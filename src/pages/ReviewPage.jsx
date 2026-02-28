import { useEffect } from 'react';
import { useLoaderData, Link as RouterLink, useBlocker } from 'react-router';
import { fetchDueReviews, submitReview } from '../api/review.js';
import { useExerciseFlow } from '../hooks/useExerciseFlow.js';
import { useGamification } from '../hooks/useGamification.js';
import { useDocumentTitle } from '../hooks/useDocumentTitle.js';
import ExerciseWrapper from '../components/exercise/ExerciseWrapper.jsx';
import LeaveExerciseDialog from '../components/exercise/LeaveExerciseDialog.jsx';
import AchievementToast from '../components/gamification/AchievementToast.jsx';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import Chip from '@mui/material/Chip';
import Paper from '@mui/material/Paper';
import Stack from '@mui/material/Stack';
import Fade from '@mui/material/Fade';
import CheckCircleOutlineIcon from '@mui/icons-material/CheckCircleOutline';
import AutorenewIcon from '@mui/icons-material/Autorenew';
import EmojiEmotionsIcon from '@mui/icons-material/EmojiEmotions';

export async function loader({ request }) {
  return fetchDueReviews({ signal: request.signal });
}

export default function ReviewPage() {
  const { exercises, stats } = useLoaderData();
  useDocumentTitle('Ôn tập hôm nay');

  const gamification = useGamification();

  const {
    phase,
    currentExercise,
    currentIndex,
    totalExercises,
    currentAnswer,
    isHintVisible: hintVisible,
    feedback,
    results,
    error,
    newAchievements,
    loadExercises,
    setAnswer,
    showHint,
    submit,
    next,
  } = useExerciseFlow({
    onGamificationUpdate: gamification?.updateFromSubmit,
    submitFn: submitReview,
  });

  const blocker = useBlocker(
    phase === 'answering' || phase === 'submitting' || phase === 'feedback',
  );

  useEffect(() => {
    if (exercises.length > 0) {
      loadExercises(exercises);
    }
  }, [exercises, loadExercises]);

  // Empty state — no reviews due today
  if (exercises.length === 0) {
    return (
      <Fade in timeout={300}>
        <Box sx={{ textAlign: 'center', py: 8 }}>
          <EmojiEmotionsIcon
            sx={{ fontSize: 72, color: 'warning.main', mb: 2 }}
          />
          <Typography variant="h5" component="h1" gutterBottom>
            Không có bài ôn tập 🎉
          </Typography>
          <Typography
            color="text.secondary"
            sx={{ mb: 4, maxWidth: 400, mx: 'auto' }}
          >
            Bạn đã hoàn thành tất cả bài ôn cho hôm nay! Quay lại vào ngày mai.
          </Typography>
          <Button variant="contained" component={RouterLink} to="/">
            Về trang chủ
          </Button>
        </Box>
      </Fade>
    );
  }

  // Finished state — all reviews completed
  if (phase === 'finished') {
    const correctCount = results.filter((r) => r.isCorrect).length;
    const score =
      totalExercises > 0
        ? Math.round((correctCount / totalExercises) * 100)
        : 0;

    return (
      <Fade in timeout={300}>
        <Box sx={{ textAlign: 'center', py: 4 }}>
          <CheckCircleOutlineIcon
            sx={{ fontSize: 64, color: 'success.main', mb: 2 }}
          />
          <Typography variant="h4" component="h1" gutterBottom>
            Hoàn thành ôn tập!
          </Typography>
          <Typography variant="body1" color="text.secondary" gutterBottom>
            Bạn đã trả lời đúng {correctCount}/{totalExercises} câu ({score}%)
          </Typography>
          <Typography
            variant="body2"
            color="text.secondary"
            sx={{ mt: 1, mb: 3 }}
          >
            Hẹn gặp lại ngày mai 👋
          </Typography>

          <Paper
            variant="outlined"
            sx={{ p: 2, my: 3, maxWidth: 400, mx: 'auto' }}
          >
            <Stack spacing={1}>
              {results.map((r, i) => (
                <Box
                  key={r.exerciseId}
                  sx={{ display: 'flex', justifyContent: 'space-between' }}
                >
                  <Typography variant="body2">Câu {i + 1}</Typography>
                  <Typography
                    variant="body2"
                    color={r.isCorrect ? 'success.main' : 'error.main'}
                    fontWeight={600}
                  >
                    {r.isCorrect ? '✓ Đúng' : '✗ Sai'}
                  </Typography>
                </Box>
              ))}
            </Stack>
          </Paper>

          <Stack direction="row" spacing={2} justifyContent="center">
            <Button variant="outlined" component={RouterLink} to="/">
              Về trang chủ
            </Button>
            <Button variant="contained" component={RouterLink} to="/paths">
              Xem Learning Paths
            </Button>
          </Stack>
        </Box>
      </Fade>
    );
  }

  // Loading / idle state
  if (phase === 'idle' || !currentExercise) {
    return (
      <Typography color="text.secondary">Đang tải bài ôn tập...</Typography>
    );
  }

  // Exercise in progress
  return (
    <Fade in timeout={300}>
      <Box>
        <Box sx={{ mb: 3, display: 'flex', alignItems: 'center', gap: 2 }}>
          <AutorenewIcon color="primary" />
          <Typography variant="h5" component="h1">
            Ôn tập hôm nay
          </Typography>
          <Chip
            label={`${stats?.due_today ?? totalExercises} bài cần ôn`}
            color="primary"
            size="small"
            variant="outlined"
          />
        </Box>
        <Typography
          variant="body2"
          color="text.secondary"
          sx={{ mb: 3, mt: -1 }}
        >
          Ôn tập giúp ghi nhớ lâu hơn
        </Typography>

        <ExerciseWrapper
          exercise={currentExercise}
          currentIndex={currentIndex}
          totalExercises={totalExercises}
          answer={currentAnswer}
          onAnswerChange={setAnswer}
          showHint={hintVisible}
          onShowHint={showHint}
          feedback={feedback}
          error={error}
          phase={phase}
          onSubmit={submit}
          onNext={next}
        />

        <LeaveExerciseDialog blocker={blocker} />
        <AchievementToast achievements={newAchievements} />
      </Box>
    </Fade>
  );
}
