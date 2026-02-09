import Box from '@mui/material/Box';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import LinearProgress from '@mui/material/LinearProgress';
import Stack from '@mui/material/Stack';
import CheckCircleIcon from '@mui/icons-material/CheckCircle';
import RadioButtonUncheckedIcon from '@mui/icons-material/RadioButtonUnchecked';
import ScoreBadge from './ScoreBadge.jsx';

export default function LessonProgressSummary({ progress }) {
  if (!progress) return null;

  const exercisePercent =
    progress.exercises_total > 0
      ? Math.round(
          (progress.exercises_attempted / progress.exercises_total) * 100,
        )
      : 0;

  return (
    <Paper variant="outlined" sx={{ p: 2.5 }}>
      <Typography variant="subtitle1" fontWeight={600} gutterBottom>
        Tiến trình học
      </Typography>

      <Stack spacing={1.5}>
        {/* Theory status */}
        <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
          {progress.theory_completed ? (
            <CheckCircleIcon color="success" fontSize="small" />
          ) : (
            <RadioButtonUncheckedIcon color="disabled" fontSize="small" />
          )}
          <Typography variant="body2">
            {progress.theory_completed
              ? 'Đã đọc lý thuyết'
              : 'Chưa đọc lý thuyết'}
          </Typography>
        </Box>

        {/* Exercise progress */}
        {progress.exercises_total > 0 && (
          <Box>
            <Box
              sx={{ display: 'flex', justifyContent: 'space-between', mb: 0.5 }}
            >
              <Typography variant="body2" color="text.secondary">
                Bài tập: {progress.exercises_attempted}/
                {progress.exercises_total}
              </Typography>
              <Typography variant="body2" color="text.secondary">
                {exercisePercent}%
              </Typography>
            </Box>
            <LinearProgress
              variant="determinate"
              value={exercisePercent}
              sx={{ height: 6, borderRadius: 3 }}
            />
          </Box>
        )}

        {/* Scores */}
        <Stack direction="row" spacing={2}>
          <ScoreBadge score={progress.current_score} label="Điểm hiện tại" />
          <ScoreBadge score={progress.best_score} label="Điểm cao nhất" />
        </Stack>
      </Stack>
    </Paper>
  );
}
