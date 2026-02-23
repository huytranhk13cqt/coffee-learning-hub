-- Migration 015: Make lesson_section.content nullable
-- Date: 2026-02-23
-- Purpose: Allow audio and video sections to store their resource URL in the
--   JSONB `metadata` column (e.g. {"src": "..."} or {"provider":"youtube","videoId":"..."}),
--   with no accompanying text body. Previously content was NOT NULL, forcing
--   audio/video rows to carry a meaningless empty string.
--
-- Backward compatibility: all existing rows have non-null content — no data is changed.
-- New audio/video sections simply omit content → stored as NULL.

BEGIN;

INSERT INTO schema_version (version, description)
VALUES (15, 'Make lesson_section.content nullable for audio/video sections');

ALTER TABLE lesson_section ALTER COLUMN content DROP NOT NULL;
ALTER TABLE lesson_section ALTER COLUMN content_vi DROP NOT NULL;

COMMIT;
