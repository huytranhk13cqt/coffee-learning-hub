/** Protected admin dashboard routes */
export function adminRoutes(controller, adminAuth) {
  return async function (fastify) {
    // Apply admin auth to all routes in this plugin
    fastify.addHook('preHandler', adminAuth);

    fastify.get('/stats', controller.getStats);
    fastify.get('/activity', controller.getActivity);
    fastify.get('/content-health', controller.getContentHealth);
    fastify.get('/drafts', controller.getDrafts);
    fastify.get('/content-breakdown', controller.getContentBreakdown);
  };
}
