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
}
