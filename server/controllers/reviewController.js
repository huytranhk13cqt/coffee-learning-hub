import { ValidationError } from '../errors/AppError.js';
import {
  validateAnswerShape,
  validateAnswer,
} from '../services/answerValidator.js';
import { extractSessionId } from '../utils/session.js';
import { sm2Update } from '../utils/sm2.js';

export class ReviewController {
  constructor(reviewRepo, exerciseRepo, gamificationRepo, sql) {
    this.reviewRepo = reviewRepo;
    this.exerciseRepo = exerciseRepo;
    this.gamificationRepo = gamificationRepo;
    this.sql = sql;
  }

  // GET /api/review/due
  getDue = async (request) => {
    const sessionId = extractSessionId(request);
    const [exercises, stats] = await Promise.all([
      this.reviewRepo.findDueExercises(sessionId),
      this.reviewRepo.getReviewStats(sessionId),
    ]);
    return { data: exercises, stats };
  };

  // GET /api/review/stats
  getStats = async (request) => {
    const sessionId = extractSessionId(request);
    const stats = await this.reviewRepo.getReviewStats(sessionId);
    return { data: stats };
  };

  // POST /api/review/:exerciseId/submit
  submit = async (request) => {
    const sessionId = extractSessionId(request);
    const exerciseId = Number(request.params.exerciseId);
    if (!Number.isInteger(exerciseId) || exerciseId <= 0) {
      throw new ValidationError('Invalid exercise ID');
    }

    const { answer, timeTaken: _timeTaken } = request.body || {};
    if (answer === undefined || answer === null) {
      throw new ValidationError('Answer is required');
    }

    // 1. Look up exercise type
    const exercise = await this.exerciseRepo.findTypeById(exerciseId);
    const { type } = exercise;

    // 2. Validate answer shape
    validateAnswerShape(type, answer);

    // 3. Fetch correct answer and validate
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
    const grade = result.isCorrect ? 5 : 1;

    // 4. Get current SM-2 state from review record, update it
    await this.sql.begin(async (tx) => {
      const rows = await tx`
        SELECT ease_factor, interval_days, repetitions
        FROM exercise_review
        WHERE session_id = ${sessionId} AND exercise_id = ${exerciseId}
      `;

      const currentState = rows[0] || {
        ease_factor: 2.5,
        interval_days: 0,
        repetitions: 0,
      };
      const sm2State = sm2Update(
        {
          easeFactor: parseFloat(currentState.ease_factor),
          intervalDays: currentState.interval_days,
          repetitions: currentState.repetitions,
        },
        grade,
      );

      await this.reviewRepo.upsertReview(tx, sessionId, exerciseId, sm2State);
    });

    // 5. Award XP (3 XP for review, non-critical)
    let gamification = null;
    try {
      gamification = await this.sql.begin(async (tx) => {
        const xpAmount = result.isCorrect ? 3 : 1;
        await this.gamificationRepo.recordXPEvent(tx, {
          sessionId,
          eventType: result.isCorrect
            ? 'exercise_correct'
            : 'exercise_incorrect',
          xpAmount,
          referenceId: exerciseId,
        });
        await this.gamificationRepo.updateDailyActivity(
          tx,
          sessionId,
          xpAmount,
        );
        const streak = await this.gamificationRepo.updateStreak(tx, sessionId);
        const totalXP = await this.gamificationRepo.getTotalXP(sessionId);
        return {
          xpEarned: xpAmount,
          totalXP,
          level: Math.floor(totalXP / 100) + 1,
          streak: streak.current_streak,
          newAchievements: [],
        };
      });
    } catch (err) {
      request.log.warn(
        { err: err.message },
        'Gamification update failed (non-critical)',
      );
    }

    return {
      data: {
        isCorrect: result.isCorrect,
        explanation: result.explanation,
        explanationVi: result.explanationVi,
        gamification,
      },
    };
  };
}
