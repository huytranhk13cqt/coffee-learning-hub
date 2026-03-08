import { Link as RouterLink } from 'react-router';
import Box from '@mui/material/Box';
import Grid from '@mui/material/Grid';
import Typography from '@mui/material/Typography';
import Link from '@mui/material/Link';
import Tooltip from '@mui/material/Tooltip';
import {
  BoltIcon,
  WhatshotIcon,
  FlagIcon,
  EmojiEventsIcon,
  EditIcon,
} from '../pixel/icons.jsx';
import { PixelFrame, PixelProgressBar } from '../pixel/index.js';
import { useGamification } from '../../hooks/useGamification.js';
import { ANIMATION } from '../../theme/pixelUtils.js';

export default function GamificationOverview({ stats }) {
  const { openDailyGoalDialog } = useGamification() ?? {};

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
          <PixelFrame
            variant="raised"
            sx={{ textAlign: 'center', p: 2, ...ANIMATION.stagger(0) }}
          >
            <BoltIcon
              sx={{
                fontSize: 32,
                color: 'warning.main',
                mb: 0.5,
                ...ANIMATION.float,
              }}
            />
            <Typography variant="h5" fontWeight={700}>
              Lv. {xp?.level ?? 1}
            </Typography>
            <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
              {xp?.total ?? 0} XP
            </Typography>
            <PixelProgressBar
              value={xpInLevel}
              segments={10}
              color="warning.main"
              height={8}
            />
            <Typography variant="caption" color="text.secondary">
              {xpInLevel}/100 đến level tiếp theo
            </Typography>
          </PixelFrame>
        </Grid>

        {/* Streak */}
        <Grid size={{ xs: 6, sm: 3 }}>
          <PixelFrame
            variant="raised"
            sx={{ textAlign: 'center', p: 2, ...ANIMATION.stagger(1) }}
          >
            <WhatshotIcon
              sx={{
                fontSize: 32,
                color: 'error.main',
                mb: 0.5,
                ...ANIMATION.pulse,
              }}
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
          </PixelFrame>
        </Grid>

        {/* Daily Goal — clickable to edit via context dialog */}
        <Grid size={{ xs: 6, sm: 3 }}>
          <Tooltip title="Nhấn để thay đổi mục tiêu">
            <PixelFrame
              variant="raised"
              onClick={openDailyGoalDialog}
              sx={{
                textAlign: 'center',
                p: 2,
                cursor: 'pointer',
                transition: 'border-color 0.2s',
                '&:hover': { borderColor: 'success.main' },
                ...ANIMATION.stagger(2),
              }}
            >
              <Box
                sx={{
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  gap: 0.5,
                  mb: 0.5,
                }}
              >
                <FlagIcon
                  sx={{
                    fontSize: 32,
                    color: 'success.main',
                    ...ANIMATION.float,
                  }}
                />
                <EditIcon sx={{ fontSize: 14, color: 'text.disabled' }} />
              </Box>
              <Typography variant="h5" fontWeight={700}>
                {dailyGoal?.completed ?? 0}/{dailyGoal?.target ?? 5}
              </Typography>
              <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
                Mục tiêu hôm nay
              </Typography>
              <PixelProgressBar
                value={goalProgress}
                segments={Math.max(dailyGoal?.target ?? 5, 5)}
                color="success.main"
                height={8}
              />
            </PixelFrame>
          </Tooltip>
        </Grid>

        {/* Achievements */}
        <Grid size={{ xs: 6, sm: 3 }}>
          <PixelFrame
            variant="raised"
            sx={{ textAlign: 'center', p: 2, ...ANIMATION.stagger(3) }}
          >
            <EmojiEventsIcon
              sx={{
                fontSize: 32,
                color: 'secondary.main',
                mb: 0.5,
                ...ANIMATION.bounce,
              }}
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
          </PixelFrame>
        </Grid>
      </Grid>
    </Box>
  );
}
