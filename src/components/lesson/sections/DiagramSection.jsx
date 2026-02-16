import { useEffect, useState, useId } from 'react';
import mermaid from 'mermaid';
import { useColorScheme } from '@mui/material/styles';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import Alert from '@mui/material/Alert';
import MarkdownContent from '../MarkdownContent.jsx';

/**
 * DiagramSection renders Mermaid diagrams with dark mode support.
 *
 * Expected metadata:
 *   { code: "graph TD\n  A --> B\n  B --> C" }
 *
 * The Mermaid syntax is in metadata.code (not content) because content
 * follows the section convention: markdown description/caption.
 *
 * content/content_vi: optional markdown caption displayed below the diagram.
 */
export default function DiagramSection({ section }) {
  const { mode } = useColorScheme();
  const id = useId();
  const [svg, setSvg] = useState('');
  const [error, setError] = useState(null);

  const diagramCode = section.metadata?.code;
  const caption = section.content_vi || section.content;

  useEffect(() => {
    if (!diagramCode) return;

    let cancelled = false;

    mermaid.initialize({
      startOnLoad: false,
      theme: mode === 'dark' ? 'dark' : 'default',
      securityLevel: 'strict',
    });

    // useId produces ":r1:" — strip colons for valid HTML ID
    const elementId = `mermaid${id.replace(/:/g, '')}`;

    mermaid
      .render(elementId, diagramCode)
      .then(({ svg: result }) => {
        if (!cancelled) {
          setSvg(result);
          setError(null);
        }
      })
      .catch((err) => {
        if (!cancelled) {
          setError(err.message || 'Diagram rendering failed');
        }
      });

    return () => {
      cancelled = true;
    };
  }, [diagramCode, mode, id]);

  if (!diagramCode) return null;

  return (
    <Paper variant="outlined" sx={{ p: 2.5 }}>
      {section.title_vi && (
        <Typography variant="h6" gutterBottom>
          {section.title_vi}
        </Typography>
      )}

      {error ? (
        <Alert
          severity="warning"
          sx={{ '& .MuiAlert-message': { width: '100%' } }}
        >
          <MarkdownContent
            content={`\`\`\`\n${diagramCode}\n\`\`\``}
            sx={{ '& p:last-child': { mb: 0 } }}
          />
        </Alert>
      ) : svg ? (
        <Box
          dangerouslySetInnerHTML={{ __html: svg }}
          sx={{
            textAlign: 'center',
            my: 1,
            '& svg': { maxWidth: '100%', height: 'auto' },
          }}
        />
      ) : null}

      {caption && (
        <MarkdownContent
          content={caption}
          sx={{ mt: 1.5, '& p:last-child': { mb: 0 } }}
        />
      )}
    </Paper>
  );
}
