-- Migration 009: Expand lesson_section_type ENUM
-- Date: 2026-02-15
-- Purpose: Add 'audio', 'video', 'chart', 'diagram' section types to support
--   rich media content across domains (music lessons, data viz, architecture diagrams).
--   PostgreSQL ENUMs are append-only — existing values unchanged.
--
-- NOTE: ALTER TYPE ... ADD VALUE cannot run inside a transaction block in PostgreSQL.
-- Each ADD VALUE is idempotent with IF NOT EXISTS, safe to re-run.

ALTER TYPE lesson_section_type ADD VALUE IF NOT EXISTS 'audio';
ALTER TYPE lesson_section_type ADD VALUE IF NOT EXISTS 'video';
ALTER TYPE lesson_section_type ADD VALUE IF NOT EXISTS 'chart';
ALTER TYPE lesson_section_type ADD VALUE IF NOT EXISTS 'diagram';

INSERT INTO schema_version (version, description)
VALUES (9, 'Expand lesson_section_type with audio, video, chart, diagram');

-- Rollback note:
-- PostgreSQL does not support removing ENUM values directly.
-- To roll back, recreate the type (requires dropping/recreating dependent columns).
-- This is intentionally append-only and safe — unused values have zero cost.
