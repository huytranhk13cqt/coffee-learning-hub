import Typography from '@mui/material/Typography';
import TextField from '@mui/material/TextField';
import Box from '@mui/material/Box';

export default function FillBlank({
  exercise,
  answer,
  onAnswerChange,
  disabled,
}) {
  // Split content on ___ to render inline input
  const parts = (exercise.content || '').split('___');

  if (parts.length <= 1) {
    // No blank marker, just show a text field below
    return (
      <Box>
        {exercise.content && (
          <Typography variant="body1" sx={{ mb: 2, fontStyle: 'italic' }}>
            {exercise.content}
          </Typography>
        )}
        <TextField
          fullWidth
          size="small"
          placeholder="Nhập câu trả lời..."
          value={answer || ''}
          onChange={(e) => onAnswerChange(e.target.value)}
          disabled={disabled}
          autoComplete="off"
        />
      </Box>
    );
  }

  return (
    <Box
      sx={{ display: 'flex', alignItems: 'center', flexWrap: 'wrap', gap: 1 }}
    >
      <Typography component="span">{parts[0]}</Typography>
      <TextField
        size="small"
        sx={{ width: 180 }}
        placeholder="..."
        value={answer || ''}
        onChange={(e) => onAnswerChange(e.target.value)}
        disabled={disabled}
        autoComplete="off"
      />
      {parts[1] && <Typography component="span">{parts[1]}</Typography>}
    </Box>
  );
}
