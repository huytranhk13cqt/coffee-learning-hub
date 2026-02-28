import { describe, it, expect, vi, beforeEach } from 'vitest';
import { loader } from './DashboardPage.jsx';
import { fetchDashboard, fetchWeakSpots } from '../api/progress.js';
import { fetchReviewStats } from '../api/review.js';

vi.mock('../api/progress.js');
vi.mock('../api/review.js');

function mockRequest() {
  return { signal: new AbortController().signal };
}

describe('DashboardPage loader', () => {
  beforeEach(() => {
    vi.clearAllMocks();
    // Optional endpoints — default to non-throwing so tests don't fail on them
    fetchReviewStats.mockResolvedValue({ due_today: 0, total_enrolled: 0 });
    fetchWeakSpots.mockResolvedValue([]);
  });

  it('returns merged dashboard data with reviewStats and weakSpots', async () => {
    const dashboardData = {
      stats: { lessons_started: 3, total_lessons: 12 },
      lessons: [{ lesson_id: 1, slug: 'present-simple' }],
    };
    const reviewStats = { due_today: 5, total_enrolled: 20 };
    const weakSpots = [{ id: 1, error_rate: 0.8 }];

    fetchDashboard.mockResolvedValueOnce(dashboardData);
    fetchReviewStats.mockResolvedValueOnce(reviewStats);
    fetchWeakSpots.mockResolvedValueOnce(weakSpots);

    const result = await loader({ request: mockRequest() });

    expect(result.stats).toEqual(dashboardData.stats);
    expect(result.lessons).toEqual(dashboardData.lessons);
    expect(result.reviewStats).toEqual(reviewStats);
    expect(result.weakSpots).toEqual(weakSpots);
  });

  it('passes abort signal to fetchDashboard', async () => {
    fetchDashboard.mockResolvedValueOnce({ stats: {}, lessons: [] });
    const request = mockRequest();

    await loader({ request });

    expect(fetchDashboard).toHaveBeenCalledWith({ signal: request.signal });
  });

  it('propagates fetchDashboard errors', async () => {
    fetchDashboard.mockRejectedValueOnce(new Error('Server error'));

    await expect(loader({ request: mockRequest() })).rejects.toThrow(
      'Server error',
    );
  });
});
