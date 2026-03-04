import Box from '@mui/material/Box';
import Alert from '@mui/material/Alert';
import AdminFormField from '../AdminFormField.jsx';

const INFO_TEXT = {
  error_correction: 'Enter the corrected sentence',
  sentence_transform: 'Enter the transformed sentence',
};

export default function SimpleAnswerEditor({ form, setForm, errors }) {
  return (
    <Box>
      <Alert severity="info" sx={{ mb: 2 }}>
        {INFO_TEXT[form.type] || 'Enter the correct answer'}
      </Alert>

      <AdminFormField
        label="Correct Answer"
        value={form.correct_answer}
        onChange={(e) =>
          setForm((prev) => ({ ...prev, correct_answer: e.target.value }))
        }
        error={!!errors.correct_answer}
        helperText={errors.correct_answer}
        multiline
        rows={3}
      />
    </Box>
  );
}
