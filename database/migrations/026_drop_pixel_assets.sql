-- Migration 026: Drop pixel_assets table (Asset Studio removed)
-- The image generation feature has been removed in favor of external tools.

DROP TABLE IF EXISTS pixel_assets;
