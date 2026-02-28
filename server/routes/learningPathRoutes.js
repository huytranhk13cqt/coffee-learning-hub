const slugParams = {
  type: 'object',
  properties: {
    slug: { type: 'string', minLength: 1, maxLength: 128 },
  },
  required: ['slug'],
};

export function learningPathRoutes(controller) {
  return async function (fastify) {
    fastify.get('/', controller.getAll);
    fastify.get(
      '/:slug',
      { schema: { params: slugParams } },
      controller.getBySlug,
    );
  };
}
