import Box from '@mui/material/Box';

/**
 * Decorative pixel art frame — RPG dialog box style.
 * Uses multi-layer box-shadow for crisp pixel borders.
 *
 * Variants:
 * - "default" — simple 2px pixel border
 * - "raised"  — 2px border + pixel drop shadow (lifted look)
 * - "inset"   — 2px border + inset shadow (sunken look)
 *
 * @param {Object} props
 * @param {'default'|'raised'|'inset'} [props.variant='default']
 * @param {boolean} [props.glow] - Add subtle primary glow on hover
 * @param {Object} [props.sx] - Additional sx overrides
 */
export default function PixelFrame({
  children,
  variant = 'default',
  glow = false,
  sx,
  ...rest
}) {
  const baseSx = {
    position: 'relative',
    border: '2px solid',
    borderColor: 'divider',
    borderRadius: 0,
    bgcolor: 'background.paper',
    transition: 'box-shadow 0.15s steps(3, end)',
  };

  const variantSx =
    variant === 'raised'
      ? {
          boxShadow: '3px 3px 0 0 var(--mui-palette-divider)',
        }
      : variant === 'inset'
        ? {
            boxShadow: 'inset 2px 2px 0 0 var(--mui-palette-divider)',
          }
        : {};

  const glowSx = glow
    ? {
        '&:hover': {
          boxShadow:
            variant === 'raised'
              ? '3px 3px 0 0 var(--mui-palette-divider), 0 0 12px var(--mui-palette-primary-main)'
              : '0 0 12px var(--mui-palette-primary-main)',
        },
      }
    : {};

  return (
    <Box sx={{ ...baseSx, ...variantSx, ...glowSx, ...sx }} {...rest}>
      {children}
    </Box>
  );
}
