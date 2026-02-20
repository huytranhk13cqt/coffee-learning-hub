const bookmarkBody = {
  type: 'object',
  required: ['lessonId'],
  properties: {
    lessonId: { type: 'integer' },
    sectionType: { type: 'string', nullable: true },
    sectionId: { type: 'integer', nullable: true },
    note: { type: 'string', nullable: true },
  },
};

export function bookmarkRoutes(controller) {
  return async function (fastify) {
    fastify.get('/', controller.getAll);
    fastify.get('/check', controller.check);
    fastify.post('/', { schema: { body: bookmarkBody } }, controller.add);
    fastify.delete('/', controller.remove);
    fastify.delete('/:id', controller.removeById);
  };
}
