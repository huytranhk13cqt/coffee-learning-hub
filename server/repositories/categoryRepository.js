export class CategoryRepository {
  constructor(sql) {
    this.sql = sql;
  }

  async findAllWithLessonCount() {
    return this.sql`
      SELECT
        g.id,
        g.name,
        g.name_vi,
        g.description,
        g.description_vi,
        g.icon,
        g.color,
        g.order_index,
        COUNT(l.id)::int AS lesson_count
      FROM category g
      LEFT JOIN lesson l ON l.group_id = g.id AND l.is_published = TRUE
      GROUP BY g.id
      ORDER BY g.order_index
    `;
  }

  /**
   * Home page BFF: categories + lessons + session progress in a single query.
   * Returns flat rows; the controller groups them into nested structure.
   */
  async findHomePageData(sessionId) {
    return this.sql`
      SELECT
        g.id            AS group_id,
        g.name          AS group_name,
        g.name_vi       AS group_name_vi,
        g.color         AS group_color,
        l.id            AS lesson_id,
        l.name          AS lesson_name,
        l.name_vi       AS lesson_name_vi,
        l.slug          AS lesson_slug,
        l.difficulty    AS lesson_difficulty,
        COALESCE(up.status::text, 'not_started') AS progress_status,
        COALESCE(up.best_score, 0)               AS best_score
      FROM category g
      LEFT JOIN lesson l ON l.group_id = g.id AND l.is_published = TRUE
      LEFT JOIN user_progress up
        ON up.lesson_id = l.id AND up.session_id = ${sessionId}
      ORDER BY g.order_index, l.order_index
    `;
  }
}
