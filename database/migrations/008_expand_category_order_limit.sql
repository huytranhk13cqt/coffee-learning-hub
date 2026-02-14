-- Migration 008: Expand category order_index constraint
-- Date: 2026-02-15
-- Purpose: Allow more than 10 categories by raising the order_index upper bound
--   from 10 to 20. Required for new content categories (Music Theory, Philosophy, etc.)

BEGIN;

INSERT INTO schema_version (version, description)
VALUES (8, 'Expand category order_index constraint from 10 to 20');

ALTER TABLE category DROP CONSTRAINT chk_category_order;
ALTER TABLE category ADD CONSTRAINT chk_category_order CHECK (order_index >= 0 AND order_index <= 20);

COMMIT;

-- Rollback (if needed):
-- BEGIN;
-- ALTER TABLE category DROP CONSTRAINT chk_category_order;
-- ALTER TABLE category ADD CONSTRAINT chk_category_order CHECK (order_index >= 0 AND order_index <= 10);
-- DELETE FROM schema_version WHERE version = 8;
-- COMMIT;
