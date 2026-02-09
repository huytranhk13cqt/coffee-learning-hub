import { Outlet, useNavigation, Link as RouterLink } from 'react-router';
import { ThemeProvider } from '@mui/material/styles';
import CssBaseline from '@mui/material/CssBaseline';
import AppBar from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';
import LinearProgress from '@mui/material/LinearProgress';
import Box from '@mui/material/Box';
import SchoolIcon from '@mui/icons-material/School';
import theme from '../theme/theme.js';

export default function Layout() {
  const navigation = useNavigation();
  const isLoading = navigation.state === 'loading';

  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <Box sx={{ display: 'flex', flexDirection: 'column', minHeight: '100vh' }}>
        <AppBar position="sticky">
          <Toolbar>
            <SchoolIcon sx={{ mr: 1.5 }} />
            <Typography
              variant="h6"
              component={RouterLink}
              to="/"
              sx={{ flexGrow: 1, textDecoration: 'none', color: 'inherit' }}
            >
              Grammar Learning
            </Typography>
          </Toolbar>
          {isLoading && (
            <LinearProgress
              color="secondary"
              sx={{ position: 'absolute', bottom: 0, left: 0, right: 0 }}
            />
          )}
        </AppBar>
        <Container maxWidth="lg" sx={{ py: 4, flex: 1 }}>
          <Outlet />
        </Container>
      </Box>
    </ThemeProvider>
  );
}
