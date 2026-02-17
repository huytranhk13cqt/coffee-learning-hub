import { describe, it, expect, vi, beforeEach } from 'vitest';
import { loader } from './LessonPage.jsx';
import { fetchLesson } from '../api/lessons.js';
import { fetchProgress } from '../api/progress.js';

vi.mock('../api/lessons.js');
vi.mock('../api/progress.js');

function mockRequest() {
  return { signal: new AbortController().signal };
}

const mockLesson = {
  id: 7,
  name: 'Present Simple',
  slug: 'present-simple',
  formulas: [],
  usages: [],
  signalWords: [],
  tips: [],
  comparisons: [],
  sections: [],
};

describe('LessonPage loader', () => {
  beforeEach(() => vi.clearAllMocks());

  it('returns lesson and progress', async () => {
    const progress = { status: 'in_progress', theory_completed: true };
    fetchLesson.mockResolvedValueOnce(mockLesson);
    fetchProgress.mockResolvedValueOnce(progress);

    const result = await loader({
      params: { slug: 'present-simple' },
      request: mockRequest(),
    });

    expect(result).toEqual({ lesson: mockLesson, progress });
  });

  it('uses lesson.id from fetchLesson for fetchProgress call', async () => {
    fetchLesson.mockResolvedValueOnce(mockLesson);
    fetchProgress.mockResolvedValueOnce(null);
    const request = mockRequest();

    await loader({ params: { slug: 'present-simple' }, request });

    expect(fetchLesson).toHaveBeenCalledWith('present-simple', {
      signal: request.signal,
    });
    expect(fetchProgress).toHaveBeenCalledWith(7, {
      signal: request.signal,
    });
  });

  it('returns null progress when fetchProgress fails', async () => {
    fetchLesson.mockResolvedValueOnce(mockLesson);
    fetchProgress.mockRejectedValueOnce(new Error('No session'));

    const result = await loader({
      params: { slug: 'present-simple' },
      request: mockRequest(),
    });

    expect(result).toEqual({ lesson: mockLesson, progress: null });
  });

  it('propagates fetchLesson errors (does not catch)', async () => {
    fetchLesson.mockRejectedValueOnce(new Error('Not found'));

    await expect(
      loader({ params: { slug: 'nonexistent' }, request: mockRequest() }),
    ).rejects.toThrow('Not found');
  });
});
