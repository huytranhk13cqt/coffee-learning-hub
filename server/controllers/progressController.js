import { ValidationError } from '../errors/AppError.js';

function extractSessionId(request) {
  const sessionId = request.headers['x-session-id'];
  if (!sessionId || typeof sessionId !== 'string' || sessionId.length > 64) {
    throw new ValidationError('Missing or invalid X-Session-Id header');
  }
  return sessionId;
}

export class ProgressController {
  constructor(progressRepo) {
    this.progressRepo = progressRepo;
  }

  // GET /api/progress/:lessonId
  getProgress = async (request) => {
    const sessionId = extractSessionId(request);
    const lessonId = Number(request.params.lessonId);
    if (!Number.isInteger(lessonId) || lessonId <= 0) {
      throw new ValidationError('Invalid lesson ID');
    }

    const progress = await this.progressRepo.findBySessionAndLesson(sessionId, lessonId);
    return { data: progress };
  };

  // POST /api/progress/:lessonId/theory-complete
  markTheoryComplete = async (request) => {
    const sessionId = extractSessionId(request);
    const lessonId = Number(request.params.lessonId);
    if (!Number.isInteger(lessonId) || lessonId <= 0) {
      throw new ValidationError('Invalid lesson ID');
    }

    const { timeSpent } = request.body || {};
    await this.progressRepo.markTheoryComplete(sessionId, lessonId, timeSpent || 0);
    return { data: { success: true } };
  };

  // POST /api/progress/:lessonId/reset
  resetProgress = async (request) => {
    const sessionId = extractSessionId(request);
    const lessonId = Number(request.params.lessonId);
    if (!Number.isInteger(lessonId) || lessonId <= 0) {
      throw new ValidationError('Invalid lesson ID');
    }

    await this.progressRepo.resetProgress(sessionId, lessonId);
    return { data: { success: true } };
  };
}
