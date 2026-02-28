# ADR 003: Fastify over Express

**Date**: 2025-12 (migration from Express)
**Status**: Accepted

## Context

Project started with Express.js (the default for Node.js APIs). As the codebase grew, pain points appeared: no schema validation, manual error handling, verbose middleware setup.

## Decision

Migrated to Fastify 5.

## Reasons

1. **JSON Schema validation built-in** — request bodies validated automatically via `schema` option on routes. No need for `joi`, `zod`, or `express-validator`.
2. **Error handler pattern** — `setErrorHandler` catches thrown errors globally. Controllers throw `AppError` subclasses; no try/catch needed at the controller layer.
3. **Performance** — Fastify is consistently 2–3x faster than Express in benchmarks due to its serialization engine and schema-aware JSON parsing.
4. **Plugin system** — `@fastify/helmet`, `@fastify/cors`, `@fastify/rate-limit` are first-class ecosystem plugins with zero config friction.
5. **TypeScript-friendly shape** — even without TypeScript, `reply.send()` vs `res.json()` feels intentional.

## Consequences

- `+` Request validation is declarative, not imperative
- `+` Error handling is centralized — no scattered try/catch
- `+` `fastify.inject()` enables integration testing without starting a real HTTP server
- `-` Plugin encapsulation model is non-obvious at first (scoped vs global plugins)
- `-` Smaller ecosystem than Express, some middleware not available

## Key Pattern

```js
// Controller just throws — Fastify catches
getBySlug = async (request, reply) => {
  const lesson = await this.lessonRepo.findBySlug(request.params.slug);
  if (!lesson) throw new NotFoundError('Lesson not found');
  return { data: lesson };
};
```
