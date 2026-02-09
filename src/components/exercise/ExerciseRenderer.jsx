import Typography from '@mui/material/Typography';
import exerciseRegistry from './registry.js';

export default function ExerciseRenderer({ exercise, answer, onAnswerChange, disabled }) {
  const Component = exerciseRegistry[exercise.type];

  if (!Component) {
    return (
      <Typography color="error">
        Loại bài tập không được hỗ trợ: {exercise.type}
      </Typography>
    );
  }

  return (
    <Component
      exercise={exercise}
      answer={answer}
      onAnswerChange={onAnswerChange}
      disabled={disabled}
    />
  );
}
