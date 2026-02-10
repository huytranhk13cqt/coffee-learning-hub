import Fastify from 'fastify';
import helmet from '@fastify/helmet';
import cors from '@fastify/cors';
import rateLimit from '@fastify/rate-limit';
import { categoryRoutes } from './routes/categoryRoutes.js';
import { lessonRoutes, groupLessonRoutes } from './routes/lessonRoutes.js';
import {
  lessonExerciseRoutes,
  exerciseSubmitRoutes,
} from './routes/exerciseRoutes.js';
import { progressRoutes } from './routes/progressRoutes.js';
import { AppError } from './errors/AppError.js';

export async function createApp({
  categoryController,
  lessonController,
  exerciseController,
  progressController,
}) {
  const app = Fastify({ logger: true });

  // --- Plugins ---
  await app.register(helmet, {
    contentSecurityPolicy: false,
  });
  await app.register(cors, {
    origin: process.env.CORS_ORIGIN || 'http://localhost:5173',
  });
  await app.register(rateLimit, {
    max: 100,
    timeWindow: '1 minute',
  });

  // --- Health check ---
  app.get('/api/health', async () => {
    return { status: 'ok', timestamp: new Date().toISOString() };
  });

  // --- API routes ---
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

  // --- 404 handler ---
  app.setNotFoundHandler((request, reply) => {
    reply
      .status(404)
      .send({ error: `Cannot ${request.method} ${request.url}` });
  });

  // --- Error handler ---
  app.setErrorHandler((err, request, reply) => {
    if (err instanceof AppError) {
      return reply.status(err.statusCode).send({ error: err.message });
    }

    // Fastify plugin errors (rate-limit 429, schema validation 400, etc.)
    if (err.statusCode && err.statusCode < 500) {
      return reply.status(err.statusCode).send({ error: err.message });
    }

    request.log.error(err, 'Unexpected error');
    reply.status(500).send({ error: 'Internal server error' });
  });

  return app;
}
