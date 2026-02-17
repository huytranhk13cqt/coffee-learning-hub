import { ValidationError } from '../errors/AppError.js';

/**
 * Normalize text for comparison:
 * trim, collapse whitespace, lowercase.
 * Used by grammar/language exercises where case doesn't matter.
 */
function normalizeText(text) {
  return String(text).trim().replace(/\s+/g, ' ').toLowerCase();
}

/**
 * Normalize text preserving original case:
 * trim and collapse whitespace only.
 * Used by code_output where case matters (e.g. Python True vs true).
 */
function normalizeTextPreserveCase(text) {
  return String(text).trim().replace(/\s+/g, ' ');
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

/**
 * Shared validator for text-based exercise types (case-insensitive).
 * Compares normalized user input against the correct answer string.
 *
 * Used by: fill_blank, error_correction, sentence_transform,
 *          true_false, arrange_words
 */
function validateTextAnswer(userAnswer, data) {
  const isCorrect =
    normalizeText(userAnswer) === normalizeText(data.correct_answer);
  return {
    isCorrect,
    explanation: data.explanation,
    explanationVi: data.explanation_vi,
  };
}

/**
 * Case-sensitive validator for code output exercises.
 * Trims whitespace but preserves original casing.
 * Critical for programming languages where True ≠ true (Python, etc.).
 */
function validateCodeOutput(userAnswer, data) {
  const isCorrect =
    normalizeTextPreserveCase(userAnswer) ===
    normalizeTextPreserveCase(data.correct_answer);
  return {
    isCorrect,
    explanation: data.explanation,
    explanationVi: data.explanation_vi,
  };
}

function validateMatching(userAnswer, data) {
  // userAnswer = array of { leftId, rightId }
  // data = { pairs: [{ id, left_content, right_content }], explanation, explanation_vi }
  //
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
  fill_blank: validateTextAnswer,
  error_correction: validateTextAnswer,
  sentence_transform: validateTextAnswer,
  true_false: validateTextAnswer,
  arrange_words: validateTextAnswer,
  code_output: validateCodeOutput,
  matching: validateMatching,
};

// --- Shape validation (what the client must send) ---

const isNonEmptyString = (a) => typeof a === 'string' && a.trim().length > 0;

const shapeValidators = {
  multiple_choice: (a) => typeof a === 'string' && /^[A-F]$/.test(a),
  fill_blank: isNonEmptyString,
  error_correction: isNonEmptyString,
  sentence_transform: isNonEmptyString,
  arrange_words: isNonEmptyString,
  code_output: isNonEmptyString,
  true_false: (a) => typeof a === 'string' && /^(true|false)$/i.test(a),
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
