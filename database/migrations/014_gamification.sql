-- Migration 014: Gamification system — XP, Streaks, Achievements, Daily Goals
-- Date: 2026-02-18
-- Purpose: Add engagement engine to the Learning Hub with:
--   - XP event sourcing (append-only log for audit trail + analytics)
--   - Daily activity tracking (exercises count + XP per day for streaks/goals)
--   - Achievement definitions (18 seeded badges across 5 categories)
--   - User achievement junction (earned badges per session)
--   - User streak cache (current/longest streak + daily goal setting)
--
-- Design decisions:
--   - Event sourcing for XP: each event is immutable → enables analytics, undo, audit
--   - daily_activity as streak source of truth: one row per session per day
--   - user_streak as a derived cache: avoids computing streak from N daily_activity rows
--   - Achievement checking via single CTE query: O(1) queries, not O(N) per achievement

BEGIN;

INSERT INTO schema_version (version, description)
VALUES (14, 'Add gamification system: XP events, daily activity, achievements, streaks');


-- ============================================================================
-- TABLE: xp_event (append-only event sourcing log)
-- ============================================================================

CREATE TABLE xp_event (
    id              SERIAL          PRIMARY KEY,
    session_id      UUID            NOT NULL,
    event_type      VARCHAR(30)     NOT NULL,
    xp_amount       INTEGER         NOT NULL,
    reference_id    INTEGER,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE xp_event IS 'Append-only XP event log (event sourcing)';
COMMENT ON COLUMN xp_event.event_type IS 'exercise_correct, exercise_incorrect, achievement_bonus';
COMMENT ON COLUMN xp_event.reference_id IS 'exercise_id or achievement_id depending on event_type';

CREATE INDEX idx_xp_event_session ON xp_event (session_id);
CREATE INDEX idx_xp_event_session_date ON xp_event (session_id, created_at);


-- ============================================================================
-- TABLE: daily_activity (one row per session per day — streak source of truth)
-- ============================================================================

CREATE TABLE daily_activity (
    id                  SERIAL      PRIMARY KEY,
    session_id          UUID        NOT NULL,
    activity_date       DATE        NOT NULL DEFAULT CURRENT_DATE,
    exercises_completed INTEGER     NOT NULL DEFAULT 0,
    xp_earned           INTEGER     NOT NULL DEFAULT 0,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    UNIQUE (session_id, activity_date)
);

COMMENT ON TABLE daily_activity IS 'Daily activity tracker — source of truth for streaks and daily goals';

CREATE TRIGGER update_daily_activity_updated_at
    BEFORE UPDATE ON daily_activity
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();


-- ============================================================================
-- TABLE: achievement (definitions — seeded data)
-- ============================================================================

CREATE TABLE achievement (
    id              SERIAL          PRIMARY KEY,
    code            VARCHAR(50)     NOT NULL UNIQUE,
    name            VARCHAR(100)    NOT NULL,
    name_vi         VARCHAR(100)    NOT NULL,
    description     VARCHAR(255)    NOT NULL,
    description_vi  VARCHAR(255)    NOT NULL,
    icon            VARCHAR(50)     NOT NULL,
    category        VARCHAR(30)     NOT NULL,
    condition_type  VARCHAR(30)     NOT NULL,
    condition_value INTEGER         NOT NULL DEFAULT 1,
    xp_reward       INTEGER         NOT NULL DEFAULT 0,
    sort_order      INTEGER         NOT NULL DEFAULT 0,
    is_active       BOOLEAN         NOT NULL DEFAULT TRUE
);

COMMENT ON TABLE achievement IS 'Achievement badge definitions (seeded, not user-created)';
COMMENT ON COLUMN achievement.condition_type IS 'exercises_completed, lessons_completed, streak_days, total_xp, perfect_score, categories_explored';
COMMENT ON COLUMN achievement.icon IS 'MUI icon component name (e.g. EmojiEvents, LocalFireDepartment)';


-- ============================================================================
-- TABLE: user_achievement (junction — which session earned which badge)
-- ============================================================================

CREATE TABLE user_achievement (
    id              SERIAL          PRIMARY KEY,
    session_id      UUID            NOT NULL,
    achievement_id  INTEGER         NOT NULL REFERENCES achievement(id),
    earned_at       TIMESTAMPTZ     NOT NULL DEFAULT NOW(),

    UNIQUE (session_id, achievement_id)
);

COMMENT ON TABLE user_achievement IS 'Tracks achievements earned by each session';

CREATE INDEX idx_user_achievement_session ON user_achievement (session_id);


-- ============================================================================
-- TABLE: user_streak (derived cache — avoids recomputing from daily_activity)
-- ============================================================================

CREATE TABLE user_streak (
    session_id      UUID            PRIMARY KEY,
    current_streak  INTEGER         NOT NULL DEFAULT 0,
    longest_streak  INTEGER         NOT NULL DEFAULT 0,
    last_active_date DATE,
    daily_goal      INTEGER         NOT NULL DEFAULT 5,
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE user_streak IS 'Cached streak data + daily goal setting per session';

CREATE TRIGGER update_user_streak_updated_at
    BEFORE UPDATE ON user_streak
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();


-- ============================================================================
-- SEED: Achievement definitions (18 badges across 5 categories)
-- ============================================================================

INSERT INTO achievement (code, name, name_vi, description, description_vi, icon, category, condition_type, condition_value, xp_reward, sort_order) VALUES
-- Milestones
('first_exercise',  'First Steps',       'Bước đầu tiên',           'Complete your first exercise',              'Hoàn thành bài tập đầu tiên',              'EmojiEvents',          'milestone', 'exercises_completed', 1,    10,  1),
('first_lesson',    'Scholar',           'Học giả',                  'Complete your first lesson',                'Hoàn thành bài học đầu tiên',              'School',               'milestone', 'lessons_completed',   1,    25,  2),

-- Streaks
('streak_3',        'Getting Started',   'Khởi đầu tốt',            'Maintain a 3-day streak',                  'Duy trì chuỗi 3 ngày liên tiếp',          'LocalFireDepartment',  'streak',    'streak_days',         3,    15,  10),
('streak_7',        'Week Warrior',      'Chiến binh tuần',          'Maintain a 7-day streak',                  'Duy trì chuỗi 7 ngày liên tiếp',          'LocalFireDepartment',  'streak',    'streak_days',         7,    30,  11),
('streak_14',       'Dedicated',         'Tận tâm',                  'Maintain a 14-day streak',                 'Duy trì chuỗi 14 ngày liên tiếp',         'LocalFireDepartment',  'streak',    'streak_days',         14,   50,  12),
('streak_30',       'Unstoppable',       'Không thể cản',            'Maintain a 30-day streak',                 'Duy trì chuỗi 30 ngày liên tiếp',         'Whatshot',             'streak',    'streak_days',         30,   100, 13),

-- XP milestones
('xp_100',          'Rising Star',       'Ngôi sao mới',             'Earn 100 XP',                              'Đạt 100 XP',                               'Star',                 'xp',        'total_xp',            100,  10,  20),
('xp_500',          'Knowledge Seeker',  'Người tìm tri thức',       'Earn 500 XP',                              'Đạt 500 XP',                               'StarBorder',           'xp',        'total_xp',            500,  25,  21),
('xp_1000',         'Expert',            'Chuyên gia',               'Earn 1,000 XP',                            'Đạt 1.000 XP',                             'StarRate',             'xp',        'total_xp',            1000, 50,  22),
('xp_5000',         'Master',            'Bậc thầy',                 'Earn 5,000 XP',                            'Đạt 5.000 XP',                             'AutoAwesome',          'xp',        'total_xp',            5000, 100, 23),

-- Lesson completion
('lessons_5',       'Curious Mind',      'Trí tò mò',                'Complete 5 lessons',                       'Hoàn thành 5 bài học',                     'MenuBook',             'lesson',    'lessons_completed',   5,    30,  30),
('lessons_10',      'Knowledge Builder', 'Xây dựng tri thức',        'Complete 10 lessons',                      'Hoàn thành 10 bài học',                    'AutoStories',          'lesson',    'lessons_completed',   10,   50,  31),
('lessons_20',      'Lifelong Learner',  'Học tập suốt đời',         'Complete 20 lessons',                      'Hoàn thành 20 bài học',                    'EmojiObjects',         'lesson',    'lessons_completed',   20,   100, 32),

-- Mastery
('perfect_score',   'Perfectionist',     'Người cầu toàn',           'Score 100% on any lesson',                 'Đạt điểm tuyệt đối trong bất kỳ bài nào', 'MilitaryTech',         'mastery',   'perfect_score',       1,    25,  40),

-- Explorer
('explorer_3',      'Explorer',          'Nhà thám hiểm',            'Study lessons from 3 different categories','Học bài từ 3 chủ đề khác nhau',            'Explore',              'explorer',  'categories_explored', 3,    30,  50),
('explorer_6',      'Polymath',          'Đa tài',                   'Study lessons from 6 different categories','Học bài từ 6 chủ đề khác nhau',            'Public',               'explorer',  'categories_explored', 6,    60,  51),
('explorer_10',     'Renaissance',       'Phục Hưng',                'Study lessons from 10 different categories','Học bài từ 10 chủ đề khác nhau',           'TravelExplore',        'explorer',  'categories_explored', 10,   100, 52),

-- Exercise volume
('exercises_50',    'Practice Makes Perfect', 'Luyện tập hoàn hảo',  'Complete 50 exercises correctly',          'Hoàn thành đúng 50 bài tập',              'FitnessCenter',        'milestone', 'exercises_completed', 50,   40,  3);


COMMIT;

-- Rollback:
-- BEGIN;
-- DROP TABLE IF EXISTS user_achievement;
-- DROP TABLE IF EXISTS user_streak;
-- DROP TABLE IF EXISTS daily_activity;
-- DROP TABLE IF EXISTS xp_event;
-- DROP TABLE IF EXISTS achievement;
-- DELETE FROM schema_version WHERE version = 14;
-- COMMIT;
