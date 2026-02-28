const exerciseIdParams = {
  type: 'object',
  properties: {
    exerciseId: { type: 'integer', minimum: 1 },
  },
  required: ['exerciseId'],
};

const submitBody = {
  type: 'object',
  required: ['answer'],
  properties: {
    answer: {},
    timeTaken: { type: 'integer', minimum: 0, nullable: true },
  },
};

export function reviewRoutes(controller) {
  return async function plugin(fastify) {
    fastify.get('/due', controller.getDue);
    fastify.get('/stats', controller.getStats);
    fastify.post(
      '/:exerciseId/submit',
      {
        schema: { params: exerciseIdParams, body: submitBody },
        config: {
          rateLimit: {
            max: 20,
            timeWindow: '1 minute',
            keyGenerator: (req) => req.headers['x-session-id'] || req.ip,
          },
        },
      },
      controller.submit,
    );
  };
}
