import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import { FONT } from '../../theme/pixelUtils.js';

/**
 * Pixel-styled page header with decorative elements.
 * Adds a pixel diamond marker and optional subtitle.
 *
 * @param {Object} props
 * @param {string} props.title - Page title text
 * @param {string} [props.subtitle] - Optional subtitle
 * @param {React.ReactNode} [props.action] - Optional action button(s)
 * @param {Object} [props.sx] - Additional sx overrides
 */
export default function PixelPageHeader({ title, subtitle, action, sx }) {
  return (
    <Box
      sx={{
        display: 'flex',
        alignItems: { xs: 'flex-start', sm: 'center' },
        justifyContent: 'space-between',
        flexDirection: { xs: 'column', sm: 'row' },
        gap: 2,
        mb: 3,
        pb: 2,
        borderBottom: '2px solid',
        borderColor: 'divider',
        ...sx,
      }}
    >
      <Box sx={{ display: 'flex', alignItems: 'center', gap: 1.5 }}>
        {/* Pixel diamond marker */}
        <Box
          aria-hidden="true"
          sx={{
            width: 12,
            height: 12,
            bgcolor: 'primary.main',
            transform: 'rotate(45deg)',
            flexShrink: 0,
            boxShadow: '0 0 8px var(--mui-palette-primary-main)',
          }}
        />
        <Box>
          <Typography
            variant="h2"
            component="h1"
            sx={{ fontFamily: FONT.pixel }}
          >
            {title}
          </Typography>
          {subtitle && (
            <Typography variant="body2" color="text.secondary" sx={{ mt: 0.5 }}>
              {subtitle}
            </Typography>
          )}
        </Box>
      </Box>
      {action && <Box sx={{ flexShrink: 0 }}>{action}</Box>}
    </Box>
  );
}
