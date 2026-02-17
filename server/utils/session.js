import { ValidationError } from '../errors/AppError.js';

const UUID_RE =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

export function extractSessionId(request) {
  const sessionId = request.headers['x-session-id'];
  if (!sessionId || typeof sessionId !== 'string' || !UUID_RE.test(sessionId)) {
    throw new ValidationError('Missing or invalid X-Session-Id header');
  }
  return sessionId;
}
