# Runbook: Database Migrations

> Use this when: adding new columns/tables, changing ENUMs, or modifying constraints.

---

## How Migrations Work

Migrations are SQL files in `database/migrations/`. They run incrementally.
The `schema_version` table tracks which migrations have been applied.

**Schema version flow**:
`schema.sql` (v1–v19 baked in) → `migrations/020_*.sql` → `migrations/021_*.sql` → ...

---

## Step-by-Step: Writing a New Migration

### 1. Find the next version number

```bash
docker exec -it knowledge-postgres psql -U relax_user -d knowledge_learning \
  -c "SELECT MAX(version) FROM schema_version;"
```

If result is `22`, your new migration is `023`.

### 2. Create the migration file

```bash
touch database/migrations/023_your_description.sql
```

### 3. Write the migration

**Template**:

```sql
-- Migration 023: Short description
-- ============================================================================

-- Your DDL changes here
ALTER TABLE lesson ADD COLUMN IF NOT EXISTS new_col VARCHAR(100);

-- ⚠️ If adding ENUM values: CANNOT run inside BEGIN/COMMIT
ALTER TYPE exercise_type ADD VALUE IF NOT EXISTS 'new_type';

-- Update schema_version (always last)
INSERT INTO schema_version (version, description)
VALUES (23, 'Add new_col to lesson, new_type to exercise_type');
```

### 4. Critical Rules

| Rule                                                    | Reason                                                              |
| ------------------------------------------------------- | ------------------------------------------------------------------- |
| `ALTER TYPE ... ADD VALUE` must be OUTSIDE transactions | PostgreSQL restriction — will error if inside BEGIN/COMMIT          |
| Use `IF NOT EXISTS` / `IF EXISTS`                       | Makes migration re-runnable (idempotent)                            |
| `INSERT INTO schema_version` always last                | Ensures version is only recorded if all DDL succeeded               |
| Never modify `schema.sql` directly                      | schema.sql is the baseline; migrations are incremental deltas       |
| Test with `--dry-run` if touching data                  | Use transactions for DML: `BEGIN; UPDATE ...; ROLLBACK;` to preview |

---

## Applying a Migration

```bash
# Apply to local Docker DB
docker exec -i knowledge-postgres psql -U relax_user -d knowledge_learning \
  < database/migrations/023_your_description.sql

# Verify
docker exec -it knowledge-postgres psql -U relax_user -d knowledge_learning \
  -c "SELECT version, description, applied_at FROM schema_version ORDER BY version DESC LIMIT 3;"
```

---

## Rollback Strategy

PostgreSQL DDL is **not easily reversible**. Before applying:

1. For column additions: `ALTER TABLE ... DROP COLUMN IF EXISTS ...`
2. For table additions: `DROP TABLE IF EXISTS ...`
3. For ENUM additions: No rollback (can only add, never remove ENUM values in PG)
4. For data migrations: Always wrap DML in `BEGIN; ... ROLLBACK;` to test first

**Best practice**: Write the rollback script alongside the migration before applying.

---

## ENUM-Specific Workflow

PostgreSQL does not allow removing ENUM values. Plan carefully before adding.

```sql
-- ✅ Correct — outside any transaction
ALTER TYPE lesson_section_type ADD VALUE IF NOT EXISTS 'quiz';

-- ❌ Wrong — will fail with "ALTER TYPE cannot run inside a transaction block"
BEGIN;
ALTER TYPE lesson_section_type ADD VALUE 'quiz';
COMMIT;
```

In migration files: simply don't wrap ENUM changes in BEGIN/COMMIT.
Other DDL (CREATE TABLE, ALTER TABLE, etc.) can still use transactions.

---

## Checking Schema State

```bash
# All migrations applied
docker exec -it knowledge-postgres psql -U relax_user -d knowledge_learning \
  -c "SELECT * FROM schema_version ORDER BY version;"

# Current table list
docker exec -it knowledge-postgres psql -U relax_user -d knowledge_learning -c "\dt"

# ENUM values
docker exec -it knowledge-postgres psql -U relax_user -d knowledge_learning \
  -c "SELECT enumlabel FROM pg_enum JOIN pg_type ON pg_enum.enumtypid = pg_type.oid WHERE typname = 'exercise_type' ORDER BY enumsortorder;"
```
