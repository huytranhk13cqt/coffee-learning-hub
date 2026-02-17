import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Tooltip from '@mui/material/Tooltip';
import CircularProgress from '@mui/material/CircularProgress';
import CheckCircleIcon from '@mui/icons-material/CheckCircle';

export default function DailyGoalProgress({ completed = 0, target = 5 }) {
  const progress = Math.min((completed / target) * 100, 100);
  const isDone = completed >= target;

  return (
    <Tooltip title={`Mục tiêu hôm nay: ${completed}/${target} bài tập`}>
      <Box
        sx={{
          display: 'flex',
          alignItems: 'center',
          gap: 0.5,
          cursor: 'default',
        }}
        aria-label={`Hoàn thành ${completed} trên ${target} bài tập hôm nay`}
      >
        {isDone ? (
          <CheckCircleIcon
            sx={{ fontSize: 20, color: 'success.main' }}
            aria-hidden="true"
          />
        ) : (
          <Box sx={{ position: 'relative', display: 'inline-flex' }}>
            <CircularProgress
              variant="determinate"
              value={progress}
              size={20}
              thickness={5}
              sx={{ color: 'success.main' }}
            />
          </Box>
        )}
        <Typography variant="body2" fontWeight={700} color="inherit">
          {completed}/{target}
        </Typography>
      </Box>
    </Tooltip>
  );
}
