import { describe, it, expect, vi, beforeEach } from 'vitest';
import { loader } from './HomePage.jsx';
import { fetchHomePage } from '../api/groups.js';

vi.mock('../api/groups.js');

function mockRequest() {
  return { signal: new AbortController().signal };
}

describe('HomePage loader', () => {
  beforeEach(() => vi.clearAllMocks());

  it('returns groups from fetchHomePage', async () => {
    const groups = [{ id: 1, name: 'Grammar', lessons: [] }];
    fetchHomePage.mockResolvedValueOnce({ groups });

    const result = await loader({ request: mockRequest() });

    expect(result).toEqual({ groups });
  });

  it('passes abort signal to fetchHomePage', async () => {
    fetchHomePage.mockResolvedValueOnce({ groups: [] });
    const request = mockRequest();

    await loader({ request });

    expect(fetchHomePage).toHaveBeenCalledWith({ signal: request.signal });
  });

  it('propagates fetch errors', async () => {
    fetchHomePage.mockRejectedValueOnce(new Error('Network error'));

    await expect(loader({ request: mockRequest() })).rejects.toThrow(
      'Network error',
    );
  });
});
