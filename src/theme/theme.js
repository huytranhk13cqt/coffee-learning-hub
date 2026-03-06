import { createTheme } from '@mui/material/styles';

// PICO-8 accent colors for consistency with admin theme
const PICO_BLUE = '#29ADFF';
const PICO_GREEN = '#00E436';
const PICO_PINK = '#FF77A8';

const theme = createTheme({
  cssVariables: { colorSchemeSelector: 'data-color-scheme' },
  colorSchemes: {
    light: {
      palette: {
        // WCAG AA contrast: #3b3ec4 on white = 7.2:1, #b91c5c on white = 5.1:1
        primary: { main: '#3b3ec4' },
        secondary: { main: '#b91c5c' },
        success: { main: '#15803d' },
        warning: { main: '#b45309' },
        error: { main: '#be123c' },
        background: {
          default: '#f7f5f2',
          paper: '#ffffff',
        },
        text: {
          primary: '#1a1a2e',
          secondary: '#5c5a65',
        },
      },
    },
    dark: {
      palette: {
        primary: { main: '#818cf8' },
        secondary: { main: '#f472b6' },
        success: { main: PICO_GREEN },
        warning: { main: '#FFA300' },
        error: { main: '#FF004D' },
        background: {
          default: '#121520',
          paper: '#1a1e30',
        },
        text: {
          primary: '#eae6df',
          secondary: '#9b97a0',
        },
      },
    },
  },

  shape: {
    borderRadius: 6,
  },

  typography: {
    fontFamily:
      '"Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif',
    // Pixel-influenced headings with Silkscreen
    h1: {
      fontFamily: '"Silkscreen", cursive',
      fontSize: '1.75rem',
      lineHeight: 1.5,
      fontWeight: 400,
    },
    h2: {
      fontFamily: '"Silkscreen", cursive',
      fontSize: '1.5rem',
      lineHeight: 1.5,
      fontWeight: 400,
    },
    h3: {
      fontFamily: '"Silkscreen", cursive',
      fontSize: '1.25rem',
      lineHeight: 1.4,
      fontWeight: 400,
    },
    h4: {
      fontFamily: '"Silkscreen", cursive',
      fontSize: '1.15rem',
      lineHeight: 1.4,
    },
    h5: { fontSize: '1.05rem', fontWeight: 600 },
    h6: { fontSize: '1rem', fontWeight: 600 },
    button: {
      textTransform: 'none',
      fontWeight: 600,
    },
  },

  components: {
    MuiButton: {
      styleOverrides: {
        root: {
          borderRadius: 6,
          boxShadow: '0 1px 3px rgba(0,0,0,0.08)',
          '&:hover': {
            boxShadow: '0 2px 8px rgba(0,0,0,0.12)',
          },
          transition: 'box-shadow 0.15s ease-out, transform 0.15s ease-out',
        },
      },
    },

    MuiCard: {
      styleOverrides: {
        root: {
          borderRadius: 8,
          border: '1px solid var(--mui-palette-divider)',
          boxShadow: '0 1px 4px rgba(0,0,0,0.06)',
          backgroundImage: 'none',
          transition: 'box-shadow 0.15s ease-out, transform 0.15s ease-out',
        },
      },
    },

    MuiPaper: {
      styleOverrides: {
        root: {
          backgroundImage: 'none',
        },
      },
    },

    MuiChip: {
      styleOverrides: {
        root: {
          borderRadius: 6,
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

    MuiAlert: {
      styleOverrides: {
        root: {
          borderRadius: 6,
        },
      },
    },
  },
});

export default theme;
