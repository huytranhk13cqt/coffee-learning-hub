import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Alert from '@mui/material/Alert';
import AdminFormField from '../AdminFormField.jsx';

export default function FillBlankEditor({ form, setForm, errors }) {
  const hasPlaceholder = form.content.includes('___');

  return (
    <Box>
      <Alert severity="info" sx={{ mb: 2 }}>
        The &quot;Content&quot; field above should contain &quot;___&quot; as
        the blank placeholder.
      </Alert>

      {!hasPlaceholder && form.content && (
        <Alert severity="warning" sx={{ mb: 2 }}>
          Content does not contain &quot;___&quot; placeholder yet.
        </Alert>
      )}

      <AdminFormField
        label="Correct Answer"
        value={form.correct_answer}
        onChange={(e) =>
          setForm((prev) => ({ ...prev, correct_answer: e.target.value }))
        }
        error={!!errors.correct_answer}
        helperText={errors.correct_answer}
      />

      {hasPlaceholder && form.correct_answer && (
        <Typography variant="body2" color="text.secondary">
          Preview: {form.content.replace('___', form.correct_answer)}
        </Typography>
      )}
    </Box>
  );
}
