# API Reference — Learning Hub

**Base URL**: `http://localhost:3001` (dev) — proxied via Vite to `/api`
**Auth**: None. Session identified by `X-Session-Id: <UUID>` header (auto-injected by `src/api/client.js`)
**Rate limit**: 100 req/min per IP (`@fastify/rate-limit`)
**Error shape**: `{ error: string, message: string, statusCode: number }`

---

## Home / Navigation

### `GET /api/home`

BFF endpoint — returns full homepage data in one round-trip (replaces 14 individual requests).

**Response**:

```json
{
  "data": {
    "topics": [
      {
        "id": 1,
        "name": "Computer Science",
        "name_vi": "Khoa học Máy tính",
        "icon": "Code",
        "color": "#6366f1",
        "groups": [
          {
            "id": 5,
            "name": "Python Basics",
            "lessons": [
              {
                "id": 10,
                "name": "Variables & Types",
                "slug": "python-variables",
                "difficulty": "beginner",
                "exerciseCount": 8,
                "progress": { "status": "completed", "bestScore": 95 }
              }
            ]
          }
        ]
      }
    ],
    "featuredPaths": [{ "id": 1, "name": "Python Starter", "stepCount": 5 }]
  }
}
```

---

## Categories / Groups

### `GET /api/groups`

Returns all categories (flat list, no lessons).

**Response**: `{ "data": [ { "id", "name", "name_vi", "icon", "color", "order_index" } ] }`

### `GET /api/groups/:groupId/lessons`

Returns all published lessons for a category.

**Response**: `{ "data": [ { "id", "name", "slug", "difficulty", "exerciseCount" } ] }`

---

## Lessons

### `GET /api/lessons/search?q=<query>`

Full-text search on lesson name/name_vi. Falls back to ILIKE if FTS index unavailable.

**Query params**: `q` (min 2 chars)
**Response**: `{ "data": [ { "id", "name", "name_vi", "slug", "short_desc", "group_name" } ] }`
**Note**: Results ranked by `ts_rank` + fuzzy similarity. Returns max 20 results.

### `GET /api/lessons/:slug`

BFF — returns full lesson detail: theory, sections, formulas, usages, tips, progress.

**Response**:

```json
{
  "data": {
    "lesson": { "id", "name", "slug", "difficulty", "description", ... },
    "sections": [ { "id", "type", "title", "content", "metadata", "order_index" } ],
    "formulas": [ { "type", "structure", "example", ... } ],
    "usages": [ { "title", "description", "examples": [...] } ],
    "signalWords": [ { "word", "category", "position" } ],
    "tips": [ { "title", "content", "category", "importance" } ],
    "comparisons": [ { "aspect", "lesson_1_point", "lesson_2_point" } ],
    "progress": { "status", "theoryCompleted", "currentScore", "bestScore" }
  }
}
```

### `GET /api/lessons/:lessonId/exercises`

BFF — returns all exercises for a lesson. **Never returns `correct_answer` or `is_correct`.**

**Response**:

```json
{
  "data": {
    "exercises": [
      {
        "id", "type", "difficulty", "question", "question_vi",
        "content", "word_bank", "hint", "image_url", "audio_url", "points",
        "options": [ { "id", "label", "content" } ],
        "pairs": [ { "id", "left_content", "right_content" } ]
      }
    ],
    "lesson": { "id", "name" },
    "progress": { "status", "bestScore" }
  }
}
```

### `GET /api/lessons/:lessonId/results`

Returns exercise results for a session. Uses INNER JOIN on attempts — only returns exercises the session has attempted.

**Response**:

```json
{
  "data": {
    "results": [
      {
        "exerciseId", "question", "userAnswer", "correctAnswer",
        "isCorrect", "explanation", "attemptNumber"
      }
    ],
    "progress": { "currentScore", "bestScore", "exercisesCorrect", "exercisesAttempted" }
  }
}
```

---

## Exercises

### `POST /api/exercises/:exerciseId/submit`

Submit an answer. Validates server-side, records attempt, updates progress.

**Headers**: `X-Session-Id: <UUID>` (required)
**Body**: `{ "answer": string | string[] | [{leftId, rightId}] }`
**Response**:

```json
{
  "data": {
    "isCorrect": true,
    "correctAnswer": "She has been studying",
    "explanation": "Present Perfect Continuous for ongoing actions",
    "points": 10,
    "attemptNumber": 1
  }
}
```

---

## Progress

### `GET /api/progress/session/dashboard`

BFF — returns full dashboard: stats, per-category progress, review stats, weak spots.

**Response**:

```json
{
  "data": {
    "stats": { "totalLessons", "completedLessons", "totalScore", "totalXP", "streak" },
    "lessons": [ { "id", "name", "status", "bestScore", "exercisesCorrect" } ],
    "reviewStats": { "dueCount", "totalReviewed", "averageEaseFactor" },
    "weakSpots": [ { "exerciseId", "question", "incorrectCount", "lessonName" } ]
  }
}
```

### `GET /api/progress/session/overview`

Lightweight overview for the current session (no per-lesson detail).

### `GET /api/progress/:lessonId`

Progress for a specific lesson in the current session.

### `POST /api/progress/:lessonId/theory-complete`

Marks theory as completed for the lesson.

**Body**: `{}` (empty)
**Response**: `{ "data": { "status": "in_progress", "theoryCompleted": true } }`

### `POST /api/progress/:lessonId/reset`

Resets all progress for a lesson (deletes attempts, resets progress row).

**Body**: `{}` (empty)
**Response**: `{ "data": { "status": "not_started" } }`

---

## Session Export / Import

### `GET /api/progress/session/export`

Exports all session progress as JSON file download.

### `POST /api/progress/session/import`

Imports session data from exported JSON.

---

## Spaced Repetition (SM-2 Review)

### `GET /api/review/due`

Returns exercises due for review today + review stats.

**Response**: `{ "data": [...exercises], "stats": { "dueCount", "totalReviewed" } }`

### `POST /api/review/:exerciseId/submit`

Submits a review answer. Updates SM-2 state (ease_factor, interval_days, next_review_at).

---

## Learning Paths

### `GET /api/learning-paths`

Returns all available learning paths with step counts.

### `GET /api/learning-paths/:pathId`

Returns full path detail with all steps (lessons in order).

### `POST /api/learning-paths/:pathId/enroll`

Enrolls session in a learning path.

---

## Gamification

### `GET /api/gamification/profile`

Returns XP total, streak, achievements, daily activity.

### `GET /api/weak-spots`

Returns exercises with highest incorrect rate for the session.

---

## Error Codes

| Status | Error class       | When                                        |
| ------ | ----------------- | ------------------------------------------- |
| 400    | `ValidationError` | Invalid input (JSON schema, missing fields) |
| 404    | `NotFoundError`   | Resource doesn't exist                      |
| 429    | —                 | Rate limit exceeded (100 req/min)           |
| 500    | `AppError`        | Unexpected server error                     |
