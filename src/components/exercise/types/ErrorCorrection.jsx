import Typography from '@mui/material/Typography';
import TextField from '@mui/material/TextField';
import Paper from '@mui/material/Paper';
import Box from '@mui/material/Box';

export default function ErrorCorrection({ exercise, answer, onAnswerChange, disabled }) {
  return (
    <Box>
      <Paper
        variant="outlined"
        sx={{ p: 2, mb: 2, bgcolor: 'error.50', borderColor: 'error.200' }}
      >
        <Typography
          variant="body1"
          sx={{ fontStyle: 'italic', color: 'error.dark' }}
        >
          {exercise.content}
        </Typography>
      </Paper>
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
