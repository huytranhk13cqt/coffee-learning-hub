import { ValidationError, UnauthorizedError } from '../errors/AppError.js';

export class AdminAuthController {
  constructor(adminPassword, adminRepo, claudeService) {
    this.adminPassword = adminPassword;
    this.adminRepo = adminRepo;
    this.claudeService = claudeService;
  }

  /**
   * POST /api/admin/login
   * Validates password, signs JWT, sets HttpOnly cookie.
   */
  login = async (request, reply) => {
    const { password } = request.body || {};
    if (!password) throw new ValidationError('Password is required');
    if (password !== this.adminPassword)
      throw new UnauthorizedError('Invalid password');

    const token = await reply.jwtSign({ role: 'admin' }, { expiresIn: '365d' });

    reply
      .setCookie('admin_token', token, {
        path: '/',
        httpOnly: true,
        sameSite: 'lax',
        secure: process.env.NODE_ENV === 'production',
        maxAge: 365 * 24 * 60 * 60,
      })
      .send({ success: true });

    // Log login action (fire-and-forget)
    this.adminRepo.logAction({
      action: 'login',
      entityType: 'admin',
      ipAddress: request.ip,
    });
  };

  /**
   * POST /api/admin/logout
   * Clears the admin_token cookie.
   */
  logout = async (_request, reply) => {
    reply.clearCookie('admin_token', { path: '/' }).send({ success: true });
  };

  /**
   * GET /api/admin/verify
   * Returns { authenticated: true/false } — never throws 401.
   */
  verify = async (request, reply) => {
    const token = request.cookies?.admin_token;
    if (!token) return reply.send({ authenticated: false });

    try {
      await request.jwtVerify({ onlyCookie: true });
      return reply.send({ authenticated: true });
    } catch {
      return reply.send({ authenticated: false });
    }
  };

  /**
   * PUT /api/admin/settings/password
   * Changes the admin password (runtime-only, resets on server restart).
   */
  changePassword = async (request) => {
    const { currentPassword, newPassword } = request.body || {};
    if (!currentPassword || !newPassword) {
      throw new ValidationError('currentPassword and newPassword are required');
    }
    if (currentPassword !== this.adminPassword) {
      throw new UnauthorizedError('Current password is incorrect');
    }
    if (newPassword.length < 8) {
      throw new ValidationError('New password must be at least 8 characters');
    }
    // Update in-memory password
    this.adminPassword = newPassword;

    this.adminRepo.logAction({
      action: 'update',
      entityType: 'admin',
      metadata: { action: 'password_change' },
      ipAddress: request.ip,
    });

    return {
      success: true,
      warning:
        'Password changed for this server session only. Update ADMIN_PASSWORD env var for persistence.',
    };
  };

  /** POST /api/admin/settings/api-key -- Store Claude API key */
  setApiKey = async (request) => {
    const { apiKey } = request.body || {};
    if (!apiKey?.trim()) throw new ValidationError('apiKey is required');

    this.claudeService.setApiKey(apiKey.trim());

    this.adminRepo.logAction({
      action: 'update',
      entityType: 'admin',
      metadata: { action: 'api_key_set' },
      ipAddress: request.ip,
    });

    return { success: true, message: 'API key configured' };
  };

  /** DELETE /api/admin/settings/api-key -- Remove Claude API key */
  removeApiKey = async (request) => {
    this.claudeService.removeApiKey();

    this.adminRepo.logAction({
      action: 'update',
      entityType: 'admin',
      metadata: { action: 'api_key_removed' },
      ipAddress: request.ip,
    });

    return { success: true, message: 'API key removed' };
  };

  /** GET /api/admin/settings/api-key/status -- Check if key is configured */
  getApiKeyStatus = async () => {
    return {
      configured: this.claudeService.isConfigured(),
      maskedKey: this.claudeService.getMaskedKey(),
    };
  };
}
