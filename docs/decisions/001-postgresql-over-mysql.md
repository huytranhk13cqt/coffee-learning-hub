# ADR 001: PostgreSQL over MySQL

**Date**: 2025-12 (migrated from MySQL mid-project)
**Status**: Accepted

## Context

Project originally started with MySQL 8.0 + Express.js. During generalization to multi-subject Learning Hub, the search requirements grew (fuzzy search across lesson names/descriptions) and the schema needed richer types (JSONB for word_bank, metadata).

## Decision

Migrated to PostgreSQL 17.

## Reasons

1. **`pg_trgm` extension** — trigram-based fuzzy search (`word_similarity`, GIN indexes) with no external search service. Essential for lesson search UX.
2. **Full-text search** — `to_tsvector` + `plainto_tsquery` + `ts_rank` + GIN indexes give ranked results without Elasticsearch.
3. **JSONB** — native JSON with operators, used for `exercise.word_bank`, `lesson_section.metadata`, interactive chart configs.
4. **`postgres.js` DX** — tagged template literals with automatic parameterization. Safer and cleaner than `mysql2`.
5. **Generated expressions** — `to_tsvector` as index expression (avoids stale stored column).
6. **Advisory locks** — `pg_advisory_xact_lock` for `getNextAttemptNumber` race condition guard.

## Consequences

- `+` No external search service (Elasticsearch/Algolia) needed
- `+` JSONB eliminates several join tables
- `+` Better tooling (`psql`, `pgAdmin`, `pg_stat_statements`)
- `-` MySQL-familiar syntax knowledge doesn't transfer directly (SERIAL vs AUTO_INCREMENT, `~` vs REGEXP)
- `-` `ALTER TYPE ... ADD VALUE` cannot run inside `BEGIN/COMMIT` — constraint on migration design
