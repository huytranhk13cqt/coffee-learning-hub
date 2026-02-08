import { NotFoundError } from '../errors/AppError.js';

export class LessonRepository {
  constructor(pool) {
    this.pool = pool;
  }

  // B1: Lesson info by slug
  async findBySlug(slug) {
    const [rows] = await this.pool.query(
      `SELECT
        l.*,
        g.name       AS group_name,
        g.name_vi    AS group_name_vi,
        g.color      AS group_color,
        g.icon       AS group_icon
      FROM lesson l
      JOIN tense_group g ON l.group_id = g.id
      WHERE l.slug = ? AND l.is_published = TRUE`,
      [slug],
    );
    if (!rows.length) throw new NotFoundError('Lesson');
    return rows[0];
  }

  // A3: Lessons by group
  async findByGroup(groupId) {
    const [rows] = await this.pool.query(
      `SELECT
        l.id, l.name, l.name_vi, l.slug,
        l.short_desc, l.short_desc_vi,
        l.difficulty, l.estimated_time, l.order_index
      FROM lesson l
      WHERE l.group_id = ? AND l.is_published = TRUE
      ORDER BY l.order_index`,
      [groupId],
    );
    return rows;
  }

  // B2: Formulas
  async findFormulas(lessonId) {
    const [rows] = await this.pool.query(
      `SELECT id, type, subject_note, structure, structure_vi,
              example, example_vi, example_negative, note
      FROM formula
      WHERE lesson_id = ?
      ORDER BY order_index`,
      [lessonId],
    );
    return rows;
  }

  // B3a: Usages
  async findUsages(lessonId) {
    const [rows] = await this.pool.query(
      `SELECT id, title, title_vi, description, description_vi, icon, is_common
      FROM lesson_usage
      WHERE lesson_id = ?
      ORDER BY order_index`,
      [lessonId],
    );
    return rows;
  }

  // B3b: Examples for all usages of a lesson (1 query, not N)
  async findExamples(lessonId) {
    const [rows] = await this.pool.query(
      `SELECT
        e.id, e.usage_id, e.sentence, e.sentence_vi,
        e.explanation, e.explanation_vi, e.highlight_word, e.audio_url
      FROM example e
      JOIN lesson_usage u ON e.usage_id = u.id
      WHERE u.lesson_id = ?
      ORDER BY u.order_index, e.order_index`,
      [lessonId],
    );
    return rows;
  }

  // B4: Signal words
  async findSignalWords(lessonId) {
    const [rows] = await this.pool.query(
      `SELECT id, word, word_vi, category, example_sentence,
              example_vi, position, note
      FROM signal_word
      WHERE lesson_id = ?
      ORDER BY order_index`,
      [lessonId],
    );
    return rows;
  }

  // B5: Tips
  async findTips(lessonId) {
    const [rows] = await this.pool.query(
      `SELECT id, title, title_vi, content, content_vi,
              category, importance, icon
      FROM tip
      WHERE lesson_id = ?
      ORDER BY order_index`,
      [lessonId],
    );
    return rows;
  }

  // B6: Comparisons (via view)
  async findComparisons(lessonId) {
    const [rows] = await this.pool.query(
      `SELECT
        compared_with_id, compared_with_name, compared_with_name_vi,
        aspect, aspect_vi,
        this_lesson_point, this_lesson_point_vi,
        other_lesson_point, other_lesson_point_vi,
        this_example, this_example_vi,
        other_example, other_example_vi,
        tip, tip_vi
      FROM v_lesson_comparisons
      WHERE lesson_id = ?
      ORDER BY order_index`,
      [lessonId],
    );
    return rows;
  }

  // B7: Full lesson assembly (BFF pattern)
  async findFullBySlug(slug) {
    const lesson = await this.findBySlug(slug);

    const [formulas, usages, examples, signalWords, tips, comparisons] =
      await Promise.all([
        this.findFormulas(lesson.id),
        this.findUsages(lesson.id),
        this.findExamples(lesson.id),
        this.findSignalWords(lesson.id),
        this.findTips(lesson.id),
        this.findComparisons(lesson.id),
      ]);

    // Nest examples under their usages
    const usagesWithExamples = usages.map((usage) => ({
      ...usage,
      examples: examples.filter((ex) => ex.usage_id === usage.id),
    }));

    return {
      ...lesson,
      formulas,
      usages: usagesWithExamples,
      signalWords,
      tips,
      comparisons,
    };
  }
}
