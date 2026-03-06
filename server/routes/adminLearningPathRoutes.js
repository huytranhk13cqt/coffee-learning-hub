/** Admin Learning Path CRUD routes — all require adminAuth */
export function adminLearningPathRoutes(controller, adminAuth) {
  return async function (fastify) {
    fastify.addHook('preHandler', adminAuth);

    const idParams = {
      type: 'object',
      required: ['id'],
      properties: { id: { type: 'string', pattern: '^\\d+$' } },
    };

    const reorderSchema = {
      body: {
        type: 'object',
        required: ['orderedIds'],
        properties: {
          orderedIds: {
            type: 'array',
            items: { type: 'integer' },
            minItems: 1,
          },
        },
      },
    };

    const hexColorPattern = '^#[0-9A-Fa-f]{6}$';

    // ─── LIST paths ───────────────────────────────────────────

    fastify.get('/paths', controller.listPaths);

    // ─── Available lessons (for step picker) ──────────────────

    fastify.get('/paths/lessons', controller.listLessons);

    // ─── GET path by ID ───────────────────────────────────────

    fastify.get('/paths/:id', {
      schema: { params: idParams },
      handler: controller.getPath,
    });

    // ─── CREATE path ──────────────────────────────────────────

    fastify.post('/paths', {
      schema: {
        body: {
          type: 'object',
          required: ['name', 'name_vi'],
          properties: {
            name: { type: 'string', maxLength: 200 },
            name_vi: { type: 'string', maxLength: 200 },
            slug: { type: 'string', maxLength: 100 },
            description: { type: ['string', 'null'] },
            description_vi: { type: ['string', 'null'] },
            icon: { type: 'string', maxLength: 50 },
            color: { type: 'string', pattern: hexColorPattern },
            estimated_days: { type: 'integer', minimum: 1, maximum: 365 },
            is_featured: { type: 'boolean' },
            is_active: { type: 'boolean' },
          },
        },
      },
      handler: controller.createPath,
    });

    // ─── UPDATE path ──────────────────────────────────────────

    fastify.put('/paths/:id', {
      schema: {
        params: idParams,
        body: {
          type: 'object',
          properties: {
            name: { type: 'string', maxLength: 200 },
            name_vi: { type: 'string', maxLength: 200 },
            slug: { type: 'string', maxLength: 100 },
            description: { type: ['string', 'null'] },
            description_vi: { type: ['string', 'null'] },
            icon: { type: 'string', maxLength: 50 },
            color: { type: 'string', pattern: hexColorPattern },
            estimated_days: { type: 'integer', minimum: 1, maximum: 365 },
            is_featured: { type: 'boolean' },
            is_active: { type: 'boolean' },
          },
        },
      },
      handler: controller.updatePath,
    });

    // ─── DELETE path ──────────────────────────────────────────

    fastify.delete('/paths/:id', {
      schema: { params: idParams },
      handler: controller.deletePath,
    });

    // ─── REORDER paths ────────────────────────────────────────

    fastify.post('/paths/reorder', {
      schema: reorderSchema,
      handler: controller.reorderPaths,
    });

    // ─── REPLACE STEPS ────────────────────────────────────────

    fastify.put('/paths/:id/steps', {
      schema: {
        params: idParams,
        body: {
          type: 'object',
          required: ['steps'],
          properties: {
            steps: {
              type: 'array',
              items: {
                type: 'object',
                required: ['lesson_id'],
                properties: {
                  lesson_id: { type: 'integer' },
                },
              },
              maxItems: 50,
            },
          },
        },
      },
      handler: controller.replaceSteps,
    });

    // ─── TOGGLE ACTIVE ────────────────────────────────────────

    fastify.patch('/paths/:id/toggle-active', {
      schema: { params: idParams },
      handler: controller.toggleActive,
    });
  };
}
