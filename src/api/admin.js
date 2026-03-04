const API_BASE = '/api/admin';

async function adminRequest(endpoint, options = {}) {
  const url = `${API_BASE}${endpoint}`;
  const res = await fetch(url, {
    credentials: 'include',
    headers: { 'Content-Type': 'application/json', ...options.headers },
    ...options,
  });

  const body = await res.json().catch(() => ({}));

  if (!res.ok) {
    const error = new Error(body.error || `Request failed (${res.status})`);
    error.status = res.status;
    throw error;
  }

  return body;
}

export function adminLogin(password) {
  return adminRequest('/login', {
    method: 'POST',
    body: JSON.stringify({ password }),
  });
}

export function adminLogout() {
  return adminRequest('/logout', { method: 'POST' });
}

export function adminVerify() {
  return adminRequest('/verify');
}

export function fetchAdminStats() {
  return adminRequest('/stats');
}

export function fetchAdminActivity(limit = 20) {
  return adminRequest(`/activity?limit=${limit}`);
}

export function fetchAdminContentHealth() {
  return adminRequest('/content-health');
}

export function fetchAdminDrafts() {
  return adminRequest('/drafts');
}

export function fetchAdminContentBreakdown() {
  return adminRequest('/content-breakdown');
}

export async function fetchAdminDashboard() {
  const [stats, activity, health, drafts, breakdown] = await Promise.all([
    fetchAdminStats(),
    fetchAdminActivity(),
    fetchAdminContentHealth(),
    fetchAdminDrafts(),
    fetchAdminContentBreakdown(),
  ]);
  return { stats, activity, health, drafts, breakdown };
}

// ─── TOPICS CRUD ─────────────────────────────────────────────

export function fetchAdminTopics() {
  return adminRequest('/topics');
}

export function createAdminTopic(data) {
  return adminRequest('/topics', {
    method: 'POST',
    body: JSON.stringify(data),
  });
}

export function updateAdminTopic(id, data) {
  return adminRequest(`/topics/${id}`, {
    method: 'PUT',
    body: JSON.stringify(data),
  });
}

export function deleteAdminTopic(id) {
  return adminRequest(`/topics/${id}`, { method: 'DELETE' });
}

export function reorderAdminTopics(orderedIds) {
  return adminRequest('/topics/reorder', {
    method: 'POST',
    body: JSON.stringify({ orderedIds }),
  });
}

// ─── CATEGORIES CRUD ─────────────────────────────────────────

export function fetchAdminCategories(topicId) {
  const qs = topicId ? `?topicId=${topicId}` : '';
  return adminRequest(`/categories${qs}`);
}

export function createAdminCategory(data) {
  return adminRequest('/categories', {
    method: 'POST',
    body: JSON.stringify(data),
  });
}

export function updateAdminCategory(id, data) {
  return adminRequest(`/categories/${id}`, {
    method: 'PUT',
    body: JSON.stringify(data),
  });
}

export function deleteAdminCategory(id) {
  return adminRequest(`/categories/${id}`, { method: 'DELETE' });
}

export function reorderAdminCategories(orderedIds) {
  return adminRequest('/categories/reorder', {
    method: 'POST',
    body: JSON.stringify({ orderedIds }),
  });
}

// ─── LESSONS CRUD ────────────────────────────────────────────

export function fetchAdminLessons({ categoryId, search } = {}) {
  const params = new URLSearchParams();
  if (categoryId) params.set('categoryId', categoryId);
  if (search) params.set('search', search);
  const qs = params.toString();
  return adminRequest(`/lessons${qs ? `?${qs}` : ''}`);
}

export function fetchAdminLesson(id) {
  return adminRequest(`/lessons/${id}`);
}

export function createAdminLesson(data) {
  return adminRequest('/lessons', {
    method: 'POST',
    body: JSON.stringify(data),
  });
}

export function updateAdminLesson(id, data) {
  return adminRequest(`/lessons/${id}`, {
    method: 'PUT',
    body: JSON.stringify(data),
  });
}

export function deleteAdminLesson(id) {
  return adminRequest(`/lessons/${id}`, { method: 'DELETE' });
}

export function reorderAdminLessons(orderedIds) {
  return adminRequest('/lessons/reorder', {
    method: 'POST',
    body: JSON.stringify({ orderedIds }),
  });
}

// ─── SECTIONS CRUD ───────────────────────────────────────────

export function fetchAdminSections(lessonId) {
  return adminRequest(`/lessons/${lessonId}/sections`);
}

export function createAdminSection(lessonId, data) {
  return adminRequest(`/lessons/${lessonId}/sections`, {
    method: 'POST',
    body: JSON.stringify(data),
  });
}

export function updateAdminSection(id, data) {
  return adminRequest(`/sections/${id}`, {
    method: 'PUT',
    body: JSON.stringify(data),
  });
}

export function deleteAdminSection(id) {
  return adminRequest(`/sections/${id}`, { method: 'DELETE' });
}

export function reorderAdminSections(lessonId, orderedIds) {
  return adminRequest(`/lessons/${lessonId}/sections/reorder`, {
    method: 'POST',
    body: JSON.stringify({ orderedIds }),
  });
}

// ─── EXERCISES CRUD ─────────────────────────────────────────

export function fetchAdminExercises({
  lessonId,
  type,
  difficulty,
  search,
} = {}) {
  const params = new URLSearchParams();
  if (lessonId) params.set('lessonId', lessonId);
  if (type) params.set('type', type);
  if (difficulty) params.set('difficulty', difficulty);
  if (search) params.set('search', search);
  const qs = params.toString();
  return adminRequest(`/exercises${qs ? `?${qs}` : ''}`);
}

export function fetchAdminExercise(id) {
  return adminRequest(`/exercises/${id}`);
}

export function createAdminExercise(data) {
  return adminRequest('/exercises', {
    method: 'POST',
    body: JSON.stringify(data),
  });
}

export function updateAdminExercise(id, data) {
  return adminRequest(`/exercises/${id}`, {
    method: 'PUT',
    body: JSON.stringify(data),
  });
}

export function deleteAdminExercise(id) {
  return adminRequest(`/exercises/${id}`, { method: 'DELETE' });
}

export function reorderAdminExercises(lessonId, orderedIds) {
  return adminRequest(`/lessons/${lessonId}/exercises/reorder`, {
    method: 'POST',
    body: JSON.stringify({ orderedIds }),
  });
}
