import { useEffect } from 'react';
import {
  Outlet,
  useNavigation,
  useLocation,
  Link as RouterLink,
} from 'react-router';
import { ThemeProvider, useColorScheme } from '@mui/material/styles';
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
import LightModeIcon from '@mui/icons-material/LightMode';
import DarkModeIcon from '@mui/icons-material/DarkMode';
import theme from '../theme/theme.js';
import SearchBar from './search/SearchBar.jsx';
import PageSkeleton from './skeletons/PageSkeleton.jsx';

/**
 * Theme toggle button — must be rendered inside ThemeProvider
 * because useColorScheme reads from the nearest provider.
 */
function ColorModeToggle() {
  const { mode, setMode } = useColorScheme();
  if (!mode) return null;

  const isDark = mode === 'dark';
  return (
    <Tooltip title={isDark ? 'Chế độ sáng' : 'Chế độ tối'}>
      <IconButton
        color="inherit"
        onClick={() => setMode(isDark ? 'light' : 'dark')}
        aria-label={
          isDark ? 'Chuyển sang chế độ sáng' : 'Chuyển sang chế độ tối'
        }
        sx={{ ml: 0.5 }}
      >
        {isDark ? <LightModeIcon /> : <DarkModeIcon />}
      </IconButton>
    </Tooltip>
  );
}

/**
 * Inner layout content — separate component so useColorScheme
 * can access the ThemeProvider context from the outer Layout.
 */
function LayoutContent() {
  const navigation = useNavigation();
  const location = useLocation();
  const isLoading = navigation.state === 'loading';

  useEffect(() => {
    window.scrollTo(0, 0);
  }, [location.pathname]);

  return (
    <Box sx={{ display: 'flex', flexDirection: 'column', minHeight: '100vh' }}>
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
          <ColorModeToggle />
          <Tooltip title="Tổng quan">
            <IconButton
              color="inherit"
              component={RouterLink}
              to="/dashboard"
              sx={{ ml: 0.5 }}
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
  );
}

export default function Layout() {
  return (
    <ThemeProvider theme={theme}>
      <CssBaseline enableColorScheme />
      <LayoutContent />
    </ThemeProvider>
  );
}
