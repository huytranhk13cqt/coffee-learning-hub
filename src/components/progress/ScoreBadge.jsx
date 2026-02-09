import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';

function getScoreColor(score) {
  if (score >= 80) return 'success.main';
  if (score >= 60) return 'warning.main';
  return 'error.main';
}

export default function ScoreBadge({
  score,
  label = 'Điểm',
  variant = 'body2',
}) {
  if (score == null || score <= 0) return null;

  return (
    <Box sx={{ display: 'inline-flex', alignItems: 'center', gap: 0.5 }}>
      <Typography variant={variant} color="text.secondary">
        {label}:
      </Typography>
      <Typography
        variant={variant}
        fontWeight={600}
        color={getScoreColor(score)}
      >
        {Math.round(score)}%
      </Typography>
    </Box>
  );
}
