import { UnauthorizedError } from '../errors/AppError.js';

/**
 * Factory: creates an admin auth preHandler hook.
 * Usage in routes: { preHandler: [adminAuth] }
 *
 * @param {import('fastify').FastifyInstance} fastify — needed for fastify.jwt.verify
 */
export function createAdminAuth(_fastify) {
  return async function adminAuth(request) {
    const token = request.cookies?.admin_token;
    if (!token) throw new UnauthorizedError();

    try {
      await request.jwtVerify({ onlyCookie: true });
    } catch {
      throw new UnauthorizedError();
    }
  };
}
