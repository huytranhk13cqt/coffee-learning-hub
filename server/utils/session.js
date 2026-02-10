import { ValidationError } from '../errors/AppError.js';

export function extractSessionId(request) {
  const sessionId = request.headers['x-session-id'];
  if (!sessionId || typeof sessionId !== 'string' || sessionId.length > 64) {
    throw new ValidationError('Missing or invalid X-Session-Id header');
  }
  return sessionId;
}
