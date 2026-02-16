import { describe, it, expect } from 'vitest';
import { validateAnswer, validateAnswerShape } from './answerValidator.js';

describe('validateAnswerShape', () => {
  it('accepts valid multiple choice answer (A-F)', () => {
    expect(() => validateAnswerShape('multiple_choice', 'A')).not.toThrow();
    expect(() => validateAnswerShape('multiple_choice', 'F')).not.toThrow();
  });

  it('rejects invalid multiple choice answer', () => {
    expect(() => validateAnswerShape('multiple_choice', 'G')).toThrow(
      'Invalid answer format',
    );
    expect(() => validateAnswerShape('multiple_choice', '')).toThrow(
      'Invalid answer format',
    );
  });

  it('accepts valid fill_blank answer', () => {
    expect(() =>
      validateAnswerShape('fill_blank', 'She goes to school'),
    ).not.toThrow();
  });

  it('rejects empty fill_blank answer', () => {
    expect(() => validateAnswerShape('fill_blank', '   ')).toThrow(
      'Invalid answer format',
    );
  });

  it('accepts valid true_false answer', () => {
    expect(() => validateAnswerShape('true_false', 'true')).not.toThrow();
    expect(() => validateAnswerShape('true_false', 'false')).not.toThrow();
  });

  it('rejects invalid true_false answer', () => {
    expect(() => validateAnswerShape('true_false', 'maybe')).toThrow(
      'Invalid answer format',
    );
  });

  it('accepts valid matching answer', () => {
    const answer = [
      { leftId: 1, rightId: 2 },
      { leftId: 3, rightId: 4 },
    ];
    expect(() => validateAnswerShape('matching', answer)).not.toThrow();
  });

  it('rejects matching answer with string IDs', () => {
    const answer = [{ leftId: '1', rightId: '2' }];
    expect(() => validateAnswerShape('matching', answer)).toThrow(
      'Invalid answer format',
    );
  });

  it('accepts valid code_output answer', () => {
    expect(() =>
      validateAnswerShape('code_output', 'Hello, World!'),
    ).not.toThrow();
  });

  it('rejects empty code_output answer', () => {
    expect(() => validateAnswerShape('code_output', '   ')).toThrow(
      'Invalid answer format',
    );
  });

  it('throws for unknown exercise type', () => {
    expect(() => validateAnswerShape('unknown_type', 'x')).toThrow(
      'Unknown exercise type',
    );
  });
});

describe('validateAnswer', () => {
  const baseData = {
    correct_answer: 'She goes to school',
    explanation: 'Present simple for habits',
    explanation_vi: 'Thì hiện tại đơn cho thói quen',
  };

  describe('fill_blank', () => {
    it('returns correct for exact match', () => {
      const result = validateAnswer(
        'fill_blank',
        'She goes to school',
        baseData,
      );
      expect(result.isCorrect).toBe(true);
      expect(result.explanation).toBe(baseData.explanation);
    });

    it('normalizes whitespace and case', () => {
      const result = validateAnswer(
        'fill_blank',
        '  she  GOES  to  school  ',
        baseData,
      );
      expect(result.isCorrect).toBe(true);
    });

    it('returns incorrect for wrong answer', () => {
      const result = validateAnswer('fill_blank', 'She go to school', baseData);
      expect(result.isCorrect).toBe(false);
      expect(result.explanationVi).toBe(baseData.explanation_vi);
    });
  });

  describe('true_false', () => {
    it('returns correct when matching', () => {
      const data = { ...baseData, correct_answer: 'true' };
      const result = validateAnswer('true_false', 'true', data);
      expect(result.isCorrect).toBe(true);
    });

    it('is case-insensitive', () => {
      const data = { ...baseData, correct_answer: 'true' };
      const result = validateAnswer('true_false', 'TRUE', data);
      expect(result.isCorrect).toBe(true);
    });
  });

  describe('multiple_choice', () => {
    it('returns the pre-computed is_correct flag', () => {
      const data = {
        is_correct: true,
        explanation: 'Correct!',
        explanation_vi: 'Đúng rồi!',
      };
      const result = validateAnswer('multiple_choice', 'A', data);
      expect(result.isCorrect).toBe(true);
    });

    it('returns false when option is incorrect', () => {
      const data = {
        is_correct: false,
        explanation: 'Wrong answer',
        explanation_vi: 'Sai rồi',
      };
      const result = validateAnswer('multiple_choice', 'B', data);
      expect(result.isCorrect).toBe(false);
    });
  });

  describe('matching', () => {
    const matchData = {
      pairs: [
        { id: 1, left_content: 'I', right_content: 'am' },
        { id: 2, left_content: 'She', right_content: 'is' },
      ],
      explanation: 'Subject-verb agreement',
      explanation_vi: 'Hòa hợp chủ-vị',
    };

    it('returns correct when all pairs match', () => {
      const answer = [
        { leftId: 1, rightId: 1 },
        { leftId: 2, rightId: 2 },
      ];
      const result = validateAnswer('matching', answer, matchData);
      expect(result.isCorrect).toBe(true);
    });

    it('returns incorrect when pairs are mismatched', () => {
      const answer = [
        { leftId: 1, rightId: 2 },
        { leftId: 2, rightId: 1 },
      ];
      const result = validateAnswer('matching', answer, matchData);
      expect(result.isCorrect).toBe(false);
    });

    it('returns incorrect when missing pairs', () => {
      const answer = [{ leftId: 1, rightId: 1 }];
      const result = validateAnswer('matching', answer, matchData);
      expect(result.isCorrect).toBe(false);
    });
  });

  describe('code_output', () => {
    it('returns correct for exact output match', () => {
      const data = {
        correct_answer: 'Hello, World!',
        explanation: 'print() outputs the string',
        explanation_vi: 'print() in ra chuỗi',
      };
      const result = validateAnswer('code_output', 'Hello, World!', data);
      expect(result.isCorrect).toBe(true);
      expect(result.explanation).toBe(data.explanation);
    });

    it('normalizes whitespace and case', () => {
      const data = { ...baseData, correct_answer: '42' };
      const result = validateAnswer('code_output', '  42  ', data);
      expect(result.isCorrect).toBe(true);
    });

    it('returns incorrect for wrong output', () => {
      const data = {
        correct_answer: '[1, 2, 3]',
        explanation: 'List comprehension output',
        explanation_vi: 'Kết quả list comprehension',
      };
      const result = validateAnswer('code_output', '[1, 2]', data);
      expect(result.isCorrect).toBe(false);
      expect(result.explanationVi).toBe(data.explanation_vi);
    });
  });

  it('throws for unknown exercise type', () => {
    expect(() => validateAnswer('bogus', 'x', {})).toThrow(
      'Unknown exercise type',
    );
  });
});
