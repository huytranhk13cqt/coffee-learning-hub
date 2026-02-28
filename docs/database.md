# Database Reference — Learning Hub

**Engine**: PostgreSQL 17 (Docker)
**Schema file**: `database/schema.sql`
**Migrations**: `database/migrations/` (v1–v19 in schema.sql + additional migration files)
**Connection**: `server/config/database.js` — postgres.js singleton, pool: 10

---

## Table Hierarchy

```
topic (6 rows)
  └── category (48 rows)
        └── lesson (124 rows)
              ├── formula           (grammar-specific: affirmative/negative/interrogative)
              ├── lesson_usage      (when/how to use)
              │     └── example     (sentences with optional highlight range)
              ├── signal_word       (grammar-specific: time/frequency/duration/etc.)
              ├── tip               (memory tricks, common mistakes, comparisons)
              ├── lesson_section    (generic data-driven content: markdown, chart, diagram, etc.)
              ├── lesson_comparison (side-by-side lesson comparison, lesson_id_1 < lesson_id_2)
              └── exercise          (726 rows, 8 types)
                    ├── exercise_option   (A–F choices for multiple_choice)
                    └── matching_pair     (left↔right pairs for matching)

user_progress   (UNIQUE session_id × lesson_id)
  └── exercise_attempt (UNIQUE session_id × exercise_id × attempt_number)

exercise_review (SM-2 spaced repetition queue — from migration)
learning_path   (curated lesson sequences — from migration)
  └── learning_path_step

bookmark        (session × lesson × section, reserved)
schema_version  (migration tracking)

── Gamification ──────────────────────────────────────
xp_event        (append-only event log — event sourcing)
daily_activity  (UNIQUE session_id × activity_date — streak source of truth)
achievement     (definitions, seeded with schema — 18 badges)
user_achievement (junction: session × achievement)
user_streak     (cached streak + daily goal per session)
```

---

## ENUMs (12)

| Type                   | Values                                                                                                                              |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `difficulty_level`     | `beginner`, `intermediate`, `advanced`                                                                                              |
| `exercise_difficulty`  | `easy`, `medium`, `hard`                                                                                                            |
| `exercise_type`        | `multiple_choice`, `fill_blank`, `error_correction`, `sentence_transform`, `arrange_words`, `matching`, `true_false`, `code_output` |
| `lesson_section_type`  | `markdown`, `key_points`, `info_box`, `audio`, `video`, `chart`, `diagram`, `image`, `interactive_chart`                            |
| `option_label`         | `A`, `B`, `C`, `D`, `E`, `F`                                                                                                        |
| `progress_status`      | `not_started`, `in_progress`, `completed`                                                                                           |
| `formula_type`         | `affirmative`, `negative`, `interrogative`                                                                                          |
| `signal_word_category` | `time`, `frequency`, `duration`, `sequence`, `other`                                                                                |
| `signal_word_position` | `beginning`, `middle`, `end`, `flexible`                                                                                            |
| `tip_category`         | `memory`, `common_mistake`, `comparison`, `native_usage`, `shortcut`, `general`                                                     |
| `importance_level`     | `low`, `medium`, `high`                                                                                                             |
| `section_type`         | `formula`, `usage`, `signal_word`, `tip`, `exercise`, `comparison`                                                                  |

---

## Key Tables

### `lesson`

Primary content entity. Belongs to `category` via `group_id` FK (legacy name).

| Column             | Type             | Notes                                               |
| ------------------ | ---------------- | --------------------------------------------------- |
| `id`               | SERIAL           | PK                                                  |
| `group_id`         | INTEGER          | FK → category.id (named group_id for legacy compat) |
| `name` / `name_vi` | VARCHAR(100)     | UNIQUE, bilingual                                   |
| `slug`             | VARCHAR(100)     | UNIQUE, URL-safe identifier                         |
| `difficulty`       | difficulty_level | beginner / intermediate / advanced                  |
| `is_published`     | BOOLEAN          | Filter: only published lessons served               |
| `order_index`      | SMALLINT         | Sort order within category                          |

**Indexes**: `(group_id)`, `(is_published, order_index)`, `(group_id, is_published, order_index)`, GIN trigram on `name` and `name_vi`

### `exercise`

**Security invariant**: `correct_answer` and `is_correct` (on `exercise_option`) must NEVER be returned by GET endpoints. Only the submit endpoint validates and returns correctness.

| Column                    | Type          | Notes                                           |
| ------------------------- | ------------- | ----------------------------------------------- |
| `type`                    | exercise_type | Determines which component/validator handles it |
| `correct_answer`          | VARCHAR(500)  | ⚠️ NEVER return on GET                          |
| `word_bank`               | JSONB         | Array of words for `arrange_words` type         |
| `content`                 | TEXT          | The sentence/text to interact with              |
| `image_url` / `audio_url` | VARCHAR(500)  | Optional media attachments                      |
| `points`                  | SMALLINT      | 1–100, default 10                               |

### `user_progress`

One row per `(session_id, lesson_id)` pair — enforced by UNIQUE constraint.

| Column              | Type            | Notes                                           |
| ------------------- | --------------- | ----------------------------------------------- |
| `session_id`        | VARCHAR(64)     | Browser UUID from localStorage                  |
| `status`            | progress_status | not_started → in_progress → completed           |
| `current_score`     | DECIMAL(5,2)    | Latest attempt %                                |
| `best_score`        | DECIMAL(5,2)    | Best attempt %                                  |
| `exercises_correct` | SMALLINT        | Always ≤ exercises_attempted (CHECK constraint) |

### `exercise_attempt`

UNIQUE on `(session_id, exercise_id, attempt_number)`. Race condition guard: `pg_advisory_xact_lock` in `getNextAttemptNumber`.

### `lesson_section`

Generic data-driven content sections replacing grammar-specific legacy tables. `content` is nullable for media sections (audio/video/image use `metadata` JSONB instead).

```sql
-- metadata examples:
-- info_box: { "variant": "warning" }
-- chart: { "type": "line", "data": [...] }
-- interactive_chart: { "generatorKey": "sine", "params": {...} }
```

### `exercise_review` (SM-2 Spaced Repetition — added via migration)

One row per `(session_id, exercise_id)`. Stores SM-2 state: `ease_factor`, `interval_days`, `repetitions`, `next_review_at`.

UPSERT pattern: `INSERT ON CONFLICT (session_id, exercise_id) DO UPDATE SET ...`

---

## Views

| View                   | Purpose                                                                         |
| ---------------------- | ------------------------------------------------------------------------------- |
| `v_lesson_summary`     | Lesson + category join with computed counts (formula, usage, exercise, etc.)    |
| `v_lesson_comparisons` | Bidirectional view for lesson_comparison (lesson_id_1 < lesson_id_2 constraint) |
| `v_exercise_stats`     | Aggregate stats per exercise across all sessions                                |

---

## Key Constraints & Invariants

| Constraint                                         | Where             | Why                                   |
| -------------------------------------------------- | ----------------- | ------------------------------------- |
| `UNIQUE (session_id, lesson_id)`                   | user_progress     | One progress row per session/lesson   |
| `UNIQUE (session_id, exercise_id, attempt_number)` | exercise_attempt  | No duplicate attempts                 |
| `lesson_id_1 < lesson_id_2`                        | lesson_comparison | Prevents both directions of same pair |
| `exercises_correct <= exercises_attempted`         | user_progress     | Data integrity CHECK                  |
| `pg_trgm` extension                                | schema            | Enables fuzzy search on lesson names  |

---

## Migrations

Migrations in `database/migrations/` are versioned SQL files. Each must:

1. Not use `BEGIN`/`COMMIT` with `ALTER TYPE ... ADD VALUE` (PostgreSQL restriction)
2. Update `schema_version` table with version + description
3. Be idempotent if possible (use `IF NOT EXISTS`, `IF EXISTS`)

See [`runbooks/migration.md`](./runbooks/migration.md) for step-by-step guide.
