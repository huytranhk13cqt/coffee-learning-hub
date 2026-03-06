import yaml from 'js-yaml';
import {
  validateLesson,
  validateLearningPath,
} from '../../scripts/lesson-schema.js';
import { ValidationError, NotFoundError } from '../errors/AppError.js';

export class YamlImportController {
  constructor(sql, adminRepo) {
    this.sql = sql;
    this.adminRepo = adminRepo;
  }

  /** POST /api/admin/import/validate -- parse + validate YAML (dry run) */
  validate = async (request) => {
    const { yaml: yamlString } = request.body;
    if (!yamlString?.trim())
      throw new ValidationError('yaml content is required');

    const data = this.#parseYaml(yamlString);
    const type = data.type === 'learning_path' ? 'learning_path' : 'lesson';

    const errors =
      type === 'learning_path'
        ? validateLearningPath(data)
        : validateLesson(data);

    if (errors.length > 0) {
      return { valid: false, type, summary: null, errors };
    }

    const summary =
      type === 'learning_path'
        ? {
            slug: data.slug,
            name: data.name,
            name_vi: data.name_vi,
            steps: data.steps?.length || 0,
          }
        : {
            slug: data.slug,
            name: data.name,
            name_vi: data.name_vi,
            category: data.category,
            sections: data.sections?.length || 0,
            exercises: data.exercises?.length || 0,
          };

    return { valid: true, type, summary, errors: [] };
  };

  /** POST /api/admin/import/execute -- actually import into DB */
  execute = async (request) => {
    const { yaml: yamlString } = request.body;
    if (!yamlString?.trim())
      throw new ValidationError('yaml content is required');

    const data = this.#parseYaml(yamlString);
    const type = data.type === 'learning_path' ? 'learning_path' : 'lesson';

    const errors =
      type === 'learning_path'
        ? validateLearningPath(data)
        : validateLesson(data);

    if (errors.length > 0) {
      throw new ValidationError(`Validation failed: ${errors[0]}`);
    }

    const result =
      type === 'learning_path'
        ? await this.#importLearningPath(data)
        : await this.#importLesson(data);

    // Fire-and-forget audit log
    this.adminRepo.logAction({
      action: 'create',
      entityType: type,
      entityId: result.id,
      metadata: { slug: result.slug, via: 'yaml_import' },
      ipAddress: request.ip,
    });

    return { success: true, type, ...result };
  };

  #parseYaml(yamlString) {
    try {
      const data = yaml.load(yamlString);
      if (!data || typeof data !== 'object') {
        throw new ValidationError('Invalid YAML: must be an object');
      }
      return data;
    } catch (err) {
      if (err instanceof ValidationError) throw err;
      throw new ValidationError(`YAML parse error: ${err.message}`);
    }
  }

  async #importLesson(data) {
    const sql = this.sql;

    const [category] =
      await sql`SELECT id FROM category WHERE name = ${data.category}`;
    if (!category) throw new NotFoundError(`Category "${data.category}"`);

    let lessonId;
    let stats = { usages: 0, sections: 0, exercises: 0 };

    await sql.begin(async (tx) => {
      const [lesson] = await tx`
        INSERT INTO lesson (slug, group_id, name, name_vi, difficulty, estimated_time, order_index, is_published)
        VALUES (
          ${data.slug}, ${category.id}, ${data.name}, ${data.name_vi},
          ${data.difficulty}, ${data.estimated_time}, ${data.order_index},
          ${data.is_published !== false}
        )
        ON CONFLICT (slug) DO UPDATE SET
          group_id = EXCLUDED.group_id, name = EXCLUDED.name, name_vi = EXCLUDED.name_vi,
          difficulty = EXCLUDED.difficulty, estimated_time = EXCLUDED.estimated_time,
          order_index = EXCLUDED.order_index, is_published = EXCLUDED.is_published
        RETURNING id
      `;
      lessonId = lesson.id;

      await tx`DELETE FROM lesson_usage WHERE lesson_id = ${lessonId}`;
      await tx`DELETE FROM lesson_section WHERE lesson_id = ${lessonId}`;
      await tx`DELETE FROM exercise WHERE lesson_id = ${lessonId}`;

      const usages = data.usages || [];
      for (let i = 0; i < usages.length; i++) {
        const u = usages[i];
        await tx`
          INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index)
          VALUES (${lessonId}, ${u.title}, ${u.title_vi || null}, ${u.description}, ${u.description_vi || null}, ${i})
        `;
      }

      const sections = data.sections || [];
      for (let i = 0; i < sections.length; i++) {
        const s = sections[i];
        await tx`
          INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index)
          VALUES (${lessonId}, ${s.type}, ${s.title || null}, ${s.title_vi || null},
            ${s.content || null}, ${s.content_vi || null}, ${JSON.stringify(s.metadata || {})}, ${i})
        `;
      }

      const exercises = data.exercises || [];
      for (let i = 0; i < exercises.length; i++) {
        const ex = exercises[i];
        const [inserted] = await tx`
          INSERT INTO exercise (
            lesson_id, type, difficulty, question, question_vi,
            correct_answer, word_bank, explanation, explanation_vi,
            points, time_limit, order_index, is_active
          ) VALUES (
            ${lessonId}, ${ex.type}, ${ex.difficulty}, ${ex.question}, ${ex.question_vi || null},
            ${ex.correct_answer || null}, ${ex.word_bank ? JSON.stringify(ex.word_bank) : null},
            ${ex.explanation || null}, ${ex.explanation_vi || null},
            ${ex.points || 10}, ${ex.time_limit || null}, ${i}, ${ex.is_active !== false}
          ) RETURNING id
        `;

        if (ex.type === 'multiple_choice' && Array.isArray(ex.options)) {
          const labels = ['A', 'B', 'C', 'D', 'E', 'F'];
          for (let j = 0; j < ex.options.length; j++) {
            const opt = ex.options[j];
            await tx`
              INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, explanation, explanation_vi, order_index)
              VALUES (${inserted.id}, ${opt.label || labels[j]}, ${opt.content}, ${opt.content_vi || null},
                ${opt.is_correct === true}, ${opt.explanation || null}, ${opt.explanation_vi || null}, ${j})
            `;
          }
        }
      }

      stats = {
        usages: usages.length,
        sections: sections.length,
        exercises: exercises.length,
      };
    });

    return { slug: data.slug, id: lessonId, stats };
  }

  async #importLearningPath(data) {
    const sql = this.sql;
    let pathId;

    await sql.begin(async (tx) => {
      const [path] = await tx`
        INSERT INTO learning_path (slug, name, name_vi, description, description_vi, icon, color, estimated_days, is_featured, order_index)
        VALUES (
          ${data.slug}, ${data.name}, ${data.name_vi},
          ${data.description || null}, ${data.description_vi || null},
          ${data.icon || null}, ${data.color || '#6366f1'},
          ${data.estimated_days || null}, ${data.is_featured === true}, ${data.order_index || 0}
        )
        ON CONFLICT (slug) DO UPDATE SET
          name = EXCLUDED.name, name_vi = EXCLUDED.name_vi,
          description = EXCLUDED.description, description_vi = EXCLUDED.description_vi,
          icon = EXCLUDED.icon, color = EXCLUDED.color,
          estimated_days = EXCLUDED.estimated_days, is_featured = EXCLUDED.is_featured,
          order_index = EXCLUDED.order_index
        RETURNING id
      `;
      pathId = path.id;

      await tx`DELETE FROM learning_path_step WHERE path_id = ${pathId}`;

      for (let i = 0; i < data.steps.length; i++) {
        const step = data.steps[i];
        const [lesson] =
          await tx`SELECT id FROM lesson WHERE slug = ${step.lesson}`;
        if (!lesson)
          throw new Error(
            `Lesson slug not found: "${step.lesson}" (step ${i})`,
          );
        await tx`
          INSERT INTO learning_path_step (path_id, lesson_id, order_index)
          VALUES (${pathId}, ${lesson.id}, ${i})
        `;
      }
    });

    return { slug: data.slug, id: pathId, stats: { steps: data.steps.length } };
  }
}
