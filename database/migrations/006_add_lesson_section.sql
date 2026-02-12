-- Migration 006: Add lesson_section table for data-driven content rendering
-- Date: 2026-02-12
-- Purpose: Enable non-grammar lessons to define flexible, ordered content
--   sections. Grammar lessons continue using legacy tables (formula,
--   lesson_usage, signal_word, tip, lesson_comparison). New lessons use
--   lesson_section for data-driven rendering with markdown support.
--
-- Section types:
--   markdown   — Free-form markdown content (headings, bold, lists, code, etc.)
--   key_points — Bullet list of key takeaways (content is markdown)
--   info_box   — Callout/alert box (metadata.variant: info|warning|tip|example)

BEGIN;

INSERT INTO schema_version (version, description)
VALUES (6, 'Add lesson_section table for data-driven content rendering');

-- New ENUM for lesson section types (separate from bookmark section_type)
CREATE TYPE lesson_section_type AS ENUM ('markdown', 'key_points', 'info_box');

-- Generic ordered content sections
CREATE TABLE lesson_section (
    id          SERIAL          PRIMARY KEY,
    lesson_id   INTEGER         NOT NULL REFERENCES lesson(id) ON DELETE CASCADE,
    type        lesson_section_type NOT NULL,
    title       VARCHAR(255),
    title_vi    VARCHAR(255),
    content     TEXT            NOT NULL,
    content_vi  TEXT,
    metadata    JSONB           NOT NULL DEFAULT '{}',
    order_index SMALLINT        NOT NULL DEFAULT 0,
    created_at  TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_lesson_section_lesson ON lesson_section(lesson_id, order_index);

COMMENT ON TABLE lesson_section IS 'Generic ordered content sections for data-driven lesson rendering';
COMMENT ON COLUMN lesson_section.type IS 'Rendering type: markdown (free-form), key_points (bullet list), info_box (callout)';
COMMENT ON COLUMN lesson_section.content IS 'Markdown content (rendered client-side via marked + DOMPurify)';
COMMENT ON COLUMN lesson_section.content_vi IS 'Vietnamese translation of content (markdown)';
COMMENT ON COLUMN lesson_section.metadata IS 'Extra rendering hints: {variant: "info"|"warning"|"tip"|"example"} for info_box';

COMMIT;

-- Rollback (if needed):
-- BEGIN;
-- DROP TABLE IF EXISTS lesson_section;
-- DROP TYPE IF EXISTS lesson_section_type;
-- DELETE FROM schema_version WHERE version = 6;
-- COMMIT;
