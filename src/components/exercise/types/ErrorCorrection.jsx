import Typography from '@mui/material/Typography';
import TextField from '@mui/material/TextField';
import { PixelFrame } from '../../pixel/index.js';
import Box from '@mui/material/Box';

export default function ErrorCorrection({
  exercise,
  answer,
  onAnswerChange,
  disabled,
}) {
  return (
    <Box>
      <PixelFrame
        variant="inset"
        role="region"
        aria-label="Câu có lỗi cần sửa"
        sx={{ p: 2, mb: 2, bgcolor: 'error.50', borderColor: 'error.200' }}
      >
        <Typography
          variant="body1"
          sx={{ fontStyle: 'italic', color: 'error.dark' }}
        >
          {exercise.content}
        </Typography>
      </PixelFrame>
      <TextField
        fullWidth
        size="small"
        label="Câu đã sửa"
        placeholder="Viết lại câu đúng..."
        value={answer || ''}
        onChange={(e) => onAnswerChange(e.target.value)}
        disabled={disabled}
        autoComplete="off"
      />
    </Box>
  );
}
