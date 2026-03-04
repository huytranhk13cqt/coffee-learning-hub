/** Admin CRUD routes — all require adminAuth */
export function adminCrudRoutes(controller, adminAuth) {
  return async function (fastify) {
    fastify.addHook('preHandler', adminAuth);

    // ─── Shared schemas ─────────────────────────────────────

    const idParams = {
      type: 'object',
      required: ['id'],
      properties: { id: { type: 'string', pattern: '^\\d+$' } },
    };

    const lessonIdParams = {
      type: 'object',
      required: ['lessonId'],
      properties: { lessonId: { type: 'string', pattern: '^\\d+$' } },
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

    // ─── TOPIC routes ───────────────────────────────────────

    fastify.get('/topics', controller.listTopics);

    fastify.post('/topics', {
      schema: {
        body: {
          type: 'object',
          required: ['name', 'name_vi', 'color'],
          properties: {
            name: { type: 'string', maxLength: 100 },
            name_vi: { type: 'string', maxLength: 100 },
            description: { type: 'string' },
            description_vi: { type: 'string' },
            icon: { type: 'string', maxLength: 50 },
            color: { type: 'string', pattern: hexColorPattern },
          },
        },
      },
      handler: controller.createTopic,
    });

    fastify.put('/topics/:id', {
      schema: {
        params: idParams,
        body: {
          type: 'object',
          properties: {
            name: { type: 'string', maxLength: 100 },
            name_vi: { type: 'string', maxLength: 100 },
            description: { type: ['string', 'null'] },
            description_vi: { type: ['string', 'null'] },
            icon: { type: ['string', 'null'], maxLength: 50 },
            color: { type: 'string', pattern: hexColorPattern },
          },
        },
      },
      handler: controller.updateTopic,
    });

    fastify.delete('/topics/:id', {
      schema: { params: idParams },
      handler: controller.deleteTopic,
    });

    fastify.post('/topics/reorder', {
      schema: reorderSchema,
      handler: controller.reorderTopics,
    });

    // ─── CATEGORY routes ────────────────────────────────────

    fastify.get('/categories', controller.listCategories);

    fastify.post('/categories', {
      schema: {
        body: {
          type: 'object',
          required: ['name', 'name_vi', 'color'],
          properties: {
            name: { type: 'string', maxLength: 100 },
            name_vi: { type: 'string', maxLength: 100 },
            description: { type: 'string' },
            description_vi: { type: 'string' },
            icon: { type: 'string', maxLength: 50 },
            color: { type: 'string', pattern: hexColorPattern },
            topic_id: { type: ['integer', 'null'] },
          },
        },
      },
      handler: controller.createCategory,
    });

    fastify.put('/categories/:id', {
      schema: {
        params: idParams,
        body: {
          type: 'object',
          properties: {
            name: { type: 'string', maxLength: 100 },
            name_vi: { type: 'string', maxLength: 100 },
            description: { type: ['string', 'null'] },
            description_vi: { type: ['string', 'null'] },
            icon: { type: ['string', 'null'], maxLength: 50 },
            color: { type: 'string', pattern: hexColorPattern },
            topic_id: { type: ['integer', 'null'] },
          },
        },
      },
      handler: controller.updateCategory,
    });

    fastify.delete('/categories/:id', {
      schema: { params: idParams },
      handler: controller.deleteCategory,
    });

    fastify.post('/categories/reorder', {
      schema: reorderSchema,
      handler: controller.reorderCategories,
    });

    // ─── LESSON routes ──────────────────────────────────────

    fastify.get('/lessons', controller.listLessons);

    fastify.get('/lessons/:id', {
      schema: { params: idParams },
      handler: controller.getLessonById,
    });

    fastify.post('/lessons', {
      schema: {
        body: {
          type: 'object',
          required: ['name', 'name_vi', 'group_id'],
          properties: {
            name: { type: 'string', maxLength: 100 },
            name_vi: { type: 'string', maxLength: 100 },
            slug: { type: 'string', maxLength: 100 },
            short_desc: { type: 'string', maxLength: 255 },
            short_desc_vi: { type: 'string', maxLength: 255 },
            description: { type: 'string' },
            description_vi: { type: 'string' },
            group_id: { type: 'integer' },
            difficulty: {
              type: 'string',
              enum: ['beginner', 'intermediate', 'advanced'],
            },
            estimated_time: { type: ['integer', 'null'], minimum: 0 },
            is_published: { type: 'boolean' },
          },
        },
      },
      handler: controller.createLesson,
    });

    fastify.put('/lessons/:id', {
      schema: {
        params: idParams,
        body: {
          type: 'object',
          properties: {
            name: { type: 'string', maxLength: 100 },
            name_vi: { type: 'string', maxLength: 100 },
            slug: { type: 'string', maxLength: 100 },
            short_desc: { type: ['string', 'null'], maxLength: 255 },
            short_desc_vi: { type: ['string', 'null'], maxLength: 255 },
            description: { type: ['string', 'null'] },
            description_vi: { type: ['string', 'null'] },
            group_id: { type: 'integer' },
            difficulty: {
              type: 'string',
              enum: ['beginner', 'intermediate', 'advanced'],
            },
            estimated_time: { type: ['integer', 'null'], minimum: 0 },
            is_published: { type: 'boolean' },
          },
        },
      },
      handler: controller.updateLesson,
    });

    fastify.delete('/lessons/:id', {
      schema: { params: idParams },
      handler: controller.deleteLesson,
    });

    fastify.post('/lessons/reorder', {
      schema: reorderSchema,
      handler: controller.reorderLessons,
    });

    // ─── SECTION routes ─────────────────────────────────────

    const sectionTypes = [
      'markdown',
      'key_points',
      'info_box',
      'audio',
      'video',
      'chart',
      'diagram',
      'image',
      'interactive_chart',
    ];

    fastify.get('/lessons/:lessonId/sections', {
      schema: { params: lessonIdParams },
      handler: controller.listSections,
    });

    fastify.post('/lessons/:lessonId/sections', {
      schema: {
        params: lessonIdParams,
        body: {
          type: 'object',
          required: ['type'],
          properties: {
            type: { type: 'string', enum: sectionTypes },
            title: { type: 'string', maxLength: 255 },
            title_vi: { type: 'string', maxLength: 255 },
            content: { type: ['string', 'null'] },
            content_vi: { type: ['string', 'null'] },
            metadata: { type: 'object' },
          },
        },
      },
      handler: controller.createSection,
    });

    fastify.put('/sections/:id', {
      schema: {
        params: idParams,
        body: {
          type: 'object',
          properties: {
            type: { type: 'string', enum: sectionTypes },
            title: { type: ['string', 'null'], maxLength: 255 },
            title_vi: { type: ['string', 'null'], maxLength: 255 },
            content: { type: ['string', 'null'] },
            content_vi: { type: ['string', 'null'] },
            metadata: { type: 'object' },
          },
        },
      },
      handler: controller.updateSection,
    });

    fastify.delete('/sections/:id', {
      schema: { params: idParams },
      handler: controller.deleteSection,
    });

    fastify.post('/lessons/:lessonId/sections/reorder', {
      schema: {
        params: lessonIdParams,
        ...reorderSchema,
      },
      handler: controller.reorderSections,
    });
  };
}
