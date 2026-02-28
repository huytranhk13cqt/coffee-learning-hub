import { useLoaderData, Link as RouterLink } from 'react-router';
import { fetchPaths } from '../api/paths.js';
import { useDocumentTitle } from '../hooks/useDocumentTitle.js';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Grid from '@mui/material/Grid';
import Card from '@mui/material/Card';
import CardActionArea from '@mui/material/CardActionArea';
import CardContent from '@mui/material/CardContent';
import LinearProgress from '@mui/material/LinearProgress';
import Chip from '@mui/material/Chip';
import Fade from '@mui/material/Fade';
import RouteIcon from '@mui/icons-material/Route';
import AutoStoriesIcon from '@mui/icons-material/AutoStories';
import AccessTimeIcon from '@mui/icons-material/AccessTime';

export async function loader({ request }) {
  return fetchPaths({ signal: request.signal });
}

export default function LearningPathsPage() {
  const paths = useLoaderData();
  useDocumentTitle('Lộ trình học tập');

  const featured = paths.filter((p) => p.is_featured);
  const rest = paths.filter((p) => !p.is_featured);

  return (
    <Fade in timeout={300}>
      <div>
        <Box sx={{ display: 'flex', alignItems: 'center', gap: 1.5, mb: 1 }}>
          <RouteIcon sx={{ color: 'primary.main', fontSize: 32 }} />
          <Typography variant="h4" component="h1">
            Lộ trình học tập
          </Typography>
        </Box>
        <Typography color="text.secondary" sx={{ mb: 4 }}>
          Các lộ trình được thiết kế giúp bạn học có hệ thống và đạt mục tiêu
          nhanh hơn.
        </Typography>

        {featured.length > 0 && (
          <>
            <Typography variant="h6" fontWeight={700} sx={{ mb: 2 }}>
              Nổi bật
            </Typography>
            <Grid container spacing={3} sx={{ mb: 4 }}>
              {featured.map((path) => (
                <Grid key={path.id} size={{ xs: 12, sm: 6, md: 4 }}>
                  <PathCard path={path} />
                </Grid>
              ))}
            </Grid>
          </>
        )}

        {rest.length > 0 && (
          <>
            <Typography variant="h6" fontWeight={700} sx={{ mb: 2 }}>
              Tất cả lộ trình
            </Typography>
            <Grid container spacing={3}>
              {rest.map((path) => (
                <Grid key={path.id} size={{ xs: 12, sm: 6, md: 4 }}>
                  <PathCard path={path} />
                </Grid>
              ))}
            </Grid>
          </>
        )}

        {paths.length === 0 && (
          <Box sx={{ textAlign: 'center', py: 8 }}>
            <AutoStoriesIcon
              sx={{ fontSize: 64, color: 'text.disabled', mb: 2 }}
            />
            <Typography variant="h6" gutterBottom>
              Chưa có lộ trình nào
            </Typography>
            <Typography color="text.secondary">
              Các lộ trình học tập sẽ sớm được thêm vào.
            </Typography>
          </Box>
        )}
      </div>
    </Fade>
  );
}

function PathCard({ path }) {
  const descPreview = (path.description_vi || path.description || '').slice(
    0,
    90,
  );

  return (
    <Card
      sx={{
        height: '100%',
        borderTop: 4,
        borderColor: path.color || 'primary.main',
        transition: 'box-shadow 0.15s',
        '&:hover': { boxShadow: 4 },
      }}
    >
      <CardActionArea
        component={RouterLink}
        to={`/paths/${path.slug}`}
        sx={{
          height: '100%',
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'stretch',
        }}
      >
        <CardContent sx={{ flex: 1 }}>
          <Box
            sx={{
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'flex-start',
              mb: 1,
            }}
          >
            <Typography
              variant="h6"
              component="h2"
              sx={{ lineHeight: 1.3, flex: 1, mr: 1 }}
            >
              {path.name_vi}
            </Typography>
            {path.is_featured && (
              <Chip
                label="Nổi bật"
                size="small"
                color="primary"
                sx={{ flexShrink: 0 }}
              />
            )}
          </Box>

          {descPreview && (
            <Typography
              variant="body2"
              color="text.secondary"
              sx={{ mb: 2, minHeight: 40 }}
            >
              {descPreview}
              {descPreview.length >= 90 ? '…' : ''}
            </Typography>
          )}

          <Box sx={{ display: 'flex', gap: 2, mb: 2 }}>
            <Box sx={{ display: 'flex', alignItems: 'center', gap: 0.5 }}>
              <AutoStoriesIcon sx={{ fontSize: 16, color: 'text.secondary' }} />
              <Typography variant="caption" color="text.secondary">
                {path.total_steps} bài học
              </Typography>
            </Box>
            <Box sx={{ display: 'flex', alignItems: 'center', gap: 0.5 }}>
              <AccessTimeIcon sx={{ fontSize: 16, color: 'text.secondary' }} />
              <Typography variant="caption" color="text.secondary">
                {path.estimated_days} ngày
              </Typography>
            </Box>
          </Box>

          {path.progress_percent > 0 && (
            <Box>
              <Box
                sx={{
                  display: 'flex',
                  justifyContent: 'space-between',
                  mb: 0.5,
                }}
              >
                <Typography variant="caption" color="text.secondary">
                  Tiến độ
                </Typography>
                <Typography
                  variant="caption"
                  fontWeight={700}
                  color="primary.main"
                >
                  {path.progress_percent}%
                </Typography>
              </Box>
              <LinearProgress
                variant="determinate"
                value={path.progress_percent}
                sx={{ height: 6, borderRadius: 3 }}
              />
            </Box>
          )}
        </CardContent>
      </CardActionArea>
    </Card>
  );
}
