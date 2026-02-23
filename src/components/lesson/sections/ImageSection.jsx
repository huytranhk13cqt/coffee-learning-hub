import Typography from '@mui/material/Typography';
import Paper from '@mui/material/Paper';
import Box from '@mui/material/Box';
import MarkdownContent from '../MarkdownContent.jsx';

/**
 * ImageSection renders a responsive image with optional caption.
 *
 * Expected metadata:
 *   { src: "/media/images/photo.jpg", alt: "Description" }
 *
 * content/content_vi: optional markdown caption displayed below the image.
 */
export default function ImageSection({ section }) {
  const { src, alt } = section.metadata || {};

  return (
    <Paper variant="outlined" sx={{ p: 2.5 }}>
      {section.title_vi && (
        <Typography variant="h6" gutterBottom>
          {section.title_vi}
        </Typography>
      )}

      {src && (
        <Box
          component="img"
          src={src}
          alt={alt || section.title_vi || section.title || 'Hình ảnh minh họa'}
          sx={{
            maxWidth: '100%',
            height: 'auto',
            borderRadius: 1,
            display: 'block',
          }}
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
