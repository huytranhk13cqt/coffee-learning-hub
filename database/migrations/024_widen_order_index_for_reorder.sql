-- Migration 024: Widen order_index constraints for gap-based reorder
-- Removes upper-bound CHECK on topic/category order_index to support gap reorder (gaps of 1000).
-- Changes SMALLINT → INTEGER for topic.order_index and category.order_index.
-- Must drop/recreate v_lesson_summary which depends on category.order_index.
-- ============================================================================

BEGIN;

-- 0. Drop dependent view (references category.order_index and lesson.order_index)
DROP VIEW IF EXISTS v_lesson_summary;

-- 1. Topic: drop old constraint, widen column, add new constraint
ALTER TABLE topic DROP CONSTRAINT IF EXISTS chk_topic_order;
ALTER TABLE topic ALTER COLUMN order_index TYPE INTEGER;
ALTER TABLE topic ADD CONSTRAINT chk_topic_order CHECK (order_index >= 0);

-- 2. Category: drop old constraint, widen column, add new constraint
ALTER TABLE category DROP CONSTRAINT IF EXISTS chk_category_order;
ALTER TABLE category ALTER COLUMN order_index TYPE INTEGER;
ALTER TABLE category ADD CONSTRAINT chk_category_order CHECK (order_index >= 0);

-- 3. Lesson: already INTEGER-compatible, just ensure no upper bound
-- lesson.order_index already has: CHECK (order_index >= 0) — no change needed

-- 4. lesson_section.order_index: widen for gap reorder
ALTER TABLE lesson_section ALTER COLUMN order_index TYPE INTEGER;

-- 5. Recreate the dependent view
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

INSERT INTO schema_version (version, description)
VALUES (24, 'Widen order_index for gap-based drag-and-drop reorder');

COMMIT;
