-- Migration 025: Pixel Assets table for Asset Studio
-- Stores metadata for generated/uploaded pixel art sprites

CREATE TABLE pixel_assets (
  id          SERIAL PRIMARY KEY,
  name        VARCHAR(255) NOT NULL,
  type        VARCHAR(50) NOT NULL DEFAULT 'sprite',
  path        VARCHAR(500) NOT NULL,
  width       INTEGER,
  height      INTEGER,
  frame_count INTEGER DEFAULT 1,
  tags        TEXT[] DEFAULT '{}',
  prompt      TEXT,
  model       VARCHAR(100),
  file_size   INTEGER,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_pixel_assets_type ON pixel_assets(type);
CREATE INDEX idx_pixel_assets_created_at ON pixel_assets(created_at DESC);
