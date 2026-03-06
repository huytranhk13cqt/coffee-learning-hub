export function yamlImportRoutes(controller, adminAuth) {
  return async function (fastify) {
    fastify.addHook('preHandler', adminAuth);

    const bodySchema = {
      type: 'object',
      required: ['yaml'],
      properties: {
        yaml: { type: 'string', minLength: 1 },
      },
    };

    fastify.post('/import/validate', {
      schema: { body: bodySchema },
      handler: controller.validate,
    });

    fastify.post('/import/execute', {
      schema: { body: bodySchema },
      handler: controller.execute,
    });
  };
}
