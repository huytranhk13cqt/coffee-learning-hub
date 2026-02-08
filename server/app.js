import Fastify from 'fastify';
import cors from '@fastify/cors';
import { tenseGroupRoutes } from './routes/tenseGroupRoutes.js';
import { lessonRoutes, groupLessonRoutes } from './routes/lessonRoutes.js';
import { AppError } from './errors/AppError.js';

export async function createApp({ tenseGroupController, lessonController }) {
  const app = Fastify({ logger: false });

  // --- Plugins ---
  await app.register(cors, {
    origin: process.env.CORS_ORIGIN || 'http://localhost:5173',
  });

  // --- Health check ---
  app.get('/api/health', async () => {
    return { status: 'ok', timestamp: new Date().toISOString() };
  });

  // --- API routes ---
  app.register(tenseGroupRoutes(tenseGroupController), { prefix: '/api/groups' });
  app.register(groupLessonRoutes(lessonController), { prefix: '/api/groups' });
  app.register(lessonRoutes(lessonController), { prefix: '/api/lessons' });

  // --- 404 handler ---
  app.setNotFoundHandler((request, reply) => {
    reply.status(404).send({ error: `Cannot ${request.method} ${request.url}` });
  });

  // --- Error handler ---
  app.setErrorHandler((err, request, reply) => {
    if (err instanceof AppError) {
      return reply.status(err.statusCode).send({ error: err.message });
    }

    console.error('Unexpected error:', err);
    reply.status(500).send({ error: 'Internal server error' });
  });

  return app;
}
