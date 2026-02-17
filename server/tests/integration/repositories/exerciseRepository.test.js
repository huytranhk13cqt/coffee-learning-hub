import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { getTestSql, closeTestSql } from '../db.js';
import { ExerciseRepository } from '../../../repositories/exerciseRepository.js';
import { NotFoundError } from '../../../errors/AppError.js';

describe('ExerciseRepository (integration)', () => {
  let sql;
  let repo;

  beforeAll(() => {
    sql = getTestSql();
    repo = new ExerciseRepository(sql);
  });

  afterAll(async () => {
    await closeTestSql();
  });

  describe('findByLesson (security boundary)', () => {
    it('returns exercises for a lesson', async () => {
      const exercises = await repo.findByLesson(1);
      expect(exercises.length).toBeGreaterThan(0);
    });

    it('NEVER returns correct_answer field', async () => {
      const exercises = await repo.findByLesson(1);
      for (const ex of exercises) {
        expect(ex).not.toHaveProperty('correct_answer');
      }
    });

    it('NEVER returns explanation field', async () => {
      const exercises = await repo.findByLesson(1);
      for (const ex of exercises) {
        expect(ex).not.toHaveProperty('explanation');
        expect(ex).not.toHaveProperty('explanation_vi');
      }
    });

    it('returns expected fields', async () => {
      const exercises = await repo.findByLesson(1);
      const ex = exercises[0];
      expect(ex).toHaveProperty('id');
      expect(ex).toHaveProperty('type');
      expect(ex).toHaveProperty('difficulty');
      expect(ex).toHaveProperty('question');
      expect(ex).toHaveProperty('points');
    });

    it('returns empty for non-existent lesson', async () => {
      const exercises = await repo.findByLesson(999);
      expect(exercises).toEqual([]);
    });
  });

  describe('findOptionsByLesson (security boundary)', () => {
    it('returns options WITHOUT is_correct', async () => {
      const options = await repo.findOptionsByLesson(1);
      for (const opt of options) {
        expect(opt).not.toHaveProperty('is_correct');
        expect(opt).not.toHaveProperty('explanation');
      }
    });

    it('returns expected option fields', async () => {
      const options = await repo.findOptionsByLesson(1);
      if (options.length > 0) {
        expect(options[0]).toHaveProperty('id');
        expect(options[0]).toHaveProperty('exercise_id');
        expect(options[0]).toHaveProperty('label');
        expect(options[0]).toHaveProperty('content');
      }
    });
  });

  describe('findMatchingPairsByLesson', () => {
    it('returns matching pairs for lessons with matching exercises', async () => {
      // Find a lesson that has matching exercises
      const allExercises = await repo.findByLesson(1);
      const hasMatching = allExercises.some((e) => e.type === 'matching');

      const pairs = await repo.findMatchingPairsByLesson(1);
      if (hasMatching) {
        expect(pairs.length).toBeGreaterThan(0);
        expect(pairs[0]).toHaveProperty('left_content');
        expect(pairs[0]).toHaveProperty('right_content');
      } else {
        expect(pairs).toEqual([]);
      }
    });
  });

  describe('findOptionForValidation', () => {
    it('returns option with is_correct for validation', async () => {
      // Find a MC exercise from seed data
      const exercises = await repo.findByLesson(1);
      const mcExercise = exercises.find((e) => e.type === 'multiple_choice');
      if (!mcExercise) return; // skip if no MC exercises

      const option = await repo.findOptionForValidation(mcExercise.id, 'A');
      expect(option).toHaveProperty('is_correct');
      expect(option).toHaveProperty('label');
      expect(option.label).toBe('A');
    });

    it('throws NotFoundError for valid label with no matching option', async () => {
      const exercises = await repo.findByLesson(1);
      const mcExercise = exercises.find((e) => e.type === 'multiple_choice');
      if (!mcExercise) return;

      // 'F' is a valid ENUM value but unlikely to exist for this exercise
      await expect(
        repo.findOptionForValidation(mcExercise.id, 'F'),
      ).rejects.toThrow(NotFoundError);
    });

    it('throws PostgresError for invalid ENUM label', async () => {
      const exercises = await repo.findByLesson(1);
      const mcExercise = exercises.find((e) => e.type === 'multiple_choice');
      if (!mcExercise) return;

      // 'Z' is not a valid option_label ENUM value — DB rejects it
      await expect(
        repo.findOptionForValidation(mcExercise.id, 'Z'),
      ).rejects.toThrow(/invalid input value/);
    });
  });

  describe('findAnswerForValidation', () => {
    it('returns correct_answer for text-based exercises', async () => {
      const exercises = await repo.findByLesson(1);
      const textExercise = exercises.find((e) => e.type === 'fill_blank');
      if (!textExercise) return;

      const answer = await repo.findAnswerForValidation(textExercise.id);
      expect(answer).toHaveProperty('correct_answer');
      expect(answer.correct_answer).toBeTruthy();
      expect(answer).toHaveProperty('explanation');
    });

    it('throws NotFoundError for non-existent exercise', async () => {
      await expect(repo.findAnswerForValidation(99999)).rejects.toThrow(
        NotFoundError,
      );
    });
  });

  describe('findMatchingPairsForValidation', () => {
    it('returns pairs with correct pairing data', async () => {
      const exercises = await repo.findByLesson(1);
      const matchingExercise = exercises.find((e) => e.type === 'matching');
      if (!matchingExercise) return;

      const pairs = await repo.findMatchingPairsForValidation(
        matchingExercise.id,
      );
      expect(pairs.length).toBeGreaterThan(0);
      expect(pairs[0]).toHaveProperty('id');
      expect(pairs[0]).toHaveProperty('left_content');
      expect(pairs[0]).toHaveProperty('right_content');
    });
  });

  describe('findExplanationById', () => {
    it('returns explanation for matching exercise', async () => {
      const exercises = await repo.findByLesson(1);
      const matchingExercise = exercises.find((e) => e.type === 'matching');
      if (!matchingExercise) return;

      const result = await repo.findExplanationById(matchingExercise.id);
      expect(result).toHaveProperty('explanation');
      expect(result).toHaveProperty('explanation_vi');
      expect(result.explanation).toBeTruthy();
    });

    it('throws NotFoundError for non-existent exercise', async () => {
      await expect(repo.findExplanationById(99999)).rejects.toThrow(
        NotFoundError,
      );
    });
  });

  describe('matching exercise full validation flow', () => {
    it('provides complete data for answer validation pipeline', async () => {
      // 1. Find a matching exercise via findByLesson
      const exercises = await repo.findByLesson(1);
      const matchingExercise = exercises.find((e) => e.type === 'matching');
      if (!matchingExercise) return;

      // 2. Verify findTypeById returns correct type
      const typeInfo = await repo.findTypeById(matchingExercise.id);
      expect(typeInfo.type).toBe('matching');
      expect(typeInfo.lesson_id).toBe(1);

      // 3. Get validation data (pairs + explanation) — same as controller does
      const [pairs, explanationData] = await Promise.all([
        repo.findMatchingPairsForValidation(matchingExercise.id),
        repo.findExplanationById(matchingExercise.id),
      ]);

      // 4. Verify pairs have the data needed for validation
      expect(pairs.length).toBeGreaterThan(0);
      for (const pair of pairs) {
        expect(pair.id).toBeDefined();
        expect(pair.left_content).toBeTruthy();
        expect(pair.right_content).toBeTruthy();
      }

      // 5. Verify explanation is available for feedback
      expect(explanationData.explanation).toBeTruthy();
    });
  });

  describe('findTypeById', () => {
    it('returns exercise type and lesson_id', async () => {
      const exercises = await repo.findByLesson(1);
      const first = exercises[0];

      const result = await repo.findTypeById(first.id);
      expect(result.id).toBe(first.id);
      expect(result.type).toBe(first.type);
      expect(result).toHaveProperty('lesson_id');
    });

    it('throws NotFoundError for non-existent exercise', async () => {
      await expect(repo.findTypeById(99999)).rejects.toThrow(NotFoundError);
    });
  });

  describe('findResultsByLesson (INNER JOIN security)', () => {
    it('returns empty when no attempts exist for session', async () => {
      const results = await repo.findResultsByLesson(1, 'brand-new-session');
      expect(results).toEqual([]);
    });

    it('only returns exercises with actual attempts (INNER JOIN)', async () => {
      // Insert a single attempt for one exercise
      const sessionId = 'results-test-session';
      const exercises = await repo.findByLesson(1);
      const firstExercise = exercises[0];

      await sql`
        INSERT INTO user_progress (session_id, lesson_id, status, exercises_attempted)
        VALUES (${sessionId}, 1, 'in_progress', 1)
        ON CONFLICT DO NOTHING
      `;
      await sql`
        INSERT INTO exercise_attempt
          (session_id, exercise_id, user_answer, is_correct, attempt_number)
        VALUES
          (${sessionId}, ${firstExercise.id}, 'test-answer', false, 1)
        ON CONFLICT DO NOTHING
      `;

      const results = await repo.findResultsByLesson(1, sessionId);
      // Should only return the ONE attempted exercise, not all
      expect(results.length).toBe(1);
      expect(results[0].exercise_id).toBe(firstExercise.id);
      // Results endpoint CAN include correct_answer (for review)
      expect(results[0]).toHaveProperty('correct_answer');
      expect(results[0]).toHaveProperty('user_answer');
      expect(results[0]).toHaveProperty('is_correct');

      // Cleanup
      await sql`
        DELETE FROM exercise_attempt
        WHERE session_id = ${sessionId}
      `;
      await sql`
        DELETE FROM user_progress
        WHERE session_id = ${sessionId}
      `;
    });
  });
});
