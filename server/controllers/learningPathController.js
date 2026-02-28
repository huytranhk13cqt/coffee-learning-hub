import { NotFoundError } from '../errors/AppError.js';
import { extractSessionId } from '../utils/session.js';

export class LearningPathController {
  constructor(learningPathRepo) {
    this.learningPathRepo = learningPathRepo;
  }

  getAll = async (request) => {
    const sessionId = extractSessionId(request);
    const paths = await this.learningPathRepo.findAll(sessionId);
    return { data: paths };
  };

  getBySlug = async (request) => {
    const { slug } = request.params;
    const sessionId = extractSessionId(request);
    const path = await this.learningPathRepo.findBySlug(slug, sessionId);
    if (!path) throw new NotFoundError('Learning path');
    return { data: path };
  };
}
