/** Protected admin dashboard routes */
export function adminRoutes(controller, adminAuth, adminAuthController) {
  return async function (fastify) {
    // Apply admin auth to all routes in this plugin
    fastify.addHook('preHandler', adminAuth);

    fastify.get('/stats', controller.getStats);
    fastify.get('/activity', controller.getActivity);
    fastify.get('/content-health', controller.getContentHealth);
    fastify.get('/drafts', controller.getDrafts);
    fastify.get('/content-breakdown', controller.getContentBreakdown);

    // Activity Log (paginated)
    fastify.get('/activity-log', controller.listActionLogs);

    // Spaced Repetition aggregate stats
    fastify.get('/review-stats', controller.getReviewStats);

    // Weak Spots aggregate
    fastify.get('/weak-spots-aggregate', controller.getWeakSpots);

    // Settings — password change
    if (adminAuthController) {
      fastify.put('/settings/password', {
        schema: {
          body: {
            type: 'object',
            required: ['currentPassword', 'newPassword'],
            properties: {
              currentPassword: { type: 'string' },
              newPassword: { type: 'string', minLength: 8 },
            },
          },
        },
        handler: adminAuthController.changePassword,
      });
    }
  };
}
