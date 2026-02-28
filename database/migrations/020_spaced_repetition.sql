-- Migration: Spaced Repetition (SM-2) review queue
-- Run AFTER applying previous migrations

CREATE TABLE IF NOT EXISTS exercise_review (
  id              SERIAL        PRIMARY KEY,
  session_id      VARCHAR(64)   NOT NULL,
  exercise_id     INTEGER       NOT NULL REFERENCES exercise(id) ON DELETE CASCADE,
  ease_factor     NUMERIC(4,2)  NOT NULL DEFAULT 2.5,
  interval_days   SMALLINT      NOT NULL DEFAULT 0,
  repetitions     SMALLINT      NOT NULL DEFAULT 0,
  last_review_at  TIMESTAMPTZ,
  next_review_at  DATE          NOT NULL DEFAULT CURRENT_DATE,
  created_at      TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
  CONSTRAINT uq_review_session_exercise UNIQUE (session_id, exercise_id),
  CONSTRAINT chk_ef CHECK (ease_factor >= 1.3 AND ease_factor <= 5.0)
);

CREATE INDEX IF NOT EXISTS idx_review_due
  ON exercise_review(session_id, next_review_at);

CREATE INDEX IF NOT EXISTS idx_review_session
  ON exercise_review(session_id);

-- Track in schema_version table
INSERT INTO schema_version (version, description)
VALUES (20, 'Add exercise_review table for SM-2 spaced repetition')
ON CONFLICT (version) DO NOTHING;
