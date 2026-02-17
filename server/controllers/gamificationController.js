import { ValidationError } from '../errors/AppError.js';
import { extractSessionId } from '../utils/session.js';

export class GamificationController {
  constructor(gamificationRepo) {
    this.gamificationRepo = gamificationRepo;
  }

  // GET /api/gamification/stats
  getStats = async (request) => {
    const sessionId = extractSessionId(request);
    const stats = await this.gamificationRepo.getStats(sessionId);
    const level = Math.floor(stats.total_xp / 100) + 1;

    return {
      data: {
        xp: {
          total: stats.total_xp,
          level,
          todayEarned: stats.today_xp,
        },
        streak: {
          current: stats.current_streak,
          longest: stats.longest_streak,
        },
        dailyGoal: {
          target: stats.daily_goal,
          completed: stats.today_exercises,
        },
        achievementsEarned: stats.achievements_earned,
      },
    };
  };

  // GET /api/gamification/achievements
  getAchievements = async (request) => {
    const sessionId = extractSessionId(request);
    const achievements =
      await this.gamificationRepo.getAllAchievements(sessionId);

    return {
      data: achievements.map((a) => ({
        id: a.id,
        code: a.code,
        name: a.name,
        nameVi: a.name_vi,
        description: a.description,
        descriptionVi: a.description_vi,
        icon: a.icon,
        category: a.category,
        conditionType: a.condition_type,
        conditionValue: a.condition_value,
        xpReward: a.xp_reward,
        earned: !!a.earned_at,
        earnedAt: a.earned_at,
      })),
    };
  };

  // POST /api/gamification/daily-goal
  updateDailyGoal = async (request) => {
    const sessionId = extractSessionId(request);
    const { target } = request.body || {};
    if (!Number.isInteger(target) || target < 1 || target > 50) {
      throw new ValidationError('Daily goal must be between 1 and 50');
    }

    await this.gamificationRepo.updateDailyGoal(sessionId, target);
    return { data: { success: true, target } };
  };
}
