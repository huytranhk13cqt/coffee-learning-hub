# Phase 3: Admin Learning + Insights + Settings — Implementation Plan

> Learning Paths CRUD, Activity Log, Spaced Repetition admin view, Weak Spots admin view, Settings (password change).
> Estimated files: ~8 new files (3 server, 5 client), ~4 modified files
> All sidebar nav links already exist in AdminLayout.jsx — just need matching routes + pages.

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

Phase 3 adds 5 features to the admin dashboard:

| #   | Feature                          | Complexity | Type                                            |
| --- | -------------------------------- | ---------- | ----------------------------------------------- |
| 1   | **Learning Paths CRUD**          | HIGH       | Full CRUD with child table (steps)              |
| 2   | **Activity Log**                 | MEDIUM     | Read-only with server-side pagination + filters |
| 3   | **Spaced Repetition Admin View** | LOW        | Read-only aggregate stats                       |
| 4   | **Weak Spots Admin View**        | LOW        | Read-only aggregate stats + filters             |
| 5   | **Settings**                     | LOW        | Password change form                            |

### Why this grouping?

- Features 1 completes the **LEARNING** sidebar group (paths CRUD)
- Features 2 completes the **INSIGHTS** sidebar group (activity log)
- Features 3-4 are read-only aggregate views for the LEARNING group
- Feature 5 is a standalone admin utility

### Architecture pattern (same as Phase 2A/2B)

```
server/index.js (Composition Root)
  → new AdminLearningPathRepository(sql)
  → new AdminLearningPathController(repo, adminRepo)
  → adminLearningPathRoutes(controller, adminAuth)

server/app.js → app.register(routes, { prefix: '/api/admin' })
```

All other features (Activity Log, Review Stats, Weak Spots, Settings) are added to the **existing** `adminRepository.js` / `adminRoutes.js` / `adminController.js` files since they are small read-only methods that don't warrant separate files.

---

## SECTION 2: Dependencies

### Root (client) — NO new dependencies

All required packages already installed from Phase 2A:

- `@tanstack/react-table` — data table (AdminDataTable)
- `@dnd-kit/core`, `@dnd-kit/sortable`, `@dnd-kit/utilities` — drag-and-drop reorder

### Server — NO new dependencies

All server deps already installed (Fastify, postgres.js, @fastify/cookie, @fastify/jwt).

---

## SECTION 3: Database Migrations

### NO migrations needed

All required tables already exist:

- `learning_path` (migration 021) — id, slug, name, name_vi, description, description_vi, icon, color, estimated_days, is_featured, order_index, is_active, created_at
- `learning_path_step` (migration 021) — id, path_id, lesson_id, order_index + UNIQUE constraints
- `admin_action_log` (migration 023) — id, action, entity_type, entity_id, metadata, ip_address, created_at + indexes
- `exercise_review` (migration 020) — SM-2 state per session+exercise
- `exercise_attempt` (schema.sql) — attempt records with is_correct

**Note**: `learning_path.order_index` is `SMALLINT` (not widened to `INTEGER` like topics/categories in migration 024). Since there are only 6 paths currently, SMALLINT is fine. If gap-based reorder is used with `i * 1000` gaps, SMALLINT max (32767) supports up to ~32 paths — more than enough. No migration needed.

---

## SECTION 4: File Structure

### Server (new files)

```
server/
├── repositories/
│   └── adminLearningPathRepository.js   ★ NEW — Learning Path + Steps CRUD queries
├── controllers/
│   └── adminLearningPathController.js   ★ NEW — Handler methods for path operations
└── routes/
    └── adminLearningPathRoutes.js       ★ NEW — Route definitions with JSON Schema
```

### Server (modified files)

```
server/
├── index.js                             MOD — wire AdminLearningPathRepo + Controller
├── app.js                               MOD — register adminLearningPathRoutes
├── repositories/adminRepository.js      MOD — add findActionLogs, countActionLogs, getReviewAggregateStats, getWeakSpotsAggregate
├── controllers/adminController.js       MOD — add listActionLogs, getReviewStats, getWeakSpots handlers
├── routes/adminRoutes.js                MOD — add routes for activity-log, review-stats, weak-spots
├── controllers/adminAuthController.js   MOD — add changePassword handler
└── routes/adminAuthRoutes.js            MOD — add PUT /settings/password route
```

### Client (new files)

```
src/
└── pages/admin/
    ├── AdminLearningPathsPage.jsx       ★ NEW — Path list with dnd-kit reorder
    ├── AdminLearningPathFormPage.jsx     ★ NEW — Create/edit form + step management
    ├── AdminActivityLogPage.jsx          ★ NEW — Paginated log with filters
    ├── AdminReviewPage.jsx              ★ NEW — Aggregate SM-2 stats dashboard
    ├── AdminWeakSpotsPage.jsx           ★ NEW — Aggregate weak spots table
    └── AdminSettingsPage.jsx            ★ NEW — Password change form + app info
```

### Client (modified files)

```
src/
├── api/admin.js                         MOD — add API functions for all new endpoints
└── router.jsx                           MOD — add route entries for 6 new admin pages
```

---

## SECTION 5: API Contracts

### 5.1 Learning Paths CRUD

#### `GET /api/admin/paths`

List all learning paths (including inactive).

**Response:**

```json
{
  "data": [
    {
      "id": 1,
      "slug": "english-grammar-basics",
      "name": "English Grammar Basics",
      "name_vi": "Ngữ pháp tiếng Anh cơ bản",
      "description": "...",
      "description_vi": "...",
      "icon": "RouteOutlined",
      "color": "#6366f1",
      "estimated_days": 14,
      "is_featured": true,
      "is_active": true,
      "order_index": 0,
      "created_at": "2026-01-15T...",
      "step_count": 8
    }
  ]
}
```

#### `GET /api/admin/paths/:id`

Get single path with all steps (includes lesson names for display).

**Response:**

```json
{
  "data": {
    "id": 1,
    "slug": "english-grammar-basics",
    "name": "English Grammar Basics",
    "name_vi": "...",
    "description": "...",
    "description_vi": "...",
    "icon": "RouteOutlined",
    "color": "#6366f1",
    "estimated_days": 14,
    "is_featured": true,
    "is_active": true,
    "order_index": 0,
    "created_at": "2026-01-15T...",
    "steps": [
      {
        "id": 1,
        "lesson_id": 5,
        "order_index": 0,
        "lesson_name": "Present Simple",
        "lesson_name_vi": "Thì hiện tại đơn",
        "lesson_slug": "present-simple",
        "category_name": "Present Tenses"
      }
    ]
  }
}
```

#### `POST /api/admin/paths`

Create a new learning path.

**Request body:**

```json
{
  "name": "Python Fundamentals",
  "name_vi": "Cơ bản Python",
  "description": "Learn Python from scratch",
  "description_vi": "Học Python từ đầu",
  "icon": "CodeOutlined",
  "color": "#10b981",
  "estimated_days": 21,
  "is_featured": false,
  "is_active": true
}
```

**Required**: `name`, `name_vi`
**Optional**: `slug` (auto-generated from `name` if omitted), `description`, `description_vi`, `icon`, `color`, `estimated_days`, `is_featured`, `is_active`

**Response:** `{ "data": { ...created path } }`

#### `PUT /api/admin/paths/:id`

Update path metadata (partial update).

**Request body:** Same fields as POST, all optional.

**Response:** `{ "data": { ...updated path } }`

#### `DELETE /api/admin/paths/:id`

Delete path. CASCADE deletes all steps.

**Response:** `{ "data": { "id": 1 } }`

#### `POST /api/admin/paths/reorder`

Reorder paths globally.

**Request body:**

```json
{
  "orderedIds": [3, 1, 5, 2, 4, 6]
}
```

**Response:** `{ "data": { "ok": true } }`

#### `PUT /api/admin/paths/:id/steps`

Replace all steps for a path (delete-all + re-insert pattern, same as exercise options in Phase 2B).

**Request body:**

```json
{
  "steps": [{ "lesson_id": 5 }, { "lesson_id": 12 }, { "lesson_id": 3 }]
}
```

Order is determined by array index (step[0] → order_index 1, step[1] → order_index 2, etc.).

**Response:**

```json
{
  "data": {
    "steps": [
      { "id": 10, "lesson_id": 5, "order_index": 1 },
      { "id": 11, "lesson_id": 12, "order_index": 2 },
      { "id": 12, "lesson_id": 3, "order_index": 3 }
    ]
  }
}
```

#### `PATCH /api/admin/paths/:id/toggle-active`

Toggle the `is_active` flag.

**Response:** `{ "data": { "id": 1, "is_active": false } }`

---

### 5.2 Activity Log

#### `GET /api/admin/activity-log`

Paginated admin action logs with filters.

**Query params:**
| Param | Type | Default | Description |
|-------|------|---------|-------------|
| `page` | int | 1 | Page number (1-based) |
| `pageSize` | int | 25 | Items per page (25, 50, or 100) |
| `action` | string | — | Filter: create, update, delete, reorder, toggle_active, login, logout |
| `entityType` | string | — | Filter: topic, category, lesson, section, exercise, learning_path, admin |
| `from` | string | — | ISO date, inclusive start |
| `to` | string | — | ISO date, inclusive end |
| `search` | string | — | Search in metadata JSONB (text contains) |

**Response:**

```json
{
  "data": [
    {
      "id": 142,
      "action": "create",
      "entity_type": "lesson",
      "entity_id": 125,
      "metadata": { "name": "New Lesson", "slug": "new-lesson" },
      "ip_address": "127.0.0.1",
      "created_at": "2026-03-07T10:23:00Z"
    }
  ],
  "pagination": {
    "page": 1,
    "pageSize": 25,
    "total": 142,
    "totalPages": 6
  }
}
```

---

### 5.3 Spaced Repetition Aggregate Stats

#### `GET /api/admin/review-stats`

Aggregate SM-2 stats across ALL sessions.

**Response:**

```json
{
  "data": {
    "total_enrolled": 4520,
    "due_today": 312,
    "due_this_week": 1205,
    "avg_ease_factor": 2.43,
    "avg_interval_days": 8.7,
    "ease_distribution": [
      { "bucket": "1.3-1.7", "count": 120 },
      { "bucket": "1.7-2.1", "count": 340 },
      { "bucket": "2.1-2.5", "count": 890 },
      { "bucket": "2.5-2.9", "count": 1500 },
      { "bucket": "2.9-3.3", "count": 1200 },
      { "bucket": "3.3+", "count": 470 }
    ],
    "interval_distribution": [
      { "bucket": "0-1", "count": 312 },
      { "bucket": "2-7", "count": 893 },
      { "bucket": "8-14", "count": 650 },
      { "bucket": "15-30", "count": 1100 },
      { "bucket": "31+", "count": 1565 }
    ],
    "top_reviewed": [
      {
        "exercise_id": 42,
        "question": "Choose the correct...",
        "lesson_name": "Present Simple",
        "review_count": 58,
        "avg_ease": 2.1
      }
    ],
    "unique_sessions": 87
  }
}
```

---

### 5.4 Weak Spots Aggregate

#### `GET /api/admin/weak-spots`

Aggregate weak spots across ALL sessions.

**Query params:**
| Param | Type | Default | Description |
|-------|------|---------|-------------|
| `minAttempts` | int | 5 | Minimum total attempts to qualify |
| `type` | string | — | Filter by exercise type |
| `lessonId` | int | — | Filter by lesson |
| `categoryId` | int | — | Filter by category |
| `limit` | int | 50 | Max results |

**Response:**

```json
{
  "data": [
    {
      "exercise_id": 42,
      "question": "Choose the correct form...",
      "question_vi": "...",
      "type": "fill_blank",
      "lesson_name": "Present Simple",
      "lesson_id": 5,
      "category_name": "Present Tenses",
      "category_id": 1,
      "total_attempts": 156,
      "total_errors": 89,
      "error_rate": 0.57,
      "unique_sessions": 23
    }
  ]
}
```

---

### 5.5 Settings — Password Change

#### `PUT /api/admin/settings/password`

Change admin password. Requires current password for verification.

**Request body:**

```json
{
  "currentPassword": "old-password",
  "newPassword": "new-password"
}
```

**Response:** `{ "success": true }`

**Error cases:**

- 400: Missing fields
- 401: Current password incorrect
- 400: New password too short (< 8 chars)

**NOTE**: Since admin auth uses a single `ADMIN_PASSWORD` env var (no database users table), the password change will update the in-memory password and log the action. The env var file is NOT automatically updated — this is a runtime-only change that resets on server restart. This is acceptable for the current single-admin setup. The response should include a warning about this.

---

## SECTION 6: Backend Implementation

### 6.1 AdminLearningPathRepository (NEW)

**File**: `server/repositories/adminLearningPathRepository.js`

```js
import { NotFoundError } from '../errors/AppError.js';

export class AdminLearningPathRepository {
  constructor(sql) {
    this.sql = sql;
  }
```

#### Methods:

**`findAll()`** — All paths with step count, ordered by order_index

```sql
SELECT
  lp.*,
  COALESCE(sc.cnt, 0)::int AS step_count
FROM learning_path lp
LEFT JOIN (
  SELECT path_id, COUNT(*)::int AS cnt
  FROM learning_path_step GROUP BY path_id
) sc ON sc.path_id = lp.id
ORDER BY lp.order_index, lp.id
```

**`findById(id)`** — Single path + all steps with lesson names

```js
async findById(id) {
  const [path] = await this.sql`SELECT * FROM learning_path WHERE id = ${id}`;
  if (!path) throw new NotFoundError('Learning Path');

  const steps = await this.sql`
    SELECT lps.id, lps.lesson_id, lps.order_index,
           l.name AS lesson_name, l.name_vi AS lesson_name_vi,
           l.slug AS lesson_slug,
           c.name AS category_name
    FROM learning_path_step lps
    JOIN lesson l ON l.id = lps.lesson_id
    JOIN category c ON c.id = l.group_id
    WHERE lps.path_id = ${id}
    ORDER BY lps.order_index ASC
  `;

  return { ...path, steps };
}
```

**`create(data)`** — Insert path with auto order_index (gap-based) + auto slug

```js
async create(data) {
  const [{ max_order }] = await this.sql`
    SELECT COALESCE(MAX(order_index), 0)::int AS max_order FROM learning_path
  `;
  const [row] = await this.sql`
    INSERT INTO learning_path (name, name_vi, slug, description, description_vi,
      icon, color, estimated_days, is_featured, is_active, order_index)
    VALUES (
      ${data.name}, ${data.name_vi}, ${data.slug},
      ${data.description ?? null}, ${data.description_vi ?? null},
      ${data.icon ?? 'RouteOutlined'}, ${data.color ?? '#6366f1'},
      ${data.estimated_days ?? 7}, ${data.is_featured ?? false},
      ${data.is_active ?? true}, ${max_order + 1000}
    )
    RETURNING *
  `;
  return row;
}
```

**`update(id, data)`** — Partial update (merge with existing)

```js
async update(id, data) {
  const existing = await this.findById(id);
  // Note: findById returns {steps, ...path}. Use existing for field merging.
  const [row] = await this.sql`
    UPDATE learning_path SET
      name           = ${data.name ?? existing.name},
      name_vi        = ${data.name_vi ?? existing.name_vi},
      slug           = ${data.slug ?? existing.slug},
      description    = ${data.description !== undefined ? data.description : existing.description},
      description_vi = ${data.description_vi !== undefined ? data.description_vi : existing.description_vi},
      icon           = ${data.icon !== undefined ? data.icon : existing.icon},
      color          = ${data.color ?? existing.color},
      estimated_days = ${data.estimated_days ?? existing.estimated_days},
      is_featured    = ${data.is_featured !== undefined ? data.is_featured : existing.is_featured},
      is_active      = ${data.is_active !== undefined ? data.is_active : existing.is_active}
    WHERE id = ${id}
    RETURNING *
  `;
  return row;
}
```

**`delete(id)`** — Delete path (CASCADE deletes steps)

```js
async delete(id) {
  const [existing] = await this.sql`SELECT id FROM learning_path WHERE id = ${id}`;
  if (!existing) throw new NotFoundError('Learning Path');
  await this.sql`DELETE FROM learning_path WHERE id = ${id}`;
  return { id };
}
```

**`reorder(orderedIds)`** — Gap-based reorder

```js
async reorder(orderedIds) {
  await this.sql.begin(async (tx) => {
    for (let i = 0; i < orderedIds.length; i++) {
      await tx`
        UPDATE learning_path SET order_index = ${i * 1000} WHERE id = ${orderedIds[i]}
      `;
    }
  });
}
```

**`replaceSteps(pathId, steps)`** — Delete-all + re-insert (transactional)

```js
async replaceSteps(pathId, steps) {
  // Verify path exists
  const [path] = await this.sql`SELECT id FROM learning_path WHERE id = ${pathId}`;
  if (!path) throw new NotFoundError('Learning Path');

  return this.sql.begin(async (tx) => {
    // Delete existing steps
    await tx`DELETE FROM learning_path_step WHERE path_id = ${pathId}`;

    // Insert new steps with sequential order_index
    const inserted = [];
    for (let i = 0; i < steps.length; i++) {
      const [row] = await tx`
        INSERT INTO learning_path_step (path_id, lesson_id, order_index)
        VALUES (${pathId}, ${steps[i].lesson_id}, ${i + 1})
        RETURNING *
      `;
      inserted.push(row);
    }

    return inserted;
  });
}
```

**`toggleActive(id)`** — Toggle is_active flag

```js
async toggleActive(id) {
  const [row] = await this.sql`
    UPDATE learning_path SET is_active = NOT is_active WHERE id = ${id}
    RETURNING id, is_active
  `;
  if (!row) throw new NotFoundError('Learning Path');
  return row;
}
```

---

### 6.2 AdminLearningPathController (NEW)

**File**: `server/controllers/adminLearningPathController.js`

```js
import { ValidationError } from '../errors/AppError.js';
import { slugify } from '../utils/slugify.js';

export class AdminLearningPathController {
  constructor(adminLearningPathRepo, adminRepo) {
    this.repo = adminLearningPathRepo;
    this.adminRepo = adminRepo;
  }

  listPaths = async () => {
    const data = await this.repo.findAll();
    return { data };
  };

  getPath = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.findById(id);
    return { data };
  };

  createPath = async (request) => {
    const body = { ...request.body };
    if (!body.slug) body.slug = slugify(body.name);
    const data = await this.repo.create(body);
    this.adminRepo.logAction({
      action: 'create',
      entityType: 'learning_path',
      entityId: data.id,
      metadata: { name: data.name, slug: data.slug },
      ipAddress: request.ip,
    });
    return { data };
  };

  updatePath = async (request) => {
    const id = parseInt(request.params.id, 10);
    const body = { ...request.body };
    if (body.name && !body.slug) body.slug = slugify(body.name);
    const data = await this.repo.update(id, body);
    this.adminRepo.logAction({
      action: 'update',
      entityType: 'learning_path',
      entityId: id,
      metadata: { fields: Object.keys(request.body) },
      ipAddress: request.ip,
    });
    return { data };
  };

  deletePath = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.delete(id);
    this.adminRepo.logAction({
      action: 'delete',
      entityType: 'learning_path',
      entityId: id,
      ipAddress: request.ip,
    });
    return { data };
  };

  reorderPaths = async (request) => {
    const { orderedIds } = request.body;
    if (!Array.isArray(orderedIds) || orderedIds.length === 0) {
      throw new ValidationError('orderedIds must be a non-empty array');
    }
    await this.repo.reorder(orderedIds);
    this.adminRepo.logAction({
      action: 'reorder',
      entityType: 'learning_path',
      metadata: { orderedIds },
      ipAddress: request.ip,
    });
    return { data: { ok: true } };
  };

  replaceSteps = async (request) => {
    const pathId = parseInt(request.params.id, 10);
    const { steps } = request.body;
    if (!Array.isArray(steps)) {
      throw new ValidationError('steps must be an array');
    }
    const data = await this.repo.replaceSteps(pathId, steps);
    this.adminRepo.logAction({
      action: 'update',
      entityType: 'learning_path',
      entityId: pathId,
      metadata: { action: 'replace_steps', stepCount: steps.length },
      ipAddress: request.ip,
    });
    return { data: { steps: data } };
  };

  toggleActive = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.toggleActive(id);
    this.adminRepo.logAction({
      action: 'toggle_active',
      entityType: 'learning_path',
      entityId: id,
      metadata: { is_active: data.is_active },
      ipAddress: request.ip,
    });
    return { data };
  };
}
```

---

### 6.3 AdminLearningPathRoutes (NEW)

**File**: `server/routes/adminLearningPathRoutes.js`

```js
export function adminLearningPathRoutes(controller, adminAuth) {
  return async function (fastify) {
    fastify.addHook('preHandler', adminAuth);

    const idParams = {
      type: 'object',
      required: ['id'],
      properties: { id: { type: 'string', pattern: '^\\d+$' } },
    };

    const reorderSchema = {
      body: {
        type: 'object',
        required: ['orderedIds'],
        properties: {
          orderedIds: {
            type: 'array',
            items: { type: 'integer' },
            minItems: 1,
          },
        },
      },
    };

    const hexColorPattern = '^#[0-9A-Fa-f]{6}$';

    // LIST
    fastify.get('/paths', controller.listPaths);

    // GET by ID
    fastify.get('/paths/:id', {
      schema: { params: idParams },
      handler: controller.getPath,
    });

    // CREATE
    fastify.post('/paths', {
      schema: {
        body: {
          type: 'object',
          required: ['name', 'name_vi'],
          properties: {
            name: { type: 'string', maxLength: 200 },
            name_vi: { type: 'string', maxLength: 200 },
            slug: { type: 'string', maxLength: 100 },
            description: { type: ['string', 'null'] },
            description_vi: { type: ['string', 'null'] },
            icon: { type: 'string', maxLength: 50 },
            color: { type: 'string', pattern: hexColorPattern },
            estimated_days: { type: 'integer', minimum: 1, maximum: 365 },
            is_featured: { type: 'boolean' },
            is_active: { type: 'boolean' },
          },
        },
      },
      handler: controller.createPath,
    });

    // UPDATE
    fastify.put('/paths/:id', {
      schema: {
        params: idParams,
        body: {
          type: 'object',
          properties: {
            name: { type: 'string', maxLength: 200 },
            name_vi: { type: 'string', maxLength: 200 },
            slug: { type: 'string', maxLength: 100 },
            description: { type: ['string', 'null'] },
            description_vi: { type: ['string', 'null'] },
            icon: { type: 'string', maxLength: 50 },
            color: { type: 'string', pattern: hexColorPattern },
            estimated_days: { type: 'integer', minimum: 1, maximum: 365 },
            is_featured: { type: 'boolean' },
            is_active: { type: 'boolean' },
          },
        },
      },
      handler: controller.updatePath,
    });

    // DELETE
    fastify.delete('/paths/:id', {
      schema: { params: idParams },
      handler: controller.deletePath,
    });

    // REORDER
    fastify.post('/paths/reorder', {
      schema: reorderSchema,
      handler: controller.reorderPaths,
    });

    // REPLACE STEPS
    fastify.put('/paths/:id/steps', {
      schema: {
        params: idParams,
        body: {
          type: 'object',
          required: ['steps'],
          properties: {
            steps: {
              type: 'array',
              items: {
                type: 'object',
                required: ['lesson_id'],
                properties: {
                  lesson_id: { type: 'integer' },
                },
              },
              maxItems: 50,
            },
          },
        },
      },
      handler: controller.replaceSteps,
    });

    // TOGGLE ACTIVE
    fastify.patch('/paths/:id/toggle-active', {
      schema: { params: idParams },
      handler: controller.toggleActive,
    });
  };
}
```

---

### 6.4 AdminRepository — New Methods (MODIFIED)

**File**: `server/repositories/adminRepository.js` — add these methods:

#### `findActionLogs({ page, pageSize, action, entityType, from, to, search })`

```js
async findActionLogs({ page = 1, pageSize = 25, action, entityType, from, to, search } = {}) {
  const offset = (page - 1) * pageSize;
  const searchPattern = search ? `%${search.replace(/[%_\\]/g, '\\$&')}%` : null;

  return this.sql`
    SELECT id, action, entity_type, entity_id, metadata, ip_address, created_at
    FROM admin_action_log
    WHERE 1=1
      ${action ? this.sql`AND action = ${action}` : this.sql``}
      ${entityType ? this.sql`AND entity_type = ${entityType}` : this.sql``}
      ${from ? this.sql`AND created_at >= ${from}::timestamptz` : this.sql``}
      ${to ? this.sql`AND created_at <= ${to}::timestamptz + interval '1 day'` : this.sql``}
      ${searchPattern ? this.sql`AND metadata::text ILIKE ${searchPattern}` : this.sql``}
    ORDER BY created_at DESC
    LIMIT ${pageSize}
    OFFSET ${offset}
  `;
}
```

#### `countActionLogs({ action, entityType, from, to, search })`

Same WHERE clause but `SELECT COUNT(*)::int AS total`.

```js
async countActionLogs({ action, entityType, from, to, search } = {}) {
  const searchPattern = search ? `%${search.replace(/[%_\\]/g, '\\$&')}%` : null;

  const [{ total }] = await this.sql`
    SELECT COUNT(*)::int AS total
    FROM admin_action_log
    WHERE 1=1
      ${action ? this.sql`AND action = ${action}` : this.sql``}
      ${entityType ? this.sql`AND entity_type = ${entityType}` : this.sql``}
      ${from ? this.sql`AND created_at >= ${from}::timestamptz` : this.sql``}
      ${to ? this.sql`AND created_at <= ${to}::timestamptz + interval '1 day'` : this.sql``}
      ${searchPattern ? this.sql`AND metadata::text ILIKE ${searchPattern}` : this.sql``}
  `;
  return total;
}
```

**Implementation note**: Uses `metadata::text ILIKE` for JSONB text search — this casts JSONB to text and does case-insensitive pattern matching. Not the most efficient for large datasets, but acceptable for admin action logs (typically < 10k entries). The `idx_admin_action_log_created` index covers the ORDER BY, and the `idx_admin_action_log_entity` covers entity_type filters.

#### `getReviewAggregateStats()`

Single-query CTE for all SM-2 aggregate stats.

```js
async getReviewAggregateStats() {
  const [summary] = await this.sql`
    SELECT
      COUNT(*)::int AS total_enrolled,
      COUNT(*) FILTER (WHERE next_review_at <= CURRENT_DATE)::int AS due_today,
      COUNT(*) FILTER (WHERE next_review_at <= CURRENT_DATE + 7)::int AS due_this_week,
      ROUND(AVG(ease_factor), 2) AS avg_ease_factor,
      ROUND(AVG(interval_days), 1) AS avg_interval_days,
      COUNT(DISTINCT session_id)::int AS unique_sessions
    FROM exercise_review
  `;

  const easeDistribution = await this.sql`
    SELECT
      CASE
        WHEN ease_factor < 1.7 THEN '1.3-1.7'
        WHEN ease_factor < 2.1 THEN '1.7-2.1'
        WHEN ease_factor < 2.5 THEN '2.1-2.5'
        WHEN ease_factor < 2.9 THEN '2.5-2.9'
        WHEN ease_factor < 3.3 THEN '2.9-3.3'
        ELSE '3.3+'
      END AS bucket,
      COUNT(*)::int AS count
    FROM exercise_review
    GROUP BY bucket
    ORDER BY bucket
  `;

  const intervalDistribution = await this.sql`
    SELECT
      CASE
        WHEN interval_days <= 1 THEN '0-1'
        WHEN interval_days <= 7 THEN '2-7'
        WHEN interval_days <= 14 THEN '8-14'
        WHEN interval_days <= 30 THEN '15-30'
        ELSE '31+'
      END AS bucket,
      COUNT(*)::int AS count
    FROM exercise_review
    GROUP BY bucket
    ORDER BY MIN(interval_days)
  `;

  const topReviewed = await this.sql`
    SELECT
      er.exercise_id,
      e.question,
      l.name AS lesson_name,
      COUNT(DISTINCT er.session_id)::int AS review_count,
      ROUND(AVG(er.ease_factor), 2) AS avg_ease
    FROM exercise_review er
    JOIN exercise e ON e.id = er.exercise_id
    JOIN lesson l ON l.id = e.lesson_id
    GROUP BY er.exercise_id, e.question, l.name
    ORDER BY review_count DESC
    LIMIT 10
  `;

  return {
    ...summary,
    ease_distribution: easeDistribution,
    interval_distribution: intervalDistribution,
    top_reviewed: topReviewed,
  };
}
```

#### `getWeakSpotsAggregate({ minAttempts, type, lessonId, categoryId, limit })`

Cross-session aggregate of weak exercises.

```js
async getWeakSpotsAggregate({ minAttempts = 5, type, lessonId, categoryId, limit = 50 } = {}) {
  return this.sql`
    SELECT
      e.id AS exercise_id,
      e.question,
      e.question_vi,
      e.type,
      l.name AS lesson_name,
      l.id AS lesson_id,
      c.name AS category_name,
      c.id AS category_id,
      COUNT(*)::int AS total_attempts,
      SUM(CASE WHEN ea.is_correct = FALSE THEN 1 ELSE 0 END)::int AS total_errors,
      ROUND(
        SUM(CASE WHEN ea.is_correct = FALSE THEN 1 ELSE 0 END)::NUMERIC / COUNT(*), 2
      ) AS error_rate,
      COUNT(DISTINCT ea.session_id)::int AS unique_sessions
    FROM exercise_attempt ea
    JOIN exercise e ON ea.exercise_id = e.id
    JOIN lesson l ON e.lesson_id = l.id
    JOIN category c ON l.group_id = c.id
    WHERE e.is_active = TRUE
      ${type ? this.sql`AND e.type = ${type}` : this.sql``}
      ${lessonId ? this.sql`AND e.lesson_id = ${lessonId}` : this.sql``}
      ${categoryId ? this.sql`AND l.group_id = ${categoryId}` : this.sql``}
    GROUP BY e.id, e.question, e.question_vi, e.type, l.name, l.id, c.name, c.id
    HAVING COUNT(*) >= ${minAttempts}
    ORDER BY error_rate DESC, total_attempts DESC
    LIMIT ${limit}
  `;
}
```

---

### 6.5 AdminController — New Handlers (MODIFIED)

**File**: `server/controllers/adminController.js` — add these handlers:

```js
// GET /api/admin/activity-log
listActionLogs = async (request) => {
  const page = parseInt(request.query.page, 10) || 1;
  const pageSize = [25, 50, 100].includes(parseInt(request.query.pageSize, 10))
    ? parseInt(request.query.pageSize, 10)
    : 25;
  const action = request.query.action || null;
  const entityType = request.query.entityType || null;
  const from = request.query.from || null;
  const to = request.query.to || null;
  const search = request.query.search?.trim() || null;

  const filters = { action, entityType, from, to, search };
  const [data, total] = await Promise.all([
    this.adminRepo.findActionLogs({ page, pageSize, ...filters }),
    this.adminRepo.countActionLogs(filters),
  ]);

  return {
    data,
    pagination: {
      page,
      pageSize,
      total,
      totalPages: Math.ceil(total / pageSize),
    },
  };
};

// GET /api/admin/review-stats
getReviewStats = async () => {
  const data = await this.adminRepo.getReviewAggregateStats();
  return { data };
};

// GET /api/admin/weak-spots
getWeakSpots = async (request) => {
  const minAttempts = parseInt(request.query.minAttempts, 10) || 5;
  const type = request.query.type || null;
  const lessonId = request.query.lessonId
    ? parseInt(request.query.lessonId, 10)
    : null;
  const categoryId = request.query.categoryId
    ? parseInt(request.query.categoryId, 10)
    : null;
  const limit = parseInt(request.query.limit, 10) || 50;
  const data = await this.adminRepo.getWeakSpotsAggregate({
    minAttempts,
    type,
    lessonId,
    categoryId,
    limit,
  });
  return { data };
};
```

---

### 6.6 AdminRoutes — New Routes (MODIFIED)

**File**: `server/routes/adminRoutes.js` — add these routes inside the existing plugin:

```js
// Activity Log (paginated)
fastify.get('/activity-log', controller.listActionLogs);

// Spaced Repetition aggregate stats
fastify.get('/review-stats', controller.getReviewStats);

// Weak Spots aggregate
fastify.get('/weak-spots-aggregate', controller.getWeakSpots);
```

**Note**: The weak spots endpoint is `/weak-spots-aggregate` to avoid collision with the existing public `/api/progress/weak-spots` endpoint. Both are under different prefixes (`/api/admin` vs `/api/progress`), but using a distinct name makes intent clearer.

---

### 6.7 AdminAuthController — Password Change (MODIFIED)

**File**: `server/controllers/adminAuthController.js` — add this handler:

```js
/**
 * PUT /api/admin/settings/password
 * Changes the admin password (runtime-only, resets on server restart).
 */
changePassword = async (request) => {
  const { currentPassword, newPassword } = request.body || {};
  if (!currentPassword || !newPassword) {
    throw new ValidationError('currentPassword and newPassword are required');
  }
  if (currentPassword !== this.adminPassword) {
    throw new UnauthorizedError('Current password is incorrect');
  }
  if (newPassword.length < 8) {
    throw new ValidationError('New password must be at least 8 characters');
  }
  // Update in-memory password
  this.adminPassword = newPassword;

  this.adminRepo.logAction({
    action: 'update',
    entityType: 'admin',
    metadata: { action: 'password_change' },
    ipAddress: request.ip,
  });

  return {
    success: true,
    warning:
      'Password changed for this server session only. Update ADMIN_PASSWORD env var for persistence.',
  };
};
```

### 6.8 AdminAuthRoutes — Add Password Route (MODIFIED)

**File**: `server/routes/adminAuthRoutes.js`

The password change route needs adminAuth (unlike login/logout/verify which are public). So we add it as a separate registered plugin within the same file, or we register it in adminRoutes.js instead. **Best approach**: add the route to `adminRoutes.js` (which already has adminAuth) and have adminAuthController injected into adminController, OR simply register it in a new scope.

**Simplest approach**: Add the route to `adminRoutes.js` since it already has `adminAuth` applied:

```js
// In adminRoutes.js — add after existing routes
fastify.put('/settings/password', {
  schema: {
    body: {
      type: 'object',
      required: ['currentPassword', 'newPassword'],
      properties: {
        currentPassword: { type: 'string' },
        newPassword: { type: 'string', minLength: 8 },
      },
    },
  },
  handler: adminAuthController.changePassword,
});
```

**This means** `adminRoutes` needs to receive `adminAuthController` too. Update the function signature:

```js
export function adminRoutes(controller, adminAuth, adminAuthController) {
  // ...
  // At the end, add password change route
  if (adminAuthController) {
    fastify.put('/settings/password', {
      schema: { ... },
      handler: adminAuthController.changePassword,
    });
  }
}
```

And update `app.js`:

```js
app.register(adminRoutes(adminController, adminAuth, adminAuthController), {
  prefix: '/api/admin',
});
```

---

### 6.9 Composition Root Changes (server/index.js)

Add after existing admin wiring:

```js
import { AdminLearningPathRepository } from './repositories/adminLearningPathRepository.js';
import { AdminLearningPathController } from './controllers/adminLearningPathController.js';

// ...

const adminLearningPathRepo = new AdminLearningPathRepository(sql);
const adminLearningPathController = new AdminLearningPathController(
  adminLearningPathRepo,
  adminRepo,
);

// Pass to createApp:
const app = await createApp({
  // ...existing...
  adminLearningPathController,
});
```

### 6.10 App.js Changes

```js
import { adminLearningPathRoutes } from './routes/adminLearningPathRoutes.js';

// In createApp params, add: adminLearningPathController
// After existing admin route registrations:
if (adminLearningPathController) {
  app.register(
    adminLearningPathRoutes(adminLearningPathController, adminAuth),
    { prefix: '/api/admin' },
  );
}

// Update adminRoutes registration to pass adminAuthController:
if (adminController) {
  app.register(adminRoutes(adminController, adminAuth, adminAuthController), {
    prefix: '/api/admin',
  });
}
```

---

## SECTION 7: Frontend Implementation

### 7.1 API Module — New Functions (src/api/admin.js)

Add to existing file:

```js
// ─── LEARNING PATHS CRUD ────────────────────────────────────

export function fetchAdminPaths() {
  return adminRequest('/paths');
}

export function fetchAdminPath(id) {
  return adminRequest(`/paths/${id}`);
}

export function createAdminPath(data) {
  return adminRequest('/paths', {
    method: 'POST',
    body: JSON.stringify(data),
  });
}

export function updateAdminPath(id, data) {
  return adminRequest(`/paths/${id}`, {
    method: 'PUT',
    body: JSON.stringify(data),
  });
}

export function deleteAdminPath(id) {
  return adminRequest(`/paths/${id}`, { method: 'DELETE' });
}

export function reorderAdminPaths(orderedIds) {
  return adminRequest('/paths/reorder', {
    method: 'POST',
    body: JSON.stringify({ orderedIds }),
  });
}

export function replaceAdminPathSteps(pathId, steps) {
  return adminRequest(`/paths/${pathId}/steps`, {
    method: 'PUT',
    body: JSON.stringify({ steps }),
  });
}

export function toggleAdminPathActive(id) {
  return adminRequest(`/paths/${id}/toggle-active`, { method: 'PATCH' });
}

// ─── ACTIVITY LOG ───────────────────────────────────────────

export function fetchAdminActivityLog({
  page,
  pageSize,
  action,
  entityType,
  from,
  to,
  search,
} = {}) {
  const params = new URLSearchParams();
  if (page) params.set('page', page);
  if (pageSize) params.set('pageSize', pageSize);
  if (action) params.set('action', action);
  if (entityType) params.set('entityType', entityType);
  if (from) params.set('from', from);
  if (to) params.set('to', to);
  if (search) params.set('search', search);
  const qs = params.toString();
  return adminRequest(`/activity-log${qs ? `?${qs}` : ''}`);
}

// ─── REVIEW STATS ───────────────────────────────────────────

export function fetchAdminReviewStats() {
  return adminRequest('/review-stats');
}

// ─── WEAK SPOTS ─────────────────────────────────────────────

export function fetchAdminWeakSpots({
  minAttempts,
  type,
  lessonId,
  categoryId,
  limit,
} = {}) {
  const params = new URLSearchParams();
  if (minAttempts) params.set('minAttempts', minAttempts);
  if (type) params.set('type', type);
  if (lessonId) params.set('lessonId', lessonId);
  if (categoryId) params.set('categoryId', categoryId);
  if (limit) params.set('limit', limit);
  const qs = params.toString();
  return adminRequest(`/weak-spots-aggregate${qs ? `?${qs}` : ''}`);
}

// ─── SETTINGS ───────────────────────────────────────────────

export function changeAdminPassword(currentPassword, newPassword) {
  return adminRequest('/settings/password', {
    method: 'PUT',
    body: JSON.stringify({ currentPassword, newPassword }),
  });
}
```

---

### 7.2 Router — New Routes (src/router.jsx)

Add inside the `/admin` children array:

```jsx
// Learning Paths
{
  path: 'paths',
  lazy: async () => {
    const { default: Component, loader } =
      await import('./pages/admin/AdminLearningPathsPage.jsx');
    return { Component, loader };
  },
  ErrorBoundary: ErrorPage,
},
{
  path: 'paths/new',
  lazy: async () => {
    const { default: Component, loader } =
      await import('./pages/admin/AdminLearningPathFormPage.jsx');
    return { Component, loader };
  },
  ErrorBoundary: ErrorPage,
},
{
  path: 'paths/:id/edit',
  lazy: async () => {
    const { default: Component, loader } =
      await import('./pages/admin/AdminLearningPathFormPage.jsx');
    return { Component, loader };
  },
  ErrorBoundary: ErrorPage,
},
// Activity Log
{
  path: 'activity',
  lazy: async () => {
    const { default: Component, loader } =
      await import('./pages/admin/AdminActivityLogPage.jsx');
    return { Component, loader };
  },
  ErrorBoundary: ErrorPage,
},
// Spaced Repetition
{
  path: 'review',
  lazy: async () => {
    const { default: Component, loader } =
      await import('./pages/admin/AdminReviewPage.jsx');
    return { Component, loader };
  },
  ErrorBoundary: ErrorPage,
},
// Weak Spots
{
  path: 'weak-spots',
  lazy: async () => {
    const { default: Component, loader } =
      await import('./pages/admin/AdminWeakSpotsPage.jsx');
    return { Component, loader };
  },
  ErrorBoundary: ErrorPage,
},
// Settings
{
  path: 'settings',
  lazy: async () => {
    const { default: Component } =
      await import('./pages/admin/AdminSettingsPage.jsx');
    return { Component };
  },
  ErrorBoundary: ErrorPage,
},
```

---

### 7.3 AdminLearningPathsPage.jsx

**Pattern**: Same as AdminLessonsPage (list with AdminDataTable + dnd-kit reorder).

**Loader**:

```js
export async function loader() {
  const res = await fetchAdminPaths();
  return { paths: res.data };
}
```

**Columns**:
| Column | Source | Notes |
|--------|--------|-------|
| Name | `name` | Link to edit form |
| Name (VI) | `name_vi` | — |
| Steps | `step_count` | Numeric count |
| Days | `estimated_days` | — |
| Featured | `is_featured` | Chip: "Featured" (green) or empty |
| Active | `is_active` | Toggle button (calls toggleAdminPathActive) |
| Actions | — | Edit, Delete buttons |

**Features**:

- AdminDataTable with search
- Drag-and-drop reorder (same pattern as AdminTopicsPage)
- Toggle active/inactive inline (PATCH endpoint)
- "New Path" button → navigate to `/admin/paths/new`
- Delete with DeleteConfirmDialog

---

### 7.4 AdminLearningPathFormPage.jsx

**Pattern**: Same as AdminLessonFormPage (full-page form). Dual-mode: create + edit.

**Loader**:

```js
export async function loader({ params }) {
  if (params.id) {
    const [pathRes, lessonsRes] = await Promise.all([
      fetchAdminPath(params.id),
      fetchAdminLessons(),
    ]);
    return { path: pathRes.data, lessons: lessonsRes.data };
  }
  const lessonsRes = await fetchAdminLessons();
  return { path: null, lessons: lessonsRes.data };
}
```

**Form fields** (top section — path metadata):

- Name (text, required)
- Name Vietnamese (text, required)
- Slug (text, auto-generated, editable)
- Description (textarea)
- Description Vietnamese (textarea)
- Icon (text, default "RouteOutlined")
- Color (color picker / text with hex validation)
- Estimated Days (number, min 1, max 365)
- Is Featured (checkbox)
- Is Active (checkbox)

**Steps section** (bottom section):

- List of current steps (ordered), each showing: order number, lesson name, category name, remove button
- Drag-and-drop reorder within steps (using @dnd-kit)
- "Add Lesson" button/dropdown: opens a lesson picker (Autocomplete or searchable Select with all available lessons)
- Lesson picker should show lesson name + category name, and exclude lessons already in the path
- Save steps button (calls `replaceAdminPathSteps`)

**UX flow**:

1. Creating: Fill metadata → Save path (POST) → redirect to edit page → then manage steps
2. Editing: Load existing → modify metadata + steps → Save metadata (PUT /paths/:id) + Save steps (PUT /paths/:id/steps) separately
3. Steps are saved independently from metadata — two separate API calls, two separate save buttons

**Why two save buttons?** Steps use the replace-all pattern (delete + re-insert) which is a separate transactional operation. Keeping them separate prevents data loss if one fails. The metadata save button is at the top form section, the steps save button is at the bottom steps section.

---

### 7.5 AdminActivityLogPage.jsx

**Pattern**: Custom page (not AdminDataTable since we need server-side pagination).

**Loader**:

```js
export async function loader({ request }) {
  const url = new URL(request.url);
  const page = url.searchParams.get('page') || 1;
  const pageSize = url.searchParams.get('pageSize') || 25;
  const action = url.searchParams.get('action') || '';
  const entityType = url.searchParams.get('entityType') || '';
  const from = url.searchParams.get('from') || '';
  const to = url.searchParams.get('to') || '';
  const search = url.searchParams.get('search') || '';
  const res = await fetchAdminActivityLog({
    page,
    pageSize,
    action,
    entityType,
    from,
    to,
    search,
  });
  return res;
}
```

**Layout**:

```
┌─────────────────────────────────────────────────────┐
│ Activity Log                                         │
├─────────────────────────────────────────────────────┤
│ [Action ▼] [Entity Type ▼] [From 📅] [To 📅] [🔍] │
├─────────────────────────────────────────────────────┤
│ Timestamp    │ Action │ Entity  │ ID │ Details │ IP  │
│──────────────│────────│─────────│────│─────────│─────│
│ 2026-03-07...│ create │ lesson  │ 125│ {...}   │ ::1 │
│ 2026-03-07...│ update │ exercise│ 42 │ {...}   │ ::1 │
│ ...          │        │         │    │         │     │
├─────────────────────────────────────────────────────┤
│ Page 1 of 6  │  [25▼]  │  [< Prev] [Next >]        │
└─────────────────────────────────────────────────────┘
```

**Implementation details**:

- Filter changes update URL searchParams and trigger loader re-fetch via `useNavigate` with `?page=1&action=create...`
- This leverages React Router's loader-based data fetching — no useEffect needed
- MUI Table (not AdminDataTable) since we need server-side pagination
- Metadata column: show as collapsed JSON preview, expand on click
- Page size selector: MUI Select with 25/50/100 options
- Pagination: "Previous" / "Next" buttons + page info text

**State management**:

```js
// Filters controlled via URL searchParams (source of truth)
// When a filter changes: navigate to same page with updated params + page=1
// Pagination: navigate with updated page param
```

---

### 7.6 AdminReviewPage.jsx

**Pattern**: Read-only stats dashboard (similar to AdminDashboardPage widgets).

**Loader**:

```js
export async function loader() {
  const res = await fetchAdminReviewStats();
  return res;
}
```

**Layout**:

```
┌─────────────────────────────────────────────────────┐
│ Spaced Repetition Overview                           │
├─────────────────────────────────────────────────────┤
│ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌─────────┐ │
│ │ Total    │ │ Due Today│ │ Due Week │ │Sessions │ │
│ │ 4,520    │ │ 312      │ │ 1,205   │ │ 87      │ │
│ └──────────┘ └──────────┘ └──────────┘ └─────────┘ │
├─────────────────────────────────────────────────────┤
│ ┌─────────────────────┐ ┌─────────────────────────┐ │
│ │ Ease Factor Dist.   │ │ Interval Distribution   │ │
│ │ [bar chart]         │ │ [bar chart]             │ │
│ └─────────────────────┘ └─────────────────────────┘ │
├─────────────────────────────────────────────────────┤
│ Top 10 Most Reviewed Exercises                       │
│ ┌───────────────────────────────────────────────────┐│
│ │ # │ Question          │ Lesson       │ Count│ EF ││
│ │ 1 │ Choose correct... │ Present S.   │ 58   │2.1 ││
│ │ ...                                              ││
│ └───────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────┘
```

**Components used**:

- Paper cards for stat numbers (same style as AdminDashboardPage)
- Simple horizontal bar charts using MUI Box with percentage widths (no Recharts dependency needed — keep it simple with CSS bars)
- MUI Table for top reviewed exercises

**Why no Recharts?** The admin dashboard uses pixel art theme and simple stat cards. CSS-based bar charts (colored Box elements with width percentages) are perfectly adequate for distribution histograms and avoid adding lazy-loaded vendor-recharts to the admin bundle.

---

### 7.7 AdminWeakSpotsPage.jsx

**Pattern**: Read-only table with filters.

**Loader**:

```js
export async function loader() {
  const [weakSpotsRes, lessonsRes, categoriesRes] = await Promise.all([
    fetchAdminWeakSpots(),
    fetchAdminLessons(),
    fetchAdminCategories(),
  ]);
  return {
    weakSpots: weakSpotsRes.data,
    lessons: lessonsRes.data,
    categories: categoriesRes.data,
  };
}
```

**Layout**:

```
┌─────────────────────────────────────────────────────┐
│ Weak Spots (All Users)                               │
├─────────────────────────────────────────────────────┤
│ [Category ▼] [Lesson ▼] [Type ▼] [Min Attempts: 5] │
├─────────────────────────────────────────────────────┤
│ Question     │ Type   │ Lesson  │ Attempts│Error Rate│
│──────────────│────────│─────────│─────────│──────────│
│ Choose the...│fill_bl│Present S│ 156     │ 57%      │
│ ...          │        │         │         │          │
└─────────────────────────────────────────────────────┘
```

**Implementation details**:

- Filters trigger navigation with query params → loader re-fetches
- OR: Use client-side refetch pattern (since there's no pagination, just re-call the API)
- AdminDataTable with search for the results table
- Error rate shown as colored Chip: red (>70%), orange (>50%), yellow (>30%)
- Min attempts: MUI TextField type="number" with debounced re-fetch

**State management** for filters:

```js
// Since weak spots is not paginated, we can use useState for filters
// and re-fetch on filter change via useCallback + state
const [filters, setFilters] = useState({
  minAttempts: 5,
  type: '',
  lessonId: '',
  categoryId: '',
});
const [data, setData] = useState(loaderData.weakSpots);

// Re-fetch when filters change
async function refetch(newFilters) {
  const res = await fetchAdminWeakSpots(newFilters);
  setData(res.data);
}
```

This is one of the few places where useState-based refetch is acceptable because:

1. It's a filter operation on an admin page (not user-facing)
2. The data set is small (max 50 items)
3. Using URL params would make the URL overly complex for a simple filter

---

### 7.8 AdminSettingsPage.jsx

**Pattern**: Simple form page.

**No loader needed** (no initial data to fetch).

**Layout**:

```
┌─────────────────────────────────────────────────────┐
│ Settings                                             │
├─────────────────────────────────────────────────────┤
│ Change Password                                      │
│ ┌─────────────────────────────────────────────────┐ │
│ │ Current Password: [••••••••••]                  │ │
│ │ New Password:     [••••••••••]                  │ │
│ │ Confirm Password: [••••••••••]                  │ │
│ │                                                 │ │
│ │ [Change Password]                               │ │
│ └─────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────┤
│ App Info                                             │
│ ┌─────────────────────────────────────────────────┐ │
│ │ Version: Phase 3 (dev)                          │ │
│ │ Database: Connected                             │ │
│ │ Schema: v24                                     │ │
│ └─────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────┘
```

**Password change flow**:

1. User fills current password + new password + confirm password
2. Frontend validates: new password matches confirm, min 8 chars
3. Calls `changeAdminPassword(current, new)`
4. On success: show success Snackbar/Alert
5. On error: show error message (e.g., "Current password is incorrect")

**State**:

```js
const [form, setForm] = useState({ current: '', newPw: '', confirm: '' });
const [loading, setLoading] = useState(false);
const [message, setMessage] = useState(null); // { type: 'success'|'error', text: '...' }
```

**App Info section**: Static info, no API call. Can hardcode version string. Optionally call `/api/health` to show DB status.

---

## SECTION 8: UX Design Decisions

### 8.1 Learning Path Step Management

**Decision**: Steps are edited on the same page as the path form (bottom section), NOT a separate page.

**Rationale**: Unlike sections (which have complex inline editing with expand/collapse), steps are simple lesson references. A separate page would add unnecessary navigation. The form page has two sections: metadata (top) and steps (bottom), each with their own save button.

**Step reorder**: Drag-and-drop using @dnd-kit (same as AdminSectionsPage). Visual: numbered list with drag handle, lesson name, category name, remove button.

**Lesson picker**: MUI Autocomplete with all lessons. Shows `lesson.name (category_name)` as label. Filters out lessons already in the path. On select, appends to steps list.

### 8.2 Activity Log Pagination

**Decision**: Server-side pagination via URL searchParams.

**Rationale**: Activity logs can grow to thousands of entries. Client-side pagination would require loading all data upfront. Server-side pagination with React Router loaders keeps the architecture consistent.

### 8.3 Stats Pages — No Recharts

**Decision**: Use CSS-based bar charts (MUI Box with width percentages) for distribution histograms.

**Rationale**: The admin dashboard uses pixel art theme with simple stat cards. Adding Recharts to admin pages would:

1. Increase bundle size (vendor-recharts is 156KB gz, lazy-loaded)
2. Look inconsistent with the pixel art aesthetic
3. Be overkill for simple 5-6 bar histograms

Simple colored bars with labels are sufficient and visually match the theme.

### 8.4 Password Change — Runtime Only

**Decision**: Password change only updates in-memory. Env var is NOT modified.

**Rationale**: Modifying .env files from the application is a security anti-pattern. The admin should update `ADMIN_PASSWORD` in their deployment config. The runtime change is useful for temporary password rotation during an active session.

### 8.5 Weak Spots — Client-Side Filters

**Decision**: Use client-side filter state + API refetch (not URL params).

**Rationale**: Unlike Activity Log which needs server pagination, Weak Spots returns max 50 items and has no pagination. Using useState for filters with API refetch is simpler and doesn't bloat the URL.

---

## SECTION 9: Security Considerations

### 9.1 All endpoints require adminAuth

Every new endpoint is behind `adminAuth` preHandler (JWT cookie verification).

### 9.2 JSON Schema validation on all mutations

- POST/PUT bodies validated via Fastify JSON Schema
- Prevents invalid data from reaching the database
- String maxLength limits prevent oversized payloads
- Integer min/max on estimated_days, pageSize, etc.

### 9.3 SQL injection prevention

All queries use postgres.js tagged templates — NEVER string concatenation. The conditional fragments (`${condition ? sql\`...\` : sql\`\`}`) are safe because they're tagged template fragments, not string interpolation.

### 9.4 JSONB search safety

Activity log search uses `metadata::text ILIKE ${pattern}` with escaped pattern — safe from SQL injection. The `ILIKE` operates on the text cast, not on raw user input.

### 9.5 Password validation

- Current password must match before allowing change
- New password minimum 8 characters (enforced by both JSON Schema and controller)
- Password change logged to audit trail

### 9.6 No CORS changes needed

Admin endpoints already covered by existing CORS config (PUT/DELETE methods added in Phase 2A). PATCH method needs to be added to the CORS `methods` array in `app.js`.

**Action**: Add `'PATCH'` to the CORS methods array:

```js
methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH'],
```

---

## SECTION 10: CI Compatibility

### No breaking changes

1. **No new migrations** — all tables exist
2. **No new npm packages** — all deps installed
3. **No public API changes** — only new admin endpoints added
4. **Existing tests unaffected** — no modified public behavior
5. **Lint + Build** — all new files follow existing patterns (ESLint config, MUI deep imports)

### Files to validate

```bash
# Server
npx eslint server/repositories/adminLearningPathRepository.js
npx eslint server/controllers/adminLearningPathController.js
npx eslint server/routes/adminLearningPathRoutes.js

# Client
npm run lint
npm run build
```

---

## SECTION 11: Appendix

### A. Complete File Change Summary

| File                                                 | Action | Lines (est.) |
| ---------------------------------------------------- | ------ | ------------ |
| `server/repositories/adminLearningPathRepository.js` | NEW    | ~120         |
| `server/controllers/adminLearningPathController.js`  | NEW    | ~100         |
| `server/routes/adminLearningPathRoutes.js`           | NEW    | ~100         |
| `server/repositories/adminRepository.js`             | MOD    | +~120        |
| `server/controllers/adminController.js`              | MOD    | +~40         |
| `server/routes/adminRoutes.js`                       | MOD    | +~20         |
| `server/controllers/adminAuthController.js`          | MOD    | +~25         |
| `server/index.js`                                    | MOD    | +~10         |
| `server/app.js`                                      | MOD    | +~10         |
| `src/api/admin.js`                                   | MOD    | +~70         |
| `src/router.jsx`                                     | MOD    | +~60         |
| `src/pages/admin/AdminLearningPathsPage.jsx`         | NEW    | ~180         |
| `src/pages/admin/AdminLearningPathFormPage.jsx`      | NEW    | ~350         |
| `src/pages/admin/AdminActivityLogPage.jsx`           | NEW    | ~250         |
| `src/pages/admin/AdminReviewPage.jsx`                | NEW    | ~200         |
| `src/pages/admin/AdminWeakSpotsPage.jsx`             | NEW    | ~200         |
| `src/pages/admin/AdminSettingsPage.jsx`              | NEW    | ~150         |

**Total**: ~8 new files, ~6 modified files, ~2005 lines estimated

### B. Existing Sidebar Nav Links (already in AdminLayout.jsx)

These already exist and will work once routes are added:

```
LEARNING group:
  - Learning Paths → /admin/paths    ← Feature 1
  - Spaced Repetition → /admin/review ← Feature 3
  - Weak Spots → /admin/weak-spots    ← Feature 4

INSIGHTS group:
  - Activity Log → /admin/activity    ← Feature 2

Bottom:
  - Settings → /admin/settings        ← Feature 5
```

### C. Implementation Order (Recommended)

**Backend first, then frontend** (backend and frontend agents work independently).

**Backend order**:

1. AdminLearningPathRepository + Controller + Routes (most complex, self-contained)
2. AdminRepository new methods (findActionLogs, countActionLogs, getReviewAggregateStats, getWeakSpotsAggregate)
3. AdminController new handlers (listActionLogs, getReviewStats, getWeakSpots)
4. AdminRoutes updates (new routes)
5. AdminAuthController.changePassword + route
6. Composition Root (index.js) + App.js wiring
7. CORS update (add PATCH method)

**Frontend order**:

1. api/admin.js — all new API functions
2. router.jsx — all new route entries
3. AdminLearningPathsPage (list)
4. AdminLearningPathFormPage (create/edit + step management)
5. AdminActivityLogPage (paginated log)
6. AdminReviewPage (stats dashboard)
7. AdminWeakSpotsPage (table + filters)
8. AdminSettingsPage (password form)

### D. Example API Requests

#### Create Learning Path

```bash
curl -X POST http://localhost:3001/api/admin/paths \
  -H "Content-Type: application/json" \
  --cookie "admin_token=..." \
  -d '{
    "name": "Python Fundamentals",
    "name_vi": "Co ban Python",
    "description": "Learn Python from scratch",
    "color": "#10b981",
    "estimated_days": 21,
    "is_featured": true
  }'
```

#### Replace Steps

```bash
curl -X PUT http://localhost:3001/api/admin/paths/1/steps \
  -H "Content-Type: application/json" \
  --cookie "admin_token=..." \
  -d '{
    "steps": [
      { "lesson_id": 5 },
      { "lesson_id": 12 },
      { "lesson_id": 3 }
    ]
  }'
```

#### Activity Log with Filters

```bash
curl "http://localhost:3001/api/admin/activity-log?page=1&pageSize=25&action=create&entityType=lesson" \
  --cookie "admin_token=..."
```

#### Change Password

```bash
curl -X PUT http://localhost:3001/api/admin/settings/password \
  -H "Content-Type: application/json" \
  --cookie "admin_token=..." \
  -d '{
    "currentPassword": "old-password",
    "newPassword": "new-secure-password"
  }'
```
