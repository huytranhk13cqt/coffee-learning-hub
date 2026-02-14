import { useMemo } from 'react';
import { Marked } from 'marked';
import { markedHighlight } from 'marked-highlight';
import hljs from 'highlight.js/lib/core';
import python from 'highlight.js/lib/languages/python';
import javascript from 'highlight.js/lib/languages/javascript';
import bash from 'highlight.js/lib/languages/bash';
import sql from 'highlight.js/lib/languages/sql';
import xml from 'highlight.js/lib/languages/xml';
import css from 'highlight.js/lib/languages/css';
import java from 'highlight.js/lib/languages/java';
import c from 'highlight.js/lib/languages/c';
import cpp from 'highlight.js/lib/languages/cpp';
import typescript from 'highlight.js/lib/languages/typescript';
import json from 'highlight.js/lib/languages/json';
import go from 'highlight.js/lib/languages/go';
import DOMPurify from 'dompurify';
import Box from '@mui/material/Box';
import 'highlight.js/styles/github-dark.css';

// Register languages + common aliases for code blocks
// Format: [canonical name, definition, ...aliases]
const LANGUAGES = [
  ['python', python],
  ['javascript', javascript, 'js'],
  ['bash', bash, 'sh', 'shell'],
  ['sql', sql],
  ['xml', xml, 'html'],
  ['css', css],
  ['java', java],
  ['c', c],
  ['cpp', cpp, 'c++'],
  ['typescript', typescript, 'ts'],
  ['json', json],
  ['go', go],
];

for (const [name, def, ...aliases] of LANGUAGES) {
  hljs.registerLanguage(name, def);
  for (const alias of aliases) {
    hljs.registerLanguage(alias, def);
  }
}

// Configure marked with syntax highlighting
const marked = new Marked(
  markedHighlight({
    langPrefix: 'hljs language-',
    highlight(code, lang) {
      if (lang && hljs.getLanguage(lang)) {
        return hljs.highlight(code, { language: lang }).value;
      }
      return code;
    },
  }),
  { breaks: true, gfm: true },
);

export default function MarkdownContent({ content, sx }) {
  // SECURITY: Content is trusted (server-seeded DB only, no user-generated input).
  // DOMPurify sanitizes marked output as defense-in-depth before rendering.
  // If a CMS or user input is added in the future, add input sanitization too.
  const html = useMemo(() => {
    if (!content) return '';
    const raw = marked.parse(content);
    return DOMPurify.sanitize(raw);
  }, [content]);

  if (!html) return null;

  return (
    <Box
      sx={{
        '& h1, & h2, & h3, & h4': {
          mt: 2,
          mb: 1,
          fontWeight: 600,
        },
        '& h3': { fontSize: '1.15rem' },
        '& p': { mb: 1.5, lineHeight: 1.7 },
        '& ul, & ol': { pl: 3, mb: 1.5 },
        '& li': { mb: 0.5 },
        '& code': {
          bgcolor: 'grey.100',
          px: 0.75,
          py: 0.25,
          borderRadius: 0.5,
          fontSize: '0.875em',
          fontFamily: 'monospace',
        },
        '& pre': {
          bgcolor: 'grey.900',
          p: 2,
          borderRadius: 1,
          overflow: 'auto',
          mb: 1.5,
          '& code': {
            bgcolor: 'transparent',
            p: 0,
            color: 'grey.100',
          },
        },
        '& blockquote': {
          borderLeft: 3,
          borderColor: 'primary.main',
          pl: 2,
          ml: 0,
          color: 'text.secondary',
          fontStyle: 'italic',
        },
        '& strong': { fontWeight: 600 },
        '& a': { color: 'primary.main' },
        '& img': {
          maxWidth: '100%',
          height: 'auto',
          borderRadius: 1,
          my: 1.5,
          display: 'block',
        },
        '& table': {
          width: '100%',
          borderCollapse: 'collapse',
          mb: 1.5,
          '& th, & td': {
            border: 1,
            borderColor: 'divider',
            px: 1.5,
            py: 1,
            textAlign: 'left',
            fontSize: '0.875rem',
          },
          '& th': {
            bgcolor: 'grey.100',
            fontWeight: 600,
          },
        },
        '& hr': {
          border: 'none',
          borderTop: 1,
          borderColor: 'divider',
          my: 2,
        },
        ...sx,
      }}
      dangerouslySetInnerHTML={{ __html: html }}
    />
  );
}
