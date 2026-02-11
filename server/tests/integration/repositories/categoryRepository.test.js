import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { getTestSql, closeTestSql } from '../db.js';
import { CategoryRepository } from '../../../repositories/categoryRepository.js';

describe('CategoryRepository (integration)', () => {
  let sql;
  let repo;

  beforeAll(() => {
    sql = getTestSql();
    repo = new CategoryRepository(sql);
  });

  afterAll(async () => {
    await closeTestSql();
  });

  describe('findAllWithLessonCount', () => {
    it('returns all categories ordered by order_index', async () => {
      const categories = await repo.findAllWithLessonCount();

      expect(categories.length).toBeGreaterThanOrEqual(3);
      // Verify ordering
      for (let i = 1; i < categories.length; i++) {
        expect(categories[i].order_index).toBeGreaterThanOrEqual(
          categories[i - 1].order_index,
        );
      }
    });

    it('includes correct lesson_count per category', async () => {
      const categories = await repo.findAllWithLessonCount();

      // Each category should have a numeric lesson_count
      for (const cat of categories) {
        expect(typeof cat.lesson_count).toBe('number');
        expect(cat.lesson_count).toBeGreaterThanOrEqual(0);
      }

      // Total lessons across all categories should match seed data
      const totalLessons = categories.reduce(
        (sum, c) => sum + c.lesson_count,
        0,
      );
      expect(totalLessons).toBeGreaterThanOrEqual(12);
    });

    it('returns expected fields for each category', async () => {
      const categories = await repo.findAllWithLessonCount();
      const first = categories[0];

      expect(first).toHaveProperty('id');
      expect(first).toHaveProperty('name');
      expect(first).toHaveProperty('name_vi');
      expect(first).toHaveProperty('color');
      expect(first).toHaveProperty('icon');
      expect(first).toHaveProperty('order_index');
      expect(first).toHaveProperty('lesson_count');
    });
  });
});
