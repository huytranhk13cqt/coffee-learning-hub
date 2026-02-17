import { useState, useEffect } from 'react';
import { useLoaderData, Link as RouterLink, useNavigate } from 'react-router';
import { fetchLesson } from '../api/lessons.js';
import {
  fetchProgress,
  markTheoryComplete,
  resetProgress,
} from '../api/progress.js';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import Chip from '@mui/material/Chip';
import Breadcrumbs from '@mui/material/Breadcrumbs';
import Link from '@mui/material/Link';
import Divider from '@mui/material/Divider';
import Stack from '@mui/material/Stack';
import Button from '@mui/material/Button';
import Snackbar from '@mui/material/Snackbar';
import Alert from '@mui/material/Alert';
import AccessTimeIcon from '@mui/icons-material/AccessTime';
import CheckCircleIcon from '@mui/icons-material/CheckCircle';
import MenuBookIcon from '@mui/icons-material/MenuBook';
import ArrowBackIcon from '@mui/icons-material/ArrowBack';
import ArrowForwardIcon from '@mui/icons-material/ArrowForward';
import FormulaSection from '../components/lesson/FormulaSection.jsx';
import UsageSection from '../components/lesson/UsageSection.jsx';
import SignalWordSection from '../components/lesson/SignalWordSection.jsx';
import TipSection from '../components/lesson/TipSection.jsx';
import ComparisonSection from '../components/lesson/ComparisonSection.jsx';
import SectionRenderer from '../components/lesson/SectionRenderer.jsx';
import LessonStatusChip from '../components/progress/LessonStatusChip.jsx';
import LessonProgressSummary from '../components/progress/LessonProgressSummary.jsx';
import ResetProgressDialog from '../components/progress/ResetProgressDialog.jsx';
import Fade from '@mui/material/Fade';
import {
  DIFFICULTY_LABELS,
  DIFFICULTY_COLORS,
} from '../constants/difficulty.js';

export async function loader({ params, request }) {
  const lesson = await fetchLesson(params.slug, { signal: request.signal });
  const progress = await fetchProgress(lesson.id, {
    signal: request.signal,
  }).catch(() => null);
  return { lesson, progress };
}

function getExerciseCTA(progress) {
  if (!progress || progress.exercises_attempted === 0) {
    return 'Bắt đầu làm bài tập';
  }
  if (progress.status === 'completed') {
    return 'Làm lại bài tập';
  }
  return 'Tiếp tục làm bài tập';
}

export default function LessonPage() {
  const { lesson, progress: loaderProgress } = useLoaderData();
  const navigate = useNavigate();

  // Local state for optimistic updates (theory complete, reset)
  // Sync with loader data when navigating between lessons
  const [progress, setProgress] = useState(loaderProgress);
  useEffect(() => {
    setProgress(loaderProgress);
  }, [loaderProgress]);
  const [theoryMarking, setTheoryMarking] = useState(false);
  const [resetDialogOpen, setResetDialogOpen] = useState(false);
  const [resetting, setResetting] = useState(false);
  const [snackbarOpen, setSnackbarOpen] = useState(false);
  const [actionError, setActionError] = useState(null);

  async function handleMarkTheoryComplete() {
    setTheoryMarking(true);
    try {
      await markTheoryComplete(lesson.id, { timeSpent: 0 });
      setProgress((prev) =>
        prev
          ? { ...prev, theory_completed: true }
          : {
              theory_completed: true,
              status: 'not_started',
              exercises_attempted: 0,
              exercises_total: 0,
              current_score: 0,
              best_score: 0,
            },
      );
    } catch {
      setActionError('Không thể đánh dấu lý thuyết. Vui lòng thử lại.');
    } finally {
      setTheoryMarking(false);
    }
  }

  async function handleReset() {
    setResetting(true);
    try {
      await resetProgress(lesson.id);
      setProgress(null);
      setResetDialogOpen(false);
    } catch {
      setActionError('Không thể đặt lại tiến trình. Vui lòng thử lại.');
    } finally {
      setResetting(false);
    }
  }

  function handleExerciseCTA() {
    // Soft reminder if theory not read
    if (!progress?.theory_completed) {
      setSnackbarOpen(true);
    }
    navigate(`/lessons/${lesson.id}/exercises`, {
      state: { lessonName: lesson.name_vi, lessonSlug: lesson.slug },
    });
  }

  return (
    <Fade in timeout={300}>
      <Box>
        {/* Breadcrumb */}
        <Breadcrumbs sx={{ mb: 2 }}>
          <Link component={RouterLink} to="/" underline="hover" color="inherit">
            Trang chủ
          </Link>
          <Typography color="text.secondary">{lesson.group_name_vi}</Typography>
          <Typography color="text.primary">{lesson.name_vi}</Typography>
        </Breadcrumbs>

        {/* Lesson Header */}
        <Box sx={{ mb: 4 }}>
          <Typography variant="h4" component="h1" gutterBottom>
            {lesson.name}
          </Typography>
          <Typography variant="h6" color="text.secondary" gutterBottom>
            {lesson.name_vi}
          </Typography>

          {lesson.description_vi && (
            <Typography variant="body1" sx={{ mb: 2 }}>
              {lesson.description_vi}
            </Typography>
          )}

          <Stack direction="row" spacing={1} flexWrap="wrap" useFlexGap>
            <Chip
              label={DIFFICULTY_LABELS[lesson.difficulty] || lesson.difficulty}
              color={DIFFICULTY_COLORS[lesson.difficulty] || 'default'}
              size="small"
            />
            {lesson.estimated_time && (
              <Chip
                icon={<AccessTimeIcon />}
                label={`${lesson.estimated_time} phút`}
                size="small"
                variant="outlined"
              />
            )}
            <Chip
              label={lesson.group_name_vi}
              size="small"
              sx={{ bgcolor: lesson.group_color, color: '#fff' }}
            />
            <LessonStatusChip status={progress?.status} />
          </Stack>
        </Box>

        {/* Theory Sections — data-driven sections first, then legacy grammar sections */}
        <Stack spacing={4} divider={<Divider />}>
          <SectionRenderer sections={lesson.sections} />
          <FormulaSection formulas={lesson.formulas} />
          <UsageSection usages={lesson.usages} />
          <SignalWordSection signalWords={lesson.signalWords} />
          <TipSection tips={lesson.tips} />
          <ComparisonSection
            comparisons={lesson.comparisons}
            lessonName={lesson.name}
          />
        </Stack>

        {/* Mark Theory Complete */}
        <Box sx={{ mt: 4, textAlign: 'center' }}>
          {progress?.theory_completed ? (
            <Box
              sx={{
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                gap: 1,
              }}
            >
              <CheckCircleIcon color="success" />
              <Typography variant="body1" color="success.main" fontWeight={500}>
                Đã hoàn thành lý thuyết
              </Typography>
            </Box>
          ) : (
            <Button
              variant="outlined"
              startIcon={<MenuBookIcon />}
              onClick={handleMarkTheoryComplete}
              loading={theoryMarking}
            >
              Đánh dấu đã đọc lý thuyết
            </Button>
          )}
        </Box>

        {/* Progress Summary */}
        {progress &&
          (progress.exercises_attempted > 0 || progress.theory_completed) && (
            <Box sx={{ mt: 3 }}>
              <LessonProgressSummary progress={progress} />
            </Box>
          )}

        {/* Exercise CTA */}
        <Box sx={{ mt: 4, textAlign: 'center' }}>
          <Divider sx={{ mb: 4 }} />
          <Typography variant="h6" gutterBottom>
            Sẵn sàng luyện tập?
          </Typography>
          <Button
            variant="contained"
            size="large"
            onClick={handleExerciseCTA}
            sx={{ px: 4 }}
          >
            {getExerciseCTA(progress)}
          </Button>

          {/* Reset progress */}
          {progress &&
            (progress.exercises_attempted > 0 || progress.theory_completed) && (
              <Box sx={{ mt: 2 }}>
                <Button
                  size="small"
                  color="inherit"
                  sx={{ color: 'text.secondary' }}
                  onClick={() => setResetDialogOpen(true)}
                >
                  Đặt lại tiến trình
                </Button>
              </Box>
            )}
        </Box>

        {/* Prev/Next Lesson Navigation */}
        {lesson.navigation &&
          (lesson.navigation.prev || lesson.navigation.next) && (
            <Box sx={{ mt: 4 }}>
              <Divider sx={{ mb: 3 }} />
              <Stack direction="row" justifyContent="space-between">
                {lesson.navigation.prev ? (
                  <Button
                    component={RouterLink}
                    to={`/lessons/${lesson.navigation.prev.slug}`}
                    startIcon={<ArrowBackIcon />}
                  >
                    {lesson.navigation.prev.name_vi}
                  </Button>
                ) : (
                  <Box />
                )}
                {lesson.navigation.next ? (
                  <Button
                    component={RouterLink}
                    to={`/lessons/${lesson.navigation.next.slug}`}
                    endIcon={<ArrowForwardIcon />}
                  >
                    {lesson.navigation.next.name_vi}
                  </Button>
                ) : (
                  <Box />
                )}
              </Stack>
            </Box>
          )}

        {/* Reset Confirmation Dialog */}
        <ResetProgressDialog
          open={resetDialogOpen}
          onClose={() => setResetDialogOpen(false)}
          onConfirm={handleReset}
          loading={resetting}
        />

        {/* Soft Theory Reminder */}
        <Snackbar
          open={snackbarOpen}
          autoHideDuration={4000}
          onClose={() => setSnackbarOpen(false)}
          message="Bạn chưa đọc lý thuyết. Đọc lý thuyết giúp làm bài tốt hơn!"
        />

        {/* Action Error Feedback */}
        <Snackbar
          open={!!actionError}
          autoHideDuration={5000}
          onClose={() => setActionError(null)}
        >
          <Alert
            severity="error"
            variant="filled"
            onClose={() => setActionError(null)}
          >
            {actionError}
          </Alert>
        </Snackbar>
      </Box>
    </Fade>
  );
}
