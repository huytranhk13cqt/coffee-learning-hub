export class ReviewRepository {
  constructor(sql) {
    this.sql = sql;
  }

  // Enroll all exercises of a lesson into review queue
  // Sets next_review_at = tomorrow (review day after completing)
  async enrollLesson(sessionId, lessonId) {
    await this.sql`
      INSERT INTO exercise_review (session_id, exercise_id, next_review_at)
      SELECT ${sessionId}, e.id, CURRENT_DATE + 1
      FROM exercise e
      WHERE e.lesson_id = ${lessonId} AND e.is_active = TRUE
      ON CONFLICT (session_id, exercise_id) DO NOTHING
    `;
  }

  // Get exercises due today (next_review_at <= CURRENT_DATE), limit 20
  // Include exercise data (type, question, options, etc.) — NO correct_answer
  async findDueExercises(sessionId, limit = 20) {
    const exercises = await this.sql`
      SELECT
        er.id AS review_id,
        er.ease_factor, er.interval_days, er.repetitions, er.next_review_at,
        e.id, e.type, e.difficulty, e.question, e.question_vi,
        e.content, e.content_vi, e.context, e.context_vi,
        e.word_bank, e.hint, e.hint_vi, e.points,
        l.name AS lesson_name, l.name_vi AS lesson_name_vi, l.slug AS lesson_slug,
        c.name AS category_name
      FROM exercise_review er
      JOIN exercise e ON e.id = er.exercise_id
      JOIN lesson l ON l.id = e.lesson_id
      JOIN category c ON c.id = l.group_id
      WHERE er.session_id = ${sessionId}
        AND er.next_review_at <= CURRENT_DATE
        AND e.is_active = TRUE
      ORDER BY er.next_review_at ASC, er.ease_factor ASC
      LIMIT ${limit}
    `;

    if (exercises.length === 0) return [];

    // Get MC options for due exercises (without is_correct)
    const exerciseIds = exercises.map((e) => e.id);
    const options = await this.sql`
      SELECT eo.id, eo.exercise_id, eo.label, eo.content, eo.content_vi
      FROM exercise_option eo
      WHERE eo.exercise_id = ANY(${exerciseIds})
      ORDER BY eo.exercise_id, eo.order_index
    `;

    // Group options by exercise_id
    const optionMap = new Map();
    for (const opt of options) {
      if (!optionMap.has(opt.exercise_id)) optionMap.set(opt.exercise_id, []);
      optionMap.get(opt.exercise_id).push(opt);
    }

    return exercises.map((ex) => {
      const result = { ...ex };
      if (ex.type === 'multiple_choice') {
        result.options = optionMap.get(ex.id) || [];
      }
      return result;
    });
  }

  // Upsert SM-2 state after a review (uses tx for transaction safety)
  // INSERT ON CONFLICT ensures silent failure is impossible even if exercise
  // was never formally enrolled (e.g. direct API call with a valid exerciseId).
  async upsertReview(
    tx,
    sessionId,
    exerciseId,
    { easeFactor, intervalDays, repetitions, nextReviewDate },
  ) {
    const nextDate = nextReviewDate.toISOString().split('T')[0];
    await tx`
      INSERT INTO exercise_review
        (session_id, exercise_id, ease_factor, interval_days, repetitions,
         last_review_at, next_review_at)
      VALUES
        (${sessionId}, ${exerciseId}, ${easeFactor}, ${intervalDays}, ${repetitions},
         NOW(), ${nextDate})
      ON CONFLICT (session_id, exercise_id) DO UPDATE
        SET ease_factor    = EXCLUDED.ease_factor,
            interval_days  = EXCLUDED.interval_days,
            repetitions    = EXCLUDED.repetitions,
            last_review_at = NOW(),
            next_review_at = EXCLUDED.next_review_at,
            updated_at     = NOW()
    `;
  }

  // Stats: count due today, due this week, total enrolled
  async getReviewStats(sessionId) {
    const rows = await this.sql`
      SELECT
        COUNT(*) FILTER (WHERE next_review_at <= CURRENT_DATE)::int AS due_today,
        COUNT(*) FILTER (WHERE next_review_at <= CURRENT_DATE + 7)::int AS due_this_week,
        COUNT(*)::int AS total_enrolled
      FROM exercise_review
      WHERE session_id = ${sessionId}
    `;
    return rows[0];
  }
}
