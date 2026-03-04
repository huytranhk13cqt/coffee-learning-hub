import { NotFoundError } from '../errors/AppError.js';

export class AdminCrudRepository {
  constructor(sql) {
    this.sql = sql;
  }

  // ─── TOPICS ──────────────────────────────────────────────

  /** All topics with category count, ordered by order_index */
  async findAllTopics() {
    return this.sql`
      SELECT
        t.*,
        COALESCE(cc.cnt, 0)::int AS category_count
      FROM topic t
      LEFT JOIN (
        SELECT topic_id, COUNT(*)::int AS cnt
        FROM category
        WHERE topic_id IS NOT NULL
        GROUP BY topic_id
      ) cc ON cc.topic_id = t.id
      ORDER BY t.order_index, t.id
    `;
  }

  async findTopicById(id) {
    const [row] = await this.sql`SELECT * FROM topic WHERE id = ${id}`;
    if (!row) throw new NotFoundError('Topic');
    return row;
  }

  async createTopic(data) {
    // Auto-assign order_index: max + 1000 (gap-based)
    const [{ max_order }] = await this.sql`
      SELECT COALESCE(MAX(order_index), 0)::int AS max_order FROM topic
    `;
    const [row] = await this.sql`
      INSERT INTO topic (name, name_vi, description, description_vi, icon, color, order_index)
      VALUES (
        ${data.name}, ${data.name_vi},
        ${data.description ?? null}, ${data.description_vi ?? null},
        ${data.icon ?? null}, ${data.color},
        ${max_order + 1000}
      )
      RETURNING *
    `;
    return row;
  }

  async updateTopic(id, data) {
    const existing = await this.findTopicById(id);
    const [row] = await this.sql`
      UPDATE topic SET
        name           = ${data.name ?? existing.name},
        name_vi        = ${data.name_vi ?? existing.name_vi},
        description    = ${data.description !== undefined ? data.description : existing.description},
        description_vi = ${data.description_vi !== undefined ? data.description_vi : existing.description_vi},
        icon           = ${data.icon !== undefined ? data.icon : existing.icon},
        color          = ${data.color ?? existing.color}
      WHERE id = ${id}
      RETURNING *
    `;
    return row;
  }

  async deleteTopic(id) {
    await this.findTopicById(id); // throws 404 if not found
    await this.sql`DELETE FROM topic WHERE id = ${id}`;
    return { id };
  }

  async reorderTopics(orderedIds) {
    // Gap-based: assign order_index = index * 1000
    await this.sql.begin(async (tx) => {
      for (let i = 0; i < orderedIds.length; i++) {
        await tx`
          UPDATE topic SET order_index = ${i * 1000} WHERE id = ${orderedIds[i]}
        `;
      }
    });
  }

  // ─── CATEGORIES ──────────────────────────────────────────

  async findAllCategories(topicId) {
    if (topicId) {
      return this.sql`
        SELECT
          c.*,
          t.name AS topic_name,
          COALESCE(lc.cnt, 0)::int AS lesson_count
        FROM category c
        LEFT JOIN topic t ON t.id = c.topic_id
        LEFT JOIN (
          SELECT group_id, COUNT(*)::int AS cnt FROM lesson GROUP BY group_id
        ) lc ON lc.group_id = c.id
        WHERE c.topic_id = ${topicId}
        ORDER BY c.order_index, c.id
      `;
    }
    return this.sql`
      SELECT
        c.*,
        t.name AS topic_name,
        COALESCE(lc.cnt, 0)::int AS lesson_count
      FROM category c
      LEFT JOIN topic t ON t.id = c.topic_id
      LEFT JOIN (
        SELECT group_id, COUNT(*)::int AS cnt FROM lesson GROUP BY group_id
      ) lc ON lc.group_id = c.id
      ORDER BY COALESCE(t.order_index, 99999), c.order_index, c.id
    `;
  }

  async findCategoryById(id) {
    const [row] = await this.sql`SELECT * FROM category WHERE id = ${id}`;
    if (!row) throw new NotFoundError('Category');
    return row;
  }

  async createCategory(data) {
    const [{ max_order }] = await this.sql`
      SELECT COALESCE(MAX(order_index), 0)::int AS max_order FROM category
    `;
    const [row] = await this.sql`
      INSERT INTO category (name, name_vi, description, description_vi, icon, color, topic_id, order_index)
      VALUES (
        ${data.name}, ${data.name_vi},
        ${data.description ?? null}, ${data.description_vi ?? null},
        ${data.icon ?? null}, ${data.color},
        ${data.topic_id ?? null},
        ${max_order + 1000}
      )
      RETURNING *
    `;
    return row;
  }

  async updateCategory(id, data) {
    const existing = await this.findCategoryById(id);
    const [row] = await this.sql`
      UPDATE category SET
        name           = ${data.name ?? existing.name},
        name_vi        = ${data.name_vi ?? existing.name_vi},
        description    = ${data.description !== undefined ? data.description : existing.description},
        description_vi = ${data.description_vi !== undefined ? data.description_vi : existing.description_vi},
        icon           = ${data.icon !== undefined ? data.icon : existing.icon},
        color          = ${data.color ?? existing.color},
        topic_id       = ${data.topic_id !== undefined ? data.topic_id : existing.topic_id}
      WHERE id = ${id}
      RETURNING *
    `;
    return row;
  }

  async deleteCategory(id) {
    await this.findCategoryById(id);
    // FK ON DELETE RESTRICT — will throw DB error if lessons exist
    await this.sql`DELETE FROM category WHERE id = ${id}`;
    return { id };
  }

  async reorderCategories(orderedIds) {
    await this.sql.begin(async (tx) => {
      for (let i = 0; i < orderedIds.length; i++) {
        await tx`
          UPDATE category SET order_index = ${i * 1000} WHERE id = ${orderedIds[i]}
        `;
      }
    });
  }

  // ─── LESSONS ─────────────────────────────────────────────

  async findAllLessons({ categoryId, search } = {}) {
    if (search) {
      const pattern = `%${search.replace(/[%_\\]/g, '\\$&')}%`;
      return this.sql`
        SELECT
          l.id, l.name, l.name_vi, l.slug, l.difficulty,
          l.is_published, l.order_index, l.group_id,
          l.estimated_time, l.created_at, l.updated_at,
          c.name AS category_name,
          t.name AS topic_name,
          COALESCE(ec.cnt, 0)::int AS exercise_count,
          COALESCE(sc.cnt, 0)::int AS section_count
        FROM lesson l
        JOIN category c ON c.id = l.group_id
        LEFT JOIN topic t ON t.id = c.topic_id
        LEFT JOIN (
          SELECT lesson_id, COUNT(*)::int AS cnt
          FROM exercise WHERE is_active = TRUE GROUP BY lesson_id
        ) ec ON ec.lesson_id = l.id
        LEFT JOIN (
          SELECT lesson_id, COUNT(*)::int AS cnt
          FROM lesson_section GROUP BY lesson_id
        ) sc ON sc.lesson_id = l.id
        WHERE l.name ILIKE ${pattern} OR l.name_vi ILIKE ${pattern}
        ORDER BY l.updated_at DESC
        LIMIT 200
      `;
    }
    if (categoryId) {
      return this.sql`
        SELECT
          l.id, l.name, l.name_vi, l.slug, l.difficulty,
          l.is_published, l.order_index, l.group_id,
          l.estimated_time, l.created_at, l.updated_at,
          c.name AS category_name,
          t.name AS topic_name,
          COALESCE(ec.cnt, 0)::int AS exercise_count,
          COALESCE(sc.cnt, 0)::int AS section_count
        FROM lesson l
        JOIN category c ON c.id = l.group_id
        LEFT JOIN topic t ON t.id = c.topic_id
        LEFT JOIN (
          SELECT lesson_id, COUNT(*)::int AS cnt
          FROM exercise WHERE is_active = TRUE GROUP BY lesson_id
        ) ec ON ec.lesson_id = l.id
        LEFT JOIN (
          SELECT lesson_id, COUNT(*)::int AS cnt
          FROM lesson_section GROUP BY lesson_id
        ) sc ON sc.lesson_id = l.id
        WHERE l.group_id = ${categoryId}
        ORDER BY l.order_index, l.id
      `;
    }
    return this.sql`
      SELECT
        l.id, l.name, l.name_vi, l.slug, l.difficulty,
        l.is_published, l.order_index, l.group_id,
        l.estimated_time, l.created_at, l.updated_at,
        c.name AS category_name,
        t.name AS topic_name,
        COALESCE(ec.cnt, 0)::int AS exercise_count,
        COALESCE(sc.cnt, 0)::int AS section_count
      FROM lesson l
      JOIN category c ON c.id = l.group_id
      LEFT JOIN topic t ON t.id = c.topic_id
      LEFT JOIN (
        SELECT lesson_id, COUNT(*)::int AS cnt
        FROM exercise WHERE is_active = TRUE GROUP BY lesson_id
      ) ec ON ec.lesson_id = l.id
      LEFT JOIN (
        SELECT lesson_id, COUNT(*)::int AS cnt
        FROM lesson_section GROUP BY lesson_id
      ) sc ON sc.lesson_id = l.id
      ORDER BY COALESCE(t.order_index, 99999), c.order_index, l.order_index, l.id
      LIMIT 500
    `;
  }

  async findLessonById(id) {
    const [row] = await this.sql`
      SELECT l.*, c.name AS category_name, t.name AS topic_name
      FROM lesson l
      JOIN category c ON c.id = l.group_id
      LEFT JOIN topic t ON t.id = c.topic_id
      WHERE l.id = ${id}
    `;
    if (!row) throw new NotFoundError('Lesson');
    return row;
  }

  async createLesson(data) {
    const [{ max_order }] = await this.sql`
      SELECT COALESCE(MAX(order_index), 0)::int AS max_order
      FROM lesson WHERE group_id = ${data.group_id}
    `;
    const [row] = await this.sql`
      INSERT INTO lesson (
        name, name_vi, slug, short_desc, short_desc_vi,
        description, description_vi, group_id,
        difficulty, estimated_time, is_published, order_index
      ) VALUES (
        ${data.name}, ${data.name_vi}, ${data.slug},
        ${data.short_desc ?? null}, ${data.short_desc_vi ?? null},
        ${data.description ?? null}, ${data.description_vi ?? null},
        ${data.group_id},
        ${data.difficulty ?? 'beginner'},
        ${data.estimated_time ?? null},
        ${data.is_published ?? false},
        ${max_order + 1000}
      )
      RETURNING *
    `;
    return row;
  }

  async updateLesson(id, data) {
    const existing = await this.findLessonById(id);
    const [row] = await this.sql`
      UPDATE lesson SET
        name           = ${data.name ?? existing.name},
        name_vi        = ${data.name_vi ?? existing.name_vi},
        slug           = ${data.slug ?? existing.slug},
        short_desc     = ${data.short_desc !== undefined ? data.short_desc : existing.short_desc},
        short_desc_vi  = ${data.short_desc_vi !== undefined ? data.short_desc_vi : existing.short_desc_vi},
        description    = ${data.description !== undefined ? data.description : existing.description},
        description_vi = ${data.description_vi !== undefined ? data.description_vi : existing.description_vi},
        group_id       = ${data.group_id ?? existing.group_id},
        difficulty     = ${data.difficulty ?? existing.difficulty},
        estimated_time = ${data.estimated_time !== undefined ? data.estimated_time : existing.estimated_time},
        is_published   = ${data.is_published !== undefined ? data.is_published : existing.is_published}
      WHERE id = ${id}
      RETURNING *
    `;
    return row;
  }

  async deleteLesson(id) {
    await this.findLessonById(id);
    // CASCADE deletes: sections, exercises, formulas, usages, etc.
    await this.sql`DELETE FROM lesson WHERE id = ${id}`;
    return { id };
  }

  async reorderLessons(orderedIds) {
    await this.sql.begin(async (tx) => {
      for (let i = 0; i < orderedIds.length; i++) {
        await tx`
          UPDATE lesson SET order_index = ${i * 1000} WHERE id = ${orderedIds[i]}
        `;
      }
    });
  }

  // ─── SECTIONS ────────────────────────────────────────────

  async findSectionsByLesson(lessonId) {
    // Verify lesson exists
    const [lesson] = await this.sql`
      SELECT l.id, l.name, l.name_vi, l.slug
      FROM lesson l WHERE l.id = ${lessonId}
    `;
    if (!lesson) throw new NotFoundError('Lesson');

    const sections = await this.sql`
      SELECT * FROM lesson_section
      WHERE lesson_id = ${lessonId}
      ORDER BY order_index, id
    `;

    return { lesson, sections };
  }

  async findSectionById(id) {
    const [row] = await this.sql`SELECT * FROM lesson_section WHERE id = ${id}`;
    if (!row) throw new NotFoundError('Section');
    return row;
  }

  async createSection(lessonId, data) {
    // Verify lesson exists
    const [lesson] = await this
      .sql`SELECT id FROM lesson WHERE id = ${lessonId}`;
    if (!lesson) throw new NotFoundError('Lesson');

    const [{ max_order }] = await this.sql`
      SELECT COALESCE(MAX(order_index), 0)::int AS max_order
      FROM lesson_section WHERE lesson_id = ${lessonId}
    `;
    const [row] = await this.sql`
      INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index)
      VALUES (
        ${lessonId}, ${data.type},
        ${data.title ?? null}, ${data.title_vi ?? null},
        ${data.content ?? null}, ${data.content_vi ?? null},
        ${data.metadata ?? {}},
        ${max_order + 1000}
      )
      RETURNING *
    `;
    return row;
  }

  async updateSection(id, data) {
    const existing = await this.findSectionById(id);
    const [row] = await this.sql`
      UPDATE lesson_section SET
        type       = ${data.type ?? existing.type},
        title      = ${data.title !== undefined ? data.title : existing.title},
        title_vi   = ${data.title_vi !== undefined ? data.title_vi : existing.title_vi},
        content    = ${data.content !== undefined ? data.content : existing.content},
        content_vi = ${data.content_vi !== undefined ? data.content_vi : existing.content_vi},
        metadata   = ${data.metadata !== undefined ? data.metadata : existing.metadata}
      WHERE id = ${id}
      RETURNING *
    `;
    return row;
  }

  async deleteSection(id) {
    await this.findSectionById(id);
    await this.sql`DELETE FROM lesson_section WHERE id = ${id}`;
    return { id };
  }

  async reorderSections(lessonId, orderedIds) {
    await this.sql.begin(async (tx) => {
      for (let i = 0; i < orderedIds.length; i++) {
        await tx`
          UPDATE lesson_section
          SET order_index = ${i * 1000}
          WHERE id = ${orderedIds[i]} AND lesson_id = ${lessonId}
        `;
      }
    });
  }
}
