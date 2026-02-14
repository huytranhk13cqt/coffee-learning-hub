import Typography from '@mui/material/Typography';
import Paper from '@mui/material/Paper';
import Box from '@mui/material/Box';
import MarkdownContent from '../MarkdownContent.jsx';

/**
 * VideoSection renders HTML5 video or a YouTube/Vimeo embed.
 *
 * Expected metadata:
 *   HTML5:   { src: "https://example.com/video.mp4" }
 *   YouTube: { provider: "youtube", videoId: "dQw4w9WgXcQ" }
 *
 * content/content_vi: optional markdown caption displayed below the player.
 */

const EMBED_URLS = {
  youtube: (id) => `https://www.youtube-nocookie.com/embed/${id}`,
  vimeo: (id) => `https://player.vimeo.com/video/${id}`,
};

// 16:9 responsive container via padding-top trick
const RESPONSIVE_WRAPPER_SX = {
  position: 'relative',
  width: '100%',
  pt: '56.25%', // 9/16 = 56.25%
  '& iframe, & video': {
    position: 'absolute',
    top: 0,
    left: 0,
    width: '100%',
    height: '100%',
    border: 'none',
    borderRadius: 1,
  },
};

export default function VideoSection({ section }) {
  const { src, provider, videoId } = section.metadata || {};
  const embedUrl = provider && videoId ? EMBED_URLS[provider]?.(videoId) : null;

  return (
    <Paper variant="outlined" sx={{ p: 2.5 }}>
      {section.title_vi && (
        <Typography variant="h6" gutterBottom>
          {section.title_vi}
        </Typography>
      )}

      {embedUrl ? (
        <Box sx={RESPONSIVE_WRAPPER_SX}>
          <Box
            component="iframe"
            src={embedUrl}
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            allowFullScreen
            loading="lazy"
            title={section.title_vi || section.title || 'Video'}
          />
        </Box>
      ) : src ? (
        <Box sx={RESPONSIVE_WRAPPER_SX}>
          <Box component="video" controls preload="metadata" src={src} />
        </Box>
      ) : null}

      {(section.content_vi || section.content) && (
        <MarkdownContent
          content={section.content_vi || section.content}
          sx={{ mt: 1.5, '& p:last-child': { mb: 0 } }}
        />
      )}
    </Paper>
  );
}
