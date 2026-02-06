# Entity Relationship Diagram - Grammar Learning Database

## Complete ERD Visualization

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃                                     GRAMMAR LEARNING DATABASE                                      ┃
┃                                         14 Tables | 4 Views                                        ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

                                    ┌─────────────────────┐
                                    │    tense_group      │
                                    ├─────────────────────┤
                                    │ PK  id              │
                                    │     name            │
                                    │     name_vi         │
                                    │     description     │
                                    │     color           │
                                    │     order_index     │
                                    └──────────┬──────────┘
                                               │
                                               │ 1:N
                                               │ ON DELETE RESTRICT
                                               ▼
┌──────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                                                                                      │
│  ┌─────────────────────────────────────────────────────────────────────────────────────────────────┐ │
│  │                                         lesson                                                  │ │
│  ├─────────────────────────────────────────────────────────────────────────────────────────────────┤ │
│  │ PK  id            │ FK  group_id      │     name          │     slug          │     difficulty │ │
│  │     name_vi       │     short_desc    │     description   │     estimated_time│     order_index│ │
│  │     is_published  │     is_premium    │     created_at    │     updated_at    │                │ │
│  └─────────────────────────────────────────────────────────────────────────────────────────────────┘ │
│                                                                                                      │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘
         │                    │                    │                    │                    │
         │ 1:N                │ 1:N                │ 1:N                │ 1:N                │ 1:N
         │                    │                    │                    │                    │
         ▼                    ▼                    ▼                    ▼                    ▼
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│    formula      │  │     usage       │  │  signal_word    │  │      tip        │  │    exercise     │
├─────────────────┤  ├─────────────────┤  ├─────────────────┤  ├─────────────────┤  ├─────────────────┤
│PK id            │  │PK id            │  │PK id            │  │PK id            │  │PK id            │
│FK lesson_id     │  │FK lesson_id     │  │FK lesson_id     │  │FK lesson_id     │  │FK lesson_id     │
│   type (+/-/?)  │  │   title         │  │   word          │  │   title         │  │   type          │
│   structure     │  │   title_vi      │  │   word_vi       │  │   content       │  │   difficulty    │
│   structure_vi  │  │   description   │  │   category      │  │   content_vi    │  │   question      │
│   example       │  │   description_vi│  │   example       │  │   category      │  │   content       │
│   example_vi    │  │   is_common     │  │   position      │  │   importance    │  │   correct_answer│
│   note          │  │   order_index   │  │   note          │  │   order_index   │  │   word_bank JSON│
│   order_index   │  │                 │  │   order_index   │  │                 │  │   explanation   │
└─────────────────┘  └────────┬────────┘  └─────────────────┘  └─────────────────┘  └────────┬────────┘
                              │                                                              │
                              │ 1:N                                                          │
                              ▼                                                              │
                     ┌─────────────────┐                                                     │
                     │    example      │                                                     │
                     ├─────────────────┤                                                     │
                     │PK id            │                                                     │
                     │FK usage_id      │                                                     │
                     │   sentence      │                                                     │
                     │   sentence_vi   │                                                     │
                     │   explanation   │                                                     │
                     │   highlight_word│                                                     │
                     │   audio_url     │                                                     │
                     │   order_index   │                                                     │
                     └─────────────────┘                                                     │
                                                                                             │
                     ┌───────────────────────────────────────────────────────────────────────┘
                     │
                     │ 1:N                                           1:N
                     ▼                                                ▼
         ┌─────────────────────┐                          ┌─────────────────────┐
         │  exercise_option    │                          │   matching_pair     │
         ├─────────────────────┤                          ├─────────────────────┤
         │PK id                │                          │PK id                │
         │FK exercise_id       │                          │FK exercise_id       │
         │   label (A,B,C,D)   │                          │   left_content      │
         │   content           │                          │   left_content_vi   │
         │   content_vi        │                          │   right_content     │
         │   is_correct        │                          │   right_content_vi  │
         │   explanation       │                          │   order_index       │
         │   order_index       │                          │                     │
         └─────────────────────┘                          └─────────────────────┘



┌──────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                              SELF-REFERENCING M:N RELATIONSHIP                                       │
├──────────────────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                                      │
│         lesson                    lesson_comparison                     lesson                       │
│     ┌───────────┐              ┌─────────────────────┐              ┌───────────┐                   │
│     │    id     │◄─────────────│ FK lesson_id_1      │              │    id     │                   │
│     │   name    │              │ FK lesson_id_2      │─────────────►│   name    │                   │
│     │   ...     │              │    aspect           │              │   ...     │                   │
│     └───────────┘              │    lesson_1_point   │              └───────────┘                   │
│                                │    lesson_2_point   │                                              │
│                                │    example_1        │                                              │
│     Constraint:                │    example_2        │                                              │
│     lesson_id_1 < lesson_id_2  │    tip              │                                              │
│     (Avoid duplicate pairs)    └─────────────────────┘                                              │
│                                                                                                      │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘



┌──────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                    USER TRACKING (No Auth)                                           │
├──────────────────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                                      │
│     ┌─────────────────────┐           ┌─────────────────────┐           ┌─────────────────────┐     │
│     │   user_progress     │           │  exercise_attempt   │           │     bookmark        │     │
│     ├─────────────────────┤           ├─────────────────────┤           ├─────────────────────┤     │
│     │PK id                │           │PK id                │           │PK id                │     │
│     │   session_id  ──────┼───────────┼── session_id        │───────────┼── session_id        │     │
│     │FK lesson_id         │           │FK exercise_id       │           │FK lesson_id         │     │
│     │   status            │           │   user_answer       │           │   section_type      │     │
│     │   theory_completed  │           │   is_correct        │           │   section_id        │     │
│     │   exercises_attempted│          │   time_taken        │           │   note              │     │
│     │   exercises_correct │           │   attempt_number    │           │   created_at        │     │
│     │   best_score        │           │   created_at        │           │                     │     │
│     │   total_time_spent  │           │                     │           │                     │     │
│     │   last_access       │           │                     │           │                     │     │
│     └─────────────────────┘           └─────────────────────┘           └─────────────────────┘     │
│                                                                                                      │
│     session_id = UUID generated by browser, stored in localStorage                                   │
│                                                                                                      │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## Relationship Summary

| Parent Table | Child Table | Relationship | ON DELETE | ON UPDATE |
|-------------|-------------|--------------|-----------|-----------|
| tense_group | lesson | 1:N | RESTRICT | CASCADE |
| lesson | formula | 1:N | CASCADE | CASCADE |
| lesson | usage | 1:N | CASCADE | CASCADE |
| lesson | signal_word | 1:N | CASCADE | CASCADE |
| lesson | tip | 1:N | CASCADE | CASCADE |
| lesson | exercise | 1:N | CASCADE | CASCADE |
| lesson | user_progress | 1:N | CASCADE | CASCADE |
| lesson | bookmark | 1:N | CASCADE | CASCADE |
| lesson | lesson_comparison | M:N (self) | CASCADE | CASCADE |
| usage | example | 1:N | CASCADE | CASCADE |
| exercise | exercise_option | 1:N | CASCADE | CASCADE |
| exercise | matching_pair | 1:N | CASCADE | CASCADE |
| exercise | exercise_attempt | 1:N | CASCADE | CASCADE |

---

## Data Flow Diagram

```
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                                    DATA FLOW                                             │
├─────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                          │
│    ┌──────────────┐                                                                     │
│    │   BROWSER    │                                                                     │
│    │              │                                                                     │
│    │ localStorage │─── session_id (UUID) ───┐                                           │
│    │              │                          │                                           │
│    └──────────────┘                          │                                           │
│           │                                  │                                           │
│           │ API Request                      │                                           │
│           ▼                                  ▼                                           │
│    ┌──────────────┐                  ┌──────────────┐                                   │
│    │   Express    │                  │    MySQL     │                                   │
│    │   Server     │◄────────────────►│   Database   │                                   │
│    └──────────────┘                  └──────────────┘                                   │
│           │                                  │                                           │
│           │                                  │                                           │
│           ▼                                  ▼                                           │
│    ┌─────────────────────────────────────────────────────────────────────────────┐     │
│    │                              QUERY PATTERNS                                  │     │
│    ├─────────────────────────────────────────────────────────────────────────────┤     │
│    │                                                                              │     │
│    │  1. List Lessons:                                                           │     │
│    │     SELECT * FROM v_lesson_summary WHERE is_published = TRUE                │     │
│    │                                                                              │     │
│    │  2. Get Full Lesson:                                                        │     │
│    │     CALL sp_get_lesson_full(lesson_id)                                      │     │
│    │                                                                              │     │
│    │  3. Get Comparisons:                                                        │     │
│    │     SELECT * FROM v_lesson_comparisons WHERE lesson_id = ?                  │     │
│    │                                                                              │     │
│    │  4. Submit Answer:                                                          │     │
│    │     CALL sp_update_exercise_progress(session_id, lesson_id, ...)           │     │
│    │                                                                              │     │
│    │  5. Get Progress:                                                           │     │
│    │     CALL sp_get_session_progress(session_id)                               │     │
│    │                                                                              │     │
│    └─────────────────────────────────────────────────────────────────────────────┘     │
│                                                                                          │
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## Index Strategy Visualization

```
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                              INDEX COVERAGE MAP                                          │
├─────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                          │
│  lesson table:                                                                           │
│  ┌─────────────────────────────────────────────────────────────────────────────────┐   │
│  │ Query: WHERE group_id = ? AND is_published = TRUE ORDER BY order_index          │   │
│  │                                                                                  │   │
│  │ Indexes:  idx_lesson_group ────────► [group_id]                                 │   │
│  │           idx_lesson_published ────► [is_published, order_index]                │   │
│  │                                                                                  │   │
│  │ Coverage: ✓ Fully indexed                                                       │   │
│  └─────────────────────────────────────────────────────────────────────────────────┘   │
│                                                                                          │
│  exercise table:                                                                         │
│  ┌─────────────────────────────────────────────────────────────────────────────────┐   │
│  │ Query: WHERE lesson_id = ? AND type = ? AND difficulty = ? AND is_active = TRUE │   │
│  │                                                                                  │   │
│  │ Index:   idx_exercise_lesson_type_diff ─► [lesson_id, type, difficulty]         │   │
│  │          idx_exercise_lesson_active ────► [lesson_id, is_active]                │   │
│  │                                                                                  │   │
│  │ Coverage: ✓ Composite index follows "equality first" rule                       │   │
│  └─────────────────────────────────────────────────────────────────────────────────┘   │
│                                                                                          │
│  user_progress table:                                                                    │
│  ┌─────────────────────────────────────────────────────────────────────────────────┐   │
│  │ Query: WHERE session_id = ? ORDER BY last_access DESC                           │   │
│  │                                                                                  │   │
│  │ Indexes:  idx_progress_session ────────► [session_id]                           │   │
│  │           idx_progress_last_access ────► [last_access]                          │   │
│  │           UNIQUE constraint ───────────► [session_id, lesson_id]                │   │
│  │                                                                                  │   │
│  │ Coverage: ✓ Optimized for session-based queries                                 │   │
│  └─────────────────────────────────────────────────────────────────────────────────┘   │
│                                                                                          │
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## Cascade Delete Chain

```
DELETE FROM lesson WHERE id = 1

                    lesson (id=1)
                         │
         ┌───────────────┼───────────────┬───────────────┬───────────────┐
         │               │               │               │               │
         ▼               ▼               ▼               ▼               ▼
    ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐
    │ formula │    │  usage  │    │signal_  │    │   tip   │    │exercise │
    │ (3 rows)│    │ (5 rows)│    │  word   │    │ (4 rows)│    │(7 rows) │
    └─────────┘    └────┬────┘    │(10 rows)│    └─────────┘    └────┬────┘
                        │         └─────────┘                        │
                        ▼                                            │
                   ┌─────────┐                         ┌─────────────┼─────────────┐
                   │ example │                         │             │             │
                   │(15 rows)│                         ▼             ▼             ▼
                   └─────────┘                   ┌─────────┐   ┌─────────┐   ┌─────────┐
                                                 │ option  │   │matching │   │ attempt │
                                                 │(28 rows)│   │  pair   │   │(100+row)│
                                                 └─────────┘   │ (4 rows)│   └─────────┘
                                                               └─────────┘
    Also deleted:
    ┌─────────────┐    ┌─────────────┐    ┌─────────────────┐
    │user_progress│    │  bookmark   │    │lesson_comparison│
    │  (50+ rows) │    │  (20 rows)  │    │    (3 rows)     │
    └─────────────┘    └─────────────┘    └─────────────────┘

    TOTAL: ~250+ rows deleted from single DELETE statement

    ⚠️  SAFETY: tense_group → lesson uses RESTRICT (blocks delete if lessons exist)
```
