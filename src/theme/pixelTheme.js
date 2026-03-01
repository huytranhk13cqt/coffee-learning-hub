import { createTheme } from '@mui/material/styles';

// PICO-8 palette
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

// Pixel-art box-shadow borders
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

const pixelTheme = createTheme({
  cssVariables: { colorSchemeSelector: 'data-color-scheme' },
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
          default: PICO.darkBlue,
          paper: '#262b44',
        },
        text: {
          primary: PICO.white,
          secondary: PICO.lightGrey,
        },
        divider: PICO.darkGrey,
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
          default: '#f0ebe3',
          paper: PICO.white,
        },
        text: {
          primary: '#1a1a2e',
          secondary: PICO.darkGrey,
        },
        divider: PICO.lightGrey,
      },
    },
  },
  shape: {
    borderRadius: 0,
  },
  typography: {
    fontFamily: '"VT323", "Courier New", monospace',
    fontSize: 16,
    h1: {
      fontFamily: '"Press Start 2P", cursive',
      fontSize: '1.5rem',
      lineHeight: 1.8,
    },
    h2: {
      fontFamily: '"Press Start 2P", cursive',
      fontSize: '1.25rem',
      lineHeight: 1.8,
    },
    h3: {
      fontFamily: '"Press Start 2P", cursive',
      fontSize: '1rem',
      lineHeight: 1.6,
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
        },
      },
    },
    MuiButton: {
      styleOverrides: {
        root: {
          borderRadius: 0,
          boxShadow: pixelBorder('#000'),
          textTransform: 'none',
          '&:hover': {
            transform: 'translate(-1px, -1px)',
            boxShadow: pixelBorderThick('#000'),
          },
          '&:active': {
            transform: 'translate(1px, 1px)',
          },
          transition: 'transform 0.1s step-end, box-shadow 0.1s step-end',
        },
      },
    },
    MuiCard: {
      styleOverrides: {
        root: {
          borderRadius: 0,
          boxShadow: pixelBorderThick('var(--mui-palette-divider)'),
          backgroundImage: 'none',
        },
      },
    },
    MuiPaper: {
      styleOverrides: {
        root: {
          borderRadius: 0,
          backgroundImage: 'none',
        },
      },
    },
    MuiTextField: {
      styleOverrides: {
        root: {
          '& .MuiOutlinedInput-root': {
            borderRadius: 0,
            '& fieldset': {
              borderWidth: 2,
            },
          },
        },
      },
    },
    MuiChip: {
      styleOverrides: {
        root: {
          borderRadius: 0,
          fontFamily: '"VT323", monospace',
          fontSize: '1rem',
        },
      },
    },
    MuiLinearProgress: {
      styleOverrides: {
        root: {
          borderRadius: 0,
          height: 8,
          boxShadow: pixelBorder('#000'),
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
          borderRadius: 0,
          '&.Mui-selected': {
            borderLeft: '4px solid var(--mui-palette-primary-main)',
          },
        },
      },
    },
  },
});

export default pixelTheme;
export { PICO, pixelBorder, pixelBorderThick };
