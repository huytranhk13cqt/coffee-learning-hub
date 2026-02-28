# ADR 006: Registry Pattern for Exercise Types and Section Renderers

**Date**: 2026-01
**Status**: Accepted

## Context

There are 8 exercise types and 9 section renderer types, each requiring a different React component and different answer validation logic. The naive approach (if/switch statements) becomes unmaintainable as types grow.

## Decision

Registry pattern for both exercise types and section types. A central map (`type → component`) allows O(1) lookup and makes adding a new type a localized change.

## Exercise Registry (`src/components/exercise/registry.js`)

```js
const registry = {
  multiple_choice: MultipleChoice,
  fill_blank: FillBlank,
  error_correction: ErrorCorrection,
  sentence_transform: SentenceTransform,
  arrange_words: ArrangeWords,
  matching: Matching,
  true_false: TrueFalse,
  code_output: CodeOutput,
};

// Usage:
const Component = registry[exercise.type];
<Component
  exercise={exercise}
  answer={answer}
  onAnswerChange={onChange}
  disabled={disabled}
/>;
```

All components share the same interface: `{ exercise, answer, onAnswerChange, disabled }`.

## Section Registry (`src/components/lesson/sections/`)

```js
const sectionRegistry = {
  markdown: MarkdownSection,
  key_points: KeyPointsSection,
  info_box: InfoBoxSection,
  audio: AudioSection,
  video: VideoSection,
  chart: ChartSection, // lazy-loaded
  diagram: DiagramSection, // lazy-loaded
  image: ImageSection,
  interactive_chart: InteractiveChartSection, // lazy-loaded
};
```

## Server-Side: Strategy Pattern for Validation (`server/services/answerValidator.js`)

```js
const validators = {
  multiple_choice: validateMultipleChoice,
  fill_blank: validateFillBlank,
  // ... one validator per type
};

function validate(exercise, userAnswer) {
  const fn = validators[exercise.type];
  if (!fn) throw new ValidationError(`Unknown exercise type: ${exercise.type}`);
  return fn(exercise, userAnswer);
}
```

## Reasons

1. **Open/Closed Principle** — add a new type without modifying existing code. Just add to the registry + create a component.
2. **Discoverability** — the registry file is the single source of truth for what types exist.
3. **Lazy loading** — heavy renderers (Mermaid, Recharts) are lazy-loaded only when their section type appears in a lesson.
4. **Testability** — each component/validator is independently testable.

## Consequences

- `+` Adding a new exercise type = 3 files: component, validator, registry entry
- `+` Unknown types fail loudly (server throws, client renders fallback)
- `-` All exercise components must conform to the same interface — changing the interface requires updating all 8 components
