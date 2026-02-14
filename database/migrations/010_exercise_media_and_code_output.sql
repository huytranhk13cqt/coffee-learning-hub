-- Migration 010: Add media columns to exercise + code_output exercise type
-- Date: 2026-02-15
-- Purpose: Enable image/audio attachments on exercises and add code_output type
--   for "predict the output" style coding exercises.
--
-- NOTE: ALTER TYPE ... ADD VALUE cannot run inside a transaction block.

ALTER TYPE exercise_type ADD VALUE IF NOT EXISTS 'code_output';

ALTER TABLE exercise ADD COLUMN IF NOT EXISTS image_url VARCHAR(500) NULL;
ALTER TABLE exercise ADD COLUMN IF NOT EXISTS audio_url VARCHAR(500) NULL;

COMMENT ON COLUMN exercise.image_url IS 'Optional image for visual exercises (safe in GET)';
COMMENT ON COLUMN exercise.audio_url IS 'Optional audio clip for listening exercises (safe in GET)';

INSERT INTO schema_version (version, description)
VALUES (10, 'Add exercise image_url, audio_url columns and code_output type');

-- Rollback:
-- ALTER TABLE exercise DROP COLUMN IF EXISTS audio_url;
-- ALTER TABLE exercise DROP COLUMN IF EXISTS image_url;
-- DELETE FROM schema_version WHERE version = 10;
-- (exercise_type ENUM value cannot be removed without type recreation)
