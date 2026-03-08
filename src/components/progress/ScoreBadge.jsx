import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import { FONT } from '../../theme/pixelUtils.js';

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
    <Box
      sx={{
        display: 'inline-flex',
        alignItems: 'center',
        gap: 0.5,
        border: '2px solid',
        borderColor: 'divider',
        px: 1,
        py: 0.25,
      }}
    >
      {label && (
        <Typography variant={variant} color="text.secondary">
          {label}:
        </Typography>
      )}
      <Typography
        variant={variant}
        color={getScoreColor(score)}
        sx={{ fontFamily: FONT.pixel, fontSize: '0.8rem' }}
      >
        {Math.round(score)}%
      </Typography>
    </Box>
  );
}
