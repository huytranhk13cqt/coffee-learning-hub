import { createApp } from '../app.js';
import { CategoryController } from '../controllers/categoryController.js';
import { LessonController } from '../controllers/lessonController.js';
import { ExerciseController } from '../controllers/exerciseController.js';
import { ProgressController } from '../controllers/progressController.js';
import { GamificationController } from '../controllers/gamificationController.js';

function createMockCategoryRepo(overrides = {}) {
  return {
    findAllWithLessonCount: async () => [],
    findHomePageData: async () => [],
    ...overrides,
  };
}

function createMockLessonRepo(overrides = {}) {
  return {
    search: async () => [],
    findFullBySlug: async () => null,
    findByGroup: async () => [],
    findSections: async () => [],
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
    findExplanationById: async () => {
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

function createMockGamificationRepo(overrides = {}) {
  return {
    recordXPEvent: async () => {},
    getTotalXP: async () => 0,
    updateDailyActivity: async () => {},
    getDailyActivity: async () => ({ exercises_completed: 0, xp_earned: 0 }),
    updateStreak: async () => ({ current_streak: 0, longest_streak: 0 }),
    getStreak: async () => ({
      current_streak: 0,
      longest_streak: 0,
      last_active_date: null,
      daily_goal: 5,
    }),
    getStats: async () => ({
      total_xp: 0,
      today_xp: 0,
      today_exercises: 0,
      current_streak: 0,
      longest_streak: 0,
      daily_goal: 5,
      achievements_earned: 0,
    }),
    checkAndAwardAchievements: async () => [],
    getAllAchievements: async () => [],
    updateDailyGoal: async () => {},
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
  gamificationRepoOverrides,
} = {}) {
  const categoryRepo = createMockCategoryRepo(categoryRepoOverrides);
  const lessonRepo = createMockLessonRepo(lessonRepoOverrides);
  const exerciseRepo = createMockExerciseRepo(exerciseRepoOverrides);
  const progressRepo = createMockProgressRepo(progressRepoOverrides);
  const gamificationRepo = createMockGamificationRepo(
    gamificationRepoOverrides,
  );
  const sql = { begin: async (fn) => fn({}) };

  const categoryController = new CategoryController(categoryRepo);
  const lessonController = new LessonController(lessonRepo);
  const exerciseController = new ExerciseController(
    exerciseRepo,
    progressRepo,
    gamificationRepo,
    sql,
  );
  const progressController = new ProgressController(progressRepo);
  const gamificationController = new GamificationController(gamificationRepo);

  return createApp({
    categoryController,
    lessonController,
    exerciseController,
    progressController,
    gamificationController,
    logger: false,
  });
}
