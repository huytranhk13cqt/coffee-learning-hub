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
export function getSessionId() {
  let id = localStorage.getItem(STORAGE_KEY);
  if (!id) {
    id = crypto.randomUUID();
    localStorage.setItem(STORAGE_KEY, id);
  }
  return id;
}

/**
 * Reset session (generates new UUID).
 * All subscribed components re-render.
 */
export function resetSessionId() {
  const id = crypto.randomUUID();
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
