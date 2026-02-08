import { useLoaderData, Link as RouterLink } from 'react-router';
import { fetchGroups } from '../api/groups.js';
import { fetchLessonsByGroup } from '../api/lessons.js';
import {
  Typography,
  Grid,
  Card,
  CardContent,
  Box,
  Chip,
  List,
  ListItemButton,
  ListItemText,
  ListItemIcon,
} from '@mui/material';
import MenuBookIcon from '@mui/icons-material/MenuBook';

export async function loader({ request }) {
  const groups = await fetchGroups({ signal: request.signal });

  // Load lessons for all groups in parallel
  const lessonsPerGroup = await Promise.all(
    groups.map((g) => fetchLessonsByGroup(g.id, { signal: request.signal })),
  );

  return groups.map((group, i) => ({
    ...group,
    lessons: lessonsPerGroup[i],
  }));
}

const DIFFICULTY_LABELS = {
  beginner: 'Cơ bản',
  intermediate: 'Trung bình',
  advanced: 'Nâng cao',
};

export default function HomePage() {
  const groups = useLoaderData();

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
                  {group.lessons.map((lesson) => (
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
                    </ListItemButton>
                  ))}
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
