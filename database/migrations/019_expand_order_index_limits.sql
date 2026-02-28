-- Migration 019: Expand order_index limits for 44+ topics and 48+ categories
-- Also widen category.name/name_vi from VARCHAR(50) to VARCHAR(100) for longer names
BEGIN;

ALTER TABLE topic DROP CONSTRAINT chk_topic_order;
ALTER TABLE topic ADD CONSTRAINT chk_topic_order CHECK (order_index >= 0 AND order_index <= 100);

ALTER TABLE category DROP CONSTRAINT chk_category_order;
ALTER TABLE category ADD CONSTRAINT chk_category_order CHECK (order_index >= 0 AND order_index <= 100);

-- Drop view that depends on category.name before altering column type
DROP VIEW IF EXISTS v_lesson_summary;

ALTER TABLE category ALTER COLUMN name TYPE VARCHAR(100);
ALTER TABLE category ALTER COLUMN name_vi TYPE VARCHAR(100);

-- Recreate the view (identical definition, now uses wider column)
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
VALUES (19, 'Expand order_index limits and category name length for large curriculum');

COMMIT;
