import { useLoaderData, Link as RouterLink } from 'react-router';
import { fetchHomePage } from '../api/groups.js';
import { useDocumentTitle } from '../hooks/useDocumentTitle.js';
import Typography from '@mui/material/Typography';
import Grid from '@mui/material/Grid';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Box from '@mui/material/Box';
import Chip from '@mui/material/Chip';
import Stack from '@mui/material/Stack';
import List from '@mui/material/List';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemText from '@mui/material/ListItemText';
import ListItemIcon from '@mui/material/ListItemIcon';
import Divider from '@mui/material/Divider';
import MenuBookIcon from '@mui/icons-material/MenuBook';
import TranslateIcon from '@mui/icons-material/Translate';
import ComputerIcon from '@mui/icons-material/Computer';
import ScienceIcon from '@mui/icons-material/Science';
import HistoryEduIcon from '@mui/icons-material/HistoryEdu';
import PaletteIcon from '@mui/icons-material/Palette';
import TrendingUpIcon from '@mui/icons-material/TrendingUp';
import LessonStatusChip from '../components/progress/LessonStatusChip.jsx';
import ScoreBadge from '../components/progress/ScoreBadge.jsx';
import Fade from '@mui/material/Fade';
import { DIFFICULTY_LABELS } from '../constants/difficulty.js';

// Icon mapping for topic icons (avoids dynamic imports)
const TOPIC_ICONS = {
  Translate: TranslateIcon,
  Computer: ComputerIcon,
  Science: ScienceIcon,
  HistoryEdu: HistoryEduIcon,
  Palette: PaletteIcon,
  TrendingUp: TrendingUpIcon,
};

function getTopicLessonCount(topic) {
  return topic.groups.reduce((sum, g) => sum + g.lessons.length, 0);
}

export async function loader({ request }) {
  const { topics } = await fetchHomePage({ signal: request.signal });
  return { topics };
}

export default function HomePage() {
  const { topics } = useLoaderData();
  useDocumentTitle(null);

  return (
    <Fade in timeout={300}>
      <div>
        <Typography variant="h4" component="h1" gutterBottom>
          Learning Hub
        </Typography>
        <Typography variant="subtitle1" color="text.secondary" sx={{ mb: 3 }}>
          Chọn chủ đề để bắt đầu học
        </Typography>

        {/* Topic Navigation Chips */}
        <Stack
          direction="row"
          spacing={1}
          flexWrap="wrap"
          useFlexGap
          sx={{ mb: 4 }}
        >
          {topics.map((topic) => {
            const count = getTopicLessonCount(topic);
            return (
              <Chip
                key={topic.id ?? 'other'}
                label={`${topic.name_vi} (${count})`}
                onClick={() => {
                  const el = document.getElementById(
                    `topic-${topic.id ?? 'other'}`,
                  );
                  el?.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }}
                sx={{
                  bgcolor: topic.color + '18',
                  color: topic.color,
                  fontWeight: 600,
                  '&:hover': { bgcolor: topic.color + '30' },
                }}
              />
            );
          })}
        </Stack>

        {/* Topic Sections */}
        <Stack spacing={5}>
          {topics.map((topic) => (
            <TopicSection key={topic.id ?? 'other'} topic={topic} />
          ))}
        </Stack>
      </div>
    </Fade>
  );
}

function TopicSection({ topic }) {
  const TopicIcon = TOPIC_ICONS[topic.icon] || MenuBookIcon;
  const lessonCount = getTopicLessonCount(topic);

  return (
    <Box id={`topic-${topic.id ?? 'other'}`} sx={{ scrollMarginTop: 80 }}>
      {/* Topic Header */}
      <Box sx={{ display: 'flex', alignItems: 'center', gap: 1.5, mb: 2.5 }}>
        <Box
          sx={{
            width: 44,
            height: 44,
            borderRadius: 2,
            bgcolor: topic.color + '18',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            flexShrink: 0,
          }}
        >
          <TopicIcon sx={{ color: topic.color, fontSize: 26 }} />
        </Box>
        <Box sx={{ flex: 1, minWidth: 0 }}>
          <Typography variant="h5" component="h2" sx={{ lineHeight: 1.3 }}>
            {topic.name}
          </Typography>
          <Typography variant="body2" color="text.secondary">
            {topic.name_vi} · {lessonCount} bài học
          </Typography>
        </Box>
      </Box>

      <Divider sx={{ mb: 2.5 }} />

      {/* Category Cards Grid */}
      <Grid container spacing={3}>
        {topic.groups.map((group) => (
          <Grid key={group.id} size={{ xs: 12, sm: 6, md: 4 }}>
            <CategoryCard group={group} />
          </Grid>
        ))}
      </Grid>
    </Box>
  );
}

function CategoryCard({ group }) {
  return (
    <Card
      sx={{
        height: '100%',
        borderTop: 4,
        borderColor: group.color,
      }}
    >
      <CardContent>
        <Typography variant="h6" component="h3" gutterBottom>
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
  );
}
