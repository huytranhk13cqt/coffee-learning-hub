# Learning Hub

A general-purpose interactive learning platform that can teach **any subject** — from English grammar to Python programming, cybersecurity, mathematics, and psychology. Built with a modern React + Fastify stack, bilingual content (English/Vietnamese), and a 7-type exercise system with real-time feedback.

> **Not a grammar app.** English tenses are just the first content module. The platform is designed to host unlimited subjects through a data-driven, schema-extensible architecture.

---

## Table of Contents

- [Objectives](#objectives)
- [Key Achievements](#key-achievements)
- [Tech Stack](#tech-stack)
- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Architecture](#architecture)
- [Database Design](#database-design)
- [API Reference](#api-reference)
- [Exercise System](#exercise-system)
- [Design Patterns](#design-patterns)
- [Techniques & Algorithms](#techniques--algorithms)
- [Libraries & Justification](#libraries--justification)
- [Testing](#testing)
- [Developer Experience](#developer-experience)
- [Security](#security)
- [Performance](#performance)
- [CI/CD](#cicd)
- [Makefile Commands](#makefile-commands)
- [Environment Variables](#environment-variables)
- [License](#license)

---

## Objectives

1. **Teach any subject** — content-agnostic schema supports unlimited categories and lessons
2. **Interactive exercises** — 7 exercise types with instant validation, scoring, and progress tracking
3. **Bilingual** — all content in English and Vietnamese (extensible to more languages)
4. **Zero friction** — no signup, no login. Session-based progress via localStorage UUID
5. **Production-grade** — security hardening, rate limiting, input validation, CI/CD pipeline, 116 automated tests

---

## Key Achievements

| Metric        | Value                                                                                       |
| ------------- | ------------------------------------------------------------------------------------------- |
| Categories    | 8 (Grammar: Present/Past/Future, Learning Methods, Python, Math, Cybersecurity, Psychology) |
| Lessons       | 31 (each with theory, usages, examples, tips, exercises)                                    |
| Exercises     | 217 (7 types per lesson, all with bilingual content)                                        |
| Test Coverage | 116 tests (10 client + 41 server unit + 59 integration + 6 E2E)                             |
| Build Size    | ~335 KB gzipped (code-split: vendor-react 119KB, vendor-mui 141KB, vendor-router 29KB)      |
| Schema        | 15 tables, 12 ENUMs, 3 views, 3 functions, 8 triggers                                       |
| API Endpoints | 13 (8 GET, 4 POST, 1 health check)                                                          |
| Security      | Helmet, rate limiting, JSON schema validation, ILIKE escape, DOMPurify                      |

---

## Tech Stack

### Frontend

| Technology            | Version | Purpose                                           |
| --------------------- | ------- | ------------------------------------------------- |
| **React**             | 19      | UI framework                                      |
| **React Router**      | 7       | Client-side routing with data loaders             |
| **MUI (Material UI)** | 7       | Component library (deep imports for tree-shaking) |
| **Vite**              | 7       | Build tool and dev server                         |
| **marked**            | 17      | Markdown rendering for lesson content             |
| **highlight.js**      | 11      | Code syntax highlighting (Python, JavaScript)     |
| **DOMPurify**         | 3       | XSS sanitization for rendered markdown            |

### Backend

| Technology              | Version | Purpose                                 |
| ----------------------- | ------- | --------------------------------------- |
| **Fastify**             | 5       | HTTP server framework                   |
| **postgres.js**         | 3       | PostgreSQL client (tagged template SQL) |
| **@fastify/helmet**     | 13      | Security headers                        |
| **@fastify/rate-limit** | 10      | IP-based rate limiting (100 req/min)    |
| **@fastify/cors**       | 11      | Cross-origin resource sharing           |

### Infrastructure

| Technology         | Version | Purpose                       |
| ------------------ | ------- | ----------------------------- |
| **PostgreSQL**     | 17      | Primary database (Docker)     |
| **Docker Compose** | —       | Container orchestration       |
| **GitHub Actions** | —       | CI pipeline (3 parallel jobs) |
| **Node.js**        | ≥ 20    | Runtime                       |

### Developer Tooling

| Tool            | Purpose                                       |
| --------------- | --------------------------------------------- |
| **Vitest**      | Unit and integration testing                  |
| **Playwright**  | End-to-end smoke tests                        |
| **ESLint 9**    | Linting (flat config, separate client/server) |
| **Prettier 3**  | Code formatting                               |
| **Husky**       | Git hooks (pre-commit)                        |
| **lint-staged** | Run lint/format on staged files only          |
| **commitlint**  | Enforce conventional commits                  |

---

## Quick Start

### Prerequisites

- Node.js ≥ 20
- Docker (for PostgreSQL)

### 1. Clone and configure

```bash
git clone <repo-url>
cd project-relax
cp .env.example .env
```

### 2. Start database

```bash
docker compose up -d
```

> First run auto-loads schema + all seed data (31 lessons). Subsequent runs reuse the volume.

### 3. Install and run

```bash
# Install all dependencies
make install

# Start both client and server
make dev
```

Or manually in two terminals:

```bash
# Terminal 1 — Client (http://localhost:5173)
npm ci && npm run dev

# Terminal 2 — Server (http://localhost:3001)
cd server && npm ci && npm run dev
```

### 4. Open the app

Visit **http://localhost:5173**

---

## Project Structure

```
project-relax/
├── database/                    # Database layer
│   ├── schema.sql               #   DDL: 15 tables, 12 ENUMs, 3 views (817 lines)
│   ├── migrations/              #   Incremental migrations (v1–v7)
│   ├── seed_data.sql            #   Grammar + Learning Methods (12+3 lessons)
│   ├── seed_python.sql          #   Python Basics (4 lessons)
│   ├── seed_math.sql            #   Math Foundations (4 lessons)
│   ├── seed_cybersecurity.sql   #   Cybersecurity Basics (4 lessons)
│   └── seed_psychology.sql      #   Psychology 101 (4 lessons)
│
├── server/                      # Backend (Fastify 5)
│   ├── index.js                 #   ★ Entrypoint — Composition Root (DI wiring)
│   ├── app.js                   #   Fastify app factory (plugins, routes, error handler)
│   ├── config/database.js       #   postgres.js connection pool
│   ├── controllers/             #   HTTP handlers (4 controllers)
│   ├── repositories/            #   SQL queries (4 repositories)
│   ├── routes/                  #   Route definitions (factory pattern)
│   ├── services/                #   Business logic (answerValidator)
│   ├── errors/                  #   AppError, NotFoundError, ValidationError
│   ├── utils/                   #   session.js, collections.js
│   └── tests/                   #   Unit + integration tests
│
├── src/                         # Frontend (React 19)
│   ├── main.jsx                 #   ★ Entrypoint — RouterProvider + StrictMode
│   ├── router.jsx               #   Route tree with loaders + lazy loading
│   ├── api/                     #   API client (auto X-Session-Id, 30s timeout)
│   ├── components/
│   │   ├── Layout.jsx           #   AppBar + SearchBar + page skeleton
│   │   ├── exercise/            #   Exercise UI (registry + 7 type components)
│   │   ├── lesson/              #   Theory sections + MarkdownContent
│   │   ├── progress/            #   Status chips, score badges, reset dialog
│   │   ├── search/              #   Async search with 300ms debounce
│   │   └── skeletons/           #   Loading skeletons
│   ├── hooks/                   #   useExerciseFlow (FSM), useSessionId
│   ├── pages/                   #   5 pages (Home, Dashboard, Lesson, Exercise, Results)
│   ├── constants/               #   Shared constants (difficulty labels/colors)
│   └── theme/                   #   MUI theme (primary: #6366f1)
│
├── e2e/                         # Playwright smoke tests (6 tests)
├── .github/workflows/ci.yml    # GitHub Actions (3 parallel jobs)
├── docker-compose.yml           # PostgreSQL 17 container
├── Makefile                     # Developer commands
├── vite.config.js               # Vite config (proxy, chunks, target)
└── eslint.config.js             # ESLint 9 flat config
```

---

## Architecture

### High-Level Data Flow

```
Browser → React Router (loader) → API Client → Fastify → Repository → PostgreSQL
                                   ↓
                              X-Session-Id header (UUID from localStorage)
```

### Server Architecture (Composition Root)

```
index.js (wires everything)
  │
  ├── sql = postgres(config)
  ├── repos = { category(sql), lesson(sql), exercise(sql), progress(sql) }
  ├── controllers = { category(repo), lesson(repo), exercise(repo), progress(repo) }
  └── app = createApp({ controllers, sql })
        │
        ├── Plugins: helmet, cors, rate-limit
        ├── Routes: factory pattern → (controller) => fastify plugin
        └── Error handler: AppError → status + message
```

### Client Architecture

```
main.jsx → RouterProvider
  │
  router.jsx (route tree)
    ├── / → HomePage (eager load)
    ├── /dashboard → DashboardPage (lazy)
    ├── /lessons/:slug → LessonPage (lazy)
    ├── /lessons/:id/exercises → ExercisePage (lazy)
    └── /lessons/:id/results → ResultsPage (lazy)

  Data flow: loader() → fetch API → useState(loaderData) + useEffect sync
```

---

## Database Design

### Entity Relationship (15 tables)

```
category (8 rows)
  └── lesson (31 rows)
        ├── formula (grammar-specific, 36 rows)
        ├── lesson_usage (95 rows)
        │     └── example (186 rows)
        ├── signal_word (grammar-specific, 76 rows)
        ├── tip (94 rows)
        ├── lesson_section (57 rows, generic markdown content)
        ├── lesson_comparison (19 rows, bidirectional via view)
        └── exercise (217 rows)
              ├── exercise_option (for multiple_choice, 124 rows)
              └── matching_pair (for matching, 108+ rows)

user_progress (session × lesson, unique)
  └── exercise_attempt (session × exercise × attempt_number)

bookmark (session × lesson, reserved for future)
schema_version (migration tracking, currently v7)
```

### Key Design Decisions

| Decision                                                | Rationale                                                                           |
| ------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| **Grammar-specific tables kept** (formula, signal_word) | Backward-compatible; non-grammar lessons simply have 0 rows; UI null-guards         |
| **lesson_section** for generic content                  | Data-driven markdown sections with metadata (info_box, key_points); any subject     |
| **Dynamic exercise count**                              | `exercises_total` computed at runtime via subquery (no stale cached column)         |
| **Advisory locks** for race conditions                  | `pg_advisory_xact_lock` prevents duplicate `attempt_number` under concurrent writes |
| **INNER JOIN on results**                               | Never LEFT JOIN — prevents answer leakage for unattempted exercises                 |
| **Bidirectional comparison view**                       | `v_lesson_comparisons` uses UNION to show comparisons from both sides               |

### Indexes (Strategic)

| Index                              | Type                                 | Purpose                                          |
| ---------------------------------- | ------------------------------------ | ------------------------------------------------ |
| `idx_exercise_lesson_active_order` | **Partial** (WHERE is_active = TRUE) | 8+ query paths; excludes inactive exercises      |
| `idx_lesson_group_published_order` | **Composite**                        | Covers equality + filter + sort in one scan      |
| `idx_exercise_lesson_type_diff`    | Composite                            | Exercise filtering by lesson + type + difficulty |
| `idx_progress_lesson_session`      | Composite                            | Progress lookup by lesson + session              |
| `idx_attempt_session_exercise`     | Composite                            | Attempt history per session per exercise         |

---

## API Reference

| Method | Endpoint                                  | Purpose                               |
| ------ | ----------------------------------------- | ------------------------------------- |
| GET    | `/api/health`                             | Health check with DB ping             |
| GET    | `/api/groups`                             | List all categories                   |
| GET    | `/api/groups/:groupId/lessons`            | Lessons by category                   |
| GET    | `/api/lessons/search?q=`                  | Search lessons (ILIKE, limit 50)      |
| GET    | `/api/lessons/:slug`                      | Full lesson (BFF: 8 parallel queries) |
| GET    | `/api/lessons/:lessonId/exercises`        | Exercises for a lesson (no answers)   |
| GET    | `/api/lessons/:lessonId/results`          | Results (INNER JOIN on attempts)      |
| POST   | `/api/exercises/:exerciseId/submit`       | Submit answer + validate              |
| GET    | `/api/progress/session/dashboard`         | Dashboard stats (BFF)                 |
| GET    | `/api/progress/session/overview`          | All progress for session              |
| GET    | `/api/progress/:lessonId`                 | Progress for a specific lesson        |
| POST   | `/api/progress/:lessonId/theory-complete` | Mark theory as read                   |
| POST   | `/api/progress/:lessonId/reset`           | Reset lesson progress                 |

All endpoints include JSON Schema validation on params, query, and body.

---

## Exercise System

### 7 Exercise Types

| Type                 | Component             | Input                  | Validation                              |
| -------------------- | --------------------- | ---------------------- | --------------------------------------- |
| `multiple_choice`    | MultipleChoice.jsx    | Radio button (A–F)     | Exact match against `is_correct` option |
| `fill_blank`         | FillBlank.jsx         | Text input             | Case-insensitive, trimmed comparison    |
| `error_correction`   | ErrorCorrection.jsx   | Text input             | Normalized string comparison            |
| `sentence_transform` | SentenceTransform.jsx | Text input             | Normalized string comparison            |
| `true_false`         | TrueFalse.jsx         | Toggle button          | Exact match ("true"/"false")            |
| `arrange_words`      | ArrangeWords.jsx      | Click-to-arrange chips | Normalized sentence comparison          |
| `matching`           | Matching.jsx          | Click-to-pair chips    | Set comparison (all pairs correct)      |

### Exercise Flow (FSM)

```
idle → answering → submitting → feedback → (next exercise or finished)
                        ↓
                      error → answering (retry)
```

Implemented via `useReducer` in `useExerciseFlow.js` (10 unit tests cover all transitions).

---

## Design Patterns

| Pattern                             | Where                                 | Why                                                                           |
| ----------------------------------- | ------------------------------------- | ----------------------------------------------------------------------------- |
| **Composition Root**                | `server/index.js`                     | Single wiring point for all dependencies. No hidden imports. Testable.        |
| **Repository Pattern**              | `server/repositories/`                | SQL isolated from business logic. Swap DB without touching controllers.       |
| **Factory Pattern**                 | `server/routes/`                      | Routes receive controller via factory. No global imports.                     |
| **Registry Pattern**                | `src/components/exercise/registry.js` | Map exercise type → component. Add new types without modifying existing code. |
| **Strategy Pattern**                | `server/services/answerValidator.js`  | Each exercise type has its own validation strategy. Open/closed principle.    |
| **BFF (Backend-for-Frontend)**      | `findFullBySlug()`, `getDashboard()`  | Server assembles complex views from parallel queries. Client gets one call.   |
| **FSM (Finite State Machine)**      | `useExerciseFlow.js`                  | Predictable state transitions for exercise flow. No impossible states.        |
| **Observer (useSyncExternalStore)** | `useSessionId.js`                     | Session ID available in both components and loaders without prop drilling.    |

---

## Techniques & Algorithms

| Technique                       | Location                           | Complexity     | Purpose                                                               |
| ------------------------------- | ---------------------------------- | -------------- | --------------------------------------------------------------------- |
| **SQL ILIKE wildcard escaping** | `lessonRepository.js:10`           | O(n)           | Escape `%`, `_`, `\` to prevent wildcard injection                    |
| **Parallel query execution**    | `findFullBySlug()`                 | O(1) parallel  | 8 queries via `Promise.all` — eliminates N+1                          |
| **CTE + ROW_NUMBER()**          | `findResultsByLesson()`            | O(n log n)     | Latest attempt per exercise without correlated subquery               |
| **Advisory locks**              | `getNextAttemptNumber()`           | O(1)           | `pg_advisory_xact_lock` prevents race condition on concurrent submits |
| **Debounce**                    | `SearchBar.jsx`                    | O(1)           | 300ms debounce prevents API call on every keystroke                   |
| **Partial index**               | `idx_exercise_lesson_active_order` | Smaller index  | Only indexes active exercises (WHERE is_active = TRUE)                |
| **Route-based code splitting**  | `router.jsx`                       | O(1) per route | `lazy()` on 4/5 pages — only load code for current page               |
| **Vendor chunking**             | `vite.config.js`                   | Build-time     | Separate chunks for React, MUI, Router — better cache invalidation    |
| **Fisher-Yates shuffle**        | `collections.js`                   | O(n)           | Randomize exercise order with `[...arr]` copy (no mutation)           |
| **COALESCE on aggregates**      | Progress queries                   | O(1)           | Prevent NULL from SUM/AVG on empty sets                               |

### Data Structures

| Structure                    | Where                                          | Why                                                     |
| ---------------------------- | ---------------------------------------------- | ------------------------------------------------------- |
| **Set**                      | `Matching.jsx` (pairedLeftIds, pairedRightIds) | O(1) lookup for paired status                           |
| **Map-like groupBy**         | `DashboardPage.jsx`, `collections.js`          | Group lessons by category — O(n)                        |
| **Array of ordered indices** | `ArrangeWords.jsx` (selectedIndices)           | Track word selection order for sentence construction    |
| **Reducer state object**     | `useExerciseFlow.js`                           | FSM state: `{ phase, index, answers, feedback, error }` |

---

## Libraries & Justification

| Library                   | Why chosen                                                                   | Why not alternatives                                                               |
| ------------------------- | ---------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| **Fastify**               | Fastest Node.js framework, schema validation built-in, plugin system         | Express: no built-in validation, slower. Koa: smaller ecosystem.                   |
| **postgres.js**           | Tagged template literals prevent SQL injection by design. Zero overhead.     | pg (node-postgres): more boilerplate. Knex/Prisma: unnecessary ORM for this scale. |
| **React Router 7**        | Data loaders eliminate useEffect waterfalls. Lazy routes for code splitting. | TanStack Router: newer, less ecosystem. Next.js: SSR unnecessary for SPA.          |
| **MUI 7**                 | Comprehensive component library with theming. Deep imports for tree-shaking. | Tailwind: no pre-built components. Ant Design: less customizable theme.            |
| **marked + highlight.js** | Lightweight markdown with tree-shakeable syntax highlighting.                | react-markdown: heavier. Shiki: larger bundle for same result.                     |
| **DOMPurify**             | Industry-standard XSS sanitization. Small (~7KB).                            | sanitize-html: heavier. No sanitization: unacceptable risk.                        |
| **Vitest**                | Vite-native, fast, ESM support, compatible with Jest API.                    | Jest: slower with ESM. Mocha: more configuration.                                  |
| **Playwright**            | Cross-browser E2E, auto-wait, reliable.                                      | Cypress: no Firefox/Safari. Puppeteer: Chrome-only.                                |

---

## Testing

### Test Matrix (116 total)

| Layer                  | Tests | Framework           | What's tested                                               |
| ---------------------- | ----- | ------------------- | ----------------------------------------------------------- |
| **Client unit**        | 10    | Vitest + jsdom      | `useExerciseFlow` FSM — all state transitions               |
| **Server unit**        | 41    | Vitest              | `answerValidator` (20) + `app.test.js` (21 with mock repos) |
| **Server integration** | 59    | Vitest + PostgreSQL | 4 repository files against real test DB                     |
| **E2E smoke**          | 6     | Playwright          | Homepage, lesson, Python code, exercise, search, dashboard  |

### Running Tests

```bash
# All tests
make test

# Unit only (no DB required)
make test-unit

# Integration only (requires PostgreSQL)
make test-integration

# E2E (requires running dev servers)
npm run test:e2e
```

### Integration Test Architecture

- `globalSetup` creates a fresh `knowledge_learning_test` database, loads schema + seed
- Each test uses a unique `session_id` for isolation (no test interference)
- `globalTeardown` drops the test database
- Separate Vitest config: `server/vitest.integration.js`

---

## Developer Experience

### Pre-commit Hooks (Husky + lint-staged)

On every commit:

1. **ESLint --fix** on staged `src/**/*.{js,jsx}`
2. **Prettier --write** on all staged files
3. **commitlint** validates conventional commit format

### Conventional Commits

```
feat(content): add Python Basics category
fix(server): escape ILIKE wildcards in search
perf(db): add partial exercise index
test(e2e): add Playwright smoke tests
```

### Hot Reload

- **Client**: Vite HMR (instant)
- **Server**: nodemon (auto-restart on file change)

---

## Security

| Measure                       | Implementation                                                                      |
| ----------------------------- | ----------------------------------------------------------------------------------- |
| **SQL injection prevention**  | postgres.js tagged templates — parameterized by design                              |
| **ILIKE wildcard injection**  | Escape `%`, `_`, `\` before pattern construction                                    |
| **XSS prevention**            | DOMPurify sanitizes all markdown output before `dangerouslySetInnerHTML`            |
| **Answer leakage prevention** | GET endpoints never return `correct_answer` or `is_correct`. INNER JOIN on results. |
| **Security headers**          | @fastify/helmet (all headers except CSP, which conflicts with SPA)                  |
| **Rate limiting**             | 100 requests/minute per IP via @fastify/rate-limit                                  |
| **Input validation**          | Fastify JSON Schema on all 12 data endpoints (params, query, body)                  |
| **Session validation**        | `X-Session-Id` header: required, string, max 64 chars                               |
| **Race condition guard**      | `pg_advisory_xact_lock` in attempt number generation                                |
| **No secrets in code**        | All credentials via `.env` file (not committed)                                     |

---

## Performance

| Optimization             | Impact                                                                   |
| ------------------------ | ------------------------------------------------------------------------ |
| **BFF pattern**          | Lesson page: 1 HTTP call instead of 8. Server runs queries in parallel.  |
| **Partial index**        | Exercise queries only scan active rows (WHERE is_active = TRUE)          |
| **CTE + ROW_NUMBER()**   | Results query: O(n log n) instead of O(n²) correlated subquery           |
| **Route code splitting** | 4 pages lazy-loaded. Initial bundle: ~6KB app code + vendor chunks.      |
| **Vendor chunking**      | React, MUI, Router in separate chunks — cache survives app code changes. |
| **Search debounce**      | 300ms — prevents API hammering during fast typing.                       |
| **Connection pool**      | postgres.js pool: 10 connections, 20s idle timeout, 10s connect timeout. |

---

## CI/CD

### GitHub Actions Pipeline

```
push/PR to main/master
  │
  ├── Job 1: Lint & Build (parallel)
  │     ├── ESLint (client + server)
  │     ├── Prettier check
  │     └── Vite build
  │
  ├── Job 2: Unit Tests (parallel)
  │     ├── Client tests (Vitest + jsdom)
  │     └── Server unit tests (Vitest)
  │
  └── Job 3: Integration Tests (parallel)
        ├── PostgreSQL 17 service container
        └── Repository tests against real DB
```

All 3 jobs run in parallel. Cache: `package-lock.json` for npm dependencies.

---

## Makefile Commands

```bash
make help             # Show all available commands
make install          # Install client + server dependencies
make dev              # Start both dev servers (parallel)
make lint             # Lint client + server
make format           # Format all code
make build            # Production build
make test             # Run all tests (unit + integration)
make test-unit        # Unit tests only (no DB needed)
make test-integration # Integration tests (needs PostgreSQL)
make db-up            # Start PostgreSQL container
make db-down          # Stop PostgreSQL container
make db-reset         # Destroy + recreate database from scratch
make check            # Full CI check: lint + format + test + build
make clean            # Remove build artifacts and node_modules
```

---

## Environment Variables

Copy `.env.example` to `.env`:

```bash
# Database (Docker PostgreSQL)
DB_HOST=localhost
DB_PORT=5432
DB_USER=relax_user
DB_PASSWORD=change_me
DB_NAME=knowledge_learning

# Server
PORT=3001
NODE_ENV=development

# CORS (React dev server)
CORS_ORIGIN=http://localhost:5173
```

---

## License

MIT — see [LICENSE](./LICENSE)
