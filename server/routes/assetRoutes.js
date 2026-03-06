/** Asset Studio routes — all require adminAuth */
export function assetRoutes(controller, adminAuth) {
  return async function (fastify) {
    fastify.addHook('preHandler', adminAuth);

    const idParams = {
      type: 'object',
      required: ['id'],
      properties: { id: { type: 'string', pattern: '^\\d+$' } },
    };

    // ─── Image generation ────────────────────────────────────

    fastify.post('/generate', {
      schema: {
        body: {
          type: 'object',
          required: ['model', 'prompt', 'name'],
          properties: {
            model: { type: 'string' },
            prompt: { type: 'string', minLength: 1 },
            name: { type: 'string', minLength: 1, maxLength: 255 },
            config: {
              type: 'object',
              properties: {
                aspectRatio: { type: 'string' },
                numberOfImages: {
                  type: 'integer',
                  minimum: 1,
                  maximum: 4,
                },
              },
              additionalProperties: false,
            },
          },
        },
      },
      handler: controller.generate,
    });

    // ─── File upload ─────────────────────────────────────────

    fastify.post('/upload', controller.upload);

    // ─── List + CRUD ─────────────────────────────────────────

    fastify.get('/', {
      schema: {
        querystring: {
          type: 'object',
          properties: {
            type: { type: 'string' },
            tag: { type: 'string' },
            page: { type: 'string' },
            limit: { type: 'string' },
          },
        },
      },
      handler: controller.list,
    });

    fastify.get('/:id', {
      schema: { params: idParams },
      handler: controller.get,
    });

    fastify.delete('/:id', {
      schema: { params: idParams },
      handler: controller.remove,
    });

    // ─── Gemini API key management ───────────────────────────

    fastify.post('/gemini/api-key', {
      schema: {
        body: {
          type: 'object',
          required: ['apiKey'],
          properties: {
            apiKey: { type: 'string', minLength: 1 },
          },
        },
      },
      handler: controller.setApiKey,
    });

    fastify.delete('/gemini/api-key', controller.removeApiKey);

    fastify.get('/gemini/api-key', controller.getApiKeyStatus);
  };
}
