export class AdminRepository {
  constructor(sql) {
    this.sql = sql;
  }

  /** Total counts for stats cards */
  async getStats() {
    // Single round-trip: 6 parallel COUNT queries via CTE
    const [row] = await this.sql`
      WITH
        t AS (SELECT COUNT(*)::int AS c FROM topic),
        ca AS (SELECT COUNT(*)::int AS c FROM category),
        l AS (SELECT COUNT(*)::int AS c FROM lesson),
        e AS (SELECT COUNT(*)::int AS c FROM exercise WHERE is_active = TRUE),
        s AS (SELECT COUNT(*)::int AS c FROM lesson_section),
        lp AS (SELECT COUNT(*)::int AS c FROM learning_path)
      SELECT
        t.c  AS topics,
        ca.c AS categories,
        l.c  AS lessons,
        e.c  AS exercises,
        s.c  AS sections,
        lp.c AS learning_paths
      FROM t, ca, l, e, s, lp
    `;
    return row;
  }

  /** Exercise count grouped by type */
  async getExerciseTypeBreakdown() {
    return this.sql`
      SELECT type, COUNT(*)::int AS count
      FROM exercise
      WHERE is_active = TRUE
      GROUP BY type
      ORDER BY count DESC
    `;
  }

  /** Section count grouped by type */
  async getSectionTypeBreakdown() {
    return this.sql`
      SELECT type, COUNT(*)::int AS count
      FROM lesson_section
      GROUP BY type
      ORDER BY count DESC
    `;
  }

  /** Lesson count per category */
  async getLessonsPerCategory() {
    return this.sql`
      SELECT
        c.id AS category_id,
        c.name AS category_name,
        COUNT(l.id)::int AS count
      FROM category c
      LEFT JOIN lesson l ON l.group_id = c.id
      GROUP BY c.id, c.name
      ORDER BY count DESC
    `;
  }

  /**
   * Recent content changes — UNION of latest created/updated items
   * from multiple tables, sorted by most recent first.
   */
  async getRecentActivity(limit = 20) {
    return this.sql`
      (
        SELECT 'lesson' AS type, id, name,
          CASE WHEN updated_at > created_at + interval '1 second'
            THEN 'updated' ELSE 'created' END AS action,
          GREATEST(created_at, updated_at) AS timestamp
        FROM lesson
        ORDER BY GREATEST(created_at, updated_at) DESC
        LIMIT ${limit}
      )
      UNION ALL
      (
        SELECT 'exercise' AS type, id, question AS name,
          CASE WHEN updated_at > created_at + interval '1 second'
            THEN 'updated' ELSE 'created' END AS action,
          GREATEST(created_at, updated_at) AS timestamp
        FROM exercise
        ORDER BY GREATEST(created_at, updated_at) DESC
        LIMIT ${limit}
      )
      UNION ALL
      (
        SELECT 'topic' AS type, id, name,
          CASE WHEN updated_at > created_at + interval '1 second'
            THEN 'updated' ELSE 'created' END AS action,
          GREATEST(created_at, updated_at) AS timestamp
        FROM topic
        ORDER BY GREATEST(created_at, updated_at) DESC
        LIMIT ${limit}
      )
      UNION ALL
      (
        SELECT 'category' AS type, id, name,
          CASE WHEN updated_at > created_at + interval '1 second'
            THEN 'updated' ELSE 'created' END AS action,
          GREATEST(created_at, updated_at) AS timestamp
        FROM category
        ORDER BY GREATEST(created_at, updated_at) DESC
        LIMIT ${limit}
      )
      ORDER BY timestamp DESC
      LIMIT ${limit}
    `;
  }

  /** Content health: find orphans and incomplete content */
  async getLessonsWithoutExercises() {
    return this.sql`
      SELECT l.id, l.name, l.slug, c.name AS category
      FROM lesson l
      JOIN category c ON c.id = l.group_id
      WHERE NOT EXISTS (
        SELECT 1 FROM exercise e WHERE e.lesson_id = l.id AND e.is_active = TRUE
      )
      ORDER BY l.name
    `;
  }

  async getLessonsWithoutSections() {
    return this.sql`
      SELECT l.id, l.name, l.slug, c.name AS category
      FROM lesson l
      JOIN category c ON c.id = l.group_id
      WHERE NOT EXISTS (
        SELECT 1 FROM lesson_section s WHERE s.lesson_id = l.id
      )
      ORDER BY l.name
    `;
  }

  async getCategoriesWithoutLessons() {
    return this.sql`
      SELECT c.id, c.name, COALESCE(t.name, 'No Topic') AS topic
      FROM category c
      LEFT JOIN topic t ON t.id = c.topic_id
      WHERE NOT EXISTS (
        SELECT 1 FROM lesson l WHERE l.group_id = c.id
      )
      ORDER BY c.name
    `;
  }

  async getTopicsWithoutCategories() {
    return this.sql`
      SELECT t.id, t.name
      FROM topic t
      WHERE NOT EXISTS (
        SELECT 1 FROM category c WHERE c.topic_id = t.id
      )
      ORDER BY t.name
    `;
  }

  async getUnpublishedLessons() {
    return this.sql`
      SELECT l.id, l.name, l.slug, c.name AS category
      FROM lesson l
      JOIN category c ON c.id = l.group_id
      WHERE l.is_published = FALSE
      ORDER BY l.name
    `;
  }

  /**
   * Drafts: lessons with 0 exercises OR 0 sections.
   * Single query with LEFT JOIN + HAVING for efficiency.
   */
  async getDrafts() {
    return this.sql`
      SELECT
        l.id,
        l.name,
        l.slug,
        c.name AS category,
        COALESCE(ec.cnt, 0) AS exercise_count,
        COALESCE(sc.cnt, 0) AS section_count,
        l.created_at
      FROM lesson l
      JOIN category c ON c.id = l.group_id
      LEFT JOIN (
        SELECT lesson_id, COUNT(*)::int AS cnt
        FROM exercise WHERE is_active = TRUE
        GROUP BY lesson_id
      ) ec ON ec.lesson_id = l.id
      LEFT JOIN (
        SELECT lesson_id, COUNT(*)::int AS cnt
        FROM lesson_section
        GROUP BY lesson_id
      ) sc ON sc.lesson_id = l.id
      WHERE COALESCE(ec.cnt, 0) = 0 OR COALESCE(sc.cnt, 0) = 0
      ORDER BY l.created_at DESC
    `;
  }

  /** Log an admin action */
  async logAction({ action, entityType, entityId, metadata, ipAddress }) {
    await this.sql`
      INSERT INTO admin_action_log (action, entity_type, entity_id, metadata, ip_address)
      VALUES (${action}, ${entityType}, ${entityId ?? null}, ${metadata ?? {}}, ${ipAddress ?? null})
    `;
  }
}
