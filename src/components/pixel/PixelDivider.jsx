import Box from '@mui/material/Box';

/**
 * Decorative pixel divider — diamond-centered separator line.
 * A horizontal rule with a small pixel diamond in the center.
 *
 * @param {Object} props
 * @param {Object} [props.sx] - Additional sx overrides
 */
export default function PixelDivider({ sx }) {
  return (
    <Box
      role="separator"
      sx={{
        display: 'flex',
        alignItems: 'center',
        gap: 1.5,
        my: 3,
        ...sx,
      }}
    >
      {/* Left line */}
      <Box
        sx={{
          flex: 1,
          height: 2,
          bgcolor: 'divider',
        }}
      />
      {/* Center diamond */}
      <Box
        aria-hidden="true"
        sx={{
          width: 8,
          height: 8,
          bgcolor: 'primary.main',
          transform: 'rotate(45deg)',
          flexShrink: 0,
          opacity: 0.6,
        }}
      />
      {/* Right line */}
      <Box
        sx={{
          flex: 1,
          height: 2,
          bgcolor: 'divider',
        }}
      />
    </Box>
  );
}
