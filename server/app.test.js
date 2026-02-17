import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { createTestApp } from './tests/helpers.js';

const TEST_SESSION = '550e8400-e29b-41d4-a716-446655440000';

// ---------------------------------------------------------------------------
// 1. Health & Routing
// ---------------------------------------------------------------------------
describe('Health & Routing', () => {
  let app;
  beforeAll(async () => {
    app = await createTestApp();
  });
  afterAll(async () => {
    await app.close();
  });

  it('GET /api/health returns 200', async () => {
    const res = await app.inject({ method: 'GET', url: '/api/health' });
    expect(res.statusCode).toBe(200);
    const body = res.json();
    expect(body.status).toBe('ok');
    expect(body.timestamp).toBeDefined();
  });

  it('GET unknown route returns 404', async () => {
    const res = await app.inject({ method: 'GET', url: '/api/nonexistent' });
    expect(res.statusCode).toBe(404);
    expect(res.json().error).toMatch(/Cannot GET/);
  });

  it('returns X-Request-Id header on every response', async () => {
    const res = await app.inject({ method: 'GET', url: '/api/health' });
    expect(res.headers['x-request-id']).toBeDefined();
    expect(res.headers['x-request-id'].length).toBeGreaterThan(0);
  });

  it('echoes client-provided X-Request-Id', async () => {
    const clientId = '550e8400-e29b-41d4-a716-446655440099';
    const res = await app.inject({
      method: 'GET',
      url: '/api/health',
      headers: { 'x-request-id': clientId },
    });
    expect(res.headers['x-request-id']).toBe(clientId);
  });

  it('returns Content-Security-Policy header', async () => {
    const res = await app.inject({ method: 'GET', url: '/api/health' });
    const csp = res.headers['content-security-policy'];
    expect(csp).toContain("default-src 'none'");
    expect(csp).toContain("frame-ancestors 'none'");
  });
});

// ---------------------------------------------------------------------------
// 2. Schema Validation (Fastify JSON Schema)
// ---------------------------------------------------------------------------
describe('Schema Validation', () => {
  let app;
  beforeAll(async () => {
    app = await createTestApp();
  });
  afterAll(async () => {
    await app.close();
  });

  it('GET /api/groups/:groupId/lessons rejects non-integer groupId', async () => {
    const res = await app.inject({
      method: 'GET',
      url: '/api/groups/abc/lessons',
    });
    expect(res.statusCode).toBe(400);
    expect(res.json().error).toBeDefined();
  });

  it('POST /api/exercises/:exerciseId/submit rejects non-integer exerciseId', async () => {
    const res = await app.inject({
      method: 'POST',
      url: '/api/exercises/abc/submit',
      headers: { 'content-type': 'application/json', 'x-session-id': 'test' },
      payload: { answer: 'A' },
    });
    expect(res.statusCode).toBe(400);
    expect(res.json().error).toBeDefined();
  });

  it('POST /api/exercises/1/submit rejects missing answer', async () => {
    const res = await app.inject({
      method: 'POST',
      url: '/api/exercises/1/submit',
      headers: { 'content-type': 'application/json', 'x-session-id': 'test' },
      payload: {},
    });
    expect(res.statusCode).toBe(400);
    expect(res.json().error).toBeDefined();
  });

  it('GET /api/lessons/search rejects q longer than 128 chars', async () => {
    const longQ = 'a'.repeat(129);
    const res = await app.inject({
      method: 'GET',
      url: `/api/lessons/search?q=${longQ}`,
    });
    expect(res.statusCode).toBe(400);
    expect(res.json().error).toBeDefined();
  });

  it('GET /api/progress/:lessonId rejects non-integer lessonId', async () => {
    const res = await app.inject({
      method: 'GET',
      url: '/api/progress/abc',
      headers: { 'x-session-id': TEST_SESSION },
    });
    expect(res.statusCode).toBe(400);
    expect(res.json().error).toBeDefined();
  });
});

// ---------------------------------------------------------------------------
// 3. Error Handling
// ---------------------------------------------------------------------------
describe('Error Handling', () => {
  it('NotFoundError maps to 404', async () => {
    const { NotFoundError } = await import('./errors/AppError.js');
    const app = await createTestApp({
      lessonRepoOverrides: {
        findFullBySlug: async () => {
          throw new NotFoundError('Lesson');
        },
      },
    });
    const res = await app.inject({
      method: 'GET',
      url: '/api/lessons/nonexistent',
    });
    expect(res.statusCode).toBe(404);
    expect(res.json().error).toBe('Lesson not found');
    await app.close();
  });

  it('ValidationError maps to 400', async () => {
    // extractSessionId throws ValidationError when header is missing
    const app = await createTestApp();
    const res = await app.inject({
      method: 'GET',
      url: '/api/progress/1',
      // no x-session-id header
    });
    expect(res.statusCode).toBe(400);
    expect(res.json().error).toMatch(/Session/i);
    await app.close();
  });

  it('Unknown error maps to 500', async () => {
    const app = await createTestApp({
      categoryRepoOverrides: {
        findAllWithLessonCount: async () => {
          throw new Error('Unexpected DB failure');
        },
      },
    });
    const res = await app.inject({ method: 'GET', url: '/api/groups' });
    expect(res.statusCode).toBe(500);
    expect(res.json().error).toBe('Internal server error');
    await app.close();
  });
});

// ---------------------------------------------------------------------------
// 4. Session Validation
// ---------------------------------------------------------------------------
describe('Session Validation', () => {
  let app;
  beforeAll(async () => {
    app = await createTestApp();
  });
  afterAll(async () => {
    await app.close();
  });

  it('rejects requests without X-Session-Id header', async () => {
    const res = await app.inject({
      method: 'GET',
      url: '/api/progress/1',
    });
    expect(res.statusCode).toBe(400);
    expect(res.json().error).toMatch(/Session/i);
  });

  it('accepts valid X-Session-Id header', async () => {
    const res = await app.inject({
      method: 'GET',
      url: '/api/progress/1',
      headers: { 'x-session-id': TEST_SESSION },
    });
    expect(res.statusCode).toBe(200);
    // Default mock returns null progress
    expect(res.json().data).toBeNull();
  });

  it('rejects non-UUID X-Session-Id header', async () => {
    const res = await app.inject({
      method: 'GET',
      url: '/api/progress/1',
      headers: { 'x-session-id': 'not-a-valid-uuid' },
    });
    expect(res.statusCode).toBe(400);
    expect(res.json().error).toMatch(/Session/i);
  });
});

// ---------------------------------------------------------------------------
// 5. Happy Paths
// ---------------------------------------------------------------------------
describe('Happy Paths', () => {
  it('GET /api/home returns grouped lessons with progress (BFF)', async () => {
    const mockRows = [
      {
        group_id: 1,
        group_name: 'Present Tenses',
        group_name_vi: 'Thì hiện tại',
        group_color: '#4CAF50',
        lesson_id: 1,
        lesson_name: 'Simple Present',
        lesson_name_vi: 'Hiện tại đơn',
        lesson_slug: 'simple-present',
        lesson_difficulty: 'beginner',
        progress_status: 'completed',
        best_score: 90,
      },
      {
        group_id: 1,
        group_name: 'Present Tenses',
        group_name_vi: 'Thì hiện tại',
        group_color: '#4CAF50',
        lesson_id: 2,
        lesson_name: 'Present Continuous',
        lesson_name_vi: 'Hiện tại tiếp diễn',
        lesson_slug: 'present-continuous',
        lesson_difficulty: 'beginner',
        progress_status: 'not_started',
        best_score: 0,
      },
    ];
    const app = await createTestApp({
      categoryRepoOverrides: {
        findHomePageData: async () => mockRows,
      },
    });
    const res = await app.inject({ method: 'GET', url: '/api/home' });
    expect(res.statusCode).toBe(200);
    const body = res.json();
    expect(body.data.groups).toHaveLength(1);
    expect(body.data.groups[0].name).toBe('Present Tenses');
    expect(body.data.groups[0].lessons).toHaveLength(2);
    expect(body.data.groups[0].lessons[0].status).toBe('completed');
    expect(body.data.groups[0].lessons[0].best_score).toBe(90);
    expect(body.data.groups[0].lessons[1].status).toBe('not_started');
    await app.close();
  });

  it('GET /api/home works without session header', async () => {
    const app = await createTestApp({
      categoryRepoOverrides: {
        findHomePageData: async () => [],
      },
    });
    const res = await app.inject({ method: 'GET', url: '/api/home' });
    expect(res.statusCode).toBe(200);
    expect(res.json().data.groups).toEqual([]);
    await app.close();
  });

  it('GET /api/home handles empty categories', async () => {
    const mockRows = [
      {
        group_id: 1,
        group_name: 'Empty Category',
        group_name_vi: 'Danh mục trống',
        group_color: '#999',
        lesson_id: null,
        lesson_name: null,
        lesson_name_vi: null,
        lesson_slug: null,
        lesson_difficulty: null,
        progress_status: 'not_started',
        best_score: 0,
      },
    ];
    const app = await createTestApp({
      categoryRepoOverrides: {
        findHomePageData: async () => mockRows,
      },
    });
    const res = await app.inject({ method: 'GET', url: '/api/home' });
    expect(res.statusCode).toBe(200);
    const groups = res.json().data.groups;
    expect(groups).toHaveLength(1);
    expect(groups[0].name).toBe('Empty Category');
    expect(groups[0].lessons).toHaveLength(0);
    await app.close();
  });

  it('GET /api/groups returns categories', async () => {
    const mockGroups = [
      { id: 1, name: 'Present Tenses', lesson_count: 4 },
      { id: 2, name: 'Past Tenses', lesson_count: 4 },
    ];
    const app = await createTestApp({
      categoryRepoOverrides: {
        findAllWithLessonCount: async () => mockGroups,
      },
    });
    const res = await app.inject({ method: 'GET', url: '/api/groups' });
    expect(res.statusCode).toBe(200);
    expect(res.json().data).toEqual(mockGroups);
    await app.close();
  });

  it('GET /api/lessons/:slug returns lesson BFF data', async () => {
    const mockLesson = {
      id: 1,
      slug: 'simple-present',
      name: 'Simple Present',
      formulas: [],
      usages: [],
      signalWords: [],
      tips: [],
      comparisons: [],
    };
    const app = await createTestApp({
      lessonRepoOverrides: {
        findFullBySlug: async () => mockLesson,
      },
    });
    const res = await app.inject({
      method: 'GET',
      url: '/api/lessons/simple-present',
    });
    expect(res.statusCode).toBe(200);
    expect(res.json().data.slug).toBe('simple-present');
    await app.close();
  });

  it('GET /api/lessons/search returns search results', async () => {
    const mockResults = [
      { id: 1, name: 'Simple Present', slug: 'simple-present' },
    ];
    const app = await createTestApp({
      lessonRepoOverrides: { search: async () => mockResults },
    });
    const res = await app.inject({
      method: 'GET',
      url: '/api/lessons/search?q=simple',
    });
    expect(res.statusCode).toBe(200);
    expect(res.json().data).toHaveLength(1);
    await app.close();
  });

  it('GET /api/progress/session/dashboard returns stats + lessons', async () => {
    const mockStats = {
      lessons_started: 2,
      lessons_completed: 1,
      total_lessons: 12,
      avg_score: 85.5,
      total_time_seconds: 600,
    };
    const mockLessons = [
      {
        lesson_id: 1,
        lesson_name: 'Simple Present',
        status: 'completed',
        exercises_total: 7,
      },
    ];
    const app = await createTestApp({
      progressRepoOverrides: {
        getSessionStats: async () => mockStats,
        getDashboardOverview: async () => mockLessons,
      },
    });
    const res = await app.inject({
      method: 'GET',
      url: '/api/progress/session/dashboard',
      headers: { 'x-session-id': TEST_SESSION },
    });
    expect(res.statusCode).toBe(200);
    const body = res.json();
    expect(body.data.stats.lessons_completed).toBe(1);
    expect(body.data.lessons[0].exercises_total).toBe(7);
    await app.close();
  });

  it('POST /api/progress/:lessonId/theory-complete marks theory done', async () => {
    let capturedArgs;
    const app = await createTestApp({
      progressRepoOverrides: {
        markTheoryComplete: async (sid, lid, ts) => {
          capturedArgs = { sid, lid, ts };
        },
      },
    });
    const res = await app.inject({
      method: 'POST',
      url: '/api/progress/1/theory-complete',
      headers: {
        'content-type': 'application/json',
        'x-session-id': TEST_SESSION,
      },
      payload: { timeSpent: 42 },
    });
    expect(res.statusCode).toBe(200);
    expect(res.json().data.success).toBe(true);
    expect(capturedArgs.sid).toBe(TEST_SESSION);
    expect(capturedArgs.lid).toBe(1);
    expect(capturedArgs.ts).toBe(42);
    await app.close();
  });

  it('GET /api/lessons/:lessonId/exercises returns BFF exercises', async () => {
    const mockExercises = [
      { id: 1, type: 'fill_blank', question: 'She ___ every day.' },
      {
        id: 2,
        type: 'multiple_choice',
        question: 'Choose the correct form.',
      },
    ];
    const mockOptions = [
      { id: 1, exercise_id: 2, label: 'A', content: 'goes' },
      { id: 2, exercise_id: 2, label: 'B', content: 'go' },
    ];
    const app = await createTestApp({
      exerciseRepoOverrides: {
        findByLesson: async () => mockExercises,
        findOptionsByLesson: async () => mockOptions,
        findMatchingPairsByLesson: async () => [],
      },
    });
    const res = await app.inject({
      method: 'GET',
      url: '/api/lessons/1/exercises',
    });
    expect(res.statusCode).toBe(200);
    const data = res.json().data;
    expect(data).toHaveLength(2);
    // MC exercise should have nested options
    expect(data[1].options).toHaveLength(2);
    // fill_blank should not have options
    expect(data[0].options).toBeUndefined();
    await app.close();
  });

  it('GET /api/lessons/:lessonId/results returns attempted results', async () => {
    const mockResults = [
      {
        exercise_id: 1,
        type: 'fill_blank',
        question: 'She ___ every day.',
        correct_answer: 'goes',
        user_answer: 'goes',
        is_correct: true,
        attempt_number: 1,
      },
    ];
    const app = await createTestApp({
      exerciseRepoOverrides: {
        findResultsByLesson: async () => mockResults,
      },
    });
    const res = await app.inject({
      method: 'GET',
      url: '/api/lessons/1/results',
      headers: { 'x-session-id': TEST_SESSION },
    });
    expect(res.statusCode).toBe(200);
    const data = res.json().data;
    expect(data).toHaveLength(1);
    expect(data[0].is_correct).toBe(true);
    expect(data[0].attempt_number).toBe(1);
    await app.close();
  });

  it('POST /api/exercises/:id/submit validates and records answer', async () => {
    const app = await createTestApp({
      exerciseRepoOverrides: {
        findTypeById: async () => ({
          id: 1,
          type: 'fill_blank',
          lesson_id: 1,
        }),
        findAnswerForValidation: async () => ({
          correct_answer: 'goes',
          explanation: 'Third person singular uses -es.',
          explanation_vi: 'Ngoi thu ba so it dung -es.',
        }),
      },
    });
    const res = await app.inject({
      method: 'POST',
      url: '/api/exercises/1/submit',
      headers: {
        'content-type': 'application/json',
        'x-session-id': TEST_SESSION,
      },
      payload: { answer: 'goes', timeTaken: 10 },
    });
    expect(res.statusCode).toBe(200);
    const data = res.json().data;
    expect(data.isCorrect).toBe(true);
    expect(data.explanation).toBe('Third person singular uses -es.');
    await app.close();
  });

  it('POST /api/exercises/:id/submit returns incorrect for wrong answer', async () => {
    const app = await createTestApp({
      exerciseRepoOverrides: {
        findTypeById: async () => ({
          id: 1,
          type: 'fill_blank',
          lesson_id: 1,
        }),
        findAnswerForValidation: async () => ({
          correct_answer: 'goes',
          explanation: 'Third person singular uses -es.',
          explanation_vi: 'Ngoi thu ba so it dung -es.',
        }),
      },
    });
    const res = await app.inject({
      method: 'POST',
      url: '/api/exercises/1/submit',
      headers: {
        'content-type': 'application/json',
        'x-session-id': TEST_SESSION,
      },
      payload: { answer: 'go' },
    });
    expect(res.statusCode).toBe(200);
    expect(res.json().data.isCorrect).toBe(false);
    await app.close();
  });

  it('POST /api/exercises/:id/submit handles matching exercise correctly', async () => {
    const matchingPairs = [
      { id: 1, left_content: 'Cat', right_content: 'Mèo' },
      { id: 2, left_content: 'Dog', right_content: 'Chó' },
    ];
    const app = await createTestApp({
      exerciseRepoOverrides: {
        findTypeById: async () => ({
          id: 10,
          type: 'matching',
          lesson_id: 1,
        }),
        findMatchingPairsForValidation: async () => matchingPairs,
        findExplanationById: async () => ({
          explanation: 'Match animals to translations.',
          explanation_vi: 'Nối động vật với bản dịch.',
        }),
      },
    });
    const res = await app.inject({
      method: 'POST',
      url: '/api/exercises/10/submit',
      headers: {
        'content-type': 'application/json',
        'x-session-id': TEST_SESSION,
      },
      payload: {
        answer: [
          { leftId: 1, rightId: 1 },
          { leftId: 2, rightId: 2 },
        ],
        timeTaken: 15,
      },
    });
    expect(res.statusCode).toBe(200);
    const data = res.json().data;
    expect(data.isCorrect).toBe(true);
    expect(data.explanation).toBe('Match animals to translations.');
    await app.close();
  });

  it('POST /api/exercises/:id/submit returns incorrect for wrong matching', async () => {
    const matchingPairs = [
      { id: 1, left_content: 'Cat', right_content: 'Mèo' },
      { id: 2, left_content: 'Dog', right_content: 'Chó' },
    ];
    const app = await createTestApp({
      exerciseRepoOverrides: {
        findTypeById: async () => ({
          id: 10,
          type: 'matching',
          lesson_id: 1,
        }),
        findMatchingPairsForValidation: async () => matchingPairs,
        findExplanationById: async () => ({
          explanation: 'Match animals to translations.',
          explanation_vi: 'Nối động vật với bản dịch.',
        }),
      },
    });
    const res = await app.inject({
      method: 'POST',
      url: '/api/exercises/10/submit',
      headers: {
        'content-type': 'application/json',
        'x-session-id': TEST_SESSION,
      },
      payload: {
        answer: [
          { leftId: 1, rightId: 2 },
          { leftId: 2, rightId: 1 },
        ],
      },
    });
    expect(res.statusCode).toBe(200);
    expect(res.json().data.isCorrect).toBe(false);
    await app.close();
  });
});
