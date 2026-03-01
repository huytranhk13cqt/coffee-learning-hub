import { ValidationError, UnauthorizedError } from '../errors/AppError.js';

export class AdminAuthController {
  constructor(adminPassword, adminRepo) {
    this.adminPassword = adminPassword;
    this.adminRepo = adminRepo;
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
}
