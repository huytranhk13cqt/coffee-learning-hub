# Database Schema Review - Grammar Learning Application

## Overview

This document provides a comprehensive review of the database schema, identifying improvements made, potential issues found, and recommendations.

---

## 1. Tables Added/Modified from Original Design

### New Tables Added

| Table | Reason |
|-------|--------|
| `matching_pair` | Support for matching-type exercises (M:N pairs) |
| `exercise_attempt` | Track individual exercise attempts for analytics |
| `bookmark` | User bookmarks for quick access to content |

### Columns Added to Existing Tables

| Table | New Column | Reason |
|-------|------------|--------|
| `lesson` | `short_desc`, `short_desc_vi` | Card display needs brief text |
| `lesson` | `estimated_time` | UX: Show time needed |
| `lesson` | `is_premium` | Future monetization |
| `formula` | `example_negative` | Show transformation |
| `usage` | `is_common` | Highlight important usages |
| `signal_word` | `category` | Group by type (time/frequency/etc) |
| `signal_word` | `example_sentence` | More context |
| `tip` | `title`, `importance` | Better organization |
| `exercise` | `content`, `word_bank`, `time_limit` | Support more exercise types |
| `user_progress` | `theory_completed`, `theory_time_spent` | Track theory separately |
| `user_progress` | `last_position` | Resume where left off |

---

## 2. Issues Found & Fixed

### Issue 1: Missing Bilingual Support

```
PROBLEM:
- Original design only had Vietnamese translations for some fields
- Inconsistent naming (_vi suffix)

FIX:
- Added _vi suffix consistently to ALL text fields
- description_vi, content_vi, explanation_vi, etc.
```

### Issue 2: Example Table Missing Direct Lesson Link

```
PROBLEM:
- To get all examples for a lesson, need JOIN through usage
- Query: lesson -> usage -> example (2 JOINs)

ANALYSIS:
- This is actually CORRECT design (3NF)
- Examples belong to specific usage contexts
- Adding lesson_id would create redundancy

DECISION: Keep as-is (proper normalization)
```

### Issue 3: Exercise Types Need Different Data Structures

```
PROBLEM:
- Different exercise types need different data:
  - multiple_choice: needs options
  - fill_blank: needs blank position
  - arrange_words: needs word list
  - matching: needs pairs

FIX:
- Added flexible columns: content, word_bank (JSON), correct_answer
- Created matching_pair table for matching exercises
- Keep exercise_option for multiple choice
```

### Issue 4: Signal Word Position Enum

```
PROBLEM:
- Original had 'any' which is vague

FIX:
- Changed to 'flexible' (more precise meaning)
- Added 'category' to group signal words
```

### Issue 5: User Progress Score Calculation

```
PROBLEM:
- exercises_correct / exercises_total = wrong formula
- Should be exercises_correct / exercises_attempted

FIX:
- Fixed in stored procedure sp_update_exercise_progress
- Added exercises_attempted for accurate tracking
```

---

## 3. Potential Issues Still Present

### Issue A: JSON Column (word_bank)

```sql
word_bank JSON NULL COMMENT 'Words to arrange (JSON array)'
```

**Concern:**
- JSON columns can't be indexed efficiently
- No schema validation at DB level

**Mitigation:**
- Only used for arrange_words type
- Validation should be done at application level
- Consider: Create separate `exercise_word` table if performance issues arise

**Recommendation:** Keep for now, monitor performance

---

### Issue B: Self-Referencing Comparison Limitation

```sql
CONSTRAINT chk_comparison_order CHECK (lesson_id_1 < lesson_id_2)
```

**Concern:**
- Query complexity: Need to check both directions
- Example query to find all comparisons for lesson 5:

```sql
SELECT * FROM lesson_comparison
WHERE lesson_id_1 = 5 OR lesson_id_2 = 5
```

**Alternative considered:**
- Store both directions (1,2) and (2,1)
- Rejected: Causes data duplication and sync issues

**Recommendation:** Keep current design, create helper view:

```sql
CREATE VIEW v_lesson_comparisons AS
SELECT id, lesson_id_1 AS lesson_id, lesson_id_2 AS compared_with, ... FROM lesson_comparison
UNION ALL
SELECT id, lesson_id_2 AS lesson_id, lesson_id_1 AS compared_with, ... FROM lesson_comparison;
```

---

### Issue C: Cascade Delete Chain Risk

```
DELETE lesson WHERE id = 1
  ├─ CASCADE → formula (3 rows)
  ├─ CASCADE → usage (5 rows)
  │              └─ CASCADE → example (15 rows)
  ├─ CASCADE → signal_word (10 rows)
  ├─ CASCADE → tip (5 rows)
  ├─ CASCADE → exercise (20 rows)
  │              ├─ CASCADE → exercise_option (80 rows)
  │              └─ CASCADE → matching_pair (10 rows)
  ├─ CASCADE → exercise_attempt (100+ rows)
  ├─ CASCADE → user_progress (50+ rows)
  └─ CASCADE → bookmark (20 rows)

Total: 300+ rows deleted from single DELETE
```

**Concern:**
- Accidental deletion could cause massive data loss
- No soft delete mechanism

**Recommendation:** Add soft delete:

```sql
-- Add to lesson table
ALTER TABLE lesson ADD COLUMN deleted_at TIMESTAMP NULL;
CREATE INDEX idx_lesson_deleted ON lesson(deleted_at);

-- Modify queries to exclude deleted
SELECT * FROM lesson WHERE deleted_at IS NULL;
```

**Decision:** Not implemented in v1.0 to keep schema simple. Add in future if needed.

---

### Issue D: Session ID Security

```sql
session_id VARCHAR(64) NOT NULL COMMENT 'Browser session UUID'
```

**Concern:**
- Session ID stored in localStorage is accessible via XSS
- No expiration mechanism
- Anyone with session_id can view progress

**Mitigation:**
- This is a local learning app, not sensitive data
- Progress data is not personally identifiable
- No authentication = acceptable risk for this use case

**Recommendation:** If deploying publicly:
1. Add session expiration
2. Consider fingerprinting
3. Rate limiting on API

---

### Issue E: Example Highlight Position

```sql
highlight_start INT UNSIGNED NULL,
highlight_end   INT UNSIGNED NULL,
```

**Concern:**
- Character positions can break if sentence is edited
- Multi-byte UTF-8 characters might cause offset issues

**Mitigation:**
- Added CHECK constraint ensuring start < end
- Application should recalculate on edit

**Alternative:**
- Use `highlight_word` VARCHAR instead (simpler)
- Let frontend find and highlight

**Recommendation:** Keep both options, prefer `highlight_word` for simplicity

---

### Issue F: No Audit Trail

**Concern:**
- No way to track who changed what and when
- Important for content management

**Recommendation for future:**

```sql
CREATE TABLE audit_log (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    table_name  VARCHAR(50) NOT NULL,
    record_id   INT UNSIGNED NOT NULL,
    action      ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    old_values  JSON NULL,
    new_values  JSON NULL,
    changed_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_audit_table (table_name, record_id)
);
```

**Decision:** Not implemented in v1.0 (local app, single user)

---

## 4. Performance Considerations

### Index Analysis

| Table | Index | Query Pattern | Status |
|-------|-------|---------------|--------|
| lesson | idx_lesson_group | WHERE group_id = ? | Good |
| lesson | idx_lesson_published | WHERE is_published ORDER BY | Good |
| formula | idx_formula_lesson | WHERE lesson_id = ? | Good |
| exercise | idx_exercise_lesson_type_diff | WHERE lesson_id AND type AND difficulty | Good |
| user_progress | idx_progress_session | WHERE session_id = ? | Good |

### Missing Indexes Identified

```sql
-- For querying comparisons by either lesson
CREATE INDEX idx_comparison_lessons ON lesson_comparison(lesson_id_1, lesson_id_2);

-- For date-based queries on attempts
CREATE INDEX idx_attempt_date ON exercise_attempt(created_at, session_id);
```

### Query Optimization Notes

1. **Lesson listing with counts**: Use the `v_lesson_summary` view
2. **Full lesson data**: Use `sp_get_lesson_full` stored procedure
3. **Progress updates**: Use `sp_update_exercise_progress` for atomic updates

---

## 5. Data Integrity Checklist

| Check | Implementation | Status |
|-------|----------------|--------|
| No orphan formulas | FK with CASCADE | OK |
| No orphan examples | FK with CASCADE | OK |
| Valid score range | CHECK constraint | OK |
| Valid color format | CHECK with REGEX | OK |
| Unique lesson slugs | UNIQUE constraint | OK |
| One formula per type per lesson | UNIQUE (lesson_id, type) | OK |
| Comparison pair uniqueness | UNIQUE + CHECK order | OK |
| Option label validity | CHECK IN ('A'-'F') | OK |
| Exercise score bounds | CHECK 0-100 | OK |
| Progress consistency | CHECK exercises_correct <= attempted | OK |

---

## 6. Normalization Verification

### 1NF Compliance
- All columns contain atomic values
- No repeating groups
- JSON used only for dynamic arrays (word_bank)

### 2NF Compliance
- No partial dependencies (no composite PKs except junction tables)
- Junction table (lesson_comparison) has proper structure

### 3NF Compliance
- No transitive dependencies
- tense_group properly separated from lesson
- example properly linked through usage (not directly to lesson)

### BCNF Compliance
- All determinants are candidate keys
- No anomalies detected

---

## 7. Recommendations Summary

### Must Fix (Before Production)

| Priority | Issue | Action |
|----------|-------|--------|
| HIGH | None critical | - |

### Should Fix (v1.1)

| Priority | Issue | Action |
|----------|-------|--------|
| MEDIUM | Soft delete | Add deleted_at to lesson, exercise |
| MEDIUM | Comparison view | Create v_lesson_comparisons |
| LOW | Audit trail | Add audit_log table |

### Consider for Future

| Issue | When to Address |
|-------|-----------------|
| Session expiration | If deploying publicly |
| Full-text search | If content grows large |
| Partitioning | If data exceeds 1M rows |

---

## 8. Final Assessment

### Schema Quality Score

| Criteria | Score | Notes |
|----------|-------|-------|
| Normalization | 9/10 | Proper 3NF, JSON acceptable |
| Data Integrity | 9/10 | Comprehensive constraints |
| Performance | 8/10 | Good indexes, can optimize |
| Flexibility | 8/10 | Supports multiple exercise types |
| Maintainability | 8/10 | Clear naming, documented |
| Security | 7/10 | Acceptable for local app |

**Overall: 8.2/10 - Production Ready for Local Use**

---

## 9. Schema Statistics

```
Tables:           14
Views:             3
Stored Procedures: 2
Triggers:          2
Indexes:          35+
Foreign Keys:     13
Check Constraints: 12
Unique Constraints: 9
```

---

*Review completed: Ready for implementation*
