-- Migration 004: Add missing indexes and unique constraint
-- Date: 2026-02-11
-- Purpose: Defense-in-depth for race conditions + query performance optimization

BEGIN;

INSERT INTO schema_version (version, description)
VALUES (4, 'Add missing indexes and unique constraint for exercise_attempt');

-- Defense-in-depth: app uses pg_advisory_xact_lock, this catches bugs
ALTER TABLE exercise_attempt
  ADD CONSTRAINT uq_attempt_session_exercise_number
  UNIQUE (session_id, exercise_id, attempt_number);

-- Optimize results query (covers WHERE + ORDER BY for findResultsByLesson)
CREATE INDEX idx_attempt_exercise_number
  ON exercise_attempt(exercise_id, session_id, attempt_number DESC);

-- Optimize dashboard query (covers LEFT JOIN in getDashboardOverview)
CREATE INDEX idx_progress_lesson_session
  ON user_progress(lesson_id, session_id);

COMMIT;

-- Rollback (if needed):
-- BEGIN;
-- DROP INDEX IF EXISTS idx_progress_lesson_session;
-- DROP INDEX IF EXISTS idx_attempt_exercise_number;
-- ALTER TABLE exercise_attempt DROP CONSTRAINT IF EXISTS uq_attempt_session_exercise_number;
-- DELETE FROM schema_version WHERE version = 4;
-- COMMIT;
