export function lessonRoutes(controller) {
  return async function (fastify) {
    fastify.get('/:slug', controller.getBySlug);
  };
}

export function groupLessonRoutes(controller) {
  return async function (fastify) {
    fastify.get('/:groupId/lessons', controller.getByGroup);
  };
}
