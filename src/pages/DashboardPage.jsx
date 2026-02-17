import { useLoaderData, Link as RouterLink } from 'react-router';
import { fetchDashboard } from '../api/progress.js';
import { useDocumentTitle } from '../hooks/useDocumentTitle.js';
import Typography from '@mui/material/Typography';
import Grid from '@mui/material/Grid';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Paper from '@mui/material/Paper';
import Box from '@mui/material/Box';
import Stack from '@mui/material/Stack';
import List from '@mui/material/List';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemText from '@mui/material/ListItemText';
import ListItemIcon from '@mui/material/ListItemIcon';
import LinearProgress from '@mui/material/LinearProgress';
import Button from '@mui/material/Button';
import MenuBookIcon from '@mui/icons-material/MenuBook';
import SchoolIcon from '@mui/icons-material/School';
import CheckCircleIcon from '@mui/icons-material/CheckCircle';
import AccessTimeIcon from '@mui/icons-material/AccessTime';
import TrendingUpIcon from '@mui/icons-material/TrendingUp';
import LessonStatusChip from '../components/progress/LessonStatusChip.jsx';
import Fade from '@mui/material/Fade';
import ScoreBadge from '../components/progress/ScoreBadge.jsx';

export async function loader({ request }) {
  return fetchDashboard({ signal: request.signal });
}

function formatTime(seconds) {
  if (!seconds || seconds <= 0) return '0m';
  const h = Math.floor(seconds / 3600);
  const m = Math.floor((seconds % 3600) / 60);
  if (h > 0) return `${h}h ${m}m`;
  return `${m}m`;
}

function groupBy(arr, keyFn) {
  const map = Object.create(null);
  for (const item of arr) {
    const key = keyFn(item);
    (map[key] ||= []).push(item);
  }
  return map;
}

const STAT_CARDS = [
  {
    key: 'started',
    icon: SchoolIcon,
    label: 'Bài đã học',
    color: 'primary.main',
  },
  {
    key: 'completed',
    icon: CheckCircleIcon,
    label: 'Hoàn thành',
    color: 'success.main',
  },
  {
    key: 'avgScore',
    icon: TrendingUpIcon,
    label: 'Điểm trung bình',
    color: 'warning.main',
  },
  {
    key: 'time',
    icon: AccessTimeIcon,
    label: 'Thời gian học',
    color: 'info.main',
  },
];

function getStatValue(key, stats) {
  switch (key) {
    case 'started':
      return `${stats.lessons_started}/${stats.total_lessons}`;
    case 'completed':
      return `${stats.lessons_completed}/${stats.total_lessons}`;
    case 'avgScore':
      return stats.lessons_started > 0
        ? `${Math.round(stats.avg_score)}%`
        : '—';
    case 'time':
      return formatTime(stats.total_time_seconds);
    default:
      return '—';
  }
}

export default function DashboardPage() {
  const { stats, lessons } = useLoaderData();
  useDocumentTitle('Tổng quan học tập');
  const grouped = groupBy(lessons, (l) => l.group_id);

  // Extract unique groups in order (lessons are already sorted by group order)
  const groups = [];
  const seen = new Set();
  for (const lesson of lessons) {
    if (!seen.has(lesson.group_id)) {
      seen.add(lesson.group_id);
      groups.push({
        id: lesson.group_id,
        name: lesson.group_name,
        name_vi: lesson.group_name_vi,
        color: lesson.group_color,
        icon: lesson.group_icon,
      });
    }
  }

  const isEmpty = stats.lessons_started === 0;

  return (
    <Fade in timeout={300}>
      <div>
        <Typography variant="h4" component="h1" gutterBottom>
          Tổng quan học tập
        </Typography>

        {/* Stat Cards */}
        <Grid container spacing={2} sx={{ mb: 4 }}>
          {STAT_CARDS.map(({ key, icon: Icon, label, color }) => (
            <Grid key={key} size={{ xs: 6, sm: 3 }}>
              <Card variant="outlined">
                <CardContent sx={{ textAlign: 'center', py: 2 }}>
                  <Icon sx={{ fontSize: 32, color, mb: 0.5 }} />
                  <Typography variant="h5" fontWeight={700}>
                    {getStatValue(key, stats)}
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    {label}
                  </Typography>
                </CardContent>
              </Card>
            </Grid>
          ))}
        </Grid>

        {/* Empty state */}
        {isEmpty && (
          <Paper variant="outlined" sx={{ p: 4, textAlign: 'center', mb: 4 }}>
            <SchoolIcon sx={{ fontSize: 48, color: 'text.disabled', mb: 1 }} />
            <Typography variant="h6" gutterBottom>
              Chưa có tiến trình nào
            </Typography>
            <Typography color="text.secondary" sx={{ mb: 2 }}>
              Bắt đầu học bài đầu tiên để theo dõi tiến trình của bạn!
            </Typography>
            <Button variant="contained" component={RouterLink} to="/">
              Bắt đầu học
            </Button>
          </Paper>
        )}

        {/* Per-group lesson progress */}
        <Stack spacing={3}>
          {groups.map((group) => (
            <Paper
              key={group.id}
              variant="outlined"
              sx={{ borderTop: 4, borderColor: group.color }}
            >
              <Box sx={{ px: 2.5, pt: 2, pb: 1 }}>
                <Typography variant="h6">{group.name}</Typography>
                <Typography variant="body2" color="text.secondary">
                  {group.name_vi}
                </Typography>
              </Box>

              <List dense disablePadding>
                {grouped[group.id].map((lesson) => {
                  const exercisePercent =
                    lesson.exercises_total > 0
                      ? Math.round(
                          (lesson.exercises_attempted /
                            lesson.exercises_total) *
                            100,
                        )
                      : 0;

                  return (
                    <ListItemButton
                      key={lesson.lesson_id}
                      component={RouterLink}
                      to={`/lessons/${lesson.slug}`}
                      sx={{ px: 2.5 }}
                    >
                      <ListItemIcon sx={{ minWidth: 36 }}>
                        <MenuBookIcon
                          fontSize="small"
                          sx={{ color: group.color }}
                        />
                      </ListItemIcon>
                      <ListItemText
                        primary={lesson.lesson_name_vi}
                        secondary={
                          lesson.exercises_total > 0
                            ? `${lesson.exercises_attempted}/${lesson.exercises_total} bài tập`
                            : 'Chưa có bài tập'
                        }
                      />
                      <Box
                        sx={{
                          display: 'flex',
                          alignItems: 'center',
                          gap: 1,
                          ml: 1,
                          flexShrink: 0,
                        }}
                      >
                        {lesson.exercises_total > 0 && (
                          <Box
                            sx={{
                              width: 60,
                              display: { xs: 'none', sm: 'block' },
                            }}
                          >
                            <LinearProgress
                              variant="determinate"
                              value={exercisePercent}
                              sx={{ height: 6, borderRadius: 3 }}
                            />
                          </Box>
                        )}
                        <ScoreBadge score={lesson.best_score} label="" />
                        <LessonStatusChip status={lesson.status} />
                      </Box>
                    </ListItemButton>
                  );
                })}
              </List>
            </Paper>
          ))}
        </Stack>
      </div>
    </Fade>
  );
}
