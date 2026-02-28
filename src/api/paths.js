import { api } from './client.js';

export async function fetchPaths({ signal } = {}) {
  const { data } = await api.get('/paths', { signal });
  return data;
}

export async function fetchPath(slug, { signal } = {}) {
  const { data } = await api.get(`/paths/${slug}`, { signal });
  return data;
}
