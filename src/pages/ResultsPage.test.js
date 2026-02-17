import { describe, it, expect, vi, beforeEach } from 'vitest';
import { loader } from './ResultsPage.jsx';
import { fetchResults } from '../api/exercises.js';
import { fetchProgress } from '../api/progress.js';

vi.mock('../api/exercises.js');
vi.mock('../api/progress.js');

function mockRequest() {
  return { signal: new AbortController().signal };
}

describe('ResultsPage loader', () => {
  beforeEach(() => vi.clearAllMocks());

  it('returns results, lessonId, and progress', async () => {
    const results = [{ exercise_id: 1, is_correct: true, user_answer: 'A' }];
    const progress = { best_score: 80, status: 'completed' };
    fetchResults.mockResolvedValueOnce(results);
    fetchProgress.mockResolvedValueOnce(progress);

    const result = await loader({
      params: { lessonId: '7' },
      request: mockRequest(),
    });

    expect(result).toEqual({ results, lessonId: '7', progress });
  });

  it('passes lessonId and signal to both API calls', async () => {
    fetchResults.mockResolvedValueOnce([]);
    fetchProgress.mockResolvedValueOnce(null);
    const request = mockRequest();

    await loader({ params: { lessonId: '7' }, request });

    expect(fetchResults).toHaveBeenCalledWith('7', {
      signal: request.signal,
    });
    expect(fetchProgress).toHaveBeenCalledWith('7', {
      signal: request.signal,
    });
  });

  it('returns null progress when fetchProgress fails', async () => {
    fetchResults.mockResolvedValueOnce([{ exercise_id: 1 }]);
    fetchProgress.mockRejectedValueOnce(new Error('No session'));

    const result = await loader({
      params: { lessonId: '7' },
      request: mockRequest(),
    });

    expect(result.progress).toBeNull();
    expect(result.results).toHaveLength(1);
  });

  it('propagates fetchResults errors even if progress succeeds', async () => {
    fetchResults.mockRejectedValueOnce(new Error('Server error'));
    fetchProgress.mockResolvedValueOnce({ best_score: 90 });

    await expect(
      loader({ params: { lessonId: '7' }, request: mockRequest() }),
    ).rejects.toThrow('Server error');
  });
});
