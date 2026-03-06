/** Asset Studio routes — all require adminAuth */
export function assetRoutes(controller, adminAuth) {
  return async function (fastify) {
    fastify.addHook('preHandler', adminAuth);

    const idParams = {
      type: 'object',
      required: ['id'],
      properties: { id: { type: 'string', pattern: '^\\d+$' } },
    };

    const providerParams = {
      type: 'object',
      required: ['provider'],
      properties: {
        provider: {
          type: 'string',
          enum: ['gemini', 'openai', 'stability'],
        },
      },
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
                size: { type: 'string' },
                quality: { type: 'string' },
                negativePrompt: { type: 'string' },
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

    // ─── Provider API key management ─────────────────────────

    fastify.get('/providers', controller.getProviders);

    fastify.post('/providers/:provider/api-key', {
      schema: {
        params: providerParams,
        body: {
          type: 'object',
          required: ['apiKey'],
          properties: {
            apiKey: { type: 'string', minLength: 1 },
          },
        },
      },
      handler: controller.setProviderApiKey,
    });

    fastify.delete('/providers/:provider/api-key', {
      schema: { params: providerParams },
      handler: controller.removeProviderApiKey,
    });

    fastify.get('/providers/:provider/api-key', {
      schema: { params: providerParams },
      handler: controller.getProviderApiKeyStatus,
    });
  };
}
