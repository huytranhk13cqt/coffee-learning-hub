import { useLoaderData, Link as RouterLink } from 'react-router';
import { fetchGroups } from '../api/groups.js';
import { fetchLessonsByGroup } from '../api/lessons.js';
import { fetchSessionOverview } from '../api/progress.js';
import Typography from '@mui/material/Typography';
import Grid from '@mui/material/Grid';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Box from '@mui/material/Box';
import Chip from '@mui/material/Chip';
import List from '@mui/material/List';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemText from '@mui/material/ListItemText';
import ListItemIcon from '@mui/material/ListItemIcon';
import MenuBookIcon from '@mui/icons-material/MenuBook';
import LessonStatusChip from '../components/progress/LessonStatusChip.jsx';
import ScoreBadge from '../components/progress/ScoreBadge.jsx';

export async function loader({ request }) {
  const groups = await fetchGroups({ signal: request.signal });

  // Load lessons + session progress in parallel
  const [lessonsPerGroup, progressData] = await Promise.all([
    Promise.all(
      groups.map((g) => fetchLessonsByGroup(g.id, { signal: request.signal })),
    ),
    fetchSessionOverview({ signal: request.signal }).catch(() => []),
  ]);

  // Index progress by lesson_id for O(1) lookup
  const progressByLesson = Object.create(null);
  for (const p of progressData) {
    progressByLesson[p.lesson_id] = p;
  }

  return {
    groups: groups.map((group, i) => ({
      ...group,
      lessons: lessonsPerGroup[i],
    })),
    progressByLesson,
  };
}

const DIFFICULTY_LABELS = {
  beginner: 'Cơ bản',
  intermediate: 'Trung bình',
  advanced: 'Nâng cao',
};

export default function HomePage() {
  const { groups, progressByLesson } = useLoaderData();

  return (
    <>
      <Typography variant="h4" component="h1" gutterBottom>
        English Grammar
      </Typography>
      <Typography variant="subtitle1" color="text.secondary" sx={{ mb: 4 }}>
        Chọn bài học để bắt đầu
      </Typography>

      <Grid container spacing={3}>
        {groups.map((group) => (
          <Grid key={group.id} size={{ xs: 12, sm: 6, md: 4 }}>
            <Card
              sx={{
                height: '100%',
                borderTop: 4,
                borderColor: group.color,
              }}
            >
              <CardContent>
                <Typography variant="h5" gutterBottom>
                  {group.name}
                </Typography>
                <Typography variant="subtitle2" color="text.secondary" gutterBottom>
                  {group.name_vi}
                </Typography>

                <List dense disablePadding>
                  {group.lessons.map((lesson) => {
                    const progress = progressByLesson[lesson.id];
                    return (
                      <ListItemButton
                        key={lesson.id}
                        component={RouterLink}
                        to={`/lessons/${lesson.slug}`}
                        sx={{ borderRadius: 1 }}
                      >
                        <ListItemIcon sx={{ minWidth: 36 }}>
                          <MenuBookIcon fontSize="small" sx={{ color: group.color }} />
                        </ListItemIcon>
                        <ListItemText
                          primary={lesson.name}
                          secondary={`${lesson.name_vi} · ${DIFFICULTY_LABELS[lesson.difficulty] || lesson.difficulty}`}
                        />
                        <Box sx={{ display: 'flex', alignItems: 'center', gap: 1, ml: 1, flexShrink: 0 }}>
                          <ScoreBadge score={progress?.best_score} label="" />
                          <LessonStatusChip status={progress?.status} />
                        </Box>
                      </ListItemButton>
                    );
                  })}
                </List>

                <Box sx={{ mt: 1 }}>
                  <Chip
                    label={`${group.lessons.length} bài học`}
                    size="small"
                    sx={{ backgroundColor: group.color, color: '#fff' }}
                  />
                </Box>
              </CardContent>
            </Card>
          </Grid>
        ))}
      </Grid>
    </>
  );
}
