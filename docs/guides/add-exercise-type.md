# Guide: Adding a New Exercise Type

The exercise system uses a **Registry pattern** — adding a new type requires exactly 4 steps.

---

## Overview of What to Change

```
1. DB ENUM         database/migrations/0XX_add_<type>_exercise.sql
2. Server validator server/services/answerValidator.js
3. Client component src/components/exercise/types/<TypeName>.jsx
4. Client registry  src/components/exercise/registry.js
```

---

## Step 1: Add ENUM Value (Database Migration)

```sql
-- database/migrations/023_add_diagram_label_exercise.sql

-- ⚠️ ENUM ADD VALUE must be OUTSIDE any transaction
ALTER TYPE exercise_type ADD VALUE IF NOT EXISTS 'diagram_label';

INSERT INTO schema_version (version, description)
VALUES (23, 'Add diagram_label exercise type');
```

Apply:

```bash
docker exec -i knowledge-postgres psql -U relax_user -d knowledge_learning \
  < database/migrations/023_add_diagram_label_exercise.sql
```

---

## Step 2: Add Server Validator (`server/services/answerValidator.js`)

```js
// Add to the validators registry object:
diagram_label: (exercise, userAnswer) => {
  if (typeof userAnswer !== 'string') return false;
  // Case-insensitive, trim whitespace
  return userAnswer.trim().toLowerCase() === exercise.correct_answer.trim().toLowerCase();
},
```

The validator receives `exercise` (from DB, including `correct_answer`) and `userAnswer` (from POST body). Return `boolean`.

---

## Step 3: Create Client Component

```jsx
// src/components/exercise/types/DiagramLabel.jsx

export default function DiagramLabel({
  exercise,
  answer,
  onAnswerChange,
  disabled,
}) {
  return (
    <Box>
      {exercise.image_url && (
        <Box
          component="img"
          src={exercise.image_url}
          alt="diagram"
          sx={{ maxWidth: '100%', mb: 2 }}
        />
      )}
      <TextField
        label="Label the diagram element"
        value={answer ?? ''}
        onChange={(e) => onAnswerChange(e.target.value)}
        disabled={disabled}
        fullWidth
      />
    </Box>
  );
}
```

**Interface** (all components must implement this):

```ts
interface ExerciseTypeProps {
  exercise: object; // exercise row + options/pairs
  answer: any; // current answer value (controlled)
  onAnswerChange: (answer: any) => void;
  disabled: boolean; // true during submission / after feedback
}
```

---

## Step 4: Register in Client Registry

```js
// src/components/exercise/registry.js
import DiagramLabel from './types/DiagramLabel.jsx';

const registry = {
  // ... existing types ...
  diagram_label: DiagramLabel, // ← add this line
};
```

---

## Step 5: Update YAML Schema (if using YAML import)

```js
// scripts/lesson-schema.js
const EXERCISE_TYPES = [
  'multiple_choice',
  'fill_blank',
  'error_correction',
  'sentence_transform',
  'arrange_words',
  'matching',
  'true_false',
  'code_output',
  'diagram_label', // ← add here
];
```

---

## Step 6: Update Documentation

- Add row to exercise type table in [`../api.md`](../api.md)
- Add row to `src/components/exercise/registry.js` table in `CLAUDE.md`
- Add row to exercise type table in [`add-content.md`](./add-content.md)

---

## Testing the New Type

```bash
# Unit test the validator
# server/tests/unit/answerValidator.test.js — add test cases:
it('diagram_label: case-insensitive match', () => {
  const exercise = { type: 'diagram_label', correct_answer: 'Nucleus' };
  expect(validate(exercise, 'nucleus')).toBe(true);
  expect(validate(exercise, 'cytoplasm')).toBe(false);
});
```

```bash
# Manually test with a seed exercise:
node scripts/import-lesson.js database/content/test-diagram.yaml --dry-run
```
