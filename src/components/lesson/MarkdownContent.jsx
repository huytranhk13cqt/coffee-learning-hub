import { useMemo } from 'react';
import { marked } from 'marked';
import DOMPurify from 'dompurify';
import Box from '@mui/material/Box';

// Configure marked for safe output
marked.setOptions({
  breaks: true,
  gfm: true,
});

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
          bgcolor: 'grey.100',
          p: 2,
          borderRadius: 1,
          overflow: 'auto',
          mb: 1.5,
          '& code': {
            bgcolor: 'transparent',
            p: 0,
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
