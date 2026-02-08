import { Outlet, useNavigation } from 'react-router';
import {
  ThemeProvider,
  CssBaseline,
  AppBar,
  Toolbar,
  Typography,
  Container,
  LinearProgress,
  Box,
} from '@mui/material';
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
            <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
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
