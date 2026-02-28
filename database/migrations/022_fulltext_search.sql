-- Migration 022: Full-text search (tsvector computed column + GIN index)
--
-- 'simple' config: no stemming, no stop words — works for any language
-- (English, Vietnamese, technical terms all treated equally as tokens).
-- GENERATED ALWAYS AS STORED: auto-updated on INSERT/UPDATE, zero maintenance.
-- ============================================================================

ALTER TABLE lesson
  ADD COLUMN search_vector tsvector GENERATED ALWAYS AS (
    to_tsvector('simple',
      coalesce(name, '')          || ' ' ||
      coalesce(name_vi, '')       || ' ' ||
      coalesce(short_desc, '')    || ' ' ||
      coalesce(short_desc_vi, '')
    )
  ) STORED;

-- GIN index for fast @@ operator on lesson full-text search
CREATE INDEX idx_lesson_fts ON lesson USING GIN (search_vector);

-- Expression index on lesson_section so section-content search is also fast.
-- Not a stored column because content is mutable JSON/markdown text.
CREATE INDEX idx_lesson_section_fts
  ON lesson_section
  USING GIN (to_tsvector('simple',
    coalesce(content, '') || ' ' || coalesce(content_vi, '')
  ));

-- Expression index on exercise question search
CREATE INDEX idx_exercise_question_fts
  ON exercise
  USING GIN (to_tsvector('simple', coalesce(question, '') || ' ' || coalesce(question_vi, '')));

INSERT INTO schema_version (version, description)
VALUES (22, 'Add tsvector column and GIN indexes for full-text search on lesson, section, exercise');
