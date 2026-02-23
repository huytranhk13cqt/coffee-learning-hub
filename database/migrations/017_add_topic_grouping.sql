-- Migration 017: Add topic grouping for category organization
-- Topics are meta-groups that organize related categories together
-- e.g., "STEM Sciences" groups Math, Physics, Chemistry, Medicine
--
-- Hierarchy: Topic → Category → Lesson → Exercise
-- topic_id on category is nullable for backward compatibility

-- 1. Create topic table
CREATE TABLE topic (
    id              SERIAL          PRIMARY KEY,
    name            VARCHAR(100)    NOT NULL,
    name_vi         VARCHAR(100)    NOT NULL,
    description     TEXT,
    description_vi  TEXT,
    icon            VARCHAR(50),
    color           VARCHAR(7)      NOT NULL DEFAULT '#6366f1',
    order_index     SMALLINT        NOT NULL DEFAULT 0,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),

    CONSTRAINT uq_topic_name  UNIQUE (name),
    CONSTRAINT chk_topic_color CHECK (color ~ '^#[0-9A-Fa-f]{6}$'),
    CONSTRAINT chk_topic_order CHECK (order_index >= 0 AND order_index <= 20)
);

CREATE INDEX idx_topic_order ON topic(order_index);

CREATE TRIGGER trg_topic_updated_at
    BEFORE UPDATE ON topic
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- 2. Add topic_id FK to category (nullable — categories may exist without a topic)
ALTER TABLE category
    ADD COLUMN topic_id INTEGER REFERENCES topic(id) ON DELETE SET NULL;

CREATE INDEX idx_category_topic ON category(topic_id);

-- 3. Track migration
INSERT INTO schema_version (version, description) VALUES
(17, 'Add topic grouping for category organization');
