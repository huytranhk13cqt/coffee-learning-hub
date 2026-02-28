// ============================================================================
// lesson-schema.js — YAML validation rules for lesson and learning path imports
// ============================================================================

const DIFFICULTY_LEVELS = ['beginner', 'intermediate', 'advanced']
const EXERCISE_DIFFICULTIES = ['easy', 'medium', 'hard']
const SECTION_TYPES = [
  'markdown', 'key_points', 'info_box', 'chart', 'diagram',
  'interactive_chart', 'image', 'audio', 'video',
]
const EXERCISE_TYPES = [
  'multiple_choice', 'fill_blank', 'error_correction',
  'sentence_transform', 'arrange_words', 'matching',
  'true_false', 'code_output',
]
const OPTION_LABELS = ['A', 'B', 'C', 'D', 'E', 'F']
const SLUG_REGEX = /^[a-z0-9]+(?:-[a-z0-9]+)*$/
const HEX_COLOR_REGEX = /^#[0-9A-Fa-f]{6}$/

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

function isNonEmptyString(val) {
  return typeof val === 'string' && val.trim().length > 0
}

function isPositiveInt(val) {
  return Number.isInteger(val) && val > 0
}

function isNonNegativeInt(val) {
  return Number.isInteger(val) && val >= 0
}

// ---------------------------------------------------------------------------
// validateLesson
// ---------------------------------------------------------------------------

export function validateLesson(data) {
  const errors = []

  // Required string fields
  const requiredStrings = { slug: data.slug, category: data.category, name: data.name, name_vi: data.name_vi }
  for (const [field, val] of Object.entries(requiredStrings)) {
    if (!isNonEmptyString(val)) {
      errors.push(`lesson.${field} is required and must be a non-empty string`)
    }
  }

  // Slug format
  if (isNonEmptyString(data.slug) && !SLUG_REGEX.test(data.slug)) {
    errors.push(`lesson.slug must be kebab-case (got "${data.slug}")`)
  }

  // Difficulty
  if (!DIFFICULTY_LEVELS.includes(data.difficulty)) {
    errors.push(`lesson.difficulty must be one of [${DIFFICULTY_LEVELS.join(', ')}] (got "${data.difficulty}")`)
  }

  // Estimated time
  if (!isPositiveInt(data.estimated_time)) {
    errors.push(`lesson.estimated_time must be a positive integer (minutes)`)
  }

  // Order index
  if (!isNonNegativeInt(data.order_index)) {
    errors.push(`lesson.order_index must be a non-negative integer`)
  }

  // Usages (optional, 0-5)
  if (data.usages != null) {
    if (!Array.isArray(data.usages)) {
      errors.push(`lesson.usages must be an array`)
    } else {
      if (data.usages.length > 5) {
        errors.push(`lesson.usages may have at most 5 items (got ${data.usages.length})`)
      }
      data.usages.forEach((u, i) => {
        if (!isNonEmptyString(u.title)) errors.push(`lesson.usages[${i}].title is required`)
        if (!isNonEmptyString(u.description)) errors.push(`lesson.usages[${i}].description is required`)
      })
    }
  }

  // Sections (optional, 0-10)
  if (data.sections != null) {
    if (!Array.isArray(data.sections)) {
      errors.push(`lesson.sections must be an array`)
    } else {
      if (data.sections.length > 10) {
        errors.push(`lesson.sections may have at most 10 items (got ${data.sections.length})`)
      }
      data.sections.forEach((s, i) => {
        if (!SECTION_TYPES.includes(s.type)) {
          errors.push(`lesson.sections[${i}].type must be one of [${SECTION_TYPES.join(', ')}] (got "${s.type}")`)
        }
        // Content is required for text-based sections, optional for media types
        const mediaTypes = ['audio', 'video', 'image']
        if (!mediaTypes.includes(s.type) && !isNonEmptyString(s.content)) {
          errors.push(`lesson.sections[${i}].content is required for type "${s.type}"`)
        }
        if (s.metadata != null && (typeof s.metadata !== 'object' || Array.isArray(s.metadata))) {
          errors.push(`lesson.sections[${i}].metadata must be a plain object`)
        }
      })
    }
  }

  // Exercises (optional, 0-20)
  if (data.exercises != null) {
    if (!Array.isArray(data.exercises)) {
      errors.push(`lesson.exercises must be an array`)
    } else {
      if (data.exercises.length > 20) {
        errors.push(`lesson.exercises may have at most 20 items (got ${data.exercises.length})`)
      }
      data.exercises.forEach((ex, i) => {
        errors.push(...validateExercise(ex, i))
      })
    }
  }

  return errors
}

// ---------------------------------------------------------------------------
// validateExercise (internal)
// ---------------------------------------------------------------------------

function validateExercise(ex, idx) {
  const errors = []
  const prefix = `lesson.exercises[${idx}]`

  // Type
  if (!EXERCISE_TYPES.includes(ex.type)) {
    errors.push(`${prefix}.type must be one of [${EXERCISE_TYPES.join(', ')}] (got "${ex.type}")`)
  }

  // Difficulty
  if (!EXERCISE_DIFFICULTIES.includes(ex.difficulty)) {
    errors.push(`${prefix}.difficulty must be one of [${EXERCISE_DIFFICULTIES.join(', ')}] (got "${ex.difficulty}")`)
  }

  // Question required
  if (!isNonEmptyString(ex.question)) {
    errors.push(`${prefix}.question is required`)
  }

  // Type-specific validations
  if (ex.type === 'multiple_choice') {
    // Must have options
    if (!Array.isArray(ex.options) || ex.options.length < 2 || ex.options.length > 6) {
      errors.push(`${prefix}.options must be an array with 2-6 items`)
    } else {
      const correctCount = ex.options.filter(o => o.is_correct === true).length
      if (correctCount !== 1) {
        errors.push(`${prefix}.options must have exactly 1 is_correct=true (got ${correctCount})`)
      }
      ex.options.forEach((opt, j) => {
        if (!isNonEmptyString(opt.content)) {
          errors.push(`${prefix}.options[${j}].content is required`)
        }
        if (opt.label != null && !OPTION_LABELS.includes(opt.label)) {
          errors.push(`${prefix}.options[${j}].label must be one of [${OPTION_LABELS.join(', ')}]`)
        }
      })
    }
    // correct_answer should NOT be set for multiple_choice
    if (ex.correct_answer != null) {
      errors.push(`${prefix}: multiple_choice should not have correct_answer (use options[].is_correct)`)
    }
  } else {
    // Non-multiple_choice: must have correct_answer
    if (!isNonEmptyString(ex.correct_answer)) {
      errors.push(`${prefix}.correct_answer is required for type "${ex.type}"`)
    }
  }

  // arrange_words: must have word_bank
  if (ex.type === 'arrange_words') {
    if (!Array.isArray(ex.word_bank) || ex.word_bank.length === 0) {
      errors.push(`${prefix}.word_bank must be a non-empty array for arrange_words`)
    }
  }

  // Points (optional, but if set must be valid)
  if (ex.points != null && (!Number.isInteger(ex.points) || ex.points < 1 || ex.points > 100)) {
    errors.push(`${prefix}.points must be an integer between 1 and 100`)
  }

  // Time limit (optional)
  if (ex.time_limit != null && (!Number.isInteger(ex.time_limit) || ex.time_limit <= 0)) {
    errors.push(`${prefix}.time_limit must be a positive integer (seconds)`)
  }

  return errors
}

// ---------------------------------------------------------------------------
// validateLearningPath
// ---------------------------------------------------------------------------

export function validateLearningPath(data) {
  const errors = []

  // Required fields
  if (!isNonEmptyString(data.slug)) errors.push(`learning_path.slug is required`)
  if (!isNonEmptyString(data.name)) errors.push(`learning_path.name is required`)
  if (!isNonEmptyString(data.name_vi)) errors.push(`learning_path.name_vi is required`)

  // Slug format
  if (isNonEmptyString(data.slug) && !SLUG_REGEX.test(data.slug)) {
    errors.push(`learning_path.slug must be kebab-case (got "${data.slug}")`)
  }

  // Color (optional)
  if (data.color != null && !HEX_COLOR_REGEX.test(data.color)) {
    errors.push(`learning_path.color must be a hex color (got "${data.color}")`)
  }

  // Estimated days (optional)
  if (data.estimated_days != null && !isPositiveInt(data.estimated_days)) {
    errors.push(`learning_path.estimated_days must be a positive integer`)
  }

  // Order index (optional)
  if (data.order_index != null && !isNonNegativeInt(data.order_index)) {
    errors.push(`learning_path.order_index must be a non-negative integer`)
  }

  // Steps
  if (!Array.isArray(data.steps) || data.steps.length === 0) {
    errors.push(`learning_path.steps must be a non-empty array`)
  } else {
    data.steps.forEach((step, i) => {
      if (!isNonEmptyString(step.lesson)) {
        errors.push(`learning_path.steps[${i}].lesson is required (lesson slug)`)
      }
    })
  }

  return errors
}
