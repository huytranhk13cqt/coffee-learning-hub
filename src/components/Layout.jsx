import { useEffect } from 'react';
import {
  Outlet,
  useNavigation,
  useLocation,
  Link as RouterLink,
} from 'react-router';
import { ThemeProvider } from '@mui/material/styles';
import CssBaseline from '@mui/material/CssBaseline';
import AppBar from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';
import LinearProgress from '@mui/material/LinearProgress';
import Box from '@mui/material/Box';
import IconButton from '@mui/material/IconButton';
import Tooltip from '@mui/material/Tooltip';
import SchoolIcon from '@mui/icons-material/School';
import BarChartIcon from '@mui/icons-material/BarChart';
import theme from '../theme/theme.js';
import SearchBar from './search/SearchBar.jsx';
import PageSkeleton from './skeletons/PageSkeleton.jsx';

export default function Layout() {
  const navigation = useNavigation();
  const location = useLocation();
  const isLoading = navigation.state === 'loading';

  useEffect(() => {
    window.scrollTo(0, 0);
  }, [location.pathname]);

  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <Box
        sx={{ display: 'flex', flexDirection: 'column', minHeight: '100vh' }}
      >
        <AppBar position="sticky">
          <Toolbar>
            <SchoolIcon sx={{ mr: 1.5 }} />
            <Typography
              variant="h6"
              component={RouterLink}
              to="/"
              sx={{
                textDecoration: 'none',
                color: 'inherit',
                mr: 2,
                display: { xs: 'none', sm: 'block' },
              }}
            >
              Learning Hub
            </Typography>
            <Box sx={{ flexGrow: 1 }} />
            <SearchBar />
            <Tooltip title="Tổng quan">
              <IconButton
                color="inherit"
                component={RouterLink}
                to="/dashboard"
                sx={{ ml: 1 }}
              >
                <BarChartIcon />
              </IconButton>
            </Tooltip>
          </Toolbar>
          {isLoading && (
            <LinearProgress
              color="secondary"
              sx={{ position: 'absolute', bottom: 0, left: 0, right: 0 }}
            />
          )}
        </AppBar>
        <Container maxWidth="lg" sx={{ py: 4, flex: 1 }}>
          {isLoading ? <PageSkeleton /> : <Outlet />}
        </Container>
      </Box>
    </ThemeProvider>
  );
}
