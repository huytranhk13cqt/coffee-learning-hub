import { describe, it, expect, vi, beforeEach } from 'vitest';
import { loader } from './DashboardPage.jsx';
import { fetchDashboard } from '../api/progress.js';

vi.mock('../api/progress.js');

function mockRequest() {
  return { signal: new AbortController().signal };
}

describe('DashboardPage loader', () => {
  beforeEach(() => vi.clearAllMocks());

  it('returns dashboard data directly from API', async () => {
    const data = {
      stats: { lessons_started: 3, total_lessons: 12 },
      lessons: [{ lesson_id: 1, slug: 'present-simple' }],
    };
    fetchDashboard.mockResolvedValueOnce(data);

    const result = await loader({ request: mockRequest() });

    expect(result).toEqual(data);
  });

  it('passes abort signal to fetchDashboard', async () => {
    fetchDashboard.mockResolvedValueOnce({ stats: {}, lessons: [] });
    const request = mockRequest();

    await loader({ request });

    expect(fetchDashboard).toHaveBeenCalledWith({ signal: request.signal });
  });

  it('propagates fetch errors', async () => {
    fetchDashboard.mockRejectedValueOnce(new Error('Server error'));

    await expect(loader({ request: mockRequest() })).rejects.toThrow(
      'Server error',
    );
  });
});
