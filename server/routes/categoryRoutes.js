export function categoryRoutes(controller) {
  return async function (fastify) {
    fastify.get('/', controller.getAll);
  };
}
