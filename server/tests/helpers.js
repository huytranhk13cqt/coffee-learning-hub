import { createApp } from '../app.js';
import { CategoryController } from '../controllers/categoryController.js';
import { LessonController } from '../controllers/lessonController.js';
import { ExerciseController } from '../controllers/exerciseController.js';
import { ProgressController } from '../controllers/progressController.js';

function createMockCategoryRepo(overrides = {}) {
  return {
    findAllWithLessonCount: async () => [],
    ...overrides,
  };
}

function createMockLessonRepo(overrides = {}) {
  return {
    search: async () => [],
    findFullBySlug: async () => null,
    findByGroup: async () => [],
    ...overrides,
  };
}

function createMockExerciseRepo(overrides = {}) {
  return {
    findByLesson: async () => [],
    findOptionsByLesson: async () => [],
    findMatchingPairsByLesson: async () => [],
    findTypeById: async () => {
      throw new Error('Not mocked');
    },
    findOptionForValidation: async () => {
      throw new Error('Not mocked');
    },
    findAnswerForValidation: async () => {
      throw new Error('Not mocked');
    },
    findMatchingPairsForValidation: async () => {
      throw new Error('Not mocked');
    },
    findResultsByLesson: async () => [],
    ...overrides,
  };
}

function createMockProgressRepo(overrides = {}) {
  return {
    findAllBySession: async () => [],
    findBySessionAndLesson: async () => null,
    markTheoryComplete: async () => {},
    getNextAttemptNumber: async () => 1,
    insertAttempt: async () => {},
    upsertProgress: async () => {},
    updateScores: async () => {},
    getDashboardOverview: async () => [],
    getSessionStats: async () => ({
      lessons_started: 0,
      lessons_completed: 0,
      total_lessons: 0,
      avg_score: 0,
      total_time_seconds: 0,
    }),
    resetProgress: async () => {},
    ...overrides,
  };
}

/**
 * Create a Fastify app with mock repositories for integration testing.
 * Override specific repo methods to control test behavior.
 */
export async function createTestApp({
  categoryRepoOverrides,
  lessonRepoOverrides,
  exerciseRepoOverrides,
  progressRepoOverrides,
} = {}) {
  const categoryRepo = createMockCategoryRepo(categoryRepoOverrides);
  const lessonRepo = createMockLessonRepo(lessonRepoOverrides);
  const exerciseRepo = createMockExerciseRepo(exerciseRepoOverrides);
  const progressRepo = createMockProgressRepo(progressRepoOverrides);
  const sql = { begin: async (fn) => fn({}) };

  const categoryController = new CategoryController(categoryRepo);
  const lessonController = new LessonController(lessonRepo);
  const exerciseController = new ExerciseController(
    exerciseRepo,
    progressRepo,
    sql,
  );
  const progressController = new ProgressController(progressRepo);

  return createApp({
    categoryController,
    lessonController,
    exerciseController,
    progressController,
    logger: false,
  });
}
