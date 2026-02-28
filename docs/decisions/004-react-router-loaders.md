# ADR 004: React Router v7 Loaders (No useEffect for Data)

**Date**: 2026-01 (architecture decision)
**Status**: Accepted

## Context

Data fetching in React has historically been done with `useEffect` + `useState`. This causes problems: loading waterfalls (parent loads, renders, child loads), race conditions, stale closures, and no built-in error boundaries.

## Decision

All initial data fetching via React Router v7 `loader` functions. `useEffect` is prohibited for data loading.

## Reasons

1. **No waterfalls** — loaders run in parallel before the component renders. All data arrives together.
2. **URL-driven** — loaders run on navigation, so the browser back/forward button works correctly with fresh data.
3. **Error boundaries** — loader errors are caught by React Router's `errorElement` (our `ErrorPage`). No per-component error handling needed.
4. **`loader` + `useState` sync** — for optimistic updates, initialize `useState(loaderData)` + `useEffect([loaderData])` to re-sync on navigation. This is the official pattern.
5. **`useSyncExternalStore`** — session ID in localStorage exposed via `getSessionId()` for use in loaders (loaders don't have React hooks).

## Consequences

- `+` No loading waterfalls
- `+` Race conditions eliminated (React Router handles cancellation)
- `+` Consistent data-loading architecture — one pattern everywhere
- `-` Requires understanding React Router's data router (v6.4+ / v7 concept)
- `-` Server-side rendering would require different loader setup (not a concern for this SPA)

## Key Pattern

```js
// co-located with page file:
export async function loader({ params }) {
  const sessionId = getSessionId(); // useSyncExternalStore-based, safe in loaders
  const [lesson, progress] = await Promise.all([
    fetchLesson(params.slug),
    fetchProgress(params.slug, sessionId),
  ]);
  return { lesson, progress };
}

// In component — sync on navigation:
const { lesson, progress: initialProgress } = useLoaderData();
const [progress, setProgress] = useState(initialProgress);
useEffect(() => {
  setProgress(initialProgress);
}, [initialProgress]);
```
