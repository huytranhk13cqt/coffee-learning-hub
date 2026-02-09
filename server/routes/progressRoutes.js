// Progress: GET/POST /api/progress/:lessonId/*
export function progressRoutes(controller) {
  return async function (fastify) {
    fastify.get('/:lessonId', controller.getProgress);
    fastify.post('/:lessonId/theory-complete', controller.markTheoryComplete);
    fastify.post('/:lessonId/reset', controller.resetProgress);
  };
}
