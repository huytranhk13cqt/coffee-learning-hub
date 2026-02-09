import { getSessionId } from '../hooks/useSessionId.js';

const API_BASE = '/api';

export class ApiError extends Error {
  constructor(message, status, data) {
    super(message);
    this.name = 'ApiError';
    this.status = status;
    this.data = data;
  }
}

async function request(endpoint, { headers, ...options } = {}) {
  const url = `${API_BASE}${endpoint}`;

  const res = await fetch(url, {
    ...options,
    headers: {
      'Content-Type': 'application/json',
      'X-Session-Id': getSessionId(),
      ...headers,
    },
  });

  if (!res.ok) {
    const body = await res.json().catch(() => ({}));
    throw new ApiError(
      body.error || `Request failed (${res.status})`,
      res.status,
      body,
    );
  }

  return res.json();
}

export const api = {
  get: (endpoint, opts) => request(endpoint, { method: 'GET', ...opts }),

  post: (endpoint, body, opts) =>
    request(endpoint, { method: 'POST', body: JSON.stringify(body), ...opts }),

  put: (endpoint, body, opts) =>
    request(endpoint, { method: 'PUT', body: JSON.stringify(body), ...opts }),

  delete: (endpoint, opts) => request(endpoint, { method: 'DELETE', ...opts }),
};
