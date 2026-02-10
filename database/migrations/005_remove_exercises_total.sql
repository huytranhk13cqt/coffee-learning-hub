-- Migration 005: Remove exercises_total cached column, compute dynamically
-- Date: 2026-02-11
-- Purpose: Eliminate stale data from cached exercise count. The column was set
--   at INSERT time by a trigger and never updated — if exercises were added or
--   removed, the count became wrong. Now computed dynamically via subquery.

BEGIN;

INSERT INTO schema_version (version, description)
VALUES (5, 'Remove exercises_total cached column, compute dynamically');

-- 1. Drop CHECK that depends on exercises_total
ALTER TABLE user_progress DROP CONSTRAINT chk_progress_attempted;

-- 2. Rewrite completion trigger to compute exercise count dynamically
CREATE OR REPLACE FUNCTION fn_progress_check_completion()
RETURNS TRIGGER AS $$
DECLARE
    v_total INTEGER;
BEGIN
    SELECT COUNT(*)::int INTO v_total
    FROM exercise
    WHERE lesson_id = NEW.lesson_id AND is_active = TRUE;

    IF NEW.exercises_attempted >= v_total
       AND v_total > 0
       AND NEW.theory_completed = TRUE
       AND NEW.status != 'completed' THEN
        NEW.status := 'completed';
        NEW.completed_at := NOW();
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 3. Drop the set-total trigger (no longer needed)
DROP TRIGGER tr_progress_set_total ON user_progress;
DROP FUNCTION fn_progress_set_total;

-- 4. Drop the column
ALTER TABLE user_progress DROP COLUMN exercises_total;

COMMIT;

-- Rollback (if needed):
-- BEGIN;
-- ALTER TABLE user_progress ADD COLUMN exercises_total SMALLINT NOT NULL DEFAULT 0;
-- CREATE OR REPLACE FUNCTION fn_progress_set_total()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     NEW.exercises_total := (
--         SELECT COUNT(*)::int FROM exercise
--         WHERE lesson_id = NEW.lesson_id AND is_active = TRUE
--     );
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;
-- CREATE TRIGGER tr_progress_set_total
--   BEFORE INSERT ON user_progress
--   FOR EACH ROW EXECUTE FUNCTION fn_progress_set_total();
-- CREATE OR REPLACE FUNCTION fn_progress_check_completion()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     IF NEW.exercises_attempted >= NEW.exercises_total
--        AND NEW.exercises_total > 0
--        AND NEW.theory_completed = TRUE
--        AND NEW.status != 'completed' THEN
--         NEW.status := 'completed';
--         NEW.completed_at := NOW();
--     END IF;
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;
-- ALTER TABLE user_progress ADD CONSTRAINT chk_progress_attempted
--   CHECK (exercises_attempted <= exercises_total);
-- DELETE FROM schema_version WHERE version = 5;
-- COMMIT;
