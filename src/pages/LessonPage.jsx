import { useLoaderData, Link as RouterLink } from 'react-router';
import { fetchLesson } from '../api/lessons.js';
import {
  Typography,
  Box,
  Chip,
  Breadcrumbs,
  Link,
  Divider,
  Stack,
} from '@mui/material';
import AccessTimeIcon from '@mui/icons-material/AccessTime';
import FormulaSection from '../components/lesson/FormulaSection.jsx';
import UsageSection from '../components/lesson/UsageSection.jsx';
import SignalWordSection from '../components/lesson/SignalWordSection.jsx';
import TipSection from '../components/lesson/TipSection.jsx';
import ComparisonSection from '../components/lesson/ComparisonSection.jsx';

export async function loader({ params, request }) {
  return fetchLesson(params.slug, { signal: request.signal });
}

const DIFFICULTY_COLORS = {
  beginner: 'success',
  intermediate: 'warning',
  advanced: 'error',
};

const DIFFICULTY_LABELS = {
  beginner: 'Cơ bản',
  intermediate: 'Trung bình',
  advanced: 'Nâng cao',
};

export default function LessonPage() {
  const lesson = useLoaderData();

  return (
    <Box>
      {/* Breadcrumb */}
      <Breadcrumbs sx={{ mb: 2 }}>
        <Link component={RouterLink} to="/" underline="hover" color="inherit">
          Trang chủ
        </Link>
        <Typography color="text.secondary">
          {lesson.group_name_vi}
        </Typography>
        <Typography color="text.primary">
          {lesson.name_vi}
        </Typography>
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
        </Stack>
      </Box>

      {/* Theory Sections */}
      <Stack spacing={4} divider={<Divider />}>
        <FormulaSection formulas={lesson.formulas} />
        <UsageSection usages={lesson.usages} />
        <SignalWordSection signalWords={lesson.signalWords} />
        <TipSection tips={lesson.tips} />
        <ComparisonSection
          comparisons={lesson.comparisons}
          lessonName={lesson.name}
        />
      </Stack>
    </Box>
  );
}
