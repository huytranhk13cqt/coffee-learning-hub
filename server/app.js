import { randomUUID } from 'node:crypto';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import Fastify from 'fastify';
import helmet from '@fastify/helmet';
import cors from '@fastify/cors';
import cookie from '@fastify/cookie';
import jwt from '@fastify/jwt';
import compress from '@fastify/compress';
import rateLimit from '@fastify/rate-limit';
import fastifyStatic from '@fastify/static';
import { categoryRoutes, homeRoutes } from './routes/categoryRoutes.js';
import { lessonRoutes, groupLessonRoutes } from './routes/lessonRoutes.js';
import {
  lessonExerciseRoutes,
  exerciseSubmitRoutes,
} from './routes/exerciseRoutes.js';
import { progressRoutes } from './routes/progressRoutes.js';
import { gamificationRoutes } from './routes/gamificationRoutes.js';
import { bookmarkRoutes } from './routes/bookmarkRoutes.js';
import { reviewRoutes } from './routes/reviewRoutes.js';
import { learningPathRoutes } from './routes/learningPathRoutes.js';
import { createAdminAuth } from './middleware/adminAuth.js';
import { adminAuthRoutes } from './routes/adminAuthRoutes.js';
import { adminRoutes } from './routes/adminRoutes.js';
import { adminCrudRoutes } from './routes/adminCrudRoutes.js';
import { AppError } from './errors/AppError.js';

// __dirname equivalent for ES modules (app.js lives in server/, media/ is at project root)
const MEDIA_ROOT = path.join(
  path.dirname(fileURLToPath(import.meta.url)),
  '..',
  'media',
);

export async function createApp({
  categoryController,
  lessonController,
  exerciseController,
  progressController,
  gamificationController,
  bookmarkController,
  reviewController,
  learningPathController,
  adminController,
  adminAuthController,
  adminCrudController,
  sql,
  logger = true,
}) {
  const app = Fastify({
    logger,
    genReqId: (req) => req.headers['x-request-id'] || randomUUID(),
  });

  // --- Plugins ---
  await app.register(helmet, {
    // Serves JSON API + static media files.
    // mediaSrc 'self': allows <audio>/<video> tags to load from /media/*
    // frameSrc: allows YouTube/Vimeo embeds in VideoSection
    contentSecurityPolicy: {
      directives: {
        defaultSrc: ["'none'"],
        imgSrc: ["'self'"],
        mediaSrc: ["'self'"],
        frameSrc: [
          'https://www.youtube-nocookie.com',
          'https://player.vimeo.com',
        ],
        frameAncestors: ["'none'"],
      },
    },
  });
  await app.register(cors, {
    origin: process.env.CORS_ORIGIN || 'http://localhost:5173',
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowedHeaders: ['Content-Type', 'X-Session-Id', 'X-Request-Id'],
    exposedHeaders: ['X-Request-Id'],
    maxAge: 86400,
  });

  // --- Request ID propagation ---
  app.addHook('onSend', async (request, reply) => {
    reply.header('x-request-id', request.id);
  });
  // Serve local media files (audio/video) from project-root/media/.
  // decorateReply:false prevents conflicts with other plugins that also decorate reply.
  // The directory is git-ignored; only .gitkeep files are committed.
  await app.register(fastifyStatic, {
    root: MEDIA_ROOT,
    prefix: '/media/',
    decorateReply: false,
  });

  await app.register(compress, { threshold: 1024 });
  await app.register(rateLimit, {
    max: 100,
    timeWindow: '1 minute',
  });

  // --- Cookie + JWT for admin auth ---
  await app.register(cookie);
  await app.register(jwt, {
    secret: process.env.JWT_SECRET || 'dev-secret-change-in-production',
    cookie: {
      cookieName: 'admin_token',
      signed: false,
    },
  });

  const adminAuth = createAdminAuth(app);

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
  app.register(bookmarkRoutes(bookmarkController), {
    prefix: '/api/bookmarks',
  });
  if (reviewController) {
    app.register(reviewRoutes(reviewController), { prefix: '/api/review' });
  }
  if (learningPathController) {
    app.register(learningPathRoutes(learningPathController), {
      prefix: '/api/paths',
    });
  }

  // --- Admin routes ---
  if (adminAuthController) {
    app.register(adminAuthRoutes(adminAuthController), {
      prefix: '/api/admin',
    });
  }
  if (adminController) {
    app.register(adminRoutes(adminController, adminAuth), {
      prefix: '/api/admin',
    });
  }
  if (adminCrudController) {
    app.register(adminCrudRoutes(adminCrudController, adminAuth), {
      prefix: '/api/admin',
    });
  }

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
