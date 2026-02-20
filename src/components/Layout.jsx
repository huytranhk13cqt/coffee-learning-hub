import { useEffect } from 'react';
import {
  Outlet,
  useNavigation,
  useLocation,
  useRouteLoaderData,
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
import EmojiEventsIcon from '@mui/icons-material/EmojiEvents';
import LightModeIcon from '@mui/icons-material/LightMode';
import DarkModeIcon from '@mui/icons-material/DarkMode';
import theme from '../theme/theme.js';
import MuiLink from '@mui/material/Link';
import SearchBar from './search/SearchBar.jsx';
import PageSkeleton from './skeletons/PageSkeleton.jsx';
import StreakDisplay from './gamification/StreakDisplay.jsx';
import XPDisplay from './gamification/XPDisplay.jsx';
import DailyGoalProgress from './gamification/DailyGoalProgress.jsx';
import GamificationProvider from '../contexts/GamificationContext.jsx';
import { useGamification } from '../hooks/useGamification.js';

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
 * Gamification indicators in the AppBar — reads from GamificationContext.
 * Shows streak, XP, and daily goal progress as compact badges.
 */
function GamificationBar() {
  const ctx = useGamification();
  if (!ctx?.stats) return null;

  const { xp, streak, dailyGoal } = ctx.stats;

  return (
    <Box
      sx={{
        display: 'flex',
        alignItems: 'center',
        gap: { xs: 1, sm: 1.5 },
        mr: 1,
      }}
    >
      <StreakDisplay streak={streak?.current} />
      <XPDisplay totalXP={xp?.total} level={xp?.level} />
      <Box sx={{ display: { xs: 'none', sm: 'flex' } }}>
        <DailyGoalProgress
          completed={dailyGoal?.completed}
          target={dailyGoal?.target}
        />
      </Box>
    </Box>
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
  const rootData = useRouteLoaderData('root');

  useEffect(() => {
    window.scrollTo(0, 0);
  }, [location.pathname]);

  return (
    <GamificationProvider initialStats={rootData?.gamification ?? null}>
      <Box
        sx={{ display: 'flex', flexDirection: 'column', minHeight: '100vh' }}
      >
        {/* Skip navigation link (WCAG 2.4.1) */}
        <MuiLink
          href="#main-content"
          sx={{
            position: 'absolute',
            left: '-100vw',
            '&:focus': {
              left: 8,
              top: 8,
              zIndex: (t) => t.zIndex.tooltip + 1,
              bgcolor: 'background.paper',
              px: 2,
              py: 1,
              borderRadius: 1,
              boxShadow: 3,
            },
          }}
        >
          Bỏ qua thanh điều hướng
        </MuiLink>
        <AppBar position="sticky" component="nav">
          <Toolbar>
            <SchoolIcon aria-hidden="true" sx={{ mr: 1.5 }} />
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
            <GamificationBar />
            <SearchBar />
            <ColorModeToggle />
            <Tooltip title="Thành tựu">
              <IconButton
                color="inherit"
                component={RouterLink}
                to="/achievements"
                aria-label="Thành tựu"
                sx={{ ml: 0.5 }}
              >
                <EmojiEventsIcon aria-hidden="true" />
              </IconButton>
            </Tooltip>
            <Tooltip title="Bài học đã lưu">
              <IconButton
                color="inherit"
                component={RouterLink}
                to="/bookmarks"
                aria-label="Bài học đã lưu"
                sx={{ ml: 0.5 }}
              >
                <BookmarkIcon aria-hidden="true" />
              </IconButton>
            </Tooltip>
            <Tooltip title="Tổng quan">
              <IconButton
                color="inherit"
                component={RouterLink}
                to="/dashboard"
                aria-label="Tổng quan học tập"
                sx={{ ml: 0.5 }}
              >
                <BarChartIcon aria-hidden="true" />
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
        <Container
          component="main"
          id="main-content"
          maxWidth="lg"
          sx={{ py: 4, flex: 1 }}
        >
          {isLoading ? <PageSkeleton /> : <Outlet />}
        </Container>
      </Box>
    </GamificationProvider>
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
