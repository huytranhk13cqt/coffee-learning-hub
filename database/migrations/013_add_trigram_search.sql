-- Migration 013: Add pg_trgm extension for fuzzy search
-- Date: 2026-02-17
-- Purpose: Enable trigram-based fuzzy search with typo tolerance and relevance
--   ranking. Current ILIKE search requires exact substring match — pg_trgm adds
--   word_similarity() for fuzzy matching and GIN indexes for ILIKE acceleration.
--
-- NOTE: CREATE EXTENSION must run outside the transaction because some
--   PostgreSQL configurations restrict DDL for extensions within transactions.

CREATE EXTENSION IF NOT EXISTS pg_trgm;

BEGIN;

INSERT INTO schema_version (version, description)
VALUES (13, 'Add pg_trgm extension and GIN indexes for fuzzy search');

-- GIN trigram indexes on lesson name columns
-- Supports: ILIKE '%pattern%', similarity(), word_similarity(), % and <% operators
CREATE INDEX idx_lesson_name_trgm ON lesson USING gin(name gin_trgm_ops);
CREATE INDEX idx_lesson_name_vi_trgm ON lesson USING gin(name_vi gin_trgm_ops);

COMMIT;

-- Rollback:
-- BEGIN;
-- DROP INDEX IF EXISTS idx_lesson_name_trgm;
-- DROP INDEX IF EXISTS idx_lesson_name_vi_trgm;
-- DELETE FROM schema_version WHERE version = 13;
-- COMMIT;
-- DROP EXTENSION IF EXISTS pg_trgm;
