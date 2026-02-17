import { ValidationError } from '../errors/AppError.js';
import {
  validateAnswerShape,
  validateAnswer,
} from '../services/answerValidator.js';
import { extractSessionId } from '../utils/session.js';
import { groupBy, shuffle } from '../utils/collections.js';

export class ExerciseController {
  constructor(exerciseRepo, progressRepo, sql) {
    this.exerciseRepo = exerciseRepo;
    this.progressRepo = progressRepo;
    this.sql = sql;
  }

  // GET /api/lessons/:lessonId/exercises
  getByLesson = async (request) => {
    const lessonId = Number(request.params.lessonId);
    if (!Number.isInteger(lessonId) || lessonId <= 0) {
      throw new ValidationError('Invalid lesson ID');
    }

    // BFF: parallel fetch exercises + options + matching pairs
    const [exercises, options, matchingPairs] = await Promise.all([
      this.exerciseRepo.findByLesson(lessonId),
      this.exerciseRepo.findOptionsByLesson(lessonId),
      this.exerciseRepo.findMatchingPairsByLesson(lessonId),
    ]);

    // Nest options under their exercises
    const optionsByExercise = groupBy(options, (o) => o.exercise_id);
    const pairsByExercise = groupBy(matchingPairs, (p) => p.exercise_id);

    const data = exercises.map((ex) => {
      const result = { ...ex };

      if (ex.type === 'multiple_choice') {
        result.options = optionsByExercise.get(ex.id) || [];
      }

      if (ex.type === 'matching') {
        const pairs = pairsByExercise.get(ex.id) || [];
        // Send left items in order, but shuffle right items
        result.leftItems = pairs.map((p) => ({
          id: p.id,
          content: p.left_content,
          contentVi: p.left_content_vi,
        }));
        result.rightItems = shuffle(
          pairs.map((p) => ({
            id: p.id,
            content: p.right_content,
            contentVi: p.right_content_vi,
          })),
        );
      }

      return result;
    });

    return { data };
  };

  // POST /api/exercises/:exerciseId/submit
  submit = async (request) => {
    const sessionId = extractSessionId(request);
    const exerciseId = Number(request.params.exerciseId);
    if (!Number.isInteger(exerciseId) || exerciseId <= 0) {
      throw new ValidationError('Invalid exercise ID');
    }

    const { answer, timeTaken } = request.body || {};
    if (answer === undefined || answer === null) {
      throw new ValidationError('Answer is required');
    }

    // 1. Look up exercise type + lesson_id
    const exercise = await this.exerciseRepo.findTypeById(exerciseId);
    const { type, lesson_id: lessonId } = exercise;

    // 2. Validate answer shape
    validateAnswerShape(type, answer);

    // 3. Fetch correct answer from DB + validate
    let validationData;
    if (type === 'multiple_choice') {
      validationData = await this.exerciseRepo.findOptionForValidation(
        exerciseId,
        answer,
      );
    } else if (type === 'matching') {
      const [pairs, exerciseData] = await Promise.all([
        this.exerciseRepo.findMatchingPairsForValidation(exerciseId),
        this.exerciseRepo.findExplanationById(exerciseId),
      ]);
      validationData = {
        pairs,
        explanation: exerciseData.explanation,
        explanation_vi: exerciseData.explanation_vi,
      };
    } else {
      validationData =
        await this.exerciseRepo.findAnswerForValidation(exerciseId);
    }

    const result = validateAnswer(type, answer, validationData);
    const userAnswerStr =
      typeof answer === 'string' ? answer : JSON.stringify(answer);

    // 4. Record attempt + update progress in transaction
    await this.sql.begin(async (tx) => {
      const attemptNumber = await this.progressRepo.getNextAttemptNumber(
        tx,
        sessionId,
        exerciseId,
      );
      await this.progressRepo.insertAttempt(tx, {
        sessionId,
        exerciseId,
        userAnswer: userAnswerStr,
        isCorrect: result.isCorrect,
        timeTaken: timeTaken ?? null,
        attemptNumber,
      });
      await this.progressRepo.upsertProgress(tx, {
        sessionId,
        lessonId,
        isCorrect: result.isCorrect,
        timeTaken: timeTaken ?? null,
      });
      await this.progressRepo.updateScores(tx, sessionId, lessonId);
    });

    return {
      data: {
        isCorrect: result.isCorrect,
        explanation: result.explanation,
        explanationVi: result.explanationVi,
      },
    };
  };

  // GET /api/lessons/:lessonId/results
  getResults = async (request) => {
    const sessionId = extractSessionId(request);
    const lessonId = Number(request.params.lessonId);
    if (!Number.isInteger(lessonId) || lessonId <= 0) {
      throw new ValidationError('Invalid lesson ID');
    }

    const results = await this.exerciseRepo.findResultsByLesson(
      lessonId,
      sessionId,
    );
    return { data: results };
  };
}
