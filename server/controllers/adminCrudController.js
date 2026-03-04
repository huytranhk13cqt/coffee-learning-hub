import { ValidationError } from '../errors/AppError.js';
import { slugify } from '../utils/slugify.js';

export class AdminCrudController {
  constructor(adminCrudRepo, adminRepo) {
    this.repo = adminCrudRepo;
    this.adminRepo = adminRepo; // for audit logging
  }

  // ─── TOPICS ──────────────────────────────────────────────

  listTopics = async () => {
    const data = await this.repo.findAllTopics();
    return { data };
  };

  createTopic = async (request) => {
    const data = await this.repo.createTopic(request.body);
    this.adminRepo.logAction({
      action: 'create',
      entityType: 'topic',
      entityId: data.id,
      metadata: { name: data.name },
      ipAddress: request.ip,
    });
    return { data };
  };

  updateTopic = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.updateTopic(id, request.body);
    this.adminRepo.logAction({
      action: 'update',
      entityType: 'topic',
      entityId: id,
      metadata: { fields: Object.keys(request.body) },
      ipAddress: request.ip,
    });
    return { data };
  };

  deleteTopic = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.deleteTopic(id);
    this.adminRepo.logAction({
      action: 'delete',
      entityType: 'topic',
      entityId: id,
      ipAddress: request.ip,
    });
    return { data };
  };

  reorderTopics = async (request) => {
    const { orderedIds } = request.body;
    if (!Array.isArray(orderedIds) || orderedIds.length === 0) {
      throw new ValidationError('orderedIds must be a non-empty array');
    }
    await this.repo.reorderTopics(orderedIds);
    this.adminRepo.logAction({
      action: 'reorder',
      entityType: 'topic',
      metadata: { orderedIds },
      ipAddress: request.ip,
    });
    return { data: { ok: true } };
  };

  // ─── CATEGORIES ──────────────────────────────────────────

  listCategories = async (request) => {
    const topicId = request.query.topicId
      ? parseInt(request.query.topicId, 10)
      : null;
    const data = await this.repo.findAllCategories(topicId);
    return { data };
  };

  createCategory = async (request) => {
    const data = await this.repo.createCategory(request.body);
    this.adminRepo.logAction({
      action: 'create',
      entityType: 'category',
      entityId: data.id,
      metadata: { name: data.name },
      ipAddress: request.ip,
    });
    return { data };
  };

  updateCategory = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.updateCategory(id, request.body);
    this.adminRepo.logAction({
      action: 'update',
      entityType: 'category',
      entityId: id,
      metadata: { fields: Object.keys(request.body) },
      ipAddress: request.ip,
    });
    return { data };
  };

  deleteCategory = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.deleteCategory(id);
    this.adminRepo.logAction({
      action: 'delete',
      entityType: 'category',
      entityId: id,
      ipAddress: request.ip,
    });
    return { data };
  };

  reorderCategories = async (request) => {
    const { orderedIds } = request.body;
    if (!Array.isArray(orderedIds) || orderedIds.length === 0) {
      throw new ValidationError('orderedIds must be a non-empty array');
    }
    await this.repo.reorderCategories(orderedIds);
    this.adminRepo.logAction({
      action: 'reorder',
      entityType: 'category',
      metadata: { orderedIds },
      ipAddress: request.ip,
    });
    return { data: { ok: true } };
  };

  // ─── LESSONS ─────────────────────────────────────────────

  listLessons = async (request) => {
    const categoryId = request.query.categoryId
      ? parseInt(request.query.categoryId, 10)
      : null;
    const search = request.query.search?.trim() || null;
    const data = await this.repo.findAllLessons({ categoryId, search });
    return { data };
  };

  getLessonById = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.findLessonById(id);
    return { data };
  };

  createLesson = async (request) => {
    const body = { ...request.body };
    // Auto-generate slug from name if not provided
    if (!body.slug) {
      body.slug = slugify(body.name);
    }
    const data = await this.repo.createLesson(body);
    this.adminRepo.logAction({
      action: 'create',
      entityType: 'lesson',
      entityId: data.id,
      metadata: { name: data.name, slug: data.slug },
      ipAddress: request.ip,
    });
    return { data };
  };

  updateLesson = async (request) => {
    const id = parseInt(request.params.id, 10);
    const body = { ...request.body };
    // Re-generate slug if name changed and slug not explicitly provided
    if (body.name && !body.slug) {
      body.slug = slugify(body.name);
    }
    const data = await this.repo.updateLesson(id, body);
    this.adminRepo.logAction({
      action: 'update',
      entityType: 'lesson',
      entityId: id,
      metadata: { fields: Object.keys(request.body) },
      ipAddress: request.ip,
    });
    return { data };
  };

  deleteLesson = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.deleteLesson(id);
    this.adminRepo.logAction({
      action: 'delete',
      entityType: 'lesson',
      entityId: id,
      ipAddress: request.ip,
    });
    return { data };
  };

  reorderLessons = async (request) => {
    const { orderedIds } = request.body;
    if (!Array.isArray(orderedIds) || orderedIds.length === 0) {
      throw new ValidationError('orderedIds must be a non-empty array');
    }
    await this.repo.reorderLessons(orderedIds);
    this.adminRepo.logAction({
      action: 'reorder',
      entityType: 'lesson',
      metadata: { orderedIds },
      ipAddress: request.ip,
    });
    return { data: { ok: true } };
  };

  // ─── SECTIONS ────────────────────────────────────────────

  listSections = async (request) => {
    const lessonId = parseInt(request.params.lessonId, 10);
    const data = await this.repo.findSectionsByLesson(lessonId);
    return { data };
  };

  createSection = async (request) => {
    const lessonId = parseInt(request.params.lessonId, 10);
    const data = await this.repo.createSection(lessonId, request.body);
    this.adminRepo.logAction({
      action: 'create',
      entityType: 'section',
      entityId: data.id,
      metadata: { lessonId, type: data.type },
      ipAddress: request.ip,
    });
    return { data };
  };

  updateSection = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.updateSection(id, request.body);
    this.adminRepo.logAction({
      action: 'update',
      entityType: 'section',
      entityId: id,
      metadata: { fields: Object.keys(request.body) },
      ipAddress: request.ip,
    });
    return { data };
  };

  deleteSection = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.deleteSection(id);
    this.adminRepo.logAction({
      action: 'delete',
      entityType: 'section',
      entityId: id,
      ipAddress: request.ip,
    });
    return { data };
  };

  reorderSections = async (request) => {
    const lessonId = parseInt(request.params.lessonId, 10);
    const { orderedIds } = request.body;
    if (!Array.isArray(orderedIds) || orderedIds.length === 0) {
      throw new ValidationError('orderedIds must be a non-empty array');
    }
    await this.repo.reorderSections(lessonId, orderedIds);
    this.adminRepo.logAction({
      action: 'reorder',
      entityType: 'section',
      metadata: { lessonId, orderedIds },
      ipAddress: request.ip,
    });
    return { data: { ok: true } };
  };
}
