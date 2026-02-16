-- Migration 011: Add missing indexes on formula and signal_word tables
-- Date: 2026-02-17
-- Purpose: Cover the BFF parallel-query pattern in findFullBySlug().
--   Both formula and signal_word are queried via WHERE lesson_id = ?
--   but lack indexes, causing sequential scans during lesson page loads.
--
-- Also adds a composite index on signal_word for the common query pattern
-- that filters by lesson_id and orders by category + position.

BEGIN;

INSERT INTO schema_version (version, description)
VALUES (11, 'Add indexes on formula and signal_word for BFF lesson queries');

CREATE INDEX idx_formula_lesson ON formula(lesson_id, order_index);

CREATE INDEX idx_signal_word_lesson ON signal_word(lesson_id, category, position);

COMMIT;

-- Rollback:
-- BEGIN;
-- DROP INDEX IF EXISTS idx_formula_lesson;
-- DROP INDEX IF EXISTS idx_signal_word_lesson;
-- DELETE FROM schema_version WHERE version = 11;
-- COMMIT;
