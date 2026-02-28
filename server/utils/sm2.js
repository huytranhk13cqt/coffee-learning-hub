/**
 * SM-2 spaced repetition algorithm.
 * Simplified binary grading: grade 5 = correct, grade 1 = incorrect.
 *
 * @param {{ easeFactor: number, intervalDays: number, repetitions: number }} state
 * @param {5|1} grade - 5 for correct, 1 for incorrect
 * @returns {{ easeFactor: number, intervalDays: number, repetitions: number, nextReviewDate: Date }}
 */
export function sm2Update({ easeFactor, intervalDays, repetitions }, grade) {
  // Clamp ease factor between 1.3 and 5.0
  const newEF = Math.min(
    5.0,
    Math.max(1.3, easeFactor + 0.1 - (5 - grade) * (0.08 + (5 - grade) * 0.02)),
  );

  let newInterval, newReps;
  if (grade < 3) {
    // Forgot — reset interval but keep (reduced) ease factor
    newInterval = 1;
    newReps = 0;
  } else {
    newReps = repetitions + 1;
    if (newReps === 1) newInterval = 1;
    else if (newReps === 2) newInterval = 6;
    else newInterval = Math.round(intervalDays * newEF);
  }

  const nextReviewDate = new Date();
  nextReviewDate.setDate(nextReviewDate.getDate() + newInterval);

  return {
    easeFactor: parseFloat(newEF.toFixed(2)),
    intervalDays: newInterval,
    repetitions: newReps,
    nextReviewDate,
  };
}
