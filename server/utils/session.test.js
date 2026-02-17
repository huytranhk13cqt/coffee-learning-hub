import { describe, it, expect } from 'vitest';
import { extractSessionId, tryExtractSessionId } from './session.js';

const validUUID = '550e8400-e29b-41d4-a716-446655440000';

function fakeRequest(sessionId) {
  return { headers: { 'x-session-id': sessionId } };
}

describe('extractSessionId', () => {
  it('returns a valid UUID session ID', () => {
    expect(extractSessionId(fakeRequest(validUUID))).toBe(validUUID);
  });

  it('accepts uppercase UUID', () => {
    const upper = validUUID.toUpperCase();
    expect(extractSessionId(fakeRequest(upper))).toBe(upper);
  });

  it('throws for missing header', () => {
    expect(() => extractSessionId({ headers: {} })).toThrow(
      'Missing or invalid X-Session-Id',
    );
  });

  it('throws for empty string', () => {
    expect(() => extractSessionId(fakeRequest(''))).toThrow(
      'Missing or invalid X-Session-Id',
    );
  });

  it('throws for non-UUID string', () => {
    expect(() => extractSessionId(fakeRequest('not-a-uuid'))).toThrow(
      'Missing or invalid X-Session-Id',
    );
  });

  it('throws for UUID without hyphens', () => {
    expect(() =>
      extractSessionId(fakeRequest('550e8400e29b41d4a716446655440000')),
    ).toThrow('Missing or invalid X-Session-Id');
  });

  it('throws for SQL injection attempt', () => {
    expect(() =>
      extractSessionId(fakeRequest("'; DROP TABLE users; --")),
    ).toThrow('Missing or invalid X-Session-Id');
  });

  it('throws for overly long input', () => {
    expect(() => extractSessionId(fakeRequest('a'.repeat(200)))).toThrow(
      'Missing or invalid X-Session-Id',
    );
  });
});

describe('tryExtractSessionId', () => {
  it('returns valid UUID', () => {
    expect(tryExtractSessionId(fakeRequest(validUUID))).toBe(validUUID);
  });

  it('returns null for missing header', () => {
    expect(tryExtractSessionId({ headers: {} })).toBeNull();
  });

  it('returns null for invalid UUID', () => {
    expect(tryExtractSessionId(fakeRequest('not-a-uuid'))).toBeNull();
  });

  it('returns null for empty string', () => {
    expect(tryExtractSessionId(fakeRequest(''))).toBeNull();
  });
});
