import { describe, it, expect, vi, beforeEach } from 'vitest';
import { loader } from './ExercisePage.jsx';
import { fetchExercises } from '../api/exercises.js';

vi.mock('../api/exercises.js');

function mockRequest() {
  return { signal: new AbortController().signal };
}

describe('ExercisePage loader', () => {
  beforeEach(() => vi.clearAllMocks());

  it('returns exercises and lessonId', async () => {
    const exercises = [{ id: 1, type: 'fill_blank', question: 'Fill in ___' }];
    fetchExercises.mockResolvedValueOnce(exercises);

    const result = await loader({
      params: { lessonId: '42' },
      request: mockRequest(),
    });

    expect(result).toEqual({ exercises, lessonId: '42' });
  });

  it('passes lessonId and abort signal to fetchExercises', async () => {
    fetchExercises.mockResolvedValueOnce([]);
    const request = mockRequest();

    await loader({ params: { lessonId: '42' }, request });

    expect(fetchExercises).toHaveBeenCalledWith('42', {
      signal: request.signal,
    });
  });

  it('propagates fetch errors', async () => {
    fetchExercises.mockRejectedValueOnce(new Error('Not found'));

    await expect(
      loader({ params: { lessonId: '99' }, request: mockRequest() }),
    ).rejects.toThrow('Not found');
  });
});
