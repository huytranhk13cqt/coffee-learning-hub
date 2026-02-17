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

const DEFAULT_TIMEOUT = 30_000;

async function request(endpoint, { headers, timeout, ...options } = {}) {
  const url = `${API_BASE}${endpoint}`;

  // Combine external signal (React Router) with timeout signal
  const signals = [];
  if (options.signal) signals.push(options.signal);
  if (timeout !== 0) {
    signals.push(AbortSignal.timeout(timeout || DEFAULT_TIMEOUT));
  }
  const signal =
    signals.length > 1 ? AbortSignal.any(signals) : signals[0] || undefined;

  // Only set Content-Type for requests with a body
  const reqHeaders = { 'X-Session-Id': getSessionId(), ...headers };
  if (options.body) reqHeaders['Content-Type'] = 'application/json';

  try {
    const res = await fetch(url, {
      ...options,
      signal,
      headers: reqHeaders,
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
  } catch (err) {
    if (err instanceof ApiError) throw err;
    if (err.name === 'AbortError' || err.name === 'TimeoutError') {
      throw new ApiError('Request timeout', 408);
    }
    throw err;
  }
}

export const api = {
  get: (endpoint, opts) => request(endpoint, { method: 'GET', ...opts }),

  post: (endpoint, body, opts) =>
    request(endpoint, { method: 'POST', body: JSON.stringify(body), ...opts }),
};
