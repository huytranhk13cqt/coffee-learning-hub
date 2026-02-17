import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';
import { ApiError, api } from './client.js';

// Mock getSessionId — always return a valid UUID
vi.mock('../hooks/useSessionId.js', () => ({
  getSessionId: () => '550e8400-e29b-41d4-a716-446655440000',
}));

// --- Helpers ---

function jsonResponse(body, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { 'Content-Type': 'application/json' },
  });
}

function networkError() {
  return new TypeError('Failed to fetch');
}

// Eliminate retry delays so tests run instantly.
// We keep the real setTimeout but override the delay to 0.
const realSetTimeout = globalThis.setTimeout;
function installZeroDelay() {
  vi.spyOn(globalThis, 'setTimeout').mockImplementation((fn, _delay) =>
    realSetTimeout(fn, 0),
  );
}

// --- Tests ---

describe('ApiError', () => {
  it('stores status and data', () => {
    const err = new ApiError('Not found', 404, { detail: 'missing' });
    expect(err.message).toBe('Not found');
    expect(err.status).toBe(404);
    expect(err.data.detail).toBe('missing');
    expect(err.name).toBe('ApiError');
    expect(err).toBeInstanceOf(Error);
  });
});

describe('api.get', () => {
  beforeEach(() => {
    installZeroDelay();
  });
  afterEach(() => {
    vi.restoreAllMocks();
  });

  it('returns JSON on success', async () => {
    vi.spyOn(globalThis, 'fetch').mockResolvedValueOnce(
      jsonResponse({ data: [1, 2, 3] }),
    );

    const result = await api.get('/test');
    expect(result).toEqual({ data: [1, 2, 3] });
    expect(fetch).toHaveBeenCalledTimes(1);
  });

  it('retries on 500 error and succeeds', async () => {
    vi.spyOn(globalThis, 'fetch')
      .mockResolvedValueOnce(jsonResponse({ error: 'Internal' }, 500))
      .mockResolvedValueOnce(jsonResponse({ data: 'ok' }));

    const result = await api.get('/test');
    expect(result).toEqual({ data: 'ok' });
    expect(fetch).toHaveBeenCalledTimes(2);
  });

  it('retries on network error (TypeError) and succeeds', async () => {
    vi.spyOn(globalThis, 'fetch')
      .mockRejectedValueOnce(networkError())
      .mockResolvedValueOnce(jsonResponse({ data: 'recovered' }));

    const result = await api.get('/test');
    expect(result).toEqual({ data: 'recovered' });
    expect(fetch).toHaveBeenCalledTimes(2);
  });

  it('retries up to MAX_GET_RETRIES (2) times then throws', async () => {
    vi.spyOn(globalThis, 'fetch')
      .mockResolvedValueOnce(jsonResponse({ error: 'fail' }, 500))
      .mockResolvedValueOnce(jsonResponse({ error: 'fail' }, 500))
      .mockResolvedValueOnce(jsonResponse({ error: 'fail' }, 500));

    try {
      await api.get('/test');
      expect.unreachable('should have thrown');
    } catch (err) {
      expect(err).toBeInstanceOf(ApiError);
      expect(err.status).toBe(500);
    }
    // 1 initial + 2 retries = 3 total
    expect(fetch).toHaveBeenCalledTimes(3);
  });

  it('does NOT retry on 404 (client error)', async () => {
    vi.spyOn(globalThis, 'fetch').mockResolvedValueOnce(
      jsonResponse({ error: 'Not found' }, 404),
    );

    await expect(api.get('/test')).rejects.toMatchObject({ status: 404 });
    expect(fetch).toHaveBeenCalledTimes(1);
  });

  it('does NOT retry on 400 (client error)', async () => {
    vi.spyOn(globalThis, 'fetch').mockResolvedValueOnce(
      jsonResponse({ error: 'Bad request' }, 400),
    );

    await expect(api.get('/test')).rejects.toMatchObject({ status: 400 });
    expect(fetch).toHaveBeenCalledTimes(1);
  });

  it('respects retries: 0 override', async () => {
    vi.spyOn(globalThis, 'fetch').mockResolvedValueOnce(
      jsonResponse({ error: 'fail' }, 500),
    );

    await expect(api.get('/test', { retries: 0 })).rejects.toMatchObject({
      status: 500,
    });
    expect(fetch).toHaveBeenCalledTimes(1);
  });

  it('stops retrying when signal is aborted', async () => {
    const controller = new AbortController();
    vi.spyOn(globalThis, 'fetch')
      .mockResolvedValueOnce(jsonResponse({ error: 'fail' }, 500))
      .mockResolvedValueOnce(jsonResponse({ data: 'ok' }));

    // Abort before retry fires
    controller.abort();

    try {
      await api.get('/test', { signal: controller.signal, retries: 2 });
      expect.unreachable('should have thrown');
    } catch (err) {
      expect(err).toBeInstanceOf(ApiError);
    }
    // Only 1 attempt — retry skipped because signal aborted
    expect(fetch).toHaveBeenCalledTimes(1);
  });

  it('includes X-Session-Id header', async () => {
    vi.spyOn(globalThis, 'fetch').mockResolvedValueOnce(
      jsonResponse({ data: 'ok' }),
    );

    await api.get('/test');

    const [, options] = fetch.mock.calls[0];
    expect(options.headers['X-Session-Id']).toBe(
      '550e8400-e29b-41d4-a716-446655440000',
    );
  });

  it('calls correct URL with /api prefix', async () => {
    vi.spyOn(globalThis, 'fetch').mockResolvedValueOnce(
      jsonResponse({ data: [] }),
    );

    await api.get('/groups');

    const [url] = fetch.mock.calls[0];
    expect(url).toBe('/api/groups');
  });
});

describe('api.post', () => {
  afterEach(() => {
    vi.restoreAllMocks();
  });

  it('sends JSON body and returns response', async () => {
    vi.spyOn(globalThis, 'fetch').mockResolvedValueOnce(
      jsonResponse({ data: { success: true } }),
    );

    const result = await api.post('/exercises/1/submit', { answer: 'A' });
    expect(result).toEqual({ data: { success: true } });

    const [, options] = fetch.mock.calls[0];
    expect(options.method).toBe('POST');
    expect(options.headers['Content-Type']).toBe('application/json');
    expect(JSON.parse(options.body)).toEqual({ answer: 'A' });
  });

  it('does NOT retry on 500 error', async () => {
    vi.spyOn(globalThis, 'fetch').mockResolvedValueOnce(
      jsonResponse({ error: 'fail' }, 500),
    );

    await expect(
      api.post('/exercises/1/submit', { answer: 'A' }),
    ).rejects.toMatchObject({ status: 500 });
    expect(fetch).toHaveBeenCalledTimes(1);
  });

  it('does NOT retry on network error', async () => {
    vi.spyOn(globalThis, 'fetch').mockRejectedValueOnce(networkError());

    await expect(
      api.post('/exercises/1/submit', { answer: 'A' }),
    ).rejects.toBeInstanceOf(TypeError);
    expect(fetch).toHaveBeenCalledTimes(1);
  });
});
