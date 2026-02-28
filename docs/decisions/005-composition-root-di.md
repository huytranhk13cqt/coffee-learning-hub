# ADR 005: Composition Root + Manual DI

**Date**: 2026-01
**Status**: Accepted

## Context

The backend needs a testable, maintainable dependency graph: `sql → repositories → controllers → routes`. The alternatives are: service locator (global imports), DI container (InversifyJS, tsyringe), or Composition Root (manual wiring).

## Decision

Composition Root pattern in `server/index.js`. All wiring is explicit and manual.

## Reasons

1. **Testability** — repositories and controllers receive their dependencies via constructor. Tests inject mocks directly.
2. **No magic** — no decorators, no reflection, no container config. The wiring is plain JavaScript that you can read linearly.
3. **No circular imports** — route files never import repositories directly. They receive a controller. This is enforced by the factory pattern.
4. **Simplicity** — a DI container (InversifyJS) would add ~50KB and require decorators or reflection. For 4 repositories and 4 controllers, that's over-engineering.

## Wiring in `server/index.js`

```js
const sql = postgres(config.database);

const repos = {
  category: new CategoryRepository(sql),
  lesson: new LessonRepository(sql),
  exercise: new ExerciseRepository(sql),
  progress: new ProgressRepository(sql),
  review: new ReviewRepository(sql),
  path: new LearningPathRepository(sql),
};

const controllers = {
  category: new CategoryController(repos.category, repos.lesson),
  lesson: new LessonController(repos.lesson),
  exercise: new ExerciseController(repos.exercise, repos.progress),
  progress: new ProgressController(repos.progress),
  review: new ReviewController(repos.review, repos.exercise),
  path: new LearningPathController(repos.path),
};

const app = createApp({ controllers, sql });
```

## Route Factory Pattern

```js
// routes/lessonRoutes.js — never imports repo directly
export default function lessonRoutes(controller) {
  return async function plugin(fastify) {
    fastify.get('/api/lessons/:slug', controller.getBySlug);
  };
}
```

## Consequences

- `+` No framework lock-in
- `+` Dead simple testing — `new LessonController({ findBySlug: vi.fn() })`
- `+` Linear, readable wiring — no magic resolution
- `-` Manual wiring means adding a dependency requires editing `index.js` explicitly
- `-` No lifecycle management (but not needed for this app's scale)
