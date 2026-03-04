import Box from '@mui/material/Box';
import Alert from '@mui/material/Alert';
import AdminFormField from '../AdminFormField.jsx';

export default function CodeOutputEditor({ form, setForm, errors }) {
  return (
    <Box>
      <Alert severity="info" sx={{ mb: 2 }}>
        Enter the exact expected output (case-sensitive)
      </Alert>

      <AdminFormField
        label="Expected Output"
        value={form.correct_answer}
        onChange={(e) =>
          setForm((prev) => ({ ...prev, correct_answer: e.target.value }))
        }
        error={!!errors.correct_answer}
        helperText={errors.correct_answer}
        multiline
        rows={3}
        sx={{ mb: 0, '& .MuiInputBase-input': { fontFamily: 'monospace' } }}
      />
    </Box>
  );
}
