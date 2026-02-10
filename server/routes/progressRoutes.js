const lessonIdParams = {
  type: 'object',
  properties: {
    lessonId: { type: 'integer', minimum: 1 },
  },
  required: ['lessonId'],
};

const theoryCompleteBody = {
  type: 'object',
  properties: {
    timeSpent: { type: 'integer', minimum: 0, nullable: true },
  },
};

// Progress: GET/POST /api/progress/*
export function progressRoutes(controller) {
  return async function (fastify) {
    fastify.get('/session/dashboard', controller.getDashboard);
    fastify.get('/session/overview', controller.getSessionOverview);
    fastify.get(
      '/:lessonId',
      { schema: { params: lessonIdParams } },
      controller.getProgress,
    );
    fastify.post(
      '/:lessonId/theory-complete',
      { schema: { params: lessonIdParams, body: theoryCompleteBody } },
      controller.markTheoryComplete,
    );
    fastify.post(
      '/:lessonId/reset',
      { schema: { params: lessonIdParams } },
      controller.resetProgress,
    );
  };
}
