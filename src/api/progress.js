import { api } from './client.js';

export async function fetchSessionOverview({ signal } = {}) {
  const { data } = await api.get('/progress/session/overview', { signal });
  return data;
}

export async function fetchProgress(lessonId, { signal } = {}) {
  const { data } = await api.get(`/progress/${lessonId}`, { signal });
  return data;
}

export async function markTheoryComplete(lessonId, body, { signal } = {}) {
  const { data } = await api.post(`/progress/${lessonId}/theory-complete`, body, { signal });
  return data;
}

export async function resetProgress(lessonId, { signal } = {}) {
  const { data } = await api.post(`/progress/${lessonId}/reset`, {}, { signal });
  return data;
}
