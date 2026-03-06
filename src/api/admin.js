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

// ─── LEARNING PATHS CRUD ────────────────────────────────────

export function fetchAdminPaths() {
  return adminRequest('/paths');
}

export function fetchAdminPath(id) {
  return adminRequest(`/paths/${id}`);
}

export function createAdminPath(data) {
  return adminRequest('/paths', {
    method: 'POST',
    body: JSON.stringify(data),
  });
}

export function updateAdminPath(id, data) {
  return adminRequest(`/paths/${id}`, {
    method: 'PUT',
    body: JSON.stringify(data),
  });
}

export function deleteAdminPath(id) {
  return adminRequest(`/paths/${id}`, { method: 'DELETE' });
}

export function reorderAdminPaths(orderedIds) {
  return adminRequest('/paths/reorder', {
    method: 'POST',
    body: JSON.stringify({ orderedIds }),
  });
}

export function replaceAdminPathSteps(pathId, steps) {
  return adminRequest(`/paths/${pathId}/steps`, {
    method: 'PUT',
    body: JSON.stringify({ steps }),
  });
}

export function toggleAdminPathActive(id) {
  return adminRequest(`/paths/${id}/toggle-active`, { method: 'PATCH' });
}

// ─── ACTIVITY LOG ───────────────────────────────────────────

export function fetchAdminActivityLog({
  page,
  pageSize,
  action,
  entityType,
  from,
  to,
  search,
} = {}) {
  const params = new URLSearchParams();
  if (page) params.set('page', page);
  if (pageSize) params.set('pageSize', pageSize);
  if (action) params.set('action', action);
  if (entityType) params.set('entityType', entityType);
  if (from) params.set('from', from);
  if (to) params.set('to', to);
  if (search) params.set('search', search);
  const qs = params.toString();
  return adminRequest(`/activity-log${qs ? `?${qs}` : ''}`);
}

// ─── REVIEW STATS ───────────────────────────────────────────

export function fetchAdminReviewStats() {
  return adminRequest('/review-stats');
}

// ─── WEAK SPOTS ─────────────────────────────────────────────

export function fetchAdminWeakSpots({
  minAttempts,
  type,
  lessonId,
  categoryId,
  limit,
} = {}) {
  const params = new URLSearchParams();
  if (minAttempts) params.set('minAttempts', minAttempts);
  if (type) params.set('type', type);
  if (lessonId) params.set('lessonId', lessonId);
  if (categoryId) params.set('categoryId', categoryId);
  if (limit) params.set('limit', limit);
  const qs = params.toString();
  return adminRequest(`/weak-spots-aggregate${qs ? `?${qs}` : ''}`);
}

// ─── SETTINGS ───────────────────────────────────────────────

export function changeAdminPassword(currentPassword, newPassword) {
  return adminRequest('/settings/password', {
    method: 'PUT',
    body: JSON.stringify({ currentPassword, newPassword }),
  });
}

// ─── API KEY MANAGEMENT ─────────────────────────────────────

export function setAdminApiKey(apiKey) {
  return adminRequest('/settings/api-key', {
    method: 'POST',
    body: JSON.stringify({ apiKey }),
  });
}

export function removeAdminApiKey() {
  return adminRequest('/settings/api-key', { method: 'DELETE' });
}

export function fetchApiKeyStatus() {
  return adminRequest('/settings/api-key/status');
}

// ─── CONTENT GENERATION ─────────────────────────────────────

/**
 * Stream content generation via SSE.
 * Uses fetch + ReadableStream (EventSource only supports GET).
 *
 * @param {Object} params - Generation parameters
 * @param {Object} callbacks - { onThinking, onText, onUsage, onDone, onError }
 * @returns {AbortController} - call .abort() to cancel
 */
export function streamGenerate(
  params,
  { onThinking, onText, onUsage, onDone, onError },
) {
  const controller = new AbortController();

  fetch(`${API_BASE}/generate`, {
    method: 'POST',
    credentials: 'include',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(params),
    signal: controller.signal,
  })
    .then(async (response) => {
      if (!response.ok) {
        const body = await response.json().catch(() => ({}));
        onError?.({
          error: body.error || `HTTP ${response.status}`,
          type: 'http_error',
        });
        return;
      }

      const reader = response.body.getReader();
      const decoder = new TextDecoder();
      let buffer = '';

      for (;;) {
        const { done, value } = await reader.read();
        if (done) break;

        buffer += decoder.decode(value, { stream: true });
        const lines = buffer.split('\n');
        buffer = lines.pop();

        let currentEvent = null;
        for (const line of lines) {
          if (line.startsWith('event: ')) {
            currentEvent = line.slice(7);
          } else if (line.startsWith('data: ') && currentEvent) {
            const data = JSON.parse(line.slice(6));
            if (currentEvent === 'thinking') onThinking?.(data);
            else if (currentEvent === 'text') onText?.(data);
            else if (currentEvent === 'usage') onUsage?.(data);
            else if (currentEvent === 'done') onDone?.(data);
            else if (currentEvent === 'error') onError?.(data);
            currentEvent = null;
          } else if (line === '') {
            currentEvent = null;
          }
        }
      }
    })
    .catch((err) => {
      if (err.name !== 'AbortError') {
        onError?.({ error: err.message, type: 'network_error' });
      }
    });

  return controller;
}

// ─── IMAGE PROVIDER API KEY MANAGEMENT ──────────────────────

export function getAllProviderStatus() {
  return adminRequest('/assets/providers');
}

export function setProviderApiKey(provider, apiKey) {
  return adminRequest(`/assets/providers/${provider}/api-key`, {
    method: 'POST',
    body: JSON.stringify({ apiKey }),
  });
}

export function removeProviderApiKey(provider) {
  return adminRequest(`/assets/providers/${provider}/api-key`, {
    method: 'DELETE',
  });
}

export function getProviderApiKeyStatus(provider) {
  return adminRequest(`/assets/providers/${provider}/api-key`);
}

// ─── ASSET CRUD ─────────────────────────────────────────────

export function generateAsset({ model, prompt, name, config }) {
  return adminRequest('/assets/generate', {
    method: 'POST',
    body: JSON.stringify({ model, prompt, name, config }),
  });
}

export async function uploadAsset(formData) {
  const res = await fetch(`${API_BASE}/assets/upload`, {
    method: 'POST',
    body: formData,
    credentials: 'include',
  });
  if (!res.ok) {
    const body = await res.json().catch(() => ({}));
    throw new Error(body.error || `Upload failed (${res.status})`);
  }
  return res.json();
}

export function listAssets({ type, tag, page, limit } = {}) {
  const params = new URLSearchParams();
  if (type) params.set('type', type);
  if (tag) params.set('tag', tag);
  if (page) params.set('page', page);
  if (limit) params.set('limit', limit);
  const qs = params.toString();
  return adminRequest(`/assets${qs ? `?${qs}` : ''}`);
}

export function deleteAsset(id) {
  return adminRequest(`/assets/${id}`, { method: 'DELETE' });
}

// ─── YAML IMPORT ────────────────────────────────────────────

export function validateYamlImport(yamlContent) {
  return adminRequest('/import/validate', {
    method: 'POST',
    body: JSON.stringify({ yaml: yamlContent }),
  });
}

export function executeYamlImport(yamlContent) {
  return adminRequest('/import/execute', {
    method: 'POST',
    body: JSON.stringify({ yaml: yamlContent }),
  });
}
