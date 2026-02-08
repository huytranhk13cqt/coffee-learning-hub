import { api } from './client.js';

export async function fetchGroups({ signal } = {}) {
  const { data } = await api.get('/groups', { signal });
  return data;
}
