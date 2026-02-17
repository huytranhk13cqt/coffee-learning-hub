import { useState, useCallback } from 'react';
import { GamificationContext } from './gamificationContext.js';

/**
 * Provides gamification stats (XP, streak, daily goal) to the entire app.
 *
 * Initialized from root loader data, then updated incrementally
 * when exercise submissions return gamification results.
 */
export default function GamificationProvider({ initialStats, children }) {
  const [stats, setStats] = useState(initialStats);

  const updateFromSubmit = useCallback((gamification) => {
    if (!gamification) return;
    setStats((prev) => {
      if (!prev) return prev;
      return {
        ...prev,
        xp: {
          total: gamification.totalXP,
          level: gamification.level,
          todayEarned: (prev.xp?.todayEarned ?? 0) + gamification.xpEarned,
        },
        streak: {
          ...prev.streak,
          current: gamification.streak,
        },
        dailyGoal: {
          ...prev.dailyGoal,
          completed: (prev.dailyGoal?.completed ?? 0) + 1,
        },
      };
    });
  }, []);

  const refreshStats = useCallback((newStats) => {
    setStats(newStats);
  }, []);

  return (
    <GamificationContext.Provider
      value={{ stats, updateFromSubmit, refreshStats }}
    >
      {children}
    </GamificationContext.Provider>
  );
}
