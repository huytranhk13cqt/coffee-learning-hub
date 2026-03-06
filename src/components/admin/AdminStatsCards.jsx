import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Grid from '@mui/material/Grid';
import FolderOpenIcon from '@mui/icons-material/FolderOpen';
import CategoryIcon from '@mui/icons-material/Category';
import MenuBookIcon from '@mui/icons-material/MenuBook';
import AssignmentIcon from '@mui/icons-material/Assignment';
import ArticleIcon from '@mui/icons-material/Article';
import RouteIcon from '@mui/icons-material/Route';
import { PICO } from '../../theme/pixelTheme.js';

const STAT_CARDS = [
  { key: 'topics', label: 'Topics', icon: FolderOpenIcon, color: PICO.blue },
  {
    key: 'categories',
    label: 'Categories',
    icon: CategoryIcon,
    color: PICO.lavender,
  },
  { key: 'lessons', label: 'Lessons', icon: MenuBookIcon, color: PICO.green },
  {
    key: 'exercises',
    label: 'Exercises',
    icon: AssignmentIcon,
    color: PICO.orange,
  },
  { key: 'sections', label: 'Sections', icon: ArticleIcon, color: PICO.pink },
  { key: 'learning_paths', label: 'Paths', icon: RouteIcon, color: PICO.peach },
];

export default function AdminStatsCards({ stats }) {
  if (!stats) return null;

  return (
    <Grid container spacing={2}>
      {STAT_CARDS.map(({ key, label, icon: Icon, color }) => (
        <Grid key={key} size={{ xs: 6, sm: 4, md: 2 }}>
          <Card
            sx={{
              minHeight: 100,
              borderTop: `3px solid ${color}`,
              position: 'relative',
              overflow: 'hidden',
              '&:hover': {
                transform: 'translateY(-3px) scale(1.02)',
                boxShadow: `0 6px 20px ${color}22, 0 3px 8px rgba(29,43,83,0.10)`,
              },
              transition: 'transform 0.2s ease-out, box-shadow 0.2s ease-out',
            }}
          >
            <CardContent sx={{ p: 2, '&:last-child': { pb: 2 } }}>
              <Box sx={{ display: 'flex', alignItems: 'center', gap: 1.5 }}>
                <Box
                  sx={{
                    width: 40,
                    height: 40,
                    borderRadius: 2,
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    bgcolor: `${color}18`,
                    border: `1px solid ${color}30`,
                    flexShrink: 0,
                  }}
                >
                  <Icon sx={{ fontSize: '1.4rem', color }} />
                </Box>
                <Box>
                  <Typography variant="h3">{stats[key] ?? 0}</Typography>
                  <Typography variant="caption" color="text.secondary">
                    {label}
                  </Typography>
                </Box>
              </Box>
            </CardContent>
          </Card>
        </Grid>
      ))}
    </Grid>
  );
}
