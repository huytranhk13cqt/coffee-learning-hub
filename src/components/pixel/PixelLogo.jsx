import Box from '@mui/material/Box';

/**
 * Pixel diamond logo mark — CSS-only, no images needed.
 * Nested rotated squares create a pixel gem/diamond effect.
 *
 * @param {Object} props
 * @param {number} [props.size=24] - Outer box size in px
 * @param {Object} [props.sx] - Additional sx overrides
 */
export default function PixelLogo({ size = 24, sx }) {
  const innerInset = Math.round(size * 0.15);
  const coreInset = Math.round(size * 0.3);

  return (
    <Box
      aria-hidden="true"
      sx={{
        width: size,
        height: size,
        position: 'relative',
        flexShrink: 0,
        // Outer diamond
        '&::before': {
          content: '""',
          position: 'absolute',
          inset: innerInset,
          bgcolor: 'primary.main',
          transform: 'rotate(45deg)',
          boxShadow: '0 0 10px var(--mui-palette-primary-main)',
        },
        // Inner cutout
        '&::after': {
          content: '""',
          position: 'absolute',
          inset: coreInset,
          bgcolor: 'background.paper',
          transform: 'rotate(45deg)',
        },
        ...sx,
      }}
    />
  );
}
