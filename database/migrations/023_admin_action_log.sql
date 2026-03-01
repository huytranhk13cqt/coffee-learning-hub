-- Migration 023: Admin action log for audit trail
-- Tracks all admin write operations (create, update, delete, import)
-- ============================================================================

CREATE TABLE admin_action_log (
    id          SERIAL          PRIMARY KEY,
    action      VARCHAR(50)     NOT NULL,
    entity_type VARCHAR(50)     NOT NULL,
    entity_id   INTEGER         NULL,
    metadata    JSONB           NOT NULL DEFAULT '{}',
    ip_address  VARCHAR(45)     NULL,
    created_at  TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE admin_action_log IS 'Audit trail for admin write operations';
COMMENT ON COLUMN admin_action_log.action IS 'e.g. create, update, delete, import, login, logout';
COMMENT ON COLUMN admin_action_log.entity_type IS 'e.g. topic, category, lesson, exercise, learning_path';
COMMENT ON COLUMN admin_action_log.metadata IS 'Additional context (changed fields, old/new values, etc.)';

CREATE INDEX idx_admin_action_log_created ON admin_action_log(created_at DESC);
CREATE INDEX idx_admin_action_log_entity ON admin_action_log(entity_type, entity_id);

INSERT INTO schema_version (version, description)
VALUES (23, 'Add admin_action_log table for audit trail');
