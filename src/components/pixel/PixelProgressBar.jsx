import Box from '@mui/material/Box';

/**
 * Segmented pixel progress bar — RPG HP/XP bar style.
 * Renders as a series of filled pixel blocks instead of a smooth bar.
 *
 * @param {Object} props
 * @param {number} props.value - Progress value (0-100)
 * @param {number} [props.segments=10] - Number of pixel segments
 * @param {string} [props.color='primary.main'] - Fill color (theme token)
 * @param {number} [props.height=12] - Bar height in px
 * @param {Object} [props.sx] - Additional sx overrides
 */
export default function PixelProgressBar({
  value,
  segments = 10,
  color = 'primary.main',
  height = 12,
  sx,
}) {
  const filled = Math.round((value / 100) * segments);

  return (
    <Box
      role="progressbar"
      aria-valuenow={value}
      aria-valuemin={0}
      aria-valuemax={100}
      sx={{
        display: 'flex',
        gap: '2px',
        border: '2px solid',
        borderColor: 'divider',
        p: '2px',
        bgcolor: 'background.default',
        ...sx,
      }}
    >
      {Array.from({ length: segments }, (_, i) => (
        <Box
          key={i}
          sx={{
            flex: 1,
            height,
            bgcolor: i < filled ? color : 'action.disabledBackground',
            transition: 'background-color 0.1s steps(2, end)',
          }}
        />
      ))}
    </Box>
  );
}
