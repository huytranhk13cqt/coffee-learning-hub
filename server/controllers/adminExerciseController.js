import { ValidationError } from '../errors/AppError.js';

export class AdminExerciseController {
  constructor(adminExerciseRepo, adminRepo) {
    this.repo = adminExerciseRepo;
    this.adminRepo = adminRepo; // for audit logging
  }

  listExercises = async (request) => {
    const lessonId = request.query.lessonId
      ? parseInt(request.query.lessonId, 10)
      : null;
    const type = request.query.type || null;
    const difficulty = request.query.difficulty || null;
    const search = request.query.search?.trim() || null;
    const data = await this.repo.findAll({
      lessonId,
      type,
      difficulty,
      search,
    });
    return { data };
  };

  getExercise = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.findById(id);
    return { data };
  };

  createExercise = async (request) => {
    const data = await this.repo.create(request.body);
    this.adminRepo.logAction({
      action: 'create',
      entityType: 'exercise',
      entityId: data.id,
      metadata: { type: data.type, lessonId: data.lesson_id },
      ipAddress: request.ip,
    });
    return { data };
  };

  updateExercise = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.update(id, request.body);
    this.adminRepo.logAction({
      action: 'update',
      entityType: 'exercise',
      entityId: id,
      metadata: { fields: Object.keys(request.body) },
      ipAddress: request.ip,
    });
    return { data };
  };

  deleteExercise = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.delete(id);
    this.adminRepo.logAction({
      action: 'delete',
      entityType: 'exercise',
      entityId: id,
      ipAddress: request.ip,
    });
    return { data };
  };

  reorderExercises = async (request) => {
    const lessonId = parseInt(request.params.lessonId, 10);
    const { orderedIds } = request.body;
    if (!Array.isArray(orderedIds) || orderedIds.length === 0) {
      throw new ValidationError('orderedIds must be a non-empty array');
    }
    await this.repo.reorder(lessonId, orderedIds);
    this.adminRepo.logAction({
      action: 'reorder',
      entityType: 'exercise',
      metadata: { lessonId, orderedIds },
      ipAddress: request.ip,
    });
    return { data: { ok: true } };
  };
}
