-- Migration 007: Add production performance indexes
-- Date: 2026-02-14
-- Purpose: Cover the two most impactful unindexed query patterns identified
--   via systematic query-by-query analysis across all 4 repositories.
--
-- Index 1 (HIGH priority): Partial index on exercise for the dominant pattern
--   WHERE lesson_id = ? AND is_active = TRUE ORDER BY order_index
--   Used by 8+ code paths: findByLesson, findOptionsByLesson, findMatchingPairsByLesson,
--   findResultsByLesson, progress correlated subqueries, fn_progress_check_completion.
--
-- Index 2 (MEDIUM priority): Composite index on lesson for group-scoped queries
--   WHERE group_id = ? AND is_published = TRUE ORDER BY order_index
--   Used by: findByGroup (BFF sibling navigation), getDashboardOverview.

BEGIN;

INSERT INTO schema_version (version, description)
VALUES (7, 'Add partial exercise index and composite lesson index for production performance');

-- Partial index: only active exercises are ever queried by the application.
-- Covers lesson_id equality + order_index sort in a single scan.
CREATE INDEX idx_exercise_lesson_active_order
  ON exercise(lesson_id, order_index)
  WHERE is_active = TRUE;

-- Composite index: covers group_id equality + is_published filter + order_index sort.
-- Eliminates post-index filter and filesort for findByGroup and dashboard queries.
CREATE INDEX idx_lesson_group_published_order
  ON lesson(group_id, is_published, order_index);

COMMIT;

-- Rollback (if needed):
-- BEGIN;
-- DROP INDEX IF EXISTS idx_exercise_lesson_active_order;
-- DROP INDEX IF EXISTS idx_lesson_group_published_order;
-- DELETE FROM schema_version WHERE version = 7;
-- COMMIT;
