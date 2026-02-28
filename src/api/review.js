import { api } from './client.js';

export async function fetchDueReviews({ signal } = {}) {
  const { data, stats } = await api.get('/review/due', { signal });
  return { exercises: data, stats };
}

export async function fetchReviewStats({ signal } = {}) {
  const { data } = await api.get('/review/stats', { signal });
  return data;
}

export async function submitReview(exerciseId, body, { signal } = {}) {
  const { data } = await api.post(`/review/${exerciseId}/submit`, body, {
    signal,
  });
  return data;
}
