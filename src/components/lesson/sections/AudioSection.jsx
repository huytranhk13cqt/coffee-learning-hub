import Typography from '@mui/material/Typography';
import Paper from '@mui/material/Paper';
import Box from '@mui/material/Box';
import MarkdownContent from '../MarkdownContent.jsx';

/**
 * AudioSection renders an HTML5 audio player with optional caption.
 *
 * Expected metadata:
 *   { src: "https://example.com/audio.mp3" }
 *
 * content/content_vi: optional markdown caption displayed below the player.
 */
export default function AudioSection({ section }) {
  const src = section.metadata?.src;

  return (
    <Paper variant="outlined" sx={{ p: 2.5 }}>
      {section.title_vi && (
        <Typography variant="h6" gutterBottom>
          {section.title_vi}
        </Typography>
      )}

      {src && (
        <Box
          component="audio"
          controls
          preload="metadata"
          src={src}
          sx={{ width: '100%', maxWidth: 500, display: 'block' }}
        />
      )}

      {(section.content_vi || section.content) && (
        <MarkdownContent
          content={section.content_vi || section.content}
          sx={{ mt: 1.5, '& p:last-child': { mb: 0 } }}
        />
      )}
    </Paper>
  );
}
