import { useLoaderData, Link as RouterLink } from 'react-router';
import { fetchResults } from '../api/exercises.js';
import { fetchProgress } from '../api/progress.js';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import Paper from '@mui/material/Paper';
import Stack from '@mui/material/Stack';
import Chip from '@mui/material/Chip';
import Breadcrumbs from '@mui/material/Breadcrumbs';
import Link from '@mui/material/Link';
import Divider from '@mui/material/Divider';
import CheckCircleIcon from '@mui/icons-material/CheckCircle';
import CancelIcon from '@mui/icons-material/Cancel';
import Fade from '@mui/material/Fade';
import LessonStatusChip from '../components/progress/LessonStatusChip.jsx';

export async function loader({ params, request }) {
  const [results, progress] = await Promise.all([
    fetchResults(params.lessonId, { signal: request.signal }),
    fetchProgress(params.lessonId, { signal: request.signal }).catch(
      () => null,
    ),
  ]);
  return { results, lessonId: params.lessonId, progress };
}

const typeLabels = {
  multiple_choice: 'Trắc nghiệm',
  fill_blank: 'Điền từ',
  error_correction: 'Sửa lỗi',
  sentence_transform: 'Chuyển đổi câu',
  arrange_words: 'Sắp xếp từ',
  matching: 'Nối cặp',
  true_false: 'Đúng/Sai',
};

export default function ResultsPage() {
  const { results, lessonId, progress } = useLoaderData();

  const attempted = results.filter((r) => r.user_answer != null);
  const correct = attempted.filter((r) => r.is_correct);
  const score =
    attempted.length > 0
      ? Math.round((correct.length / results.length) * 100)
      : 0;

  return (
    <Fade in timeout={300}>
      <Box>
        <Breadcrumbs sx={{ mb: 3 }}>
          <Link component={RouterLink} to="/" underline="hover" color="inherit">
            Trang chủ
          </Link>
          <Link
            component={RouterLink}
            to={`/lessons/${lessonId}/exercises`}
            underline="hover"
            color="inherit"
          >
            Bài tập
          </Link>
          <Typography color="text.primary">Kết quả</Typography>
        </Breadcrumbs>

        {/* Summary */}
        <Box sx={{ textAlign: 'center', mb: 4 }}>
          <Typography variant="h4" gutterBottom>
            Kết quả chi tiết
          </Typography>
          <Typography
            variant="h5"
            color={score >= 70 ? 'success.main' : 'error.main'}
          >
            {correct.length}/{results.length} ({score}%)
          </Typography>
          {progress?.best_score > 0 &&
            Math.round(progress.best_score) !== score && (
              <Typography
                variant="body1"
                color="text.secondary"
                sx={{ mt: 0.5 }}
              >
                Điểm cao nhất: {Math.round(progress.best_score)}%
              </Typography>
            )}
          {progress?.status === 'completed' && (
            <Box sx={{ mt: 1 }}>
              <LessonStatusChip status="completed" />
            </Box>
          )}
        </Box>

        {/* Exercise details */}
        <Stack spacing={2}>
          {results.map((ex, index) => {
            const hasAttempt = ex.user_answer != null;
            return (
              <Paper key={ex.exercise_id} variant="outlined" sx={{ p: 2 }}>
                <Box
                  sx={{
                    display: 'flex',
                    alignItems: 'flex-start',
                    gap: 1.5,
                    mb: 1,
                  }}
                >
                  {hasAttempt ? (
                    ex.is_correct ? (
                      <CheckCircleIcon color="success" />
                    ) : (
                      <CancelIcon color="error" />
                    )
                  ) : (
                    <CancelIcon sx={{ color: 'text.disabled' }} />
                  )}
                  <Box sx={{ flex: 1 }}>
                    <Box
                      sx={{
                        display: 'flex',
                        alignItems: 'center',
                        gap: 1,
                        mb: 0.5,
                      }}
                    >
                      <Typography variant="subtitle2">
                        Câu {index + 1}
                      </Typography>
                      <Chip
                        label={typeLabels[ex.type] || ex.type}
                        size="small"
                        variant="outlined"
                      />
                    </Box>

                    <Typography variant="body1" sx={{ mb: 1 }}>
                      {ex.question}
                    </Typography>

                    {ex.content && (
                      <Typography
                        variant="body2"
                        color="text.secondary"
                        sx={{ mb: 1, fontStyle: 'italic' }}
                      >
                        {ex.content}
                      </Typography>
                    )}

                    <Divider sx={{ my: 1 }} />

                    {/* User's answer vs correct */}
                    {hasAttempt && (
                      <Box sx={{ mb: 1 }}>
                        <Typography variant="body2">
                          <strong>Bạn trả lời:</strong>{' '}
                          <Typography
                            component="span"
                            color={
                              ex.is_correct ? 'success.main' : 'error.main'
                            }
                          >
                            {ex.user_answer}
                          </Typography>
                        </Typography>
                      </Box>
                    )}

                    {!hasAttempt && (
                      <Typography
                        variant="body2"
                        color="text.disabled"
                        sx={{ mb: 1 }}
                      >
                        Chưa trả lời
                      </Typography>
                    )}

                    {ex.correct_answer && (
                      <Typography variant="body2" sx={{ mb: 1 }}>
                        <strong>Đáp án:</strong>{' '}
                        <Typography component="span" color="success.main">
                          {ex.correct_answer}
                        </Typography>
                      </Typography>
                    )}

                    {/* Explanation */}
                    {ex.explanation_vi && (
                      <Paper sx={{ p: 1.5, bgcolor: 'grey.50', mt: 1 }}>
                        <Typography variant="body2">
                          {ex.explanation_vi}
                        </Typography>
                        {ex.explanation && (
                          <Typography
                            variant="body2"
                            color="text.secondary"
                            sx={{ mt: 0.5 }}
                          >
                            {ex.explanation}
                          </Typography>
                        )}
                      </Paper>
                    )}
                  </Box>
                </Box>
              </Paper>
            );
          })}
        </Stack>

        {/* Actions */}
        <Stack
          direction="row"
          spacing={2}
          justifyContent="center"
          sx={{ mt: 4 }}
        >
          <Button
            variant="outlined"
            component={RouterLink}
            to={`/lessons/${lessonId}/exercises`}
          >
            Làm lại
          </Button>
          <Button variant="contained" component={RouterLink} to="/">
            Về trang chủ
          </Button>
        </Stack>
      </Box>
    </Fade>
  );
}
