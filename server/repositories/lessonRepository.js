import { NotFoundError } from '../errors/AppError.js';

export class LessonRepository {
  constructor(sql) {
    this.sql = sql;
  }

  // F1: Search lessons by keyword (ILIKE substring + pg_trgm fuzzy matching)
  async search(keyword) {
    // Escape ILIKE metacharacters (% and _) so they match literally
    const escaped = keyword.replace(/[%_\\]/g, '\\$&');
    const pattern = `%${escaped}%`;
    const lowerKeyword = keyword.toLowerCase();
    return this.sql`
      SELECT
        l.id, l.name, l.name_vi, l.slug,
        l.short_desc, l.short_desc_vi,
        l.difficulty,
        g.name_vi   AS group_name_vi,
        g.color      AS group_color
      FROM lesson l
      JOIN category g ON l.group_id = g.id
      WHERE l.is_published = TRUE
        AND (
          l.name ILIKE ${pattern}
          OR l.name_vi ILIKE ${pattern}
          OR l.short_desc ILIKE ${pattern}
          OR l.short_desc_vi ILIKE ${pattern}
          OR word_similarity(${lowerKeyword}, lower(l.name)) > 0.3
          OR word_similarity(${lowerKeyword}, lower(l.name_vi)) > 0.3
        )
      ORDER BY
        GREATEST(
          word_similarity(${lowerKeyword}, lower(l.name)),
          word_similarity(${lowerKeyword}, lower(l.name_vi))
        ) DESC,
        g.order_index, l.order_index
      LIMIT 50
    `;
  }

  // B1: Lesson info by slug
  async findBySlug(slug) {
    const rows = await this.sql`
      SELECT
        l.*,
        g.name       AS group_name,
        g.name_vi    AS group_name_vi,
        g.color      AS group_color,
        g.icon       AS group_icon
      FROM lesson l
      JOIN category g ON l.group_id = g.id
      WHERE l.slug = ${slug} AND l.is_published = TRUE
    `;
    if (!rows.length) throw new NotFoundError('Lesson');
    return rows[0];
  }

  // A3: Lessons by group
  async findByGroup(groupId) {
    return this.sql`
      SELECT
        l.id, l.name, l.name_vi, l.slug,
        l.short_desc, l.short_desc_vi,
        l.difficulty, l.estimated_time, l.order_index
      FROM lesson l
      WHERE l.group_id = ${groupId} AND l.is_published = TRUE
      ORDER BY l.order_index
    `;
  }

  // B2: Formulas
  async findFormulas(lessonId) {
    return this.sql`
      SELECT id, type, subject_note, structure, structure_vi,
             example, example_vi, example_negative, note
      FROM formula
      WHERE lesson_id = ${lessonId}
      ORDER BY order_index
    `;
  }

  // B3a: Usages
  async findUsages(lessonId) {
    return this.sql`
      SELECT id, title, title_vi, description, description_vi, icon, is_common
      FROM lesson_usage
      WHERE lesson_id = ${lessonId}
      ORDER BY order_index
    `;
  }

  // B3b: Examples for all usages of a lesson (1 query, not N)
  async findExamples(lessonId) {
    return this.sql`
      SELECT
        e.id, e.usage_id, e.sentence, e.sentence_vi,
        e.explanation, e.explanation_vi, e.highlight_word, e.audio_url
      FROM example e
      JOIN lesson_usage u ON e.usage_id = u.id
      WHERE u.lesson_id = ${lessonId}
      ORDER BY u.order_index, e.order_index
    `;
  }

  // B4: Signal words
  async findSignalWords(lessonId) {
    return this.sql`
      SELECT id, word, word_vi, category, example_sentence,
             example_vi, position, note
      FROM signal_word
      WHERE lesson_id = ${lessonId}
      ORDER BY order_index
    `;
  }

  // B5: Tips
  async findTips(lessonId) {
    return this.sql`
      SELECT id, title, title_vi, content, content_vi,
             category, importance, icon
      FROM tip
      WHERE lesson_id = ${lessonId}
      ORDER BY order_index
    `;
  }

  // B6: Comparisons (via view)
  async findComparisons(lessonId) {
    return this.sql`
      SELECT
        compared_with_id, compared_with_name, compared_with_name_vi,
        aspect, aspect_vi,
        this_lesson_point, this_lesson_point_vi,
        other_lesson_point, other_lesson_point_vi,
        this_example, this_example_vi,
        other_example, other_example_vi,
        tip, tip_vi
      FROM v_lesson_comparisons
      WHERE lesson_id = ${lessonId}
      ORDER BY order_index
    `;
  }

  // B7a: Generic content sections (data-driven)
  async findSections(lessonId) {
    return this.sql`
      SELECT id, type, title, title_vi, content, content_vi, metadata, order_index
      FROM lesson_section
      WHERE lesson_id = ${lessonId}
      ORDER BY order_index
    `;
  }

  // B7: Full lesson assembly (BFF pattern)
  async findFullBySlug(slug) {
    const lesson = await this.findBySlug(slug);

    const [
      formulas,
      usages,
      examples,
      signalWords,
      tips,
      comparisons,
      sections,
      siblings,
    ] = await Promise.all([
      this.findFormulas(lesson.id),
      this.findUsages(lesson.id),
      this.findExamples(lesson.id),
      this.findSignalWords(lesson.id),
      this.findTips(lesson.id),
      this.findComparisons(lesson.id),
      this.findSections(lesson.id),
      this.findByGroup(lesson.group_id),
    ]);

    // Nest examples under their usages
    const usagesWithExamples = usages.map((usage) => ({
      ...usage,
      examples: examples.filter((ex) => ex.usage_id === usage.id),
    }));

    // Compute prev/next lesson navigation from siblings
    const currentIndex = siblings.findIndex((s) => s.id === lesson.id);
    const prev = currentIndex > 0 ? siblings[currentIndex - 1] : null;
    const next =
      currentIndex >= 0 && currentIndex < siblings.length - 1
        ? siblings[currentIndex + 1]
        : null;

    return {
      ...lesson,
      formulas,
      usages: usagesWithExamples,
      signalWords,
      tips,
      comparisons,
      sections,
      navigation: {
        prev: prev && { slug: prev.slug, name_vi: prev.name_vi },
        next: next && { slug: next.slug, name_vi: next.name_vi },
      },
    };
  }
}
