// Progress: GET/POST /api/progress/*
export function progressRoutes(controller) {
  return async function (fastify) {
    fastify.get('/session/overview', controller.getSessionOverview);
    fastify.get('/:lessonId', controller.getProgress);
    fastify.post('/:lessonId/theory-complete', controller.markTheoryComplete);
    fastify.post('/:lessonId/reset', controller.resetProgress);
  };
}
