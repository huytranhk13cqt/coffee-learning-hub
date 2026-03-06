import { NotFoundError } from '../errors/AppError.js';

export class AdminLearningPathRepository {
  constructor(sql) {
    this.sql = sql;
  }

  // ─── LIST ───────────────────────────────────────────────

  async findAll() {
    return this.sql`
      SELECT
        lp.*,
        COALESCE(sc.cnt, 0)::int AS step_count
      FROM learning_path lp
      LEFT JOIN (
        SELECT path_id, COUNT(*)::int AS cnt
        FROM learning_path_step GROUP BY path_id
      ) sc ON sc.path_id = lp.id
      ORDER BY lp.order_index, lp.id
    `;
  }

  // ─── GET BY ID ──────────────────────────────────────────

  async findById(id) {
    const [path] = await this.sql`SELECT * FROM learning_path WHERE id = ${id}`;
    if (!path) throw new NotFoundError('Learning Path');

    const steps = await this.sql`
      SELECT lps.id, lps.lesson_id, lps.order_index,
             l.name AS lesson_name, l.name_vi AS lesson_name_vi,
             l.slug AS lesson_slug,
             c.name AS category_name
      FROM learning_path_step lps
      JOIN lesson l ON l.id = lps.lesson_id
      JOIN category c ON c.id = l.group_id
      WHERE lps.path_id = ${id}
      ORDER BY lps.order_index ASC
    `;

    return { ...path, steps };
  }

  // ─── CREATE ─────────────────────────────────────────────

  async create(data) {
    const [{ max_order }] = await this.sql`
      SELECT COALESCE(MAX(order_index), 0)::int AS max_order FROM learning_path
    `;
    const [row] = await this.sql`
      INSERT INTO learning_path (name, name_vi, slug, description, description_vi,
        icon, color, estimated_days, is_featured, is_active, order_index)
      VALUES (
        ${data.name}, ${data.name_vi}, ${data.slug},
        ${data.description ?? null}, ${data.description_vi ?? null},
        ${data.icon ?? 'RouteOutlined'}, ${data.color ?? '#6366f1'},
        ${data.estimated_days ?? 7}, ${data.is_featured ?? false},
        ${data.is_active ?? true}, ${max_order + 1000}
      )
      RETURNING *
    `;
    return row;
  }

  // ─── UPDATE ─────────────────────────────────────────────

  async update(id, data) {
    const existing = await this.findById(id);
    const [row] = await this.sql`
      UPDATE learning_path SET
        name           = ${data.name ?? existing.name},
        name_vi        = ${data.name_vi ?? existing.name_vi},
        slug           = ${data.slug ?? existing.slug},
        description    = ${data.description !== undefined ? data.description : existing.description},
        description_vi = ${data.description_vi !== undefined ? data.description_vi : existing.description_vi},
        icon           = ${data.icon !== undefined ? data.icon : existing.icon},
        color          = ${data.color ?? existing.color},
        estimated_days = ${data.estimated_days ?? existing.estimated_days},
        is_featured    = ${data.is_featured !== undefined ? data.is_featured : existing.is_featured},
        is_active      = ${data.is_active !== undefined ? data.is_active : existing.is_active}
      WHERE id = ${id}
      RETURNING *
    `;
    return row;
  }

  // ─── DELETE ─────────────────────────────────────────────

  async delete(id) {
    const [existing] = await this
      .sql`SELECT id FROM learning_path WHERE id = ${id}`;
    if (!existing) throw new NotFoundError('Learning Path');
    await this.sql`DELETE FROM learning_path WHERE id = ${id}`;
    return { id };
  }

  // ─── REORDER ────────────────────────────────────────────

  async reorder(orderedIds) {
    await this.sql.begin(async (tx) => {
      for (let i = 0; i < orderedIds.length; i++) {
        await tx`
          UPDATE learning_path SET order_index = ${i * 1000} WHERE id = ${orderedIds[i]}
        `;
      }
    });
  }

  // ─── REPLACE STEPS ──────────────────────────────────────

  async replaceSteps(pathId, steps) {
    const [path] = await this
      .sql`SELECT id FROM learning_path WHERE id = ${pathId}`;
    if (!path) throw new NotFoundError('Learning Path');

    return this.sql.begin(async (tx) => {
      await tx`DELETE FROM learning_path_step WHERE path_id = ${pathId}`;

      const inserted = [];
      for (let i = 0; i < steps.length; i++) {
        const [row] = await tx`
          INSERT INTO learning_path_step (path_id, lesson_id, order_index)
          VALUES (${pathId}, ${steps[i].lesson_id}, ${i + 1})
          RETURNING *
        `;
        inserted.push(row);
      }

      return inserted;
    });
  }

  // ─── TOGGLE ACTIVE ──────────────────────────────────────

  async toggleActive(id) {
    const [row] = await this.sql`
      UPDATE learning_path SET is_active = NOT is_active WHERE id = ${id}
      RETURNING id, is_active
    `;
    if (!row) throw new NotFoundError('Learning Path');
    return row;
  }

  // ─── ALL LESSONS (for step picker) ──────────────────────

  async findAllLessons() {
    return this.sql`
      SELECT l.id, l.name, l.name_vi, l.slug, c.name AS category_name
      FROM lesson l
      JOIN category c ON c.id = l.group_id
      ORDER BY c.name, l.name
    `;
  }
}
