export class ProgressRepository {
  constructor(sql) {
    this.sql = sql;
  }

  // D0: Get progress for all lessons in a session
  async findAllBySession(sessionId) {
    return this.sql`
      SELECT
        lesson_id, status, theory_completed,
        exercises_attempted, exercises_correct, exercises_total,
        current_score, best_score, total_attempts
      FROM user_progress
      WHERE session_id = ${sessionId}
    `;
  }

  // D1: Get progress for a lesson
  async findBySessionAndLesson(sessionId, lessonId) {
    const rows = await this.sql`
      SELECT
        status, theory_completed, theory_time_spent,
        exercises_attempted, exercises_correct, exercises_total,
        current_score, best_score, total_time_spent,
        last_position, completed_at
      FROM user_progress
      WHERE session_id = ${sessionId} AND lesson_id = ${lessonId}
    `;
    return rows[0] || null;
  }

  // D2: Mark theory as read (upsert)
  async markTheoryComplete(sessionId, lessonId, timeSpent) {
    await this.sql`
      INSERT INTO user_progress (session_id, lesson_id, theory_completed, last_position, theory_time_spent)
      VALUES (${sessionId}, ${lessonId}, TRUE, 'theory', ${timeSpent || 0})
      ON CONFLICT (session_id, lesson_id) DO UPDATE SET
        theory_completed = TRUE,
        last_position = 'theory',
        theory_time_spent = user_progress.theory_time_spent + ${timeSpent || 0}
    `;
  }

  // --- Transaction-aware methods (receive tx sql as first param) ---

  // C5a: Get next attempt number (serialized per session+exercise pair)
  async getNextAttemptNumber(tx, sessionId, exerciseId) {
    await tx`SELECT pg_advisory_xact_lock(hashtext(${sessionId} || ':' || ${exerciseId}::text))`;
    const rows = await tx`
      SELECT COALESCE(MAX(attempt_number), 0) + 1 AS next_attempt
      FROM exercise_attempt
      WHERE session_id = ${sessionId} AND exercise_id = ${exerciseId}
    `;
    return rows[0].next_attempt;
  }

  // C5b: Insert attempt record
  async insertAttempt(tx, { sessionId, exerciseId, userAnswer, isCorrect, timeTaken, attemptNumber }) {
    await tx`
      INSERT INTO exercise_attempt
        (session_id, exercise_id, user_answer, is_correct, time_taken, attempt_number)
      VALUES
        (${sessionId}, ${exerciseId}, ${userAnswer}, ${isCorrect}, ${timeTaken || null}, ${attemptNumber})
    `;
  }

  // C5c: Upsert progress
  async upsertProgress(tx, { sessionId, lessonId, isCorrect, timeTaken }) {
    const correctIncrement = isCorrect ? 1 : 0;
    const timeIncrement = timeTaken || 0;

    await tx`
      INSERT INTO user_progress
        (session_id, lesson_id, status, exercises_attempted, exercises_correct, total_attempts, total_time_spent)
      VALUES
        (${sessionId}, ${lessonId}, 'in_progress', 1, ${correctIncrement}, 1, ${timeIncrement})
      ON CONFLICT (session_id, lesson_id) DO UPDATE SET
        status = CASE
          WHEN user_progress.status = 'completed' THEN 'completed'::progress_status
          ELSE 'in_progress'::progress_status
        END,
        exercises_attempted = user_progress.exercises_attempted + 1,
        exercises_correct = user_progress.exercises_correct + ${correctIncrement},
        total_attempts = user_progress.total_attempts + 1,
        total_time_spent = user_progress.total_time_spent + ${timeIncrement},
        last_access = NOW()
    `;
  }

  // C5d: Update scores
  async updateScores(tx, sessionId, lessonId) {
    await tx`
      UPDATE user_progress
      SET current_score = COALESCE(ROUND((exercises_correct::DECIMAL / NULLIF(exercises_attempted, 0)) * 100, 2), 0),
          best_score = GREATEST(best_score, COALESCE(ROUND((exercises_correct::DECIMAL / NULLIF(exercises_attempted, 0)) * 100, 2), 0))
      WHERE session_id = ${sessionId} AND lesson_id = ${lessonId}
    `;
  }

  // D3: Dashboard overview — all lessons with progress overlay
  async getDashboardOverview(sessionId) {
    return this.sql`
      SELECT
        g.id            AS group_id,
        g.name          AS group_name,
        g.name_vi       AS group_name_vi,
        g.color         AS group_color,
        g.icon          AS group_icon,
        l.id            AS lesson_id,
        l.name          AS lesson_name,
        l.name_vi       AS lesson_name_vi,
        l.slug,
        l.difficulty,
        COALESCE(up.status, 'not_started')   AS status,
        COALESCE(up.theory_completed, FALSE) AS theory_completed,
        COALESCE(up.best_score, 0)           AS best_score,
        COALESCE(up.exercises_attempted, 0)  AS exercises_attempted,
        COALESCE(up.exercises_total, 0)      AS exercises_total,
        up.completed_at
      FROM lesson l
      JOIN tense_group g ON l.group_id = g.id
      LEFT JOIN user_progress up ON up.lesson_id = l.id AND up.session_id = ${sessionId}
      WHERE l.is_published = TRUE
      ORDER BY g.order_index, l.order_index
    `;
  }

  // D4: Aggregate session statistics for dashboard header
  async getSessionStats(sessionId) {
    const rows = await this.sql`
      SELECT
        COUNT(*)::int                                                       AS lessons_started,
        COALESCE(SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END), 0)::int AS lessons_completed,
        (SELECT COUNT(*)::int FROM lesson WHERE is_published = TRUE)     AS total_lessons,
        COALESCE(ROUND(AVG(best_score), 1), 0)                          AS avg_score,
        COALESCE(SUM(total_time_spent), 0)::int                         AS total_time_seconds
      FROM user_progress
      WHERE session_id = ${sessionId}
    `;
    return rows[0];
  }

  // D5: Reset progress (transaction)
  async resetProgress(sessionId, lessonId) {
    await this.sql.begin(async (tx) => {
      // Delete attempts (PostgreSQL subquery instead of MySQL DELETE JOIN)
      await tx`
        DELETE FROM exercise_attempt
        WHERE session_id = ${sessionId}
          AND exercise_id IN (SELECT id FROM exercise WHERE lesson_id = ${lessonId})
      `;

      // Reset progress record (keep best_score and total_attempts)
      await tx`
        UPDATE user_progress
        SET status = 'not_started',
            theory_completed = FALSE,
            theory_time_spent = 0,
            exercises_attempted = 0,
            exercises_correct = 0,
            current_score = 0,
            last_position = NULL,
            completed_at = NULL
        WHERE session_id = ${sessionId} AND lesson_id = ${lessonId}
      `;
    });
  }
}
