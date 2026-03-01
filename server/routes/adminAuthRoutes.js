/** Auth routes — no admin middleware required */
export function adminAuthRoutes(authController) {
  return async function (fastify) {
    fastify.post('/login', authController.login);
    fastify.post('/logout', authController.logout);
    fastify.get('/verify', authController.verify);
  };
}
