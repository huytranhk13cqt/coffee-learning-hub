const dailyGoalBody = {
  type: 'object',
  required: ['target'],
  properties: {
    target: { type: 'integer', minimum: 1, maximum: 50 },
  },
};

export function gamificationRoutes(controller) {
  return async function (fastify) {
    fastify.get('/stats', controller.getStats);
    fastify.get('/achievements', controller.getAchievements);
    fastify.post(
      '/daily-goal',
      { schema: { body: dailyGoalBody } },
      controller.updateDailyGoal,
    );
  };
}
