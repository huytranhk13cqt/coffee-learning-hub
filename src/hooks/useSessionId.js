import { useSyncExternalStore } from 'react';

const STORAGE_KEY = 'relax_session_id';

// --- External store for session ID ---
// Subscribers are notified when session ID changes (e.g., reset)
const listeners = new Set();

function subscribe(callback) {
  listeners.add(callback);
  return () => listeners.delete(callback);
}

function getSnapshot() {
  return getSessionId();
}

function emitChange() {
  for (const listener of listeners) {
    listener();
  }
}

// --- Public API ---

/**
 * Non-hook getter — safe to call from React Router loaders,
 * API client, or anywhere outside the component tree.
 */
function generateUUID() {
  if (typeof crypto !== 'undefined' && crypto.randomUUID) {
    return crypto.randomUUID();
  }
  // Fallback for older browsers (iOS < 15.4)
  return '10000000-1000-4000-8000-100000000000'.replace(/[018]/g, (c) =>
    (
      +c ^
      (crypto.getRandomValues(new Uint8Array(1))[0] & (15 >> (+c / 4)))
    ).toString(16),
  );
}

export function getSessionId() {
  let id = localStorage.getItem(STORAGE_KEY);
  if (!id) {
    id = generateUUID();
    localStorage.setItem(STORAGE_KEY, id);
  }
  return id;
}

/**
 * Reset session (generates new UUID).
 * All subscribed components re-render.
 */
export function resetSessionId() {
  const id = generateUUID();
  localStorage.setItem(STORAGE_KEY, id);
  emitChange();
  return id;
}

/**
 * React hook — returns current session ID,
 * re-renders when session is reset.
 */
export function useSessionId() {
  return useSyncExternalStore(subscribe, getSnapshot);
}
