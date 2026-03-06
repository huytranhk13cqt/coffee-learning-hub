import { createTheme } from '@mui/material/styles';

// ────────────────────────────────────────────────────────
// PICO-8 palette — the retro DNA of the design system
// ────────────────────────────────────────────────────────
const PICO = {
  black: '#000000',
  darkBlue: '#1D2B53',
  darkPurple: '#7E2553',
  darkGreen: '#008751',
  brown: '#AB5236',
  darkGrey: '#5F574F',
  lightGrey: '#C2C3C7',
  white: '#FFF1E8',
  red: '#FF004D',
  orange: '#FFA300',
  yellow: '#FFEC27',
  green: '#00E436',
  blue: '#29ADFF',
  lavender: '#83769C',
  pink: '#FF77A8',
  peach: '#FFCCAA',
};

// ────────────────────────────────────────────────────────
// 128-bit shadow system — color-tinted, layered depth
// ────────────────────────────────────────────────────────
const shadows = [
  'none',
  '0 1px 3px rgba(29,43,83,0.10), 0 1px 2px rgba(0,0,0,0.06)',
  '0 2px 6px rgba(29,43,83,0.12), 0 1px 3px rgba(0,0,0,0.08)',
  '0 4px 12px rgba(29,43,83,0.14), 0 2px 4px rgba(0,0,0,0.08)',
  '0 6px 16px rgba(29,43,83,0.16), 0 3px 6px rgba(0,0,0,0.08)',
  '0 8px 24px rgba(29,43,83,0.18), 0 4px 8px rgba(0,0,0,0.08)',
  ...Array(19).fill(
    '0 8px 24px rgba(29,43,83,0.18), 0 4px 8px rgba(0,0,0,0.08)',
  ),
];

// Legacy pixel border helpers — kept for backward compatibility
const pixelBorder = (color) => `
  2px 0 0 0 ${color},
  -2px 0 0 0 ${color},
  0 2px 0 0 ${color},
  0 -2px 0 0 ${color}
`;

const pixelBorderThick = (color) => `
  4px 0 0 0 ${color},
  -4px 0 0 0 ${color},
  0 4px 0 0 ${color},
  0 -4px 0 0 ${color}
`;

// ────────────────────────────────────────────────────────
// CSS custom properties for pixel-art textures
// ────────────────────────────────────────────────────────
const PIXEL_PATTERN_LIGHT =
  'radial-gradient(circle, rgba(29,43,83,0.035) 1px, transparent 1px)';
const PIXEL_PATTERN_DARK =
  'radial-gradient(circle, rgba(255,241,232,0.025) 1px, transparent 1px)';

// ────────────────────────────────────────────────────────
// 128-bit Pixel Art Theme — PS2/GameCube era refinement
// ────────────────────────────────────────────────────────
const pixelTheme = createTheme({
  cssVariables: { colorSchemeSelector: 'data-color-scheme' },
  shadows,

  colorSchemes: {
    dark: {
      palette: {
        primary: { main: PICO.blue },
        secondary: { main: PICO.pink },
        success: { main: PICO.green },
        warning: { main: PICO.orange },
        error: { main: PICO.red },
        info: { main: PICO.lavender },
        background: {
          default: '#141a2e',
          paper: '#1c2340',
        },
        text: {
          primary: '#eae6df',
          secondary: '#9b97a0',
        },
        divider: 'rgba(255,255,255,0.08)',
      },
    },
    light: {
      palette: {
        primary: { main: '#1a56db' },
        secondary: { main: PICO.darkPurple },
        success: { main: '#15803d' },
        warning: { main: '#b45309' },
        error: { main: '#be123c' },
        info: { main: PICO.lavender },
        background: {
          default: '#f5f1eb',
          paper: '#ffffff',
        },
        text: {
          primary: '#1a1a2e',
          secondary: '#5c5a65',
        },
        divider: 'rgba(0,0,0,0.08)',
      },
    },
  },

  shape: {
    borderRadius: 4,
  },

  typography: {
    fontFamily: '"VT323", "Courier New", monospace',
    fontSize: 16,
    h1: {
      fontFamily: '"Silkscreen", cursive',
      fontSize: '1.75rem',
      lineHeight: 1.6,
      fontWeight: 400,
    },
    h2: {
      fontFamily: '"Silkscreen", cursive',
      fontSize: '1.4rem',
      lineHeight: 1.6,
      fontWeight: 400,
    },
    h3: {
      fontFamily: '"Silkscreen", cursive',
      fontSize: '1.15rem',
      lineHeight: 1.5,
      fontWeight: 400,
    },
    h4: { fontFamily: '"Silkscreen", cursive', fontSize: '1.25rem' },
    h5: { fontFamily: '"Silkscreen", cursive', fontSize: '1.1rem' },
    h6: { fontFamily: '"Silkscreen", cursive', fontSize: '1rem' },
    subtitle1: { fontFamily: '"Silkscreen", cursive', fontSize: '0.95rem' },
    subtitle2: { fontFamily: '"Silkscreen", cursive', fontSize: '0.85rem' },
    body1: {
      fontFamily: '"VT323", monospace',
      fontSize: '1.25rem',
      lineHeight: 1.6,
    },
    body2: {
      fontFamily: '"VT323", monospace',
      fontSize: '1.1rem',
      lineHeight: 1.5,
    },
    button: {
      fontFamily: '"Silkscreen", cursive',
      fontSize: '0.875rem',
      textTransform: 'none',
    },
    caption: { fontFamily: '"VT323", monospace', fontSize: '1rem' },
    overline: { fontFamily: '"Silkscreen", cursive', fontSize: '0.7rem' },
  },

  components: {
    MuiCssBaseline: {
      styleOverrides: {
        body: {
          imageRendering: 'pixelated',
          // Subtle pixel dot overlay — the "128-bit texture"
          '&::after': {
            content: '""',
            position: 'fixed',
            inset: 0,
            backgroundImage: PIXEL_PATTERN_LIGHT,
            backgroundSize: '4px 4px',
            pointerEvents: 'none',
            zIndex: 9999,
          },
          // Dark mode swap via data attribute
          '[data-color-scheme="dark"] &::after': {
            backgroundImage: PIXEL_PATTERN_DARK,
          },
        },
      },
    },

    MuiButton: {
      styleOverrides: {
        root: {
          borderRadius: 3,
          textTransform: 'none',
          border: '1px solid transparent',
          boxShadow: '0 1px 3px rgba(29,43,83,0.10)',
          '&:hover': {
            transform: 'translateY(-1px)',
            boxShadow: '0 3px 8px rgba(29,43,83,0.18)',
          },
          '&:active': {
            transform: 'translateY(0)',
            boxShadow: '0 1px 2px rgba(29,43,83,0.10)',
          },
          transition: 'transform 0.15s ease-out, box-shadow 0.15s ease-out',
        },
        containedPrimary: {
          '&:hover': {
            boxShadow: '0 3px 12px rgba(41,173,255,0.35)',
          },
        },
      },
    },

    MuiCard: {
      styleOverrides: {
        root: {
          borderRadius: 6,
          border: '1px solid var(--mui-palette-divider)',
          backgroundImage: 'none',
          boxShadow: '0 2px 8px rgba(29,43,83,0.08)',
          transition: 'box-shadow 0.2s ease-out, transform 0.2s ease-out',
          '&:hover': {
            boxShadow:
              '0 4px 16px rgba(41,173,255,0.12), 0 2px 6px rgba(29,43,83,0.08)',
          },
        },
      },
    },

    MuiPaper: {
      styleOverrides: {
        root: {
          borderRadius: 6,
          backgroundImage: 'none',
        },
      },
    },

    MuiTextField: {
      styleOverrides: {
        root: {
          '& .MuiOutlinedInput-root': {
            borderRadius: 4,
            '& fieldset': {
              borderWidth: 1.5,
            },
            '&:hover fieldset': {
              borderWidth: 2,
            },
            '&.Mui-focused fieldset': {
              borderWidth: 2,
            },
          },
        },
      },
    },

    MuiChip: {
      styleOverrides: {
        root: {
          borderRadius: 4,
          fontFamily: '"VT323", monospace',
          fontSize: '1rem',
        },
      },
    },

    MuiLinearProgress: {
      styleOverrides: {
        root: {
          borderRadius: 4,
          height: 6,
        },
      },
    },

    MuiDrawer: {
      styleOverrides: {
        paper: {
          borderRadius: 0,
        },
      },
    },

    MuiListItemButton: {
      styleOverrides: {
        root: {
          borderRadius: 4,
          margin: '1px 4px',
          position: 'relative',
          '&.Mui-selected': {
            background:
              'linear-gradient(90deg, rgba(41,173,255,0.15) 0%, rgba(41,173,255,0.05) 70%, transparent 100%)',
            borderLeft: '3px solid var(--mui-palette-primary-main)',
            '&::before': {
              content: '""',
              position: 'absolute',
              left: 0,
              top: '50%',
              transform: 'translateY(-50%)',
              width: 3,
              height: '60%',
              background: 'var(--mui-palette-primary-main)',
              boxShadow: '0 0 8px rgba(41,173,255,0.5)',
              borderRadius: 1,
            },
            '&:hover': {
              background:
                'linear-gradient(90deg, rgba(41,173,255,0.20) 0%, rgba(41,173,255,0.08) 70%, transparent 100%)',
            },
          },
          '&:hover': {
            background: 'rgba(41,173,255,0.06)',
          },
          transition: 'background 0.15s ease-out',
        },
      },
    },

    MuiAlert: {
      styleOverrides: {
        root: {
          borderRadius: 4,
        },
      },
    },

    MuiDialog: {
      styleOverrides: {
        paper: {
          borderRadius: 8,
        },
      },
    },

    MuiTableCell: {
      styleOverrides: {
        head: {
          fontFamily: '"Silkscreen", cursive',
          fontSize: '0.8rem',
        },
      },
    },

    MuiTooltip: {
      styleOverrides: {
        tooltip: {
          borderRadius: 4,
          fontFamily: '"VT323", monospace',
          fontSize: '0.95rem',
        },
      },
    },
  },
});

export default pixelTheme;
export { PICO, pixelBorder, pixelBorderThick };
