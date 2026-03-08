import Box from '@mui/material/Box';

/**
 * Segmented pixel progress bar — RPG HP/XP bar style.
 * Renders as a series of filled pixel blocks instead of a smooth bar.
 *
 * Supports two modes:
 * - **Determinate** (default): filled segments based on `value` (0-100)
 * - **Indeterminate**: scanning sweep animation for loading states
 *
 * @param {Object} props
 * @param {number} [props.value] - Progress value (0-100, ignored in indeterminate)
 * @param {boolean} [props.indeterminate] - Scanning loading animation
 * @param {number} [props.segments=10] - Number of pixel segments
 * @param {string} [props.color='primary.main'] - Fill color (theme token)
 * @param {number} [props.height=12] - Bar height in px (4px in indeterminate)
 * @param {Object} [props.sx] - Additional sx overrides
 */
export default function PixelProgressBar({
  value,
  indeterminate = false,
  segments = 10,
  color = 'primary.main',
  height,
  sx,
}) {
  const actualHeight = height ?? (indeterminate ? 4 : 12);
  const filled = indeterminate ? 0 : Math.round((value / 100) * segments);

  return (
    <Box
      role="progressbar"
      aria-valuenow={indeterminate ? undefined : value}
      aria-valuemin={0}
      aria-valuemax={100}
      sx={{
        display: 'flex',
        gap: indeterminate ? '1px' : '2px',
        ...(indeterminate
          ? { bgcolor: 'transparent' }
          : {
              border: '2px solid',
              borderColor: 'divider',
              p: '2px',
              bgcolor: 'background.default',
            }),
        ...sx,
      }}
    >
      {Array.from({ length: segments }, (_, i) =>
        indeterminate ? (
          <Box
            key={i}
            sx={{
              flex: 1,
              height: actualHeight,
              bgcolor: color,
              '@keyframes pixelScan': {
                '0%, 100%': { opacity: 0.15 },
                '25%': { opacity: 1 },
                '50%': { opacity: 0.15 },
              },
              animation: 'pixelScan 1.2s step-end infinite',
              animationDelay: `${Math.round((i / segments) * 1200)}ms`,
            }}
          />
        ) : (
          <Box
            key={i}
            sx={{
              flex: 1,
              height: actualHeight,
              bgcolor: i < filled ? color : 'action.disabledBackground',
              transition: 'background-color 0.1s steps(2, end)',
            }}
          />
        ),
      )}
    </Box>
  );
}
