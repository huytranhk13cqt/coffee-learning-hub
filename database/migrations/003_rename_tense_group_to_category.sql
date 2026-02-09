-- ============================================================================
-- MIGRATION 003: Rename tense_group → category
-- Purpose: Generalize app from "English Grammar" to multi-topic Learning Hub
-- Reversible: see rollback section at bottom
-- ============================================================================

BEGIN;

-- 1. Record migration
INSERT INTO schema_version (version, description)
VALUES (3, 'Rename tense_group to category (Learning Hub generalization)');

-- 2. Rename table
ALTER TABLE tense_group RENAME TO category;

-- 3. Rename constraints
ALTER TABLE category RENAME CONSTRAINT uq_tense_group_name TO uq_category_name;
ALTER TABLE category RENAME CONSTRAINT chk_tense_group_color TO chk_category_color;
ALTER TABLE category RENAME CONSTRAINT chk_tense_group_order TO chk_category_order;

-- 4. Rename index
ALTER INDEX idx_tense_group_order RENAME TO idx_category_order;

-- 5. Recreate trigger (PostgreSQL cannot rename triggers)
DROP TRIGGER trg_tense_group_updated_at ON category;
CREATE TRIGGER trg_category_updated_at
  BEFORE UPDATE ON category
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- 6. Rename foreign key on lesson table
ALTER TABLE lesson RENAME CONSTRAINT fk_lesson_group TO fk_lesson_category;

-- 7. Update column comments to be topic-neutral
COMMENT ON COLUMN lesson_comparison.lesson_id_1 IS 'First lesson (smaller ID)';
COMMENT ON COLUMN lesson_comparison.lesson_id_2 IS 'Second lesson (larger ID)';

-- 8. Recreate views that reference tense_group

DROP VIEW IF EXISTS v_lesson_summary;
CREATE VIEW v_lesson_summary AS
SELECT
    l.id,
    l.name,
    l.name_vi,
    l.slug,
    l.short_desc,
    l.short_desc_vi,
    l.difficulty,
    l.estimated_time,
    l.order_index AS lesson_order,
    l.is_published,
    g.id AS group_id,
    g.name AS group_name,
    g.name_vi AS group_name_vi,
    g.color AS group_color,
    g.icon AS group_icon,
    g.order_index AS group_order,
    (SELECT COUNT(*)::int FROM formula f WHERE f.lesson_id = l.id) AS formula_count,
    (SELECT COUNT(*)::int FROM lesson_usage u WHERE u.lesson_id = l.id) AS usage_count,
    (SELECT COUNT(*)::int FROM signal_word sw WHERE sw.lesson_id = l.id) AS signal_word_count,
    (SELECT COUNT(*)::int FROM tip t WHERE t.lesson_id = l.id) AS tip_count,
    (SELECT COUNT(*)::int FROM exercise e WHERE e.lesson_id = l.id AND e.is_active = TRUE) AS exercise_count
FROM lesson l
JOIN category g ON l.group_id = g.id
ORDER BY g.order_index, l.order_index;

DROP VIEW IF EXISTS v_database_stats;
CREATE VIEW v_database_stats AS
SELECT
    (SELECT COUNT(*)::int FROM category) AS total_groups,
    (SELECT COUNT(*)::int FROM lesson) AS total_lessons,
    (SELECT COUNT(*)::int FROM lesson WHERE is_published = TRUE) AS published_lessons,
    (SELECT COUNT(*)::int FROM formula) AS total_formulas,
    (SELECT COUNT(*)::int FROM lesson_usage) AS total_usages,
    (SELECT COUNT(*)::int FROM example) AS total_examples,
    (SELECT COUNT(*)::int FROM signal_word) AS total_signal_words,
    (SELECT COUNT(*)::int FROM tip) AS total_tips,
    (SELECT COUNT(*)::int FROM lesson_comparison) AS total_comparisons,
    (SELECT COUNT(*)::int FROM exercise WHERE is_active = TRUE) AS total_exercises,
    (SELECT COUNT(*)::int FROM exercise_option) AS total_options,
    (SELECT COUNT(DISTINCT session_id)::int FROM user_progress) AS total_users,
    (SELECT COUNT(*)::int FROM exercise_attempt) AS total_attempts;

-- 9. Update fn_lesson_is_complete: remove formula requirement
--    Non-grammar topics (math, coding, etc.) won't have formulas
CREATE OR REPLACE FUNCTION fn_lesson_is_complete(p_lesson_id INTEGER)
RETURNS BOOLEAN
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
    v_usage_count    INTEGER;
    v_exercise_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_usage_count    FROM lesson_usage WHERE lesson_id = p_lesson_id;
    SELECT COUNT(*) INTO v_exercise_count FROM exercise WHERE lesson_id = p_lesson_id AND is_active = TRUE;

    -- Minimum: 1 usage, 3 exercises (formulas are optional — grammar-specific)
    RETURN v_usage_count >= 1 AND v_exercise_count >= 3;
END;
$$;

COMMIT;

-- ============================================================================
-- ROLLBACK (run manually if needed — NOT part of the migration)
-- ============================================================================
-- BEGIN;
-- ALTER TABLE category RENAME TO tense_group;
-- ALTER TABLE tense_group RENAME CONSTRAINT uq_category_name TO uq_tense_group_name;
-- ALTER TABLE tense_group RENAME CONSTRAINT chk_category_color TO chk_tense_group_color;
-- ALTER TABLE tense_group RENAME CONSTRAINT chk_category_order TO chk_tense_group_order;
-- ALTER INDEX idx_category_order RENAME TO idx_tense_group_order;
-- DROP TRIGGER trg_category_updated_at ON tense_group;
-- CREATE TRIGGER trg_tense_group_updated_at
--   BEFORE UPDATE ON tense_group
--   FOR EACH ROW EXECUTE FUNCTION update_updated_at();
-- ALTER TABLE lesson RENAME CONSTRAINT fk_lesson_category TO fk_lesson_group;
-- COMMENT ON COLUMN lesson_comparison.lesson_id_1 IS 'First tense (smaller ID)';
-- COMMENT ON COLUMN lesson_comparison.lesson_id_2 IS 'Second tense (larger ID)';
-- (then recreate views with tense_group table name)
-- DELETE FROM schema_version WHERE version = 3;
-- COMMIT;
