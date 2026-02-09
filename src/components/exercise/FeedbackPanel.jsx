import Alert from '@mui/material/Alert';
import AlertTitle from '@mui/material/AlertTitle';
import Typography from '@mui/material/Typography';

export default function FeedbackPanel({ feedback }) {
  if (!feedback) return null;

  const { isCorrect, explanation, explanationVi } = feedback;

  return (
    <Alert
      severity={isCorrect ? 'success' : 'error'}
      sx={{ mt: 2 }}
    >
      <AlertTitle>{isCorrect ? 'Chính xác!' : 'Chưa đúng'}</AlertTitle>
      {explanationVi && (
        <Typography variant="body2" sx={{ mb: 0.5 }}>
          {explanationVi}
        </Typography>
      )}
      {explanation && (
        <Typography variant="body2" color="text.secondary">
          {explanation}
        </Typography>
      )}
    </Alert>
  );
}
