import Typography from '@mui/material/Typography';
import TextField from '@mui/material/TextField';
import { PixelFrame } from '../../pixel/index.js';
import Box from '@mui/material/Box';

export default function SentenceTransform({
  exercise,
  answer,
  onAnswerChange,
  disabled,
}) {
  return (
    <Box>
      <PixelFrame variant="inset" sx={{ p: 2, mb: 2 }}>
        <Typography variant="body1" sx={{ fontStyle: 'italic' }}>
          {exercise.content}
        </Typography>
        {exercise.content_vi && (
          <Typography variant="body2" color="text.secondary" sx={{ mt: 0.5 }}>
            {exercise.content_vi}
          </Typography>
        )}
      </PixelFrame>
      <TextField
        fullWidth
        size="small"
        label="Câu đã chuyển đổi"
        placeholder="Viết câu mới..."
        value={answer || ''}
        onChange={(e) => onAnswerChange(e.target.value)}
        disabled={disabled}
        autoComplete="off"
      />
    </Box>
  );
}
