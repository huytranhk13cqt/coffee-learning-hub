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
import { GamificationRepository } from './repositories/gamificationRepository.js';
import { ExerciseController } from './controllers/exerciseController.js';
import { ProgressController } from './controllers/progressController.js';
import { GamificationController } from './controllers/gamificationController.js';
import { bookmarkRepository } from './repositories/bookmarkRepository.js';
import { bookmarkController as BookmarkController } from './controllers/bookmarkController.js';
import { ReviewRepository } from './repositories/reviewRepository.js';
import { ReviewController } from './controllers/reviewController.js';
import { LearningPathRepository } from './repositories/learningPathRepository.js';
import { LearningPathController } from './controllers/learningPathController.js';
import { AdminRepository } from './repositories/adminRepository.js';
import { AdminController } from './controllers/adminController.js';
import { AdminAuthController } from './controllers/adminAuthController.js';
import { AdminCrudRepository } from './repositories/adminCrudRepository.js';
import { AdminCrudController } from './controllers/adminCrudController.js';
import { AdminExerciseRepository } from './repositories/adminExerciseRepository.js';
import { AdminExerciseController } from './controllers/adminExerciseController.js';
import { AdminLearningPathRepository } from './repositories/adminLearningPathRepository.js';
import { AdminLearningPathController } from './controllers/adminLearningPathController.js';
import { ClaudeService } from './services/claudeService.js';
import { ClaudeController } from './controllers/claudeController.js';
import { GeminiService } from './services/geminiService.js';
import { AssetRepository } from './repositories/assetRepository.js';
import { AssetController } from './controllers/assetController.js';
import { YamlImportController } from './controllers/yamlImportController.js';
import { createApp } from './app.js';

// --- Startup env validation (fail-fast) ---
const requiredEnv = ['DB_HOST', 'DB_USER', 'DB_NAME'];
for (const key of requiredEnv) {
  if (!process.env[key]) {
    console.error(`Missing required environment variable: ${key}`);
    process.exit(1);
  }
}

const port = parseInt(process.env.PORT, 10) || 3001;

// --- Composition Root: wire all dependencies ---
const sql = getSql();

// --- DB connectivity check (fail-fast) ---
try {
  await sql`SELECT 1`;
} catch (err) {
  console.error('Failed to connect to database:', err.message);
  await closeSql();
  process.exit(1);
}

const categoryRepo = new CategoryRepository(sql);
const categoryController = new CategoryController(categoryRepo);

const lessonRepo = new LessonRepository(sql);
const lessonController = new LessonController(lessonRepo);

const exerciseRepo = new ExerciseRepository(sql);
const progressRepo = new ProgressRepository(sql);
const gamificationRepo = new GamificationRepository(sql);

const reviewRepo = new ReviewRepository(sql);
const reviewController = new ReviewController(
  reviewRepo,
  exerciseRepo,
  gamificationRepo,
  sql,
);

const learningPathRepo = new LearningPathRepository(sql);
const learningPathController = new LearningPathController(learningPathRepo);

const exerciseController = new ExerciseController(
  exerciseRepo,
  progressRepo,
  gamificationRepo,
  sql,
  reviewRepo, // enables auto-enroll on lesson completion
);
const progressController = new ProgressController(progressRepo);
const gamificationController = new GamificationController(gamificationRepo);
const bookmarkRepo = bookmarkRepository(sql);
const bookmarkControllerInstance = BookmarkController(bookmarkRepo);

const adminRepo = new AdminRepository(sql);
const adminController = new AdminController(adminRepo);
const claudeService = new ClaudeService();
const adminAuthController = new AdminAuthController(
  process.env.ADMIN_PASSWORD,
  adminRepo,
  claudeService,
);
const adminCrudRepo = new AdminCrudRepository(sql);
const adminCrudController = new AdminCrudController(adminCrudRepo, adminRepo);
const adminExerciseRepo = new AdminExerciseRepository(sql);
const adminExerciseController = new AdminExerciseController(
  adminExerciseRepo,
  adminRepo,
);
const adminLearningPathRepo = new AdminLearningPathRepository(sql);
const adminLearningPathController = new AdminLearningPathController(
  adminLearningPathRepo,
  adminRepo,
);
const claudeController = new ClaudeController(claudeService, adminRepo);
const geminiService = new GeminiService();
const assetRepo = new AssetRepository(sql);
const assetController = new AssetController(
  assetRepo,
  geminiService,
  adminRepo,
);
const yamlImportController = new YamlImportController(sql, adminRepo);

const app = await createApp({
  categoryController,
  lessonController,
  exerciseController,
  progressController,
  gamificationController,
  bookmarkController: bookmarkControllerInstance,
  reviewController,
  learningPathController,
  adminController,
  adminAuthController,
  adminCrudController,
  adminExerciseController,
  adminLearningPathController,
  claudeController,
  assetController,
  yamlImportController,
  sql,
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
