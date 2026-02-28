# Documentation Index — Learning Hub

> **Who is this for?** Yourself — after a long break, re-onboarding, or reviewing architecture.
> All docs reflect the **current** codebase. If something is wrong, update it.

---

## Navigation

| Document                                                       | What it answers                                                      |
| -------------------------------------------------------------- | -------------------------------------------------------------------- |
| [`database.md`](./database.md)                                 | What tables exist, their columns, relationships, and key constraints |
| [`api.md`](./api.md)                                           | Every API endpoint — URL, method, request/response shape             |
| [`decisions/`](./decisions/)                                   | **WHY** major architectural decisions were made                      |
| [`guides/add-content.md`](./guides/add-content.md)             | How to add new lessons and exercises via YAML                        |
| [`guides/add-exercise-type.md`](./guides/add-exercise-type.md) | How to add a new exercise type to the registry                       |
| [`runbooks/local-dev.md`](./runbooks/local-dev.md)             | Full local dev setup (more detailed than README)                     |
| [`runbooks/migration.md`](./runbooks/migration.md)             | How to write and apply DB migrations safely                          |

---

## Architecture Summary

```
Browser → React Router loader → API Client (X-Session-Id) → Fastify → Repository → PostgreSQL
```

**Server** (Composition Root DI):

```
index.js → sql → repos → controllers → routes → Fastify app
```

**Key patterns**: Registry (exercises, sections), useReducer FSM (exercise flow),
React Router v7 loaders (no useEffect for data), Composition Root DI, AppError hierarchy.

See [`../.claude/CLAUDE.md`](../.claude/CLAUDE.md) for working agreement + anti-patterns.

---

## Current State (2026-03-01)

- **Schema**: v19 + migrations (exercise_review, learning_path, learning_path_step)
- **Content**: 44 topics, 48 categories, 124 lessons, 726 exercises
- **Tests**: ~206 unit/integration + 8 E2E Playwright
- **Stack**: React 19 + Vite 7 + MUI 7 + Fastify 5 + PostgreSQL 17 + postgres.js
