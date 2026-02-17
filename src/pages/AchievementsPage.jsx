import { useLoaderData, Link as RouterLink } from 'react-router';
import { fetchAchievements } from '../api/gamification.js';
import { useDocumentTitle } from '../hooks/useDocumentTitle.js';
import Typography from '@mui/material/Typography';
import Grid from '@mui/material/Grid';
import Box from '@mui/material/Box';
import Chip from '@mui/material/Chip';
import Breadcrumbs from '@mui/material/Breadcrumbs';
import Link from '@mui/material/Link';
import Fade from '@mui/material/Fade';
import AchievementCard from '../components/gamification/AchievementCard.jsx';

export async function loader({ request }) {
  return fetchAchievements({ signal: request.signal });
}

const CATEGORY_LABELS = {
  milestone: 'Cột mốc',
  streak: 'Chuỗi ngày',
  xp: 'Kinh nghiệm',
  lesson: 'Bài học',
  mastery: 'Thành thạo',
  explorer: 'Khám phá',
};

function groupByCategory(achievements) {
  const groups = Object.create(null);
  for (const a of achievements) {
    const cat = a.category;
    (groups[cat] ||= []).push(a);
  }
  return groups;
}

export default function AchievementsPage() {
  const achievements = useLoaderData();
  useDocumentTitle('Thành tựu');

  const grouped = groupByCategory(achievements);
  const categories = Object.keys(grouped);
  const earnedCount = achievements.filter((a) => a.earned).length;

  return (
    <Fade in timeout={300}>
      <div>
        <Breadcrumbs sx={{ mb: 2 }}>
          <Link component={RouterLink} to="/" underline="hover" color="inherit">
            Trang chủ
          </Link>
          <Typography color="text.primary">Thành tựu</Typography>
        </Breadcrumbs>

        <Box
          sx={{
            display: 'flex',
            alignItems: 'baseline',
            gap: 2,
            mb: 3,
          }}
        >
          <Typography variant="h4" component="h1">
            Thành tựu
          </Typography>
          <Chip
            label={`${earnedCount}/${achievements.length}`}
            color="primary"
            size="small"
          />
        </Box>

        {categories.map((category) => (
          <Box key={category} sx={{ mb: 4 }}>
            <Typography
              variant="h6"
              component="h2"
              gutterBottom
              color="text.secondary"
            >
              {CATEGORY_LABELS[category] ?? category}
            </Typography>
            <Grid container spacing={2}>
              {grouped[category].map((achievement) => (
                <Grid key={achievement.id} size={{ xs: 12, sm: 6, md: 4 }}>
                  <AchievementCard achievement={achievement} />
                </Grid>
              ))}
            </Grid>
          </Box>
        ))}
      </div>
    </Fade>
  );
}
