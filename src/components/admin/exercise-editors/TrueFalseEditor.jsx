import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import FormControl from '@mui/material/FormControl';
import RadioGroup from '@mui/material/RadioGroup';
import FormControlLabel from '@mui/material/FormControlLabel';
import Radio from '@mui/material/Radio';

export default function TrueFalseEditor({ form, setForm, errors }) {
  return (
    <Box>
      <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
        Is the statement in &quot;Content&quot; correct?
      </Typography>

      <FormControl error={!!errors.correct_answer}>
        <RadioGroup
          value={form.correct_answer}
          onChange={(e) =>
            setForm((prev) => ({ ...prev, correct_answer: e.target.value }))
          }
        >
          <FormControlLabel
            value="true"
            control={<Radio />}
            label="True (Statement is correct)"
          />
          <FormControlLabel
            value="false"
            control={<Radio />}
            label="False (Statement is incorrect)"
          />
        </RadioGroup>
      </FormControl>

      {errors.correct_answer && (
        <Typography
          color="error"
          variant="caption"
          sx={{ display: 'block', mt: 1 }}
        >
          {errors.correct_answer}
        </Typography>
      )}
    </Box>
  );
}
