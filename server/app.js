import { randomUUID } from 'node:crypto';
import Fastify from 'fastify';
import helmet from '@fastify/helmet';
import cors from '@fastify/cors';
import compress from '@fastify/compress';
import rateLimit from '@fastify/rate-limit';
import { categoryRoutes, homeRoutes } from './routes/categoryRoutes.js';
import { lessonRoutes, groupLessonRoutes } from './routes/lessonRoutes.js';
import {
  lessonExerciseRoutes,
  exerciseSubmitRoutes,
} from './routes/exerciseRoutes.js';
import { progressRoutes } from './routes/progressRoutes.js';
import { gamificationRoutes } from './routes/gamificationRoutes.js';
import { AppError } from './errors/AppError.js';

export async function createApp({
  categoryController,
  lessonController,
  exerciseController,
  progressController,
  gamificationController,
  sql,
  logger = true,
}) {
  const app = Fastify({
    logger,
    genReqId: (req) => req.headers['x-request-id'] || randomUUID(),
  });

  // --- Plugins ---
  await app.register(helmet, {
    // API-only server: strictest CSP since responses are JSON, not HTML.
    // If Fastify ever serves the SPA directly, this must be relaxed.
    contentSecurityPolicy: {
      directives: {
        defaultSrc: ["'none'"],
        frameAncestors: ["'none'"],
      },
    },
  });
  await app.register(cors, {
    origin: process.env.CORS_ORIGIN || 'http://localhost:5173',
    methods: ['GET', 'POST'],
    allowedHeaders: ['Content-Type', 'X-Session-Id', 'X-Request-Id'],
    exposedHeaders: ['X-Request-Id'],
    maxAge: 86400,
  });

  // --- Request ID propagation ---
  app.addHook('onSend', async (request, reply) => {
    reply.header('x-request-id', request.id);
  });
  await app.register(compress, { threshold: 1024 });
  await app.register(rateLimit, {
    max: 100,
    timeWindow: '1 minute',
  });

  // --- Health check (includes DB ping) ---
  app.get('/api/health', async (_request, reply) => {
    const result = { status: 'ok', timestamp: new Date().toISOString() };
    if (sql) {
      try {
        await sql`SELECT 1`;
        result.database = 'connected';
      } catch {
        result.status = 'degraded';
        result.database = 'disconnected';
        return reply.status(503).send(result);
      }
    }
    return result;
  });

  // --- API routes ---
  app.register(homeRoutes(categoryController), { prefix: '/api/home' });
  app.register(categoryRoutes(categoryController), {
    prefix: '/api/groups',
  });
  app.register(groupLessonRoutes(lessonController), { prefix: '/api/groups' });
  app.register(lessonRoutes(lessonController), { prefix: '/api/lessons' });
  app.register(lessonExerciseRoutes(exerciseController), {
    prefix: '/api/lessons',
  });
  app.register(exerciseSubmitRoutes(exerciseController), {
    prefix: '/api/exercises',
  });
  app.register(progressRoutes(progressController), { prefix: '/api/progress' });
  app.register(gamificationRoutes(gamificationController), {
    prefix: '/api/gamification',
  });

  // --- 404 handler ---
  app.setNotFoundHandler((request, reply) => {
    reply
      .status(404)
      .send({ error: `Cannot ${request.method} ${request.url}` });
  });

  // --- Error handler ---
  app.setErrorHandler((err, request, reply) => {
    if (err instanceof AppError) {
      request.log.warn(
        { err: err.message, statusCode: err.statusCode },
        'App error',
      );
      return reply.status(err.statusCode).send({ error: err.message });
    }

    // Fastify plugin errors (rate-limit 429, schema validation 400, etc.)
    if (err.statusCode && err.statusCode < 500) {
      request.log.warn(
        { err: err.message, statusCode: err.statusCode },
        'Client error',
      );
      return reply.status(err.statusCode).send({ error: err.message });
    }

    request.log.error(err, 'Unexpected error');
    reply.status(500).send({ error: 'Internal server error' });
  });

  return app;
}
