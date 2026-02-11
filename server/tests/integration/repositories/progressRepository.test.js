import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { getTestSql, closeTestSql } from '../db.js';
import { ProgressRepository } from '../../../repositories/progressRepository.js';

describe('ProgressRepository (integration)', () => {
  let sql;
  let repo;
  // Use unique session IDs per test group to avoid cross-contamination
  const SESSION_PREFIX = 'test-progress-';
  let sessionCounter = 0;

  function uniqueSession() {
    sessionCounter++;
    return `${SESSION_PREFIX}${sessionCounter}-${Date.now()}`;
  }

  beforeAll(() => {
    sql = getTestSql();
    repo = new ProgressRepository(sql);
  });

  afterAll(async () => {
    // Clean up all test sessions
    await sql`
      DELETE FROM exercise_attempt
      WHERE session_id LIKE ${SESSION_PREFIX + '%'}
    `;
    await sql`
      DELETE FROM user_progress
      WHERE session_id LIKE ${SESSION_PREFIX + '%'}
    `;
    await closeTestSql();
  });

  describe('findAllBySession', () => {
    it('returns empty array for new session', async () => {
      const progress = await repo.findAllBySession(uniqueSession());
      expect(progress).toEqual([]);
    });
  });

  describe('markTheoryComplete', () => {
    it('inserts new progress record', async () => {
      const sid = uniqueSession();
      await repo.markTheoryComplete(sid, 1, 30);

      const result = await repo.findBySessionAndLesson(sid, 1);
      expect(result).not.toBeNull();
      expect(result.theory_completed).toBe(true);
      expect(result.theory_time_spent).toBe(30);
    });

    it('accumulates time on subsequent calls (upsert)', async () => {
      const sid = uniqueSession();
      await repo.markTheoryComplete(sid, 1, 20);
      await repo.markTheoryComplete(sid, 1, 15);

      const result = await repo.findBySessionAndLesson(sid, 1);
      expect(result.theory_completed).toBe(true);
      expect(result.theory_time_spent).toBe(35);
    });
  });

  describe('findBySessionAndLesson', () => {
    it('returns null for non-existent progress', async () => {
      const result = await repo.findBySessionAndLesson(uniqueSession(), 1);
      expect(result).toBeNull();
    });

    it('includes dynamic exercises_total count', async () => {
      const sid = uniqueSession();
      await repo.markTheoryComplete(sid, 1, 0);

      const result = await repo.findBySessionAndLesson(sid, 1);
      // exercises_total is computed via subquery, not cached
      expect(typeof result.exercises_total).toBe('number');
      expect(result.exercises_total).toBeGreaterThan(0);
    });
  });

  describe('transaction methods (attempt flow)', () => {
    it('getNextAttemptNumber returns 1 for first attempt', async () => {
      const sid = uniqueSession();
      const exerciseId = 1;

      const next = await sql.begin(async (tx) => {
        return repo.getNextAttemptNumber(tx, sid, exerciseId);
      });
      expect(next).toBe(1);
    });

    it('insertAttempt + getNextAttemptNumber increment correctly', async () => {
      const sid = uniqueSession();
      const exerciseId = 1;

      // First attempt
      await sql.begin(async (tx) => {
        const num = await repo.getNextAttemptNumber(tx, sid, exerciseId);
        expect(num).toBe(1);
        await repo.insertAttempt(tx, {
          sessionId: sid,
          exerciseId,
          userAnswer: 'test',
          isCorrect: false,
          timeTaken: 5,
          attemptNumber: num,
        });
      });

      // Second attempt
      await sql.begin(async (tx) => {
        const num = await repo.getNextAttemptNumber(tx, sid, exerciseId);
        expect(num).toBe(2);
        await repo.insertAttempt(tx, {
          sessionId: sid,
          exerciseId,
          userAnswer: 'test2',
          isCorrect: true,
          timeTaken: 3,
          attemptNumber: num,
        });
      });

      // Third should be 3
      const thirdNum = await sql.begin(async (tx) => {
        return repo.getNextAttemptNumber(tx, sid, exerciseId);
      });
      expect(thirdNum).toBe(3);
    });
  });

  describe('upsertProgress', () => {
    it('creates progress for first exercise submission', async () => {
      const sid = uniqueSession();

      await sql.begin(async (tx) => {
        await repo.upsertProgress(tx, {
          sessionId: sid,
          lessonId: 1,
          isCorrect: true,
          timeTaken: 10,
        });
      });

      const result = await repo.findBySessionAndLesson(sid, 1);
      expect(result.status).toBe('in_progress');
      expect(result.exercises_attempted).toBe(1);
      expect(result.exercises_correct).toBe(1);
    });

    it('increments counters on subsequent submissions', async () => {
      const sid = uniqueSession();

      // First: correct
      await sql.begin(async (tx) => {
        await repo.upsertProgress(tx, {
          sessionId: sid,
          lessonId: 1,
          isCorrect: true,
          timeTaken: 10,
        });
      });

      // Second: incorrect
      await sql.begin(async (tx) => {
        await repo.upsertProgress(tx, {
          sessionId: sid,
          lessonId: 1,
          isCorrect: false,
          timeTaken: 8,
        });
      });

      const result = await repo.findBySessionAndLesson(sid, 1);
      expect(result.exercises_attempted).toBe(2);
      expect(result.exercises_correct).toBe(1);
    });
  });

  describe('updateScores', () => {
    it('computes correct score percentage', async () => {
      const sid = uniqueSession();

      // Create progress: 3 attempted, 2 correct
      await sql.begin(async (tx) => {
        await repo.upsertProgress(tx, {
          sessionId: sid,
          lessonId: 1,
          isCorrect: true,
          timeTaken: 5,
        });
      });
      await sql.begin(async (tx) => {
        await repo.upsertProgress(tx, {
          sessionId: sid,
          lessonId: 1,
          isCorrect: true,
          timeTaken: 5,
        });
      });
      await sql.begin(async (tx) => {
        await repo.upsertProgress(tx, {
          sessionId: sid,
          lessonId: 1,
          isCorrect: false,
          timeTaken: 5,
        });
      });

      // Update scores
      await sql.begin(async (tx) => {
        await repo.updateScores(tx, sid, 1);
      });

      const result = await repo.findBySessionAndLesson(sid, 1);
      // 2/3 correct = 66.67%
      expect(Number(result.current_score)).toBeCloseTo(66.67, 1);
      expect(Number(result.best_score)).toBeCloseTo(66.67, 1);
    });
  });

  describe('getDashboardOverview', () => {
    it('returns all published lessons with progress overlay', async () => {
      const sid = uniqueSession();
      const overview = await repo.getDashboardOverview(sid);

      expect(overview.length).toBeGreaterThanOrEqual(12);
      const first = overview[0];
      expect(first).toHaveProperty('group_id');
      expect(first).toHaveProperty('lesson_id');
      expect(first).toHaveProperty('status');
      expect(first).toHaveProperty('exercises_total');
      // New session should show not_started
      expect(first.status).toBe('not_started');
    });
  });

  describe('getSessionStats', () => {
    it('returns zero stats for new session', async () => {
      const stats = await repo.getSessionStats(uniqueSession());
      expect(stats.lessons_started).toBe(0);
      expect(stats.lessons_completed).toBe(0);
      expect(stats.total_lessons).toBeGreaterThanOrEqual(12);
    });

    it('counts started lessons correctly', async () => {
      const sid = uniqueSession();
      await repo.markTheoryComplete(sid, 1, 0);
      await repo.markTheoryComplete(sid, 2, 0);

      const stats = await repo.getSessionStats(sid);
      expect(stats.lessons_started).toBe(2);
    });
  });

  describe('resetProgress', () => {
    it('clears attempts and resets progress fields', async () => {
      const sid = uniqueSession();
      const exerciseId = 1;

      // Setup: mark theory + add attempt + progress
      await repo.markTheoryComplete(sid, 1, 20);
      await sql.begin(async (tx) => {
        const num = await repo.getNextAttemptNumber(tx, sid, exerciseId);
        await repo.insertAttempt(tx, {
          sessionId: sid,
          exerciseId,
          userAnswer: 'test',
          isCorrect: true,
          timeTaken: 5,
          attemptNumber: num,
        });
        await repo.upsertProgress(tx, {
          sessionId: sid,
          lessonId: 1,
          isCorrect: true,
          timeTaken: 5,
        });
      });

      // Verify data exists
      const before = await repo.findBySessionAndLesson(sid, 1);
      expect(before.theory_completed).toBe(true);
      expect(before.exercises_attempted).toBeGreaterThan(0);

      // Reset
      await repo.resetProgress(sid, 1);

      // Verify reset
      const after = await repo.findBySessionAndLesson(sid, 1);
      expect(after.theory_completed).toBe(false);
      expect(after.exercises_attempted).toBe(0);
      expect(after.exercises_correct).toBe(0);
      expect(Number(after.current_score)).toBe(0);
      expect(after.status).toBe('not_started');
    });
  });
});
