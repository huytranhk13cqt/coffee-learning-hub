export class GamificationRepository {
  constructor(sql) {
    this.sql = sql;
  }

  // --- XP ---

  async recordXPEvent(tx, { sessionId, eventType, xpAmount, referenceId }) {
    await tx`
      INSERT INTO xp_event (session_id, event_type, xp_amount, reference_id)
      VALUES (${sessionId}, ${eventType}, ${xpAmount}, ${referenceId ?? null})
    `;
  }

  async getTotalXP(sessionId) {
    const rows = await this.sql`
      SELECT COALESCE(SUM(xp_amount), 0)::int AS total
      FROM xp_event
      WHERE session_id = ${sessionId}
    `;
    return rows[0].total;
  }

  // --- Daily Activity ---

  async updateDailyActivity(tx, sessionId, xpAmount) {
    await tx`
      INSERT INTO daily_activity (session_id, activity_date, exercises_completed, xp_earned)
      VALUES (${sessionId}, CURRENT_DATE, 1, ${xpAmount})
      ON CONFLICT (session_id, activity_date) DO UPDATE SET
        exercises_completed = daily_activity.exercises_completed + 1,
        xp_earned = daily_activity.xp_earned + ${xpAmount}
    `;
  }

  async getDailyActivity(sessionId) {
    const rows = await this.sql`
      SELECT exercises_completed, xp_earned
      FROM daily_activity
      WHERE session_id = ${sessionId} AND activity_date = CURRENT_DATE
    `;
    return rows[0] ?? { exercises_completed: 0, xp_earned: 0 };
  }

  // --- Streaks ---

  async updateStreak(tx, sessionId) {
    // Upsert user_streak: if last_active_date is yesterday → increment streak
    // If last_active_date is today → no change. Otherwise → reset to 1.
    const rows = await tx`
      INSERT INTO user_streak (session_id, current_streak, longest_streak, last_active_date)
      VALUES (${sessionId}, 1, 1, CURRENT_DATE)
      ON CONFLICT (session_id) DO UPDATE SET
        current_streak = CASE
          WHEN user_streak.last_active_date = CURRENT_DATE THEN user_streak.current_streak
          WHEN user_streak.last_active_date = CURRENT_DATE - 1 THEN user_streak.current_streak + 1
          ELSE 1
        END,
        longest_streak = GREATEST(
          user_streak.longest_streak,
          CASE
            WHEN user_streak.last_active_date = CURRENT_DATE THEN user_streak.current_streak
            WHEN user_streak.last_active_date = CURRENT_DATE - 1 THEN user_streak.current_streak + 1
            ELSE 1
          END
        ),
        last_active_date = CURRENT_DATE
      RETURNING current_streak, longest_streak
    `;
    return rows[0];
  }

  async getStreak(sessionId) {
    const rows = await this.sql`
      SELECT current_streak, longest_streak, last_active_date, daily_goal
      FROM user_streak
      WHERE session_id = ${sessionId}
    `;
    return (
      rows[0] ?? {
        current_streak: 0,
        longest_streak: 0,
        last_active_date: null,
        daily_goal: 5,
      }
    );
  }

  // --- Gamification Stats (combined endpoint) ---

  async getStats(sessionId) {
    const rows = await this.sql`
      SELECT
        COALESCE(
          (SELECT SUM(xp_amount)::int FROM xp_event WHERE session_id = ${sessionId}),
          0
        ) AS total_xp,
        COALESCE(
          (SELECT xp_earned FROM daily_activity
           WHERE session_id = ${sessionId} AND activity_date = CURRENT_DATE),
          0
        ) AS today_xp,
        COALESCE(
          (SELECT exercises_completed FROM daily_activity
           WHERE session_id = ${sessionId} AND activity_date = CURRENT_DATE),
          0
        ) AS today_exercises,
        COALESCE(
          (SELECT current_streak FROM user_streak WHERE session_id = ${sessionId}),
          0
        ) AS current_streak,
        COALESCE(
          (SELECT longest_streak FROM user_streak WHERE session_id = ${sessionId}),
          0
        ) AS longest_streak,
        COALESCE(
          (SELECT daily_goal FROM user_streak WHERE session_id = ${sessionId}),
          5
        ) AS daily_goal,
        (SELECT COUNT(*)::int FROM user_achievement WHERE session_id = ${sessionId})
          AS achievements_earned
    `;
    return rows[0];
  }

  // --- Achievements ---

  // Check all unearned achievements and award any that are now satisfied.
  // Returns array of newly earned achievements (may be empty).
  async checkAndAwardAchievements(tx, sessionId) {
    const newlyEarned = await tx`
      WITH stats AS (
        SELECT
          (SELECT COUNT(DISTINCT exercise_id)::int
           FROM exercise_attempt
           WHERE session_id = ${sessionId} AND is_correct = TRUE
          ) AS exercises_completed,
          (SELECT COUNT(*)::int
           FROM user_progress
           WHERE session_id = ${sessionId} AND status = 'completed'
          ) AS lessons_completed,
          COALESCE(
            (SELECT current_streak FROM user_streak WHERE session_id = ${sessionId}),
            0
          ) AS current_streak,
          COALESCE(
            (SELECT SUM(xp_amount)::int FROM xp_event WHERE session_id = ${sessionId}),
            0
          ) AS total_xp,
          EXISTS(
            SELECT 1 FROM user_progress
            WHERE session_id = ${sessionId} AND best_score >= 100
          ) AS has_perfect,
          (SELECT COUNT(DISTINCT l.group_id)::int
           FROM user_progress up
           JOIN lesson l ON up.lesson_id = l.id
           WHERE up.session_id = ${sessionId} AND up.status != 'not_started'
          ) AS categories_explored
      )
      SELECT a.id, a.code, a.name, a.name_vi, a.icon, a.xp_reward, a.category
      FROM achievement a
      CROSS JOIN stats s
      WHERE a.is_active = TRUE
        AND NOT EXISTS (
          SELECT 1 FROM user_achievement ua
          WHERE ua.session_id = ${sessionId} AND ua.achievement_id = a.id
        )
        AND (
          (a.condition_type = 'exercises_completed' AND s.exercises_completed >= a.condition_value)
          OR (a.condition_type = 'lessons_completed' AND s.lessons_completed >= a.condition_value)
          OR (a.condition_type = 'streak_days' AND s.current_streak >= a.condition_value)
          OR (a.condition_type = 'total_xp' AND s.total_xp >= a.condition_value)
          OR (a.condition_type = 'perfect_score' AND s.has_perfect = TRUE)
          OR (a.condition_type = 'categories_explored' AND s.categories_explored >= a.condition_value)
        )
    `;

    // Award newly earned achievements + record XP bonus
    for (const achievement of newlyEarned) {
      await tx`
        INSERT INTO user_achievement (session_id, achievement_id)
        VALUES (${sessionId}, ${achievement.id})
        ON CONFLICT DO NOTHING
      `;
      if (achievement.xp_reward > 0) {
        await tx`
          INSERT INTO xp_event (session_id, event_type, xp_amount, reference_id)
          VALUES (${sessionId}, 'achievement_bonus', ${achievement.xp_reward}, ${achievement.id})
        `;
      }
    }

    return newlyEarned.map((a) => ({
      code: a.code,
      name: a.name,
      nameVi: a.name_vi,
      icon: a.icon,
      xpReward: a.xp_reward,
      category: a.category,
    }));
  }

  async getAllAchievements(sessionId) {
    return this.sql`
      SELECT
        a.id, a.code, a.name, a.name_vi, a.description, a.description_vi,
        a.icon, a.category, a.condition_type, a.condition_value,
        a.xp_reward, a.sort_order,
        ua.earned_at
      FROM achievement a
      LEFT JOIN user_achievement ua
        ON ua.achievement_id = a.id AND ua.session_id = ${sessionId}
      WHERE a.is_active = TRUE
      ORDER BY a.sort_order
    `;
  }

  // --- Daily Goal ---

  async updateDailyGoal(sessionId, target) {
    await this.sql`
      INSERT INTO user_streak (session_id, daily_goal)
      VALUES (${sessionId}, ${target})
      ON CONFLICT (session_id) DO UPDATE SET daily_goal = ${target}
    `;
  }
}
