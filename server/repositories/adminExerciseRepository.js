import { NotFoundError } from '../errors/AppError.js';

export class AdminExerciseRepository {
  constructor(sql) {
    this.sql = sql;
  }

  // ─── LIST ───────────────────────────────────────────────

  async findAll({ lessonId, type, difficulty, search } = {}) {
    const pattern = search ? `%${search.replace(/[%_\\]/g, '\\$&')}%` : null;

    return this.sql`
      SELECT
        e.id, e.lesson_id, e.type, e.difficulty,
        e.question, e.question_vi, e.points, e.is_active,
        e.order_index, e.created_at, e.updated_at,
        l.name AS lesson_name,
        c.name AS category_name,
        COALESCE(oc.cnt, 0)::int AS option_count,
        COALESCE(mc.cnt, 0)::int AS pair_count
      FROM exercise e
      JOIN lesson l ON l.id = e.lesson_id
      JOIN category c ON c.id = l.group_id
      LEFT JOIN (
        SELECT exercise_id, COUNT(*)::int AS cnt
        FROM exercise_option GROUP BY exercise_id
      ) oc ON oc.exercise_id = e.id
      LEFT JOIN (
        SELECT exercise_id, COUNT(*)::int AS cnt
        FROM matching_pair GROUP BY exercise_id
      ) mc ON mc.exercise_id = e.id
      WHERE 1=1
        ${lessonId ? this.sql`AND e.lesson_id = ${lessonId}` : this.sql``}
        ${type ? this.sql`AND e.type = ${type}` : this.sql``}
        ${difficulty ? this.sql`AND e.difficulty = ${difficulty}` : this.sql``}
        ${pattern ? this.sql`AND (e.question ILIKE ${pattern} OR e.question_vi ILIKE ${pattern})` : this.sql``}
      ORDER BY l.name, e.order_index, e.id
      LIMIT 500
    `;
  }

  // ─── GET BY ID ──────────────────────────────────────────

  async findById(id) {
    const [exercise] = await this.sql`
      SELECT e.*, l.name AS lesson_name, c.name AS category_name
      FROM exercise e
      JOIN lesson l ON l.id = e.lesson_id
      JOIN category c ON c.id = l.group_id
      WHERE e.id = ${id}
    `;
    if (!exercise) throw new NotFoundError('Exercise');

    const [options, pairs] = await Promise.all([
      this.sql`
        SELECT * FROM exercise_option
        WHERE exercise_id = ${id}
        ORDER BY order_index, id
      `,
      this.sql`
        SELECT * FROM matching_pair
        WHERE exercise_id = ${id}
        ORDER BY order_index, id
      `,
    ]);

    return { ...exercise, options, matching_pairs: pairs };
  }

  // ─── CREATE ─────────────────────────────────────────────

  async create(data) {
    const { options = [], matching_pairs = [], ...exerciseData } = data;

    return this.sql.begin(async (tx) => {
      // 1. Auto-assign order_index
      const [{ max_order }] = await tx`
        SELECT COALESCE(MAX(order_index), 0)::int AS max_order
        FROM exercise WHERE lesson_id = ${exerciseData.lesson_id}
      `;

      // 2. Insert exercise
      const [exercise] = await tx`
        INSERT INTO exercise (
          lesson_id, type, difficulty,
          question, question_vi, content, content_vi,
          context, context_vi, correct_answer,
          word_bank, explanation, explanation_vi,
          hint, hint_vi, image_url, audio_url,
          points, time_limit, is_active, order_index
        ) VALUES (
          ${exerciseData.lesson_id}, ${exerciseData.type}, ${exerciseData.difficulty ?? 'medium'},
          ${exerciseData.question}, ${exerciseData.question_vi ?? null},
          ${exerciseData.content ?? null}, ${exerciseData.content_vi ?? null},
          ${exerciseData.context ?? null}, ${exerciseData.context_vi ?? null},
          ${exerciseData.correct_answer ?? null},
          ${exerciseData.word_bank ? JSON.stringify(exerciseData.word_bank) : null},
          ${exerciseData.explanation ?? null}, ${exerciseData.explanation_vi ?? null},
          ${exerciseData.hint ?? null}, ${exerciseData.hint_vi ?? null},
          ${exerciseData.image_url ?? null}, ${exerciseData.audio_url ?? null},
          ${exerciseData.points ?? 10}, ${exerciseData.time_limit ?? null},
          ${exerciseData.is_active ?? true},
          ${max_order + 1000}
        )
        RETURNING *
      `;

      // 3. Insert options (multiple_choice, true_false)
      const insertedOptions = [];
      for (let i = 0; i < options.length; i++) {
        const opt = options[i];
        const [row] = await tx`
          INSERT INTO exercise_option (
            exercise_id, label, content, content_vi,
            is_correct, explanation, explanation_vi, order_index
          ) VALUES (
            ${exercise.id}, ${opt.label}, ${opt.content}, ${opt.content_vi ?? null},
            ${opt.is_correct ?? false}, ${opt.explanation ?? null}, ${opt.explanation_vi ?? null},
            ${i + 1}
          )
          RETURNING *
        `;
        insertedOptions.push(row);
      }

      // 4. Insert matching pairs
      const insertedPairs = [];
      for (let i = 0; i < matching_pairs.length; i++) {
        const pair = matching_pairs[i];
        const [row] = await tx`
          INSERT INTO matching_pair (
            exercise_id, left_content, left_content_vi,
            right_content, right_content_vi, order_index
          ) VALUES (
            ${exercise.id}, ${pair.left_content}, ${pair.left_content_vi ?? null},
            ${pair.right_content}, ${pair.right_content_vi ?? null},
            ${i + 1}
          )
          RETURNING *
        `;
        insertedPairs.push(row);
      }

      return {
        ...exercise,
        options: insertedOptions,
        matching_pairs: insertedPairs,
      };
    });
  }

  // ─── UPDATE ─────────────────────────────────────────────

  async update(id, data) {
    const { options, matching_pairs, ...exerciseData } = data;

    return this.sql.begin(async (tx) => {
      // 1. Fetch existing exercise
      const [existing] = await tx`SELECT * FROM exercise WHERE id = ${id}`;
      if (!existing) throw new NotFoundError('Exercise');

      // 2. Update exercise fields (merge with existing)
      const [exercise] = await tx`
        UPDATE exercise SET
          lesson_id      = ${exerciseData.lesson_id ?? existing.lesson_id},
          type           = ${exerciseData.type ?? existing.type},
          difficulty     = ${exerciseData.difficulty ?? existing.difficulty},
          question       = ${exerciseData.question ?? existing.question},
          question_vi    = ${exerciseData.question_vi !== undefined ? exerciseData.question_vi : existing.question_vi},
          content        = ${exerciseData.content !== undefined ? exerciseData.content : existing.content},
          content_vi     = ${exerciseData.content_vi !== undefined ? exerciseData.content_vi : existing.content_vi},
          context        = ${exerciseData.context !== undefined ? exerciseData.context : existing.context},
          context_vi     = ${exerciseData.context_vi !== undefined ? exerciseData.context_vi : existing.context_vi},
          correct_answer = ${exerciseData.correct_answer !== undefined ? exerciseData.correct_answer : existing.correct_answer},
          word_bank      = ${exerciseData.word_bank !== undefined ? (exerciseData.word_bank ? JSON.stringify(exerciseData.word_bank) : null) : existing.word_bank},
          explanation    = ${exerciseData.explanation !== undefined ? exerciseData.explanation : existing.explanation},
          explanation_vi = ${exerciseData.explanation_vi !== undefined ? exerciseData.explanation_vi : existing.explanation_vi},
          hint           = ${exerciseData.hint !== undefined ? exerciseData.hint : existing.hint},
          hint_vi        = ${exerciseData.hint_vi !== undefined ? exerciseData.hint_vi : existing.hint_vi},
          image_url      = ${exerciseData.image_url !== undefined ? exerciseData.image_url : existing.image_url},
          audio_url      = ${exerciseData.audio_url !== undefined ? exerciseData.audio_url : existing.audio_url},
          points         = ${exerciseData.points ?? existing.points},
          time_limit     = ${exerciseData.time_limit !== undefined ? exerciseData.time_limit : existing.time_limit},
          is_active      = ${exerciseData.is_active !== undefined ? exerciseData.is_active : existing.is_active}
        WHERE id = ${id}
        RETURNING *
      `;

      // 3. Replace options if provided (delete-all + re-insert)
      let updatedOptions;
      if (options !== undefined) {
        await tx`DELETE FROM exercise_option WHERE exercise_id = ${id}`;
        updatedOptions = [];
        for (let i = 0; i < options.length; i++) {
          const opt = options[i];
          const [row] = await tx`
            INSERT INTO exercise_option (
              exercise_id, label, content, content_vi,
              is_correct, explanation, explanation_vi, order_index
            ) VALUES (
              ${id}, ${opt.label}, ${opt.content}, ${opt.content_vi ?? null},
              ${opt.is_correct ?? false}, ${opt.explanation ?? null}, ${opt.explanation_vi ?? null},
              ${i + 1}
            )
            RETURNING *
          `;
          updatedOptions.push(row);
        }
      } else {
        updatedOptions = await tx`
          SELECT * FROM exercise_option WHERE exercise_id = ${id} ORDER BY order_index, id
        `;
      }

      // 4. Replace matching pairs if provided
      let updatedPairs;
      if (matching_pairs !== undefined) {
        await tx`DELETE FROM matching_pair WHERE exercise_id = ${id}`;
        updatedPairs = [];
        for (let i = 0; i < matching_pairs.length; i++) {
          const pair = matching_pairs[i];
          const [row] = await tx`
            INSERT INTO matching_pair (
              exercise_id, left_content, left_content_vi,
              right_content, right_content_vi, order_index
            ) VALUES (
              ${id}, ${pair.left_content}, ${pair.left_content_vi ?? null},
              ${pair.right_content}, ${pair.right_content_vi ?? null},
              ${i + 1}
            )
            RETURNING *
          `;
          updatedPairs.push(row);
        }
      } else {
        updatedPairs = await tx`
          SELECT * FROM matching_pair WHERE exercise_id = ${id} ORDER BY order_index, id
        `;
      }

      return {
        ...exercise,
        options: updatedOptions,
        matching_pairs: updatedPairs,
      };
    });
  }

  // ─── DELETE ─────────────────────────────────────────────

  async delete(id) {
    const [existing] = await this.sql`SELECT id FROM exercise WHERE id = ${id}`;
    if (!existing) throw new NotFoundError('Exercise');
    // CASCADE handles exercise_option + matching_pair
    await this.sql`DELETE FROM exercise WHERE id = ${id}`;
    return { id };
  }

  // ─── REORDER ────────────────────────────────────────────

  async reorder(lessonId, orderedIds) {
    await this.sql.begin(async (tx) => {
      for (let i = 0; i < orderedIds.length; i++) {
        await tx`
          UPDATE exercise
          SET order_index = ${(i + 1) * 1000}
          WHERE id = ${orderedIds[i]} AND lesson_id = ${lessonId}
        `;
      }
    });
  }
}
