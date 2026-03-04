# Phase 2B: Exercise CRUD Admin — Implementation Plan

> Full CRUD for Exercises with type-specific child table management (options, matching pairs).
> Drag-and-drop reorder, full-page form with dynamic type-specific editors, toggle active.
> 8 exercise types: multiple_choice, fill_blank, error_correction, sentence_transform, arrange_words, matching, true_false, code_output.
> Estimated files: ~10 new files (3 server, 7 client), ~4 modified files

---

## Table of Contents

1. [Overview](#section-1-overview)
2. [Dependencies](#section-2-dependencies)
3. [Database Migrations](#section-3-database-migrations)
4. [File Structure](#section-4-file-structure)
5. [API Contracts](#section-5-api-contracts)
6. [Backend Implementation](#section-6-backend-implementation)
7. [Frontend Implementation](#section-7-frontend-implementation)
8. [UX Design Decisions](#section-8-ux-design-decisions)
9. [Security Considerations](#section-9-security-considerations)
10. [CI Compatibility](#section-10-ci-compatibility)
11. [Appendix](#section-11-appendix)

---

## SECTION 1: Overview

Phase 2B adds full CRUD for exercises to the admin dashboard. Exercises are the most complex entity because:

1. **8 exercise types** — each type uses different fields from the `exercise` table
2. **2 child tables** — `exercise_option` (multiple_choice only) and `matching_pair` (matching only)
3. **Transactional integrity** — creating/updating multiple_choice or matching exercises requires atomic multi-table operations
4. **Type immutability** — once created, an exercise's type cannot change (would break child table relationships)

The plan follows Phase 2A patterns exactly: separate repository/controller/routes files, Composition Root DI wiring, fire-and-forget audit logging, Fastify JSON Schema validation, and React Router v7 loaders for data fetching.

---

## SECTION 2: Dependencies

### Root (client) — NO new dependencies

All required packages are already installed from Phase 2A:

- `@tanstack/react-table` — data table (AdminDataTable)
- `@dnd-kit/core`, `@dnd-kit/sortable`, `@dnd-kit/utilities` — drag-and-drop reorder

### Server — NO new dependencies

All server deps already installed (Fastify, postgres.js, @fastify/cookie, @fastify/jwt).

---

## SECTION 3: Database Migrations

### NO migrations needed

The schema already has all required tables and ENUMs:

- `exercise` table with all 8 type columns
- `exercise_option` table with label ENUM (A-F)
- `matching_pair` table with left/right content
- `exercise_type` ENUM with all 8 values
- `exercise_difficulty` ENUM (easy, medium, hard)
- `option_label` ENUM (A, B, C, D, E, F)
- CASCADE delete on `exercise.lesson_id` — child tables auto-clean

---

## SECTION 4: File Structure

### Server (new files)

```
server/
├── repositories/
│   └── adminExerciseRepository.js    ★ NEW — Exercise CRUD queries (with child tables)
├── controllers/
│   └── adminExerciseController.js    ★ NEW — Handler methods for all exercise operations
└── routes/
    └── adminExerciseRoutes.js        ★ NEW — Route definitions with JSON Schema validation
```

### Server (modified files)

```
server/
├── index.js                          MOD — wire AdminExerciseRepository + AdminExerciseController
└── app.js                            MOD — register adminExerciseRoutes
```

### Client (new files)

```
src/
├── pages/admin/
│   ├── AdminExercisesPage.jsx        ★ NEW — Exercise list per lesson, with dnd-kit reorder
│   └── AdminExerciseFormPage.jsx     ★ NEW — Full-page form with type-specific editors
└── components/admin/exercise/
    ├── ExerciseTypeSelector.jsx      ★ NEW — Type selection with field requirements info
    ├── MultipleChoiceEditor.jsx      ★ NEW — Options editor (add/remove/reorder, one-correct toggle)
    ├── MatchingPairEditor.jsx        ★ NEW — Pairs editor (add/remove left/right pairs)
    ├── ArrangeWordsEditor.jsx        ★ NEW — Word bank JSONB array editor
    └── CommonFieldsEditor.jsx        ★ NEW — Shared fields (question, content, answer, hints, etc.)
```

### Client (modified files)

```
src/
├── api/admin.js                      MOD — add exercise CRUD API functions
└── router.jsx                        MOD — add exercise admin routes
```

---

## SECTION 5: API Contracts

All admin exercise endpoints require `adminAuth` middleware (JWT cookie). All return `{ data: ... }` on success or `{ error: "message" }` on failure.

### 5.1 List Exercises

```
GET /api/admin/exercises?lessonId=N
```

**Query parameters:**

| Param      | Type   | Required | Description                |
| ---------- | ------ | -------- | -------------------------- |
| `lessonId` | number | YES      | Filter exercises by lesson |

**Response:** `{ data: { lesson: Lesson, exercises: Exercise[] } }`

Each exercise includes:

- All exercise table columns
- `options: ExerciseOption[]` (populated only for type=multiple_choice)
- `matching_pairs: MatchingPair[]` (populated only for type=matching)

Ordered by `order_index, id`.

### 5.2 Get Single Exercise

```
GET /api/admin/exercises/:id
```

**Params:** `id` — exercise ID (integer as string, pattern `^\d+$`)

**Response:** `{ data: Exercise }` — includes options/pairs, plus `lesson_name` and `lesson_id`.

**Errors:** 404 if not found.

### 5.3 Create Exercise

```
POST /api/admin/exercises
```

**Request body (ExerciseCreateBody):**

```json
{
  "lesson_id": 1,
  "type": "multiple_choice",
  "difficulty": "medium",
  "question": "What is the correct form?",
  "question_vi": "Dạng đúng là gì?",
  "context": null,
  "context_vi": null,
  "content": null,
  "content_vi": null,
  "correct_answer": null,
  "word_bank": null,
  "explanation": "Because...",
  "explanation_vi": "Vì...",
  "hint": "Think about tense",
  "hint_vi": "Hãy nghĩ về thì",
  "image_url": null,
  "audio_url": null,
  "points": 10,
  "time_limit": null,
  "is_active": true,
  "options": [
    {
      "label": "A",
      "content": "goes",
      "content_vi": null,
      "is_correct": true,
      "explanation": "Correct!",
      "explanation_vi": null
    },
    {
      "label": "B",
      "content": "go",
      "content_vi": null,
      "is_correct": false,
      "explanation": "Wrong tense",
      "explanation_vi": null
    },
    {
      "label": "C",
      "content": "going",
      "content_vi": null,
      "is_correct": false,
      "explanation": null,
      "explanation_vi": null
    }
  ],
  "matching_pairs": null
}
```

**Schema rules:**

- `lesson_id` — required integer
- `type` — required, one of 8 exercise_type ENUM values
- `difficulty` — optional, defaults to "medium", one of: easy, medium, hard
- `question` — required string
- `options` — required array (2-6 items) when type=multiple_choice, null/omitted otherwise
- `matching_pairs` — required array (2-8 items) when type=matching, null/omitted otherwise
- `correct_answer` — required for fill_blank, error_correction, sentence_transform, true_false, arrange_words, code_output
- `word_bank` — required JSONB array for arrange_words
- `content` — required for fill_blank, error_correction, sentence_transform, true_false, code_output

**Response:** `{ data: Exercise }` — created exercise with all fields + options/pairs.

**Transaction behavior:**

- `multiple_choice` → INSERT exercise + INSERT all options in single transaction
- `matching` → INSERT exercise + INSERT all pairs in single transaction
- Other types → simple INSERT into exercise table (no transaction needed)

### 5.4 Update Exercise

```
PUT /api/admin/exercises/:id
```

**Request body (ExerciseUpdateBody):** Same shape as create body, all fields optional except `type` is NOT updatable.

**Transaction behavior (for child tables — delete-and-recreate):**

- `multiple_choice` → In transaction: DELETE all existing options → INSERT new options → UPDATE exercise
- `matching` → In transaction: DELETE all existing pairs → INSERT new pairs → UPDATE exercise
- Other types → simple UPDATE of exercise table

**Response:** `{ data: Exercise }` — updated exercise with refreshed options/pairs.

### 5.5 Delete Exercise

```
DELETE /api/admin/exercises/:id
```

**Response:** `{ data: { id } }`

CASCADE delete handles child rows (options, pairs, attempts, reviews).

### 5.6 Reorder Exercises

```
POST /api/admin/exercises/reorder
```

**Request body:**

```json
{
  "lessonId": 1,
  "orderedIds": [5, 3, 8, 1]
}
```

**Response:** `{ data: { ok: true } }`

Uses gap-based reorder (index \* 1000) within a transaction.

### 5.7 Toggle Active

```
PUT /api/admin/exercises/:id/toggle-active
```

**Request body:**

```json
{
  "is_active": false
}
```

**Response:** `{ data: Exercise }` — exercise with toggled is_active.

---

## SECTION 6: Backend Implementation

### 6.1 Repository: `server/repositories/adminExerciseRepository.js`

```js
import { NotFoundError } from '../errors/AppError.js';

export class AdminExerciseRepository {
  constructor(sql) {
    this.sql = sql;
  }
```

#### 6.1.1 `findExercisesByLesson(lessonId)`

```js
async findExercisesByLesson(lessonId) {
  // Verify lesson exists
  const [lesson] = await this.sql`
    SELECT l.id, l.name, l.name_vi, l.slug
    FROM lesson l WHERE l.id = ${lessonId}
  `;
  if (!lesson) throw new NotFoundError('Lesson');

  // Get all exercises for this lesson
  const exercises = await this.sql`
    SELECT * FROM exercise
    WHERE lesson_id = ${lessonId}
    ORDER BY order_index, id
  `;

  if (exercises.length === 0) return { lesson, exercises: [] };

  // Fetch options for multiple_choice exercises
  const mcIds = exercises.filter(e => e.type === 'multiple_choice').map(e => e.id);
  const options = mcIds.length > 0
    ? await this.sql`
        SELECT * FROM exercise_option
        WHERE exercise_id IN ${this.sql(mcIds)}
        ORDER BY order_index, id
      `
    : [];

  // Fetch pairs for matching exercises
  const matchIds = exercises.filter(e => e.type === 'matching').map(e => e.id);
  const pairs = matchIds.length > 0
    ? await this.sql`
        SELECT * FROM matching_pair
        WHERE exercise_id IN ${this.sql(matchIds)}
        ORDER BY order_index, id
      `
    : [];

  // Merge child rows onto exercises
  const optionsByExId = groupBy(options, 'exercise_id');
  const pairsByExId = groupBy(pairs, 'exercise_id');

  const enriched = exercises.map(ex => ({
    ...ex,
    options: optionsByExId[ex.id] || [],
    matching_pairs: pairsByExId[ex.id] || [],
  }));

  return { lesson, exercises: enriched };
}
```

**Helper (top of file, not exported):**

```js
function groupBy(arr, key) {
  const map = {};
  for (const item of arr) {
    const k = item[key];
    if (!map[k]) map[k] = [];
    map[k].push(item);
  }
  return map;
}
```

#### 6.1.2 `findExerciseById(id)`

```js
async findExerciseById(id) {
  const [exercise] = await this.sql`
    SELECT e.*, l.name AS lesson_name
    FROM exercise e
    JOIN lesson l ON l.id = e.lesson_id
    WHERE e.id = ${id}
  `;
  if (!exercise) throw new NotFoundError('Exercise');

  if (exercise.type === 'multiple_choice') {
    exercise.options = await this.sql`
      SELECT * FROM exercise_option
      WHERE exercise_id = ${id}
      ORDER BY order_index, id
    `;
  } else {
    exercise.options = [];
  }

  if (exercise.type === 'matching') {
    exercise.matching_pairs = await this.sql`
      SELECT * FROM matching_pair
      WHERE exercise_id = ${id}
      ORDER BY order_index, id
    `;
  } else {
    exercise.matching_pairs = [];
  }

  return exercise;
}
```

#### 6.1.3 `createExercise(data)`

```js
async createExercise(data) {
  const { options, matching_pairs, ...exerciseData } = data;

  // Auto-assign order_index
  const [{ max_order }] = await this.sql`
    SELECT COALESCE(MAX(order_index), 0)::int AS max_order
    FROM exercise WHERE lesson_id = ${exerciseData.lesson_id}
  `;

  if (exerciseData.type === 'multiple_choice' && options?.length) {
    return this.sql.begin(async (tx) => {
      const [exercise] = await tx`
        INSERT INTO exercise (
          lesson_id, type, difficulty, question, question_vi,
          context, context_vi, content, content_vi,
          correct_answer, word_bank,
          explanation, explanation_vi, hint, hint_vi,
          image_url, audio_url, points, time_limit,
          is_active, order_index
        ) VALUES (
          ${exerciseData.lesson_id}, ${exerciseData.type},
          ${exerciseData.difficulty || 'medium'},
          ${exerciseData.question}, ${exerciseData.question_vi || null},
          ${exerciseData.context || null}, ${exerciseData.context_vi || null},
          ${exerciseData.content || null}, ${exerciseData.content_vi || null},
          ${exerciseData.correct_answer || null}, ${exerciseData.word_bank || null},
          ${exerciseData.explanation || null}, ${exerciseData.explanation_vi || null},
          ${exerciseData.hint || null}, ${exerciseData.hint_vi || null},
          ${exerciseData.image_url || null}, ${exerciseData.audio_url || null},
          ${exerciseData.points ?? 10}, ${exerciseData.time_limit || null},
          ${exerciseData.is_active ?? true},
          ${max_order + 1000}
        ) RETURNING *
      `;

      const insertedOptions = [];
      for (let i = 0; i < options.length; i++) {
        const opt = options[i];
        const [row] = await tx`
          INSERT INTO exercise_option (
            exercise_id, label, content, content_vi,
            is_correct, explanation, explanation_vi, order_index
          ) VALUES (
            ${exercise.id}, ${opt.label}, ${opt.content},
            ${opt.content_vi || null}, ${opt.is_correct || false},
            ${opt.explanation || null}, ${opt.explanation_vi || null},
            ${i * 1000}
          ) RETURNING *
        `;
        insertedOptions.push(row);
      }

      return { ...exercise, options: insertedOptions, matching_pairs: [] };
    });
  }

  if (exerciseData.type === 'matching' && matching_pairs?.length) {
    return this.sql.begin(async (tx) => {
      const [exercise] = await tx`
        INSERT INTO exercise (
          lesson_id, type, difficulty, question, question_vi,
          context, context_vi, content, content_vi,
          correct_answer, word_bank,
          explanation, explanation_vi, hint, hint_vi,
          image_url, audio_url, points, time_limit,
          is_active, order_index
        ) VALUES (
          ${exerciseData.lesson_id}, ${exerciseData.type},
          ${exerciseData.difficulty || 'medium'},
          ${exerciseData.question}, ${exerciseData.question_vi || null},
          ${exerciseData.context || null}, ${exerciseData.context_vi || null},
          ${exerciseData.content || null}, ${exerciseData.content_vi || null},
          ${exerciseData.correct_answer || null}, ${exerciseData.word_bank || null},
          ${exerciseData.explanation || null}, ${exerciseData.explanation_vi || null},
          ${exerciseData.hint || null}, ${exerciseData.hint_vi || null},
          ${exerciseData.image_url || null}, ${exerciseData.audio_url || null},
          ${exerciseData.points ?? 10}, ${exerciseData.time_limit || null},
          ${exerciseData.is_active ?? true},
          ${max_order + 1000}
        ) RETURNING *
      `;

      const insertedPairs = [];
      for (let i = 0; i < matching_pairs.length; i++) {
        const pair = matching_pairs[i];
        const [row] = await tx`
          INSERT INTO matching_pair (
            exercise_id, left_content, left_content_vi,
            right_content, right_content_vi, order_index
          ) VALUES (
            ${exercise.id}, ${pair.left_content},
            ${pair.left_content_vi || null},
            ${pair.right_content}, ${pair.right_content_vi || null},
            ${i * 1000}
          ) RETURNING *
        `;
        insertedPairs.push(row);
      }

      return { ...exercise, options: [], matching_pairs: insertedPairs };
    });
  }

  // Simple types — no child tables
  const [exercise] = await this.sql`
    INSERT INTO exercise (
      lesson_id, type, difficulty, question, question_vi,
      context, context_vi, content, content_vi,
      correct_answer, word_bank,
      explanation, explanation_vi, hint, hint_vi,
      image_url, audio_url, points, time_limit,
      is_active, order_index
    ) VALUES (
      ${exerciseData.lesson_id}, ${exerciseData.type},
      ${exerciseData.difficulty || 'medium'},
      ${exerciseData.question}, ${exerciseData.question_vi || null},
      ${exerciseData.context || null}, ${exerciseData.context_vi || null},
      ${exerciseData.content || null}, ${exerciseData.content_vi || null},
      ${exerciseData.correct_answer || null}, ${exerciseData.word_bank || null},
      ${exerciseData.explanation || null}, ${exerciseData.explanation_vi || null},
      ${exerciseData.hint || null}, ${exerciseData.hint_vi || null},
      ${exerciseData.image_url || null}, ${exerciseData.audio_url || null},
      ${exerciseData.points ?? 10}, ${exerciseData.time_limit || null},
      ${exerciseData.is_active ?? true},
      ${max_order + 1000}
    ) RETURNING *
  `;

  return { ...exercise, options: [], matching_pairs: [] };
}
```

#### 6.1.4 `updateExercise(id, data)`

```js
async updateExercise(id, data) {
  const existing = await this.findExerciseById(id);
  const { options, matching_pairs, ...exerciseData } = data;

  // Build update — merge with existing (same pattern as Phase 2A)
  const merged = {
    difficulty: exerciseData.difficulty ?? existing.difficulty,
    question: exerciseData.question ?? existing.question,
    question_vi: exerciseData.question_vi !== undefined ? exerciseData.question_vi : existing.question_vi,
    context: exerciseData.context !== undefined ? exerciseData.context : existing.context,
    context_vi: exerciseData.context_vi !== undefined ? exerciseData.context_vi : existing.context_vi,
    content: exerciseData.content !== undefined ? exerciseData.content : existing.content,
    content_vi: exerciseData.content_vi !== undefined ? exerciseData.content_vi : existing.content_vi,
    correct_answer: exerciseData.correct_answer !== undefined ? exerciseData.correct_answer : existing.correct_answer,
    word_bank: exerciseData.word_bank !== undefined ? exerciseData.word_bank : existing.word_bank,
    explanation: exerciseData.explanation !== undefined ? exerciseData.explanation : existing.explanation,
    explanation_vi: exerciseData.explanation_vi !== undefined ? exerciseData.explanation_vi : existing.explanation_vi,
    hint: exerciseData.hint !== undefined ? exerciseData.hint : existing.hint,
    hint_vi: exerciseData.hint_vi !== undefined ? exerciseData.hint_vi : existing.hint_vi,
    image_url: exerciseData.image_url !== undefined ? exerciseData.image_url : existing.image_url,
    audio_url: exerciseData.audio_url !== undefined ? exerciseData.audio_url : existing.audio_url,
    points: exerciseData.points ?? existing.points,
    time_limit: exerciseData.time_limit !== undefined ? exerciseData.time_limit : existing.time_limit,
    is_active: exerciseData.is_active !== undefined ? exerciseData.is_active : existing.is_active,
  };

  // For types with child tables: delete-and-recreate in transaction
  if (existing.type === 'multiple_choice' && options) {
    return this.sql.begin(async (tx) => {
      const [updated] = await tx`
        UPDATE exercise SET
          difficulty = ${merged.difficulty}, question = ${merged.question},
          question_vi = ${merged.question_vi}, context = ${merged.context},
          context_vi = ${merged.context_vi}, content = ${merged.content},
          content_vi = ${merged.content_vi}, correct_answer = ${merged.correct_answer},
          word_bank = ${merged.word_bank}, explanation = ${merged.explanation},
          explanation_vi = ${merged.explanation_vi}, hint = ${merged.hint},
          hint_vi = ${merged.hint_vi}, image_url = ${merged.image_url},
          audio_url = ${merged.audio_url}, points = ${merged.points},
          time_limit = ${merged.time_limit}, is_active = ${merged.is_active}
        WHERE id = ${id}
        RETURNING *
      `;

      // Delete-and-recreate options
      await tx`DELETE FROM exercise_option WHERE exercise_id = ${id}`;
      const newOptions = [];
      for (let i = 0; i < options.length; i++) {
        const opt = options[i];
        const [row] = await tx`
          INSERT INTO exercise_option (
            exercise_id, label, content, content_vi,
            is_correct, explanation, explanation_vi, order_index
          ) VALUES (
            ${id}, ${opt.label}, ${opt.content},
            ${opt.content_vi || null}, ${opt.is_correct || false},
            ${opt.explanation || null}, ${opt.explanation_vi || null},
            ${i * 1000}
          ) RETURNING *
        `;
        newOptions.push(row);
      }

      return { ...updated, options: newOptions, matching_pairs: [] };
    });
  }

  if (existing.type === 'matching' && matching_pairs) {
    return this.sql.begin(async (tx) => {
      const [updated] = await tx`
        UPDATE exercise SET
          difficulty = ${merged.difficulty}, question = ${merged.question},
          question_vi = ${merged.question_vi}, context = ${merged.context},
          context_vi = ${merged.context_vi}, content = ${merged.content},
          content_vi = ${merged.content_vi}, correct_answer = ${merged.correct_answer},
          word_bank = ${merged.word_bank}, explanation = ${merged.explanation},
          explanation_vi = ${merged.explanation_vi}, hint = ${merged.hint},
          hint_vi = ${merged.hint_vi}, image_url = ${merged.image_url},
          audio_url = ${merged.audio_url}, points = ${merged.points},
          time_limit = ${merged.time_limit}, is_active = ${merged.is_active}
        WHERE id = ${id}
        RETURNING *
      `;

      // Delete-and-recreate matching pairs
      await tx`DELETE FROM matching_pair WHERE exercise_id = ${id}`;
      const newPairs = [];
      for (let i = 0; i < matching_pairs.length; i++) {
        const pair = matching_pairs[i];
        const [row] = await tx`
          INSERT INTO matching_pair (
            exercise_id, left_content, left_content_vi,
            right_content, right_content_vi, order_index
          ) VALUES (
            ${id}, ${pair.left_content},
            ${pair.left_content_vi || null},
            ${pair.right_content}, ${pair.right_content_vi || null},
            ${i * 1000}
          ) RETURNING *
        `;
        newPairs.push(row);
      }

      return { ...updated, options: [], matching_pairs: newPairs };
    });
  }

  // Simple types — just update exercise table
  const [updated] = await this.sql`
    UPDATE exercise SET
      difficulty = ${merged.difficulty}, question = ${merged.question},
      question_vi = ${merged.question_vi}, context = ${merged.context},
      context_vi = ${merged.context_vi}, content = ${merged.content},
      content_vi = ${merged.content_vi}, correct_answer = ${merged.correct_answer},
      word_bank = ${merged.word_bank}, explanation = ${merged.explanation},
      explanation_vi = ${merged.explanation_vi}, hint = ${merged.hint},
      hint_vi = ${merged.hint_vi}, image_url = ${merged.image_url},
      audio_url = ${merged.audio_url}, points = ${merged.points},
      time_limit = ${merged.time_limit}, is_active = ${merged.is_active}
    WHERE id = ${id}
    RETURNING *
  `;

  return { ...updated, options: existing.options, matching_pairs: existing.matching_pairs };
}
```

#### 6.1.5 `deleteExercise(id)`

```js
async deleteExercise(id) {
  await this.findExerciseById(id); // throws 404 if not found
  // CASCADE deletes: exercise_option, matching_pair, user_exercise_attempt, exercise_review
  await this.sql`DELETE FROM exercise WHERE id = ${id}`;
  return { id };
}
```

#### 6.1.6 `reorderExercises(lessonId, orderedIds)`

```js
async reorderExercises(lessonId, orderedIds) {
  await this.sql.begin(async (tx) => {
    for (let i = 0; i < orderedIds.length; i++) {
      await tx`
        UPDATE exercise
        SET order_index = ${i * 1000}
        WHERE id = ${orderedIds[i]} AND lesson_id = ${lessonId}
      `;
    }
  });
}
```

#### 6.1.7 `toggleActive(id, isActive)`

```js
async toggleActive(id, isActive) {
  const [row] = await this.sql`
    UPDATE exercise SET is_active = ${isActive}
    WHERE id = ${id}
    RETURNING *
  `;
  if (!row) throw new NotFoundError('Exercise');
  return row;
}
```

### 6.2 Controller: `server/controllers/adminExerciseController.js`

```js
import { ValidationError } from '../errors/AppError.js';

export class AdminExerciseController {
  constructor(adminExerciseRepo, adminRepo) {
    this.repo = adminExerciseRepo;
    this.adminRepo = adminRepo; // for audit logging
  }

  listExercises = async (request) => {
    const lessonId = parseInt(request.query.lessonId, 10);
    if (!lessonId) throw new ValidationError('lessonId is required');
    const data = await this.repo.findExercisesByLesson(lessonId);
    return { data };
  };

  getExerciseById = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.findExerciseById(id);
    return { data };
  };

  createExercise = async (request) => {
    const data = await this.repo.createExercise(request.body);
    this.adminRepo.logAction({
      action: 'create',
      entityType: 'exercise',
      entityId: data.id,
      metadata: { type: data.type, lessonId: data.lesson_id },
      ipAddress: request.ip,
    });
    return { data };
  };

  updateExercise = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.updateExercise(id, request.body);
    this.adminRepo.logAction({
      action: 'update',
      entityType: 'exercise',
      entityId: id,
      metadata: { fields: Object.keys(request.body) },
      ipAddress: request.ip,
    });
    return { data };
  };

  deleteExercise = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.deleteExercise(id);
    this.adminRepo.logAction({
      action: 'delete',
      entityType: 'exercise',
      entityId: id,
      ipAddress: request.ip,
    });
    return { data };
  };

  reorderExercises = async (request) => {
    const { lessonId, orderedIds } = request.body;
    if (!Array.isArray(orderedIds) || orderedIds.length === 0) {
      throw new ValidationError('orderedIds must be a non-empty array');
    }
    await this.repo.reorderExercises(lessonId, orderedIds);
    this.adminRepo.logAction({
      action: 'reorder',
      entityType: 'exercise',
      metadata: { lessonId, orderedIds },
      ipAddress: request.ip,
    });
    return { data: { ok: true } };
  };

  toggleActive = async (request) => {
    const id = parseInt(request.params.id, 10);
    const { is_active } = request.body;
    const data = await this.repo.toggleActive(id, is_active);
    this.adminRepo.logAction({
      action: 'toggle_active',
      entityType: 'exercise',
      entityId: id,
      metadata: { is_active },
      ipAddress: request.ip,
    });
    return { data };
  };
}
```

### 6.3 Routes: `server/routes/adminExerciseRoutes.js`

```js
export function adminExerciseRoutes(controller, adminAuth) {
  return async function (fastify) {
    fastify.addHook('preHandler', adminAuth);

    const idParams = {
      type: 'object',
      required: ['id'],
      properties: { id: { type: 'string', pattern: '^\\d+$' } },
    };

    const exerciseTypes = [
      'multiple_choice',
      'fill_blank',
      'error_correction',
      'sentence_transform',
      'arrange_words',
      'matching',
      'true_false',
      'code_output',
    ];

    const difficultyValues = ['easy', 'medium', 'hard'];
    const optionLabels = ['A', 'B', 'C', 'D', 'E', 'F'];

    // Shared option schema (for create/update body)
    const optionSchema = {
      type: 'object',
      required: ['label', 'content'],
      properties: {
        label: { type: 'string', enum: optionLabels },
        content: { type: 'string', maxLength: 500 },
        content_vi: { type: ['string', 'null'], maxLength: 500 },
        is_correct: { type: 'boolean' },
        explanation: { type: ['string', 'null'] },
        explanation_vi: { type: ['string', 'null'] },
      },
    };

    const matchingPairSchema = {
      type: 'object',
      required: ['left_content', 'right_content'],
      properties: {
        left_content: { type: 'string', maxLength: 300 },
        left_content_vi: { type: ['string', 'null'], maxLength: 300 },
        right_content: { type: 'string', maxLength: 300 },
        right_content_vi: { type: ['string', 'null'], maxLength: 300 },
      },
    };

    // ─── LIST ─────────────────────────────────────────────────
    fastify.get('/exercises', {
      schema: {
        querystring: {
          type: 'object',
          required: ['lessonId'],
          properties: {
            lessonId: { type: 'string', pattern: '^\\d+$' },
          },
        },
      },
      handler: controller.listExercises,
    });

    // ─── GET BY ID ────────────────────────────────────────────
    fastify.get('/exercises/:id', {
      schema: { params: idParams },
      handler: controller.getExerciseById,
    });

    // ─── CREATE ───────────────────────────────────────────────
    fastify.post('/exercises', {
      schema: {
        body: {
          type: 'object',
          required: ['lesson_id', 'type', 'question'],
          properties: {
            lesson_id: { type: 'integer' },
            type: { type: 'string', enum: exerciseTypes },
            difficulty: { type: 'string', enum: difficultyValues },
            question: { type: 'string' },
            question_vi: { type: ['string', 'null'] },
            context: { type: ['string', 'null'] },
            context_vi: { type: ['string', 'null'] },
            content: { type: ['string', 'null'] },
            content_vi: { type: ['string', 'null'] },
            correct_answer: { type: ['string', 'null'], maxLength: 500 },
            word_bank: {
              oneOf: [
                { type: 'null' },
                { type: 'array', items: { type: 'string' } },
              ],
            },
            explanation: { type: ['string', 'null'] },
            explanation_vi: { type: ['string', 'null'] },
            hint: { type: ['string', 'null'], maxLength: 255 },
            hint_vi: { type: ['string', 'null'], maxLength: 255 },
            image_url: { type: ['string', 'null'], maxLength: 500 },
            audio_url: { type: ['string', 'null'], maxLength: 500 },
            points: { type: 'integer', minimum: 0, maximum: 100 },
            time_limit: { type: ['integer', 'null'], minimum: 0 },
            is_active: { type: 'boolean' },
            options: {
              oneOf: [
                { type: 'null' },
                {
                  type: 'array',
                  items: optionSchema,
                  minItems: 2,
                  maxItems: 6,
                },
              ],
            },
            matching_pairs: {
              oneOf: [
                { type: 'null' },
                {
                  type: 'array',
                  items: matchingPairSchema,
                  minItems: 2,
                  maxItems: 8,
                },
              ],
            },
          },
        },
      },
      handler: controller.createExercise,
    });

    // ─── UPDATE ───────────────────────────────────────────────
    fastify.put('/exercises/:id', {
      schema: {
        params: idParams,
        body: {
          type: 'object',
          properties: {
            difficulty: { type: 'string', enum: difficultyValues },
            question: { type: 'string' },
            question_vi: { type: ['string', 'null'] },
            context: { type: ['string', 'null'] },
            context_vi: { type: ['string', 'null'] },
            content: { type: ['string', 'null'] },
            content_vi: { type: ['string', 'null'] },
            correct_answer: { type: ['string', 'null'], maxLength: 500 },
            word_bank: {
              oneOf: [
                { type: 'null' },
                { type: 'array', items: { type: 'string' } },
              ],
            },
            explanation: { type: ['string', 'null'] },
            explanation_vi: { type: ['string', 'null'] },
            hint: { type: ['string', 'null'], maxLength: 255 },
            hint_vi: { type: ['string', 'null'], maxLength: 255 },
            image_url: { type: ['string', 'null'], maxLength: 500 },
            audio_url: { type: ['string', 'null'], maxLength: 500 },
            points: { type: 'integer', minimum: 0, maximum: 100 },
            time_limit: { type: ['integer', 'null'], minimum: 0 },
            is_active: { type: 'boolean' },
            options: {
              oneOf: [
                { type: 'null' },
                {
                  type: 'array',
                  items: optionSchema,
                  minItems: 2,
                  maxItems: 6,
                },
              ],
            },
            matching_pairs: {
              oneOf: [
                { type: 'null' },
                {
                  type: 'array',
                  items: matchingPairSchema,
                  minItems: 2,
                  maxItems: 8,
                },
              ],
            },
          },
        },
      },
      handler: controller.updateExercise,
    });

    // ─── DELETE ────────────────────────────────────────────────
    fastify.delete('/exercises/:id', {
      schema: { params: idParams },
      handler: controller.deleteExercise,
    });

    // ─── REORDER ──────────────────────────────────────────────
    fastify.post('/exercises/reorder', {
      schema: {
        body: {
          type: 'object',
          required: ['lessonId', 'orderedIds'],
          properties: {
            lessonId: { type: 'integer' },
            orderedIds: {
              type: 'array',
              items: { type: 'integer' },
              minItems: 1,
            },
          },
        },
      },
      handler: controller.reorderExercises,
    });

    // ─── TOGGLE ACTIVE ───────────────────────────────────────
    fastify.put('/exercises/:id/toggle-active', {
      schema: {
        params: idParams,
        body: {
          type: 'object',
          required: ['is_active'],
          properties: {
            is_active: { type: 'boolean' },
          },
        },
      },
      handler: controller.toggleActive,
    });
  };
}
```

### 6.4 Wiring Changes

#### `server/index.js` — add imports + Composition Root wiring

Add after existing admin imports:

```js
import { AdminExerciseRepository } from './repositories/adminExerciseRepository.js';
import { AdminExerciseController } from './controllers/adminExerciseController.js';
```

Add after `adminCrudController` instantiation:

```js
const adminExerciseRepo = new AdminExerciseRepository(sql);
const adminExerciseController = new AdminExerciseController(
  adminExerciseRepo,
  adminRepo,
);
```

Add `adminExerciseController` to `createApp()` call.

#### `server/app.js` — register routes

Add import:

```js
import { adminExerciseRoutes } from './routes/adminExerciseRoutes.js';
```

Add `adminExerciseController` to `createApp` destructuring params.

Add route registration (after adminCrudRoutes block):

```js
if (adminExerciseController) {
  app.register(adminExerciseRoutes(adminExerciseController, adminAuth), {
    prefix: '/api/admin',
  });
}
```

---

## SECTION 7: Frontend Implementation

### 7.1 API Functions: `src/api/admin.js`

Add at the bottom of the file:

```js
// ─── EXERCISES CRUD ─────────────────────────────────────────

export function fetchAdminExercises(lessonId) {
  return adminRequest(`/exercises?lessonId=${lessonId}`);
}

export function fetchAdminExercise(id) {
  return adminRequest(`/exercises/${id}`);
}

export function createAdminExercise(data) {
  return adminRequest('/exercises', {
    method: 'POST',
    body: JSON.stringify(data),
  });
}

export function updateAdminExercise(id, data) {
  return adminRequest(`/exercises/${id}`, {
    method: 'PUT',
    body: JSON.stringify(data),
  });
}

export function deleteAdminExercise(id) {
  return adminRequest(`/exercises/${id}`, { method: 'DELETE' });
}

export function reorderAdminExercises(lessonId, orderedIds) {
  return adminRequest('/exercises/reorder', {
    method: 'POST',
    body: JSON.stringify({ lessonId, orderedIds }),
  });
}

export function toggleAdminExerciseActive(id, isActive) {
  return adminRequest(`/exercises/${id}/toggle-active`, {
    method: 'PUT',
    body: JSON.stringify({ is_active: isActive }),
  });
}
```

### 7.2 Router: `src/router.jsx`

Add these routes inside the `/admin` children array (after the sections route):

```jsx
{
  path: 'lessons/:id/exercises',
  lazy: async () => {
    const { default: Component, loader } =
      await import('./pages/admin/AdminExercisesPage.jsx');
    return { Component, loader };
  },
  ErrorBoundary: ErrorPage,
},
{
  path: 'exercises/new',
  lazy: async () => {
    const { default: Component, loader } =
      await import('./pages/admin/AdminExerciseFormPage.jsx');
    return { Component, loader };
  },
  ErrorBoundary: ErrorPage,
},
{
  path: 'exercises/:id/edit',
  lazy: async () => {
    const { default: Component, loader } =
      await import('./pages/admin/AdminExerciseFormPage.jsx');
    return { Component, loader };
  },
  ErrorBoundary: ErrorPage,
},
```

### 7.3 Exercise List Page: `src/pages/admin/AdminExercisesPage.jsx`

**Pattern:** Follows AdminSectionsPage.jsx (inline drag-and-drop list, per-lesson context).

**Loader:**

```js
export async function loader({ params }) {
  return fetchAdminExercises(params.id);
}
```

**Core structure:**

- Header: "Exercises: {lesson.name}" + Back button (navigates to /admin/lessons)
- DndContext with SortableContext for reorder
- Each exercise rendered as a Paper card showing:
  - Drag handle (DragIndicatorIcon)
  - Type chip (color-coded by type)
  - Difficulty chip (easy=success, medium=warning, hard=error)
  - Question text (truncated to ~80 chars)
  - Points badge
  - is_active toggle (Switch — calls toggleAdminExerciseActive fire-and-forget)
  - Edit button (navigates to /admin/exercises/:id/edit)
  - Delete button (opens DeleteConfirmDialog)
- "Add Exercise" button at bottom (navigates to /admin/exercises/new?lessonId=N)

**State management:**

- `useState(loaderData)` + `useEffect([loaderData])` for exercises array
- Optimistic reorder on drag end (update local state, fire-and-forget API call)
- Optimistic toggle active (update local state, fire-and-forget API call)

### 7.4 Exercise Form Page: `src/pages/admin/AdminExerciseFormPage.jsx`

**Pattern:** Follows AdminLessonFormPage.jsx (full-page form, create/edit mode).

**Loader:**

```js
export async function loader({ params, request }) {
  if (params.id) {
    // Edit mode
    return {
      exercise: (await fetchAdminExercise(params.id)).data,
      lessonId: null,
    };
  }
  // Create mode — lessonId from URL search params
  const url = new URL(request.url);
  const lessonId = url.searchParams.get('lessonId');
  return { exercise: null, lessonId: lessonId ? Number(lessonId) : null };
}
```

**Form sections (Paper cards):**

1. **Type Selection** (ExerciseTypeSelector) — only shown in create mode, disabled in edit
2. **Common Fields** (CommonFieldsEditor):
   - question / question_vi (required)
   - content / content_vi (shown for types that use it)
   - correct_answer (shown for types that use it)
   - explanation / explanation_vi
   - hint / hint_vi
   - context / context_vi
3. **Type-Specific Editor** — dynamically rendered based on selected type:
   - `multiple_choice` → MultipleChoiceEditor
   - `matching` → MatchingPairEditor
   - `arrange_words` → ArrangeWordsEditor
   - `code_output` → content field uses monospace font, context is language hint
   - `true_false` → correct_answer rendered as True/False radio toggle
   - Other types (fill_blank, error_correction, sentence_transform) → no extra editor, CommonFieldsEditor handles everything
4. **Settings**:
   - difficulty (select: easy/medium/hard)
   - points (number input, default 10)
   - time_limit (number input, optional)
   - is_active (switch)
   - image_url / audio_url (text inputs)

**Validation (client-side):**

- question required
- lesson_id required (from URL param in create mode)
- Type-specific: options required for MC (2-6), pairs for matching (2-8), correct_answer for text types, word_bank for arrange_words

**Submit:**

- Create mode: POST with full body → navigate to `/admin/lessons/:lessonId/exercises`
- Edit mode: PUT with body → navigate back

### 7.5 Type-Specific Editors

#### `src/components/admin/exercise/ExerciseTypeSelector.jsx`

Props: `value` (string | null), `onChange`, `disabled` (boolean)

A grid of 8 cards/buttons, one per exercise type. Each shows:

- Type name (formatted: "Multiple Choice", "Fill in the Blank", etc.)
- Brief description of what fields it uses
- Selected state (outlined vs filled)

When type is selected, it sets the `type` field in form state. **Disabled in edit mode** (type cannot change after creation — shows current type as read-only chip).

#### `src/components/admin/exercise/MultipleChoiceEditor.jsx`

Props: `options` (array), `onChange` (receives new options array)

Features:

- List of option rows, each with:
  - Label chip (A, B, C, etc. — auto-assigned based on index)
  - Content text field
  - Content (VI) text field
  - is_correct radio button (only one can be true — clicking one unchecks others)
  - Explanation text field (collapsible)
  - Delete button (if > 2 options)
- "Add Option" button (disabled if 6 options already exist)
- Labels auto-assigned: options[0] = "A", options[1] = "B", etc.

#### `src/components/admin/exercise/MatchingPairEditor.jsx`

Props: `pairs` (array), `onChange` (receives new pairs array)

Features:

- List of pair rows, each with:
  - Left content + Left content (VI) text fields
  - Arrow/divider between left and right
  - Right content + Right content (VI) text fields
  - Delete button (if > 2 pairs)
- "Add Pair" button (disabled if 8 pairs already exist)

#### `src/components/admin/exercise/ArrangeWordsEditor.jsx`

Props: `wordBank` (string array), `onChange`, `correctAnswer` (string), `onAnswerChange`

Features:

- Word bank: list of word chips, each deletable
- "Add Word" text field + button
- Correct answer text field (the complete correct sentence)
- Word bank preview: shows current words in order
- Helper text: "Enter the words in shuffled order. correct_answer holds the correctly arranged sentence."

#### `src/components/admin/exercise/CommonFieldsEditor.jsx`

Props: `form` (object), `onChange` (field updater), `errors` (object), `type` (string — to know which fields to show)

Renders the shared fields that vary by type visibility:

- question / question_vi — always shown
- content / content_vi — shown for: fill_blank, error_correction, sentence_transform, true_false, code_output
- correct_answer — shown for: fill_blank, error_correction, sentence_transform, true_false, arrange_words, code_output
- context / context_vi — shown for: code_output (language hint), optionally others
- explanation / explanation_vi — always shown
- hint / hint_vi — always shown

For `code_output` type, content field uses monospace font (`sx={{ fontFamily: 'monospace' }}`).
For `true_false` type, correct_answer rendered as a radio group: "True" / "False" (sets correct_answer to "true" or "false" string).

### 7.6 Navigation from Lessons Page

Add an "Exercises" action button to the AdminLessonsPage actions column (alongside existing "Edit", "Sections", "Delete" buttons). This navigates to `/admin/lessons/:id/exercises`.

**Change in `src/pages/admin/AdminLessonsPage.jsx`:**

Add to the actions cell in columns definition:

```jsx
<IconButton
  size="small"
  onClick={() => navigate(`/admin/lessons/${row.original.id}/exercises`)}
  title="Exercises"
>
  <QuizIcon fontSize="small" />
</IconButton>
```

Import `QuizIcon` from `@mui/icons-material/Quiz`.

---

## SECTION 8: UX Design Decisions

### 8.1 Exercise List View

| Element          | Display                                                                |
| ---------------- | ---------------------------------------------------------------------- |
| Drag handle      | DragIndicatorIcon on left                                              |
| Type badge       | Chip with type name, color-coded (MC=primary, fill=secondary, etc.)    |
| Difficulty badge | Chip (easy=success, medium=warning, hard=error)                        |
| Question preview | First ~80 chars of question text, truncated with ellipsis              |
| Points           | Small number badge                                                     |
| Active toggle    | MUI Switch, fires toggle-active API on change                          |
| Actions          | Edit icon button → form page, Delete icon button → confirmation dialog |

### 8.2 Exercise Form

- **Type selector at top** — large clickable cards, disabled after creation (greyed out with lock icon)
- **Common fields in middle** — question is always first and prominent (larger TextField)
- **Type-specific section** — dynamically rendered below common fields, clearly separated
- **Settings at bottom** — difficulty, points, time_limit, active, URLs
- **Bilingual throughout** — every text field has a Vietnamese counterpart below it

### 8.3 Type Immutability

When editing an existing exercise, the type is shown as a read-only chip at the top of the form. Users cannot change the type because:

1. Child table data (options, pairs) is type-specific
2. Changing type would require deleting child data and re-creating different child data
3. UX confusion: changing from MC to fill_blank would lose all options

If users need a different type, they should delete and recreate.

### 8.4 True/False Special Handling

True/false is the simplest type: content is the statement, correct_answer is "true" or "false". In the form, instead of a free-text correct_answer field, show a radio group: "True" / "False" that sets correct_answer to the string value.

---

## SECTION 9: Security Considerations

1. **Admin-only access** — all routes use `adminAuth` preHandler (JWT cookie verification)
2. **JSON Schema validation** — all mutation endpoints validate request bodies:
   - Type ENUM checked server-side (`exercise_type` values)
   - Difficulty ENUM checked (`exercise_difficulty` values)
   - Option labels checked (`option_label` values A-F)
   - Array length limits (options: 2-6, pairs: 2-8)
   - String length limits (question, content, URLs)
   - Points bounded (0-100)
3. **Transaction integrity** — multi-table operations (MC create/update, matching create/update) use `sql.begin()` for atomicity
4. **No correct_answer leakage** — admin endpoints return correct_answer (needed for editing), but these are behind adminAuth. Public GET endpoints already enforce no correct_answer in response.
5. **SQL injection prevention** — all queries use postgres.js tagged templates (parameterized)
6. **Audit logging** — all mutations logged via fire-and-forget `adminRepo.logAction()`

---

## SECTION 10: CI Compatibility

### No new dependencies — no `npm install` needed

### No new migrations — schema already supports everything

### No E2E test changes needed

Existing Playwright E2E tests cover public exercise routes. Admin exercise routes don't have E2E tests (same as Phase 2A admin pages).

### Existing CI checks must pass:

| Check                                   | Expected Result                           |
| --------------------------------------- | ----------------------------------------- |
| `npm run lint`                          | PASS — follows existing patterns          |
| `npm run build`                         | PASS — new pages lazy-loaded (code-split) |
| `npx prettier --check`                  | PASS — formatted with project config      |
| `npx vitest run` (client)               | PASS — no changes to tested code          |
| `npx vitest run` (server)               | PASS — no changes to tested code          |
| `npm run test:all` (server integration) | PASS — no schema changes                  |
| Playwright E2E                          | PASS — no public route changes            |

### No GitHub Actions workflow changes needed

---

## SECTION 11: Appendix

### A. Type-Specific Field Matrix

Shows which exercise table fields each type uses (R = required, O = optional, — = unused):

| Field           | multiple_choice | fill_blank | error_correction | sentence_transform | arrange_words | matching      | true_false | code_output |
| --------------- | --------------- | ---------- | ---------------- | ------------------ | ------------- | ------------- | ---------- | ----------- |
| question        | R               | R          | R                | R                  | R             | R             | R          | R           |
| question_vi     | O               | O          | O                | O                  | O             | O             | O          | O           |
| content         | —               | R          | R                | R                  | —             | —             | R          | R           |
| content_vi      | —               | O          | O                | O                  | —             | —             | O          | O           |
| correct_answer  | —               | R          | R                | R                  | R             | —             | R          | R           |
| word_bank       | —               | —          | —                | —                  | R             | —             | —          | —           |
| context         | O               | O          | O                | O                  | O             | O             | O          | R           |
| context_vi      | O               | O          | O                | O                  | O             | O             | O          | O           |
| explanation     | O               | O          | O                | O                  | O             | O             | O          | O           |
| explanation_vi  | O               | O          | O                | O                  | O             | O             | O          | O           |
| hint            | O               | O          | O                | O                  | O             | O             | O          | O           |
| hint_vi         | O               | O          | O                | O                  | O             | O             | O          | O           |
| image_url       | O               | O          | O                | O                  | O             | O             | O          | O           |
| audio_url       | O               | O          | O                | O                  | O             | O             | O          | O           |
| **Child table** | exercise_option | —          | —                | —                  | —             | matching_pair | —          | —           |

### B. Example Request/Response Bodies

#### B.1 Create Multiple Choice Exercise

**Request:**

```json
POST /api/admin/exercises
{
  "lesson_id": 5,
  "type": "multiple_choice",
  "difficulty": "easy",
  "question": "Choose the correct verb form: She ___ to school every day.",
  "question_vi": "Chon dang dong tu dung: Co ay ___ den truong moi ngay.",
  "explanation": "Third person singular uses 'goes' in present simple.",
  "explanation_vi": "Ngoi thu ba so it dung 'goes' o thi hien tai don.",
  "hint": "Present simple, third person",
  "points": 10,
  "is_active": true,
  "options": [
    { "label": "A", "content": "goes", "is_correct": true, "explanation": "Correct! Third person singular." },
    { "label": "B", "content": "go", "is_correct": false, "explanation": "This is the base form." },
    { "label": "C", "content": "going", "is_correct": false, "explanation": "This is the -ing form." },
    { "label": "D", "content": "gone", "is_correct": false, "explanation": "This is past participle." }
  ]
}
```

**Response:**

```json
{
  "data": {
    "id": 727,
    "lesson_id": 5,
    "type": "multiple_choice",
    "difficulty": "easy",
    "question": "Choose the correct verb form: She ___ to school every day.",
    "question_vi": "Chon dang dong tu dung: Co ay ___ den truong moi ngay.",
    "context": null,
    "context_vi": null,
    "content": null,
    "content_vi": null,
    "correct_answer": null,
    "word_bank": null,
    "explanation": "Third person singular uses 'goes' in present simple.",
    "explanation_vi": "Ngoi thu ba so it dung 'goes' o thi hien tai don.",
    "hint": "Present simple, third person",
    "hint_vi": null,
    "image_url": null,
    "audio_url": null,
    "points": 10,
    "time_limit": null,
    "order_index": 7000,
    "is_active": true,
    "options": [
      {
        "id": 1001,
        "exercise_id": 727,
        "label": "A",
        "content": "goes",
        "content_vi": null,
        "is_correct": true,
        "explanation": "Correct! Third person singular.",
        "explanation_vi": null,
        "order_index": 0
      },
      {
        "id": 1002,
        "exercise_id": 727,
        "label": "B",
        "content": "go",
        "content_vi": null,
        "is_correct": false,
        "explanation": "This is the base form.",
        "explanation_vi": null,
        "order_index": 1000
      },
      {
        "id": 1003,
        "exercise_id": 727,
        "label": "C",
        "content": "going",
        "content_vi": null,
        "is_correct": false,
        "explanation": "This is the -ing form.",
        "explanation_vi": null,
        "order_index": 2000
      },
      {
        "id": 1004,
        "exercise_id": 727,
        "label": "D",
        "content": "gone",
        "content_vi": null,
        "is_correct": false,
        "explanation": "This is past participle.",
        "explanation_vi": null,
        "order_index": 3000
      }
    ],
    "matching_pairs": []
  }
}
```

#### B.2 Create Fill in the Blank Exercise

**Request:**

```json
POST /api/admin/exercises
{
  "lesson_id": 5,
  "type": "fill_blank",
  "difficulty": "medium",
  "question": "Fill in the blank with the correct form of the verb.",
  "content": "I have ___ (eat) breakfast already.",
  "correct_answer": "eaten",
  "explanation": "'Eaten' is the past participle of 'eat', used with present perfect.",
  "points": 10,
  "is_active": true
}
```

#### B.3 Create Matching Exercise

**Request:**

```json
POST /api/admin/exercises
{
  "lesson_id": 5,
  "type": "matching",
  "difficulty": "medium",
  "question": "Match the verb with its past tense form.",
  "points": 15,
  "is_active": true,
  "matching_pairs": [
    { "left_content": "go", "right_content": "went" },
    { "left_content": "eat", "right_content": "ate" },
    { "left_content": "see", "right_content": "saw" },
    { "left_content": "take", "right_content": "took" }
  ]
}
```

#### B.4 Create Arrange Words Exercise

**Request:**

```json
POST /api/admin/exercises
{
  "lesson_id": 5,
  "type": "arrange_words",
  "difficulty": "easy",
  "question": "Arrange the words to form a correct sentence.",
  "correct_answer": "She has been studying English for five years.",
  "word_bank": ["for", "She", "five", "studying", "has", "years", "been", "English"],
  "points": 10,
  "is_active": true
}
```

#### B.5 Create True/False Exercise

**Request:**

```json
POST /api/admin/exercises
{
  "lesson_id": 5,
  "type": "true_false",
  "difficulty": "easy",
  "question": "Is the following statement correct?",
  "content": "The present perfect tense is formed with 'have/has' + past participle.",
  "correct_answer": "true",
  "explanation": "Yes! Present perfect = have/has + V3 (past participle).",
  "points": 5,
  "is_active": true
}
```

#### B.6 Create Code Output Exercise

**Request:**

```json
POST /api/admin/exercises
{
  "lesson_id": 42,
  "type": "code_output",
  "difficulty": "medium",
  "question": "What will be printed to the console?",
  "context": "python",
  "content": "x = [1, 2, 3]\nprint(x[::-1])",
  "correct_answer": "[3, 2, 1]",
  "explanation": "[::-1] reverses the list using slice notation.",
  "points": 15,
  "is_active": true
}
```

#### B.7 Create Error Correction Exercise

**Request:**

```json
POST /api/admin/exercises
{
  "lesson_id": 5,
  "type": "error_correction",
  "difficulty": "medium",
  "question": "Find and correct the error in this sentence.",
  "content": "She don't like coffee.",
  "correct_answer": "She doesn't like coffee.",
  "explanation": "Third person singular requires 'doesn't' (does not), not 'don't'.",
  "points": 10,
  "is_active": true
}
```

#### B.8 Create Sentence Transform Exercise

**Request:**

```json
POST /api/admin/exercises
{
  "lesson_id": 5,
  "type": "sentence_transform",
  "difficulty": "hard",
  "question": "Rewrite the sentence in passive voice.",
  "content": "The cat chased the mouse.",
  "correct_answer": "The mouse was chased by the cat.",
  "explanation": "Passive voice: object + was/were + past participle + by + subject.",
  "points": 15,
  "is_active": true
}
```

#### B.9 Reorder Exercises

**Request:**

```json
POST /api/admin/exercises/reorder
{
  "lessonId": 5,
  "orderedIds": [730, 727, 728, 729, 731]
}
```

**Response:**

```json
{ "data": { "ok": true } }
```

#### B.10 Toggle Active

**Request:**

```json
PUT /api/admin/exercises/727/toggle-active
{
  "is_active": false
}
```

**Response:**

```json
{
  "data": {
    "id": 727,
    "is_active": false,
    "...": "other exercise fields"
  }
}
```

### C. Exercise Type Display Names and Icons

| Type                 | Display Name       | Suggested MUI Icon     | Chip Color |
| -------------------- | ------------------ | ---------------------- | ---------- |
| `multiple_choice`    | Multiple Choice    | RadioButtonCheckedIcon | primary    |
| `fill_blank`         | Fill in the Blank  | TextFieldsIcon         | secondary  |
| `error_correction`   | Error Correction   | SpellcheckIcon         | warning    |
| `sentence_transform` | Sentence Transform | TransformIcon          | info       |
| `arrange_words`      | Arrange Words      | ReorderIcon            | success    |
| `matching`           | Matching           | CompareArrowsIcon      | primary    |
| `true_false`         | True / False       | ThumbsUpDownIcon       | secondary  |
| `code_output`        | Code Output        | CodeIcon               | warning    |

### D. Implementation Order (recommended)

#### Backend (can be done in a single PR):

1. `adminExerciseRepository.js` — all 7 methods
2. `adminExerciseController.js` — all 7 handlers
3. `adminExerciseRoutes.js` — all 7 routes with schemas
4. Wire in `index.js` + `app.js`

#### Frontend (can be done in a single PR, after backend):

1. `src/api/admin.js` — add 7 API functions
2. `src/router.jsx` — add 3 routes
3. `CommonFieldsEditor.jsx` — shared fields component
4. `ExerciseTypeSelector.jsx` — type selection grid
5. `MultipleChoiceEditor.jsx` — options editor
6. `MatchingPairEditor.jsx` — pairs editor
7. `ArrangeWordsEditor.jsx` — word bank editor
8. `AdminExercisesPage.jsx` — list page with dnd-kit
9. `AdminExerciseFormPage.jsx` — form page with dynamic editors
10. Update `AdminLessonsPage.jsx` — add exercises action button

---

_End of Phase 2B Plan_
