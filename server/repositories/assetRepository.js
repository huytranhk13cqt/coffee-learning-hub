import { NotFoundError } from '../errors/AppError.js';

export class AssetRepository {
  constructor(sql) {
    this.sql = sql;
  }

  async create({
    name,
    type,
    path,
    width,
    height,
    frameCount,
    tags,
    prompt,
    model,
    fileSize,
  }) {
    const [asset] = await this.sql`
      INSERT INTO pixel_assets (
        name, type, path, width, height, frame_count,
        tags, prompt, model, file_size
      )
      VALUES (
        ${name}, ${type}, ${path}, ${width || null}, ${height || null},
        ${frameCount || 1}, ${tags || []}, ${prompt || null},
        ${model || null}, ${fileSize || null}
      )
      RETURNING *
    `;
    return asset;
  }

  async findAll({ type, tag, limit = 20, offset = 0 } = {}) {
    // Build conditions dynamically using postgres.js tagged templates
    const conditions = [];
    if (type) conditions.push(this.sql`type = ${type}`);
    if (tag) conditions.push(this.sql`${tag} = ANY(tags)`);

    const where =
      conditions.length > 0
        ? this
            .sql`WHERE ${conditions.reduce((a, b) => this.sql`${a} AND ${b}`)}`
        : this.sql``;

    const rows = await this.sql`
      SELECT * FROM pixel_assets
      ${where}
      ORDER BY created_at DESC
      LIMIT ${limit} OFFSET ${offset}
    `;

    const [{ count }] = await this.sql`
      SELECT COUNT(*)::int AS count FROM pixel_assets ${where}
    `;

    return { rows, total: count };
  }

  async findById(id) {
    const [row] = await this.sql`
      SELECT * FROM pixel_assets WHERE id = ${id}
    `;
    if (!row) throw new NotFoundError('Asset');
    return row;
  }

  async remove(id) {
    const [row] = await this.sql`
      DELETE FROM pixel_assets WHERE id = ${id} RETURNING path
    `;
    if (!row) throw new NotFoundError('Asset');
    return row;
  }
}
