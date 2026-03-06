import '@fontsource/press-start-2p/400.css';
import '@fontsource/silkscreen/400.css';
import '@fontsource/vt323/400.css';

import { useState } from 'react';
import {
  Outlet,
  redirect,
  useNavigation,
  useLocation,
  Link as RouterLink,
} from 'react-router';
import { ThemeProvider, useColorScheme } from '@mui/material/styles';
import CssBaseline from '@mui/material/CssBaseline';
import Box from '@mui/material/Box';
import Drawer from '@mui/material/Drawer';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import Divider from '@mui/material/Divider';
import Typography from '@mui/material/Typography';
import IconButton from '@mui/material/IconButton';
import Tooltip from '@mui/material/Tooltip';
import LinearProgress from '@mui/material/LinearProgress';
import Container from '@mui/material/Container';
import useMediaQuery from '@mui/material/useMediaQuery';

import DashboardIcon from '@mui/icons-material/Dashboard';
import TopicIcon from '@mui/icons-material/FolderOpen';
import CategoryIcon from '@mui/icons-material/Category';
import MenuBookIcon from '@mui/icons-material/MenuBook';
import AssignmentIcon from '@mui/icons-material/Assignment';
import RouteIcon from '@mui/icons-material/Route';
import RepeatIcon from '@mui/icons-material/Repeat';
import TrackChangesIcon from '@mui/icons-material/TrackChanges';
import AutoFixHighIcon from '@mui/icons-material/AutoFixHigh';
import UploadFileIcon from '@mui/icons-material/UploadFile';
import PermMediaIcon from '@mui/icons-material/PermMedia';
import AnalyticsIcon from '@mui/icons-material/Analytics';
import HistoryIcon from '@mui/icons-material/History';
import SettingsIcon from '@mui/icons-material/Settings';
import LightModeIcon from '@mui/icons-material/LightMode';
import DarkModeIcon from '@mui/icons-material/DarkMode';
import LogoutIcon from '@mui/icons-material/Logout';
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import ChevronRightIcon from '@mui/icons-material/ChevronRight';
import MenuIcon from '@mui/icons-material/Menu';

import pixelTheme from '../../theme/pixelTheme.js';
import { adminVerify } from '../../api/admin.js';
import { useAdminAuth } from '../../hooks/useAdminAuth.js';
import PageSkeleton from '../skeletons/PageSkeleton.jsx';
import PixelMascot from './PixelMascot.jsx';

const SIDEBAR_WIDTH = 240;
const SIDEBAR_COLLAPSED = 64;
const COLLAPSE_KEY = 'admin_sidebar_collapsed';

// Subtle pixel dot pattern for sidebar background texture
const SIDEBAR_PATTERN_LIGHT =
  'radial-gradient(circle, rgba(29,43,83,0.04) 1px, transparent 1px)';
const SIDEBAR_PATTERN_DARK =
  'radial-gradient(circle, rgba(255,241,232,0.02) 1px, transparent 1px)';

export async function loader() {
  const { authenticated } = await adminVerify();
  if (!authenticated) return redirect('/admin/login');
  return null;
}

const NAV_GROUPS = [
  {
    items: [{ label: 'Dashboard', icon: DashboardIcon, path: '/admin' }],
  },
  {
    title: 'CONTENT',
    items: [
      { label: 'Topics', icon: TopicIcon, path: '/admin/topics' },
      { label: 'Categories', icon: CategoryIcon, path: '/admin/categories' },
      { label: 'Lessons', icon: MenuBookIcon, path: '/admin/lessons' },
      { label: 'Exercises', icon: AssignmentIcon, path: '/admin/exercises' },
    ],
  },
  {
    title: 'LEARNING',
    items: [
      { label: 'Learning Paths', icon: RouteIcon, path: '/admin/paths' },
      { label: 'Spaced Repetition', icon: RepeatIcon, path: '/admin/review' },
      {
        label: 'Weak Spots',
        icon: TrackChangesIcon,
        path: '/admin/weak-spots',
      },
    ],
  },
  {
    title: 'CONTENT TOOLS',
    items: [
      {
        label: 'Content Generation',
        icon: AutoFixHighIcon,
        path: '/admin/generate',
      },
      { label: 'YAML Import', icon: UploadFileIcon, path: '/admin/import' },
      { label: 'Media Library', icon: PermMediaIcon, path: '/admin/media' },
    ],
  },
  {
    title: 'INSIGHTS',
    items: [
      { label: 'Analytics', icon: AnalyticsIcon, path: '/admin/analytics' },
      { label: 'Activity Log', icon: HistoryIcon, path: '/admin/activity' },
    ],
  },
];

function ColorModeToggle({ collapsed }) {
  const { mode, setMode } = useColorScheme();
  if (!mode) return null;

  const isDark = mode === 'dark';
  return (
    <ListItem disablePadding>
      <Tooltip
        title={collapsed ? (isDark ? 'Light mode' : 'Dark mode') : ''}
        placement="right"
      >
        <ListItemButton onClick={() => setMode(isDark ? 'light' : 'dark')}>
          <ListItemIcon
            sx={{ minWidth: collapsed ? 0 : 40, justifyContent: 'center' }}
          >
            {isDark ? <LightModeIcon /> : <DarkModeIcon />}
          </ListItemIcon>
          {!collapsed && (
            <ListItemText primary={isDark ? 'Light Mode' : 'Dark Mode'} />
          )}
        </ListItemButton>
      </Tooltip>
    </ListItem>
  );
}

function SidebarContent({ collapsed, onToggle, onLogout, location }) {
  return (
    <Box sx={{ display: 'flex', flexDirection: 'column', height: '100%' }}>
      {/* Logo area — pixel art styled header */}
      <Box
        sx={{
          display: 'flex',
          alignItems: 'center',
          justifyContent: collapsed ? 'center' : 'space-between',
          px: collapsed ? 1 : 2,
          py: 2,
          minHeight: 64,
          borderBottom: '2px solid',
          borderColor: 'divider',
          position: 'relative',
          '&::after': {
            content: '""',
            position: 'absolute',
            bottom: -1,
            left: 0,
            right: 0,
            height: 1,
            background:
              'linear-gradient(90deg, transparent, var(--mui-palette-primary-main), transparent)',
            opacity: 0.4,
          },
        }}
      >
        {!collapsed && (
          <Box sx={{ display: 'flex', alignItems: 'center', gap: 1.5 }}>
            {/* Pixel diamond logo mark */}
            <Box
              sx={{
                width: 28,
                height: 28,
                position: 'relative',
                flexShrink: 0,
                '&::before': {
                  content: '""',
                  position: 'absolute',
                  inset: 4,
                  bgcolor: 'primary.main',
                  transform: 'rotate(45deg)',
                  boxShadow: '0 0 10px rgba(41,173,255,0.4)',
                },
                '&::after': {
                  content: '""',
                  position: 'absolute',
                  inset: 8,
                  bgcolor: 'background.paper',
                  transform: 'rotate(45deg)',
                },
              }}
            />
            <Typography
              variant="h3"
              sx={{
                color: 'primary.main',
                whiteSpace: 'nowrap',
                textShadow: '0 0 12px rgba(41,173,255,0.25)',
              }}
            >
              LH Admin
            </Typography>
          </Box>
        )}
        <IconButton onClick={onToggle} size="small">
          {collapsed ? <ChevronRightIcon /> : <ChevronLeftIcon />}
        </IconButton>
      </Box>

      {/* Nav groups */}
      <Box sx={{ flex: 1, overflowY: 'auto', overflowX: 'hidden', py: 0.5 }}>
        {NAV_GROUPS.map((group, gi) => (
          <Box key={gi}>
            {group.title && !collapsed && (
              <Typography
                variant="overline"
                sx={{
                  px: 2,
                  pt: 2,
                  pb: 0.5,
                  display: 'block',
                  color: 'text.secondary',
                  letterSpacing: '0.12em',
                }}
              >
                {group.title}
              </Typography>
            )}
            {group.title && collapsed && gi > 0 && <Divider sx={{ my: 0.5 }} />}
            <List disablePadding>
              {group.items.map((item) => {
                const Icon = item.icon;
                const isActive =
                  item.path === '/admin'
                    ? location.pathname === '/admin'
                    : location.pathname.startsWith(item.path);
                return (
                  <ListItem key={item.path} disablePadding>
                    <Tooltip
                      title={collapsed ? item.label : ''}
                      placement="right"
                    >
                      <ListItemButton
                        component={RouterLink}
                        to={item.path}
                        selected={isActive}
                        sx={{
                          justifyContent: collapsed ? 'center' : 'flex-start',
                          px: collapsed ? 1 : 2,
                        }}
                      >
                        <ListItemIcon
                          sx={{
                            minWidth: collapsed ? 0 : 40,
                            justifyContent: 'center',
                            color: isActive ? 'primary.main' : 'inherit',
                            transition: 'color 0.15s ease-out',
                          }}
                        >
                          <Icon
                            sx={
                              isActive
                                ? {
                                    filter:
                                      'drop-shadow(0 0 4px rgba(41,173,255,0.5))',
                                  }
                                : undefined
                            }
                          />
                        </ListItemIcon>
                        {!collapsed && <ListItemText primary={item.label} />}
                      </ListItemButton>
                    </Tooltip>
                  </ListItem>
                );
              })}
            </List>
          </Box>
        ))}
      </Box>

      <Divider />

      {/* Bottom actions */}
      <List disablePadding>
        <ListItem disablePadding>
          <Tooltip title={collapsed ? 'Settings' : ''} placement="right">
            <ListItemButton
              component={RouterLink}
              to="/admin/settings"
              sx={{
                justifyContent: collapsed ? 'center' : 'flex-start',
                px: collapsed ? 1 : 2,
              }}
            >
              <ListItemIcon
                sx={{ minWidth: collapsed ? 0 : 40, justifyContent: 'center' }}
              >
                <SettingsIcon />
              </ListItemIcon>
              {!collapsed && <ListItemText primary="Settings" />}
            </ListItemButton>
          </Tooltip>
        </ListItem>

        <ColorModeToggle collapsed={collapsed} />

        <ListItem disablePadding>
          <Tooltip title={collapsed ? 'Logout' : ''} placement="right">
            <ListItemButton
              onClick={onLogout}
              sx={{
                justifyContent: collapsed ? 'center' : 'flex-start',
                px: collapsed ? 1 : 2,
                color: 'error.main',
              }}
            >
              <ListItemIcon
                sx={{
                  minWidth: collapsed ? 0 : 40,
                  justifyContent: 'center',
                  color: 'inherit',
                }}
              >
                <LogoutIcon />
              </ListItemIcon>
              {!collapsed && <ListItemText primary="Logout" />}
            </ListItemButton>
          </Tooltip>
        </ListItem>
      </List>
    </Box>
  );
}

function AdminLayoutContent() {
  const navigation = useNavigation();
  const location = useLocation();
  const { logout } = useAdminAuth();
  const isMobile = useMediaQuery(pixelTheme.breakpoints.down('md'));
  const isLoading = navigation.state === 'loading';

  const [collapsed, setCollapsed] = useState(
    () => localStorage.getItem(COLLAPSE_KEY) === 'true',
  );
  const [mobileOpen, setMobileOpen] = useState(false);

  function handleToggle() {
    if (isMobile) {
      setMobileOpen((o) => !o);
    } else {
      setCollapsed((prev) => {
        const next = !prev;
        localStorage.setItem(COLLAPSE_KEY, String(next));
        return next;
      });
    }
  }

  const drawerWidth = collapsed ? SIDEBAR_COLLAPSED : SIDEBAR_WIDTH;

  const sidebarContent = (
    <SidebarContent
      collapsed={isMobile ? false : collapsed}
      onToggle={handleToggle}
      onLogout={logout}
      location={location}
    />
  );

  // Shared sidebar paper styles — pixel dot texture + subtle gradient
  const sidebarPaperSx = {
    bgcolor: 'background.paper',
    backgroundImage: SIDEBAR_PATTERN_LIGHT,
    backgroundSize: '4px 4px',
    '[data-color-scheme="dark"] &': {
      backgroundImage: SIDEBAR_PATTERN_DARK,
    },
    // Subtle vertical gradient overlay for depth
    '&::before': {
      content: '""',
      position: 'absolute',
      inset: 0,
      background:
        'linear-gradient(180deg, transparent 0%, rgba(29,43,83,0.03) 100%)',
      pointerEvents: 'none',
    },
  };

  return (
    <Box sx={{ display: 'flex', minHeight: '100vh' }}>
      {/* Mobile drawer */}
      {isMobile ? (
        <>
          <Box sx={{ position: 'fixed', top: 8, left: 8, zIndex: 1201 }}>
            <IconButton
              onClick={() => setMobileOpen(true)}
              sx={{ color: 'text.primary' }}
            >
              <MenuIcon />
            </IconButton>
          </Box>
          <Drawer
            variant="temporary"
            open={mobileOpen}
            onClose={() => setMobileOpen(false)}
            sx={{
              '& .MuiDrawer-paper': {
                width: SIDEBAR_WIDTH,
                ...sidebarPaperSx,
              },
            }}
          >
            {sidebarContent}
          </Drawer>
        </>
      ) : (
        <Drawer
          variant="permanent"
          sx={{
            width: drawerWidth,
            flexShrink: 0,
            '& .MuiDrawer-paper': {
              width: drawerWidth,
              boxSizing: 'border-box',
              borderRight: '2px solid',
              borderColor: 'divider',
              transition: 'width 0.2s ease-out',
              ...sidebarPaperSx,
            },
          }}
        >
          {sidebarContent}
        </Drawer>
      )}

      {/* Main content */}
      <Box
        component="main"
        sx={{
          flex: 1,
          minWidth: 0,
          position: 'relative',
        }}
      >
        {isLoading && (
          <LinearProgress
            color="primary"
            sx={{
              position: 'fixed',
              top: 0,
              left: isMobile ? 0 : drawerWidth,
              right: 0,
              zIndex: 1200,
            }}
          />
        )}
        <Container maxWidth="xl" sx={{ py: 4, px: { xs: 2, sm: 3 } }}>
          {isLoading ? <PageSkeleton /> : <Outlet />}
        </Container>
      </Box>

      <PixelMascot />
    </Box>
  );
}

export default function AdminLayout() {
  return (
    <ThemeProvider theme={pixelTheme}>
      <CssBaseline enableColorScheme />
      <AdminLayoutContent />
    </ThemeProvider>
  );
}
