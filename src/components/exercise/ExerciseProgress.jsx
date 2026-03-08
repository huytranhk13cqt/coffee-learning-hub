import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import { PixelProgressBar } from '../pixel/index.js';
import { FONT } from '../../theme/pixelUtils.js';

export default function ExerciseProgress({ current, total }) {
  const progress = total > 0 ? ((current + 1) / total) * 100 : 0;

  return (
    <Box sx={{ mb: 3 }}>
      <Box
        sx={{ display: 'flex', justifyContent: 'space-between', mb: 0.5 }}
        aria-live="polite"
        aria-atomic="true"
      >
        <Typography
          variant="body2"
          color="text.secondary"
          sx={{ fontFamily: FONT.pixel, fontSize: '0.8rem' }}
        >
          Bài {current + 1} / {total}
        </Typography>
        <Typography
          variant="body2"
          color="text.secondary"
          sx={{ fontFamily: FONT.pixel, fontSize: '0.8rem' }}
        >
          {Math.round(progress)}%
        </Typography>
      </Box>
      <PixelProgressBar
        value={progress}
        segments={total > 0 ? Math.min(total, 20) : 10}
        color="primary.main"
        height={10}
        sx={{ width: '100%' }}
      />
    </Box>
  );
}
