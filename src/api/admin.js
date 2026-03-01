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
