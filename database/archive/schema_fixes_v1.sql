-- ============================================================================
-- SCHEMA FIXES & ENHANCEMENTS
-- Apply after schema.sql
-- ============================================================================

USE grammar_learning;

-- ============================================================================
-- FIX ISSUE B: Comparison View for Bidirectional Queries
-- ============================================================================

-- View to query comparisons from either lesson's perspective
CREATE VIEW v_lesson_comparisons AS
SELECT
    lc.id,
    lc.lesson_id_1 AS lesson_id,
    lc.lesson_id_2 AS compared_with_id,
    l2.name AS compared_with_name,
    l2.name_vi AS compared_with_name_vi,
    lc.aspect,
    lc.aspect_vi,
    lc.lesson_1_point AS this_lesson_point,
    lc.lesson_1_point_vi AS this_lesson_point_vi,
    lc.lesson_2_point AS other_lesson_point,
    lc.lesson_2_point_vi AS other_lesson_point_vi,
    lc.example_1 AS this_example,
    lc.example_1_vi AS this_example_vi,
    lc.example_2 AS other_example,
    lc.example_2_vi AS other_example_vi,
    lc.tip,
    lc.tip_vi,
    lc.order_index
FROM lesson_comparison lc
JOIN lesson l2 ON lc.lesson_id_2 = l2.id

UNION ALL

SELECT
    lc.id,
    lc.lesson_id_2 AS lesson_id,
    lc.lesson_id_1 AS compared_with_id,
    l1.name AS compared_with_name,
    l1.name_vi AS compared_with_name_vi,
    lc.aspect,
    lc.aspect_vi,
    lc.lesson_2_point AS this_lesson_point,
    lc.lesson_2_point_vi AS this_lesson_point_vi,
    lc.lesson_1_point AS other_lesson_point,
    lc.lesson_1_point_vi AS other_lesson_point_vi,
    lc.example_2 AS this_example,
    lc.example_2_vi AS this_example_vi,
    lc.example_1 AS other_example,
    lc.example_1_vi AS other_example_vi,
    lc.tip,
    lc.tip_vi,
    lc.order_index
FROM lesson_comparison lc
JOIN lesson l1 ON lc.lesson_id_1 = l1.id;


-- ============================================================================
-- ADDITIONAL INDEXES (Missing from original)
-- ============================================================================

-- For querying comparisons efficiently
CREATE INDEX idx_comparison_both ON lesson_comparison(lesson_id_1, lesson_id_2);

-- For date-based analytics on attempts
CREATE INDEX idx_attempt_date_session ON exercise_attempt(created_at, session_id);

-- For finding exercises by lesson and active status
CREATE INDEX idx_exercise_lesson_active ON exercise(lesson_id, is_active);


-- ============================================================================
-- SOFT DELETE SUPPORT (Optional - uncomment if needed)
-- ============================================================================

/*
-- Add soft delete to lesson
ALTER TABLE lesson ADD COLUMN deleted_at TIMESTAMP NULL DEFAULT NULL;
CREATE INDEX idx_lesson_deleted ON lesson(deleted_at);

-- Add soft delete to exercise
ALTER TABLE exercise ADD COLUMN deleted_at TIMESTAMP NULL DEFAULT NULL;
CREATE INDEX idx_exercise_deleted ON exercise(deleted_at);

-- Update view to exclude deleted
CREATE OR REPLACE VIEW v_lesson_summary AS
SELECT ... WHERE l.deleted_at IS NULL;
*/


-- ============================================================================
-- HELPER STORED PROCEDURES
-- ============================================================================

DELIMITER //

-- Get all comparisons for a specific lesson
CREATE PROCEDURE sp_get_lesson_comparisons(IN p_lesson_id INT UNSIGNED)
BEGIN
    SELECT * FROM v_lesson_comparisons
    WHERE lesson_id = p_lesson_id
    ORDER BY order_index;
END //


-- Get lesson progress for a session
CREATE PROCEDURE sp_get_session_progress(IN p_session_id VARCHAR(64))
BEGIN
    SELECT
        up.*,
        l.name AS lesson_name,
        l.name_vi AS lesson_name_vi,
        l.slug,
        g.name AS group_name,
        g.color AS group_color
    FROM user_progress up
    JOIN lesson l ON up.lesson_id = l.id
    JOIN tense_group g ON l.group_id = g.id
    WHERE up.session_id = p_session_id
    ORDER BY g.order_index, l.order_index;
END //


-- Get exercises for a lesson with options
CREATE PROCEDURE sp_get_lesson_exercises(
    IN p_lesson_id INT UNSIGNED,
    IN p_type VARCHAR(20),
    IN p_difficulty VARCHAR(10)
)
BEGIN
    SELECT
        e.*,
        (SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'id', eo.id,
                'label', eo.label,
                'content', eo.content,
                'content_vi', eo.content_vi,
                'is_correct', eo.is_correct,
                'explanation', eo.explanation
            )
        ) FROM exercise_option eo WHERE eo.exercise_id = e.id ORDER BY eo.order_index
        ) AS options,
        (SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'id', mp.id,
                'left_content', mp.left_content,
                'right_content', mp.right_content
            )
        ) FROM matching_pair mp WHERE mp.exercise_id = e.id ORDER BY mp.order_index
        ) AS matching_pairs
    FROM exercise e
    WHERE e.lesson_id = p_lesson_id
        AND e.is_active = TRUE
        AND (p_type IS NULL OR e.type = p_type)
        AND (p_difficulty IS NULL OR e.difficulty = p_difficulty)
    ORDER BY e.order_index;
END //


-- Reset user progress for a lesson
CREATE PROCEDURE sp_reset_lesson_progress(
    IN p_session_id VARCHAR(64),
    IN p_lesson_id INT UNSIGNED
)
BEGIN
    -- Delete attempts
    DELETE ea FROM exercise_attempt ea
    JOIN exercise e ON ea.exercise_id = e.id
    WHERE ea.session_id = p_session_id AND e.lesson_id = p_lesson_id;

    -- Reset progress
    UPDATE user_progress
    SET status = 'not_started',
        theory_completed = FALSE,
        theory_time_spent = 0,
        exercises_attempted = 0,
        exercises_correct = 0,
        current_score = 0,
        total_attempts = 0,
        total_time_spent = 0,
        last_position = NULL,
        completed_at = NULL
    WHERE session_id = p_session_id AND lesson_id = p_lesson_id;
END //

DELIMITER ;


-- ============================================================================
-- DATA VALIDATION FUNCTIONS
-- ============================================================================

DELIMITER //

-- Function to check if lesson has minimum required content
CREATE FUNCTION fn_lesson_is_complete(p_lesson_id INT UNSIGNED)
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_formula_count INT;
    DECLARE v_usage_count INT;
    DECLARE v_exercise_count INT;

    SELECT COUNT(*) INTO v_formula_count FROM formula WHERE lesson_id = p_lesson_id;
    SELECT COUNT(*) INTO v_usage_count FROM `usage` WHERE lesson_id = p_lesson_id;
    SELECT COUNT(*) INTO v_exercise_count FROM exercise WHERE lesson_id = p_lesson_id AND is_active = TRUE;

    -- Minimum: 1 formula, 1 usage, 3 exercises
    RETURN v_formula_count >= 1 AND v_usage_count >= 1 AND v_exercise_count >= 3;
END //


-- Function to calculate lesson completion percentage
CREATE FUNCTION fn_calc_completion_percent(
    p_theory_done BOOLEAN,
    p_exercises_done SMALLINT,
    p_exercises_total SMALLINT
)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE v_theory_weight DECIMAL(5,2) DEFAULT 30.00;
    DECLARE v_exercise_weight DECIMAL(5,2) DEFAULT 70.00;
    DECLARE v_percent DECIMAL(5,2);

    SET v_percent = 0;

    IF p_theory_done THEN
        SET v_percent = v_percent + v_theory_weight;
    END IF;

    IF p_exercises_total > 0 THEN
        SET v_percent = v_percent + (p_exercises_done / p_exercises_total * v_exercise_weight);
    END IF;

    RETURN ROUND(v_percent, 2);
END //

DELIMITER ;


-- ============================================================================
-- STATISTICS VIEW
-- ============================================================================

CREATE VIEW v_database_stats AS
SELECT
    (SELECT COUNT(*) FROM tense_group) AS total_groups,
    (SELECT COUNT(*) FROM lesson) AS total_lessons,
    (SELECT COUNT(*) FROM lesson WHERE is_published = TRUE) AS published_lessons,
    (SELECT COUNT(*) FROM formula) AS total_formulas,
    (SELECT COUNT(*) FROM `usage`) AS total_usages,
    (SELECT COUNT(*) FROM example) AS total_examples,
    (SELECT COUNT(*) FROM signal_word) AS total_signal_words,
    (SELECT COUNT(*) FROM tip) AS total_tips,
    (SELECT COUNT(*) FROM lesson_comparison) AS total_comparisons,
    (SELECT COUNT(*) FROM exercise WHERE is_active = TRUE) AS total_exercises,
    (SELECT COUNT(*) FROM exercise_option) AS total_options,
    (SELECT COUNT(DISTINCT session_id) FROM user_progress) AS total_users,
    (SELECT COUNT(*) FROM exercise_attempt) AS total_attempts;
