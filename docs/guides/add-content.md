# Guide: Adding New Lessons and Exercises

Two methods: **YAML import** (recommended) or **raw SQL seed files**.

---

## Method 1: YAML Import (Recommended)

The YAML authoring tool (`scripts/import-lesson.js`) validates the schema and imports in one command.

### Quick Start

```bash
# Dry-run first (no DB writes)
node scripts/import-lesson.js database/content/my-lesson.yaml --dry-run

# Import for real
node scripts/import-lesson.js database/content/my-lesson.yaml

# Import entire directory
node scripts/import-lesson.js database/content/
```

### Minimal Lesson YAML

````yaml
type: lesson
category: python-basics # Must match category.name in DB
name: 'List Comprehensions'
name_vi: 'Danh sách rút gọn'
slug: python-list-comprehensions # URL-safe, unique
difficulty: intermediate # beginner | intermediate | advanced
estimated_time: 20 # minutes
short_desc: 'Build lists elegantly with one-liners'
short_desc_vi: 'Xây dựng danh sách gọn gàng với một dòng code'

sections:
  - type: markdown
    title: 'What is a List Comprehension?'
    content: |
      A **list comprehension** provides a concise way to create lists.

      ```python
      squares = [x**2 for x in range(10)]
      ```

  - type: key_points
    title: 'Key Points'
    content: |
      - Syntax: `[expression for item in iterable if condition]`
      - The `if` condition is optional
      - Always returns a new list

  - type: info_box
    title: 'Performance Note'
    content: 'List comprehensions are faster than equivalent `for` loops in CPython.'
    metadata:
      variant: info # info | warning | success | error

exercises:
  - type: multiple_choice
    difficulty: easy
    question: 'What does `[x*2 for x in [1,2,3]]` return?'
    question_vi: '`[x*2 for x in [1,2,3]]` trả về gì?'
    correct_answer: 'B'
    options:
      - label: A
        content: '[1, 2, 3]'
        is_correct: false
      - label: B
        content: '[2, 4, 6]'
        is_correct: true
      - label: C
        content: '[1, 4, 9]'
        is_correct: false

  - type: fill_blank
    difficulty: medium
    question: 'Complete the list comprehension to get even numbers from 0–9:'
    content: '[x for x in range(10) if x ___ 2 == 0]'
    correct_answer: '%'
    explanation: 'The modulo operator `%` checks divisibility.'
    explanation_vi: 'Toán tử `%` kiểm tra tính chia hết.'

  - type: code_output
    difficulty: hard
    question: 'What is printed?'
    content: |
      ```python
      data = [1, 2, 3, 4, 5]
      result = [x**2 for x in data if x % 2 != 0]
      print(result)
      ```
    correct_answer: '[1, 9, 25]'
````

### Exercise Types Reference

| Type                 | `correct_answer` format | Special fields                                    |
| -------------------- | ----------------------- | ------------------------------------------------- |
| `multiple_choice`    | `"A"` – `"F"`           | `options[]` with `label`, `content`, `is_correct` |
| `fill_blank`         | string                  | `content` has `___` as blank                      |
| `error_correction`   | corrected string        | `content` = erroneous sentence                    |
| `sentence_transform` | transformed string      | `context` = transformation instruction            |
| `arrange_words`      | joined sentence         | `word_bank` YAML list of words                    |
| `true_false`         | `"true"` or `"false"`   | —                                                 |
| `matching`           | —                       | `pairs[]` with `left`, `right`                    |
| `code_output`        | expected output string  | `content` = code block                            |

### Section Types Reference

| Type                | `content`          | `metadata`                                     |
| ------------------- | ------------------ | ---------------------------------------------- |
| `markdown`          | Markdown text      | —                                              |
| `key_points`        | Markdown list      | —                                              |
| `info_box`          | Markdown text      | `{ variant: "info\|warning\|success\|error" }` |
| `chart`             | —                  | `{ type, data, xKey, yKeys, colors }`          |
| `interactive_chart` | —                  | `{ generatorKey, title, params }`              |
| `diagram`           | Mermaid DSL        | —                                              |
| `image`             | caption (optional) | `{ src, alt }`                                 |
| `audio`             | caption (optional) | `{ src }`                                      |
| `video`             | caption (optional) | `{ src }`                                      |

---

## Method 2: Raw SQL Seed Files

For bulk imports or grammar-specific content (formula, signal_word tables):

```bash
# Naming convention
database/seed_<topic-slug>.sql

# Apply
docker exec -i knowledge-postgres psql -U relax_user -d knowledge_learning \
  < database/seed_my-topic.sql
```

SQL seed files directly INSERT into tables. See `database/seed_data.sql` for examples.

---

## Adding a New Category (Topic → Category → Lessons)

1. **Check if topic exists**:

   ```sql
   SELECT id, name FROM topic ORDER BY order_index;
   ```

2. **Insert category** (if topic exists):

   ```sql
   INSERT INTO category (topic_id, name, name_vi, icon, color, order_index)
   VALUES (3, 'Machine Learning', 'Học máy', 'Psychology', '#10b981', 5);
   ```

3. **Update `database/seed_topics.sql`** with the new category so fresh installs get it.

4. **Import lessons** via YAML pointing to the new category name.

---

## Verifying After Import

```bash
# Check lesson exists
docker exec -it knowledge-postgres psql -U relax_user -d knowledge_learning \
  -c "SELECT id, name, slug, (SELECT COUNT(*) FROM exercise WHERE lesson_id = l.id) as ex_count FROM lesson l WHERE slug = 'python-list-comprehensions';"

# Visit in app
open http://localhost:5173  # Find the lesson in its category
```
