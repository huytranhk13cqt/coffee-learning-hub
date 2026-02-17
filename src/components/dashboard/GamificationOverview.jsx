import { Link as RouterLink } from 'react-router';
import Box from '@mui/material/Box';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Grid from '@mui/material/Grid';
import Typography from '@mui/material/Typography';
import LinearProgress from '@mui/material/LinearProgress';
import Link from '@mui/material/Link';
import BoltIcon from '@mui/icons-material/Bolt';
import WhatshotIcon from '@mui/icons-material/Whatshot';
import FlagIcon from '@mui/icons-material/Flag';
import EmojiEventsIcon from '@mui/icons-material/EmojiEvents';

export default function GamificationOverview({ stats }) {
  if (!stats) return null;

  const { xp, streak, dailyGoal, achievementsEarned } = stats;
  const xpInLevel = (xp?.total ?? 0) % 100;
  const goalProgress =
    dailyGoal?.target > 0
      ? Math.min(
          100,
          Math.round(((dailyGoal.completed ?? 0) / dailyGoal.target) * 100),
        )
      : 0;

  return (
    <Box sx={{ mb: 4 }}>
      <Typography variant="h6" component="h2" gutterBottom>
        Thành tích cá nhân
      </Typography>
      <Grid container spacing={2}>
        {/* Level & XP */}
        <Grid size={{ xs: 6, sm: 3 }}>
          <Card variant="outlined">
            <CardContent sx={{ textAlign: 'center', py: 2 }}>
              <BoltIcon sx={{ fontSize: 32, color: 'warning.main', mb: 0.5 }} />
              <Typography variant="h5" fontWeight={700}>
                Lv. {xp?.level ?? 1}
              </Typography>
              <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
                {xp?.total ?? 0} XP
              </Typography>
              <LinearProgress
                variant="determinate"
                value={xpInLevel}
                color="warning"
                sx={{ height: 6, borderRadius: 3 }}
              />
              <Typography variant="caption" color="text.secondary">
                {xpInLevel}/100 đến level tiếp theo
              </Typography>
            </CardContent>
          </Card>
        </Grid>

        {/* Streak */}
        <Grid size={{ xs: 6, sm: 3 }}>
          <Card variant="outlined">
            <CardContent sx={{ textAlign: 'center', py: 2 }}>
              <WhatshotIcon
                sx={{ fontSize: 32, color: 'error.main', mb: 0.5 }}
              />
              <Typography variant="h5" fontWeight={700}>
                {streak?.current ?? 0}
              </Typography>
              <Typography variant="body2" color="text.secondary">
                Chuỗi ngày
              </Typography>
              <Typography variant="caption" color="text.secondary">
                Dài nhất: {streak?.longest ?? 0} ngày
              </Typography>
            </CardContent>
          </Card>
        </Grid>

        {/* Daily Goal */}
        <Grid size={{ xs: 6, sm: 3 }}>
          <Card variant="outlined">
            <CardContent sx={{ textAlign: 'center', py: 2 }}>
              <FlagIcon sx={{ fontSize: 32, color: 'success.main', mb: 0.5 }} />
              <Typography variant="h5" fontWeight={700}>
                {dailyGoal?.completed ?? 0}/{dailyGoal?.target ?? 5}
              </Typography>
              <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
                Mục tiêu hôm nay
              </Typography>
              <LinearProgress
                variant="determinate"
                value={goalProgress}
                color="success"
                sx={{ height: 6, borderRadius: 3 }}
              />
            </CardContent>
          </Card>
        </Grid>

        {/* Achievements */}
        <Grid size={{ xs: 6, sm: 3 }}>
          <Card variant="outlined">
            <CardContent sx={{ textAlign: 'center', py: 2 }}>
              <EmojiEventsIcon
                sx={{ fontSize: 32, color: 'secondary.main', mb: 0.5 }}
              />
              <Typography variant="h5" fontWeight={700}>
                {achievementsEarned ?? 0}
              </Typography>
              <Typography variant="body2" color="text.secondary">
                Thành tựu đạt được
              </Typography>
              <Link
                component={RouterLink}
                to="/achievements"
                variant="caption"
                underline="hover"
              >
                Xem tất cả
              </Link>
            </CardContent>
          </Card>
        </Grid>
      </Grid>
    </Box>
  );
}
