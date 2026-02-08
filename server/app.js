import express from 'express';
import cors from 'cors';
import { createTenseGroupRoutes } from './routes/tenseGroupRoutes.js';
import { createLessonRoutes, createGroupLessonRoutes } from './routes/lessonRoutes.js';
import { errorHandler } from './middleware/errorHandler.js';

export function createApp({ tenseGroupController, lessonController }) {
  const app = express();

  // --- Middleware ---
  app.use(cors({ origin: process.env.CORS_ORIGIN || 'http://localhost:5173' }));
  app.use(express.json());

  // --- Health check ---
  app.get('/api/health', (req, res) => {
    res.json({ status: 'ok', timestamp: new Date().toISOString() });
  });

  // --- API routes ---
  app.use('/api/groups', createTenseGroupRoutes(tenseGroupController));
  app.use('/api/groups', createGroupLessonRoutes(lessonController));
  app.use('/api/lessons', createLessonRoutes(lessonController));

  // --- 404 handler ---
  app.use((req, res) => {
    res.status(404).json({ error: `Cannot ${req.method} ${req.path}` });
  });

  // --- Error handler (must be registered last) ---
  app.use(errorHandler);

  return app;
}
