import dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

// Load .env from project root (one level up from server/)
const __dirname = dirname(fileURLToPath(import.meta.url));
dotenv.config({ path: join(__dirname, '..', '.env') });

import { getSql, closeSql } from './config/database.js';
import { CategoryRepository } from './repositories/categoryRepository.js';
import { CategoryController } from './controllers/categoryController.js';
import { LessonRepository } from './repositories/lessonRepository.js';
import { LessonController } from './controllers/lessonController.js';
import { ExerciseRepository } from './repositories/exerciseRepository.js';
import { ProgressRepository } from './repositories/progressRepository.js';
import { ExerciseController } from './controllers/exerciseController.js';
import { ProgressController } from './controllers/progressController.js';
import { createApp } from './app.js';

const port = parseInt(process.env.PORT, 10) || 3001;

// --- Composition Root: wire all dependencies ---
const sql = getSql();

const categoryRepo = new CategoryRepository(sql);
const categoryController = new CategoryController(categoryRepo);

const lessonRepo = new LessonRepository(sql);
const lessonController = new LessonController(lessonRepo);

const exerciseRepo = new ExerciseRepository(sql);
const progressRepo = new ProgressRepository(sql);
const exerciseController = new ExerciseController(
  exerciseRepo,
  progressRepo,
  sql,
);
const progressController = new ProgressController(progressRepo);

const app = await createApp({
  categoryController,
  lessonController,
  exerciseController,
  progressController,
});

await app.listen({ port, host: '0.0.0.0' });
app.log.info(`Server running at http://localhost:${port}`);
app.log.info(`Environment: ${process.env.NODE_ENV || 'development'}`);

// --- Graceful shutdown ---
async function shutdown() {
  app.log.info('Shutting down gracefully...');
  await app.close();
  await closeSql();
  process.exit(0);
}

process.on('SIGINT', shutdown);
process.on('SIGTERM', shutdown);
