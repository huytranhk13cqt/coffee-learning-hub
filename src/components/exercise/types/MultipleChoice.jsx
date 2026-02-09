import FormControl from '@mui/material/FormControl';
import RadioGroup from '@mui/material/RadioGroup';
import FormControlLabel from '@mui/material/FormControlLabel';
import Radio from '@mui/material/Radio';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';

export default function MultipleChoice({
  exercise,
  answer,
  onAnswerChange,
  disabled,
}) {
  const options = exercise.options || [];

  return (
    <Box>
      {exercise.content && (
        <Typography variant="body1" sx={{ mb: 2, fontStyle: 'italic' }}>
          {exercise.content}
        </Typography>
      )}
      <FormControl disabled={disabled}>
        <RadioGroup
          value={answer || ''}
          onChange={(e) => onAnswerChange(e.target.value)}
        >
          {options.map((opt) => (
            <FormControlLabel
              key={opt.label}
              value={opt.label}
              control={<Radio />}
              label={
                <Typography>
                  <strong>{opt.label}.</strong> {opt.content}
                </Typography>
              }
              sx={{ mb: 0.5 }}
            />
          ))}
        </RadioGroup>
      </FormControl>
    </Box>
  );
}
