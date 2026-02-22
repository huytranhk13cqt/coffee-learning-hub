import { useState, useCallback } from 'react';
import { GamificationContext } from './gamificationContext.js';
import { updateDailyGoal } from '../api/gamification.js';

/**
 * Provides gamification stats (XP, streak, daily goal) to the entire app.
 *
 * Initialized from root loader data, then updated incrementally
 * when exercise submissions return gamification results.
 */
export default function GamificationProvider({ initialStats, children }) {
  const [stats, setStats] = useState(initialStats);
  const [isDailyGoalDialogOpen, setIsDailyGoalDialogOpen] = useState(false);

  const openDailyGoalDialog = useCallback(
    () => setIsDailyGoalDialogOpen(true),
    [],
  );
  const closeDailyGoalDialog = useCallback(
    () => setIsDailyGoalDialogOpen(false),
    [],
  );

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

  /**
   * Optimistically updates the daily goal target, then persists to the server.
   * On failure, rolls back to the previous state and re-throws so callers
   * can show an error message.
   */
  const updateDailyGoalTarget = useCallback(
    async (target) => {
      const snapshot = stats;
      setStats((prev) => {
        if (!prev) return prev;
        return { ...prev, dailyGoal: { ...prev.dailyGoal, target } };
      });
      try {
        await updateDailyGoal(target);
      } catch (err) {
        setStats(snapshot);
        throw err;
      }
    },
    [stats],
  );

  return (
    <GamificationContext.Provider
      value={{
        stats,
        updateFromSubmit,
        refreshStats,
        updateDailyGoalTarget,
        isDailyGoalDialogOpen,
        openDailyGoalDialog,
        closeDailyGoalDialog,
      }}
    >
      {children}
    </GamificationContext.Provider>
  );
}
