export class ProgressRepository {
  constructor(sql) {
    this.sql = sql;
  }

  // D0: Get progress for all lessons in a session
  async findAllBySession(sessionId) {
    return this.sql`
      SELECT
        up.lesson_id, up.status, up.theory_completed,
        up.exercises_attempted, up.exercises_correct,
        COALESCE(ec.total, 0) AS exercises_total,
        up.current_score, up.best_score, up.total_attempts
      FROM user_progress up
      LEFT JOIN (
        SELECT lesson_id, COUNT(*)::int AS total
        FROM exercise
        WHERE is_active = TRUE
        GROUP BY lesson_id
      ) ec ON ec.lesson_id = up.lesson_id
      WHERE up.session_id = ${sessionId}
    `;
  }

  // D1: Get progress for a lesson
  async findBySessionAndLesson(sessionId, lessonId) {
    const rows = await this.sql`
      SELECT
        status, theory_completed, theory_time_spent,
        exercises_attempted, exercises_correct,
        (SELECT COUNT(*)::int FROM exercise WHERE lesson_id = up.lesson_id AND is_active = TRUE) AS exercises_total,
        current_score, best_score, total_time_spent,
        last_position, completed_at
      FROM user_progress up
      WHERE session_id = ${sessionId} AND lesson_id = ${lessonId}
    `;
    return rows[0] || null;
  }

  // D2: Mark theory as read (upsert)
  async markTheoryComplete(sessionId, lessonId, timeSpent) {
    await this.sql`
      INSERT INTO user_progress (session_id, lesson_id, theory_completed, last_position, theory_time_spent)
      VALUES (${sessionId}, ${lessonId}, TRUE, 'theory', ${timeSpent ?? 0})
      ON CONFLICT (session_id, lesson_id) DO UPDATE SET
        theory_completed = TRUE,
        last_position = 'theory',
        theory_time_spent = user_progress.theory_time_spent + ${timeSpent ?? 0}
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
  async insertAttempt(
    tx,
    { sessionId, exerciseId, userAnswer, isCorrect, timeTaken, attemptNumber },
  ) {
    await tx`
      INSERT INTO exercise_attempt
        (session_id, exercise_id, user_answer, is_correct, time_taken, attempt_number)
      VALUES
        (${sessionId}, ${exerciseId}, ${userAnswer}, ${isCorrect}, ${timeTaken ?? null}, ${attemptNumber})
    `;
  }

  // C5c: Upsert progress
  async upsertProgress(tx, { sessionId, lessonId, isCorrect, timeTaken }) {
    const correctIncrement = isCorrect ? 1 : 0;
    const timeIncrement = timeTaken ?? 0;

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
      WITH exercise_counts AS (
        SELECT lesson_id, COUNT(*)::int AS total
        FROM exercise
        WHERE is_active = TRUE
        GROUP BY lesson_id
      )
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
        COALESCE(ec.total, 0)                AS exercises_total,
        up.completed_at
      FROM lesson l
      JOIN category g ON l.group_id = g.id
      LEFT JOIN user_progress up ON up.lesson_id = l.id AND up.session_id = ${sessionId}
      LEFT JOIN exercise_counts ec ON ec.lesson_id = l.id
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

  // D6: Find exercises the learner struggles with most (Phase 24 — Adaptive Weak-Spot)
  // Returns exercises with >= minAttempts attempts and error_rate > threshold
  async findWeakSpots(sessionId, minAttempts = 2, errorRateThreshold = 0.4) {
    return this.sql`
      SELECT
        e.id,
        e.question,
        e.question_vi,
        e.type,
        c.name    AS category_name,
        c.name_vi AS category_name_vi,
        l.name    AS lesson_name,
        l.name_vi AS lesson_name_vi,
        l.slug    AS lesson_slug,
        COUNT(*)::int                                                              AS total_attempts,
        ROUND(
          SUM(CASE WHEN ea.is_correct THEN 0 ELSE 1 END)::NUMERIC / COUNT(*), 2
        )                                                                          AS error_rate
      FROM exercise_attempt ea
      JOIN exercise e  ON ea.exercise_id = e.id
      JOIN lesson l    ON e.lesson_id    = l.id
      JOIN category c  ON l.group_id     = c.id
      WHERE ea.session_id = ${sessionId}
      GROUP BY e.id, e.question, e.question_vi, e.type, c.name, c.name_vi, l.name, l.name_vi, l.slug
      HAVING
        COUNT(*) >= ${minAttempts}
        AND ROUND(
          SUM(CASE WHEN ea.is_correct THEN 0 ELSE 1 END)::NUMERIC / COUNT(*), 2
        ) > ${errorRateThreshold}
      ORDER BY error_rate DESC, total_attempts DESC
      LIMIT 10
    `;
  }

  // D6: Export all session data for backup / cross-device migration
  //
  // Fetches 7 tables in parallel — the exported payload is a self-contained
  // snapshot that can be imported to any session (same device or different device).
  async exportSession(sessionId) {
    const [
      progress,
      attempts,
      reviews,
      xpEvents,
      dailyActivity,
      streakRows,
      achievements,
    ] = await Promise.all([
      this.sql`
        SELECT lesson_id, status, theory_completed, theory_time_spent,
               exercises_attempted, exercises_correct, current_score,
               best_score, total_attempts, total_time_spent,
               last_position, completed_at
        FROM user_progress WHERE session_id = ${sessionId}
      `,
      this.sql`
        SELECT exercise_id, user_answer, is_correct, time_taken,
               attempt_number, created_at
        FROM exercise_attempt WHERE session_id = ${sessionId}
        ORDER BY created_at
      `,
      this.sql`
        SELECT exercise_id, ease_factor, interval_days, repetitions,
               last_review_at, next_review_at
        FROM exercise_review WHERE session_id = ${sessionId}
      `,
      this.sql`
        SELECT event_type, xp_amount, reference_id, created_at
        FROM xp_event WHERE session_id = ${sessionId}
        ORDER BY created_at
      `,
      this.sql`
        SELECT activity_date, exercises_completed, xp_earned
        FROM daily_activity WHERE session_id = ${sessionId}
        ORDER BY activity_date
      `,
      this.sql`
        SELECT current_streak, longest_streak, last_active_date, daily_goal
        FROM user_streak WHERE session_id = ${sessionId}
      `,
      this.sql`
        SELECT achievement_id, earned_at
        FROM user_achievement WHERE session_id = ${sessionId}
      `,
    ]);

    return {
      version: 1,
      exportedAt: new Date().toISOString(),
      progress,
      attempts,
      reviews,
      xpEvents,
      dailyActivity,
      streak: streakRows[0] ?? null,
      achievements,
    };
  }

  // D7: Import session backup — all-or-nothing transaction
  //
  // Conflict resolution strategy per table:
  //   user_progress   → UPSERT taking the "better" state (completed > in_progress)
  //   exercise_attempt → INSERT IGNORE (preserve original attempt history)
  //   exercise_review  → UPSERT (latest SM-2 state wins)
  //   xp_event        → DELETE + INSERT (no natural unique key — replace atomically)
  //   daily_activity  → DELETE + INSERT (same reason as xp_event)
  //   user_streak     → UPSERT (take highest streaks)
  //   user_achievement → INSERT IGNORE (never lose earned badges)
  async importSession(targetSessionId, data) {
    const {
      progress = [],
      attempts = [],
      reviews = [],
      xpEvents = [],
      dailyActivity = [],
      streak = null,
      achievements = [],
    } = data;

    await this.sql.begin(async (tx) => {
      // --- user_progress ---
      for (const row of progress) {
        await tx`
          INSERT INTO user_progress
            (session_id, lesson_id, status, theory_completed, theory_time_spent,
             exercises_attempted, exercises_correct, current_score, best_score,
             total_attempts, total_time_spent, last_position, completed_at)
          VALUES
            (${targetSessionId}, ${row.lesson_id},
             ${row.status}::progress_status, ${row.theory_completed}, ${row.theory_time_spent ?? 0},
             ${row.exercises_attempted ?? 0}, ${row.exercises_correct ?? 0},
             ${row.current_score ?? 0}, ${row.best_score ?? 0},
             ${row.total_attempts ?? 0}, ${row.total_time_spent ?? 0},
             ${row.last_position ?? null}, ${row.completed_at ?? null})
          ON CONFLICT (session_id, lesson_id) DO UPDATE SET
            status = CASE
              WHEN user_progress.status = 'completed'  OR EXCLUDED.status = 'completed'  THEN 'completed'::progress_status
              WHEN user_progress.status = 'in_progress' OR EXCLUDED.status = 'in_progress' THEN 'in_progress'::progress_status
              ELSE 'not_started'::progress_status
            END,
            theory_completed   = user_progress.theory_completed OR EXCLUDED.theory_completed,
            theory_time_spent  = GREATEST(user_progress.theory_time_spent,  EXCLUDED.theory_time_spent),
            exercises_attempted= GREATEST(user_progress.exercises_attempted, EXCLUDED.exercises_attempted),
            exercises_correct  = GREATEST(user_progress.exercises_correct,   EXCLUDED.exercises_correct),
            current_score      = GREATEST(user_progress.current_score,       EXCLUDED.current_score),
            best_score         = GREATEST(user_progress.best_score,          EXCLUDED.best_score),
            total_attempts     = GREATEST(user_progress.total_attempts,      EXCLUDED.total_attempts),
            total_time_spent   = GREATEST(user_progress.total_time_spent,    EXCLUDED.total_time_spent),
            completed_at       = COALESCE(user_progress.completed_at,        EXCLUDED.completed_at)
        `;
      }

      // --- exercise_attempt (preserve originals, skip duplicates) ---
      for (const row of attempts) {
        await tx`
          INSERT INTO exercise_attempt
            (session_id, exercise_id, user_answer, is_correct,
             time_taken, attempt_number, created_at)
          VALUES
            (${targetSessionId}, ${row.exercise_id}, ${row.user_answer},
             ${row.is_correct}, ${row.time_taken ?? null},
             ${row.attempt_number}, ${row.created_at})
          ON CONFLICT (session_id, exercise_id, attempt_number) DO NOTHING
        `;
      }

      // --- exercise_review (latest SM-2 state wins) ---
      for (const row of reviews) {
        await tx`
          INSERT INTO exercise_review
            (session_id, exercise_id, ease_factor, interval_days,
             repetitions, last_review_at, next_review_at)
          VALUES
            (${targetSessionId}, ${row.exercise_id}, ${row.ease_factor},
             ${row.interval_days}, ${row.repetitions},
             ${row.last_review_at ?? null}, ${row.next_review_at})
          ON CONFLICT (session_id, exercise_id) DO UPDATE SET
            ease_factor    = EXCLUDED.ease_factor,
            interval_days  = EXCLUDED.interval_days,
            repetitions    = EXCLUDED.repetitions,
            last_review_at = EXCLUDED.last_review_at,
            next_review_at = EXCLUDED.next_review_at
        `;
      }

      // --- xp_event (delete + insert — no natural unique key) ---
      await tx`DELETE FROM xp_event WHERE session_id = ${targetSessionId}`;
      for (const row of xpEvents) {
        await tx`
          INSERT INTO xp_event (session_id, event_type, xp_amount, reference_id, created_at)
          VALUES (${targetSessionId}, ${row.event_type}, ${row.xp_amount},
                  ${row.reference_id ?? null}, ${row.created_at})
        `;
      }

      // --- daily_activity (delete + insert — no natural unique key beyond session+date) ---
      await tx`DELETE FROM daily_activity WHERE session_id = ${targetSessionId}`;
      for (const row of dailyActivity) {
        await tx`
          INSERT INTO daily_activity (session_id, activity_date, exercises_completed, xp_earned)
          VALUES (${targetSessionId}, ${row.activity_date},
                  ${row.exercises_completed}, ${row.xp_earned})
        `;
      }

      // --- user_streak (upsert — take highest streaks) ---
      if (streak) {
        await tx`
          INSERT INTO user_streak
            (session_id, current_streak, longest_streak, last_active_date, daily_goal)
          VALUES
            (${targetSessionId}, ${streak.current_streak}, ${streak.longest_streak},
             ${streak.last_active_date ?? null}, ${streak.daily_goal ?? 5})
          ON CONFLICT (session_id) DO UPDATE SET
            current_streak   = GREATEST(user_streak.current_streak,   EXCLUDED.current_streak),
            longest_streak   = GREATEST(user_streak.longest_streak,   EXCLUDED.longest_streak),
            last_active_date = EXCLUDED.last_active_date,
            daily_goal       = EXCLUDED.daily_goal
        `;
      }

      // --- user_achievement (never overwrite — INSERT IGNORE) ---
      for (const row of achievements) {
        await tx`
          INSERT INTO user_achievement (session_id, achievement_id, earned_at)
          VALUES (${targetSessionId}, ${row.achievement_id}, ${row.earned_at})
          ON CONFLICT (session_id, achievement_id) DO NOTHING
        `;
      }
    });
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
