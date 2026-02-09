import dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

// Load .env from project root (one level up from server/)
const __dirname = dirname(fileURLToPath(import.meta.url));
dotenv.config({ path: join(__dirname, '..', '.env') });

import { getSql, closeSql } from './config/database.js';
import { TenseGroupRepository } from './repositories/tenseGroupRepository.js';
import { TenseGroupController } from './controllers/tenseGroupController.js';
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

const tenseGroupRepo = new TenseGroupRepository(sql);
const tenseGroupController = new TenseGroupController(tenseGroupRepo);

const lessonRepo = new LessonRepository(sql);
const lessonController = new LessonController(lessonRepo);

const exerciseRepo = new ExerciseRepository(sql);
const progressRepo = new ProgressRepository(sql);
const exerciseController = new ExerciseController(exerciseRepo, progressRepo, sql);
const progressController = new ProgressController(progressRepo);

const app = await createApp({ tenseGroupController, lessonController, exerciseController, progressController });

await app.listen({ port, host: '0.0.0.0' });
console.log(`Server running at http://localhost:${port}`);
console.log(`Environment: ${process.env.NODE_ENV || 'development'}`);

// --- Graceful shutdown ---
async function shutdown() {
  console.log('\nShutting down gracefully...');
  await app.close();
  await closeSql();
  process.exit(0);
}

process.on('SIGINT', shutdown);
process.on('SIGTERM', shutdown);
