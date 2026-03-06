export function claudeRoutes(controller, adminAuth) {
  return async function (fastify) {
    fastify.addHook('preHandler', adminAuth);

    fastify.post('/generate', {
      schema: {
        body: {
          type: 'object',
          required: ['model', 'prompt'],
          properties: {
            model: { type: 'string' },
            prompt: { type: 'string', minLength: 1 },
            systemPrompt: { type: 'string' },
            thinking: { type: 'boolean' },
            webSearch: { type: 'boolean' },
            maxTokens: { type: 'integer', minimum: 100, maximum: 128000 },
          },
        },
      },
      handler: controller.generate,
    });
  };
}
