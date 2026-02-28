# Project Relax — CLAUDE.md

General-purpose Learning Hub — can teach ANY subject (coding, math, physics, psychology, etc.). English grammar (12 tenses) is the first content module, not the app's identity.

**Stack**: React 19 + Vite 7 + MUI 7 + Fastify 5 + PostgreSQL 17 + postgres.js
**Auth**: None — local-first, session-based via `X-Session-Id` header (UUID in localStorage)

---

## 0) Quick Start

```bash
# 1. Database
docker-compose up -d

# 2. Install
npm ci                           # Client (root)
cd server && npm ci              # Server

# 3. Dev servers (two terminals)
npm run dev                      # Vite on :5173
cd server && npm run dev         # Fastify on :3001 (nodemon)
```

**Commands**:
| Task | Client (root) | Server (`cd server`) |
|------------------|---------------------|--------------------------------------|
| Install | `npm ci` | `npm ci` |
| Dev | `npm run dev` | `npm run dev` |
| Build | `npm run build` | — |
| Lint | `npm run lint` | — |
| Unit tests | `npx vitest run` | `npx vitest run` |
| Integration tests| — | `npx vitest run -c vitest.integration.js` |
| All tests | — | `npm run test:all` |
| Start | `npm run preview` | `npm start` |

> Vitest for testing. Makefile targets: `make check` (lint+format+test+build), `make test-unit`, `make test-integration`.

---

## 1) Working Agreement (Non-negotiables)

- Prefer small, reviewable diffs. Split large changes into multiple commits.
- Do not change public APIs or behavior without updating tests + docs.
- Never hardcode secrets. Never print tokens/keys in logs.
- If uncertain, add instrumentation or a test to prove the hypothesis before refactoring.
- Always preserve backward compatibility unless explicitly asked to break it.

---

## 2) Definition of Done

A change is "done" only if:

- Lint passes (`npm run lint`)
- Build succeeds (`npm run build`)
- Behavior is validated (manual test, logs, or repro steps)
- Docs/comments updated if behavior/API changed

---

## 3) Project Map

### 3.1 Top-level Structure

```
project-relax/
├── database/             # Schema, seeds, DB docs
│   ├── schema.sql        # PostgreSQL 17 DDL (15 tables, 12 ENUMs, 3 views)
│   ├── migrations/       # Incremental SQL migrations (version-tracked)
│   └── seed_data.sql     # Seed data (15 lessons: 12 grammar + 3 learning methods)
├── server/               # Backend (Fastify 5 + postgres.js)
│   ├── index.js          # ★ ENTRYPOINT — Composition Root
│   ├── app.js            # Fastify app factory (plugins, routes, error handler)
│   ├── config/
│   │   └── database.js   # postgres.js singleton (pool: 10)
│   ├── controllers/      # HTTP handlers (classes, arrow methods)
│   ├── repositories/     # SQL queries (postgres.js tagged templates)
│   ├── routes/           # Route definitions (factory → Fastify plugin)
│   ├── services/
│   │   └── answerValidator.js  # Registry-based answer validation
│   ├── errors/
│   │   └── AppError.js   # AppError, NotFoundError, ValidationError
│   └── package.json      # Server deps (separate from client)
├── src/                  # Frontend (React 19 + React Router 7 + MUI 7)
│   ├── main.jsx          # ★ ENTRYPOINT — RouterProvider + StrictMode
│   ├── router.jsx        # Route tree with loaders
│   ├── api/              # API client layer
│   │   ├── client.js     # Base client (auto X-Session-Id, ApiError)
│   │   ├── groups.js     # fetchGroups
│   │   ├── lessons.js    # fetchLesson, fetchLessonsByGroup, searchLessons
│   │   ├── exercises.js  # fetchExercises, submitAnswer, fetchResults
│   │   └── progress.js   # fetchProgress, markTheoryComplete, resetProgress, fetchDashboard
│   ├── constants/
│   │   └── difficulty.js  # DIFFICULTY_LABELS, DIFFICULTY_COLORS (shared)
│   ├── components/
│   │   ├── Layout.jsx    # AppBar + SearchBar + Outlet + ThemeProvider
│   │   ├── exercise/     # Exercise UI (see §3.4)
│   │   ├── lesson/       # Theory sections (Formula, Usage, SignalWords, Tips, Comparison)
│   │   ├── progress/     # LessonStatusChip, ScoreBadge, ProgressSummary, ResetDialog
│   │   └── search/
│   │       └── SearchBar.jsx  # Async Autocomplete + 300ms debounce
│   ├── hooks/
│   │   ├── useSessionId.js    # useSyncExternalStore (getSessionId for loaders)
│   │   └── useExerciseFlow.js # useReducer FSM (idle→answering→submitting→feedback→finished)
│   ├── pages/
│   │   ├── HomePage.jsx       # Groups + lessons + progress badges
│   │   ├── DashboardPage.jsx  # Stats cards + per-group progress
│   │   ├── LessonPage.jsx     # Theory + navigation + progress
│   │   ├── ExercisePage.jsx   # Exercise flow + nav blocker
│   │   ├── ResultsPage.jsx    # Answers review + scores
│   │   └── ErrorPage.jsx      # ErrorBoundary
│   ├── theme/
│   │   └── theme.js           # MUI createTheme (primary: #6366f1)
│   └── index.css              # Minimal global styles
├── docker-compose.yml    # PostgreSQL 17 container
├── vite.config.js        # Vite 7 (proxy /api → :3001, target: es2020+safari13)
├── eslint.config.js      # ESLint 9 flat config
├── .env.example          # DB_HOST, DB_PORT, DB_USER, DB_PASSWORD, DB_NAME, PORT, CORS_ORIGIN
└── index.html            # Vite entry HTML
```

### 3.2 API Endpoints

```
GET    /api/home                                → CategoryController.getHomePage (BFF)
GET    /api/groups                              → CategoryController.getAll
GET    /api/groups/:groupId/lessons             → LessonController.getByGroup
GET    /api/lessons/search?q=                   → LessonController.search
GET    /api/lessons/:slug                       → LessonController.getBySlug (BFF)
GET    /api/lessons/:lessonId/exercises          → ExerciseController.getByLesson (BFF)
GET    /api/lessons/:lessonId/results            → ExerciseController.getResults
POST   /api/exercises/:exerciseId/submit         → ExerciseController.submit
GET    /api/progress/session/dashboard           → ProgressController.getDashboard (BFF)
GET    /api/progress/session/overview            → ProgressController.getSessionOverview
GET    /api/progress/:lessonId                   → ProgressController.getProgress
POST   /api/progress/:lessonId/theory-complete   → ProgressController.markTheoryComplete
POST   /api/progress/:lessonId/reset             → ProgressController.resetProgress
```

### 3.3 Client Routes

```
/                          → HomePage      (loader: groups + progress)
/dashboard                 → DashboardPage (loader: dashboard BFF)
/lessons/:slug             → LessonPage    (loader: lesson + progress)
/lessons/:lessonId/exercises → ExercisePage (loader: exercises)
/lessons/:lessonId/results  → ResultsPage  (loader: results + progress)
```

### 3.4 Exercise Type Registry

8 exercise types, each mapped in `src/components/exercise/registry.js`:

| Type                 | Component             | Answer Format              |
| -------------------- | --------------------- | -------------------------- |
| `multiple_choice`    | MultipleChoice.jsx    | `"A"` – `"F"`              |
| `fill_blank`         | FillBlank.jsx         | string                     |
| `error_correction`   | ErrorCorrection.jsx   | string                     |
| `sentence_transform` | SentenceTransform.jsx | string                     |
| `true_false`         | TrueFalse.jsx         | `"true"` / `"false"`       |
| `arrange_words`      | ArrangeWords.jsx      | string (joined sentence)   |
| `matching`           | Matching.jsx          | `[{leftId, rightId}, ...]` |
| `code_output`        | CodeOutput.jsx        | string (predicted output)  |

All exercise type components share the interface:

```jsx
function TypeComponent({ exercise, answer, onAnswerChange, disabled })
```

---

## 4) Architecture Patterns (MUST follow)

### 4.1 Server Patterns

- **Composition Root**: `server/index.js` wires `sql → repo(sql) → controller(repo) → routes(controller)`. Repos: `CategoryRepository`, `LessonRepository`, `ExerciseRepository`, `ProgressRepository`. Never import repos/controllers directly in route files.
- **No try/catch in controllers**: Fastify's error handler in `app.js` catches `AppError` subclasses. Controllers just throw.
- **postgres.js tagged templates**: Always `sql\`SELECT ...\``. **Never** string concatenation in queries.
- **Transaction-aware repos**: Methods needing transactions accept `tx` as first param (e.g., `insertAttempt(tx, {...})`).
- **Security boundary**: GET endpoints (exercises, options) **never** return `correct_answer` or `is_correct`. Validation-only queries are separate methods.
- **Route factory pattern**: Each route file exports a function `(controller) => async function plugin(app)`.

### 4.2 Client Patterns

- **React Router v7 loaders** for all data fetching. **Never** `useEffect` for initial data loads.
- **`useReducer` FSM** for complex state (`useExerciseFlow`). `useState` only for simple local state.
- **`useSyncExternalStore`** for session ID (safe in loaders via `getSessionId()`).
- **Registry pattern** for exercise types — add new types to `registry.js`, create component in `types/`.
- **Loader + useState sync**: When a page needs optimistic updates, use `useState(loaderData)` + `useEffect` to sync on navigation. Never use bare `useState(loaderData)` without the sync effect.

### 4.3 MUI 7 Rules (Critical)

```javascript
// ✅ Components: deep default import
import Button from '@mui/material/Button';
import Typography from '@mui/material/Typography';

// ✅ Styles/utils: named import from subpath
import { ThemeProvider } from '@mui/material/styles';
import { useTheme } from '@mui/material/styles';

// ❌ NEVER barrel imports
import { Button, Typography } from '@mui/material';

// ❌ NEVER default import for ThemeProvider
import ThemeProvider from '@mui/material/styles/ThemeProvider';
```

- MUI 7 `Button` has native `loading` prop (no @mui/lab needed).
- Use `sx` prop for styling. Theme-based colors only (no hardcoded hex in components).

---

## 5) Naming Conventions

| Category          | Convention    | Example                                        |
| ----------------- | ------------- | ---------------------------------------------- |
| Page components   | PascalCase    | `HomePage.jsx`, `LessonPage.jsx`               |
| UI components     | PascalCase    | `ScoreBadge.jsx`, `FeedbackPanel.jsx`          |
| Hooks             | camelCase+use | `useSessionId.js`, `useExerciseFlow.js`        |
| API modules       | camelCase     | `lessons.js`, `progress.js`                    |
| Server classes    | PascalCase    | `LessonController`, `ExerciseRepository`       |
| Server files      | camelCase     | `lessonController.js`, `exerciseRepository.js` |
| DB tables/columns | snake_case    | `user_progress`, `lesson_id`                   |
| DB ENUMs          | snake_case    | `exercise_type`, `difficulty_level`            |
| Env vars          | UPPER_SNAKE   | `DB_HOST`, `CORS_ORIGIN`                       |

**Exports**:

- React components: `export default function Name()`
- Loaders: `export async function loader()` (named, co-located in page file)
- API/hooks: named exports (`export function fetchLesson()`)
- Server classes: named exports (`export class LessonController`)
- Theme/config: default export

**Component organization**: Group by feature domain (`exercise/`, `lesson/`, `progress/`, `search/`), not by type.

---

## 6) Anti-Patterns (NEVER do these)

| Anti-Pattern                        | Why                                     | Correct Approach                           |
| ----------------------------------- | --------------------------------------- | ------------------------------------------ |
| `Map.groupBy()`                     | Not available in Node < 21              | Custom `groupBy(arr, keyFn)` in controller |
| `useEffect` for data fetching       | Waterfalls, race conditions             | React Router loaders                       |
| MUI barrel imports                  | Kills tree-shaking, slow builds         | Deep imports (§4.3)                        |
| Return `correct_answer` in GET      | Answer leakage to client                | Separate validation queries                |
| `LEFT JOIN` in results query        | Leaks answers for unattempted exercises | `INNER JOIN` on attempts                   |
| `useState(loaderData)` without sync | Stale state on navigation               | Add `useEffect([loaderData])` sync         |
| Missing `COALESCE` on aggregates    | `SUM`/`AVG` return `NULL` on empty sets | `COALESCE(..., 0)`                         |
| String concat in SQL                | SQL injection risk                      | postgres.js tagged templates               |
| Array mutation in shuffle           | Mutates original array                  | `[...arr]` copy first                      |
| try/catch in controllers            | Fastify handles errors via `AppError`   | Just throw `AppError` subclass             |
| Import repos in route files         | Breaks composition root                 | Pass controller via factory                |

---

## 7) Database

- **Engine**: PostgreSQL 17 (Docker)
- **Schema**: `database/schema.sql` (15 tables, 12 ENUMs, 3 views, 3 functions, 8 triggers)
- **Migrations**: `database/migrations/` (tracked by `schema_version` table, currently v12)
- **Seeds**: `database/seed_data.sql` + `seed_python.sql` + `seed_math.sql` + `seed_cybersecurity.sql` + `seed_psychology.sql` + `seed_design.sql` + `seed_history.sql` + `seed_music.sql` + `seed_philosophy.sql`
- **Data status**: 35 lessons, 12 categories, 245 exercises total
- **Migrations**: v8 (expanded category order_index constraint to 0-20)
- **Key constraints**: `UNIQUE(session_id, lesson_id)` on progress, `UNIQUE(session_id, exercise_id, attempt_number)` on attempts
- **Race condition guard**: `pg_advisory_xact_lock` in `getNextAttemptNumber`

---

## 8) Environment Variables

Copy `.env.example` to `.env`:

```
DB_HOST=localhost
DB_PORT=5432
DB_USER=relax_user
DB_PASSWORD=change_me
DB_NAME=knowledge_learning
PORT=3001
NODE_ENV=development
CORS_ORIGIN=http://localhost:5173
```

---

## 9) Phase Status

- **Phase 0** (Theory viewing): COMPLETE
- **Phase 1** (Exercise system): COMPLETE — bugs fixed 2026-02-09
- **Phase 2** (Progress integration + UX polish): COMPLETE
- **Phase 3** (Dashboard + Search): COMPLETE
- **Phase 4** (Testing + DX): COMPLETE — Vitest, Husky, lint-staged, commitlint, Makefile
- **Phase 5** (Generalization): COMPLETE — `tense_group` → `category`, UI strings neutralized
- **Phase 6** (Content + Hardening): COMPLETE — TIER 0-4, P0 tests, P1 content done
- **Phase 7** (Multi-domain): COMPLETE — Learning Methods, test foundation, CI, lesson_section system
- **Phase 8** (Content + Polish): COMPLETE — Python Basics, code highlighting, E2E tests, UX polish, DB indexes
- **Phase 9** (Media Foundation): COMPLETE — KaTeX, 12 hljs languages, section registry, audio/video sections, code_output exercise type, exercise media columns
- **Phase 10** (Quality Shield): COMPLETE — dark mode, accessibility, component tests, E2E tests
- **Phase 11** (Rich Visualizations): COMPLETE — ChartSection (Recharts), DiagramSection (Mermaid), lazy loading
- **Phase 12** (Audit Fixes): COMPLETE — null handling, N+1 queries, error boundary, XSS sanitize, validator DRY, DB indexes
- **Phase 13** (Hardening): COMPLETE — case-sensitive code validation, UUID session check, rate limit, gzip, request-id, React Compiler, web-vitals
- **Phase 14** (BFF + Resilience): COMPLETE — HomePage BFF (14 req → 1), API retry with backoff, warn-level error logging, trigger optimization

---

## 10) Safety / Permissions

- Only run destructive commands (db reset, rm -rf, prod deploy) when explicitly asked.
- Prefer read-only inspection first.
- When debugging, reproduce + write failing test before implementing a fix.

---

## 11) How to Use the Fellow OS Skill

Use `/fellow-os` for:

- Architecture / system design
- Production bugs / incidents
- Performance / reliability work
- RFC/ADR/runbooks
- Complex refactors

When `/fellow-os` is used, follow its structure + Self-Audit. Do not skip risks/alternatives.

---

## 12) Output Style for Code Changes

When making changes:

- Explain intent in 3-7 bullets max
- Show exact files touched
- Provide validation steps
- If risk exists, propose rollback plan and what to monitor
