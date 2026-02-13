import { useMemo } from 'react';
import { Marked } from 'marked';
import { markedHighlight } from 'marked-highlight';
import hljs from 'highlight.js/lib/core';
import python from 'highlight.js/lib/languages/python';
import javascript from 'highlight.js/lib/languages/javascript';
import DOMPurify from 'dompurify';
import Box from '@mui/material/Box';
import 'highlight.js/styles/github-dark.css';

// Register only the languages we need (tree-shaking)
hljs.registerLanguage('python', python);
hljs.registerLanguage('javascript', javascript);
hljs.registerLanguage('js', javascript);

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
        ...sx,
      }}
      dangerouslySetInnerHTML={{ __html: html }}
    />
  );
}
