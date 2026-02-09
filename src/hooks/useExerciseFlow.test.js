import { describe, it, expect, vi, beforeEach } from 'vitest';
import { renderHook, act } from '@testing-library/react';

// Mock the API module before importing the hook
vi.mock('../api/exercises.js', () => ({
  submitAnswer: vi.fn(),
}));

import { useExerciseFlow } from './useExerciseFlow.js';
import { submitAnswer } from '../api/exercises.js';

const mockExercises = [
  { id: 1, type: 'fill_blank', question: 'She ___ to school' },
  { id: 2, type: 'true_false', question: 'The sun rises in the east' },
  { id: 3, type: 'multiple_choice', question: 'Choose the correct form' },
];

describe('useExerciseFlow', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it('starts in idle phase', () => {
    const { result } = renderHook(() => useExerciseFlow());
    expect(result.current.phase).toBe('idle');
    expect(result.current.currentExercise).toBeNull();
    expect(result.current.totalExercises).toBe(0);
  });

  it('transitions to answering when exercises are loaded', () => {
    const { result } = renderHook(() => useExerciseFlow());

    act(() => {
      result.current.loadExercises(mockExercises);
    });

    expect(result.current.phase).toBe('answering');
    expect(result.current.currentExercise).toEqual(mockExercises[0]);
    expect(result.current.totalExercises).toBe(3);
    expect(result.current.currentIndex).toBe(0);
  });

  it('transitions to finished when empty exercises are loaded', () => {
    const { result } = renderHook(() => useExerciseFlow());

    act(() => {
      result.current.loadExercises([]);
    });

    expect(result.current.phase).toBe('finished');
  });

  it('sets answer correctly', () => {
    const { result } = renderHook(() => useExerciseFlow());

    act(() => {
      result.current.loadExercises(mockExercises);
    });
    act(() => {
      result.current.setAnswer('goes');
    });

    expect(result.current.currentAnswer).toBe('goes');
  });

  it('shows hint when requested', () => {
    const { result } = renderHook(() => useExerciseFlow());

    act(() => {
      result.current.loadExercises(mockExercises);
    });

    expect(result.current.isHintVisible).toBe(false);

    act(() => {
      result.current.showHint();
    });

    expect(result.current.isHintVisible).toBe(true);
  });

  it('submits answer and transitions through submitting → feedback', async () => {
    submitAnswer.mockResolvedValueOnce({
      isCorrect: true,
      explanation: 'Good job!',
      explanationVi: 'Tốt lắm!',
    });

    const { result } = renderHook(() => useExerciseFlow());

    act(() => {
      result.current.loadExercises(mockExercises);
    });
    act(() => {
      result.current.setAnswer('goes');
    });

    await act(async () => {
      await result.current.submit();
    });

    expect(result.current.phase).toBe('feedback');
    expect(result.current.feedback.isCorrect).toBe(true);
    expect(result.current.results).toHaveLength(1);
    expect(result.current.results[0].exerciseId).toBe(1);
    expect(submitAnswer).toHaveBeenCalledWith(1, {
      answer: 'goes',
      timeTaken: expect.any(Number),
    });
  });

  it('handles submit error and returns to answering', async () => {
    submitAnswer.mockRejectedValueOnce(new Error('Network error'));

    const { result } = renderHook(() => useExerciseFlow());

    act(() => {
      result.current.loadExercises(mockExercises);
    });
    act(() => {
      result.current.setAnswer('goes');
    });

    await act(async () => {
      await result.current.submit();
    });

    expect(result.current.phase).toBe('answering');
    expect(result.current.error).toBe('Network error');
  });

  it('advances to next exercise and resets state', async () => {
    submitAnswer.mockResolvedValueOnce({
      isCorrect: true,
      explanation: 'Correct',
      explanationVi: 'Đúng',
    });

    const { result } = renderHook(() => useExerciseFlow());

    act(() => {
      result.current.loadExercises(mockExercises);
    });
    act(() => {
      result.current.setAnswer('goes');
    });

    // Show hint before submitting
    act(() => {
      result.current.showHint();
    });

    await act(async () => {
      await result.current.submit();
    });

    act(() => {
      result.current.next();
    });

    expect(result.current.phase).toBe('answering');
    expect(result.current.currentIndex).toBe(1);
    expect(result.current.currentExercise).toEqual(mockExercises[1]);
    expect(result.current.currentAnswer).toBeNull();
    expect(result.current.isHintVisible).toBe(false);
    expect(result.current.feedback).toBeNull();
    expect(result.current.error).toBeNull();
  });

  it('transitions to finished after last exercise', async () => {
    const singleExercise = [mockExercises[0]];

    submitAnswer.mockResolvedValueOnce({
      isCorrect: true,
      explanation: 'Done',
      explanationVi: 'Xong',
    });

    const { result } = renderHook(() => useExerciseFlow());

    act(() => {
      result.current.loadExercises(singleExercise);
    });
    act(() => {
      result.current.setAnswer('goes');
    });

    await act(async () => {
      await result.current.submit();
    });

    act(() => {
      result.current.next();
    });

    expect(result.current.phase).toBe('finished');
    expect(result.current.results).toHaveLength(1);
  });

  it('does not submit when answer is null', async () => {
    const { result } = renderHook(() => useExerciseFlow());

    act(() => {
      result.current.loadExercises(mockExercises);
    });

    // Don't set answer — currentAnswer is null
    await act(async () => {
      await result.current.submit();
    });

    expect(result.current.phase).toBe('answering');
    expect(submitAnswer).not.toHaveBeenCalled();
  });
});
