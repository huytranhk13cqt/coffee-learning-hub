-- ============================================================================
-- MIGRATION 001: Optimize Indexes & Remove Unnecessary Database Objects
-- Date: 2026-02-07
-- Description: Xóa indexes thừa, xóa stored procedures (chuyển logic sang app),
--              giữ lại views cần thiết và triggers hợp lý
-- Idempotent: CÓ — an toàn chạy lại nhiều lần
-- ============================================================================

USE grammar_learning;

-- ----------------------------------------------------------------------------
-- STEP 0: Schema Version Tracking
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS schema_version (
    version     INT UNSIGNED    NOT NULL,
    description VARCHAR(255)    NOT NULL,
    applied_at  TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (version)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Kiểm tra xem migration này đã chạy chưa
-- Nếu đã chạy, INSERT IGNORE sẽ skip
INSERT IGNORE INTO schema_version (version, description)
VALUES (1, 'Optimize indexes, remove SPs, cleanup');


-- ============================================================================
-- PHẦN A: XÓA INDEXES THỪA
-- ============================================================================
-- Lý do: 46 indexes → ~28 indexes. Giảm write overhead mà KHÔNG ảnh hưởng reads.
-- Nguyên tắc: Xóa index nếu nó:
--   1. Covered bởi composite index khác (leftmost prefix rule)
--   2. Có cardinality quá thấp (boolean, enum 3 values)
--   3. Không có query nào thực sự sử dụng

-- Cú pháp an toàn: dùng IF EXISTS (MySQL 8.0 hỗ trợ)
-- Nếu index không tồn tại → skip, không lỗi

-- ---------------------------------------------------------------------------
-- formula: idx_formula_lesson covered bởi uq_formula_lesson_type(lesson_id, type)
-- ---------------------------------------------------------------------------
DROP INDEX idx_formula_lesson ON formula;
-- ↑ Nếu lỗi "Can't DROP; check that column/key exists" → đã xóa rồi, bỏ qua

-- formula: idx_formula_type có cardinality = 3 (affirmative/negative/interrogative)
DROP INDEX idx_formula_type ON formula;

-- ---------------------------------------------------------------------------
-- usage: idx_usage_lesson covered bởi idx_usage_lesson_order(lesson_id, order_index)
-- ---------------------------------------------------------------------------
DROP INDEX idx_usage_lesson ON `usage`;

-- ---------------------------------------------------------------------------
-- signal_word: idx_signal_word_category có cardinality = 5, luôn query kèm lesson_id
-- ---------------------------------------------------------------------------
DROP INDEX idx_signal_word_category ON signal_word;

-- ---------------------------------------------------------------------------
-- tip: idx_tip_category (6 values) và idx_tip_importance (3 values)
-- Cả hai đều không bao giờ filter riêng, luôn kèm lesson_id
-- ---------------------------------------------------------------------------
DROP INDEX idx_tip_category ON tip;
DROP INDEX idx_tip_importance ON tip;

-- ---------------------------------------------------------------------------
-- exercise: Nhiều single-column indexes bị covered bởi composite
-- idx_exercise_lesson_type_diff(lesson_id, type, difficulty) covers:
--   - idx_exercise_lesson (lesson_id)
--   - idx_exercise_type (type) — low cardinality
--   - idx_exercise_difficulty (difficulty) — low cardinality
-- idx_exercise_lesson_active(lesson_id, is_active) — từ schema_fixes, trùng
-- idx_exercise_active (boolean)
-- ---------------------------------------------------------------------------
DROP INDEX idx_exercise_lesson ON exercise;
DROP INDEX idx_exercise_type ON exercise;
DROP INDEX idx_exercise_difficulty ON exercise;
DROP INDEX idx_exercise_active ON exercise;
DROP INDEX idx_exercise_lesson_active ON exercise;

-- ---------------------------------------------------------------------------
-- user_progress: Indexes với low cardinality hoặc covered
-- ---------------------------------------------------------------------------
DROP INDEX idx_progress_status ON user_progress;
DROP INDEX idx_progress_lesson ON user_progress;
DROP INDEX idx_progress_last_access ON user_progress;

-- ---------------------------------------------------------------------------
-- exercise_attempt: Covered indexes
-- idx_attempt_session covered bởi idx_attempt_session_exercise(session_id, exercise_id)
-- idx_attempt_exercise — hiếm khi query exercise_id mà không kèm session_id
-- idx_attempt_created — không có analytics query nào dùng
-- idx_attempt_date_session — từ schema_fixes, không có query nào dùng
-- ---------------------------------------------------------------------------
DROP INDEX idx_attempt_session ON exercise_attempt;
DROP INDEX idx_attempt_exercise ON exercise_attempt;
DROP INDEX idx_attempt_created ON exercise_attempt;
DROP INDEX idx_attempt_date_session ON exercise_attempt;

-- ---------------------------------------------------------------------------
-- lesson_comparison: idx_comparison_both trùng với idx_comparison_lesson_1
-- (lesson_id_1 là leftmost prefix của cả hai)
-- ---------------------------------------------------------------------------
DROP INDEX idx_comparison_both ON lesson_comparison;

-- ---------------------------------------------------------------------------
-- lesson: idx_lesson_difficulty có cardinality = 3
-- ---------------------------------------------------------------------------
DROP INDEX idx_lesson_difficulty ON lesson;

-- ---------------------------------------------------------------------------
-- bookmark: idx_bookmark_lesson — luôn query kèm session_id
-- ---------------------------------------------------------------------------
DROP INDEX idx_bookmark_lesson ON bookmark;


-- ============================================================================
-- PHẦN B: XÓA STORED PROCEDURES
-- ============================================================================
-- Lý do: Logic chuyển sang Application Layer (Node.js)
-- Xem APPLICATION_QUERIES.sql cho các query thay thế

DROP PROCEDURE IF EXISTS sp_get_lesson_full;
DROP PROCEDURE IF EXISTS sp_update_exercise_progress;
DROP PROCEDURE IF EXISTS sp_get_session_progress;
DROP PROCEDURE IF EXISTS sp_get_lesson_exercises;
DROP PROCEDURE IF EXISTS sp_reset_lesson_progress;
DROP PROCEDURE IF EXISTS sp_get_lesson_comparisons;


-- ============================================================================
-- PHẦN C: XÓA FUNCTION KHÔNG CẦN
-- ============================================================================

-- fn_calc_completion_percent: tính ở frontend (JavaScript) dễ hơn
DROP FUNCTION IF EXISTS fn_calc_completion_percent;

-- fn_lesson_is_complete: GIỮ LẠI — hữu ích cho validation khi seed data


-- ============================================================================
-- PHẦN D: XÓA VIEWS KHÔNG CẦN
-- ============================================================================

-- v_exercise_summary: không có query nào từ app sử dụng
DROP VIEW IF EXISTS v_exercise_summary;

-- v_user_progress_overview: thay bằng query D4 trong APPLICATION_QUERIES.sql
DROP VIEW IF EXISTS v_user_progress_overview;

-- GIỮ LẠI:
-- v_lesson_summary — hữu ích cho homepage
-- v_lesson_comparisons — giải quyết bidirectional M:N
-- v_database_stats — hữu ích cho debug/admin


-- ============================================================================
-- PHẦN E: SỬA TRIGGER (NẾU CẦN)
-- ============================================================================

-- tr_progress_set_total: GIỮ — tự động set exercises_total khi INSERT
-- tr_progress_check_completion: GIỮ nhưng GHI CHÚ vấn đề tiềm ẩn
-- → Nếu admin thêm exercise SAU khi user bắt đầu, exercises_total không cập nhật
-- → Giải pháp lâu dài: check completion ở application layer thay vì trigger


-- ============================================================================
-- VERIFICATION: Kiểm tra kết quả
-- ============================================================================

-- Liệt kê tất cả indexes còn lại
SELECT
    TABLE_NAME,
    INDEX_NAME,
    GROUP_CONCAT(COLUMN_NAME ORDER BY SEQ_IN_INDEX) AS columns,
    NON_UNIQUE
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'grammar_learning'
GROUP BY TABLE_NAME, INDEX_NAME
ORDER BY TABLE_NAME, INDEX_NAME;

-- Liệt kê stored procedures còn lại (expected: 0)
SELECT ROUTINE_NAME, ROUTINE_TYPE
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = 'grammar_learning'
  AND ROUTINE_TYPE = 'PROCEDURE';

-- Liệt kê functions còn lại (expected: fn_lesson_is_complete)
SELECT ROUTINE_NAME, ROUTINE_TYPE
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = 'grammar_learning'
  AND ROUTINE_TYPE = 'FUNCTION';

-- Liệt kê views còn lại
SELECT TABLE_NAME
FROM information_schema.VIEWS
WHERE TABLE_SCHEMA = 'grammar_learning';

-- Liệt kê triggers còn lại
SELECT TRIGGER_NAME, EVENT_OBJECT_TABLE, ACTION_TIMING, EVENT_MANIPULATION
FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = 'grammar_learning';

-- Đếm tổng indexes
SELECT COUNT(DISTINCT INDEX_NAME) AS total_indexes
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'grammar_learning';
