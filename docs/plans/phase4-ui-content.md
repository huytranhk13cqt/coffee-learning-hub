# Phase 4: 64-bit Pixel Art UI Overhaul + Content Generation — Implementation Plan

> **Phase 4A**: 64-bit Pixel Art UI/UX Overhaul (admin + user-facing themes)
> **Phase 4B**: Content Generation (Claude API proxy) + YAML Import (admin UI wrapper)
> Priority: 4A FIRST → 4B SECOND
> Estimated files: ~12 new files (5 server, 7 client), ~18 modified files

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

### Phase 4A: 64-bit Pixel Art UI/UX Overhaul

Evolve the visual identity from **8-bit PICO-8 (NES era)** to **64-bit refined pixel art (PS1/N64 era)**:

| Aspect         | Current (8-bit)                   | Target (64-bit)                                 |
| -------------- | --------------------------------- | ----------------------------------------------- |
| Body font      | `VT323` (blocky monospace)        | `Space Grotesk` (geometric sans, readable)      |
| Heading font   | `Press Start 2P` (chunky, h1-h3)  | `Silkscreen` only for h1-h3 display headings    |
| Data/code font | `VT323`                           | `JetBrains Mono` (legible monospace)            |
| Border radius  | 0 everywhere                      | 2-4px (subtle rounding, still angular)          |
| Shadows        | Pixel box-shadows (2px/4px solid) | Subtle drop-shadows + accent pixel borders      |
| Transitions    | `step-end` (instant snap)         | `0.15s ease-out` (smooth but snappy)            |
| Color palette  | PICO-8 flat 16 colors             | PICO-8 as accents + enriched shades + gradients |
| User-facing    | Bare MUI defaults (theme.js)      | 64-bit pixel aesthetic, light/dark, WCAG AA     |
| Background     | Flat solid                        | Optional subtle CSS pattern/texture             |

| #   | Feature                          | Complexity | Scope                     |
| --- | -------------------------------- | ---------- | ------------------------- |
| 1   | **Admin theme overhaul**         | MEDIUM     | pixelTheme.js rewrite     |
| 2   | **User-facing theme overhaul**   | MEDIUM     | theme.js rewrite          |
| 3   | **Shared pixel utilities**       | LOW        | New shared module         |
| 4   | **Admin page style audit + fix** | MEDIUM     | 15 admin pages/components |
| 5   | **User page style audit + fix**  | LOW        | 12 user pages             |

### Phase 4B: Content Generation + YAML Import

| #   | Feature                      | Complexity | Type                                 |
| --- | ---------------------------- | ---------- | ------------------------------------ |
| 6   | **Claude API proxy service** | HIGH       | New service + controller + routes    |
| 7   | **API key management**       | LOW        | Extend adminAuthController           |
| 8   | **Content Generation page**  | HIGH       | New admin page with SSE streaming    |
| 9   | **YAML Import endpoint**     | MEDIUM     | Backend wrapper for import-lesson.js |
| 10  | **YAML Import page**         | MEDIUM     | New admin page with upload + preview |

### Architecture pattern (same as Phase 2/3)

```
server/index.js (Composition Root)
  → new ClaudeService(apiKey)
  → new ClaudeController(claudeService)
  → claudeRoutes(claudeController, adminAuth)

  → new YamlImportController(sql)
  → yamlImportRoutes(yamlImportController, adminAuth)

server/app.js → app.register(routes, { prefix: '/api/admin' })
```

---

## SECTION 2: Dependencies

### Phase 4A — Root (client)

**New Google Fonts** (installed via `@fontsource`):

```bash
npm install @fontsource/space-grotesk @fontsource/jetbrains-mono
```

- `@fontsource/space-grotesk` — geometric sans-serif body font (readable, modern-retro feel)
- `@fontsource/jetbrains-mono` — programming monospace for data/code display

Already installed (keep): `@fontsource/silkscreen`, `@fontsource/press-start-2p`, `@fontsource/vt323`

### Phase 4A — Server

No new server dependencies.

### Phase 4B — Server

```bash
cd server && npm install @anthropic-ai/sdk js-yaml
```

- `@anthropic-ai/sdk` — Official Anthropic TypeScript SDK for Claude API
- `js-yaml` — YAML parser (already in root `scripts/`, but needed in server for import endpoint)

### Phase 4B — Root (client)

No new client dependencies. YAML display will use plain `<pre>` or existing markdown renderer.

---

## SECTION 3: Database Migrations

### NO migrations needed

Both phases work with existing schema (v24). Content generation and YAML import use existing tables. Theme changes are CSS-only.

---

## SECTION 4: File Structure

### Phase 4A — New + Modified Files

```
src/theme/
├── pixelTheme.js         ★ REWRITE — 64-bit admin theme
├── theme.js              ★ REWRITE — 64-bit user-facing theme
└── pixelUtils.js         ★ NEW — shared pixel art utilities (borders, patterns)

src/components/admin/
├── AdminLayout.jsx       ★ MODIFY — import new fonts, update transition references
└── AdminStatsCards.jsx   ★ MODIFY — remove step-end transition

src/components/
└── Layout.jsx            ★ MODIFY — import new fonts for user theme

src/pages/admin/
├── AdminLoginPage.jsx    ★ MODIFY — remove hardcoded borderRadius: 0
└── AdminLearningPathFormPage.jsx ★ MODIFY — use theme color token instead of #6366f1

src/pages/
├── HomePage.jsx          ★ MODIFY — replace color: '#fff' with theme token
├── LessonPage.jsx        ★ MODIFY — replace color: '#fff' with theme token
└── PathDetailPage.jsx    ★ MODIFY — replace color: '#fff' with theme token
```

### Phase 4B — New + Modified Files

```
server/
├── services/
│   └── claudeService.js           ★ NEW — Claude API client wrapper
├── controllers/
│   ├── claudeController.js        ★ NEW — generate endpoint handler
│   └── adminAuthController.js     ★ MODIFY — add API key management methods
│   └── yamlImportController.js    ★ NEW — validate + execute import
├── routes/
│   ├── claudeRoutes.js            ★ NEW — /api/admin/generate routes
│   ├── adminRoutes.js             ★ MODIFY — add API key settings routes
│   └── yamlImportRoutes.js        ★ NEW — /api/admin/import routes
├── index.js                       ★ MODIFY — wire ClaudeService + YamlImportController
└── app.js                         ★ MODIFY — register claude + import routes

src/api/
└── admin.js                       ★ MODIFY — add generate + import + api-key API functions

src/pages/admin/
├── AdminContentGenerationPage.jsx ★ NEW — Claude content generation UI
├── AdminYamlImportPage.jsx        ★ NEW — YAML upload + validate + import UI
└── AdminSettingsPage.jsx          ★ MODIFY — add API key configuration section

src/router.jsx                     ★ MODIFY — add generate + import routes
```

---

## SECTION 5: API Contracts

### 5.1 API Key Management (extend existing admin routes)

#### POST /api/admin/settings/api-key — Store Claude API key

```
Authorization: admin JWT cookie
Content-Type: application/json

Request:
{
  "apiKey": "sk-ant-api03-..."
}

Response 200:
{
  "success": true,
  "message": "API key configured"
}

Response 400:
{
  "error": "apiKey is required"
}
```

#### DELETE /api/admin/settings/api-key — Remove Claude API key

```
Authorization: admin JWT cookie

Response 200:
{
  "success": true,
  "message": "API key removed"
}
```

#### GET /api/admin/settings/api-key/status — Check if key is configured

```
Authorization: admin JWT cookie

Response 200:
{
  "configured": true,
  "maskedKey": "sk-ant-...7x3q"
}

Response 200 (not configured):
{
  "configured": false,
  "maskedKey": null
}
```

### 5.2 Content Generation

#### POST /api/admin/generate — Generate content via Claude API

```
Authorization: admin JWT cookie
Content-Type: application/json

Request:
{
  "model": "claude-sonnet-4-6",
  "systemPrompt": "You are an expert educator...",
  "prompt": "Generate 5 multiple_choice exercises about...",
  "thinking": true,
  "webSearch": false,
  "maxTokens": 4096
}

Response: SSE stream (Content-Type: text/event-stream)

event: thinking
data: {"text": "Let me think about how to structure..."}

event: text
data: {"text": "Here are 5 exercises..."}

event: text
data: {"text": "## Exercise 1\n..."}

event: usage
data: {"input_tokens": 150, "output_tokens": 1200, "cache_read_input_tokens": 0}

event: done
data: {"stop_reason": "end_turn"}

event: error (on failure)
data: {"error": "Invalid API key", "type": "authentication_error"}
```

#### Model options (sent by frontend):

| Model ID                    | Display Name | Input $/MTok | Output $/MTok | Thinking           |
| --------------------------- | ------------ | ------------ | ------------- | ------------------ |
| `claude-sonnet-4-6`         | Sonnet 4.6   | $3           | $15           | adaptive or manual |
| `claude-opus-4-6`           | Opus 4.6     | $15          | $75           | adaptive ONLY      |
| `claude-haiku-4-5-20251001` | Haiku 4.5    | $0.80        | $4            | manual only        |

### 5.3 YAML Import

#### POST /api/admin/import/validate — Validate YAML (dry run)

```
Authorization: admin JWT cookie
Content-Type: application/json

Request:
{
  "yaml": "slug: my-lesson\nname: My Lesson\n..."
}

Response 200 (valid):
{
  "valid": true,
  "type": "lesson",
  "summary": {
    "slug": "my-lesson",
    "name": "My Lesson",
    "name_vi": "Bai hoc cua toi",
    "sections": 3,
    "exercises": 5
  },
  "errors": []
}

Response 200 (invalid):
{
  "valid": false,
  "type": "lesson",
  "summary": null,
  "errors": [
    "lesson.slug must be kebab-case",
    "lesson.exercises[0].type must be one of [...]"
  ]
}
```

#### POST /api/admin/import/execute — Import YAML into database

```
Authorization: admin JWT cookie
Content-Type: application/json

Request:
{
  "yaml": "slug: my-lesson\nname: My Lesson\n..."
}

Response 200:
{
  "success": true,
  "type": "lesson",
  "slug": "my-lesson",
  "id": 125,
  "stats": {
    "usages": 2,
    "sections": 3,
    "exercises": 5
  }
}

Response 400:
{
  "error": "Validation failed: lesson.slug is required"
}

Response 404:
{
  "error": "Category not found: \"Unknown Category\""
}
```

---

## SECTION 6: Backend Implementation

### 6.1 Claude Service (`server/services/claudeService.js`)

```js
import Anthropic from '@anthropic-ai/sdk';

export class ClaudeService {
  #apiKey = null;
  #client = null;

  setApiKey(key) {
    this.#apiKey = key;
    this.#client = key ? new Anthropic({ apiKey: key }) : null;
  }

  removeApiKey() {
    this.#apiKey = null;
    this.#client = null;
  }

  isConfigured() {
    return !!this.#apiKey;
  }

  getMaskedKey() {
    if (!this.#apiKey) return null;
    const k = this.#apiKey;
    return k.slice(0, 6) + '...' + k.slice(-4);
  }

  /**
   * Stream a message from Claude API.
   * Returns an async iterable of SSE-style events.
   *
   * @param {Object} params
   * @param {string} params.model — claude-opus-4-6, claude-sonnet-4-6, claude-haiku-4-5-20251001
   * @param {string} params.prompt — user message
   * @param {string} [params.systemPrompt] — system instruction
   * @param {boolean} [params.thinking] — enable extended thinking
   * @param {boolean} [params.webSearch] — enable web search tool
   * @param {number} [params.maxTokens] — max output tokens (default 4096)
   */
  async *streamGenerate({
    model,
    prompt,
    systemPrompt,
    thinking,
    webSearch,
    maxTokens = 4096,
  }) {
    if (!this.#client) throw new Error('API key not configured');

    const messages = [{ role: 'user', content: prompt }];
    const params = { model, messages, max_tokens: maxTokens };

    // System prompt
    if (systemPrompt) {
      params.system = systemPrompt;
    }

    // Extended thinking configuration
    if (thinking) {
      // Opus 4.6: ONLY adaptive (manual deprecated)
      // Sonnet 4.6: adaptive or manual
      // Haiku 4.5: manual only
      if (model === 'claude-haiku-4-5-20251001') {
        params.thinking = {
          type: 'enabled',
          budget_tokens: Math.min(maxTokens * 2, 10000),
        };
      } else {
        // Opus 4.6 and Sonnet 4.6 both support adaptive
        params.thinking = { type: 'adaptive' };
      }
      // When thinking is enabled, max_tokens must include thinking budget
      // The SDK handles this automatically with adaptive
    }

    // Web search tool
    if (webSearch) {
      params.tools = [{ type: 'web_search_20250305', name: 'web_search' }];
    }

    // Stream using SDK's streaming API
    const stream = await this.#client.messages.create({
      ...params,
      stream: true,
    });

    for await (const event of stream) {
      // content_block_start — new block begins
      if (event.type === 'content_block_start') {
        const block = event.content_block;
        if (block.type === 'thinking') {
          yield { event: 'thinking_start', data: {} };
        } else if (block.type === 'text') {
          yield { event: 'text_start', data: {} };
        }
      }

      // content_block_delta — incremental content
      if (event.type === 'content_block_delta') {
        const delta = event.delta;
        if (delta.type === 'thinking_delta') {
          yield { event: 'thinking', data: { text: delta.thinking } };
        } else if (delta.type === 'text_delta') {
          yield { event: 'text', data: { text: delta.text } };
        }
      }

      // message_delta — stop reason + usage
      if (event.type === 'message_delta') {
        yield {
          event: 'done',
          data: { stop_reason: event.delta?.stop_reason },
        };
      }

      // message_start — contains usage info
      if (event.type === 'message_start') {
        const usage = event.message?.usage;
        if (usage) {
          yield { event: 'usage', data: usage };
        }
      }
    }
  }
}
```

**Key design decisions:**

- Private fields (`#apiKey`, `#client`) — API key never leaks via property access
- Async generator (`async *streamGenerate`) — natural fit for SSE streaming
- Model-specific thinking config — Opus only supports adaptive, Haiku only manual
- Web search as tool — `web_search_20250305` type per Anthropic API spec

### 6.2 Claude Controller (`server/controllers/claudeController.js`)

```js
import { ValidationError } from '../errors/AppError.js';

const ALLOWED_MODELS = [
  'claude-opus-4-6',
  'claude-sonnet-4-6',
  'claude-haiku-4-5-20251001',
];

export class ClaudeController {
  constructor(claudeService, adminRepo) {
    this.claudeService = claudeService;
    this.adminRepo = adminRepo;
  }

  generate = async (request, reply) => {
    if (!this.claudeService.isConfigured()) {
      throw new ValidationError(
        'Claude API key not configured. Set it in Settings.',
      );
    }

    const { model, prompt, systemPrompt, thinking, webSearch, maxTokens } =
      request.body;

    if (!ALLOWED_MODELS.includes(model)) {
      throw new ValidationError(
        `Invalid model. Must be one of: ${ALLOWED_MODELS.join(', ')}`,
      );
    }
    if (!prompt?.trim()) {
      throw new ValidationError('prompt is required');
    }

    // Set SSE headers
    reply.raw.writeHead(200, {
      'Content-Type': 'text/event-stream',
      'Cache-Control': 'no-cache',
      Connection: 'keep-alive',
      'X-Accel-Buffering': 'no', // Disable nginx buffering
    });

    try {
      for await (const chunk of this.claudeService.streamGenerate({
        model,
        prompt: prompt.trim(),
        systemPrompt: systemPrompt?.trim() || undefined,
        thinking: !!thinking,
        webSearch: !!webSearch,
        maxTokens: maxTokens || 4096,
      })) {
        reply.raw.write(
          `event: ${chunk.event}\ndata: ${JSON.stringify(chunk.data)}\n\n`,
        );
      }
    } catch (err) {
      // Send error as SSE event
      reply.raw.write(
        `event: error\ndata: ${JSON.stringify({
          error: err.message,
          type: err.error?.type || 'server_error',
        })}\n\n`,
      );
    }

    reply.raw.end();
    reply.hijack();

    // Fire-and-forget audit log
    this.adminRepo.logAction({
      action: 'generate',
      entityType: 'content',
      metadata: { model, thinking: !!thinking, webSearch: !!webSearch },
      ipAddress: request.ip,
    });
  };
}
```

**Key design decisions:**

- SSE via `reply.raw` + `reply.hijack()` — Fastify native approach for streaming
- Error sent as SSE event — frontend receives errors in the same stream
- `X-Accel-Buffering: no` — prevents nginx/reverse proxy from buffering SSE
- Audit logging — fire-and-forget, same pattern as all admin actions

### 6.3 Claude Routes (`server/routes/claudeRoutes.js`)

```js
export function claudeRoutes(controller, adminAuth) {
  return async function (fastify) {
    fastify.addHook('preHandler', adminAuth);

    fastify.post('/generate', {
      schema: {
        body: {
          type: 'object',
          required: ['model', 'prompt'],
          properties: {
            model: { type: 'string' },
            prompt: { type: 'string', minLength: 1 },
            systemPrompt: { type: 'string' },
            thinking: { type: 'boolean' },
            webSearch: { type: 'boolean' },
            maxTokens: { type: 'integer', minimum: 100, maximum: 128000 },
          },
        },
      },
      handler: controller.generate,
    });
  };
}
```

### 6.4 API Key Management (extend `adminAuthController.js`)

Add three new methods to the existing `AdminAuthController`:

```js
// In constructor, add:
// this.claudeService = claudeService;  (injected via Composition Root)

/** POST /api/admin/settings/api-key — Store Claude API key */
setApiKey = async (request) => {
  const { apiKey } = request.body || {};
  if (!apiKey?.trim()) throw new ValidationError('apiKey is required');

  this.claudeService.setApiKey(apiKey.trim());

  this.adminRepo.logAction({
    action: 'update',
    entityType: 'admin',
    metadata: { action: 'api_key_set' },
    ipAddress: request.ip,
  });

  return { success: true, message: 'API key configured' };
};

/** DELETE /api/admin/settings/api-key — Remove Claude API key */
removeApiKey = async (request) => {
  this.claudeService.removeApiKey();

  this.adminRepo.logAction({
    action: 'update',
    entityType: 'admin',
    metadata: { action: 'api_key_removed' },
    ipAddress: request.ip,
  });

  return { success: true, message: 'API key removed' };
};

/** GET /api/admin/settings/api-key/status — Check if key is configured */
getApiKeyStatus = async () => {
  return {
    configured: this.claudeService.isConfigured(),
    maskedKey: this.claudeService.getMaskedKey(),
  };
};
```

### 6.5 API Key Routes (extend `adminRoutes.js`)

Add inside the existing `adminRoutes` function, after the password change route:

```js
// API Key management
if (adminAuthController) {
  fastify.post('/settings/api-key', {
    schema: {
      body: {
        type: 'object',
        required: ['apiKey'],
        properties: {
          apiKey: { type: 'string', minLength: 1 },
        },
      },
    },
    handler: adminAuthController.setApiKey,
  });

  fastify.delete('/settings/api-key', adminAuthController.removeApiKey);

  fastify.get('/settings/api-key/status', adminAuthController.getApiKeyStatus);
}
```

### 6.6 YAML Import Controller (`server/controllers/yamlImportController.js`)

```js
import yaml from 'js-yaml';
import {
  validateLesson,
  validateLearningPath,
} from '../../scripts/lesson-schema.js';
import { ValidationError, NotFoundError } from '../errors/AppError.js';

export class YamlImportController {
  constructor(sql, adminRepo) {
    this.sql = sql;
    this.adminRepo = adminRepo;
  }

  /** POST /api/admin/import/validate — parse + validate YAML (dry run) */
  validate = async (request) => {
    const { yaml: yamlString } = request.body;
    if (!yamlString?.trim())
      throw new ValidationError('yaml content is required');

    const data = this.#parseYaml(yamlString);
    const type = data.type === 'learning_path' ? 'learning_path' : 'lesson';

    const errors =
      type === 'learning_path'
        ? validateLearningPath(data)
        : validateLesson(data);

    if (errors.length > 0) {
      return { valid: false, type, summary: null, errors };
    }

    const summary =
      type === 'learning_path'
        ? {
            slug: data.slug,
            name: data.name,
            name_vi: data.name_vi,
            steps: data.steps?.length || 0,
          }
        : {
            slug: data.slug,
            name: data.name,
            name_vi: data.name_vi,
            category: data.category,
            sections: data.sections?.length || 0,
            exercises: data.exercises?.length || 0,
          };

    return { valid: true, type, summary, errors: [] };
  };

  /** POST /api/admin/import/execute — actually import into DB */
  execute = async (request) => {
    const { yaml: yamlString } = request.body;
    if (!yamlString?.trim())
      throw new ValidationError('yaml content is required');

    const data = this.#parseYaml(yamlString);
    const type = data.type === 'learning_path' ? 'learning_path' : 'lesson';

    // Validate first
    const errors =
      type === 'learning_path'
        ? validateLearningPath(data)
        : validateLesson(data);

    if (errors.length > 0) {
      throw new ValidationError(`Validation failed: ${errors[0]}`);
    }

    // Execute import (reuses same logic as scripts/import-lesson.js)
    const result =
      type === 'learning_path'
        ? await this.#importLearningPath(data)
        : await this.#importLesson(data);

    // Audit log
    this.adminRepo.logAction({
      action: 'create',
      entityType: type,
      entityId: result.id,
      metadata: { slug: result.slug, via: 'yaml_import' },
      ipAddress: request.ip,
    });

    return { success: true, type, ...result };
  };

  #parseYaml(yamlString) {
    try {
      const data = yaml.load(yamlString);
      if (!data || typeof data !== 'object') {
        throw new ValidationError('Invalid YAML: must be an object');
      }
      return data;
    } catch (err) {
      if (err instanceof ValidationError) throw err;
      throw new ValidationError(`YAML parse error: ${err.message}`);
    }
  }

  async #importLesson(data) {
    const sql = this.sql;

    // Lookup category
    const [category] =
      await sql`SELECT id FROM category WHERE name = ${data.category}`;
    if (!category) throw new NotFoundError(`Category "${data.category}"`);

    let lessonId;
    let stats = { usages: 0, sections: 0, exercises: 0 };

    await sql.begin(async (tx) => {
      // Upsert lesson
      const [lesson] = await tx`
        INSERT INTO lesson (slug, group_id, name, name_vi, difficulty, estimated_time, order_index, is_published)
        VALUES (
          ${data.slug}, ${category.id}, ${data.name}, ${data.name_vi},
          ${data.difficulty}, ${data.estimated_time}, ${data.order_index},
          ${data.is_published !== false}
        )
        ON CONFLICT (slug) DO UPDATE SET
          group_id = EXCLUDED.group_id, name = EXCLUDED.name, name_vi = EXCLUDED.name_vi,
          difficulty = EXCLUDED.difficulty, estimated_time = EXCLUDED.estimated_time,
          order_index = EXCLUDED.order_index, is_published = EXCLUDED.is_published
        RETURNING id
      `;
      lessonId = lesson.id;

      // Delete existing related data
      await tx`DELETE FROM lesson_usage WHERE lesson_id = ${lessonId}`;
      await tx`DELETE FROM lesson_section WHERE lesson_id = ${lessonId}`;
      await tx`DELETE FROM exercise WHERE lesson_id = ${lessonId}`;

      // Insert usages
      const usages = data.usages || [];
      for (let i = 0; i < usages.length; i++) {
        const u = usages[i];
        await tx`
          INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index)
          VALUES (${lessonId}, ${u.title}, ${u.title_vi || null}, ${u.description}, ${u.description_vi || null}, ${i})
        `;
      }

      // Insert sections
      const sections = data.sections || [];
      for (let i = 0; i < sections.length; i++) {
        const s = sections[i];
        await tx`
          INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index)
          VALUES (${lessonId}, ${s.type}, ${s.title || null}, ${s.title_vi || null},
            ${s.content || null}, ${s.content_vi || null}, ${JSON.stringify(s.metadata || {})}, ${i})
        `;
      }

      // Insert exercises + options
      const exercises = data.exercises || [];
      for (let i = 0; i < exercises.length; i++) {
        const ex = exercises[i];
        const [inserted] = await tx`
          INSERT INTO exercise (
            lesson_id, type, difficulty, question, question_vi,
            correct_answer, word_bank, explanation, explanation_vi,
            points, time_limit, order_index, is_active
          ) VALUES (
            ${lessonId}, ${ex.type}, ${ex.difficulty}, ${ex.question}, ${ex.question_vi || null},
            ${ex.correct_answer || null}, ${ex.word_bank ? JSON.stringify(ex.word_bank) : null},
            ${ex.explanation || null}, ${ex.explanation_vi || null},
            ${ex.points || 10}, ${ex.time_limit || null}, ${i}, ${ex.is_active !== false}
          ) RETURNING id
        `;

        if (ex.type === 'multiple_choice' && Array.isArray(ex.options)) {
          const labels = ['A', 'B', 'C', 'D', 'E', 'F'];
          for (let j = 0; j < ex.options.length; j++) {
            const opt = ex.options[j];
            await tx`
              INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, explanation, explanation_vi, order_index)
              VALUES (${inserted.id}, ${opt.label || labels[j]}, ${opt.content}, ${opt.content_vi || null},
                ${opt.is_correct === true}, ${opt.explanation || null}, ${opt.explanation_vi || null}, ${j})
            `;
          }
        }
      }

      stats = {
        usages: usages.length,
        sections: sections.length,
        exercises: exercises.length,
      };
    });

    return { slug: data.slug, id: lessonId, stats };
  }

  async #importLearningPath(data) {
    const sql = this.sql;
    let pathId;

    await sql.begin(async (tx) => {
      const [path] = await tx`
        INSERT INTO learning_path (slug, name, name_vi, description, description_vi, icon, color, estimated_days, is_featured, order_index)
        VALUES (
          ${data.slug}, ${data.name}, ${data.name_vi},
          ${data.description || null}, ${data.description_vi || null},
          ${data.icon || null}, ${data.color || '#6366f1'},
          ${data.estimated_days || null}, ${data.is_featured === true}, ${data.order_index || 0}
        )
        ON CONFLICT (slug) DO UPDATE SET
          name = EXCLUDED.name, name_vi = EXCLUDED.name_vi,
          description = EXCLUDED.description, description_vi = EXCLUDED.description_vi,
          icon = EXCLUDED.icon, color = EXCLUDED.color,
          estimated_days = EXCLUDED.estimated_days, is_featured = EXCLUDED.is_featured,
          order_index = EXCLUDED.order_index
        RETURNING id
      `;
      pathId = path.id;

      await tx`DELETE FROM learning_path_step WHERE path_id = ${pathId}`;

      for (let i = 0; i < data.steps.length; i++) {
        const step = data.steps[i];
        const [lesson] =
          await tx`SELECT id FROM lesson WHERE slug = ${step.lesson}`;
        if (!lesson)
          throw new Error(
            `Lesson slug not found: "${step.lesson}" (step ${i})`,
          );
        await tx`
          INSERT INTO learning_path_step (path_id, lesson_id, order_index)
          VALUES (${pathId}, ${lesson.id}, ${i})
        `;
      }
    });

    return { slug: data.slug, id: pathId, stats: { steps: data.steps.length } };
  }
}
```

**Key design decisions:**

- Duplicates import logic from `scripts/import-lesson.js` rather than calling the CLI — avoids subprocess spawning, works in-process with the same `sql` connection
- Uses the same `validateLesson` / `validateLearningPath` from `scripts/lesson-schema.js` (relative import)
- Transaction-wrapped — atomic upsert with rollback on failure
- Two-phase: validate endpoint (dry run) + execute endpoint (actual import)

### 6.7 YAML Import Routes (`server/routes/yamlImportRoutes.js`)

```js
export function yamlImportRoutes(controller, adminAuth) {
  return async function (fastify) {
    fastify.addHook('preHandler', adminAuth);

    const bodySchema = {
      type: 'object',
      required: ['yaml'],
      properties: {
        yaml: { type: 'string', minLength: 1 },
      },
    };

    fastify.post('/import/validate', {
      schema: { body: bodySchema },
      handler: controller.validate,
    });

    fastify.post('/import/execute', {
      schema: { body: bodySchema },
      handler: controller.execute,
    });
  };
}
```

### 6.8 Composition Root Updates (`server/index.js`)

```js
// Add imports:
import { ClaudeService } from './services/claudeService.js';
import { ClaudeController } from './controllers/claudeController.js';
import { YamlImportController } from './controllers/yamlImportController.js';

// After existing wiring:
const claudeService = new ClaudeService();
const claudeController = new ClaudeController(claudeService, adminRepo);
const yamlImportController = new YamlImportController(sql, adminRepo);

// Update AdminAuthController — pass claudeService:
const adminAuthController = new AdminAuthController(
  process.env.ADMIN_PASSWORD,
  adminRepo,
  claudeService, // NEW — for API key management
);

// Pass to createApp:
const app = await createApp({
  // ... existing controllers ...
  claudeController,
  yamlImportController,
});
```

### 6.9 App Route Registration (`server/app.js`)

```js
// Add imports:
import { claudeRoutes } from './routes/claudeRoutes.js';
import { yamlImportRoutes } from './routes/yamlImportRoutes.js';

// Add to createApp params:
// claudeController, yamlImportController

// Add route registration (after existing admin routes):
if (claudeController) {
  app.register(claudeRoutes(claudeController, adminAuth), {
    prefix: '/api/admin',
  });
}
if (yamlImportController) {
  app.register(yamlImportRoutes(yamlImportController, adminAuth), {
    prefix: '/api/admin',
  });
}
```

---

## SECTION 7: Frontend Implementation

### 7.1 Phase 4A — Pixel Utilities (`src/theme/pixelUtils.js`)

Shared constants and helpers used by both admin and user-facing themes:

```js
// PICO-8 palette (unchanged, shared between themes)
export const PICO = {
  black: '#000000',
  darkBlue: '#1D2B53',
  darkPurple: '#7E2553',
  darkGreen: '#008751',
  brown: '#AB5236',
  darkGrey: '#5F574F',
  lightGrey: '#C2C3C7',
  white: '#FFF1E8',
  red: '#FF004D',
  orange: '#FFA300',
  yellow: '#FFEC27',
  green: '#00E436',
  blue: '#29ADFF',
  lavender: '#83769C',
  pink: '#FF77A8',
  peach: '#FFCCAA',
};

// 64-bit evolved borders — subtle, not chunky
export const pixelBorder = (color) => `
  1px 0 0 0 ${color},
  -1px 0 0 0 ${color},
  0 1px 0 0 ${color},
  0 -1px 0 0 ${color}
`;

export const pixelBorderAccent = (color) => `
  2px 0 0 0 ${color},
  -2px 0 0 0 ${color},
  0 2px 0 0 ${color},
  0 -2px 0 0 ${color}
`;

// Subtle CSS scanline pattern (optional background texture)
export const scanlinePattern = `
  repeating-linear-gradient(
    0deg,
    transparent,
    transparent 2px,
    rgba(0,0,0,0.03) 2px,
    rgba(0,0,0,0.03) 4px
  )
`;

// Shared typography stacks
export const FONT_DISPLAY = '"Silkscreen", "VT323", cursive';
export const FONT_BODY = '"Space Grotesk", "Inter", system-ui, sans-serif';
export const FONT_MONO = '"JetBrains Mono", "VT323", "Courier New", monospace';
export const FONT_RETRO = '"Press Start 2P", cursive'; // Only for special decorative use
```

### 7.2 Phase 4A — Admin Theme Rewrite (`src/theme/pixelTheme.js`)

Full rewrite evolving from 8-bit to 64-bit:

**Key changes:**

- `shape.borderRadius: 0` → `shape.borderRadius: 3` (subtle rounding)
- Body font: `VT323` → `Space Grotesk` (readable sans-serif)
- Code/data font: `VT323` → `JetBrains Mono`
- Heading font: Keep `Silkscreen` for h4-h6, `Press Start 2P` ONLY for h1 (sparingly)
- Button shadow: `pixelBorderThick` → `pixelBorderAccent` (thinner, 2px)
- Transitions: `step-end` → `0.15s ease-out` (smooth)
- Add `MuiAlert`, `MuiDialog`, `MuiTable` component overrides

**Typography mapping:**

| Variant     | Current                 | New                            |
| ----------- | ----------------------- | ------------------------------ |
| h1          | Press Start 2P, 1.5rem  | Silkscreen, 1.75rem            |
| h2          | Press Start 2P, 1.25rem | Silkscreen, 1.4rem             |
| h3          | Press Start 2P, 1rem    | Silkscreen, 1.2rem             |
| h4-h6       | Silkscreen (unchanged)  | Silkscreen (unchanged)         |
| subtitle1-2 | Silkscreen              | Space Grotesk, semibold        |
| body1       | VT323, 1.25rem          | Space Grotesk, 1rem            |
| body2       | VT323, 1.1rem           | Space Grotesk, 0.875rem        |
| button      | Silkscreen              | Space Grotesk, 600 weight      |
| caption     | VT323                   | JetBrains Mono, 0.75rem        |
| overline    | Silkscreen, 0.7rem      | Silkscreen, 0.7rem (unchanged) |

**Component overrides summary:**

| Component         | Current                          | New                                         |
| ----------------- | -------------------------------- | ------------------------------------------- |
| MuiButton         | borderRadius:0, pixelBorderThick | borderRadius:3, pixelBorderAccent, ease-out |
| MuiCard           | borderRadius:0, pixelBorderThick | borderRadius:4, subtle shadow + 1px border  |
| MuiPaper          | borderRadius:0                   | borderRadius:4                              |
| MuiTextField      | borderRadius:0, borderWidth:2    | borderRadius:3, borderWidth:1.5             |
| MuiChip           | borderRadius:0, VT323            | borderRadius:3, Space Grotesk               |
| MuiLinearProgress | borderRadius:0, pixelBorder      | borderRadius:4, no pixel border             |
| MuiDrawer         | borderRadius:0                   | borderRadius:0 (sidebar stays angular)      |
| MuiListItemButton | borderRadius:0, 4px border-left  | borderRadius:3, 3px border-left             |
| MuiAlert          | (default)                        | borderRadius:4, pixelBorderAccent           |
| MuiDialog         | (default)                        | borderRadius:6                              |
| MuiTableHead      | (default)                        | Silkscreen font, subtle bg                  |

### 7.3 Phase 4A — User-Facing Theme Rewrite (`src/theme/theme.js`)

Currently bare (just primary/secondary colors). Needs full 64-bit pixel aesthetic:

```js
import { createTheme } from '@mui/material/styles';
import {
  PICO,
  pixelBorder,
  FONT_DISPLAY,
  FONT_BODY,
  FONT_MONO,
} from './pixelUtils.js';

const theme = createTheme({
  cssVariables: { colorSchemeSelector: 'data-color-scheme' },
  colorSchemes: {
    light: {
      palette: {
        primary: { main: '#4f46e5' },
        secondary: { main: '#c2185b' },
        success: { main: '#15803d' },
        warning: { main: '#b45309' },
        error: { main: '#be123c' },
        background: { default: '#f8f7f4', paper: '#ffffff' },
      },
    },
    dark: {
      palette: {
        primary: { main: '#818cf8' },
        secondary: { main: '#f472b6' },
        success: { main: PICO.green },
        warning: { main: PICO.orange },
        error: { main: PICO.red },
        background: { default: '#0f0f23', paper: '#1a1a2e' },
      },
    },
  },
  shape: { borderRadius: 6 },
  typography: {
    fontFamily: FONT_BODY,
    h1: { fontFamily: FONT_DISPLAY, fontSize: '1.75rem', lineHeight: 1.4 },
    h2: { fontFamily: FONT_DISPLAY, fontSize: '1.4rem', lineHeight: 1.4 },
    h3: { fontFamily: FONT_DISPLAY, fontSize: '1.2rem', lineHeight: 1.4 },
    h4: { fontFamily: FONT_BODY, fontSize: '1.25rem', fontWeight: 700 },
    h5: { fontFamily: FONT_BODY, fontSize: '1.1rem', fontWeight: 700 },
    h6: { fontFamily: FONT_BODY, fontSize: '1rem', fontWeight: 700 },
    subtitle1: { fontFamily: FONT_BODY, fontWeight: 600 },
    subtitle2: { fontFamily: FONT_BODY, fontWeight: 600, fontSize: '0.875rem' },
    body1: { fontFamily: FONT_BODY, fontSize: '1rem', lineHeight: 1.6 },
    body2: { fontFamily: FONT_BODY, fontSize: '0.875rem', lineHeight: 1.5 },
    button: { fontFamily: FONT_BODY, fontWeight: 600, textTransform: 'none' },
    caption: { fontFamily: FONT_MONO, fontSize: '0.75rem' },
  },
  components: {
    MuiCard: {
      styleOverrides: {
        root: {
          backgroundImage: 'none',
          border: '1px solid',
          borderColor: 'var(--mui-palette-divider)',
        },
      },
    },
    MuiButton: {
      styleOverrides: {
        root: {
          textTransform: 'none',
          fontWeight: 600,
        },
      },
    },
    MuiChip: {
      styleOverrides: {
        root: { fontWeight: 600 },
      },
    },
    MuiLinearProgress: {
      styleOverrides: {
        root: { borderRadius: 4, height: 6 },
      },
    },
  },
});
```

**Design philosophy for user-facing:**

- Lighter pixel influence — `Silkscreen` only for h1-h3, body stays readable
- WCAG AA contrast ratios maintained (4.5:1 minimum)
- Cards get subtle 1px borders instead of heavy pixel shadows
- Dark mode uses deep navy (`#0f0f23`) instead of PICO darkBlue — more modern
- User theme is more accessible, admin theme is more stylized

### 7.4 Phase 4A — Admin Page Style Audit

Files with hardcoded styles that need fixing:

| File                            | Line(s)      | Issue                                 | Fix                                                                       |
| ------------------------------- | ------------ | ------------------------------------- | ------------------------------------------------------------------------- |
| `AdminLoginPage.jsx`            | 79           | `borderRadius: 0` hardcoded on Alert  | Remove — theme handles it                                                 |
| `AdminStatsCards.jsx`           | 48           | `step-end` transition                 | Change to `0.15s ease-out`                                                |
| `AdminLayout.jsx`               | 356          | `step-end` transition on drawer width | Change to `0.2s ease-out`                                                 |
| `AdminLearningPathFormPage.jsx` | 74, 165, 216 | `#6366f1` hardcoded color             | Use `theme.palette.primary.main` or keep as default path color (DB value) |

**Note on `AdminLearningPathFormPage.jsx`**: The `#6366f1` is a default color for new learning paths — this is an appropriate default DB value, not a theme color. Keep it but define it as a named constant at top of file.

### 7.5 Phase 4A — User-Facing Page Style Audit

| File                 | Line(s)  | Issue                                | Fix                                            |
| -------------------- | -------- | ------------------------------------ | ---------------------------------------------- |
| `HomePage.jsx`       | 573      | `color: '#fff'` on Chip              | Use `'common.white'` or compute contrast color |
| `LessonPage.jsx`     | 228      | `color: '#fff'` on Chip              | Use `'common.white'`                           |
| `PathDetailPage.jsx` | 128, 189 | `color: '#fff'` on Paper/step circle | Use `'common.white'`                           |

**Note**: These `#fff` usages are for white text on dynamically-colored backgrounds (category/path colors from DB). `'common.white'` is the semantic MUI equivalent and is acceptable. The key concern is that these are not hardcoded theme colors but contrast colors for dynamic backgrounds.

### 7.6 Phase 4A — Font Imports

**AdminLayout.jsx** — update imports:

```js
// REMOVE: import '@fontsource/press-start-2p/400.css'; (optional — keep for h1 decorative use)
// KEEP:
import '@fontsource/silkscreen/400.css';
import '@fontsource/vt323/400.css';
// ADD:
import '@fontsource/space-grotesk/400.css';
import '@fontsource/space-grotesk/600.css';
import '@fontsource/jetbrains-mono/400.css';
```

**Layout.jsx** — add imports:

```js
import '@fontsource/silkscreen/400.css';
import '@fontsource/space-grotesk/400.css';
import '@fontsource/space-grotesk/600.css';
import '@fontsource/space-grotesk/700.css';
import '@fontsource/jetbrains-mono/400.css';
```

### 7.7 Phase 4B — API Functions (`src/api/admin.js`)

Add to the existing admin.js:

```js
// ─── API KEY MANAGEMENT ─────────────────────────────────────

export function setAdminApiKey(apiKey) {
  return adminRequest('/settings/api-key', {
    method: 'POST',
    body: JSON.stringify({ apiKey }),
  });
}

export function removeAdminApiKey() {
  return adminRequest('/settings/api-key', { method: 'DELETE' });
}

export function fetchApiKeyStatus() {
  return adminRequest('/settings/api-key/status');
}

// ─── CONTENT GENERATION ─────────────────────────────────────

/**
 * Stream content generation via SSE.
 * Returns an EventSource-like interface using fetch + ReadableStream.
 *
 * @param {Object} params
 * @param {Function} onThinking — called with { text }
 * @param {Function} onText — called with { text }
 * @param {Function} onUsage — called with { input_tokens, output_tokens }
 * @param {Function} onDone — called with { stop_reason }
 * @param {Function} onError — called with { error, type }
 * @returns {AbortController} — call .abort() to cancel
 */
export function streamGenerate(
  params,
  { onThinking, onText, onUsage, onDone, onError },
) {
  const controller = new AbortController();

  fetch(`${API_BASE}/generate`, {
    method: 'POST',
    credentials: 'include',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(params),
    signal: controller.signal,
  })
    .then(async (response) => {
      if (!response.ok) {
        const body = await response.json().catch(() => ({}));
        onError?.({
          error: body.error || `HTTP ${response.status}`,
          type: 'http_error',
        });
        return;
      }

      const reader = response.body.getReader();
      const decoder = new TextDecoder();
      let buffer = '';

      while (true) {
        const { done, value } = await reader.read();
        if (done) break;

        buffer += decoder.decode(value, { stream: true });
        const lines = buffer.split('\n');
        buffer = lines.pop(); // Keep incomplete last line

        let currentEvent = null;
        for (const line of lines) {
          if (line.startsWith('event: ')) {
            currentEvent = line.slice(7);
          } else if (line.startsWith('data: ') && currentEvent) {
            const data = JSON.parse(line.slice(6));
            if (currentEvent === 'thinking') onThinking?.(data);
            else if (currentEvent === 'text') onText?.(data);
            else if (currentEvent === 'usage') onUsage?.(data);
            else if (currentEvent === 'done') onDone?.(data);
            else if (currentEvent === 'error') onError?.(data);
            currentEvent = null;
          } else if (line === '') {
            currentEvent = null;
          }
        }
      }
    })
    .catch((err) => {
      if (err.name !== 'AbortError') {
        onError?.({ error: err.message, type: 'network_error' });
      }
    });

  return controller;
}

// ─── YAML IMPORT ────────────────────────────────────────────

export function validateYamlImport(yamlContent) {
  return adminRequest('/import/validate', {
    method: 'POST',
    body: JSON.stringify({ yaml: yamlContent }),
  });
}

export function executeYamlImport(yamlContent) {
  return adminRequest('/import/execute', {
    method: 'POST',
    body: JSON.stringify({ yaml: yamlContent }),
  });
}
```

**Key design decision for `streamGenerate`:**

- Uses `fetch` + `ReadableStream` instead of `EventSource` — `EventSource` only supports GET, and we need POST with a body
- Returns `AbortController` — frontend can cancel generation mid-stream
- Callback-based API — simpler than converting SSE to async iterables in React

### 7.8 Phase 4B — Content Generation Page (`src/pages/admin/AdminContentGenerationPage.jsx`)

**Component structure:**

```
AdminContentGenerationPage
├── ModelSelector (dropdown: Sonnet 4.6, Opus 4.6, Haiku 4.5)
├── OptionsPanel
│   ├── ThinkingToggle (Switch + info tooltip)
│   ├── WebSearchToggle (Switch + pricing note)
│   └── MaxTokensSlider (100-128000, default 4096)
├── PromptSection
│   ├── SystemPromptField (textarea, collapsible, with templates)
│   └── UserPromptField (textarea)
├── CostEstimate (calculated from model + tokens)
├── GenerateButton (loading state, cancel support)
└── ResponseArea
    ├── ThinkingBlock (collapsible, gray bg)
    ├── TextOutput (markdown-rendered)
    └── UsageDisplay (tokens used)
```

**Model pricing display:**

```
┌──────────────────────────────────────────┐
│ Model: [Sonnet 4.6 ▼]                   │
│                                          │
│ ☐ Extended Thinking                      │
│   Enables deeper reasoning               │
│                                          │
│ ☐ Web Search ($10/1000 queries)          │
│   Allows model to search the web         │
│                                          │
│ Max Tokens: [────●────] 4096             │
│                                          │
│ ≈ Est. cost: ~$0.07 (150 in + 4096 out) │
└──────────────────────────────────────────┘
```

**System prompt templates** (predefined, selectable):

| Template Name       | System Prompt Content                                             |
| ------------------- | ----------------------------------------------------------------- |
| Lesson Generator    | "Generate a complete YAML lesson file for the Learning Hub..."    |
| Exercise Generator  | "Generate exercises in YAML format. Types: multiple_choice..."    |
| Content Reviewer    | "Review the following lesson content for accuracy and clarity..." |
| Translation (EN→VI) | "Translate the following educational content to Vietnamese..."    |
| Custom              | (empty, user writes their own)                                    |

Each template includes the YAML schema format expectations so Claude generates valid output.

**State management** — `useReducer` FSM:

```
States: idle → generating → done | error
Actions: START_GENERATE, RECEIVE_THINKING, RECEIVE_TEXT, RECEIVE_USAGE, COMPLETE, ERROR, RESET
```

### 7.9 Phase 4B — YAML Import Page (`src/pages/admin/AdminYamlImportPage.jsx`)

**Component structure:**

```
AdminYamlImportPage
├── UploadArea (drag-and-drop + file input)
├── YamlViewer (read-only <pre> with syntax highlighting)
├── ValidationPanel
│   ├── ValidationStatus (valid/invalid indicator)
│   ├── ErrorList (if validation fails)
│   └── ContentSummary (slug, name, sections count, exercises count)
├── ActionButtons
│   ├── ValidateButton (disabled if no YAML)
│   └── ImportButton (disabled until validation passes)
└── ResultFeedback (success/error after import)
```

**UX flow:**

1. User uploads `.yaml`/`.yml` file (drag-and-drop or file picker)
2. File content displayed in read-only viewer
3. Click "Validate" — calls `/api/admin/import/validate`
4. Validation results displayed (errors or summary preview)
5. If valid, "Import" button becomes enabled
6. Click "Import" — calls `/api/admin/import/execute`
7. Success: show result (lesson ID, slug, counts)
8. Error: show error message

**Alternative flow:** User can also paste YAML directly (textarea mode toggle).

### 7.10 Phase 4B — Settings Page Extension (`src/pages/admin/AdminSettingsPage.jsx`)

Add new "Claude API Key" section below the existing "Change Password" section:

```
┌──────────────────────────────────────────┐
│ Claude API Key                           │
│                                          │
│ Status: ● Configured (sk-ant-...7x3q)   │
│                                          │
│ [New API Key: ________________________]  │
│                                          │
│ [Save Key]  [Remove Key]                 │
│                                          │
│ ⓘ Key is stored in server memory only.  │
│   Resets when server restarts.           │
│   Set ANTHROPIC_API_KEY env var for      │
│   persistence.                           │
└──────────────────────────────────────────┘
```

### 7.11 Phase 4B — Router Updates (`src/router.jsx`)

Add two new routes inside the admin children array:

```js
{
  path: 'generate',
  lazy: async () => {
    const { default: Component } =
      await import('./pages/admin/AdminContentGenerationPage.jsx');
    return { Component };
  },
  ErrorBoundary: ErrorPage,
},
{
  path: 'import',
  lazy: async () => {
    const { default: Component } =
      await import('./pages/admin/AdminYamlImportPage.jsx');
    return { Component };
  },
  ErrorBoundary: ErrorPage,
},
```

**Note**: Both routes already have sidebar nav links in `AdminLayout.jsx` NAV_GROUPS (Content Generation + YAML Import under "CONTENT TOOLS" group). No changes to AdminLayout needed for navigation.

---

## SECTION 8: UX Design Decisions

### 8.1 Why 64-bit, Not 32-bit or Full Modern?

The 8-bit aesthetic (PICO-8, Press Start 2P everywhere) creates readability issues:

- `Press Start 2P` at body size is painful to read in data tables and forms
- `VT323` monospace makes everything look like a terminal — not great for learning content
- `borderRadius: 0` and `step-end` transitions feel harsh, not "charming retro"

64-bit (PS1/N64 era) keeps the retro identity while being usable:

- Still pixel-influenced (Silkscreen for headings, pixel borders as accents)
- Readable body text (Space Grotesk — geometric, slightly retro-futuristic)
- Smooth-but-snappy transitions (0.15s, not sluggish)
- Subtle rounding (3-4px) keeps angular feel without sharp corners

Going full modern would lose the project's visual identity entirely.

### 8.2 Two Themes, Shared Utilities

Admin theme (`pixelTheme.js`) is more stylized — the admin sees pixel art as a feature. User-facing theme (`theme.js`) is lighter — learners need maximum readability.

Both import from `pixelUtils.js` for shared PICO colors, border helpers, and font constants.

### 8.3 SSE Streaming for Content Generation

Why SSE instead of WebSocket or polling:

- **SSE fits the use case** — server pushes, client receives (one-directional)
- **No new dependencies** — fetch + ReadableStream API
- **Cancellable** — AbortController on the fetch request
- **Fastify-friendly** — `reply.raw.write()` + `reply.hijack()`

### 8.4 YAML Import: Two-Phase (Validate + Execute)

Why not single-step import:

- Users can preview what will be created before committing
- Validation errors are shown without side effects
- Prevents accidental imports of malformed content
- Same pattern as the CLI `--dry-run` flag, but in the UI

### 8.5 API Key as Runtime-Only

Same pattern as `ADMIN_PASSWORD`:

- Stored in ClaudeService private field (in-memory)
- Resets on server restart
- For persistence, set `ANTHROPIC_API_KEY` env var
- Never stored in database, never sent to frontend

### 8.6 System Prompt Templates

Pre-built templates reduce errors:

- Templates include YAML schema expectations → Claude outputs valid YAML
- Templates match the `lesson-schema.js` validation rules
- Users can still write custom prompts for flexibility
- Templates are frontend-only constants (no backend storage needed)

---

## SECTION 9: Security Considerations

### 9.1 Claude API Key Security

| Concern                  | Mitigation                                                                            |
| ------------------------ | ------------------------------------------------------------------------------------- |
| Key exposure to frontend | Key NEVER sent to client. Only `maskedKey` returned from status endpoint              |
| Key in logs              | Never logged. `logAction` only logs `api_key_set` / `api_key_removed` without the key |
| Key in database          | NOT stored in DB. Runtime-only in ClaudeService private field                         |
| Key in error messages    | Anthropic SDK errors are caught; only `err.message` forwarded                         |
| CORS                     | All admin endpoints already behind admin JWT auth + CORS policy                       |

### 9.2 Content Generation Abuse

| Concern                  | Mitigation                                             |
| ------------------------ | ------------------------------------------------------ |
| Unauthorized access      | Behind `adminAuth` middleware (JWT cookie)             |
| Cost runaway             | `maxTokens` capped at 128000 in JSON Schema validation |
| Prompt injection via API | Admin-only feature; admin is trusted                   |
| Rate limiting            | Fastify rate-limit plugin already active (100 req/min) |

### 9.3 YAML Import Safety

| Concern                    | Mitigation                                                    |
| -------------------------- | ------------------------------------------------------------- |
| SQL injection              | All queries use postgres.js tagged templates                  |
| YAML bomb (billion laughs) | `js-yaml`'s `load()` (not `loadAll`) with default safe schema |
| Large payload              | Fastify body size limit applies (default 1MB)                 |
| File system access         | No file system writes; YAML is processed in-memory            |
| Transaction atomicity      | All imports wrapped in `sql.begin()` — rollback on error      |

### 9.4 Theme Security

No security concerns — themes are CSS-only client-side changes. No API calls, no data exposure.

---

## SECTION 10: CI Compatibility

### Phase 4A — Theme Changes

- **Lint**: No new lint issues. Font imports are standard.
- **Build**: Vite tree-shakes unused font weights. New `@fontsource` packages add ~20-30KB gz total.
- **Tests**: Theme changes don't affect test logic. Vitest mocks ThemeProvider.
- **E2E**: Playwright tests use functional selectors (text, role), not style-based. Theme changes won't break E2E.

### Phase 4B — Backend Changes

- **Lint**: New server files follow existing patterns. No new lint rules needed.
- **Build**: `@anthropic-ai/sdk` is server-only (not bundled by Vite).
- **Unit tests**: ClaudeService can be tested with mocked Anthropic client. YamlImportController tested with mocked sql.
- **Integration tests**: Need `ANTHROPIC_API_KEY` env var to test real Claude calls — skip in CI with `process.env.ANTHROPIC_API_KEY || skip`.
- **E2E**: Admin generation/import pages are behind auth — not covered by current E2E smoke tests.

### CI Impact Summary

| Check                     | Phase 4A                    | Phase 4B                     |
| ------------------------- | --------------------------- | ---------------------------- |
| `npm run lint`            | Pass (no new patterns)      | Pass (follows conventions)   |
| `npm run build`           | Pass (new fonts bundled)    | Pass (server-only deps)      |
| `npx vitest run` (client) | Pass (theme mocked)         | Pass (new pages lazy-loaded) |
| `npx vitest run` (server) | N/A                         | Pass (mock Claude SDK)       |
| Playwright E2E            | Pass (functional selectors) | N/A (auth-gated)             |

---

## SECTION 11: Appendix

### A. Implementation Order

**Phase 4A** (UI overhaul, implement FIRST):

1. Create `src/theme/pixelUtils.js` — shared utilities
2. Rewrite `src/theme/pixelTheme.js` — admin 64-bit theme
3. Rewrite `src/theme/theme.js` — user-facing 64-bit theme
4. Update font imports in `AdminLayout.jsx` and `Layout.jsx`
5. Fix hardcoded styles in admin pages (LoginPage, StatsCards, Layout)
6. Fix hardcoded styles in user pages (HomePage, LessonPage, PathDetailPage)
7. Visual QA — verify both themes in light + dark mode
8. Install new font dependencies (`@fontsource/space-grotesk`, `@fontsource/jetbrains-mono`)

**Phase 4B** (Content Gen + YAML Import, implement SECOND):

1. Install server dependency (`@anthropic-ai/sdk`, `js-yaml` in server/)
2. Create `server/services/claudeService.js`
3. Create `server/controllers/claudeController.js`
4. Create `server/routes/claudeRoutes.js`
5. Extend `adminAuthController.js` with API key methods
6. Extend `adminRoutes.js` with API key routes
7. Create `server/controllers/yamlImportController.js`
8. Create `server/routes/yamlImportRoutes.js`
9. Update `server/index.js` (Composition Root) and `server/app.js`
10. Add API functions to `src/api/admin.js`
11. Create `AdminContentGenerationPage.jsx`
12. Create `AdminYamlImportPage.jsx`
13. Extend `AdminSettingsPage.jsx` with API key section
14. Add routes in `src/router.jsx`

### B. Bundle Size Impact Estimate

| Addition                                  | Size (gz) | Notes                           |
| ----------------------------------------- | --------- | ------------------------------- |
| `@fontsource/space-grotesk` (400+600+700) | ~25KB     | Regular + semibold + bold       |
| `@fontsource/jetbrains-mono` (400)        | ~12KB     | Regular only                    |
| AdminContentGenerationPage (lazy)         | ~5KB      | Lazy-loaded admin page          |
| AdminYamlImportPage (lazy)                | ~3KB      | Lazy-loaded admin page          |
| `@anthropic-ai/sdk` (server)              | N/A       | Server-only, not in Vite bundle |
| `js-yaml` (server)                        | N/A       | Server-only, not in Vite bundle |

Total client impact: ~45KB gz (fonts + 2 lazy pages).

### C. Anthropic SDK Quick Reference

```js
import Anthropic from '@anthropic-ai/sdk';

// Basic usage
const client = new Anthropic({ apiKey: 'sk-ant-...' });

// Non-streaming
const message = await client.messages.create({
  model: 'claude-sonnet-4-6',
  max_tokens: 1024,
  messages: [{ role: 'user', content: 'Hello' }],
});
// message.content[0].text

// Streaming (async iterable)
const stream = await client.messages.create({
  model: 'claude-sonnet-4-6',
  max_tokens: 1024,
  messages: [{ role: 'user', content: 'Hello' }],
  stream: true,
});
for await (const event of stream) {
  // event.type: message_start, content_block_start, content_block_delta,
  //             content_block_stop, message_delta, message_stop
}

// Extended thinking (adaptive — Opus 4.6 + Sonnet 4.6)
const message = await client.messages.create({
  model: 'claude-opus-4-6',
  max_tokens: 16000,
  thinking: { type: 'adaptive' },
  messages: [{ role: 'user', content: 'Solve this...' }],
});
// message.content includes { type: 'thinking', thinking: '...' } blocks

// Extended thinking (manual — Haiku 4.5, Sonnet 4.6)
const message = await client.messages.create({
  model: 'claude-haiku-4-5-20251001',
  max_tokens: 16000,
  thinking: { type: 'enabled', budget_tokens: 10000 },
  messages: [{ role: 'user', content: 'Solve this...' }],
});

// Web search
const message = await client.messages.create({
  model: 'claude-sonnet-4-6',
  max_tokens: 1024,
  tools: [{ type: 'web_search_20250305', name: 'web_search' }],
  messages: [{ role: 'user', content: 'What happened today?' }],
});

// Error handling
try {
  await client.messages.create(/* ... */);
} catch (err) {
  if (err instanceof Anthropic.APIError) {
    console.log(err.status); // 401, 429, etc.
    console.log(err.message); // Human-readable error
    console.log(err.error); // { type, message } from API
  }
}
```

### D. SSE Event Format Reference

```
event: thinking
data: {"text": "Let me analyze..."}

event: text
data: {"text": "Here is the result..."}

event: usage
data: {"input_tokens": 150, "output_tokens": 1200}

event: done
data: {"stop_reason": "end_turn"}

event: error
data: {"error": "Rate limit exceeded", "type": "rate_limit_error"}
```

### E. System Prompt Template Examples

**Lesson Generator Template:**

```
You are an expert educator creating content for the Learning Hub platform.
Generate a complete lesson in YAML format following this exact schema:

slug: kebab-case-slug
category: "Exact Category Name"
name: "English Lesson Name"
name_vi: "Vietnamese Lesson Name"
difficulty: beginner|intermediate|advanced
estimated_time: 15  # minutes
order_index: 0

sections:
  - type: markdown|key_points|info_box
    title: "Section Title"
    title_vi: "Vietnamese Title"
    content: |
      Markdown content here...
    content_vi: |
      Vietnamese content...

exercises:
  - type: multiple_choice|fill_blank|error_correction|sentence_transform|arrange_words|matching|true_false|code_output
    difficulty: easy|medium|hard
    question: "Question text"
    question_vi: "Vietnamese question"
    correct_answer: "answer"  # NOT for multiple_choice
    explanation: "Why this is correct"
    options:  # ONLY for multiple_choice
      - content: "Option A"
        is_correct: false
      - content: "Option B"
        is_correct: true

Generate high-quality, educational content that is accurate and engaging.
Include Vietnamese translations for all text fields.
```

**Exercise Generator Template:**

```
You are an expert educator. Generate exercises in YAML array format.
Each exercise must follow this schema:

- type: multiple_choice
  difficulty: easy|medium|hard
  question: "Clear, educational question"
  question_vi: "Vietnamese translation"
  explanation: "Detailed explanation of why the answer is correct"
  explanation_vi: "Vietnamese explanation"
  options:
    - content: "Option text"
      is_correct: false
    - content: "Correct option"
      is_correct: true

For non-multiple_choice types (fill_blank, error_correction, etc.):
- type: fill_blank
  difficulty: medium
  question: "The cat ___ on the mat."
  correct_answer: "sat"
  explanation: "Past simple tense..."

Generate exactly the number of exercises requested.
Vary difficulty levels. Ensure questions test understanding, not just memorization.
```

### F. Cost Estimation Formula (for frontend display)

```js
const PRICING = {
  'claude-sonnet-4-6': { input: 3, output: 15 }, // $ per MTok
  'claude-opus-4-6': { input: 15, output: 75 },
  'claude-haiku-4-5-20251001': { input: 0.8, output: 4 },
};

function estimateCost(model, estimatedInputTokens, maxOutputTokens) {
  const p = PRICING[model];
  const inputCost = (estimatedInputTokens / 1_000_000) * p.input;
  const outputCost = (maxOutputTokens / 1_000_000) * p.output;
  return inputCost + outputCost;
}

// Example: Sonnet 4.6, ~500 input tokens, 4096 max output
// = (500/1M) * 3 + (4096/1M) * 15 = $0.0015 + $0.0614 ≈ $0.06
```

Web search adds $10/1000 searches (flat rate per search invocation, not per token).
