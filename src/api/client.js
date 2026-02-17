import { getSessionId } from '../hooks/useSessionId.js';

const API_BASE = '/api';
const DEFAULT_TIMEOUT = 30_000;
const MAX_GET_RETRIES = 2;
const RETRY_BASE_DELAY = 500;

export class ApiError extends Error {
  constructor(message, status, data) {
    super(message);
    this.name = 'ApiError';
    this.status = status;
    this.data = data;
  }
}

function isRetryable(err) {
  if (err.name === 'AbortError' || err.name === 'TimeoutError') return false;
  if (err instanceof ApiError) return err.status >= 500;
  return err instanceof TypeError; // network failure
}

function jitteredDelay(attempt) {
  return RETRY_BASE_DELAY * 2 ** attempt + Math.random() * RETRY_BASE_DELAY;
}

async function withRetry(fn, { maxRetries = 0, signal } = {}) {
  let lastErr;
  for (let attempt = 0; attempt <= maxRetries; attempt++) {
    try {
      return await fn();
    } catch (err) {
      lastErr = err;
      if (attempt < maxRetries && isRetryable(err) && !signal?.aborted) {
        await new Promise((r) => setTimeout(r, jitteredDelay(attempt)));
        continue;
      }
      throw err;
    }
  }
  throw lastErr;
}

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
  get: (endpoint, { retries, ...opts } = {}) =>
    withRetry(() => request(endpoint, { method: 'GET', ...opts }), {
      maxRetries: retries ?? MAX_GET_RETRIES,
      signal: opts?.signal,
    }),

  post: (endpoint, body, opts) =>
    request(endpoint, { method: 'POST', body: JSON.stringify(body), ...opts }),
};
