import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import Typography from '@mui/material/Typography';
import Chip from '@mui/material/Chip';
import Alert from '@mui/material/Alert';
import Stack from '@mui/material/Stack';
import ExerciseProgress from './ExerciseProgress.jsx';
import ExerciseRenderer from './ExerciseRenderer.jsx';
import FeedbackPanel from './FeedbackPanel.jsx';
import {
  EXERCISE_DIFFICULTY_LABELS,
  EXERCISE_DIFFICULTY_COLORS,
} from '../../constants/difficulty.js';

export default function ExerciseWrapper({
  exercise,
  currentIndex,
  totalExercises,
  answer,
  onAnswerChange,
  showHint,
  onShowHint,
  feedback,
  error,
  phase,
  onSubmit,
  onNext,
}) {
  const isSubmitting = phase === 'submitting';
  const isFeedback = phase === 'feedback';
  const disabled = isSubmitting || isFeedback;

  return (
    <Box>
      <ExerciseProgress current={currentIndex} total={totalExercises} />

      {/* Header: type + difficulty chips */}
      <Stack direction="row" spacing={1} sx={{ mb: 2 }}>
        <Chip
          label={exercise.type.replace('_', ' ')}
          size="small"
          variant="outlined"
        />
        <Chip
          label={
            EXERCISE_DIFFICULTY_LABELS[exercise.difficulty] ||
            exercise.difficulty
          }
          size="small"
          color={EXERCISE_DIFFICULTY_COLORS[exercise.difficulty] || 'default'}
        />
        {exercise.points && (
          <Chip
            label={`${exercise.points} điểm`}
            size="small"
            variant="outlined"
          />
        )}
      </Stack>

      {/* Question */}
      <Typography variant="h6" sx={{ mb: 1 }}>
        {exercise.question}
      </Typography>
      {exercise.question_vi && (
        <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
          {exercise.question_vi}
        </Typography>
      )}

      {/* Exercise type component */}
      <ExerciseRenderer
        key={exercise.id}
        exercise={exercise}
        answer={answer}
        onAnswerChange={onAnswerChange}
        disabled={disabled}
      />

      {/* Hint */}
      {exercise.hint && !showHint && !isFeedback && (
        <Button size="small" sx={{ mt: 1 }} onClick={onShowHint}>
          Xem gợi ý
        </Button>
      )}
      {showHint && exercise.hint && (
        <Alert severity="info" sx={{ mt: 1 }}>
          {exercise.hint_vi || exercise.hint}
        </Alert>
      )}

      {/* Feedback */}
      <FeedbackPanel feedback={feedback} />

      {/* Error */}
      {error && (
        <Alert severity="error" sx={{ mt: 2 }}>
          {error}
        </Alert>
      )}

      {/* Action buttons */}
      <Box sx={{ mt: 3, display: 'flex', gap: 2 }}>
        {!isFeedback ? (
          <Button
            variant="contained"
            onClick={onSubmit}
            disabled={answer === null || answer === '' || isSubmitting}
            loading={isSubmitting}
          >
            {isSubmitting ? 'Đang kiểm tra...' : 'Kiểm tra'}
          </Button>
        ) : (
          <Button variant="contained" onClick={onNext}>
            {currentIndex < totalExercises - 1
              ? 'Câu tiếp theo'
              : 'Xem kết quả'}
          </Button>
        )}
      </Box>
    </Box>
  );
}
