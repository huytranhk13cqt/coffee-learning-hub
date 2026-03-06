import { useLoaderData, Link as RouterLink } from 'react-router';
import { fetchPath } from '../api/paths.js';
import { useDocumentTitle } from '../hooks/useDocumentTitle.js';
import {
  DIFFICULTY_LABELS,
  DIFFICULTY_COLORS,
} from '../constants/difficulty.js';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Paper from '@mui/material/Paper';
import Stack from '@mui/material/Stack';
import LinearProgress from '@mui/material/LinearProgress';
import Button from '@mui/material/Button';
import Chip from '@mui/material/Chip';
import List from '@mui/material/List';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemText from '@mui/material/ListItemText';
import ListItemIcon from '@mui/material/ListItemIcon';
import Fade from '@mui/material/Fade';
import Breadcrumbs from '@mui/material/Breadcrumbs';
import Link from '@mui/material/Link';
import Divider from '@mui/material/Divider';
import CheckCircleIcon from '@mui/icons-material/CheckCircle';
import RadioButtonUncheckedIcon from '@mui/icons-material/RadioButtonUnchecked';
import PlayArrowIcon from '@mui/icons-material/PlayArrow';
import RouteIcon from '@mui/icons-material/Route';
import AccessTimeIcon from '@mui/icons-material/AccessTime';
import AutoStoriesIcon from '@mui/icons-material/AutoStories';

export async function loader({ params, request }) {
  return fetchPath(params.slug, { signal: request.signal });
}

export default function PathDetailPage() {
  const path = useLoaderData();
  useDocumentTitle(path.name_vi);

  const allDone = path.steps.every((s) => s.status === 'completed');
  const ctaStep =
    path.steps.find((s) => s.status === 'in_progress') ||
    path.steps.find((s) => s.status === 'not_started');

  return (
    <Fade in timeout={300}>
      <div>
        {/* Breadcrumb */}
        <Breadcrumbs sx={{ mb: 2 }}>
          <Link
            component={RouterLink}
            to="/paths"
            underline="hover"
            color="inherit"
            sx={{ display: 'flex', alignItems: 'center', gap: 0.5 }}
          >
            <RouteIcon sx={{ fontSize: 16 }} />
            Lộ trình
          </Link>
          <Typography color="text.primary" fontWeight={600}>
            {path.name_vi}
          </Typography>
        </Breadcrumbs>

        {/* Header */}
        <Paper
          variant="outlined"
          sx={{
            p: 3,
            mb: 3,
            borderTop: 4,
            borderColor: path.color || 'primary.main',
          }}
        >
          <Typography variant="h4" component="h1" gutterBottom>
            {path.name_vi}
          </Typography>

          {path.description_vi && (
            <Typography color="text.secondary" sx={{ mb: 2 }}>
              {path.description_vi}
            </Typography>
          )}

          {/* Stats row */}
          <Stack direction="row" spacing={3} flexWrap="wrap" sx={{ mb: 2 }}>
            <Box sx={{ display: 'flex', alignItems: 'center', gap: 0.5 }}>
              <AutoStoriesIcon sx={{ fontSize: 18, color: 'text.secondary' }} />
              <Typography variant="body2" color="text.secondary">
                {path.steps.length} bài học
              </Typography>
            </Box>
            <Box sx={{ display: 'flex', alignItems: 'center', gap: 0.5 }}>
              <AccessTimeIcon sx={{ fontSize: 18, color: 'text.secondary' }} />
              <Typography variant="body2" color="text.secondary">
                ~{path.estimated_days} ngày
              </Typography>
            </Box>
          </Stack>

          {/* Progress */}
          <Box>
            <Box
              sx={{ display: 'flex', justifyContent: 'space-between', mb: 0.5 }}
            >
              <Typography variant="body2" color="text.secondary">
                Tiến độ hoàn thành
              </Typography>
              <Typography variant="body2" fontWeight={700} color="primary.main">
                {path.progress_percent}%
              </Typography>
            </Box>
            <LinearProgress
              variant="determinate"
              value={path.progress_percent}
              sx={{ height: 8, borderRadius: 4 }}
            />
          </Box>
        </Paper>

        {/* CTA Button */}
        {allDone ? (
          <Paper
            variant="outlined"
            sx={{
              p: 2,
              mb: 3,
              textAlign: 'center',
              bgcolor: 'success.main',
              color: 'common.white',
            }}
          >
            <Typography variant="h6" fontWeight={700}>
              Hoàn thành lộ trình! 🎉
            </Typography>
            <Typography variant="body2" sx={{ opacity: 0.9 }}>
              Bạn đã hoàn thành tất cả {path.steps.length} bài trong lộ trình
              này.
            </Typography>
          </Paper>
        ) : ctaStep ? (
          <Box sx={{ mb: 3 }}>
            <Button
              variant="contained"
              size="large"
              component={RouterLink}
              to={`/lessons/${ctaStep.slug}`}
              startIcon={<PlayArrowIcon />}
              fullWidth
              sx={{ py: 1.5 }}
            >
              {ctaStep.status === 'in_progress' ? 'Tiếp tục: ' : 'Bắt đầu: '}
              {ctaStep.name_vi}
            </Button>
          </Box>
        ) : null}

        {/* Step list */}
        <Typography variant="h6" fontWeight={700} sx={{ mb: 1 }}>
          Danh sách bài học
        </Typography>

        <Paper variant="outlined">
          <List disablePadding>
            {path.steps.map((step, idx) => {
              const isDone = step.status === 'completed';
              const isActive = step.status === 'in_progress';

              return (
                <Box key={step.lesson_id}>
                  <ListItemButton
                    component={RouterLink}
                    to={`/lessons/${step.slug}`}
                    sx={{
                      px: 2.5,
                      py: 1.5,
                      opacity: isDone ? 0.65 : 1,
                    }}
                  >
                    {/* Step number */}
                    <Box
                      sx={{
                        width: 28,
                        height: 28,
                        borderRadius: '50%',
                        bgcolor: isDone
                          ? 'success.main'
                          : isActive
                            ? 'primary.main'
                            : 'action.hover',
                        color:
                          isDone || isActive
                            ? 'common.white'
                            : 'text.secondary',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        flexShrink: 0,
                        mr: 2,
                        fontSize: '0.75rem',
                        fontWeight: 700,
                      }}
                    >
                      {idx + 1}
                    </Box>

                    <ListItemText
                      primary={
                        <Typography
                          variant="body1"
                          fontWeight={isActive ? 700 : 400}
                        >
                          {step.name_vi}
                        </Typography>
                      }
                      secondary={
                        <Box
                          component="span"
                          sx={{
                            display: 'flex',
                            alignItems: 'center',
                            gap: 1,
                            mt: 0.25,
                          }}
                        >
                          <Typography variant="caption" color="text.secondary">
                            {step.category_name}
                          </Typography>
                          <Chip
                            label={
                              DIFFICULTY_LABELS[step.difficulty] ||
                              step.difficulty
                            }
                            size="small"
                            color={
                              DIFFICULTY_COLORS[step.difficulty] || 'default'
                            }
                            sx={{ height: 18, fontSize: '0.65rem' }}
                          />
                        </Box>
                      }
                    />

                    <ListItemIcon sx={{ minWidth: 'auto', ml: 1 }}>
                      {isDone ? (
                        <CheckCircleIcon color="success" />
                      ) : isActive ? (
                        <PlayArrowIcon color="primary" />
                      ) : (
                        <RadioButtonUncheckedIcon
                          sx={{ color: 'text.disabled' }}
                        />
                      )}
                    </ListItemIcon>
                  </ListItemButton>

                  {idx < path.steps.length - 1 && <Divider />}
                </Box>
              );
            })}
          </List>
        </Paper>
      </div>
    </Fade>
  );
}
