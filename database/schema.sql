-- ============================================================================
-- DATABASE SCHEMA: Knowledge Learning Application
-- Version: 3.0.0 (PostgreSQL 17 — migrated from MySQL 8.0 v2.0)
-- PostgreSQL: 17+
--
-- Changes from v2.0 (MySQL):
--   - MySQL → PostgreSQL syntax (SERIAL, ENUM types, TIMESTAMPTZ, JSONB)
--   - ON UPDATE CURRENT_TIMESTAMP → update_updated_at() trigger function
--   - 2 comparison order triggers → CHECK constraint (PG has no FK+CHECK bug)
--   - REGEXP → ~ operator
--   - 11 ENUM types extracted to CREATE TYPE
--   - ENGINE/CHARSET/COLLATE clauses removed (PG defaults to UTF-8)
--   - COMMENT 'x' on column → COMMENT ON COLUMN syntax
-- ============================================================================


-- ============================================================================
-- ENUM TYPES (11)
-- ============================================================================

CREATE TYPE difficulty_level     AS ENUM ('beginner', 'intermediate', 'advanced');
CREATE TYPE formula_type         AS ENUM ('affirmative', 'negative', 'interrogative');
CREATE TYPE signal_word_category AS ENUM ('time', 'frequency', 'duration', 'sequence', 'other');
CREATE TYPE signal_word_position AS ENUM ('beginning', 'middle', 'end', 'flexible');
CREATE TYPE tip_category         AS ENUM ('memory', 'common_mistake', 'comparison', 'native_usage', 'shortcut', 'general');
CREATE TYPE importance_level     AS ENUM ('low', 'medium', 'high');
CREATE TYPE exercise_type        AS ENUM ('multiple_choice', 'fill_blank', 'error_correction', 'sentence_transform', 'arrange_words', 'matching', 'true_false');
CREATE TYPE exercise_difficulty  AS ENUM ('easy', 'medium', 'hard');
CREATE TYPE option_label         AS ENUM ('A', 'B', 'C', 'D', 'E', 'F');
CREATE TYPE progress_status      AS ENUM ('not_started', 'in_progress', 'completed');
CREATE TYPE section_type         AS ENUM ('formula', 'usage', 'signal_word', 'tip', 'exercise', 'comparison');
CREATE TYPE lesson_section_type  AS ENUM ('markdown', 'key_points', 'info_box');


-- ============================================================================
-- UTILITY: update_updated_at() trigger function
-- Replaces MySQL ON UPDATE CURRENT_TIMESTAMP
-- ============================================================================

CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- ============================================================================
-- TABLE 0: schema_version
-- ============================================================================

CREATE TABLE schema_version (
    version     INTEGER         NOT NULL,
    description VARCHAR(255)    NOT NULL,
    applied_at  TIMESTAMPTZ     NOT NULL DEFAULT NOW(),

    PRIMARY KEY (version)
);

COMMENT ON TABLE schema_version IS 'Track schema migrations';

INSERT INTO schema_version (version, description) VALUES
(1, 'Initial MySQL schema (v2.0)'),
(2, 'PostgreSQL migration (v3.0 — SERIAL, ENUM types, JSONB, triggers)'),
(3, 'Rename tense_group to category (generalize for multi-topic Learning Hub)'),
(4, 'Add missing indexes and unique constraint for exercise_attempt'),
(5, 'Remove exercises_total cached column, compute dynamically'),
(6, 'Add lesson_section table for data-driven content rendering');


-- ============================================================================
-- TABLE 1: category
-- ============================================================================

CREATE TABLE category (
    id              SERIAL          NOT NULL,
    name            VARCHAR(50)     NOT NULL,
    name_vi         VARCHAR(50)     NOT NULL,
    description     TEXT            NULL,
    description_vi  TEXT            NULL,
    icon            VARCHAR(50)     NULL,
    color           VARCHAR(7)      NOT NULL DEFAULT '#6366f1',
    order_index     SMALLINT        NOT NULL DEFAULT 0,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),

    PRIMARY KEY (id),
    CONSTRAINT uq_category_name  UNIQUE (name),
    CONSTRAINT chk_category_color CHECK (color ~ '^#[0-9A-Fa-f]{6}$'),
    CONSTRAINT chk_category_order CHECK (order_index >= 0 AND order_index <= 10)
);

COMMENT ON COLUMN category.icon IS 'MUI icon name';

CREATE INDEX idx_category_order ON category(order_index);

CREATE TRIGGER trg_category_updated_at
  BEFORE UPDATE ON category
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();


-- ============================================================================
-- TABLE 2: lesson
-- ============================================================================

CREATE TABLE lesson (
    id              SERIAL              NOT NULL,
    group_id        INTEGER             NOT NULL,
    name            VARCHAR(100)        NOT NULL,
    name_vi         VARCHAR(100)        NOT NULL,
    slug            VARCHAR(100)        NOT NULL,
    short_desc      VARCHAR(255)        NULL,
    short_desc_vi   VARCHAR(255)        NULL,
    description     TEXT                NULL,
    description_vi  TEXT                NULL,
    difficulty      difficulty_level    NOT NULL DEFAULT 'beginner',
    estimated_time  SMALLINT            NULL,
    order_index     SMALLINT            NOT NULL DEFAULT 0,
    is_published    BOOLEAN             NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMPTZ         NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ         NOT NULL DEFAULT NOW(),

    PRIMARY KEY (id),
    CONSTRAINT uq_lesson_name UNIQUE (name),
    CONSTRAINT uq_lesson_slug UNIQUE (slug),
    CONSTRAINT chk_lesson_order CHECK (order_index >= 0),
    CONSTRAINT chk_lesson_time  CHECK (estimated_time IS NULL OR estimated_time >= 0),
    CONSTRAINT fk_lesson_category
        FOREIGN KEY (group_id) REFERENCES category(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

COMMENT ON COLUMN lesson.short_desc IS 'Brief description for cards';
COMMENT ON COLUMN lesson.description IS 'Full introduction';

CREATE INDEX idx_lesson_group     ON lesson(group_id);
CREATE INDEX idx_lesson_published ON lesson(is_published, order_index);

CREATE TRIGGER trg_lesson_updated_at
  BEFORE UPDATE ON lesson
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();


-- ============================================================================
-- TABLE 3: formula
-- ============================================================================

CREATE TABLE formula (
    id                  SERIAL          NOT NULL,
    lesson_id           INTEGER         NOT NULL,
    type                formula_type    NOT NULL,
    subject_note        VARCHAR(150)    NULL,
    structure           VARCHAR(255)    NOT NULL,
    structure_vi        VARCHAR(255)    NULL,
    example             VARCHAR(255)    NOT NULL,
    example_vi          VARCHAR(255)    NULL,
    example_negative    VARCHAR(255)    NULL,
    note                TEXT            NULL,
    order_index         SMALLINT        NOT NULL DEFAULT 0,
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW(),

    PRIMARY KEY (id),
    CONSTRAINT uq_formula_lesson_type UNIQUE (lesson_id, type),
    CONSTRAINT fk_formula_lesson
        FOREIGN KEY (lesson_id) REFERENCES lesson(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

COMMENT ON COLUMN formula.type IS '+, -, ?';
COMMENT ON COLUMN formula.subject_note IS 'Notes about subject (I/you/we vs he/she/it)';
COMMENT ON COLUMN formula.structure IS 'Formula structure in English';
COMMENT ON COLUMN formula.structure_vi IS 'Formula explanation in Vietnamese';
COMMENT ON COLUMN formula.example IS 'Example sentence';
COMMENT ON COLUMN formula.example_vi IS 'Vietnamese translation';
COMMENT ON COLUMN formula.example_negative IS 'Negative form of example (if affirmative)';
COMMENT ON COLUMN formula.note IS 'Additional notes';

CREATE TRIGGER trg_formula_updated_at
  BEFORE UPDATE ON formula
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();


-- ============================================================================
-- TABLE 4: lesson_usage
-- ============================================================================

CREATE TABLE lesson_usage (
    id              SERIAL          NOT NULL,
    lesson_id       INTEGER         NOT NULL,
    title           VARCHAR(150)    NOT NULL,
    title_vi        VARCHAR(150)    NULL,
    description     TEXT            NOT NULL,
    description_vi  TEXT            NULL,
    icon            VARCHAR(50)     NULL,
    is_common       BOOLEAN         NOT NULL DEFAULT TRUE,
    order_index     SMALLINT        NOT NULL DEFAULT 0,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),

    PRIMARY KEY (id),
    CONSTRAINT fk_lesson_usage_lesson
        FOREIGN KEY (lesson_id) REFERENCES lesson(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

COMMENT ON COLUMN lesson_usage.title IS 'Usage title in English';
COMMENT ON COLUMN lesson_usage.title_vi IS 'Usage title in Vietnamese';
COMMENT ON COLUMN lesson_usage.description IS 'Detailed explanation';
COMMENT ON COLUMN lesson_usage.icon IS 'MUI icon for visual';
COMMENT ON COLUMN lesson_usage.is_common IS 'Is this a common usage?';

CREATE INDEX idx_lesson_usage_lesson_order ON lesson_usage(lesson_id, order_index);

CREATE TRIGGER trg_lesson_usage_updated_at
  BEFORE UPDATE ON lesson_usage
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();


-- ============================================================================
-- TABLE 5: example
-- ============================================================================

CREATE TABLE example (
    id              SERIAL          NOT NULL,
    usage_id        INTEGER         NOT NULL,
    sentence        VARCHAR(500)    NOT NULL,
    sentence_vi     VARCHAR(500)    NULL,
    explanation     TEXT            NULL,
    explanation_vi  TEXT            NULL,
    highlight_word  VARCHAR(100)    NULL,
    highlight_start INTEGER         NULL,
    highlight_end   INTEGER         NULL,
    audio_url       VARCHAR(255)    NULL,
    order_index     SMALLINT        NOT NULL DEFAULT 0,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),

    PRIMARY KEY (id),
    CONSTRAINT fk_example_usage
        FOREIGN KEY (usage_id) REFERENCES lesson_usage(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_example_highlight
        CHECK (
            (highlight_start IS NULL AND highlight_end IS NULL) OR
            (highlight_start IS NOT NULL AND highlight_end IS NOT NULL AND highlight_start < highlight_end)
        ),
    CONSTRAINT chk_example_highlight_positive
        CHECK (highlight_start IS NULL OR highlight_start >= 0)
);

COMMENT ON COLUMN example.sentence IS 'Example sentence in English';
COMMENT ON COLUMN example.sentence_vi IS 'Vietnamese translation';
COMMENT ON COLUMN example.explanation IS 'Grammar explanation';
COMMENT ON COLUMN example.highlight_word IS 'Word(s) to highlight in sentence';
COMMENT ON COLUMN example.highlight_start IS 'Start position of highlight';
COMMENT ON COLUMN example.highlight_end IS 'End position of highlight';
COMMENT ON COLUMN example.audio_url IS 'URL to audio file';

CREATE INDEX idx_example_usage ON example(usage_id);


-- ============================================================================
-- TABLE 6: signal_word
-- ============================================================================

CREATE TABLE signal_word (
    id                  SERIAL                  NOT NULL,
    lesson_id           INTEGER                 NOT NULL,
    word                VARCHAR(100)            NOT NULL,
    word_vi             VARCHAR(100)            NULL,
    category            signal_word_category    NOT NULL DEFAULT 'time',
    example_sentence    VARCHAR(255)            NULL,
    example_vi          VARCHAR(255)            NULL,
    position            signal_word_position    NOT NULL DEFAULT 'flexible',
    note                VARCHAR(255)            NULL,
    order_index         SMALLINT                NOT NULL DEFAULT 0,
    created_at          TIMESTAMPTZ             NOT NULL DEFAULT NOW(),

    PRIMARY KEY (id),
    CONSTRAINT uq_signal_word_lesson_word UNIQUE (lesson_id, word),
    CONSTRAINT fk_signal_word_lesson
        FOREIGN KEY (lesson_id) REFERENCES lesson(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

COMMENT ON COLUMN signal_word.word IS 'Signal word/phrase';
COMMENT ON COLUMN signal_word.word_vi IS 'Vietnamese meaning';
COMMENT ON COLUMN signal_word.example_sentence IS 'Example using this signal word';
COMMENT ON COLUMN signal_word.position IS 'Typical position in sentence';
COMMENT ON COLUMN signal_word.note IS 'Usage notes';


-- ============================================================================
-- TABLE 7: tip
-- ============================================================================

CREATE TABLE tip (
    id              SERIAL              NOT NULL,
    lesson_id       INTEGER             NOT NULL,
    title           VARCHAR(150)        NULL,
    title_vi        VARCHAR(150)        NULL,
    content         TEXT                NOT NULL,
    content_vi      TEXT                NULL,
    category        tip_category        NOT NULL DEFAULT 'general',
    importance      importance_level    NOT NULL DEFAULT 'medium',
    icon            VARCHAR(50)         NULL,
    order_index     SMALLINT            NOT NULL DEFAULT 0,
    created_at      TIMESTAMPTZ         NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ         NOT NULL DEFAULT NOW(),

    PRIMARY KEY (id),
    CONSTRAINT fk_tip_lesson
        FOREIGN KEY (lesson_id) REFERENCES lesson(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

COMMENT ON COLUMN tip.title IS 'Tip title (optional)';
COMMENT ON COLUMN tip.content IS 'Tip content';
COMMENT ON COLUMN tip.icon IS 'MUI icon name';

CREATE INDEX idx_tip_lesson ON tip(lesson_id);

CREATE TRIGGER trg_tip_updated_at
  BEFORE UPDATE ON tip
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();


-- ============================================================================
-- TABLE 7b: lesson_section (generic data-driven content sections)
-- ============================================================================

CREATE TABLE lesson_section (
    id          SERIAL              PRIMARY KEY,
    lesson_id   INTEGER             NOT NULL REFERENCES lesson(id) ON DELETE CASCADE,
    type        lesson_section_type NOT NULL,
    title       VARCHAR(255),
    title_vi    VARCHAR(255),
    content     TEXT                NOT NULL,
    content_vi  TEXT,
    metadata    JSONB               NOT NULL DEFAULT '{}',
    order_index SMALLINT            NOT NULL DEFAULT 0,
    created_at  TIMESTAMPTZ         NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_lesson_section_lesson ON lesson_section(lesson_id, order_index);

COMMENT ON TABLE lesson_section IS 'Generic ordered content sections for data-driven lesson rendering';
COMMENT ON COLUMN lesson_section.type IS 'Rendering type: markdown, key_points, info_box';
COMMENT ON COLUMN lesson_section.content IS 'Markdown content (rendered client-side)';
COMMENT ON COLUMN lesson_section.metadata IS 'Extra hints: {variant} for info_box';


-- ============================================================================
-- TABLE 8: lesson_comparison
-- NOTE: CHECK (lesson_id_1 < lesson_id_2) works natively in PG — no trigger needed!
-- ============================================================================

CREATE TABLE lesson_comparison (
    id              SERIAL          NOT NULL,
    lesson_id_1     INTEGER         NOT NULL,
    lesson_id_2     INTEGER         NOT NULL,
    aspect          VARCHAR(100)    NOT NULL,
    aspect_vi       VARCHAR(100)    NULL,
    lesson_1_point  TEXT            NOT NULL,
    lesson_1_point_vi TEXT          NULL,
    lesson_2_point  TEXT            NOT NULL,
    lesson_2_point_vi TEXT          NULL,
    example_1       VARCHAR(300)    NULL,
    example_1_vi    VARCHAR(300)    NULL,
    example_2       VARCHAR(300)    NULL,
    example_2_vi    VARCHAR(300)    NULL,
    tip             TEXT            NULL,
    tip_vi          TEXT            NULL,
    order_index     SMALLINT        NOT NULL DEFAULT 0,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),

    PRIMARY KEY (id),
    CONSTRAINT uq_comparison_pair_aspect UNIQUE (lesson_id_1, lesson_id_2, aspect),
    CONSTRAINT chk_comparison_order CHECK (lesson_id_1 < lesson_id_2),
    CONSTRAINT fk_comparison_lesson_1
        FOREIGN KEY (lesson_id_1) REFERENCES lesson(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_comparison_lesson_2
        FOREIGN KEY (lesson_id_2) REFERENCES lesson(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

COMMENT ON COLUMN lesson_comparison.lesson_id_1 IS 'First lesson (smaller ID)';
COMMENT ON COLUMN lesson_comparison.lesson_id_2 IS 'Second lesson (larger ID)';
COMMENT ON COLUMN lesson_comparison.aspect IS 'Aspect being compared';

CREATE INDEX idx_comparison_lesson_1 ON lesson_comparison(lesson_id_1);
CREATE INDEX idx_comparison_lesson_2 ON lesson_comparison(lesson_id_2);

CREATE TRIGGER trg_lesson_comparison_updated_at
  BEFORE UPDATE ON lesson_comparison
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();


-- ============================================================================
-- TABLE 9: exercise
-- ============================================================================

CREATE TABLE exercise (
    id              SERIAL                  NOT NULL,
    lesson_id       INTEGER                 NOT NULL,
    type            exercise_type           NOT NULL,
    difficulty      exercise_difficulty     NOT NULL DEFAULT 'medium',
    question        TEXT                    NOT NULL,
    question_vi     TEXT                    NULL,
    context         TEXT                    NULL,
    context_vi      TEXT                    NULL,
    content         TEXT                    NULL,
    content_vi      TEXT                    NULL,
    correct_answer  VARCHAR(500)            NULL,
    word_bank       JSONB                   NULL,
    explanation     TEXT                    NULL,
    explanation_vi  TEXT                    NULL,
    hint            VARCHAR(255)            NULL,
    hint_vi         VARCHAR(255)            NULL,
    points          SMALLINT                NOT NULL DEFAULT 10,
    time_limit      SMALLINT                NULL,
    order_index     SMALLINT                NOT NULL DEFAULT 0,
    is_active       BOOLEAN                 NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMPTZ             NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ             NOT NULL DEFAULT NOW(),

    PRIMARY KEY (id),
    CONSTRAINT fk_exercise_lesson
        FOREIGN KEY (lesson_id) REFERENCES lesson(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_exercise_points CHECK (points > 0 AND points <= 100),
    CONSTRAINT chk_exercise_time   CHECK (time_limit IS NULL OR time_limit > 0)
);

COMMENT ON COLUMN exercise.question IS 'Question or instruction';
COMMENT ON COLUMN exercise.context IS 'Context or scenario (if needed)';
COMMENT ON COLUMN exercise.content IS 'Main content (sentence for fill_blank, error_correction, etc.)';
COMMENT ON COLUMN exercise.correct_answer IS 'Correct answer (API must NOT return before submission)';
COMMENT ON COLUMN exercise.word_bank IS 'Words to arrange (JSON array)';
COMMENT ON COLUMN exercise.explanation IS 'Why this is the answer';
COMMENT ON COLUMN exercise.hint IS 'Hint for the student';
COMMENT ON COLUMN exercise.time_limit IS 'Time limit in seconds (optional)';

CREATE INDEX idx_exercise_lesson_type_diff ON exercise(lesson_id, type, difficulty);

CREATE TRIGGER trg_exercise_updated_at
  BEFORE UPDATE ON exercise
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();


-- ============================================================================
-- TABLE 10: exercise_option
-- ============================================================================

CREATE TABLE exercise_option (
    id              SERIAL          NOT NULL,
    exercise_id     INTEGER         NOT NULL,
    label           option_label    NOT NULL,
    content         VARCHAR(500)    NOT NULL,
    content_vi      VARCHAR(500)    NULL,
    is_correct      BOOLEAN         NOT NULL DEFAULT FALSE,
    explanation     TEXT            NULL,
    explanation_vi  TEXT            NULL,
    order_index     SMALLINT        NOT NULL DEFAULT 0,

    PRIMARY KEY (id),
    CONSTRAINT uq_option_exercise_label UNIQUE (exercise_id, label),
    CONSTRAINT fk_option_exercise
        FOREIGN KEY (exercise_id) REFERENCES exercise(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

COMMENT ON COLUMN exercise_option.content IS 'Option content';
COMMENT ON COLUMN exercise_option.is_correct IS 'API must NOT return before submission';
COMMENT ON COLUMN exercise_option.explanation IS 'Why this is right/wrong';


-- ============================================================================
-- TABLE 11: matching_pair
-- ============================================================================

CREATE TABLE matching_pair (
    id                  SERIAL          NOT NULL,
    exercise_id         INTEGER         NOT NULL,
    left_content        VARCHAR(300)    NOT NULL,
    left_content_vi     VARCHAR(300)    NULL,
    right_content       VARCHAR(300)    NOT NULL,
    right_content_vi    VARCHAR(300)    NULL,
    order_index         SMALLINT        NOT NULL DEFAULT 0,

    PRIMARY KEY (id),
    CONSTRAINT fk_matching_pair_exercise
        FOREIGN KEY (exercise_id) REFERENCES exercise(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

COMMENT ON COLUMN matching_pair.left_content IS 'Left side content';
COMMENT ON COLUMN matching_pair.right_content IS 'Right side content (matching)';

CREATE INDEX idx_matching_pair_exercise ON matching_pair(exercise_id);


-- ============================================================================
-- TABLE 12: user_progress
-- ============================================================================

CREATE TABLE user_progress (
    id                  SERIAL              NOT NULL,
    session_id          VARCHAR(64)         NOT NULL,
    lesson_id           INTEGER             NOT NULL,
    status              progress_status     NOT NULL DEFAULT 'not_started',

    -- Theory progress
    theory_completed    BOOLEAN             NOT NULL DEFAULT FALSE,
    theory_time_spent   INTEGER             NOT NULL DEFAULT 0,

    -- Exercise progress
    exercises_attempted SMALLINT            NOT NULL DEFAULT 0,
    exercises_correct   SMALLINT            NOT NULL DEFAULT 0,

    -- Scores
    current_score       DECIMAL(5,2)        NOT NULL DEFAULT 0,
    best_score          DECIMAL(5,2)        NOT NULL DEFAULT 0,
    total_attempts      SMALLINT            NOT NULL DEFAULT 0,

    -- Time tracking
    total_time_spent    INTEGER             NOT NULL DEFAULT 0,
    last_position       VARCHAR(50)         NULL,

    -- Timestamps
    first_access        TIMESTAMPTZ         NOT NULL DEFAULT NOW(),
    last_access         TIMESTAMPTZ         NOT NULL DEFAULT NOW(),
    completed_at        TIMESTAMPTZ         NULL,

    PRIMARY KEY (id),
    CONSTRAINT uq_progress_session_lesson UNIQUE (session_id, lesson_id),
    CONSTRAINT fk_progress_lesson
        FOREIGN KEY (lesson_id) REFERENCES lesson(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_progress_score      CHECK (current_score >= 0 AND current_score <= 100),
    CONSTRAINT chk_progress_best_score CHECK (best_score >= 0 AND best_score <= 100),
    CONSTRAINT chk_progress_exercises  CHECK (exercises_correct <= exercises_attempted),
    CONSTRAINT chk_progress_time       CHECK (theory_time_spent >= 0 AND total_time_spent >= 0)
);

COMMENT ON COLUMN user_progress.session_id IS 'Browser session UUID (crypto.randomUUID)';
COMMENT ON COLUMN user_progress.theory_time_spent IS 'Seconds spent on theory';
COMMENT ON COLUMN user_progress.current_score IS 'Latest attempt score %';
COMMENT ON COLUMN user_progress.best_score IS 'Best score %';
COMMENT ON COLUMN user_progress.total_time_spent IS 'Total seconds';
COMMENT ON COLUMN user_progress.last_position IS 'Last section viewed (resume feature)';

CREATE INDEX idx_progress_session ON user_progress(session_id);
CREATE INDEX idx_progress_lesson_session ON user_progress(lesson_id, session_id);

-- NOTE: No update_updated_at() trigger here — user_progress uses last_access, not updated_at.
-- last_access is managed explicitly by application queries.


-- ============================================================================
-- TABLE 13: exercise_attempt
-- ============================================================================

CREATE TABLE exercise_attempt (
    id              SERIAL          NOT NULL,
    session_id      VARCHAR(64)     NOT NULL,
    exercise_id     INTEGER         NOT NULL,
    user_answer     TEXT            NOT NULL,
    is_correct      BOOLEAN         NOT NULL,
    time_taken      SMALLINT        NULL,
    attempt_number  SMALLINT        NOT NULL DEFAULT 1,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),

    PRIMARY KEY (id),
    CONSTRAINT fk_attempt_exercise
        FOREIGN KEY (exercise_id) REFERENCES exercise(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_attempt_number CHECK (attempt_number > 0),
    CONSTRAINT chk_attempt_time   CHECK (time_taken IS NULL OR time_taken >= 0),
    CONSTRAINT uq_attempt_session_exercise_number
        UNIQUE (session_id, exercise_id, attempt_number)
);

COMMENT ON COLUMN exercise_attempt.user_answer IS 'User submitted answer';
COMMENT ON COLUMN exercise_attempt.time_taken IS 'Seconds to answer';

CREATE INDEX idx_attempt_session_exercise ON exercise_attempt(session_id, exercise_id);
CREATE INDEX idx_attempt_exercise_number ON exercise_attempt(exercise_id, session_id, attempt_number DESC);


-- ============================================================================
-- TABLE 14: bookmark
-- ============================================================================

CREATE TABLE bookmark (
    id              SERIAL          NOT NULL,
    session_id      VARCHAR(64)     NOT NULL,
    lesson_id       INTEGER         NOT NULL,
    section_type    section_type    NULL,
    section_id      INTEGER         NULL,
    note            VARCHAR(500)    NULL,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),

    PRIMARY KEY (id),
    CONSTRAINT uq_bookmark UNIQUE (session_id, lesson_id, section_type, section_id),
    CONSTRAINT fk_bookmark_lesson
        FOREIGN KEY (lesson_id) REFERENCES lesson(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

COMMENT ON COLUMN bookmark.section_type IS 'Specific section type';
COMMENT ON COLUMN bookmark.section_id IS 'ID of the specific section';
COMMENT ON COLUMN bookmark.note IS 'User note';


-- ============================================================================
-- VIEWS (3)
-- ============================================================================

-- View 1: v_lesson_summary
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


-- View 2: v_lesson_comparisons (bidirectional query for M:N self-reference)
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


-- View 3: v_database_stats (debug/admin)
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


-- ============================================================================
-- FUNCTION: fn_lesson_is_complete
-- ============================================================================

CREATE OR REPLACE FUNCTION fn_lesson_is_complete(p_lesson_id INTEGER)
RETURNS BOOLEAN
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
    v_formula_count  INTEGER;
    v_usage_count    INTEGER;
    v_exercise_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_formula_count  FROM formula WHERE lesson_id = p_lesson_id;
    SELECT COUNT(*) INTO v_usage_count    FROM lesson_usage WHERE lesson_id = p_lesson_id;
    SELECT COUNT(*) INTO v_exercise_count FROM exercise WHERE lesson_id = p_lesson_id AND is_active = TRUE;

    -- Minimum: 1 usage, 3 exercises (formula is optional for non-grammar topics)
    RETURN v_usage_count >= 1 AND v_exercise_count >= 3;
END;
$$;


-- ============================================================================
-- TRIGGERS (1 — exercises_total trigger removed, count computed dynamically)
-- ============================================================================

-- Trigger: Auto-complete when all exercises done + theory read
-- (exercises_total computed dynamically — no cached column)
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

CREATE TRIGGER tr_progress_check_completion
  BEFORE UPDATE ON user_progress
  FOR EACH ROW EXECUTE FUNCTION fn_progress_check_completion();


-- ============================================================================
-- INDEX SUMMARY
-- ============================================================================
-- Total: 27 indexes (15 PK + 6 UNIQUE + 6 regular)
--
-- Regular indexes (6):
--   idx_category_order              → ORDER BY group display
--   idx_lesson_group                → Filter lessons by group
--   idx_lesson_published            → Filter published + order
--   idx_lesson_usage_lesson_order   → Filter + order usages
--   idx_example_usage               → Join examples ← usages
--   idx_tip_lesson                  → Filter tips by lesson
--   idx_comparison_lesson_1         → Comparison lookup (side 1)
--   idx_comparison_lesson_2         → Comparison lookup (side 2)
--   idx_exercise_lesson_type_diff   → THE composite index
--   idx_matching_pair_exercise      → Filter pairs by exercise
--   idx_progress_session            → Session-level aggregation
--   idx_attempt_session_exercise    → Attempt lookup
--
-- Changes from MySQL v2.0:
--   - 2 comparison order triggers → CHECK constraint
--   - ON UPDATE CURRENT_TIMESTAMP → 7 update_updated_at triggers
-- ============================================================================

-- ============================================================================
-- END OF SCHEMA
-- ============================================================================
