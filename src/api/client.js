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

  // Timeout: create internal abort if none provided, or chain with external signal
  let timeoutId;
  let signal = options.signal;
  if (!signal && timeout !== 0) {
    const controller = new AbortController();
    signal = controller.signal;
    timeoutId = setTimeout(
      () => controller.abort(),
      timeout || DEFAULT_TIMEOUT,
    );
  }

  try {
    const res = await fetch(url, {
      ...options,
      signal,
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
  } catch (err) {
    if (err instanceof ApiError) throw err;
    if (err.name === 'AbortError' && !options.signal) {
      throw new ApiError('Request timeout', 408);
    }
    throw err;
  } finally {
    clearTimeout(timeoutId);
  }
}

export const api = {
  get: (endpoint, opts) => request(endpoint, { method: 'GET', ...opts }),

  post: (endpoint, body, opts) =>
    request(endpoint, { method: 'POST', body: JSON.stringify(body), ...opts }),
};
