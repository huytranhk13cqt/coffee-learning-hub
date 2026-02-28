# Project Relax — CLAUDE.md

General-purpose Learning Hub — teaches ANY subject. English grammar = first content module.
**Stack**: React 19 + Vite 7 + MUI 7 + Fastify 5 + PostgreSQL 17 + postgres.js
**Auth**: None — session-based via `X-Session-Id` header (UUID in localStorage)

---

## 0) Quick Start

```bash
docker compose up -d          # PostgreSQL
npm ci && npm run dev         # Client :5173
cd server && npm ci && npm run dev  # Server :3001
```

| Task       | Client (root)                   | Server (`cd server`)                  |
| ---------- | ------------------------------- | ------------------------------------- |
| Dev        | `npm run dev`                   | `npm run dev`                         |
| Test       | `npx vitest run`                | `npx vitest run` / `npm run test:all` |
| Lint+Build | `npm run lint && npm run build` | —                                     |
| All checks | `make check`                    | —                                     |

---

## 1) Working Agreement

- Small, reviewable diffs. Split large changes into multiple commits.
- Never change public APIs without updating tests + docs.
- Never hardcode secrets. Never print tokens/keys in logs.
- Preserve backward compatibility unless explicitly asked to break it.

## 2) Definition of Done

- Lint passes (`npm run lint`) + Build succeeds (`npm run build`)
- Behavior validated (manual test, logs, or repro steps)
- Docs/comments updated if behavior/API changed

---

## 3) Key Files

```
server/index.js          ★ Composition Root — wires sql → repos → controllers → routes
server/app.js            Fastify factory (plugins, routes, error handler)
server/services/answerValidator.js  Registry-based answer validation (Strategy pattern)
src/main.jsx             ★ React entrypoint — RouterProvider + StrictMode
src/router.jsx           Route tree + loaders + lazy loading
src/hooks/useExerciseFlow.js  useReducer FSM (idle→answering→submitting→feedback→done)
src/components/exercise/registry.js  Exercise type → component map (8 types)
```

**Full docs**: `docs/` — architecture, API reference, database schema, ADRs, runbooks, guides.

---

## 4) Architecture Patterns (MUST follow)

**Server**:

- **Composition Root**: `index.js` wires `sql → repo(sql) → controller(repo) → routes(controller)`. Never import repos in route files.
- **No try/catch in controllers**: throw `AppError` subclass; Fastify error handler catches.
- **postgres.js tagged templates**: `sql\`SELECT ...\`` — NEVER string concatenation.
- **Security boundary**: GET endpoints NEVER return `correct_answer` or `is_correct`.
- **Route factory**: `(controller) => async function plugin(fastify) { ... }`

**Client**:

- **React Router v7 loaders** for all data fetching. NEVER `useEffect` for initial data.
- **`useReducer` FSM** for complex state. `useState` only for simple local state.
- **`useSyncExternalStore`** for session ID (safe in loaders via `getSessionId()`).
- **Registry pattern** for exercise types (8) and section types (9).
- **`useState(loaderData)` + `useEffect([loaderData])`** for optimistic updates. Never bare `useState(loaderData)`.

**MUI 7**:

```js
import Button from '@mui/material/Button'; // ✅ deep default
import { ThemeProvider } from '@mui/material/styles'; // ✅ named from subpath
import { Button } from '@mui/material'; // ❌ NEVER barrel
```

- `Button` has native `loading` prop. Use `sx` for styling. Theme colors only (no hardcoded hex).

---

## 5) Naming

| Category              | Convention    | Example                                  |
| --------------------- | ------------- | ---------------------------------------- |
| Pages / UI components | PascalCase    | `HomePage.jsx`, `ScoreBadge.jsx`         |
| Hooks                 | camelCase+use | `useSessionId.js`, `useExerciseFlow.js`  |
| API modules           | camelCase     | `lessons.js`, `progress.js`              |
| Server classes        | PascalCase    | `LessonController`, `ExerciseRepository` |
| Server files          | camelCase     | `lessonController.js`                    |
| DB tables/columns     | snake_case    | `user_progress`, `lesson_id`             |
| Env vars              | UPPER_SNAKE   | `DB_HOST`, `CORS_ORIGIN`                 |

Components: `export default function Name()` — organized by feature domain (`exercise/`, `lesson/`, `progress/`).

---

## 6) Anti-Patterns (NEVER)

| Anti-Pattern                        | Correct Approach                           |
| ----------------------------------- | ------------------------------------------ |
| `Map.groupBy()`                     | Custom `groupBy(arr, keyFn)` in controller |
| `useEffect` for data fetching       | React Router loaders                       |
| MUI barrel imports                  | Deep imports (§4)                          |
| Return `correct_answer` in GET      | Separate validation queries                |
| `LEFT JOIN` in results query        | `INNER JOIN` on attempts                   |
| `useState(loaderData)` without sync | Add `useEffect([loaderData])`              |
| Missing `COALESCE` on aggregates    | `COALESCE(SUM(...), 0)`                    |
| String concat in SQL                | postgres.js tagged templates               |
| try/catch in controllers            | Throw `AppError` subclass                  |
| Import repos in route files         | Pass controller via factory                |

---

## 7) Database & Env

**DB**: PostgreSQL 17 (Docker), schema v19+, `database/schema.sql` + `database/migrations/`.
**Current data**: ~44 topics, 48 categories, 124 lessons, 726 exercises.
**Full schema reference**: `docs/database.md`

```
DB_HOST=localhost  DB_PORT=5432  DB_USER=relax_user
DB_PASSWORD=change_me  DB_NAME=knowledge_learning
PORT=3001  NODE_ENV=development  CORS_ORIGIN=http://localhost:5173
```

---

## 8) Safety & Skills

- Only run destructive commands (db reset, rm -rf) when explicitly asked.
- Reproduce + write failing test before implementing a fix.
- `/fellow-os`: architecture, production bugs, perf, RFC/ADR, complex refactors.
- Code changes: explain intent (3-7 bullets), show files touched, provide validation steps.
