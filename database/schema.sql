SET NAMES utf8mb4;

-- ============================================================================
-- DATABASE SCHEMA: Grammar Learning Application
-- Version: 2.0.0 (Optimized — merged from v1.0 schema + fixes + analysis)
-- MySQL: 8.0+
-- Charset: utf8mb4 (hỗ trợ tiếng Việt, emoji)
--
-- Thay đổi so với v1.0:
--   - Indexes: 46 → 27 (xóa 19 indexes thừa/low-cardinality)
--   - Stored Procedures: 6 → 0 (logic chuyển sang application layer)
--   - Functions: 2 → 1 (giữ fn_lesson_is_complete, xóa fn_calc_completion_percent)
--   - Views: 5 → 3 (xóa v_exercise_summary, v_user_progress_overview)
--   - Triggers: 2 → 2 (giữ nguyên)
--   - Thêm: schema_version table (migration tracking)
--   - Xóa: is_premium column (không enforce được khi không có auth)
--
-- Xem thêm: DATABASE_ANALYSIS.md (phân tích 19 mục)
--           APPLICATION_QUERIES.sql (tất cả queries ứng dụng sẽ dùng)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- DATABASE CREATION
-- ----------------------------------------------------------------------------
DROP DATABASE IF EXISTS grammar_learning;
CREATE DATABASE grammar_learning
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE grammar_learning;


-- ============================================================================
-- TABLE 0: schema_version
-- Purpose: Theo dõi version của database schema (migration tracking)
-- ============================================================================
CREATE TABLE schema_version (
    version     INT UNSIGNED    NOT NULL,
    description VARCHAR(255)    NOT NULL,
    applied_at  TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (version)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Track schema migrations';

INSERT INTO schema_version (version, description) VALUES
(1, 'Initial optimized schema (v2.0 — merged from v1.0 + analysis)');


-- ============================================================================
-- TABLE 1: tense_group
-- Purpose: Nhóm thì theo khung thời gian (Present, Past, Future)
-- Rows dự kiến: ~3-5 (static)
-- ============================================================================
CREATE TABLE tense_group (
    id              INT UNSIGNED        NOT NULL AUTO_INCREMENT,
    name            VARCHAR(50)         NOT NULL,
    name_vi         VARCHAR(50)         NOT NULL,
    description     TEXT                NULL,
    description_vi  TEXT                NULL,
    icon            VARCHAR(50)         NULL        COMMENT 'MUI icon name',
    color           VARCHAR(7)          NOT NULL    DEFAULT '#6366f1',
    order_index     TINYINT UNSIGNED    NOT NULL    DEFAULT 0,
    created_at      TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    CONSTRAINT uq_tense_group_name UNIQUE (name),
    CONSTRAINT chk_tense_group_color CHECK (color REGEXP '^#[0-9A-Fa-f]{6}$'),
    CONSTRAINT chk_tense_group_order CHECK (order_index <= 10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Groups of tenses by time frame';

-- Indexes: 1 (ngoài PK + UNIQUE)
CREATE INDEX idx_tense_group_order ON tense_group(order_index);


-- ============================================================================
-- TABLE 2: lesson
-- Purpose: Từng bài học cho mỗi thì
-- Rows dự kiến: ~12-20
-- Thay đổi: Xóa is_premium (không enforce được khi không có auth)
--           Xóa idx_lesson_difficulty (low cardinality, 3 values)
-- ============================================================================
CREATE TABLE lesson (
    id              INT UNSIGNED        NOT NULL AUTO_INCREMENT,
    group_id        INT UNSIGNED        NOT NULL,
    name            VARCHAR(100)        NOT NULL,
    name_vi         VARCHAR(100)        NOT NULL,
    slug            VARCHAR(100)        NOT NULL,
    short_desc      VARCHAR(255)        NULL        COMMENT 'Brief description for cards',
    short_desc_vi   VARCHAR(255)        NULL,
    description     TEXT                NULL        COMMENT 'Full introduction',
    description_vi  TEXT                NULL,
    difficulty      ENUM('beginner', 'intermediate', 'advanced')
                                        NOT NULL    DEFAULT 'beginner',
    estimated_time  SMALLINT UNSIGNED   NULL        COMMENT 'Estimated study time in minutes',
    order_index     TINYINT UNSIGNED    NOT NULL    DEFAULT 0,
    is_published    BOOLEAN             NOT NULL    DEFAULT TRUE,
    created_at      TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    CONSTRAINT uq_lesson_name UNIQUE (name),
    CONSTRAINT uq_lesson_slug UNIQUE (slug),
    CONSTRAINT fk_lesson_group
        FOREIGN KEY (group_id) REFERENCES tense_group(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Individual grammar lessons for each tense';

-- Indexes: 2 (ngoài PK + 2 UNIQUE)
-- idx_lesson_group: Query A3 (lấy lessons theo group)
-- idx_lesson_published: Query A2 (lấy lessons đã published, ORDER BY order_index)
CREATE INDEX idx_lesson_group ON lesson(group_id);
CREATE INDEX idx_lesson_published ON lesson(is_published, order_index);
-- XÓA: idx_lesson_difficulty (cardinality=3, không filter riêng — xem DATABASE_ANALYSIS.md mục 2)


-- ============================================================================
-- TABLE 3: formula
-- Purpose: Công thức ngữ pháp cho mỗi thì (+, -, ?)
-- Rows dự kiến: ~36-60
-- Thay đổi: Xóa idx_formula_lesson (covered bởi uq_formula_lesson_type)
--           Xóa idx_formula_type (cardinality=3)
-- ============================================================================
CREATE TABLE formula (
    id              INT UNSIGNED        NOT NULL AUTO_INCREMENT,
    lesson_id       INT UNSIGNED        NOT NULL,
    type            ENUM('affirmative', 'negative', 'interrogative')
                                        NOT NULL    COMMENT '+, -, ?',
    subject_note    VARCHAR(150)        NULL        COMMENT 'Notes about subject (I/you/we vs he/she/it)',
    structure       VARCHAR(255)        NOT NULL    COMMENT 'Formula structure in English',
    structure_vi    VARCHAR(255)        NULL        COMMENT 'Formula explanation in Vietnamese',
    example         VARCHAR(255)        NOT NULL    COMMENT 'Example sentence',
    example_vi      VARCHAR(255)        NULL        COMMENT 'Vietnamese translation',
    example_negative VARCHAR(255)       NULL        COMMENT 'Negative form of example (if affirmative)',
    note            TEXT                NULL        COMMENT 'Additional notes',
    order_index     TINYINT UNSIGNED    NOT NULL    DEFAULT 0,
    created_at      TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    CONSTRAINT uq_formula_lesson_type UNIQUE (lesson_id, type),
    CONSTRAINT fk_formula_lesson
        FOREIGN KEY (lesson_id) REFERENCES lesson(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Grammar formulas for affirmative, negative, interrogative forms';

-- Indexes: 0 (ngoài PK + UNIQUE)
-- uq_formula_lesson_type(lesson_id, type) đã cover query B2 (WHERE lesson_id = ?)
-- XÓA: idx_formula_lesson (covered bởi uq — leftmost prefix rule)
-- XÓA: idx_formula_type (cardinality=3, luôn kèm lesson_id)


-- ============================================================================
-- TABLE 4: lesson_usage
-- Purpose: Các cách dùng / ngữ cảnh cho mỗi thì
-- Rows dự kiến: ~60-100
-- Thay đổi: ĐỔI TÊN từ `usage` → `lesson_usage`
--           (usage là MySQL reserved word, gây phiền phức với backticks)
--           Xóa idx_usage_lesson (covered bởi idx_lesson_usage_lesson_order)
-- ============================================================================
CREATE TABLE lesson_usage (
    id              INT UNSIGNED        NOT NULL AUTO_INCREMENT,
    lesson_id       INT UNSIGNED        NOT NULL,
    title           VARCHAR(150)        NOT NULL    COMMENT 'Usage title in English',
    title_vi        VARCHAR(150)        NULL        COMMENT 'Usage title in Vietnamese',
    description     TEXT                NOT NULL    COMMENT 'Detailed explanation',
    description_vi  TEXT                NULL,
    icon            VARCHAR(50)         NULL        COMMENT 'MUI icon for visual',
    is_common       BOOLEAN             NOT NULL    DEFAULT TRUE COMMENT 'Is this a common usage?',
    order_index     TINYINT UNSIGNED    NOT NULL    DEFAULT 0,
    created_at      TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    CONSTRAINT fk_lesson_usage_lesson
        FOREIGN KEY (lesson_id) REFERENCES lesson(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Different usage contexts for each tense';

-- Indexes: 1 (ngoài PK)
-- Composite index covers cả filter (lesson_id) VÀ sort (order_index)
CREATE INDEX idx_lesson_usage_lesson_order ON lesson_usage(lesson_id, order_index);
-- XÓA: idx_usage_lesson (covered bởi composite — leftmost prefix rule)


-- ============================================================================
-- TABLE 5: example
-- Purpose: Câu ví dụ cho mỗi usage
-- Rows dự kiến: ~180-300
-- ============================================================================
CREATE TABLE example (
    id              INT UNSIGNED        NOT NULL AUTO_INCREMENT,
    usage_id        INT UNSIGNED        NOT NULL,
    sentence        VARCHAR(500)        NOT NULL    COMMENT 'Example sentence in English',
    sentence_vi     VARCHAR(500)        NULL        COMMENT 'Vietnamese translation',
    explanation     TEXT                NULL        COMMENT 'Grammar explanation',
    explanation_vi  TEXT                NULL,
    highlight_word  VARCHAR(100)        NULL        COMMENT 'Word(s) to highlight in sentence',
    highlight_start INT UNSIGNED        NULL        COMMENT 'Start position of highlight',
    highlight_end   INT UNSIGNED        NULL        COMMENT 'End position of highlight',
    audio_url       VARCHAR(255)        NULL        COMMENT 'URL to audio file (không lưu binary)',
    order_index     TINYINT UNSIGNED    NOT NULL    DEFAULT 0,
    created_at      TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    CONSTRAINT fk_example_usage
        FOREIGN KEY (usage_id) REFERENCES lesson_usage(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_example_highlight
        CHECK (
            (highlight_start IS NULL AND highlight_end IS NULL) OR
            (highlight_start IS NOT NULL AND highlight_end IS NOT NULL AND highlight_start < highlight_end)
        )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Example sentences illustrating each usage';

-- Indexes: 1 (ngoài PK)
CREATE INDEX idx_example_usage ON example(usage_id);


-- ============================================================================
-- TABLE 6: signal_word
-- Purpose: Dấu hiệu nhận biết thì (signal words/phrases)
-- Rows dự kiến: ~120-200
-- Thay đổi: Xóa idx_signal_word_category (cardinality=5, luôn kèm lesson_id)
-- ============================================================================
CREATE TABLE signal_word (
    id              INT UNSIGNED        NOT NULL AUTO_INCREMENT,
    lesson_id       INT UNSIGNED        NOT NULL,
    word            VARCHAR(100)        NOT NULL    COMMENT 'Signal word/phrase',
    word_vi         VARCHAR(100)        NULL        COMMENT 'Vietnamese meaning',
    category        ENUM('time', 'frequency', 'duration', 'sequence', 'other')
                                        NOT NULL    DEFAULT 'time',
    example_sentence VARCHAR(255)       NULL        COMMENT 'Example using this signal word',
    example_vi      VARCHAR(255)        NULL,
    position        ENUM('beginning', 'middle', 'end', 'flexible')
                                        NOT NULL    DEFAULT 'flexible'
                                        COMMENT 'Typical position in sentence',
    note            VARCHAR(255)        NULL        COMMENT 'Usage notes',
    order_index     TINYINT UNSIGNED    NOT NULL    DEFAULT 0,
    created_at      TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    CONSTRAINT uq_signal_word_lesson_word UNIQUE (lesson_id, word),
    CONSTRAINT fk_signal_word_lesson
        FOREIGN KEY (lesson_id) REFERENCES lesson(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Signal words indicating when to use each tense';

-- Indexes: 0 (ngoài PK + UNIQUE)
-- uq_signal_word_lesson_word(lesson_id, word) đã cover query B4 (WHERE lesson_id = ?)
-- XÓA: idx_signal_word_lesson (covered bởi uq — leftmost prefix rule)
-- XÓA: idx_signal_word_category (cardinality=5, luôn kèm lesson_id)


-- ============================================================================
-- TABLE 7: tip
-- Purpose: Mẹo ghi nhớ, lỗi thường gặp
-- Rows dự kiến: ~48-80
-- Thay đổi: Xóa idx_tip_category (cardinality=6)
--           Xóa idx_tip_importance (cardinality=3)
-- ============================================================================
CREATE TABLE tip (
    id              INT UNSIGNED        NOT NULL AUTO_INCREMENT,
    lesson_id       INT UNSIGNED        NOT NULL,
    title           VARCHAR(150)        NULL        COMMENT 'Tip title (optional)',
    title_vi        VARCHAR(150)        NULL,
    content         TEXT                NOT NULL    COMMENT 'Tip content',
    content_vi      TEXT                NULL,
    category        ENUM('memory', 'common_mistake', 'comparison', 'native_usage', 'shortcut', 'general')
                                        NOT NULL    DEFAULT 'general',
    importance      ENUM('low', 'medium', 'high')
                                        NOT NULL    DEFAULT 'medium',
    icon            VARCHAR(50)         NULL        COMMENT 'MUI icon name',
    order_index     TINYINT UNSIGNED    NOT NULL    DEFAULT 0,
    created_at      TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    CONSTRAINT fk_tip_lesson
        FOREIGN KEY (lesson_id) REFERENCES lesson(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Learning tips, memory tricks, and common mistakes';

-- Indexes: 1 (ngoài PK)
CREATE INDEX idx_tip_lesson ON tip(lesson_id);
-- XÓA: idx_tip_category (cardinality=6, luôn kèm lesson_id)
-- XÓA: idx_tip_importance (cardinality=3, không filter riêng)


-- ============================================================================
-- TABLE 8: lesson_comparison
-- Purpose: So sánh giữa hai thì (M:N self-referencing)
-- Rows dự kiến: ~30-50
-- Thay đổi: Xóa idx_comparison_both (trùng với idx_comparison_lesson_1)
-- ============================================================================
CREATE TABLE lesson_comparison (
    id              INT UNSIGNED        NOT NULL AUTO_INCREMENT,
    lesson_id_1     INT UNSIGNED        NOT NULL    COMMENT 'First tense (smaller ID)',
    lesson_id_2     INT UNSIGNED        NOT NULL    COMMENT 'Second tense (larger ID)',
    aspect          VARCHAR(100)        NOT NULL    COMMENT 'Aspect being compared',
    aspect_vi       VARCHAR(100)        NULL,
    lesson_1_point  TEXT                NOT NULL    COMMENT 'How lesson 1 handles this aspect',
    lesson_1_point_vi TEXT              NULL,
    lesson_2_point  TEXT                NOT NULL    COMMENT 'How lesson 2 handles this aspect',
    lesson_2_point_vi TEXT              NULL,
    example_1       VARCHAR(300)        NULL        COMMENT 'Example for lesson 1',
    example_1_vi    VARCHAR(300)        NULL,
    example_2       VARCHAR(300)        NULL        COMMENT 'Example for lesson 2',
    example_2_vi    VARCHAR(300)        NULL,
    tip             TEXT                NULL        COMMENT 'Tip to distinguish between them',
    tip_vi          TEXT                NULL,
    order_index     TINYINT UNSIGNED    NOT NULL    DEFAULT 0,
    created_at      TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    CONSTRAINT uq_comparison_pair_aspect UNIQUE (lesson_id_1, lesson_id_2, aspect),
    CONSTRAINT fk_comparison_lesson_1
        FOREIGN KEY (lesson_id_1) REFERENCES lesson(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_comparison_lesson_2
        FOREIGN KEY (lesson_id_2) REFERENCES lesson(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    -- NOTE: CHECK (lesson_id_1 < lesson_id_2) removed — MySQL 8.0 bug #3823:
    -- columns in FK with ON DELETE/UPDATE cannot also be in CHECK constraint.
    -- Enforced via triggers tr_comparison_order_insert/update below.
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Comparisons between pairs of tenses';

-- Indexes: 2 (ngoài PK + UNIQUE)
-- Cần cả 2 vì view v_lesson_comparisons query cả 2 chiều
CREATE INDEX idx_comparison_lesson_1 ON lesson_comparison(lesson_id_1);
CREATE INDEX idx_comparison_lesson_2 ON lesson_comparison(lesson_id_2);
-- XÓA: idx_comparison_both (lesson_id_1 đã là prefix của idx_comparison_lesson_1 VÀ uq)


-- ============================================================================
-- TABLE 9: exercise
-- Purpose: Bài tập luyện tập cho mỗi lesson
-- Rows dự kiến: ~200-500
-- Thay đổi: Chỉ giữ 1 composite index thay vì 5 single-column indexes
-- ============================================================================
CREATE TABLE exercise (
    id              INT UNSIGNED        NOT NULL AUTO_INCREMENT,
    lesson_id       INT UNSIGNED        NOT NULL,
    type            ENUM('multiple_choice', 'fill_blank', 'error_correction',
                         'sentence_transform', 'arrange_words', 'matching', 'true_false')
                                        NOT NULL,
    difficulty      ENUM('easy', 'medium', 'hard')
                                        NOT NULL    DEFAULT 'medium',
    question        TEXT                NOT NULL    COMMENT 'Question or instruction',
    question_vi     TEXT                NULL,
    context         TEXT                NULL        COMMENT 'Context or scenario (if needed)',
    context_vi      TEXT                NULL,
    content         TEXT                NULL        COMMENT 'Main content (sentence for fill_blank, error_correction, etc.)',
    content_vi      TEXT                NULL,
    correct_answer  VARCHAR(500)        NULL        COMMENT 'Correct answer (API KHÔNG trả về trước khi submit)',
    word_bank       JSON                NULL        COMMENT 'Words to arrange (JSON array)',
    explanation     TEXT                NULL        COMMENT 'Why this is the answer',
    explanation_vi  TEXT                NULL,
    hint            VARCHAR(255)        NULL        COMMENT 'Hint for the student',
    hint_vi         VARCHAR(255)        NULL,
    points          TINYINT UNSIGNED    NOT NULL    DEFAULT 10,
    time_limit      SMALLINT UNSIGNED   NULL        COMMENT 'Time limit in seconds (optional)',
    order_index     SMALLINT UNSIGNED   NOT NULL    DEFAULT 0,
    is_active       BOOLEAN             NOT NULL    DEFAULT TRUE,
    created_at      TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    CONSTRAINT fk_exercise_lesson
        FOREIGN KEY (lesson_id) REFERENCES lesson(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_exercise_points CHECK (points > 0 AND points <= 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Practice exercises for each lesson';

-- Indexes: 1 composite (ngoài PK) — thay thế 5 single-column indexes cũ
-- Composite index (lesson_id, type, difficulty) covers:
--   Query C1: WHERE lesson_id = ? AND is_active = TRUE (dùng lesson_id prefix)
--   Query F2: WHERE lesson_id = ? AND type = ? AND difficulty = ?
-- MySQL sử dụng leftmost prefix rule → 1 index phục vụ nhiều query patterns
CREATE INDEX idx_exercise_lesson_type_diff ON exercise(lesson_id, type, difficulty);
-- XÓA: idx_exercise_lesson (covered bởi composite)
-- XÓA: idx_exercise_type (cardinality=7, luôn kèm lesson_id)
-- XÓA: idx_exercise_difficulty (cardinality=3, luôn kèm lesson_id)
-- XÓA: idx_exercise_active (boolean, luôn kèm lesson_id)
-- XÓA: idx_exercise_lesson_active (covered bởi composite)


-- ============================================================================
-- TABLE 10: exercise_option
-- Purpose: Các lựa chọn cho bài multiple choice
-- Rows dự kiến: ~800-2000
-- ============================================================================
CREATE TABLE exercise_option (
    id              INT UNSIGNED        NOT NULL AUTO_INCREMENT,
    exercise_id     INT UNSIGNED        NOT NULL,
    label           CHAR(1)             NOT NULL    COMMENT 'Option label (A, B, C, D)',
    content         VARCHAR(500)        NOT NULL    COMMENT 'Option content',
    content_vi      VARCHAR(500)        NULL,
    is_correct      BOOLEAN             NOT NULL    DEFAULT FALSE
                                        COMMENT 'API KHÔNG trả về trước khi submit',
    explanation     TEXT                NULL        COMMENT 'Why this is right/wrong',
    explanation_vi  TEXT                NULL,
    order_index     TINYINT UNSIGNED    NOT NULL    DEFAULT 0,

    PRIMARY KEY (id),
    CONSTRAINT uq_option_exercise_label UNIQUE (exercise_id, label),
    CONSTRAINT fk_option_exercise
        FOREIGN KEY (exercise_id) REFERENCES exercise(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_option_label CHECK (label IN ('A', 'B', 'C', 'D', 'E', 'F'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Options for multiple choice exercises';

-- Indexes: 0 (ngoài PK + UNIQUE)
-- uq_option_exercise_label(exercise_id, label) đã cover query C2 (WHERE exercise_id IN ...)
-- XÓA: idx_option_exercise (covered bởi uq — leftmost prefix rule)


-- ============================================================================
-- TABLE 11: matching_pair
-- Purpose: Các cặp nối cho bài matching
-- Rows dự kiến: ~100-300
-- ============================================================================
CREATE TABLE matching_pair (
    id              INT UNSIGNED        NOT NULL AUTO_INCREMENT,
    exercise_id     INT UNSIGNED        NOT NULL,
    left_content    VARCHAR(300)        NOT NULL    COMMENT 'Left side content',
    left_content_vi VARCHAR(300)        NULL,
    right_content   VARCHAR(300)        NOT NULL    COMMENT 'Right side content (matching)',
    right_content_vi VARCHAR(300)       NULL,
    order_index     TINYINT UNSIGNED    NOT NULL    DEFAULT 0,

    PRIMARY KEY (id),
    CONSTRAINT fk_matching_pair_exercise
        FOREIGN KEY (exercise_id) REFERENCES exercise(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Matching pairs for matching type exercises';

-- Indexes: 1 (ngoài PK)
CREATE INDEX idx_matching_pair_exercise ON matching_pair(exercise_id);


-- ============================================================================
-- TABLE 12: user_progress
-- Purpose: Theo dõi tiến trình học (session-based, không cần auth)
-- Rows dự kiến: 0 ban đầu, ~10K+/năm
-- Thay đổi: Xóa 3 indexes low-cardinality (status, lesson, last_access)
-- ============================================================================
CREATE TABLE user_progress (
    id              INT UNSIGNED        NOT NULL AUTO_INCREMENT,
    session_id      VARCHAR(64)         NOT NULL    COMMENT 'Browser session UUID (crypto.randomUUID)',
    lesson_id       INT UNSIGNED        NOT NULL,
    status          ENUM('not_started', 'in_progress', 'completed')
                                        NOT NULL    DEFAULT 'not_started',

    -- Theory progress
    theory_completed BOOLEAN            NOT NULL    DEFAULT FALSE,
    theory_time_spent INT UNSIGNED      NOT NULL    DEFAULT 0 COMMENT 'Seconds spent on theory',

    -- Exercise progress
    exercises_attempted SMALLINT UNSIGNED NOT NULL  DEFAULT 0,
    exercises_correct   SMALLINT UNSIGNED NOT NULL  DEFAULT 0,
    exercises_total     SMALLINT UNSIGNED NOT NULL  DEFAULT 0
                                        COMMENT 'Auto-set bởi trigger tr_progress_set_total',

    -- Scores
    current_score   DECIMAL(5,2)        NOT NULL    DEFAULT 0 COMMENT 'Latest attempt score %',
    best_score      DECIMAL(5,2)        NOT NULL    DEFAULT 0 COMMENT 'Best score %',
    total_attempts  SMALLINT UNSIGNED   NOT NULL    DEFAULT 0,

    -- Time tracking
    total_time_spent INT UNSIGNED       NOT NULL    DEFAULT 0 COMMENT 'Total seconds',
    last_position   VARCHAR(50)         NULL        COMMENT 'Last section viewed (resume feature)',

    -- Timestamps
    first_access    TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP,
    last_access     TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    completed_at    TIMESTAMP           NULL,

    PRIMARY KEY (id),
    CONSTRAINT uq_progress_session_lesson UNIQUE (session_id, lesson_id),
    CONSTRAINT fk_progress_lesson
        FOREIGN KEY (lesson_id) REFERENCES lesson(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_progress_score CHECK (current_score >= 0 AND current_score <= 100),
    CONSTRAINT chk_progress_best_score CHECK (best_score >= 0 AND best_score <= 100),
    CONSTRAINT chk_progress_exercises CHECK (exercises_correct <= exercises_attempted),
    CONSTRAINT chk_progress_attempted CHECK (exercises_attempted <= exercises_total)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='User learning progress tracking (session-based)';

-- Indexes: 1 (ngoài PK + UNIQUE)
-- idx_progress_session: Query D3, D4 (aggregation theo session)
CREATE INDEX idx_progress_session ON user_progress(session_id);
-- XÓA: idx_progress_lesson (luôn query kèm session_id → dùng uq thay thế)
-- XÓA: idx_progress_status (cardinality=3)
-- XÓA: idx_progress_last_access (không có query nào filter riêng)


-- ============================================================================
-- TABLE 13: exercise_attempt
-- Purpose: Ghi nhận từng lần làm bài
-- Rows dự kiến: 0 ban đầu, ~100K+/năm (bảng tăng nhanh nhất)
-- Thay đổi: Chỉ giữ 1 composite index thay vì 4 indexes
-- ============================================================================
CREATE TABLE exercise_attempt (
    id              INT UNSIGNED        NOT NULL AUTO_INCREMENT,
    session_id      VARCHAR(64)         NOT NULL,
    exercise_id     INT UNSIGNED        NOT NULL,
    user_answer     TEXT                NOT NULL    COMMENT 'User submitted answer',
    is_correct      BOOLEAN             NOT NULL,
    time_taken      SMALLINT UNSIGNED   NULL        COMMENT 'Seconds to answer',
    attempt_number  TINYINT UNSIGNED    NOT NULL    DEFAULT 1,
    created_at      TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    CONSTRAINT fk_attempt_exercise
        FOREIGN KEY (exercise_id) REFERENCES exercise(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Individual exercise attempt records';

-- Indexes: 1 composite (ngoài PK)
-- Covers: Query C5a (WHERE session_id = ? AND exercise_id = ?)
--         Query C6 (JOIN on exercise_id, filter session_id)
CREATE INDEX idx_attempt_session_exercise ON exercise_attempt(session_id, exercise_id);
-- XÓA: idx_attempt_session (covered bởi composite — leftmost prefix)
-- XÓA: idx_attempt_exercise (covered bởi composite khi kèm session)
-- XÓA: idx_attempt_created (không có analytics query nào dùng)
-- XÓA: idx_attempt_date_session (không có analytics query nào dùng)


-- ============================================================================
-- TABLE 14: bookmark
-- Purpose: Đánh dấu bài học / phần yêu thích
-- Rows dự kiến: ~100-1000
-- Thay đổi: Xóa idx_bookmark_lesson (luôn query kèm session_id)
-- ============================================================================
CREATE TABLE bookmark (
    id              INT UNSIGNED        NOT NULL AUTO_INCREMENT,
    session_id      VARCHAR(64)         NOT NULL,
    lesson_id       INT UNSIGNED        NOT NULL,
    section_type    ENUM('formula', 'usage', 'signal_word', 'tip', 'exercise', 'comparison')
                                        NULL        COMMENT 'Specific section type',
    section_id      INT UNSIGNED        NULL        COMMENT 'ID of the specific section',
    note            VARCHAR(500)        NULL        COMMENT 'User note',
    created_at      TIMESTAMP           NOT NULL    DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    CONSTRAINT uq_bookmark UNIQUE (session_id, lesson_id, section_type, section_id),
    CONSTRAINT fk_bookmark_lesson
        FOREIGN KEY (lesson_id) REFERENCES lesson(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='User bookmarks for quick access';

-- Indexes: 0 (ngoài PK + UNIQUE)
-- uq_bookmark(session_id, ...) đã cover query E3 (WHERE session_id = ?) và E4
-- XÓA: idx_bookmark_session (covered bởi uq — leftmost prefix)
-- XÓA: idx_bookmark_lesson (luôn query kèm session_id)


-- ============================================================================
-- VIEWS (3 views — xóa v_exercise_summary, v_user_progress_overview)
-- Triết lý: Giữ views đơn giản hóa queries phức tạp,
--           xóa views mà APPLICATION_QUERIES.sql đã thay thế
-- ============================================================================

-- ---------------------------------------------------------------------------
-- View 1: v_lesson_summary
-- Dùng bởi: Query A2 (homepage lesson list)
-- Giá trị: Tổng hợp counts từ 5 bảng con trong 1 query
-- ---------------------------------------------------------------------------
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
    (SELECT COUNT(*) FROM formula f WHERE f.lesson_id = l.id) AS formula_count,
    (SELECT COUNT(*) FROM lesson_usage u WHERE u.lesson_id = l.id) AS usage_count,
    (SELECT COUNT(*) FROM signal_word sw WHERE sw.lesson_id = l.id) AS signal_word_count,
    (SELECT COUNT(*) FROM tip t WHERE t.lesson_id = l.id) AS tip_count,
    (SELECT COUNT(*) FROM exercise e WHERE e.lesson_id = l.id AND e.is_active = TRUE) AS exercise_count
FROM lesson l
JOIN tense_group g ON l.group_id = g.id
ORDER BY g.order_index, l.order_index;

-- XÓA: v_exercise_summary (không có query nào từ app sử dụng)
-- XÓA: v_user_progress_overview (thay bằng query D4 trong APPLICATION_QUERIES.sql)

-- ---------------------------------------------------------------------------
-- View 2: v_lesson_comparisons
-- Dùng bởi: Query B6 (comparison section trong lesson page)
-- Giá trị: Giải quyết bidirectional query cho M:N self-reference
--          Lưu 1 lần (lesson_id_1 < lesson_id_2) nhưng query được từ cả 2 phía
-- ---------------------------------------------------------------------------
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

-- ---------------------------------------------------------------------------
-- View 3: v_database_stats
-- Dùng bởi: Debug/admin, kiểm tra data sau seed
-- ---------------------------------------------------------------------------
CREATE VIEW v_database_stats AS
SELECT
    (SELECT COUNT(*) FROM tense_group) AS total_groups,
    (SELECT COUNT(*) FROM lesson) AS total_lessons,
    (SELECT COUNT(*) FROM lesson WHERE is_published = TRUE) AS published_lessons,
    (SELECT COUNT(*) FROM formula) AS total_formulas,
    (SELECT COUNT(*) FROM lesson_usage) AS total_usages,
    (SELECT COUNT(*) FROM example) AS total_examples,
    (SELECT COUNT(*) FROM signal_word) AS total_signal_words,
    (SELECT COUNT(*) FROM tip) AS total_tips,
    (SELECT COUNT(*) FROM lesson_comparison) AS total_comparisons,
    (SELECT COUNT(*) FROM exercise WHERE is_active = TRUE) AS total_exercises,
    (SELECT COUNT(*) FROM exercise_option) AS total_options,
    (SELECT COUNT(DISTINCT session_id) FROM user_progress) AS total_users,
    (SELECT COUNT(*) FROM exercise_attempt) AS total_attempts;


-- ============================================================================
-- FUNCTION (1 function — xóa fn_calc_completion_percent)
-- Triết lý: Giữ validation function trong DB,
--           logic tính toán chuyển sang application layer
-- ============================================================================

DELIMITER //

-- Kiểm tra lesson có đủ nội dung tối thiểu chưa
-- Dùng khi: Seed data validation, admin content check
CREATE FUNCTION fn_lesson_is_complete(p_lesson_id INT UNSIGNED)
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_formula_count INT;
    DECLARE v_usage_count INT;
    DECLARE v_exercise_count INT;

    SELECT COUNT(*) INTO v_formula_count FROM formula WHERE lesson_id = p_lesson_id;
    SELECT COUNT(*) INTO v_usage_count FROM lesson_usage WHERE lesson_id = p_lesson_id;
    SELECT COUNT(*) INTO v_exercise_count FROM exercise WHERE lesson_id = p_lesson_id AND is_active = TRUE;

    -- Minimum: 1 formula, 1 usage, 3 exercises
    RETURN v_formula_count >= 1 AND v_usage_count >= 1 AND v_exercise_count >= 3;
END //

DELIMITER ;

-- XÓA: fn_calc_completion_percent (tính ở frontend dễ hơn, linh hoạt hơn)
-- XÓA: Tất cả 6 Stored Procedures (logic ở application layer — xem APPLICATION_QUERIES.sql)
--   sp_get_lesson_full → thay bằng parallel queries B1-B6
--   sp_update_exercise_progress → thay bằng transaction C5 ở Node.js
--   sp_get_session_progress → thay bằng query D3
--   sp_get_lesson_exercises → thay bằng queries C1+C2+C3
--   sp_reset_lesson_progress → thay bằng transaction D5 ở Node.js
--   sp_get_lesson_comparisons → thay bằng query B6


-- ============================================================================
-- TRIGGERS (4 triggers)
-- ============================================================================

DELIMITER //

-- Trigger 1-2: Enforce lesson_id_1 < lesson_id_2 in lesson_comparison
-- (Replaces CHECK constraint removed due to MySQL 8.0 bug #3823)
CREATE TRIGGER tr_comparison_order_insert
BEFORE INSERT ON lesson_comparison
FOR EACH ROW
BEGIN
    IF NEW.lesson_id_1 >= NEW.lesson_id_2 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'lesson_id_1 must be less than lesson_id_2';
    END IF;
END //

CREATE TRIGGER tr_comparison_order_update
BEFORE UPDATE ON lesson_comparison
FOR EACH ROW
BEGIN
    IF NEW.lesson_id_1 >= NEW.lesson_id_2 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'lesson_id_1 must be less than lesson_id_2';
    END IF;
END //

-- Trigger 3: Auto-set exercises_total khi tạo progress record mới
-- Lưu ý: exercises_total KHÔNG auto-update nếu admin thêm exercise sau
--         → Giải pháp lâu dài: check ở application layer (query COUNT thay vì dùng cached value)
CREATE TRIGGER tr_progress_set_total
BEFORE INSERT ON user_progress
FOR EACH ROW
BEGIN
    SET NEW.exercises_total = (
        SELECT COUNT(*) FROM exercise
        WHERE lesson_id = NEW.lesson_id AND is_active = TRUE
    );
END //


-- Trigger 4: Auto-complete khi đã làm hết exercises + đọc theory
CREATE TRIGGER tr_progress_check_completion
BEFORE UPDATE ON user_progress
FOR EACH ROW
BEGIN
    IF NEW.exercises_attempted >= NEW.exercises_total
       AND NEW.exercises_total > 0
       AND NEW.theory_completed = TRUE
       AND NEW.status != 'completed' THEN
        SET NEW.status = 'completed';
        SET NEW.completed_at = CURRENT_TIMESTAMP;
    END IF;
END //

DELIMITER ;


-- ============================================================================
-- INDEX SUMMARY
-- ============================================================================
-- Tổng: 27 indexes (15 PK + 6 UNIQUE + 6 regular)
--
-- So với v1.0: 46 → 27 (giảm 41%)
--
-- Regular indexes (6):
--   idx_tense_group_order       → ORDER BY group display
--   idx_lesson_group            → Filter lessons by group
--   idx_lesson_published        → Filter published + order
--   idx_lesson_usage_lesson_order → Filter + order usages
--   idx_example_usage           → Join examples ← usages
--   idx_tip_lesson              → Filter tips by lesson
--   idx_comparison_lesson_1     → Comparison lookup (side 1)
--   idx_comparison_lesson_2     → Comparison lookup (side 2)
--   idx_exercise_lesson_type_diff → THE composite index (covers 5 old indexes)
--   idx_matching_pair_exercise  → Filter pairs by exercise
--   idx_progress_session        → Session-level aggregation
--   idx_attempt_session_exercise → Attempt lookup (covers 4 old indexes)
--
-- Mỗi index bị xóa đều có lý do cụ thể — xem DATABASE_ANALYSIS.md mục 2
-- ============================================================================

-- ============================================================================
-- END OF SCHEMA
-- ============================================================================
