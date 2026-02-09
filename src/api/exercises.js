import { api } from './client.js';

export async function fetchExercises(lessonId, { signal } = {}) {
  const { data } = await api.get(`/lessons/${lessonId}/exercises`, { signal });
  return data;
}

export async function submitAnswer(exerciseId, body, { signal } = {}) {
  const { data } = await api.post(`/exercises/${exerciseId}/submit`, body, { signal });
  return data;
}

export async function fetchResults(lessonId, { signal } = {}) {
  const { data } = await api.get(`/lessons/${lessonId}/results`, { signal });
  return data;
}
