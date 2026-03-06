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

  // ─── ACTIVITY LOG ─────────────────────────────────────────

  async findActionLogs({
    page = 1,
    pageSize = 25,
    action,
    entityType,
    from,
    to,
    search,
  } = {}) {
    const offset = (page - 1) * pageSize;
    const searchPattern = search
      ? `%${search.replace(/[%_\\]/g, '\\$&')}%`
      : null;

    return this.sql`
      SELECT id, action, entity_type, entity_id, metadata, ip_address, created_at
      FROM admin_action_log
      WHERE 1=1
        ${action ? this.sql`AND action = ${action}` : this.sql``}
        ${entityType ? this.sql`AND entity_type = ${entityType}` : this.sql``}
        ${from ? this.sql`AND created_at >= ${from}::timestamptz` : this.sql``}
        ${to ? this.sql`AND created_at <= ${to}::timestamptz + interval '1 day'` : this.sql``}
        ${searchPattern ? this.sql`AND metadata::text ILIKE ${searchPattern}` : this.sql``}
      ORDER BY created_at DESC
      LIMIT ${pageSize}
      OFFSET ${offset}
    `;
  }

  async countActionLogs({ action, entityType, from, to, search } = {}) {
    const searchPattern = search
      ? `%${search.replace(/[%_\\]/g, '\\$&')}%`
      : null;

    const [{ total }] = await this.sql`
      SELECT COUNT(*)::int AS total
      FROM admin_action_log
      WHERE 1=1
        ${action ? this.sql`AND action = ${action}` : this.sql``}
        ${entityType ? this.sql`AND entity_type = ${entityType}` : this.sql``}
        ${from ? this.sql`AND created_at >= ${from}::timestamptz` : this.sql``}
        ${to ? this.sql`AND created_at <= ${to}::timestamptz + interval '1 day'` : this.sql``}
        ${searchPattern ? this.sql`AND metadata::text ILIKE ${searchPattern}` : this.sql``}
    `;
    return total;
  }

  // ─── REVIEW AGGREGATE STATS ───────────────────────────────

  async getReviewAggregateStats() {
    const [summary] = await this.sql`
      SELECT
        COUNT(*)::int AS total_enrolled,
        COUNT(*) FILTER (WHERE next_review_at <= CURRENT_DATE)::int AS due_today,
        COUNT(*) FILTER (WHERE next_review_at <= CURRENT_DATE + 7)::int AS due_this_week,
        ROUND(AVG(ease_factor), 2) AS avg_ease_factor,
        ROUND(AVG(interval_days), 1) AS avg_interval_days,
        COUNT(DISTINCT session_id)::int AS unique_sessions
      FROM exercise_review
    `;

    const easeDistribution = await this.sql`
      SELECT
        CASE
          WHEN ease_factor < 1.7 THEN '1.3-1.7'
          WHEN ease_factor < 2.1 THEN '1.7-2.1'
          WHEN ease_factor < 2.5 THEN '2.1-2.5'
          WHEN ease_factor < 2.9 THEN '2.5-2.9'
          WHEN ease_factor < 3.3 THEN '2.9-3.3'
          ELSE '3.3+'
        END AS bucket,
        COUNT(*)::int AS count
      FROM exercise_review
      GROUP BY bucket
      ORDER BY bucket
    `;

    const intervalDistribution = await this.sql`
      SELECT
        CASE
          WHEN interval_days <= 1 THEN '0-1'
          WHEN interval_days <= 7 THEN '2-7'
          WHEN interval_days <= 14 THEN '8-14'
          WHEN interval_days <= 30 THEN '15-30'
          ELSE '31+'
        END AS bucket,
        COUNT(*)::int AS count
      FROM exercise_review
      GROUP BY bucket
      ORDER BY MIN(interval_days)
    `;

    const topReviewed = await this.sql`
      SELECT
        er.exercise_id,
        e.question,
        l.name AS lesson_name,
        COUNT(DISTINCT er.session_id)::int AS review_count,
        ROUND(AVG(er.ease_factor), 2) AS avg_ease
      FROM exercise_review er
      JOIN exercise e ON e.id = er.exercise_id
      JOIN lesson l ON l.id = e.lesson_id
      GROUP BY er.exercise_id, e.question, l.name
      ORDER BY review_count DESC
      LIMIT 10
    `;

    return {
      ...summary,
      ease_distribution: easeDistribution,
      interval_distribution: intervalDistribution,
      top_reviewed: topReviewed,
    };
  }

  // ─── WEAK SPOTS AGGREGATE ────────────────────────────────

  async getWeakSpotsAggregate({
    minAttempts = 5,
    type,
    lessonId,
    categoryId,
    limit = 50,
  } = {}) {
    return this.sql`
      SELECT
        e.id AS exercise_id,
        e.question,
        e.question_vi,
        e.type,
        l.name AS lesson_name,
        l.id AS lesson_id,
        c.name AS category_name,
        c.id AS category_id,
        COUNT(*)::int AS total_attempts,
        SUM(CASE WHEN ea.is_correct = FALSE THEN 1 ELSE 0 END)::int AS total_errors,
        ROUND(
          SUM(CASE WHEN ea.is_correct = FALSE THEN 1 ELSE 0 END)::NUMERIC / COUNT(*), 2
        ) AS error_rate,
        COUNT(DISTINCT ea.session_id)::int AS unique_sessions
      FROM exercise_attempt ea
      JOIN exercise e ON ea.exercise_id = e.id
      JOIN lesson l ON e.lesson_id = l.id
      JOIN category c ON l.group_id = c.id
      WHERE e.is_active = TRUE
        ${type ? this.sql`AND e.type = ${type}` : this.sql``}
        ${lessonId ? this.sql`AND e.lesson_id = ${lessonId}` : this.sql``}
        ${categoryId ? this.sql`AND l.group_id = ${categoryId}` : this.sql``}
      GROUP BY e.id, e.question, e.question_vi, e.type, l.name, l.id, c.name, c.id
      HAVING COUNT(*) >= ${minAttempts}
      ORDER BY error_rate DESC, total_attempts DESC
      LIMIT ${limit}
    `;
  }
}
