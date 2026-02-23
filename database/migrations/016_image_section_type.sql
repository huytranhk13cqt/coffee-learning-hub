-- Migration 016: Add 'image' section type
-- Date: 2026-02-23
-- Purpose: Allow dedicated image sections in lessons (alongside audio/video)
--
-- Note: ALTER TYPE ... ADD VALUE cannot run inside BEGIN/COMMIT in PostgreSQL.
-- Using IF NOT EXISTS for idempotency (safe to re-run).

ALTER TYPE lesson_section_type ADD VALUE IF NOT EXISTS 'image';
