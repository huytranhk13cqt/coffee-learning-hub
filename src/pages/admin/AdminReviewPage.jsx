import { useLoaderData } from 'react-router';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Paper from '@mui/material/Paper';
import Grid from '@mui/material/Grid';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Table from '@mui/material/Table';
import TableHead from '@mui/material/TableHead';
import TableBody from '@mui/material/TableBody';
import TableRow from '@mui/material/TableRow';
import TableCell from '@mui/material/TableCell';
import CircularProgress from '@mui/material/CircularProgress';
import { PICO } from '../../theme/pixelTheme.js';
import { fetchAdminReviewStats } from '../../api/admin.js';

export async function loader() {
  const res = await fetchAdminReviewStats();
  return res;
}

const STAT_CARDS = [
  { key: 'total_enrolled', label: 'Total Enrolled', color: PICO.blue },
  { key: 'due_today', label: 'Due Today', color: PICO.red },
  { key: 'due_this_week', label: 'Due This Week', color: PICO.orange },
  { key: 'unique_sessions', label: 'Sessions', color: PICO.green },
];

const EASE_COLORS = [
  PICO.red,
  PICO.orange,
  PICO.yellow,
  PICO.green,
  PICO.blue,
  PICO.lavender,
];
const INTERVAL_COLORS = [
  PICO.red,
  PICO.orange,
  PICO.yellow,
  PICO.green,
  PICO.blue,
];

function CssBarChart({ data, colors, title }) {
  if (!data || data.length === 0) {
    return (
      <Typography variant="body2" color="text.secondary">
        No data available
      </Typography>
    );
  }

  const maxCount = Math.max(...data.map((d) => d.count), 1);

  return (
    <Box>
      <Typography variant="h4" sx={{ mb: 2 }}>
        {title}
      </Typography>
      {data.map((item, idx) => (
        <Box
          key={item.bucket}
          sx={{ display: 'flex', alignItems: 'center', gap: 1, mb: 1 }}
        >
          <Typography
            variant="caption"
            sx={{ minWidth: 60, textAlign: 'right', flexShrink: 0 }}
          >
            {item.bucket}
          </Typography>
          <Box sx={{ flex: 1, position: 'relative', height: 24 }}>
            <Box
              sx={{
                height: '100%',
                width: `${(item.count / maxCount) * 100}%`,
                bgcolor: colors[idx % colors.length],
                minWidth: item.count > 0 ? 4 : 0,
                transition: 'width 0.3s',
              }}
            />
          </Box>
          <Typography variant="caption" sx={{ minWidth: 40, flexShrink: 0 }}>
            {item.count}
          </Typography>
        </Box>
      ))}
    </Box>
  );
}

export default function AdminReviewPage() {
  const loaderData = useLoaderData();
  const data = loaderData?.data;

  if (!data) {
    return (
      <Box sx={{ display: 'flex', justifyContent: 'center', py: 8 }}>
        <CircularProgress />
      </Box>
    );
  }

  return (
    <Box>
      <Typography variant="h2" sx={{ mb: 3 }}>
        Spaced Repetition Overview
      </Typography>

      <Grid container spacing={2} sx={{ mb: 3 }}>
        {STAT_CARDS.map(({ key, label, color }) => (
          <Grid key={key} size={{ xs: 6, sm: 3 }}>
            <Card>
              <CardContent sx={{ p: 2, '&:last-child': { pb: 2 } }}>
                <Typography variant="h3" sx={{ color }}>
                  {data[key] ?? 0}
                </Typography>
                <Typography variant="caption" color="text.secondary">
                  {label}
                </Typography>
              </CardContent>
            </Card>
          </Grid>
        ))}
      </Grid>

      <Grid container spacing={2} sx={{ mb: 3 }}>
        <Grid size={{ xs: 6 }}>
          <Paper sx={{ p: 2 }}>
            <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
              Avg Ease Factor: <strong>{data.avg_ease_factor ?? '-'}</strong>
            </Typography>
          </Paper>
        </Grid>
        <Grid size={{ xs: 6 }}>
          <Paper sx={{ p: 2 }}>
            <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
              Avg Interval:{' '}
              <strong>{data.avg_interval_days ?? '-'} days</strong>
            </Typography>
          </Paper>
        </Grid>
      </Grid>

      <Grid container spacing={3} sx={{ mb: 3 }}>
        <Grid size={{ xs: 12, md: 6 }}>
          <Paper sx={{ p: 3 }}>
            <CssBarChart
              data={data.ease_distribution}
              colors={EASE_COLORS}
              title="Ease Factor Distribution"
            />
          </Paper>
        </Grid>
        <Grid size={{ xs: 12, md: 6 }}>
          <Paper sx={{ p: 3 }}>
            <CssBarChart
              data={data.interval_distribution}
              colors={INTERVAL_COLORS}
              title="Interval Distribution (days)"
            />
          </Paper>
        </Grid>
      </Grid>

      <Paper sx={{ p: 3 }}>
        <Typography variant="h4" sx={{ mb: 2 }}>
          Top 10 Most Reviewed Exercises
        </Typography>
        <Box sx={{ overflow: 'auto' }}>
          <Table size="small">
            <TableHead>
              <TableRow>
                <TableCell>#</TableCell>
                <TableCell>Question</TableCell>
                <TableCell>Lesson</TableCell>
                <TableCell>Reviews</TableCell>
                <TableCell>Avg EF</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {!data.top_reviewed || data.top_reviewed.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={5} align="center" sx={{ py: 4 }}>
                    <Typography variant="body2" color="text.secondary">
                      No review data yet
                    </Typography>
                  </TableCell>
                </TableRow>
              ) : (
                data.top_reviewed.map((item, idx) => (
                  <TableRow key={item.exercise_id} hover>
                    <TableCell>{idx + 1}</TableCell>
                    <TableCell
                      sx={{
                        maxWidth: 300,
                        overflow: 'hidden',
                        textOverflow: 'ellipsis',
                        whiteSpace: 'nowrap',
                      }}
                    >
                      {item.question}
                    </TableCell>
                    <TableCell>{item.lesson_name}</TableCell>
                    <TableCell>{item.review_count}</TableCell>
                    <TableCell>{item.avg_ease}</TableCell>
                  </TableRow>
                ))
              )}
            </TableBody>
          </Table>
        </Box>
      </Paper>
    </Box>
  );
}
