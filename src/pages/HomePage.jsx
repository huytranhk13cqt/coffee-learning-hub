import { useLoaderData, Link as RouterLink } from 'react-router';
import { fetchHomePage } from '../api/groups.js';
import { useDocumentTitle } from '../hooks/useDocumentTitle.js';
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
import Fade from '@mui/material/Fade';
import { DIFFICULTY_LABELS } from '../constants/difficulty.js';

export async function loader({ request }) {
  const { groups } = await fetchHomePage({ signal: request.signal });
  return { groups };
}

export default function HomePage() {
  const { groups } = useLoaderData();
  useDocumentTitle(null); // Home page uses base title

  return (
    <Fade in timeout={300}>
      <div>
        <Typography variant="h4" component="h1" gutterBottom>
          Learning Hub
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
                  <Typography
                    variant="subtitle2"
                    color="text.secondary"
                    gutterBottom
                  >
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
                          <MenuBookIcon
                            fontSize="small"
                            sx={{ color: group.color }}
                          />
                        </ListItemIcon>
                        <ListItemText
                          primary={lesson.name}
                          secondary={`${lesson.name_vi} · ${DIFFICULTY_LABELS[lesson.difficulty] || lesson.difficulty}`}
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
                          <ScoreBadge score={lesson.best_score} label="" />
                          <LessonStatusChip status={lesson.status} />
                        </Box>
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
      </div>
    </Fade>
  );
}
