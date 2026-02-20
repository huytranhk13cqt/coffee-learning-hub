import { api } from './client.js';

export async function fetchBookmarks({ signal } = {}) {
  const { data } = await api.get('/bookmarks', { signal });
  return data;
}

export async function checkBookmark(params, { signal } = {}) {
  const { lessonId, sectionType, sectionId } = params;
  let url = `/bookmarks/check?lessonId=${lessonId}`;
  if (sectionType) url += `&sectionType=${sectionType}`;
  if (sectionId) url += `&sectionId=${sectionId}`;

  const { data } = await api.get(url, { signal });
  return data.isBookmarked;
}

export async function addBookmark(body, { signal } = {}) {
  const { data } = await api.post('/bookmarks', body, { signal });
  return data;
}

export async function removeBookmark(params, { signal } = {}) {
  const { lessonId, sectionType, sectionId } = params;
  let url = `/bookmarks?lessonId=${lessonId}`;
  if (sectionType) url += `&sectionType=${sectionType}`;
  if (sectionId) url += `&sectionId=${sectionId}`;

  await api.delete(url, { signal });
}

export async function removeBookmarkById(id, { signal } = {}) {
  await api.delete(`/bookmarks/${id}`, { signal });
}
