import { randomUUID } from 'node:crypto';
import { writeFile, unlink, mkdir } from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { ValidationError } from '../errors/AppError.js';
import { GEMINI_MODELS } from '../services/geminiService.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const SPRITES_DIR = path.join(__dirname, '..', 'uploads', 'sprites');

const ALLOWED_MIME = new Set(['image/png', 'image/gif', 'image/webp']);
const MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB

// Map mime to extension
const MIME_EXT = {
  'image/png': '.png',
  'image/gif': '.gif',
  'image/webp': '.webp',
};

export class AssetController {
  constructor(assetRepo, geminiService, adminRepo) {
    this.assetRepo = assetRepo;
    this.geminiService = geminiService;
    this.adminRepo = adminRepo;
  }

  /**
   * POST /api/admin/assets/generate
   * Generate image via Gemini AI and save as asset.
   */
  generate = async (request) => {
    if (!this.geminiService.isConfigured()) {
      throw new ValidationError(
        'Gemini API key not configured. Set it in Settings.',
      );
    }

    const { model, prompt, name, config } = request.body;

    if (!GEMINI_MODELS[model]) {
      throw new ValidationError(
        `Invalid model. Must be one of: ${Object.keys(GEMINI_MODELS).join(', ')}`,
      );
    }
    if (!prompt?.trim()) throw new ValidationError('prompt is required');
    if (!name?.trim()) throw new ValidationError('name is required');

    const result = await this.geminiService.generate(
      model,
      prompt.trim(),
      config || {},
    );

    if (!result.images.length) {
      throw new ValidationError('No images generated. Try a different prompt.');
    }

    // Save each generated image as an asset
    const assets = [];
    for (let i = 0; i < result.images.length; i++) {
      const img = result.images[i];
      const ext = MIME_EXT[img.mimeType] || '.png';
      const filename = `${Date.now()}-${randomUUID().slice(0, 8)}${ext}`;
      const filePath = path.join(SPRITES_DIR, filename);

      const buffer = Buffer.from(img.data, 'base64');

      await mkdir(SPRITES_DIR, { recursive: true });
      await writeFile(filePath, buffer);

      const asset = await this.assetRepo.create({
        name:
          result.images.length > 1 ? `${name.trim()}-${i + 1}` : name.trim(),
        type: 'sprite',
        path: `/sprites/${filename}`,
        width: null,
        height: null,
        frameCount: 1,
        tags: [],
        prompt: prompt.trim(),
        model,
        fileSize: buffer.length,
      });

      assets.push(asset);
    }

    // Fire-and-forget audit log
    this.adminRepo.logAction({
      action: 'generate',
      entityType: 'asset',
      metadata: { model, prompt: prompt.trim(), count: assets.length },
      ipAddress: request.ip,
    });

    return { assets, text: result.text || '' };
  };

  /**
   * POST /api/admin/assets/upload
   * Upload an image file as an asset (multipart/form-data).
   */
  upload = async (request) => {
    const data = await request.file();
    if (!data) throw new ValidationError('No file uploaded');

    if (!ALLOWED_MIME.has(data.mimetype)) {
      throw new ValidationError(
        `Invalid file type: ${data.mimetype}. Allowed: png, gif, webp`,
      );
    }

    // Consume the file stream into a buffer
    const chunks = [];
    for await (const chunk of data.file) {
      chunks.push(chunk);
    }
    const buffer = Buffer.concat(chunks);

    if (buffer.length > MAX_FILE_SIZE) {
      throw new ValidationError('File too large. Maximum size is 5MB.');
    }

    const ext = MIME_EXT[data.mimetype] || '.png';
    const filename = `${Date.now()}-${randomUUID().slice(0, 8)}${ext}`;
    const filePath = path.join(SPRITES_DIR, filename);

    await mkdir(SPRITES_DIR, { recursive: true });
    await writeFile(filePath, buffer);

    // Parse optional fields from multipart
    const fields = data.fields;
    const name = (fields.name?.value || data.filename || 'untitled').slice(
      0,
      255,
    );
    const type = (fields.type?.value || 'sprite').slice(0, 50);
    const tags = fields.tags?.value
      ? fields.tags.value
          .split(',')
          .map((t) => t.trim())
          .filter(Boolean)
      : [];

    const asset = await this.assetRepo.create({
      name,
      type,
      path: `/sprites/${filename}`,
      width: null,
      height: null,
      frameCount: 1,
      tags,
      prompt: null,
      model: null,
      fileSize: buffer.length,
    });

    this.adminRepo.logAction({
      action: 'upload',
      entityType: 'asset',
      metadata: { filename, size: buffer.length },
      ipAddress: request.ip,
    });

    return asset;
  };

  /**
   * GET /api/admin/assets
   * List assets with optional filters + pagination.
   */
  list = async (request) => {
    const { type, tag, page = '1', limit = '20' } = request.query;
    const pageNum = Math.max(1, parseInt(page, 10) || 1);
    const limitNum = Math.min(100, Math.max(1, parseInt(limit, 10) || 20));
    const offset = (pageNum - 1) * limitNum;

    const { rows, total } = await this.assetRepo.findAll({
      type,
      tag,
      limit: limitNum,
      offset,
    });

    return {
      assets: rows,
      total,
      page: pageNum,
      limit: limitNum,
      totalPages: Math.ceil(total / limitNum),
    };
  };

  /**
   * GET /api/admin/assets/:id
   */
  get = async (request) => {
    const asset = await this.assetRepo.findById(request.params.id);
    return asset;
  };

  /**
   * DELETE /api/admin/assets/:id
   */
  remove = async (request) => {
    const { path: assetPath } = await this.assetRepo.remove(request.params.id);

    // Delete file from filesystem (best-effort)
    const fullPath = path.join(SPRITES_DIR, '..', '..', assetPath);
    try {
      await unlink(fullPath);
    } catch {
      // File may already be deleted — not critical
    }

    this.adminRepo.logAction({
      action: 'delete',
      entityType: 'asset',
      metadata: { id: request.params.id, path: assetPath },
      ipAddress: request.ip,
    });

    return { success: true };
  };

  /**
   * POST /api/admin/assets/gemini/api-key
   */
  setApiKey = async (request) => {
    const { apiKey } = request.body || {};
    if (!apiKey?.trim()) throw new ValidationError('apiKey is required');

    this.geminiService.setApiKey(apiKey.trim());

    this.adminRepo.logAction({
      action: 'update',
      entityType: 'admin',
      metadata: { action: 'gemini_api_key_set' },
      ipAddress: request.ip,
    });

    return { success: true, message: 'Gemini API key configured' };
  };

  /**
   * DELETE /api/admin/assets/gemini/api-key
   */
  removeApiKey = async (request) => {
    this.geminiService.removeApiKey();

    this.adminRepo.logAction({
      action: 'update',
      entityType: 'admin',
      metadata: { action: 'gemini_api_key_removed' },
      ipAddress: request.ip,
    });

    return { success: true, message: 'Gemini API key removed' };
  };

  /**
   * GET /api/admin/assets/gemini/api-key
   */
  getApiKeyStatus = async () => {
    return {
      configured: this.geminiService.isConfigured(),
      maskedKey: this.geminiService.getMaskedKey(),
    };
  };
}
