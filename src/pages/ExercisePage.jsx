import { useEffect } from 'react';
import {
  useLoaderData,
  useNavigate,
  useLocation,
  useBlocker,
  Link as RouterLink,
} from 'react-router';
import { fetchExercises } from '../api/exercises.js';
import { useDocumentTitle } from '../hooks/useDocumentTitle.js';
import { useExerciseFlow } from '../hooks/useExerciseFlow.js';
import ExerciseWrapper from '../components/exercise/ExerciseWrapper.jsx';
import LeaveExerciseDialog from '../components/exercise/LeaveExerciseDialog.jsx';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import Paper from '@mui/material/Paper';
import Breadcrumbs from '@mui/material/Breadcrumbs';
import Link from '@mui/material/Link';
import Stack from '@mui/material/Stack';
import Fade from '@mui/material/Fade';
import CheckCircleOutlineIcon from '@mui/icons-material/CheckCircleOutline';

export async function loader({ params, request }) {
  const exercises = await fetchExercises(params.lessonId, {
    signal: request.signal,
  });
  return { exercises, lessonId: params.lessonId };
}

export default function ExercisePage() {
  const { exercises, lessonId } = useLoaderData();
  const navigate = useNavigate();
  const location = useLocation();
  const lessonName = location.state?.lessonName;
  useDocumentTitle(lessonName ? `Bài tập — ${lessonName}` : 'Bài tập');

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
    loadExercises,
    setAnswer,
    showHint,
    submit,
    next,
  } = useExerciseFlow();

  const blocker = useBlocker(
    phase === 'answering' || phase === 'submitting' || phase === 'feedback',
  );

  useEffect(() => {
    if (exercises.length > 0) {
      loadExercises(exercises);
    }
  }, [exercises, loadExercises]);

  // Empty state — lesson has no exercises yet
  if (exercises.length === 0) {
    return (
      <Fade in timeout={300}>
        <Box sx={{ textAlign: 'center', py: 6 }}>
          <Typography variant="h5" component="h1" gutterBottom>
            Chưa có bài tập
          </Typography>
          <Typography color="text.secondary" sx={{ mb: 3 }}>
            Bài học này chưa có bài tập. Vui lòng quay lại sau.
          </Typography>
          <Button variant="contained" component={RouterLink} to="/">
            Về trang chủ
          </Button>
        </Box>
      </Fade>
    );
  }

  // Finished state
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
            Hoàn thành!
          </Typography>
          <Typography variant="body1" color="text.secondary" gutterBottom>
            Bạn đã trả lời đúng {correctCount}/{totalExercises} câu ({score}%)
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
            <Button
              variant="outlined"
              component={RouterLink}
              to={`/lessons/${lessonId}/results`}
            >
              Xem chi tiết
            </Button>
            <Button variant="contained" onClick={() => navigate(-1)}>
              Quay lại bài học
            </Button>
          </Stack>
        </Box>
      </Fade>
    );
  }

  // Loading / idle
  if (phase === 'idle' || !currentExercise) {
    return <Typography color="text.secondary">Đang tải bài tập...</Typography>;
  }

  // Exercise in progress
  return (
    <Fade in timeout={300}>
      <Box>
        <Breadcrumbs sx={{ mb: 3 }}>
          <Link component={RouterLink} to="/" underline="hover" color="inherit">
            Trang chủ
          </Link>
          {lessonName && (
            <Typography color="text.secondary">{lessonName}</Typography>
          )}
          <Typography color="text.primary">Bài tập</Typography>
        </Breadcrumbs>

        <Typography
          variant="h5"
          component="h1"
          sx={{
            position: 'absolute',
            width: 1,
            height: 1,
            overflow: 'hidden',
            clip: 'rect(0,0,0,0)',
          }}
        >
          {lessonName ? `Bài tập — ${lessonName}` : 'Bài tập'}
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
      </Box>
    </Fade>
  );
}
