import { useRef, useEffect } from 'react';
import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import Typography from '@mui/material/Typography';
import Chip from '@mui/material/Chip';
import Alert from '@mui/material/Alert';
import AlertTitle from '@mui/material/AlertTitle';
import Paper from '@mui/material/Paper';
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
  const feedbackRef = useRef(null);
  const isSubmitting = phase === 'submitting';
  const isFeedback = phase === 'feedback';
  const disabled = isSubmitting || isFeedback;

  // Auto-scroll to feedback when it appears
  useEffect(() => {
    if (feedback && feedbackRef.current) {
      feedbackRef.current.scrollIntoView({
        behavior: 'smooth',
        block: 'nearest',
      });
    }
  }, [feedback]);

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

      {/* Context (reading passage, code snippet, etc.) */}
      {exercise.context && (
        <Paper variant="outlined" sx={{ p: 2, mb: 2, bgcolor: 'grey.50' }}>
          <Typography variant="body1" sx={{ whiteSpace: 'pre-wrap' }}>
            {exercise.context}
          </Typography>
          {exercise.context_vi && (
            <Typography
              variant="body2"
              color="text.secondary"
              sx={{ mt: 1, whiteSpace: 'pre-wrap' }}
            >
              {exercise.context_vi}
            </Typography>
          )}
        </Paper>
      )}

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
      <div ref={feedbackRef}>
        <FeedbackPanel feedback={feedback} />
      </div>

      {/* Error with retry */}
      {error && (
        <Alert severity="error" sx={{ mt: 2 }}>
          <AlertTitle>Không thể gửi câu trả lời</AlertTitle>
          Vui lòng kiểm tra kết nối mạng và thử lại.
          <Box sx={{ mt: 1 }}>
            <Button
              size="small"
              color="error"
              variant="outlined"
              onClick={onSubmit}
            >
              Thử lại
            </Button>
          </Box>
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
