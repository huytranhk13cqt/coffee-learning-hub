-- Migration 022: Full-text search GIN expression indexes
--
-- 'simple' config: no stemming, no stop words — works for Vietnamese + English + technical terms.
-- Expression-based indexes (NOT stored columns) so:
--   • No schema change to the lesson table
--   • Search query works before this migration (sequential scan)
--   • After migration, PostgreSQL auto-uses the GIN index when query expression matches exactly
-- ============================================================================

-- Lesson: search across name, name_vi, short_desc, short_desc_vi
CREATE INDEX idx_lesson_fts
  ON lesson
  USING GIN (
    to_tsvector('simple',
      coalesce(name, '') || ' ' ||
      coalesce(name_vi, '') || ' ' ||
      coalesce(short_desc, '') || ' ' ||
      coalesce(short_desc_vi, '')
    )
  );

-- Lesson section content (markdown/JSON body text)
CREATE INDEX idx_lesson_section_fts
  ON lesson_section
  USING GIN (
    to_tsvector('simple',
      coalesce(content, '') || ' ' || coalesce(content_vi, '')
    )
  );

-- Exercise questions
CREATE INDEX idx_exercise_question_fts
  ON exercise
  USING GIN (
    to_tsvector('simple',
      coalesce(question, '') || ' ' || coalesce(question_vi, '')
    )
  );

INSERT INTO schema_version (version, description)
VALUES (22, 'Add GIN expression indexes for full-text search on lesson, section, exercise');
