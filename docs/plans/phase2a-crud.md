# Phase 2A: Admin CRUD — Implementation Plan

> Full CRUD for Topics, Categories, Lessons, and Lesson Sections.
> Drag-and-drop reorder, modal forms (Topic/Category), full-page forms (Lesson), separate section editor.
> Estimated files: ~30 new files (12 server, 18 client), ~8 modified files

---

## Table of Contents

1. [Dependencies](#section-1-dependencies)
2. [Database Migrations](#section-2-database-migrations)
3. [File Structure](#section-3-file-structure)
4. [API Contracts](#section-4-api-contracts)
5. [Backend Implementation](#section-5-backend-implementation)
6. [Frontend Implementation](#section-6-frontend-implementation)
7. [Reorder Algorithm](#section-7-reorder-algorithm)
8. [Security](#section-8-security)
9. [CI Compatibility](#section-9-ci-compatibility)
10. [Appendix](#section-10-appendix)

---

## SECTION 1: Dependencies

### Root (client) — install from project root

```bash
npm install @tanstack/react-table@8 @dnd-kit/core@6 @dnd-kit/sortable@10 @dnd-kit/utilities@3
```

| Package                 | Purpose                                                  | Size (gz) |
| ----------------------- | -------------------------------------------------------- | --------- |
| `@tanstack/react-table` | Headless data table (sorting, filtering, pagination)     | ~15KB     |
| `@dnd-kit/core`         | Drag-and-drop framework (sensors, collision detection)   | ~12KB     |
| `@dnd-kit/sortable`     | Sortable preset for dnd-kit (vertical lists, table rows) | ~5KB      |
| `@dnd-kit/utilities`    | CSS utilities for transform/transition                   | ~1KB      |

### Server — no new dependencies

All server deps already installed (Fastify, postgres.js, @fastify/cookie, @fastify/jwt).

---

## SECTION 2: Database Migrations

### Migration 024: Expand CORS methods + order_index for gap reorder

The existing `order_index` constraints use `SMALLINT` (max 32767), which is sufficient for gap-based reorder (gaps of 1000 = up to 32 items before compaction). However, for future-proofing and to avoid compaction issues with large content sets, we widen topic and category `order_index` to `INTEGER` and remove the upper-bound CHECK constraints that limit to 100.

#### File: `database/migrations/024_widen_order_index_for_reorder.sql`

```sql
-- Migration 024: Widen order_index constraints for gap-based reorder
-- Removes upper-bound CHECK on topic/category order_index to support gap reorder (gaps of 1000).
-- Changes SMALLINT → INTEGER for topic.order_index and category.order_index.
-- ============================================================================

BEGIN;

-- 1. Topic: drop old constraint, widen column, add new constraint
ALTER TABLE topic DROP CONSTRAINT chk_topic_order;
ALTER TABLE topic ALTER COLUMN order_index TYPE INTEGER;
ALTER TABLE topic ADD CONSTRAINT chk_topic_order CHECK (order_index >= 0);

-- 2. Category: drop old constraint, widen column, add new constraint
ALTER TABLE category DROP CONSTRAINT chk_category_order;
ALTER TABLE category ALTER COLUMN order_index TYPE INTEGER;
ALTER TABLE category ADD CONSTRAINT chk_category_order CHECK (order_index >= 0);

-- 3. Lesson: already INTEGER-compatible, just ensure no upper bound
-- lesson.order_index already has: CHECK (order_index >= 0) — no change needed

-- 4. lesson_section.order_index: widen for gap reorder
ALTER TABLE lesson_section ALTER COLUMN order_index TYPE INTEGER;

INSERT INTO schema_version (version, description)
VALUES (24, 'Widen order_index for gap-based drag-and-drop reorder');

COMMIT;
```

**Run migration:**

```bash
psql -U relax_user -d knowledge_learning -f database/migrations/024_widen_order_index_for_reorder.sql
```

**Note:** No ENUM changes needed. All existing ENUMs (`lesson_section_type`, `exercise_type`, `difficulty_level`) are already sufficient.

---

## SECTION 3: File Structure

### Server (new files)

```
server/
├── repositories/
│   └── adminCrudRepository.js    ★ NEW — CRUD queries for topics, categories, lessons, sections
├── controllers/
│   └── adminCrudController.js    ★ NEW — handler methods for all CRUD operations
├── routes/
│   └── adminCrudRoutes.js        ★ NEW — route definitions with JSON Schema validation
└── utils/
    └── slugify.js                ★ NEW — slug generation from lesson name
```

### Server (modified files)

```
server/
├── index.js                      MOD — wire AdminCrudRepository + AdminCrudController
├── app.js                        MOD — register adminCrudRoutes, update CORS methods
└── errors/AppError.js            MOD — add ConflictError (409)
```

### Client (new files)

```
src/
├── components/admin/
│   ├── AdminDataTable.jsx        ★ NEW — reusable TanStack Table wrapper with pixel theme
│   ├── DragHandle.jsx            ★ NEW — drag handle icon for sortable rows
│   ├── TopicFormDialog.jsx       ★ NEW — modal form for create/edit topic
│   ├── CategoryFormDialog.jsx    ★ NEW — modal form for create/edit category
│   ├── DeleteConfirmDialog.jsx   ★ NEW — reusable delete confirmation dialog
│   ├── ColorPickerField.jsx      ★ NEW — hex color picker (preset swatches)
│   ├── IconPickerField.jsx       ★ NEW — MUI icon picker (searchable grid)
│   └── AdminFormField.jsx        ★ NEW — styled TextField wrapper for admin forms
├── pages/admin/
│   ├── AdminTopicsPage.jsx       ★ NEW — topic list + CRUD + reorder
│   ├── AdminCategoriesPage.jsx   ★ NEW — category list + CRUD + reorder
│   ├── AdminLessonsPage.jsx      ★ NEW — lesson list page
│   ├── AdminLessonFormPage.jsx   ★ NEW — full-page create/edit lesson form
│   └── AdminSectionsPage.jsx     ★ NEW — section editor for a specific lesson
└── api/
    └── admin.js                  MOD — add CRUD API functions
```

### Client (modified files)

```
src/
├── router.jsx                    MOD — add admin CRUD routes (topics, categories, lessons, sections)
└── components/admin/
    └── AdminLayout.jsx           (already has NAV_GROUPS with correct paths — no change needed)
```

---

## SECTION 4: API Contracts

All admin CRUD endpoints require `adminAuth` middleware (JWT cookie). All return `{ data: ... }` on success or `{ error: "message" }` on failure.

### 4.1 Topics

| Method   | Path                        | Request           | Response                 | Notes                                                                    |
| -------- | --------------------------- | ----------------- | ------------------------ | ------------------------------------------------------------------------ |
| `GET`    | `/api/admin/topics`         | —                 | `{ data: Topic[] }`      | All topics ordered by `order_index` with category count                  |
| `POST`   | `/api/admin/topics`         | `TopicCreateBody` | `{ data: Topic }`        | Creates topic, auto-assigns next `order_index`                           |
| `PUT`    | `/api/admin/topics/:id`     | `TopicUpdateBody` | `{ data: Topic }`        | Updates topic fields                                                     |
| `DELETE` | `/api/admin/topics/:id`     | —                 | `{ data: { id } }`       | Fails if topic has categories (`ON DELETE SET NULL` is safe but we warn) |
| `POST`   | `/api/admin/topics/reorder` | `ReorderBody`     | `{ data: { ok: true } }` | Batch update `order_index`                                               |

**TopicCreateBody:**

```json
{
  "name": "string (required, max 100)",
  "name_vi": "string (required, max 100)",
  "description": "string (optional)",
  "description_vi": "string (optional)",
  "icon": "string (optional, max 50)",
  "color": "string (required, hex #RRGGBB)"
}
```

**TopicUpdateBody:** Same as create, all fields optional (partial update).

**ReorderBody:**

```json
{
  "orderedIds": [3, 1, 5, 2]
}
```

### 4.2 Categories

| Method   | Path                            | Request                        | Response                 | Notes                                        |
| -------- | ------------------------------- | ------------------------------ | ------------------------ | -------------------------------------------- |
| `GET`    | `/api/admin/categories`         | `?topicId=N` (optional filter) | `{ data: Category[] }`   | All categories with topic name, lesson count |
| `POST`   | `/api/admin/categories`         | `CategoryCreateBody`           | `{ data: Category }`     | Creates category                             |
| `PUT`    | `/api/admin/categories/:id`     | `CategoryUpdateBody`           | `{ data: Category }`     | Updates category                             |
| `DELETE` | `/api/admin/categories/:id`     | —                              | `{ data: { id } }`       | Fails if category has lessons (FK RESTRICT)  |
| `POST`   | `/api/admin/categories/reorder` | `ReorderBody`                  | `{ data: { ok: true } }` | Batch update                                 |

**CategoryCreateBody:**

```json
{
  "name": "string (required, max 100)",
  "name_vi": "string (required, max 100)",
  "description": "string (optional)",
  "description_vi": "string (optional)",
  "icon": "string (optional, max 50)",
  "color": "string (required, hex #RRGGBB)",
  "topic_id": "integer | null (optional)"
}
```

### 4.3 Lessons

| Method   | Path                         | Request                                | Response                 | Notes                                                  |
| -------- | ---------------------------- | -------------------------------------- | ------------------------ | ------------------------------------------------------ |
| `GET`    | `/api/admin/lessons`         | `?categoryId=N&search=text` (optional) | `{ data: Lesson[] }`     | Lesson list with category name, exercise/section count |
| `GET`    | `/api/admin/lessons/:id`     | —                                      | `{ data: Lesson }`       | Single lesson with full fields (for edit form)         |
| `POST`   | `/api/admin/lessons`         | `LessonCreateBody`                     | `{ data: Lesson }`       | Creates lesson, auto-generates slug                    |
| `PUT`    | `/api/admin/lessons/:id`     | `LessonUpdateBody`                     | `{ data: Lesson }`       | Updates lesson                                         |
| `DELETE` | `/api/admin/lessons/:id`     | —                                      | `{ data: { id } }`       | CASCADE deletes sections, exercises, etc.              |
| `POST`   | `/api/admin/lessons/reorder` | `ReorderBody`                          | `{ data: { ok: true } }` | Reorder within a category                              |

**LessonCreateBody:**

```json
{
  "name": "string (required, max 100)",
  "name_vi": "string (required, max 100)",
  "slug": "string (optional, auto-generated from name if omitted)",
  "short_desc": "string (optional, max 255)",
  "short_desc_vi": "string (optional, max 255)",
  "description": "string (optional)",
  "description_vi": "string (optional)",
  "group_id": "integer (required — category ID)",
  "difficulty": "beginner | intermediate | advanced (default: beginner)",
  "estimated_time": "integer | null (minutes)",
  "is_published": "boolean (default: false)"
}
```

### 4.4 Lesson Sections

| Method   | Path                                            | Request             | Response                         | Notes                          |
| -------- | ----------------------------------------------- | ------------------- | -------------------------------- | ------------------------------ |
| `GET`    | `/api/admin/lessons/:lessonId/sections`         | —                   | `{ data: { lesson, sections } }` | Sections + lesson metadata     |
| `POST`   | `/api/admin/lessons/:lessonId/sections`         | `SectionCreateBody` | `{ data: Section }`              | Creates section                |
| `PUT`    | `/api/admin/sections/:id`                       | `SectionUpdateBody` | `{ data: Section }`              | Updates section                |
| `DELETE` | `/api/admin/sections/:id`                       | —                   | `{ data: { id } }`               | Deletes section                |
| `POST`   | `/api/admin/lessons/:lessonId/sections/reorder` | `ReorderBody`       | `{ data: { ok: true } }`         | Reorder sections within lesson |

**SectionCreateBody:**

```json
{
  "type": "lesson_section_type ENUM value (required)",
  "title": "string (optional, max 255)",
  "title_vi": "string (optional, max 255)",
  "content": "string (optional — null for audio/video/image)",
  "content_vi": "string (optional)",
  "metadata": "object (optional, default: {})"
}
```

---

## SECTION 5: Backend Implementation

### 5.1 Error Classes

#### File: `server/errors/AppError.js` — add ConflictError

```js
export class ConflictError extends AppError {
  constructor(message = 'Resource already exists') {
    super(message, 409);
  }
}
```

### 5.2 Slug Utility

#### File: `server/utils/slugify.js`

```js
/**
 * Generate URL-friendly slug from a string.
 * Handles ASCII + basic Vietnamese diacritics.
 * Examples:
 *   "Present Simple Tense" → "present-simple-tense"
 *   "Thì Hiện Tại Đơn"    → "thi-hien-tai-don"
 */
export function slugify(text) {
  return text
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '') // strip diacritics
    .replace(/đ/g, 'd')
    .replace(/Đ/g, 'D')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-') // non-alphanumeric → dash
    .replace(/^-|-$/g, ''); // trim leading/trailing dashes
}
```

### 5.3 AdminCrudRepository

#### File: `server/repositories/adminCrudRepository.js`

```js
import { NotFoundError, ConflictError } from '../errors/AppError.js';

export class AdminCrudRepository {
  constructor(sql) {
    this.sql = sql;
  }

  // ─── TOPICS ──────────────────────────────────────────────

  /** All topics with category count, ordered by order_index */
  async findAllTopics() {
    return this.sql`
      SELECT
        t.*,
        COALESCE(cc.cnt, 0)::int AS category_count
      FROM topic t
      LEFT JOIN (
        SELECT topic_id, COUNT(*)::int AS cnt
        FROM category
        WHERE topic_id IS NOT NULL
        GROUP BY topic_id
      ) cc ON cc.topic_id = t.id
      ORDER BY t.order_index, t.id
    `;
  }

  async findTopicById(id) {
    const [row] = await this.sql`SELECT * FROM topic WHERE id = ${id}`;
    if (!row) throw new NotFoundError('Topic');
    return row;
  }

  async createTopic(data) {
    // Auto-assign order_index: max + 1000 (gap-based)
    const [{ max_order }] = await this.sql`
      SELECT COALESCE(MAX(order_index), 0)::int AS max_order FROM topic
    `;
    const [row] = await this.sql`
      INSERT INTO topic (name, name_vi, description, description_vi, icon, color, order_index)
      VALUES (
        ${data.name}, ${data.name_vi},
        ${data.description ?? null}, ${data.description_vi ?? null},
        ${data.icon ?? null}, ${data.color},
        ${max_order + 1000}
      )
      RETURNING *
    `;
    return row;
  }

  async updateTopic(id, data) {
    // Build dynamic SET clause — only update provided fields
    const existing = await this.findTopicById(id);
    const [row] = await this.sql`
      UPDATE topic SET
        name           = ${data.name ?? existing.name},
        name_vi        = ${data.name_vi ?? existing.name_vi},
        description    = ${data.description !== undefined ? data.description : existing.description},
        description_vi = ${data.description_vi !== undefined ? data.description_vi : existing.description_vi},
        icon           = ${data.icon !== undefined ? data.icon : existing.icon},
        color          = ${data.color ?? existing.color}
      WHERE id = ${id}
      RETURNING *
    `;
    return row;
  }

  async deleteTopic(id) {
    await this.findTopicById(id); // throws 404 if not found
    await this.sql`DELETE FROM topic WHERE id = ${id}`;
    return { id };
  }

  async reorderTopics(orderedIds) {
    // Gap-based: assign order_index = index * 1000
    await this.sql.begin(async (tx) => {
      for (let i = 0; i < orderedIds.length; i++) {
        await tx`
          UPDATE topic SET order_index = ${i * 1000} WHERE id = ${orderedIds[i]}
        `;
      }
    });
  }

  // ─── CATEGORIES ──────────────────────────────────────────

  async findAllCategories(topicId) {
    if (topicId) {
      return this.sql`
        SELECT
          c.*,
          t.name AS topic_name,
          COALESCE(lc.cnt, 0)::int AS lesson_count
        FROM category c
        LEFT JOIN topic t ON t.id = c.topic_id
        LEFT JOIN (
          SELECT group_id, COUNT(*)::int AS cnt FROM lesson GROUP BY group_id
        ) lc ON lc.group_id = c.id
        WHERE c.topic_id = ${topicId}
        ORDER BY c.order_index, c.id
      `;
    }
    return this.sql`
      SELECT
        c.*,
        t.name AS topic_name,
        COALESCE(lc.cnt, 0)::int AS lesson_count
      FROM category c
      LEFT JOIN topic t ON t.id = c.topic_id
      LEFT JOIN (
        SELECT group_id, COUNT(*)::int AS cnt FROM lesson GROUP BY group_id
      ) lc ON lc.group_id = c.id
      ORDER BY COALESCE(t.order_index, 99999), c.order_index, c.id
    `;
  }

  async findCategoryById(id) {
    const [row] = await this.sql`SELECT * FROM category WHERE id = ${id}`;
    if (!row) throw new NotFoundError('Category');
    return row;
  }

  async createCategory(data) {
    const [{ max_order }] = await this.sql`
      SELECT COALESCE(MAX(order_index), 0)::int AS max_order FROM category
    `;
    const [row] = await this.sql`
      INSERT INTO category (name, name_vi, description, description_vi, icon, color, topic_id, order_index)
      VALUES (
        ${data.name}, ${data.name_vi},
        ${data.description ?? null}, ${data.description_vi ?? null},
        ${data.icon ?? null}, ${data.color},
        ${data.topic_id ?? null},
        ${max_order + 1000}
      )
      RETURNING *
    `;
    return row;
  }

  async updateCategory(id, data) {
    const existing = await this.findCategoryById(id);
    const [row] = await this.sql`
      UPDATE category SET
        name           = ${data.name ?? existing.name},
        name_vi        = ${data.name_vi ?? existing.name_vi},
        description    = ${data.description !== undefined ? data.description : existing.description},
        description_vi = ${data.description_vi !== undefined ? data.description_vi : existing.description_vi},
        icon           = ${data.icon !== undefined ? data.icon : existing.icon},
        color          = ${data.color ?? existing.color},
        topic_id       = ${data.topic_id !== undefined ? data.topic_id : existing.topic_id}
      WHERE id = ${id}
      RETURNING *
    `;
    return row;
  }

  async deleteCategory(id) {
    await this.findCategoryById(id);
    // FK ON DELETE RESTRICT — will throw DB error if lessons exist
    await this.sql`DELETE FROM category WHERE id = ${id}`;
    return { id };
  }

  async reorderCategories(orderedIds) {
    await this.sql.begin(async (tx) => {
      for (let i = 0; i < orderedIds.length; i++) {
        await tx`
          UPDATE category SET order_index = ${i * 1000} WHERE id = ${orderedIds[i]}
        `;
      }
    });
  }

  // ─── LESSONS ─────────────────────────────────────────────

  async findAllLessons({ categoryId, search } = {}) {
    // Base query with counts
    if (search) {
      const pattern = `%${search.replace(/[%_\\]/g, '\\$&')}%`;
      return this.sql`
        SELECT
          l.id, l.name, l.name_vi, l.slug, l.difficulty,
          l.is_published, l.order_index, l.group_id,
          l.estimated_time, l.created_at, l.updated_at,
          c.name AS category_name,
          t.name AS topic_name,
          COALESCE(ec.cnt, 0)::int AS exercise_count,
          COALESCE(sc.cnt, 0)::int AS section_count
        FROM lesson l
        JOIN category c ON c.id = l.group_id
        LEFT JOIN topic t ON t.id = c.topic_id
        LEFT JOIN (
          SELECT lesson_id, COUNT(*)::int AS cnt
          FROM exercise WHERE is_active = TRUE GROUP BY lesson_id
        ) ec ON ec.lesson_id = l.id
        LEFT JOIN (
          SELECT lesson_id, COUNT(*)::int AS cnt
          FROM lesson_section GROUP BY lesson_id
        ) sc ON sc.lesson_id = l.id
        WHERE l.name ILIKE ${pattern} OR l.name_vi ILIKE ${pattern}
        ORDER BY l.updated_at DESC
        LIMIT 200
      `;
    }
    if (categoryId) {
      return this.sql`
        SELECT
          l.id, l.name, l.name_vi, l.slug, l.difficulty,
          l.is_published, l.order_index, l.group_id,
          l.estimated_time, l.created_at, l.updated_at,
          c.name AS category_name,
          t.name AS topic_name,
          COALESCE(ec.cnt, 0)::int AS exercise_count,
          COALESCE(sc.cnt, 0)::int AS section_count
        FROM lesson l
        JOIN category c ON c.id = l.group_id
        LEFT JOIN topic t ON t.id = c.topic_id
        LEFT JOIN (
          SELECT lesson_id, COUNT(*)::int AS cnt
          FROM exercise WHERE is_active = TRUE GROUP BY lesson_id
        ) ec ON ec.lesson_id = l.id
        LEFT JOIN (
          SELECT lesson_id, COUNT(*)::int AS cnt
          FROM lesson_section GROUP BY lesson_id
        ) sc ON sc.lesson_id = l.id
        WHERE l.group_id = ${categoryId}
        ORDER BY l.order_index, l.id
      `;
    }
    return this.sql`
      SELECT
        l.id, l.name, l.name_vi, l.slug, l.difficulty,
        l.is_published, l.order_index, l.group_id,
        l.estimated_time, l.created_at, l.updated_at,
        c.name AS category_name,
        t.name AS topic_name,
        COALESCE(ec.cnt, 0)::int AS exercise_count,
        COALESCE(sc.cnt, 0)::int AS section_count
      FROM lesson l
      JOIN category c ON c.id = l.group_id
      LEFT JOIN topic t ON t.id = c.topic_id
      LEFT JOIN (
        SELECT lesson_id, COUNT(*)::int AS cnt
        FROM exercise WHERE is_active = TRUE GROUP BY lesson_id
      ) ec ON ec.lesson_id = l.id
      LEFT JOIN (
        SELECT lesson_id, COUNT(*)::int AS cnt
        FROM lesson_section GROUP BY lesson_id
      ) sc ON sc.lesson_id = l.id
      ORDER BY COALESCE(t.order_index, 99999), c.order_index, l.order_index, l.id
      LIMIT 500
    `;
  }

  async findLessonById(id) {
    const [row] = await this.sql`
      SELECT l.*, c.name AS category_name, t.name AS topic_name
      FROM lesson l
      JOIN category c ON c.id = l.group_id
      LEFT JOIN topic t ON t.id = c.topic_id
      WHERE l.id = ${id}
    `;
    if (!row) throw new NotFoundError('Lesson');
    return row;
  }

  async createLesson(data) {
    const [{ max_order }] = await this.sql`
      SELECT COALESCE(MAX(order_index), 0)::int AS max_order
      FROM lesson WHERE group_id = ${data.group_id}
    `;
    const [row] = await this.sql`
      INSERT INTO lesson (
        name, name_vi, slug, short_desc, short_desc_vi,
        description, description_vi, group_id,
        difficulty, estimated_time, is_published, order_index
      ) VALUES (
        ${data.name}, ${data.name_vi}, ${data.slug},
        ${data.short_desc ?? null}, ${data.short_desc_vi ?? null},
        ${data.description ?? null}, ${data.description_vi ?? null},
        ${data.group_id},
        ${data.difficulty ?? 'beginner'},
        ${data.estimated_time ?? null},
        ${data.is_published ?? false},
        ${max_order + 1000}
      )
      RETURNING *
    `;
    return row;
  }

  async updateLesson(id, data) {
    const existing = await this.findLessonById(id);
    const [row] = await this.sql`
      UPDATE lesson SET
        name           = ${data.name ?? existing.name},
        name_vi        = ${data.name_vi ?? existing.name_vi},
        slug           = ${data.slug ?? existing.slug},
        short_desc     = ${data.short_desc !== undefined ? data.short_desc : existing.short_desc},
        short_desc_vi  = ${data.short_desc_vi !== undefined ? data.short_desc_vi : existing.short_desc_vi},
        description    = ${data.description !== undefined ? data.description : existing.description},
        description_vi = ${data.description_vi !== undefined ? data.description_vi : existing.description_vi},
        group_id       = ${data.group_id ?? existing.group_id},
        difficulty     = ${data.difficulty ?? existing.difficulty},
        estimated_time = ${data.estimated_time !== undefined ? data.estimated_time : existing.estimated_time},
        is_published   = ${data.is_published !== undefined ? data.is_published : existing.is_published}
      WHERE id = ${id}
      RETURNING *
    `;
    return row;
  }

  async deleteLesson(id) {
    await this.findLessonById(id);
    // CASCADE deletes: sections, exercises, formulas, usages, etc.
    await this.sql`DELETE FROM lesson WHERE id = ${id}`;
    return { id };
  }

  async reorderLessons(orderedIds) {
    await this.sql.begin(async (tx) => {
      for (let i = 0; i < orderedIds.length; i++) {
        await tx`
          UPDATE lesson SET order_index = ${i * 1000} WHERE id = ${orderedIds[i]}
        `;
      }
    });
  }

  // ─── SECTIONS ────────────────────────────────────────────

  async findSectionsByLesson(lessonId) {
    // Verify lesson exists
    const [lesson] = await this.sql`
      SELECT l.id, l.name, l.name_vi, l.slug
      FROM lesson l WHERE l.id = ${lessonId}
    `;
    if (!lesson) throw new NotFoundError('Lesson');

    const sections = await this.sql`
      SELECT * FROM lesson_section
      WHERE lesson_id = ${lessonId}
      ORDER BY order_index, id
    `;

    return { lesson, sections };
  }

  async findSectionById(id) {
    const [row] = await this.sql`SELECT * FROM lesson_section WHERE id = ${id}`;
    if (!row) throw new NotFoundError('Section');
    return row;
  }

  async createSection(lessonId, data) {
    // Verify lesson exists
    const [lesson] = await this
      .sql`SELECT id FROM lesson WHERE id = ${lessonId}`;
    if (!lesson) throw new NotFoundError('Lesson');

    const [{ max_order }] = await this.sql`
      SELECT COALESCE(MAX(order_index), 0)::int AS max_order
      FROM lesson_section WHERE lesson_id = ${lessonId}
    `;
    const [row] = await this.sql`
      INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index)
      VALUES (
        ${lessonId}, ${data.type},
        ${data.title ?? null}, ${data.title_vi ?? null},
        ${data.content ?? null}, ${data.content_vi ?? null},
        ${data.metadata ?? {}},
        ${max_order + 1000}
      )
      RETURNING *
    `;
    return row;
  }

  async updateSection(id, data) {
    const existing = await this.findSectionById(id);
    const [row] = await this.sql`
      UPDATE lesson_section SET
        type       = ${data.type ?? existing.type},
        title      = ${data.title !== undefined ? data.title : existing.title},
        title_vi   = ${data.title_vi !== undefined ? data.title_vi : existing.title_vi},
        content    = ${data.content !== undefined ? data.content : existing.content},
        content_vi = ${data.content_vi !== undefined ? data.content_vi : existing.content_vi},
        metadata   = ${data.metadata !== undefined ? data.metadata : existing.metadata}
      WHERE id = ${id}
      RETURNING *
    `;
    return row;
  }

  async deleteSection(id) {
    await this.findSectionById(id);
    await this.sql`DELETE FROM lesson_section WHERE id = ${id}`;
    return { id };
  }

  async reorderSections(lessonId, orderedIds) {
    await this.sql.begin(async (tx) => {
      for (let i = 0; i < orderedIds.length; i++) {
        await tx`
          UPDATE lesson_section
          SET order_index = ${i * 1000}
          WHERE id = ${orderedIds[i]} AND lesson_id = ${lessonId}
        `;
      }
    });
  }
}
```

### 5.4 AdminCrudController

#### File: `server/controllers/adminCrudController.js`

```js
import { ValidationError } from '../errors/AppError.js';
import { slugify } from '../utils/slugify.js';

export class AdminCrudController {
  constructor(adminCrudRepo, adminRepo) {
    this.repo = adminCrudRepo;
    this.adminRepo = adminRepo; // for audit logging
  }

  // ─── TOPICS ──────────────────────────────────────────────

  listTopics = async () => {
    const data = await this.repo.findAllTopics();
    return { data };
  };

  createTopic = async (request) => {
    const data = await this.repo.createTopic(request.body);
    this.adminRepo.logAction({
      action: 'create',
      entityType: 'topic',
      entityId: data.id,
      metadata: { name: data.name },
      ipAddress: request.ip,
    });
    return { data };
  };

  updateTopic = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.updateTopic(id, request.body);
    this.adminRepo.logAction({
      action: 'update',
      entityType: 'topic',
      entityId: id,
      metadata: { fields: Object.keys(request.body) },
      ipAddress: request.ip,
    });
    return { data };
  };

  deleteTopic = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.deleteTopic(id);
    this.adminRepo.logAction({
      action: 'delete',
      entityType: 'topic',
      entityId: id,
      ipAddress: request.ip,
    });
    return { data };
  };

  reorderTopics = async (request) => {
    const { orderedIds } = request.body;
    if (!Array.isArray(orderedIds) || orderedIds.length === 0) {
      throw new ValidationError('orderedIds must be a non-empty array');
    }
    await this.repo.reorderTopics(orderedIds);
    this.adminRepo.logAction({
      action: 'reorder',
      entityType: 'topic',
      metadata: { orderedIds },
      ipAddress: request.ip,
    });
    return { data: { ok: true } };
  };

  // ─── CATEGORIES ──────────────────────────────────────────

  listCategories = async (request) => {
    const topicId = request.query.topicId
      ? parseInt(request.query.topicId, 10)
      : null;
    const data = await this.repo.findAllCategories(topicId);
    return { data };
  };

  createCategory = async (request) => {
    const data = await this.repo.createCategory(request.body);
    this.adminRepo.logAction({
      action: 'create',
      entityType: 'category',
      entityId: data.id,
      metadata: { name: data.name },
      ipAddress: request.ip,
    });
    return { data };
  };

  updateCategory = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.updateCategory(id, request.body);
    this.adminRepo.logAction({
      action: 'update',
      entityType: 'category',
      entityId: id,
      metadata: { fields: Object.keys(request.body) },
      ipAddress: request.ip,
    });
    return { data };
  };

  deleteCategory = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.deleteCategory(id);
    this.adminRepo.logAction({
      action: 'delete',
      entityType: 'category',
      entityId: id,
      ipAddress: request.ip,
    });
    return { data };
  };

  reorderCategories = async (request) => {
    const { orderedIds } = request.body;
    if (!Array.isArray(orderedIds) || orderedIds.length === 0) {
      throw new ValidationError('orderedIds must be a non-empty array');
    }
    await this.repo.reorderCategories(orderedIds);
    this.adminRepo.logAction({
      action: 'reorder',
      entityType: 'category',
      metadata: { orderedIds },
      ipAddress: request.ip,
    });
    return { data: { ok: true } };
  };

  // ─── LESSONS ─────────────────────────────────────────────

  listLessons = async (request) => {
    const categoryId = request.query.categoryId
      ? parseInt(request.query.categoryId, 10)
      : null;
    const search = request.query.search?.trim() || null;
    const data = await this.repo.findAllLessons({ categoryId, search });
    return { data };
  };

  getLessonById = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.findLessonById(id);
    return { data };
  };

  createLesson = async (request) => {
    const body = { ...request.body };
    // Auto-generate slug from name if not provided
    if (!body.slug) {
      body.slug = slugify(body.name);
    }
    const data = await this.repo.createLesson(body);
    this.adminRepo.logAction({
      action: 'create',
      entityType: 'lesson',
      entityId: data.id,
      metadata: { name: data.name, slug: data.slug },
      ipAddress: request.ip,
    });
    return { data };
  };

  updateLesson = async (request) => {
    const id = parseInt(request.params.id, 10);
    const body = { ...request.body };
    // Re-generate slug if name changed and slug not explicitly provided
    if (body.name && !body.slug) {
      body.slug = slugify(body.name);
    }
    const data = await this.repo.updateLesson(id, body);
    this.adminRepo.logAction({
      action: 'update',
      entityType: 'lesson',
      entityId: id,
      metadata: { fields: Object.keys(request.body) },
      ipAddress: request.ip,
    });
    return { data };
  };

  deleteLesson = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.deleteLesson(id);
    this.adminRepo.logAction({
      action: 'delete',
      entityType: 'lesson',
      entityId: id,
      ipAddress: request.ip,
    });
    return { data };
  };

  reorderLessons = async (request) => {
    const { orderedIds } = request.body;
    if (!Array.isArray(orderedIds) || orderedIds.length === 0) {
      throw new ValidationError('orderedIds must be a non-empty array');
    }
    await this.repo.reorderLessons(orderedIds);
    this.adminRepo.logAction({
      action: 'reorder',
      entityType: 'lesson',
      metadata: { orderedIds },
      ipAddress: request.ip,
    });
    return { data: { ok: true } };
  };

  // ─── SECTIONS ────────────────────────────────────────────

  listSections = async (request) => {
    const lessonId = parseInt(request.params.lessonId, 10);
    const data = await this.repo.findSectionsByLesson(lessonId);
    return { data };
  };

  createSection = async (request) => {
    const lessonId = parseInt(request.params.lessonId, 10);
    const data = await this.repo.createSection(lessonId, request.body);
    this.adminRepo.logAction({
      action: 'create',
      entityType: 'section',
      entityId: data.id,
      metadata: { lessonId, type: data.type },
      ipAddress: request.ip,
    });
    return { data };
  };

  updateSection = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.updateSection(id, request.body);
    this.adminRepo.logAction({
      action: 'update',
      entityType: 'section',
      entityId: id,
      metadata: { fields: Object.keys(request.body) },
      ipAddress: request.ip,
    });
    return { data };
  };

  deleteSection = async (request) => {
    const id = parseInt(request.params.id, 10);
    const data = await this.repo.deleteSection(id);
    this.adminRepo.logAction({
      action: 'delete',
      entityType: 'section',
      entityId: id,
      ipAddress: request.ip,
    });
    return { data };
  };

  reorderSections = async (request) => {
    const lessonId = parseInt(request.params.lessonId, 10);
    const { orderedIds } = request.body;
    if (!Array.isArray(orderedIds) || orderedIds.length === 0) {
      throw new ValidationError('orderedIds must be a non-empty array');
    }
    await this.repo.reorderSections(lessonId, orderedIds);
    this.adminRepo.logAction({
      action: 'reorder',
      entityType: 'section',
      metadata: { lessonId, orderedIds },
      ipAddress: request.ip,
    });
    return { data: { ok: true } };
  };
}
```

### 5.5 AdminCrudRoutes

#### File: `server/routes/adminCrudRoutes.js`

JSON Schema validation on all mutation endpoints. Uses Fastify's built-in `schema` option which returns `400` automatically on validation failure.

```js
/** Admin CRUD routes — all require adminAuth */
export function adminCrudRoutes(controller, adminAuth) {
  return async function (fastify) {
    fastify.addHook('preHandler', adminAuth);

    // ─── Shared schemas ─────────────────────────────────────

    const idParams = {
      type: 'object',
      required: ['id'],
      properties: { id: { type: 'string', pattern: '^\\d+$' } },
    };

    const lessonIdParams = {
      type: 'object',
      required: ['lessonId'],
      properties: { lessonId: { type: 'string', pattern: '^\\d+$' } },
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

    // ─── TOPIC routes ───────────────────────────────────────

    fastify.get('/topics', controller.listTopics);

    fastify.post('/topics', {
      schema: {
        body: {
          type: 'object',
          required: ['name', 'name_vi', 'color'],
          properties: {
            name: { type: 'string', maxLength: 100 },
            name_vi: { type: 'string', maxLength: 100 },
            description: { type: 'string' },
            description_vi: { type: 'string' },
            icon: { type: 'string', maxLength: 50 },
            color: { type: 'string', pattern: hexColorPattern },
          },
        },
      },
      handler: controller.createTopic,
    });

    fastify.put('/topics/:id', {
      schema: {
        params: idParams,
        body: {
          type: 'object',
          properties: {
            name: { type: 'string', maxLength: 100 },
            name_vi: { type: 'string', maxLength: 100 },
            description: { type: ['string', 'null'] },
            description_vi: { type: ['string', 'null'] },
            icon: { type: ['string', 'null'], maxLength: 50 },
            color: { type: 'string', pattern: hexColorPattern },
          },
        },
      },
      handler: controller.updateTopic,
    });

    fastify.delete('/topics/:id', {
      schema: { params: idParams },
      handler: controller.deleteTopic,
    });

    fastify.post('/topics/reorder', {
      schema: reorderSchema,
      handler: controller.reorderTopics,
    });

    // ─── CATEGORY routes ────────────────────────────────────

    fastify.get('/categories', controller.listCategories);

    fastify.post('/categories', {
      schema: {
        body: {
          type: 'object',
          required: ['name', 'name_vi', 'color'],
          properties: {
            name: { type: 'string', maxLength: 100 },
            name_vi: { type: 'string', maxLength: 100 },
            description: { type: 'string' },
            description_vi: { type: 'string' },
            icon: { type: 'string', maxLength: 50 },
            color: { type: 'string', pattern: hexColorPattern },
            topic_id: { type: ['integer', 'null'] },
          },
        },
      },
      handler: controller.createCategory,
    });

    fastify.put('/categories/:id', {
      schema: {
        params: idParams,
        body: {
          type: 'object',
          properties: {
            name: { type: 'string', maxLength: 100 },
            name_vi: { type: 'string', maxLength: 100 },
            description: { type: ['string', 'null'] },
            description_vi: { type: ['string', 'null'] },
            icon: { type: ['string', 'null'], maxLength: 50 },
            color: { type: 'string', pattern: hexColorPattern },
            topic_id: { type: ['integer', 'null'] },
          },
        },
      },
      handler: controller.updateCategory,
    });

    fastify.delete('/categories/:id', {
      schema: { params: idParams },
      handler: controller.deleteCategory,
    });

    fastify.post('/categories/reorder', {
      schema: reorderSchema,
      handler: controller.reorderCategories,
    });

    // ─── LESSON routes ──────────────────────────────────────

    fastify.get('/lessons', controller.listLessons);

    fastify.get('/lessons/:id', {
      schema: { params: idParams },
      handler: controller.getLessonById,
    });

    fastify.post('/lessons', {
      schema: {
        body: {
          type: 'object',
          required: ['name', 'name_vi', 'group_id'],
          properties: {
            name: { type: 'string', maxLength: 100 },
            name_vi: { type: 'string', maxLength: 100 },
            slug: { type: 'string', maxLength: 100 },
            short_desc: { type: 'string', maxLength: 255 },
            short_desc_vi: { type: 'string', maxLength: 255 },
            description: { type: 'string' },
            description_vi: { type: 'string' },
            group_id: { type: 'integer' },
            difficulty: {
              type: 'string',
              enum: ['beginner', 'intermediate', 'advanced'],
            },
            estimated_time: { type: ['integer', 'null'], minimum: 0 },
            is_published: { type: 'boolean' },
          },
        },
      },
      handler: controller.createLesson,
    });

    fastify.put('/lessons/:id', {
      schema: {
        params: idParams,
        body: {
          type: 'object',
          properties: {
            name: { type: 'string', maxLength: 100 },
            name_vi: { type: 'string', maxLength: 100 },
            slug: { type: 'string', maxLength: 100 },
            short_desc: { type: ['string', 'null'], maxLength: 255 },
            short_desc_vi: { type: ['string', 'null'], maxLength: 255 },
            description: { type: ['string', 'null'] },
            description_vi: { type: ['string', 'null'] },
            group_id: { type: 'integer' },
            difficulty: {
              type: 'string',
              enum: ['beginner', 'intermediate', 'advanced'],
            },
            estimated_time: { type: ['integer', 'null'], minimum: 0 },
            is_published: { type: 'boolean' },
          },
        },
      },
      handler: controller.updateLesson,
    });

    fastify.delete('/lessons/:id', {
      schema: { params: idParams },
      handler: controller.deleteLesson,
    });

    fastify.post('/lessons/reorder', {
      schema: reorderSchema,
      handler: controller.reorderLessons,
    });

    // ─── SECTION routes ─────────────────────────────────────

    const sectionTypes = [
      'markdown',
      'key_points',
      'info_box',
      'audio',
      'video',
      'chart',
      'diagram',
      'image',
      'interactive_chart',
    ];

    fastify.get('/lessons/:lessonId/sections', {
      schema: { params: lessonIdParams },
      handler: controller.listSections,
    });

    fastify.post('/lessons/:lessonId/sections', {
      schema: {
        params: lessonIdParams,
        body: {
          type: 'object',
          required: ['type'],
          properties: {
            type: { type: 'string', enum: sectionTypes },
            title: { type: 'string', maxLength: 255 },
            title_vi: { type: 'string', maxLength: 255 },
            content: { type: ['string', 'null'] },
            content_vi: { type: ['string', 'null'] },
            metadata: { type: 'object' },
          },
        },
      },
      handler: controller.createSection,
    });

    fastify.put('/sections/:id', {
      schema: {
        params: idParams,
        body: {
          type: 'object',
          properties: {
            type: { type: 'string', enum: sectionTypes },
            title: { type: ['string', 'null'], maxLength: 255 },
            title_vi: { type: ['string', 'null'], maxLength: 255 },
            content: { type: ['string', 'null'] },
            content_vi: { type: ['string', 'null'] },
            metadata: { type: 'object' },
          },
        },
      },
      handler: controller.updateSection,
    });

    fastify.delete('/sections/:id', {
      schema: { params: idParams },
      handler: controller.deleteSection,
    });

    fastify.post('/lessons/:lessonId/sections/reorder', {
      schema: {
        params: lessonIdParams,
        ...reorderSchema,
      },
      handler: controller.reorderSections,
    });
  };
}
```

### 5.6 Composition Root Wiring

#### File: `server/index.js` — additions

```js
// After existing imports, add:
import { AdminCrudRepository } from './repositories/adminCrudRepository.js';
import { AdminCrudController } from './controllers/adminCrudController.js';

// After existing wiring (line ~92), add:
const adminCrudRepo = new AdminCrudRepository(sql);
const adminCrudController = new AdminCrudController(adminCrudRepo, adminRepo);

// Pass to createApp:
const app = await createApp({
  // ... existing controllers ...
  adminCrudController, // ← NEW
  // ...
});
```

### 5.7 App.js Updates

#### File: `server/app.js` — changes

**1. CORS methods — add PUT and DELETE:**

```js
// Change line 76 from:
methods: ['GET', 'POST'],
// To:
methods: ['GET', 'POST', 'PUT', 'DELETE'],
```

**2. Import and register adminCrudRoutes:**

```js
// Add import:
import { adminCrudRoutes } from './routes/adminCrudRoutes.js';

// Add to createApp parameters:
export async function createApp({
  // ... existing ...
  adminCrudController,  // ← NEW
  // ...
}) {

// Add route registration after existing admin routes (line ~167):
if (adminCrudController) {
  app.register(adminCrudRoutes(adminCrudController, adminAuth), {
    prefix: '/api/admin',
  });
}
```

---

## SECTION 6: Frontend Implementation

### 6.1 API Client Additions

#### File: `src/api/admin.js` — add CRUD functions

```js
// ─── TOPICS ─────────────────────────────────────────────

export function fetchAdminTopics() {
  return adminRequest('/topics');
}

export function createAdminTopic(data) {
  return adminRequest('/topics', {
    method: 'POST',
    body: JSON.stringify(data),
  });
}

export function updateAdminTopic(id, data) {
  return adminRequest(`/topics/${id}`, {
    method: 'PUT',
    body: JSON.stringify(data),
  });
}

export function deleteAdminTopic(id) {
  return adminRequest(`/topics/${id}`, { method: 'DELETE' });
}

export function reorderAdminTopics(orderedIds) {
  return adminRequest('/topics/reorder', {
    method: 'POST',
    body: JSON.stringify({ orderedIds }),
  });
}

// ─── CATEGORIES ──────────────────────────────────────────

export function fetchAdminCategories(topicId) {
  const qs = topicId ? `?topicId=${topicId}` : '';
  return adminRequest(`/categories${qs}`);
}

export function createAdminCategory(data) {
  return adminRequest('/categories', {
    method: 'POST',
    body: JSON.stringify(data),
  });
}

export function updateAdminCategory(id, data) {
  return adminRequest(`/categories/${id}`, {
    method: 'PUT',
    body: JSON.stringify(data),
  });
}

export function deleteAdminCategory(id) {
  return adminRequest(`/categories/${id}`, { method: 'DELETE' });
}

export function reorderAdminCategories(orderedIds) {
  return adminRequest('/categories/reorder', {
    method: 'POST',
    body: JSON.stringify({ orderedIds }),
  });
}

// ─── LESSONS ─────────────────────────────────────────────

export function fetchAdminLessons({ categoryId, search } = {}) {
  const params = new URLSearchParams();
  if (categoryId) params.set('categoryId', categoryId);
  if (search) params.set('search', search);
  const qs = params.toString();
  return adminRequest(`/lessons${qs ? `?${qs}` : ''}`);
}

export function fetchAdminLesson(id) {
  return adminRequest(`/lessons/${id}`);
}

export function createAdminLesson(data) {
  return adminRequest('/lessons', {
    method: 'POST',
    body: JSON.stringify(data),
  });
}

export function updateAdminLesson(id, data) {
  return adminRequest(`/lessons/${id}`, {
    method: 'PUT',
    body: JSON.stringify(data),
  });
}

export function deleteAdminLesson(id) {
  return adminRequest(`/lessons/${id}`, { method: 'DELETE' });
}

export function reorderAdminLessons(orderedIds) {
  return adminRequest('/lessons/reorder', {
    method: 'POST',
    body: JSON.stringify({ orderedIds }),
  });
}

// ─── SECTIONS ────────────────────────────────────────────

export function fetchAdminSections(lessonId) {
  return adminRequest(`/lessons/${lessonId}/sections`);
}

export function createAdminSection(lessonId, data) {
  return adminRequest(`/lessons/${lessonId}/sections`, {
    method: 'POST',
    body: JSON.stringify(data),
  });
}

export function updateAdminSection(id, data) {
  return adminRequest(`/sections/${id}`, {
    method: 'PUT',
    body: JSON.stringify(data),
  });
}

export function deleteAdminSection(id) {
  return adminRequest(`/sections/${id}`, { method: 'DELETE' });
}

export function reorderAdminSections(lessonId, orderedIds) {
  return adminRequest(`/lessons/${lessonId}/sections/reorder`, {
    method: 'POST',
    body: JSON.stringify({ orderedIds }),
  });
}
```

### 6.2 AdminDataTable Component

#### File: `src/components/admin/AdminDataTable.jsx`

Headless TanStack Table wrapper with pixel art styling. Features:

- Column sorting (click header)
- Text search filtering (global)
- Pagination (configurable page size)
- Sortable rows via dnd-kit integration (when `onReorder` is provided)
- Empty state
- Loading state

**Component API:**

```jsx
<AdminDataTable
  data={rows} // array of row objects
  columns={columns} // TanStack column defs
  searchPlaceholder="..." // global filter placeholder
  onReorder={handleReorder} // optional — enables drag-and-drop
  pageSize={20} // optional — default 20
  loading={false} // optional — shows skeleton
/>
```

**Key implementation details:**

- Uses `@tanstack/react-table` `useReactTable` with `getCoreRowModel`, `getSortedRowModel`, `getFilteredRowModel`, `getPaginationRowModel`
- Table rendered as MUI `Table` component for pixel theme integration
- Sorting: `SortingState` + clickable headers with sort indicator
- Filtering: `globalFilter` connected to a debounced text input
- When `onReorder` is provided, renders `DndContext` + `SortableContext` wrapping table body, with drag handle column prepended

### 6.3 DragHandle Component

#### File: `src/components/admin/DragHandle.jsx`

Small component using `useSortable` from dnd-kit:

```jsx
import { useSortable } from '@dnd-kit/sortable';
import DragIndicatorIcon from '@mui/icons-material/DragIndicator';
import IconButton from '@mui/material/IconButton';

export default function DragHandle({ id }) {
  const { attributes, listeners, setNodeRef } = useSortable({ id });
  return (
    <IconButton
      ref={setNodeRef}
      {...attributes}
      {...listeners}
      size="small"
      sx={{ cursor: 'grab', '&:active': { cursor: 'grabbing' } }}
    >
      <DragIndicatorIcon fontSize="small" />
    </IconButton>
  );
}
```

### 6.4 DeleteConfirmDialog Component

#### File: `src/components/admin/DeleteConfirmDialog.jsx`

Reusable confirmation dialog with pixel theme:

```jsx
<DeleteConfirmDialog
  open={!!deleteTarget}
  title="Delete Topic?"
  message={`Are you sure you want to delete "${deleteTarget?.name}"?`}
  onConfirm={handleDelete}
  onCancel={() => setDeleteTarget(null)}
  loading={deleting}
/>
```

### 6.5 ColorPickerField Component

#### File: `src/components/admin/ColorPickerField.jsx`

Hex color picker with preset PICO-8 swatches + custom input:

- Displays a grid of 16 PICO-8 color swatches from `pixelTheme.js`
- Plus a text input for custom `#RRGGBB` values
- Validates hex format
- Shows color preview swatch next to input

```jsx
<ColorPickerField value={color} onChange={setColor} label="Color" />
```

### 6.6 IconPickerField Component

#### File: `src/components/admin/IconPickerField.jsx`

MUI icon picker — simple text input with icon preview:

- Text input for MUI icon name (e.g. `"MenuBook"`, `"Science"`)
- Shows a preview of the icon next to the input
- Uses a predefined list of ~30 common icons as suggestions in a dropdown
- Icons are imported dynamically from `@mui/icons-material`

**Approach:** Use a curated list of 30-40 common MUI icon names as a Autocomplete dropdown. Each option shows the icon + label. The value is stored as a string (MUI icon name) matching the existing `icon VARCHAR(50)` column pattern.

```jsx
<IconPickerField value={icon} onChange={setIcon} label="Icon" />
```

### 6.7 AdminFormField Component

#### File: `src/components/admin/AdminFormField.jsx`

Thin wrapper around MUI `TextField` with admin form defaults:

```jsx
// Applies: fullWidth, variant="outlined", size="small", pixel theme margins
<AdminFormField
  label="Name (English)"
  value={name}
  onChange={(e) => setName(e.target.value)}
  required
  error={!name}
  helperText={!name ? 'Required' : ''}
/>
```

### 6.8 TopicFormDialog Component

#### File: `src/components/admin/TopicFormDialog.jsx`

Modal dialog for creating/editing topics:

- `open`, `onClose`, `onSave`, `initialData` (null = create mode)
- Fields: name, name_vi, description, description_vi, icon (IconPickerField), color (ColorPickerField)
- Client-side validation: name + name_vi + color required
- Submit button with `loading` prop
- Calls `onSave(formData)` — parent handles API call

### 6.9 CategoryFormDialog Component

#### File: `src/components/admin/CategoryFormDialog.jsx`

Modal dialog for creating/editing categories:

- Same pattern as TopicFormDialog
- Additional field: `topic_id` — Select dropdown populated from topics list
- Fields: name, name_vi, description, description_vi, icon, color, topic_id

### 6.10 AdminTopicsPage

#### File: `src/pages/admin/AdminTopicsPage.jsx`

```jsx
export async function loader() {
  const { data } = await fetchAdminTopics();
  return { topics: data };
}

export default function AdminTopicsPage() {
  const loaderData = useLoaderData();
  const [topics, setTopics] = useState(loaderData.topics);
  useEffect(() => { setTopics(loaderData.topics); }, [loaderData]);

  // State: dialogOpen, editTarget, deleteTarget

  const columns = [
    // drag handle (when reorder enabled)
    { accessorKey: 'name', header: 'Name' },
    { accessorKey: 'name_vi', header: 'Tieng Viet' },
    { accessorKey: 'color', header: 'Color', cell: ColorCell },
    { accessorKey: 'icon', header: 'Icon', cell: IconCell },
    { accessorKey: 'category_count', header: 'Categories' },
    { id: 'actions', header: '', cell: ActionsCell },
  ];

  // Handlers: handleCreate, handleUpdate, handleDelete, handleReorder
  // Each calls API → updates local state optimistically → revalidates

  return (
    <Box>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 3 }}>
        <Typography variant="h2">Topics</Typography>
        <Button onClick={() => setDialogOpen(true)}>+ New Topic</Button>
      </Box>
      <AdminDataTable
        data={topics}
        columns={columns}
        searchPlaceholder="Search topics..."
        onReorder={handleReorder}
      />
      <TopicFormDialog
        open={dialogOpen}
        onClose={() => { setDialogOpen(false); setEditTarget(null); }}
        onSave={editTarget ? handleUpdate : handleCreate}
        initialData={editTarget}
      />
      <DeleteConfirmDialog ... />
    </Box>
  );
}
```

### 6.11 AdminCategoriesPage

#### File: `src/pages/admin/AdminCategoriesPage.jsx`

Same pattern as Topics page, with additions:

- Topic filter dropdown at the top (fetches topics for dropdown)
- `topic_name` displayed in a column
- `lesson_count` column
- Category form dialog with `topic_id` select

**Loader:**

```jsx
export async function loader() {
  const [{ data: categories }, { data: topics }] = await Promise.all([
    fetchAdminCategories(),
    fetchAdminTopics(),
  ]);
  return { categories, topics };
}
```

### 6.12 AdminLessonsPage

#### File: `src/pages/admin/AdminLessonsPage.jsx`

Lesson list page with:

- Search input (text filter, debounced)
- Category filter dropdown
- Table columns: name, category, difficulty, published status, exercise count, section count, actions
- Actions: Edit (navigates to `/admin/lessons/:id/edit`), Sections (navigates to `/admin/lessons/:id/sections`), Delete
- "New Lesson" button navigates to `/admin/lessons/new`
- No drag-and-drop on main list (reorder per-category only)

**Loader:**

```jsx
export async function loader({ request }) {
  const url = new URL(request.url);
  const categoryId = url.searchParams.get('categoryId');
  const search = url.searchParams.get('search');
  const [{ data: lessons }, { data: categories }] = await Promise.all([
    fetchAdminLessons({ categoryId, search }),
    fetchAdminCategories(),
  ]);
  return { lessons, categories, filters: { categoryId, search } };
}
```

### 6.13 AdminLessonFormPage

#### File: `src/pages/admin/AdminLessonFormPage.jsx`

Full-page form for creating/editing a lesson:

- Two modes: Create (`/admin/lessons/new`) and Edit (`/admin/lessons/:id/edit`)
- Fields organized in sections:
  1. **Basic Info:** name, name_vi, slug (auto-generated, editable), short_desc, short_desc_vi
  2. **Content:** description (textarea), description_vi (textarea)
  3. **Settings:** group_id (category select), difficulty (select), estimated_time, is_published (switch)
- Save button → POST or PUT → navigate back to lesson list
- Cancel button → navigate back

**Loader (edit mode):**

```jsx
export async function loader({ params }) {
  if (params.id === 'new') {
    const { data: categories } = await fetchAdminCategories();
    return { lesson: null, categories };
  }
  const [{ data: lesson }, { data: categories }] = await Promise.all([
    fetchAdminLesson(params.id),
    fetchAdminCategories(),
  ]);
  return { lesson, categories };
}
```

### 6.14 AdminSectionsPage

#### File: `src/pages/admin/AdminSectionsPage.jsx`

Section editor for a specific lesson at `/admin/lessons/:id/sections`:

- Shows lesson name as breadcrumb/title
- List of sections with drag-and-drop reorder
- Each section card shows: type badge, title, content preview (truncated)
- Inline edit: click section card → expand to edit form (title, content, metadata)
- Add section: "Add Section" button opens a mini-form below the list
- Section type selector (9 types) as a chip group
- Content field adapts based on type:
  - `markdown`, `key_points`, `info_box`: textarea for content
  - `audio`, `video`, `image`: metadata JSON editor (url, alt, etc.)
  - `chart`, `diagram`, `interactive_chart`: metadata JSON editor
- Delete: icon button on each section

**Loader:**

```jsx
export async function loader({ params }) {
  const { data } = await fetchAdminSections(params.id);
  return data; // { lesson, sections }
}
```

### 6.15 Router Updates

#### File: `src/router.jsx` — add admin children

```jsx
// Inside the /admin route children array, add:
{
  path: 'topics',
  lazy: async () => {
    const { default: Component, loader } =
      await import('./pages/admin/AdminTopicsPage.jsx');
    return { Component, loader };
  },
  ErrorBoundary: ErrorPage,
},
{
  path: 'categories',
  lazy: async () => {
    const { default: Component, loader } =
      await import('./pages/admin/AdminCategoriesPage.jsx');
    return { Component, loader };
  },
  ErrorBoundary: ErrorPage,
},
{
  path: 'lessons',
  lazy: async () => {
    const { default: Component, loader } =
      await import('./pages/admin/AdminLessonsPage.jsx');
    return { Component, loader };
  },
  ErrorBoundary: ErrorPage,
},
{
  path: 'lessons/:id/edit',
  lazy: async () => {
    const { default: Component, loader } =
      await import('./pages/admin/AdminLessonFormPage.jsx');
    return { Component, loader };
  },
  ErrorBoundary: ErrorPage,
},
{
  path: 'lessons/new',
  lazy: async () => {
    const { default: Component, loader } =
      await import('./pages/admin/AdminLessonFormPage.jsx');
    return { Component, loader };
  },
  ErrorBoundary: ErrorPage,
},
{
  path: 'lessons/:id/sections',
  lazy: async () => {
    const { default: Component, loader } =
      await import('./pages/admin/AdminSectionsPage.jsx');
    return { Component, loader };
  },
  ErrorBoundary: ErrorPage,
},
```

**Important:** Route order matters — `lessons/new` must come before `lessons/:id/edit` to avoid the `:id` param capturing "new".

### 6.16 Drag-and-Drop Reorder Implementation

All four entity pages (topics, categories, lessons within category, sections) use the same reorder pattern:

```jsx
import {
  DndContext,
  closestCenter,
  KeyboardSensor,
  PointerSensor,
  useSensor,
  useSensors,
} from '@dnd-kit/core';
import {
  SortableContext,
  verticalListSortingStrategy,
  arrayMove,
} from '@dnd-kit/sortable';
import { restrictToVerticalAxis } from '@dnd-kit/modifiers';

// In the page component:
const sensors = useSensors(
  useSensor(PointerSensor, { activationConstraint: { distance: 5 } }),
  useSensor(KeyboardSensor),
);

function handleDragEnd(event) {
  const { active, over } = event;
  if (!over || active.id === over.id) return;

  const oldIndex = items.findIndex((i) => i.id === active.id);
  const newIndex = items.findIndex((i) => i.id === over.id);
  const newItems = arrayMove(items, oldIndex, newIndex);

  // Optimistic update
  setItems(newItems);

  // Persist to server
  const orderedIds = newItems.map((i) => i.id);
  reorderApi(orderedIds).catch(() => {
    // Revert on failure
    setItems(items);
  });
}
```

The `AdminDataTable` wraps table body in `DndContext` + `SortableContext` when `onReorder` is provided. Each `TableRow` becomes a sortable item using `useSortable`. The drag handle is shown as the first column.

---

## SECTION 7: Reorder Algorithm

### Gap-Based Order Index

**Strategy:** Assign `order_index` values with gaps of 1000 between items.

| Operation         | Algorithm                                                                                                                                                     |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Create**        | `MAX(order_index) + 1000` — always append to end                                                                                                              |
| **Drag-and-drop** | Client sends `orderedIds` array → server assigns `index * 1000` to each                                                                                       |
| **Why gaps?**     | Single-item moves can compute new `order_index` as midpoint between neighbors without rewriting all rows. Batch reorder (POST /reorder) rewrites all indices. |

**Compaction:** With gaps of 1000 and INTEGER type (max ~2.1B), compaction is only needed after ~2.1M reorders of the same set — effectively never needed.

**Transaction safety:** All reorder operations run inside `sql.begin()` transaction. If any UPDATE fails, the entire batch rolls back.

**Example:**

```
Before drag:  [A:0, B:1000, C:2000, D:3000]
Drag C → position 1:
After:        [A:0, C:1000, B:2000, D:3000]
```

The server receives `orderedIds: [A.id, C.id, B.id, D.id]` and assigns `0, 1000, 2000, 3000`.

---

## SECTION 8: Security

### 8.1 Authentication

- All admin CRUD routes are behind `adminAuth` preHandler hook (JWT cookie verification)
- The `adminAuth` hook throws `UnauthorizedError` (401) if token is missing/invalid
- Applied at plugin level: `fastify.addHook('preHandler', adminAuth)` in `adminCrudRoutes`

### 8.2 Input Validation

- **Fastify JSON Schema** validates all mutation request bodies at the framework level
- Schema validation runs BEFORE the controller handler — invalid requests never reach business logic
- Rejects: missing required fields, wrong types, invalid enums, exceeding maxLength, invalid hex color patterns

### 8.3 SQL Injection Prevention

- **postgres.js tagged templates** (`sql\`...\``) parameterize all values automatically
- No string concatenation in any SQL query
- Dynamic query branches (e.g., optional filters) use separate template calls, not interpolation

### 8.4 CORS

- CORS updated to allow `PUT` and `DELETE` methods (currently only `GET`, `POST`)
- Origin remains restricted to `CORS_ORIGIN` env var
- Credentials: `true` (for cookie-based auth)

### 8.5 Audit Trail

- Every mutation (create, update, delete, reorder) logs to `admin_action_log` table
- Fire-and-forget pattern (no `await`) — audit logging failure does not break the operation
- Logs: action, entity_type, entity_id, metadata (changed fields), ip_address

### 8.6 Data Integrity

- `topic.name` has UNIQUE constraint — duplicate names return 409 (caught by DB, surfaced as error)
- `category.name` has UNIQUE constraint
- `lesson.name` and `lesson.slug` have UNIQUE constraints
- `category → lesson` FK has `ON DELETE RESTRICT` — cannot delete category with lessons
- `lesson → section` FK has `ON DELETE CASCADE` — deleting lesson removes sections automatically
- Reorder operations run in transactions — partial failures roll back

---

## SECTION 9: CI Compatibility

### 9.1 Migration

- Add `024_widen_order_index_for_reorder.sql` to `database/migrations/`
- CI integration test job runs migrations before tests — new migration will be picked up automatically
- No ENUM changes (no `ALTER TYPE ... ADD VALUE` issues)

### 9.2 CORS Change

- Adding `PUT` and `DELETE` to CORS methods is backward-compatible — existing GET/POST requests unaffected
- No breaking changes to existing API endpoints

### 9.3 Existing Tests

- No existing test files are modified
- New routes are under `/api/admin/*` — existing public API tests are unaffected
- The `ConflictError` addition to `AppError.js` is purely additive

### 9.4 Build

- New client dependencies are ESM-compatible and tree-shakeable
- All new admin pages use `lazy()` imports — no impact on initial bundle size
- Estimated chunk additions: ~33KB gz total (`@tanstack/react-table` 15KB + `@dnd-kit/*` 18KB)

### 9.5 E2E Tests

- Existing Playwright tests only cover public routes — admin CRUD pages don't affect them
- No E2E updates required for Phase 2A

---

## SECTION 10: Appendix

### A1. Icon Picker Approach

**Curated list approach** (not dynamic import):

- Define an array of ~40 common MUI icon names used across the app
- Map each name to its import: `{ name: 'MenuBook', Component: MenuBookIcon }`
- Render as MUI `Autocomplete` with icon preview in each option
- Value stored as string in DB `icon VARCHAR(50)` (e.g., `"MenuBook"`)
- This matches the existing pattern where `category.icon` and `topic.icon` store MUI icon names as strings

**Icon list includes:** Dashboard, MenuBook, Science, Psychology, Palette, Business, School, Code, Calculate, History, Language, MusicNote, Biotech, AccountBalance, TrendingUp, Lightbulb, Build, LocalHospital, Public, AutoStories, FolderOpen, Category, Assignment, Extension, Explore, Visibility, EmojiObjects, Architecture, Handyman, Analytics

### A2. Color Picker Approach

**PICO-8 swatches + custom hex:**

- Grid of 16 PICO-8 colors from `pixelTheme.js` as clickable swatches
- Text input for custom `#RRGGBB` (validated against `^#[0-9A-Fa-f]{6}$`)
- Color preview box showing current selection
- No external color picker library needed — keeps bundle small

**PICO-8 palette (from theme):**

```
#000000 #1D2B53 #7E2553 #008751
#AB5236 #5F574F #C2C3C7 #FFF1E8
#FF004D #FFA300 #FFEC27 #00E436
#29ADFF #83769C #FF77A8 #FFCCAA
```

### A3. Slug Generation

- Auto-generated from English name on create
- Regenerated when name changes (unless slug explicitly provided in request body)
- Handles Vietnamese diacritics: `normalize('NFD')` + strip combining marks + `đ/Đ` → `d/D`
- URL-safe: lowercase, non-alphanumeric → dashes, trim leading/trailing dashes
- UNIQUE constraint in DB prevents collisions (409 error surfaced to user)

### A4. Optimistic Updates Pattern

All CRUD pages follow this pattern for responsive UX:

```jsx
// 1. Load via React Router loader
const loaderData = useLoaderData();
const [items, setItems] = useState(loaderData.items);
useEffect(() => {
  setItems(loaderData.items);
}, [loaderData]);

// 2. Optimistic create
async function handleCreate(formData) {
  const { data } = await createApi(formData);
  setItems((prev) => [...prev, data]); // immediate update
}

// 3. Optimistic update
async function handleUpdate(id, formData) {
  const { data } = await updateApi(id, formData);
  setItems((prev) => prev.map((i) => (i.id === id ? data : i)));
}

// 4. Optimistic delete
async function handleDelete(id) {
  setItems((prev) => prev.filter((i) => i.id !== id)); // immediate remove
  await deleteApi(id).catch(() => {
    // revert on failure — re-fetch from loader
    setItems(loaderData.items);
  });
}

// 5. Optimistic reorder
function handleReorder(orderedIds) {
  const newItems = orderedIds.map((id) => items.find((i) => i.id === id));
  setItems(newItems);
  reorderApi(orderedIds).catch(() => setItems(items));
}
```

### A5. Section Type → Form Field Mapping

| Section Type        | Content Field                    | Metadata Fields                                         |
| ------------------- | -------------------------------- | ------------------------------------------------------- |
| `markdown`          | Textarea (Markdown)              | —                                                       |
| `key_points`        | Textarea (Markdown, bullet list) | —                                                       |
| `info_box`          | Textarea                         | `{ variant: "tip" \| "warning" \| "info" }`             |
| `audio`             | — (null)                         | `{ url, title, duration }`                              |
| `video`             | — (null)                         | `{ url, provider: "youtube" \| "vimeo", thumbnailUrl }` |
| `chart`             | — (null)                         | `{ chartType, data, options }`                          |
| `diagram`           | Textarea (Mermaid syntax)        | `{ diagramType }`                                       |
| `image`             | — (null)                         | `{ url, alt, caption, width }`                          |
| `interactive_chart` | — (null)                         | `{ generator, params, chartType, title }`               |

### A6. File Summary — All Changes

| File                                                        | Action | Description                                          |
| ----------------------------------------------------------- | ------ | ---------------------------------------------------- |
| `database/migrations/024_widen_order_index_for_reorder.sql` | NEW    | Widen order_index for gap reorder                    |
| `server/utils/slugify.js`                                   | NEW    | URL slug generation                                  |
| `server/repositories/adminCrudRepository.js`                | NEW    | CRUD queries (topics, categories, lessons, sections) |
| `server/controllers/adminCrudController.js`                 | NEW    | CRUD handlers with audit logging                     |
| `server/routes/adminCrudRoutes.js`                          | NEW    | Route defs with JSON Schema validation               |
| `server/index.js`                                           | MOD    | Wire AdminCrudRepository + Controller                |
| `server/app.js`                                             | MOD    | Register CRUD routes, update CORS methods            |
| `server/errors/AppError.js`                                 | MOD    | Add ConflictError (409)                              |
| `src/api/admin.js`                                          | MOD    | Add 20 CRUD API functions                            |
| `src/router.jsx`                                            | MOD    | Add 6 admin route entries                            |
| `src/components/admin/AdminDataTable.jsx`                   | NEW    | TanStack Table wrapper                               |
| `src/components/admin/DragHandle.jsx`                       | NEW    | Drag handle for sortable rows                        |
| `src/components/admin/TopicFormDialog.jsx`                  | NEW    | Topic create/edit modal                              |
| `src/components/admin/CategoryFormDialog.jsx`               | NEW    | Category create/edit modal                           |
| `src/components/admin/DeleteConfirmDialog.jsx`              | NEW    | Confirmation dialog                                  |
| `src/components/admin/ColorPickerField.jsx`                 | NEW    | Hex color picker                                     |
| `src/components/admin/IconPickerField.jsx`                  | NEW    | MUI icon picker                                      |
| `src/components/admin/AdminFormField.jsx`                   | NEW    | Styled text field wrapper                            |
| `src/pages/admin/AdminTopicsPage.jsx`                       | NEW    | Topics list + CRUD + reorder                         |
| `src/pages/admin/AdminCategoriesPage.jsx`                   | NEW    | Categories list + CRUD + reorder                     |
| `src/pages/admin/AdminLessonsPage.jsx`                      | NEW    | Lessons list page                                    |
| `src/pages/admin/AdminLessonFormPage.jsx`                   | NEW    | Lesson create/edit form                              |
| `src/pages/admin/AdminSectionsPage.jsx`                     | NEW    | Section editor page                                  |

**Total: 18 new files, 5 modified files**
