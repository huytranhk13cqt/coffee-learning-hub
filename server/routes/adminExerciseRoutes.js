/** Admin Exercise CRUD routes — all require adminAuth */
export function adminExerciseRoutes(controller, adminAuth) {
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

    const exerciseTypes = [
      'multiple_choice',
      'fill_blank',
      'error_correction',
      'sentence_transform',
      'arrange_words',
      'matching',
      'true_false',
      'code_output',
    ];

    const difficulties = ['easy', 'medium', 'hard'];

    const optionSchema = {
      type: 'object',
      required: ['label', 'content'],
      properties: {
        label: { type: 'string', enum: ['A', 'B', 'C', 'D', 'E', 'F'] },
        content: { type: 'string', maxLength: 500 },
        content_vi: { type: ['string', 'null'], maxLength: 500 },
        is_correct: { type: 'boolean' },
        explanation: { type: ['string', 'null'] },
        explanation_vi: { type: ['string', 'null'] },
      },
    };

    const pairSchema = {
      type: 'object',
      required: ['left_content', 'right_content'],
      properties: {
        left_content: { type: 'string', maxLength: 300 },
        left_content_vi: { type: ['string', 'null'], maxLength: 300 },
        right_content: { type: 'string', maxLength: 300 },
        right_content_vi: { type: ['string', 'null'], maxLength: 300 },
      },
    };

    // ─── LIST exercises ─────────────────────────────────────

    fastify.get('/exercises', controller.listExercises);

    // ─── GET exercise by ID ─────────────────────────────────

    fastify.get('/exercises/:id', {
      schema: { params: idParams },
      handler: controller.getExercise,
    });

    // ─── CREATE exercise ────────────────────────────────────

    fastify.post('/exercises', {
      schema: {
        body: {
          type: 'object',
          required: ['lesson_id', 'type', 'question'],
          properties: {
            lesson_id: { type: 'integer' },
            type: { type: 'string', enum: exerciseTypes },
            difficulty: { type: 'string', enum: difficulties },
            question: { type: 'string' },
            question_vi: { type: ['string', 'null'] },
            content: { type: ['string', 'null'] },
            content_vi: { type: ['string', 'null'] },
            context: { type: ['string', 'null'] },
            context_vi: { type: ['string', 'null'] },
            correct_answer: { type: ['string', 'null'], maxLength: 500 },
            word_bank: {
              type: ['array', 'null'],
              items: { type: 'string' },
            },
            explanation: { type: ['string', 'null'] },
            explanation_vi: { type: ['string', 'null'] },
            hint: { type: ['string', 'null'], maxLength: 255 },
            hint_vi: { type: ['string', 'null'], maxLength: 255 },
            image_url: { type: ['string', 'null'], maxLength: 500 },
            audio_url: { type: ['string', 'null'], maxLength: 500 },
            points: { type: 'integer', minimum: 1, maximum: 100 },
            time_limit: { type: ['integer', 'null'], minimum: 1 },
            is_active: { type: 'boolean' },
            options: {
              type: 'array',
              items: optionSchema,
              maxItems: 6,
            },
            matching_pairs: {
              type: 'array',
              items: pairSchema,
              maxItems: 10,
            },
          },
        },
      },
      handler: controller.createExercise,
    });

    // ─── UPDATE exercise ────────────────────────────────────

    fastify.put('/exercises/:id', {
      schema: {
        params: idParams,
        body: {
          type: 'object',
          properties: {
            lesson_id: { type: 'integer' },
            type: { type: 'string', enum: exerciseTypes },
            difficulty: { type: 'string', enum: difficulties },
            question: { type: 'string' },
            question_vi: { type: ['string', 'null'] },
            content: { type: ['string', 'null'] },
            content_vi: { type: ['string', 'null'] },
            context: { type: ['string', 'null'] },
            context_vi: { type: ['string', 'null'] },
            correct_answer: { type: ['string', 'null'], maxLength: 500 },
            word_bank: {
              type: ['array', 'null'],
              items: { type: 'string' },
            },
            explanation: { type: ['string', 'null'] },
            explanation_vi: { type: ['string', 'null'] },
            hint: { type: ['string', 'null'], maxLength: 255 },
            hint_vi: { type: ['string', 'null'], maxLength: 255 },
            image_url: { type: ['string', 'null'], maxLength: 500 },
            audio_url: { type: ['string', 'null'], maxLength: 500 },
            points: { type: 'integer', minimum: 1, maximum: 100 },
            time_limit: { type: ['integer', 'null'], minimum: 1 },
            is_active: { type: 'boolean' },
            options: {
              type: 'array',
              items: optionSchema,
              maxItems: 6,
            },
            matching_pairs: {
              type: 'array',
              items: pairSchema,
              maxItems: 10,
            },
          },
        },
      },
      handler: controller.updateExercise,
    });

    // ─── DELETE exercise ────────────────────────────────────

    fastify.delete('/exercises/:id', {
      schema: { params: idParams },
      handler: controller.deleteExercise,
    });

    // ─── REORDER exercises ──────────────────────────────────

    fastify.post('/lessons/:lessonId/exercises/reorder', {
      schema: {
        params: lessonIdParams,
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
      },
      handler: controller.reorderExercises,
    });
  };
}
