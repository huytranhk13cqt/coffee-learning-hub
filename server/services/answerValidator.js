import { ValidationError } from '../errors/AppError.js';

/**
 * Normalize text for comparison:
 * trim, collapse whitespace, lowercase.
 */
function normalizeText(text) {
  return String(text).trim().replace(/\s+/g, ' ').toLowerCase();
}

// --- Validation strategies (one per exercise type) ---

function validateMultipleChoice(userAnswer, data) {
  // data = { is_correct, explanation, explanation_vi } from exercise_option
  return {
    isCorrect: data.is_correct,
    explanation: data.explanation,
    explanationVi: data.explanation_vi,
  };
}

function validateFillBlank(userAnswer, data) {
  // data = { correct_answer, explanation, explanation_vi } from exercise
  const isCorrect =
    normalizeText(userAnswer) === normalizeText(data.correct_answer);
  return {
    isCorrect,
    explanation: data.explanation,
    explanationVi: data.explanation_vi,
  };
}

function validateErrorCorrection(userAnswer, data) {
  const isCorrect =
    normalizeText(userAnswer) === normalizeText(data.correct_answer);
  return {
    isCorrect,
    explanation: data.explanation,
    explanationVi: data.explanation_vi,
  };
}

function validateSentenceTransform(userAnswer, data) {
  const isCorrect =
    normalizeText(userAnswer) === normalizeText(data.correct_answer);
  return {
    isCorrect,
    explanation: data.explanation,
    explanationVi: data.explanation_vi,
  };
}

function validateTrueFalse(userAnswer, data) {
  // correct_answer is 'true' or 'false' (string)
  const isCorrect =
    normalizeText(userAnswer) === normalizeText(data.correct_answer);
  return {
    isCorrect,
    explanation: data.explanation,
    explanationVi: data.explanation_vi,
  };
}

function validateArrangeWords(userAnswer, data) {
  // userAnswer is the arranged sentence (string)
  const isCorrect =
    normalizeText(userAnswer) === normalizeText(data.correct_answer);
  return {
    isCorrect,
    explanation: data.explanation,
    explanationVi: data.explanation_vi,
  };
}

function validateMatching(userAnswer, data) {
  // userAnswer = array of { leftId, rightId }
  // data = { pairs: [{ id, left_content, right_content }], explanation, explanation_vi }
  const correctMap = new Map();
  for (const pair of data.pairs) {
    correctMap.set(pair.id, pair.id); // left and right belong to same pair row
  }

  // userAnswer pairs: user sends [{ leftId: pairRowId, rightId: pairRowId }]
  // where leftId = the pair whose left they chose, rightId = the pair whose right they chose
  // Correct if every pair's leftId === rightId (matched the same row)
  const isCorrect =
    Array.isArray(userAnswer) &&
    userAnswer.length === data.pairs.length &&
    userAnswer.every((pair) => pair.leftId === pair.rightId);

  return {
    isCorrect,
    explanation: data.explanation,
    explanationVi: data.explanation_vi,
  };
}

// --- Strategy dispatch table ---

const strategies = {
  multiple_choice: validateMultipleChoice,
  fill_blank: validateFillBlank,
  error_correction: validateErrorCorrection,
  sentence_transform: validateSentenceTransform,
  true_false: validateTrueFalse,
  arrange_words: validateArrangeWords,
  matching: validateMatching,
};

// --- Shape validation (what the client must send) ---

const shapeValidators = {
  multiple_choice: (a) => typeof a === 'string' && /^[A-F]$/.test(a),
  fill_blank: (a) => typeof a === 'string' && a.trim().length > 0,
  error_correction: (a) => typeof a === 'string' && a.trim().length > 0,
  sentence_transform: (a) => typeof a === 'string' && a.trim().length > 0,
  true_false: (a) => typeof a === 'string' && /^(true|false)$/i.test(a),
  arrange_words: (a) => typeof a === 'string' && a.trim().length > 0,
  matching: (a) =>
    Array.isArray(a) &&
    a.length > 0 &&
    a.every(
      (p) => typeof p.leftId === 'number' && typeof p.rightId === 'number',
    ),
};

/**
 * Validate answer shape before processing.
 * Throws ValidationError if invalid.
 */
export function validateAnswerShape(type, answer) {
  const validator = shapeValidators[type];
  if (!validator) {
    throw new ValidationError(`Unknown exercise type: ${type}`);
  }
  if (!validator(answer)) {
    throw new ValidationError(`Invalid answer format for ${type}`);
  }
}

/**
 * Validate answer against correct data.
 * Returns { isCorrect, explanation, explanationVi }.
 */
export function validateAnswer(type, userAnswer, data) {
  const strategy = strategies[type];
  if (!strategy) {
    throw new ValidationError(`Unknown exercise type: ${type}`);
  }
  return strategy(userAnswer, data);
}
