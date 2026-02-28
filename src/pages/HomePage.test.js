import { describe, it, expect, vi, beforeEach } from 'vitest';
import { loader } from './HomePage.jsx';
import { fetchHomePage } from '../api/groups.js';
import { fetchPaths } from '../api/paths.js';

vi.mock('../api/groups.js');
vi.mock('../api/paths.js');

function mockRequest() {
  return { signal: new AbortController().signal };
}

describe('HomePage loader', () => {
  beforeEach(() => vi.clearAllMocks());

  it('returns topics and featuredPaths from loader', async () => {
    const topics = [{ id: 1, name: 'Grammar', categories: [] }];
    fetchHomePage.mockResolvedValueOnce({ topics });
    fetchPaths.mockResolvedValueOnce([
      { id: 1, is_featured: true, name: 'Path 1' },
      { id: 2, is_featured: false, name: 'Path 2' },
    ]);

    const result = await loader({ request: mockRequest() });

    expect(result.topics).toEqual(topics);
    expect(result.featuredPaths).toHaveLength(1);
    expect(result.featuredPaths[0].id).toBe(1);
  });

  it('passes abort signal to fetchHomePage', async () => {
    fetchHomePage.mockResolvedValueOnce({ topics: [] });
    fetchPaths.mockResolvedValueOnce([]);
    const request = mockRequest();

    await loader({ request });

    expect(fetchHomePage).toHaveBeenCalledWith({ signal: request.signal });
  });

  it('propagates fetchHomePage errors', async () => {
    fetchHomePage.mockRejectedValueOnce(new Error('Network error'));
    fetchPaths.mockResolvedValueOnce([]);

    await expect(loader({ request: mockRequest() })).rejects.toThrow(
      'Network error',
    );
  });
});
