-- Migration 018: Add interactive_chart to lesson_section_type ENUM
-- Interactive charts allow students to manipulate parameters via sliders
-- and see real-time chart updates (Explorable Explanations pattern)
--
-- NOTE: ALTER TYPE ... ADD VALUE cannot run inside BEGIN/COMMIT in PostgreSQL
-- This migration must be run outside of a transaction block.

ALTER TYPE lesson_section_type ADD VALUE IF NOT EXISTS 'interactive_chart';

INSERT INTO schema_version (version, description) VALUES
(18, 'Add interactive_chart to lesson_section_type ENUM');
