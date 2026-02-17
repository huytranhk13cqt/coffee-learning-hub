-- Migration 012: Optimize completion trigger with WHEN clause
-- Date: 2026-02-17
-- Purpose: The tr_progress_check_completion trigger currently fires on every
--   UPDATE to user_progress, even when irrelevant columns change (e.g. last_access).
--   Adding a WHEN clause restricts it to only fire when exercises_attempted or
--   theory_completed actually change — the only columns that can cause completion.
--   This avoids an unnecessary COUNT(*) query on the exercise table for most updates.

BEGIN;

INSERT INTO schema_version (version, description)
VALUES (12, 'Optimize completion trigger with WHEN clause');

-- Drop and recreate trigger with conditional WHEN clause
DROP TRIGGER IF EXISTS tr_progress_check_completion ON user_progress;

CREATE TRIGGER tr_progress_check_completion
  BEFORE UPDATE ON user_progress
  FOR EACH ROW
  WHEN (
    NEW.exercises_attempted IS DISTINCT FROM OLD.exercises_attempted
    OR NEW.theory_completed IS DISTINCT FROM OLD.theory_completed
  )
  EXECUTE FUNCTION fn_progress_check_completion();

COMMIT;

-- Rollback:
-- BEGIN;
-- DROP TRIGGER IF EXISTS tr_progress_check_completion ON user_progress;
-- CREATE TRIGGER tr_progress_check_completion
--   BEFORE UPDATE ON user_progress
--   FOR EACH ROW EXECUTE FUNCTION fn_progress_check_completion();
-- DELETE FROM schema_version WHERE version = 12;
-- COMMIT;
