-- Migration 021: Learning Paths for curated lesson sequences

CREATE TABLE IF NOT EXISTS learning_path (
  id              SERIAL        PRIMARY KEY,
  slug            VARCHAR(100)  NOT NULL UNIQUE,
  name            VARCHAR(200)  NOT NULL,
  name_vi         VARCHAR(200)  NOT NULL,
  description     TEXT,
  description_vi  TEXT,
  icon            VARCHAR(50)   DEFAULT 'RouteOutlined',
  color           VARCHAR(7)    DEFAULT '#6366f1',
  estimated_days  SMALLINT      DEFAULT 7,
  is_featured     BOOLEAN       DEFAULT FALSE,
  order_index     SMALLINT      DEFAULT 0,
  is_active       BOOLEAN       DEFAULT TRUE,
  created_at      TIMESTAMPTZ   DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS learning_path_step (
  id          SERIAL    PRIMARY KEY,
  path_id     INTEGER   NOT NULL REFERENCES learning_path(id) ON DELETE CASCADE,
  lesson_id   INTEGER   NOT NULL REFERENCES lesson(id) ON DELETE CASCADE,
  order_index SMALLINT  NOT NULL,
  CONSTRAINT uq_path_step_order UNIQUE(path_id, order_index),
  CONSTRAINT uq_path_step_lesson UNIQUE(path_id, lesson_id)
);

CREATE INDEX IF NOT EXISTS idx_path_step_path ON learning_path_step(path_id, order_index);

INSERT INTO schema_version (version, description)
VALUES (21, 'Add learning_path and learning_path_step tables')
ON CONFLICT (version) DO NOTHING;
