import { useEffect } from 'react';

const BASE_TITLE = 'Learning Hub';

/**
 * Sets the document title for the current page.
 * Appends " — Learning Hub" suffix for non-home pages.
 * Resets to base title on unmount.
 */
export function useDocumentTitle(title) {
  useEffect(() => {
    document.title = title ? `${title} — ${BASE_TITLE}` : BASE_TITLE;
    return () => {
      document.title = BASE_TITLE;
    };
  }, [title]);
}
