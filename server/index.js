import dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

// Load .env from project root (one level up from server/)
const __dirname = dirname(fileURLToPath(import.meta.url));
dotenv.config({ path: join(__dirname, '..', '.env') });

import { getPool, closePool } from './config/database.js';
import { TenseGroupRepository } from './repositories/tenseGroupRepository.js';
import { TenseGroupController } from './controllers/tenseGroupController.js';
import { LessonRepository } from './repositories/lessonRepository.js';
import { LessonController } from './controllers/lessonController.js';
import { createApp } from './app.js';

const port = parseInt(process.env.PORT, 10) || 3001;

// --- Composition Root: wire all dependencies ---
const pool = getPool();

const tenseGroupRepo = new TenseGroupRepository(pool);
const tenseGroupController = new TenseGroupController(tenseGroupRepo);

const lessonRepo = new LessonRepository(pool);
const lessonController = new LessonController(lessonRepo);

const app = createApp({ tenseGroupController, lessonController });

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
  console.log(`Environment: ${process.env.NODE_ENV || 'development'}`);
});

// --- Graceful shutdown ---
async function shutdown() {
  console.log('\nShutting down gracefully...');
  await closePool();
  process.exit(0);
}

process.on('SIGINT', shutdown);
process.on('SIGTERM', shutdown);
