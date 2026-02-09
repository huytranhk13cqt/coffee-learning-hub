import Typography from '@mui/material/Typography';
import ToggleButton from '@mui/material/ToggleButton';
import ToggleButtonGroup from '@mui/material/ToggleButtonGroup';
import Paper from '@mui/material/Paper';
import Box from '@mui/material/Box';

export default function TrueFalse({ exercise, answer, onAnswerChange, disabled }) {
  return (
    <Box>
      <Paper variant="outlined" sx={{ p: 2, mb: 2 }}>
        <Typography variant="body1" sx={{ fontStyle: 'italic' }}>
          {exercise.content}
        </Typography>
        {exercise.content_vi && (
          <Typography variant="body2" color="text.secondary" sx={{ mt: 0.5 }}>
            {exercise.content_vi}
          </Typography>
        )}
      </Paper>
      <ToggleButtonGroup
        exclusive
        value={answer || ''}
        onChange={(_, val) => { if (val !== null) onAnswerChange(val); }}
        disabled={disabled}
        color="primary"
      >
        <ToggleButton value="true" sx={{ px: 4 }}>
          True
        </ToggleButton>
        <ToggleButton value="false" sx={{ px: 4 }}>
          False
        </ToggleButton>
      </ToggleButtonGroup>
    </Box>
  );
}
