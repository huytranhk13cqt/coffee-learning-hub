import { api } from './client.js';

export async function fetchGamificationStats({ signal } = {}) {
  const { data } = await api.get('/gamification/stats', { signal });
  return data;
}

export async function fetchAchievements({ signal } = {}) {
  const { data } = await api.get('/gamification/achievements', { signal });
  return data;
}

export async function updateDailyGoal(target, { signal } = {}) {
  const { data } = await api.post(
    '/gamification/daily-goal',
    { target },
    {
      signal,
    },
  );
  return data;
}
