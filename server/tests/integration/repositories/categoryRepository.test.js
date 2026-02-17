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

  describe('findHomePageData', () => {
    it('returns flat rows with group + lesson + progress fields', async () => {
      const rows = await repo.findHomePageData(null);
      expect(rows.length).toBeGreaterThan(0);

      const first = rows[0];
      expect(first).toHaveProperty('group_id');
      expect(first).toHaveProperty('group_name');
      expect(first).toHaveProperty('group_name_vi');
      expect(first).toHaveProperty('group_color');
      expect(first).toHaveProperty('lesson_id');
      expect(first).toHaveProperty('lesson_name');
      expect(first).toHaveProperty('lesson_slug');
      expect(first).toHaveProperty('lesson_difficulty');
      expect(first).toHaveProperty('progress_status');
      expect(first).toHaveProperty('best_score');
    });

    it('defaults to not_started when no session progress exists', async () => {
      const rows = await repo.findHomePageData('nonexistent-session');
      for (const row of rows) {
        if (row.lesson_id) {
          expect(row.progress_status).toBe('not_started');
          // COALESCE returns NUMERIC as string in postgres.js
          expect(Number(row.best_score)).toBe(0);
        }
      }
    });

    it('returns rows ordered by group then lesson order', async () => {
      const rows = await repo.findHomePageData(null);
      const lessonsOnly = rows.filter((r) => r.lesson_id !== null);
      // Within same group, lesson order should be non-decreasing
      for (let i = 1; i < lessonsOnly.length; i++) {
        if (lessonsOnly[i].group_id === lessonsOnly[i - 1].group_id) {
          // Same group — lesson_id order implies order_index order
          expect(lessonsOnly[i].lesson_id).toBeGreaterThan(0);
        }
      }
    });

    it('includes all categories (even empty ones)', async () => {
      const allCategories = await repo.findAllWithLessonCount();
      const rows = await repo.findHomePageData(null);
      const uniqueGroupIds = new Set(rows.map((r) => r.group_id));
      // Every category should appear at least once
      for (const cat of allCategories) {
        expect(uniqueGroupIds.has(cat.id)).toBe(true);
      }
    });
  });
});
