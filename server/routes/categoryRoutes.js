export function categoryRoutes(controller) {
  return async function (fastify) {
    fastify.get('/', controller.getAll);
  };
}

export function homeRoutes(controller) {
  return async function (fastify) {
    fastify.get('/', controller.getHomePage);
  };
}
