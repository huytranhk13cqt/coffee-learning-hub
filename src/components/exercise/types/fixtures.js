/**
 * Shared exercise fixture factory for component tests.
 *
 * Usage:
 *   createExercise('code_output')
 *   createExercise('matching', { id: 99 })
 */

const DEFAULTS = {
  code_output: {
    id: 1,
    type: 'code_output',
    question: 'What does this code print?',
    content: '```python\nprint("Hello")\n```',
  },
  arrange_words: {
    id: 2,
    type: 'arrange_words',
    question: 'Arrange into a correct sentence',
    word_bank: ['goes', 'She', 'to', 'school'],
  },
  matching: {
    id: 3,
    type: 'matching',
    question: 'Match each animal with its sound',
    leftItems: [
      { id: 'l1', content: 'Dog' },
      { id: 'l2', content: 'Cat' },
    ],
    rightItems: [
      { id: 'r1', content: 'Bark' },
      { id: 'r2', content: 'Meow' },
    ],
  },
};

export function createExercise(type, overrides = {}) {
  const base = DEFAULTS[type];
  if (!base) throw new Error(`Unknown fixture type: "${type}"`);
  return { ...base, ...overrides };
}
