const slugParams = {
  type: 'object',
  properties: {
    slug: { type: 'string', minLength: 1, maxLength: 128 },
  },
  required: ['slug'],
};

const groupIdParams = {
  type: 'object',
  properties: {
    groupId: { type: 'integer', minimum: 1 },
  },
  required: ['groupId'],
};

const searchQuery = {
  type: 'object',
  properties: {
    q: { type: 'string', maxLength: 128 },
  },
};

export function lessonRoutes(controller) {
  return async function (fastify) {
    fastify.get(
      '/search',
      { schema: { querystring: searchQuery } },
      controller.search,
    );
    fastify.get(
      '/:slug',
      { schema: { params: slugParams } },
      controller.getBySlug,
    );
  };
}

export function groupLessonRoutes(controller) {
  return async function (fastify) {
    fastify.get(
      '/:groupId/lessons',
      { schema: { params: groupIdParams } },
      controller.getByGroup,
    );
  };
}
