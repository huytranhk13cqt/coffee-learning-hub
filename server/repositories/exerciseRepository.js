import { NotFoundError, ValidationError } from '../errors/AppError.js';

export class ExerciseRepository {
  constructor(sql) {
    this.sql = sql;
  }

  // C1: Exercises for a lesson (WITHOUT answers — security boundary)
  async findByLesson(lessonId) {
    return this.sql`
      SELECT
        e.id, e.type, e.difficulty, e.question, e.question_vi,
        e.content, e.content_vi, e.word_bank, e.hint, e.hint_vi,
        e.points, e.time_limit
      FROM exercise e
      WHERE e.lesson_id = ${lessonId} AND e.is_active = TRUE
      ORDER BY e.order_index
    `;
  }

  // C2: Options for all MC exercises in a lesson (WITHOUT is_correct/explanation)
  async findOptionsByLesson(lessonId) {
    return this.sql`
      SELECT
        eo.id, eo.exercise_id, eo.label, eo.content, eo.content_vi
      FROM exercise_option eo
      WHERE eo.exercise_id IN (
        SELECT e.id FROM exercise e
        WHERE e.lesson_id = ${lessonId} AND e.is_active = TRUE
      )
      ORDER BY eo.exercise_id, eo.order_index
    `;
  }

  // C3: Matching pairs for all matching exercises in a lesson
  async findMatchingPairsByLesson(lessonId) {
    return this.sql`
      SELECT
        mp.id, mp.exercise_id, mp.left_content, mp.left_content_vi,
        mp.right_content, mp.right_content_vi
      FROM matching_pair mp
      WHERE mp.exercise_id IN (
        SELECT e.id FROM exercise e
        WHERE e.lesson_id = ${lessonId} AND e.is_active = TRUE
          AND e.type = 'matching'
      )
      ORDER BY mp.exercise_id, mp.order_index
    `;
  }

  // C4a: Get option for validation (includes is_correct + explanation)
  async findOptionForValidation(exerciseId, label) {
    const rows = await this.sql`
      SELECT eo.id, eo.label, eo.is_correct, eo.explanation, eo.explanation_vi
      FROM exercise_option eo
      WHERE eo.exercise_id = ${exerciseId} AND eo.label = ${label}
    `;
    if (!rows.length) throw new NotFoundError('Option');
    return rows[0];
  }

  // C4b: Get correct answer for text-based types
  async findAnswerForValidation(exerciseId) {
    const rows = await this.sql`
      SELECT e.correct_answer, e.explanation, e.explanation_vi
      FROM exercise e
      WHERE e.id = ${exerciseId}
    `;
    if (!rows.length) throw new NotFoundError('Exercise');
    if (rows[0].correct_answer == null) {
      throw new ValidationError('Exercise has no correct answer configured');
    }
    return rows[0];
  }

  // C4c: Get matching pairs for validation (correct pairings)
  async findMatchingPairsForValidation(exerciseId) {
    return this.sql`
      SELECT mp.id, mp.left_content, mp.right_content
      FROM matching_pair mp
      WHERE mp.exercise_id = ${exerciseId}
      ORDER BY mp.order_index
    `;
  }

  // Lookup exercise type + lesson_id by exercise ID
  async findTypeById(exerciseId) {
    const rows = await this.sql`
      SELECT e.id, e.type, e.lesson_id
      FROM exercise e
      WHERE e.id = ${exerciseId} AND e.is_active = TRUE
    `;
    if (!rows.length) throw new NotFoundError('Exercise');
    return rows[0];
  }

  // C6: Results with user attempts (includes answers — only after completion)
  async findResultsByLesson(lessonId, sessionId) {
    return this.sql`
      SELECT
        e.id AS exercise_id, e.type, e.question, e.question_vi,
        e.content, e.correct_answer, e.explanation, e.explanation_vi,
        ea.user_answer, ea.is_correct, ea.time_taken, ea.attempt_number
      FROM exercise e
      LEFT JOIN exercise_attempt ea ON ea.exercise_id = e.id
        AND ea.session_id = ${sessionId}
        AND ea.attempt_number = (
          SELECT MAX(ea2.attempt_number)
          FROM exercise_attempt ea2
          WHERE ea2.session_id = ea.session_id
            AND ea2.exercise_id = ea.exercise_id
        )
      WHERE e.lesson_id = ${lessonId} AND e.is_active = TRUE
      ORDER BY e.order_index
    `;
  }
}
