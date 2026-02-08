export function tenseGroupRoutes(controller) {
  return async function (fastify) {
    fastify.get('/', controller.getAll);
  };
}
