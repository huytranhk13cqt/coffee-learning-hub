export class LearningPathRepository {
  constructor(sql) {
    this.sql = sql;
  }

  async findAll(sessionId) {
    const rows = await this.sql`
      SELECT
        lp.id, lp.slug, lp.name, lp.name_vi,
        lp.description, lp.description_vi,
        lp.icon, lp.color, lp.estimated_days,
        lp.is_featured, lp.order_index,
        COUNT(lps.id)::int AS total_steps,
        COUNT(up.lesson_id) FILTER (WHERE up.status = 'completed')::int AS completed_steps
      FROM learning_path lp
      LEFT JOIN learning_path_step lps ON lps.path_id = lp.id
      LEFT JOIN user_progress up ON up.lesson_id = lps.lesson_id
        AND up.session_id = ${sessionId}
      WHERE lp.is_active = TRUE
      GROUP BY lp.id
      ORDER BY lp.order_index ASC, lp.is_featured DESC
    `;

    return rows.map((row) => ({
      ...row,
      progress_percent:
        row.total_steps > 0
          ? Math.round((row.completed_steps / row.total_steps) * 100)
          : 0,
    }));
  }

  async findBySlug(slug, sessionId) {
    const [path] = await this.sql`
      SELECT
        id, slug, name, name_vi,
        description, description_vi,
        icon, color, estimated_days,
        is_featured, order_index
      FROM learning_path
      WHERE slug = ${slug} AND is_active = TRUE
    `;

    if (!path) return null;

    const steps = await this.sql`
      SELECT
        lps.order_index,
        l.id AS lesson_id, l.slug, l.name, l.name_vi,
        l.difficulty, l.estimated_time,
        c.name AS category_name, c.color AS category_color,
        COALESCE(up.status::text, 'not_started') AS status,
        COALESCE(up.best_score, 0) AS best_score,
        up.theory_completed
      FROM learning_path_step lps
      JOIN lesson l ON l.id = lps.lesson_id
      JOIN category c ON c.id = l.group_id
      LEFT JOIN user_progress up ON up.lesson_id = l.id
        AND up.session_id = ${sessionId}
      WHERE lps.path_id = ${path.id}
      ORDER BY lps.order_index ASC
    `;

    const completedSteps = steps.filter((s) => s.status === 'completed').length;

    return {
      ...path,
      steps,
      progress_percent:
        steps.length > 0
          ? Math.round((completedSteps / steps.length) * 100)
          : 0,
    };
  }
}
