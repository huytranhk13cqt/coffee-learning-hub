import { ValidationError } from '../errors/AppError.js';
import { slugify } from '../utils/slugify.js';

export class AdminLearningPathController {
  constructor(adminLearningPathRepo, adminRepo) {
    this.repo = adminLearningPathRepo;
    this.adminRepo = adminRepo;
  }

  listPaths = async () => {
    const data = await this.repo.findAll();
    return { data };
  };

  getPath = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.findById(id);
    return { data };
  };

  createPath = async (request) => {
    const body = { ...request.body };
    if (!body.slug) body.slug = slugify(body.name);
    const data = await this.repo.create(body);
    this.adminRepo.logAction({
      action: 'create',
      entityType: 'learning_path',
      entityId: data.id,
      metadata: { name: data.name, slug: data.slug },
      ipAddress: request.ip,
    });
    return { data };
  };

  updatePath = async (request) => {
    const id = parseInt(request.params.id, 10);
    const body = { ...request.body };
    if (body.name && !body.slug) body.slug = slugify(body.name);
    const data = await this.repo.update(id, body);
    this.adminRepo.logAction({
      action: 'update',
      entityType: 'learning_path',
      entityId: id,
      metadata: { fields: Object.keys(request.body) },
      ipAddress: request.ip,
    });
    return { data };
  };

  deletePath = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.delete(id);
    this.adminRepo.logAction({
      action: 'delete',
      entityType: 'learning_path',
      entityId: id,
      ipAddress: request.ip,
    });
    return { data };
  };

  reorderPaths = async (request) => {
    const { orderedIds } = request.body;
    if (!Array.isArray(orderedIds) || orderedIds.length === 0) {
      throw new ValidationError('orderedIds must be a non-empty array');
    }
    await this.repo.reorder(orderedIds);
    this.adminRepo.logAction({
      action: 'reorder',
      entityType: 'learning_path',
      metadata: { orderedIds },
      ipAddress: request.ip,
    });
    return { data: { ok: true } };
  };

  replaceSteps = async (request) => {
    const pathId = parseInt(request.params.id, 10);
    const { steps } = request.body;
    if (!Array.isArray(steps)) {
      throw new ValidationError('steps must be an array');
    }
    const data = await this.repo.replaceSteps(pathId, steps);
    this.adminRepo.logAction({
      action: 'update',
      entityType: 'learning_path',
      entityId: pathId,
      metadata: { action: 'replace_steps', stepCount: steps.length },
      ipAddress: request.ip,
    });
    return { data: { steps: data } };
  };

  toggleActive = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.toggleActive(id);
    this.adminRepo.logAction({
      action: 'toggle_active',
      entityType: 'learning_path',
      entityId: id,
      metadata: { is_active: data.is_active },
      ipAddress: request.ip,
    });
    return { data };
  };

  listLessons = async () => {
    const data = await this.repo.findAllLessons();
    return { data };
  };
}
