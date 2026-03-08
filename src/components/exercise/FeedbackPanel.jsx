import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import { PixelFrame } from '../pixel/index.js';
import { CheckCircleIcon, CancelIcon } from '../pixel/icons.jsx';
import { FONT } from '../../theme/pixelUtils.js';

export default function FeedbackPanel({ feedback }) {
  if (!feedback) return null;

  const { isCorrect, explanation, explanationVi } = feedback;

  return (
    <PixelFrame
      variant="raised"
      sx={{
        mt: 2,
        p: 2,
        borderColor: isCorrect ? 'success.main' : 'error.main',
        borderWidth: 2,
      }}
    >
      <Box
        role="status"
        sx={{ display: 'flex', alignItems: 'flex-start', gap: 1.5 }}
      >
        {isCorrect ? (
          <CheckCircleIcon
            sx={{ color: 'success.main', fontSize: 28, mt: 0.25 }}
          />
        ) : (
          <CancelIcon sx={{ color: 'error.main', fontSize: 28, mt: 0.25 }} />
        )}
        <Box sx={{ flex: 1 }}>
          <Typography
            variant="subtitle1"
            sx={{
              fontFamily: FONT.pixel,
              color: isCorrect ? 'success.main' : 'error.main',
              mb: 0.5,
            }}
          >
            {isCorrect ? 'Chính xác!' : 'Chưa đúng'}
          </Typography>
          {explanationVi && (
            <Typography variant="body2" sx={{ mb: 0.5 }}>
              {explanationVi}
            </Typography>
          )}
          {explanation && (
            <Typography variant="body2" color="text.secondary">
              {explanation}
            </Typography>
          )}
        </Box>
      </Box>
    </PixelFrame>
  );
}
