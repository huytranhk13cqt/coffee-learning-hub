import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Tooltip from '@mui/material/Tooltip';
import CircularProgress from '@mui/material/CircularProgress';
import CheckCircleIcon from '@mui/icons-material/CheckCircle';

export default function DailyGoalProgress({
  completed = 0,
  target = 5,
  onClick,
}) {
  const progress = Math.min((completed / target) * 100, 100);
  const isDone = completed >= target;
  const isClickable = Boolean(onClick);

  return (
    <Tooltip
      title={
        isClickable
          ? `Mục tiêu hôm nay: ${completed}/${target} bài tập — Nhấn để đổi`
          : `Mục tiêu hôm nay: ${completed}/${target} bài tập`
      }
    >
      <Box
        onClick={onClick}
        role={isClickable ? 'button' : undefined}
        tabIndex={isClickable ? 0 : undefined}
        onKeyDown={
          isClickable ? (e) => e.key === 'Enter' && onClick(e) : undefined
        }
        sx={{
          display: 'flex',
          alignItems: 'center',
          gap: 0.5,
          cursor: isClickable ? 'pointer' : 'default',
          borderRadius: 1,
          px: isClickable ? 0.5 : 0,
          '&:hover': isClickable
            ? { bgcolor: 'action.hover', transition: 'background-color 0.2s' }
            : undefined,
        }}
        aria-label={`Hoàn thành ${completed} trên ${target} bài tập hôm nay${isClickable ? '. Nhấn để đổi mục tiêu' : ''}`}
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
