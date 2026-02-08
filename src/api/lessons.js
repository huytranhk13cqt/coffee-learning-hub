import { api } from './client.js';

export async function fetchLesson(slug, { signal } = {}) {
  const { data } = await api.get(`/lessons/${slug}`, { signal });
  return data;
}

export async function fetchLessonsByGroup(groupId, { signal } = {}) {
  const { data } = await api.get(`/groups/${groupId}/lessons`, { signal });
  return data;
}
