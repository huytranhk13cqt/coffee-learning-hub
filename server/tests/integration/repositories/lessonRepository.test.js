import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { getTestSql, closeTestSql } from '../db.js';
import { LessonRepository } from '../../../repositories/lessonRepository.js';
import { NotFoundError } from '../../../errors/AppError.js';

describe('LessonRepository (integration)', () => {
  let sql;
  let repo;

  beforeAll(() => {
    sql = getTestSql();
    repo = new LessonRepository(sql);
  });

  afterAll(async () => {
    await closeTestSql();
  });

  describe('search', () => {
    it('finds lessons by English name', async () => {
      const results = await repo.search('Present');
      expect(results.length).toBeGreaterThan(0);
      expect(
        results.some((r) => r.name.toLowerCase().includes('present')),
      ).toBe(true);
    });

    it('finds lessons by Vietnamese name', async () => {
      const results = await repo.search('Hiện tại');
      expect(results.length).toBeGreaterThan(0);
    });

    it('returns empty array for no match', async () => {
      const results = await repo.search('xyznonexistent999');
      expect(results).toEqual([]);
    });

    it('returns expected search result fields', async () => {
      const results = await repo.search('Simple');
      expect(results.length).toBeGreaterThan(0);
      const r = results[0];
      expect(r).toHaveProperty('id');
      expect(r).toHaveProperty('name');
      expect(r).toHaveProperty('name_vi');
      expect(r).toHaveProperty('slug');
      expect(r).toHaveProperty('difficulty');
      expect(r).toHaveProperty('group_name_vi');
      expect(r).toHaveProperty('group_color');
    });
  });

  describe('findBySlug', () => {
    it('returns lesson with group info for valid slug', async () => {
      const lesson = await repo.findBySlug('simple-present');
      expect(lesson.slug).toBe('simple-present');
      expect(lesson).toHaveProperty('group_name');
      expect(lesson).toHaveProperty('group_name_vi');
      expect(lesson).toHaveProperty('group_color');
      expect(lesson).toHaveProperty('group_icon');
    });

    it('throws NotFoundError for invalid slug', async () => {
      await expect(repo.findBySlug('nonexistent-slug')).rejects.toThrow(
        NotFoundError,
      );
    });
  });

  describe('findByGroup', () => {
    it('returns lessons ordered by order_index', async () => {
      // Group 1 = Present Tenses (should have multiple lessons)
      const lessons = await repo.findByGroup(1);
      expect(lessons.length).toBeGreaterThan(0);

      for (let i = 1; i < lessons.length; i++) {
        expect(lessons[i].order_index).toBeGreaterThanOrEqual(
          lessons[i - 1].order_index,
        );
      }
    });

    it('returns empty array for non-existent group', async () => {
      const lessons = await repo.findByGroup(999);
      expect(lessons).toEqual([]);
    });
  });

  describe('findFormulas', () => {
    it('returns formulas for a grammar lesson', async () => {
      // Lesson 1 = Simple Present (has formulas)
      const formulas = await repo.findFormulas(1);
      expect(formulas.length).toBeGreaterThan(0);
      expect(formulas[0]).toHaveProperty('type');
      expect(formulas[0]).toHaveProperty('structure');
    });

    it('returns empty array for lesson without formulas', async () => {
      // Non-grammar lessons may not have formulas
      const formulas = await repo.findFormulas(999);
      expect(formulas).toEqual([]);
    });
  });

  describe('findUsages', () => {
    it('returns usages for a lesson', async () => {
      const usages = await repo.findUsages(1);
      expect(usages.length).toBeGreaterThan(0);
      expect(usages[0]).toHaveProperty('title');
      expect(usages[0]).toHaveProperty('title_vi');
    });
  });

  describe('findExamples', () => {
    it('returns examples with usage_id for nesting', async () => {
      const examples = await repo.findExamples(1);
      expect(examples.length).toBeGreaterThan(0);
      expect(examples[0]).toHaveProperty('usage_id');
      expect(examples[0]).toHaveProperty('sentence');
      expect(examples[0]).toHaveProperty('sentence_vi');
    });
  });

  describe('findSignalWords', () => {
    it('returns signal words for a grammar lesson', async () => {
      const words = await repo.findSignalWords(1);
      expect(words.length).toBeGreaterThan(0);
      expect(words[0]).toHaveProperty('word');
    });
  });

  describe('findTips', () => {
    it('returns tips for a lesson', async () => {
      const tips = await repo.findTips(1);
      expect(tips.length).toBeGreaterThan(0);
      expect(tips[0]).toHaveProperty('title');
      expect(tips[0]).toHaveProperty('content');
    });
  });

  describe('findComparisons', () => {
    it('returns comparisons from view', async () => {
      const comparisons = await repo.findComparisons(1);
      // Simple Present should have comparisons with Present Continuous
      expect(comparisons.length).toBeGreaterThan(0);
      expect(comparisons[0]).toHaveProperty('compared_with_name');
      expect(comparisons[0]).toHaveProperty('aspect');
    });
  });

  describe('findFullBySlug (BFF)', () => {
    it('assembles complete lesson with all sections', async () => {
      const full = await repo.findFullBySlug('simple-present');

      expect(full.slug).toBe('simple-present');
      expect(full).toHaveProperty('formulas');
      expect(full).toHaveProperty('usages');
      expect(full).toHaveProperty('signalWords');
      expect(full).toHaveProperty('tips');
      expect(full).toHaveProperty('comparisons');
      expect(full).toHaveProperty('navigation');
    });

    it('nests examples under their usages', async () => {
      const full = await repo.findFullBySlug('simple-present');

      expect(full.usages.length).toBeGreaterThan(0);
      // Each usage should have an examples array
      for (const usage of full.usages) {
        expect(Array.isArray(usage.examples)).toBe(true);
      }
    });

    it('computes prev/next navigation from siblings', async () => {
      const full = await repo.findFullBySlug('simple-present');

      // Simple Present is first in its group, so no prev
      expect(full.navigation.prev).toBeNull();
      // Should have a next lesson
      expect(full.navigation.next).not.toBeNull();
      expect(full.navigation.next).toHaveProperty('slug');
      expect(full.navigation.next).toHaveProperty('name_vi');
    });
  });
});
