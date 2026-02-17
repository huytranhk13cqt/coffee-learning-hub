const lessonIdParams = {
  type: 'object',
  properties: {
    lessonId: { type: 'integer', minimum: 1 },
  },
  required: ['lessonId'],
};

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

// Exercises by lesson: GET /api/lessons/:lessonId/exercises, GET /api/lessons/:lessonId/results
export function lessonExerciseRoutes(controller) {
  return async function (fastify) {
    fastify.get(
      '/:lessonId/exercises',
      { schema: { params: lessonIdParams } },
      controller.getByLesson,
    );
    fastify.get(
      '/:lessonId/results',
      { schema: { params: lessonIdParams } },
      controller.getResults,
    );
  };
}

// Submit answer: POST /api/exercises/:exerciseId/submit
export function exerciseSubmitRoutes(controller) {
  return async function (fastify) {
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
