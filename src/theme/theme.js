import { createTheme } from '@mui/material/styles';

const theme = createTheme({
  cssVariables: true,
  colorSchemes: {
    light: {
      palette: {
        // Contrast-safe: #4f46e5 on white = 4.7:1 (AA), #c2185b on white = 5.6:1
        primary: { main: '#4f46e5' },
        secondary: { main: '#c2185b' },
      },
    },
    dark: {
      palette: {
        primary: { main: '#818cf8' },
        secondary: { main: '#f472b6' },
      },
    },
  },
});

export default theme;
