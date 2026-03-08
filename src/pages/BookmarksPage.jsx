import {
  useLoaderData,
  Link as RouterLink,
  useRevalidator,
} from 'react-router';
import { fetchBookmarks, removeBookmarkById } from '../api/bookmarks.js';
import { useDocumentTitle } from '../hooks/useDocumentTitle.js';
import Typography from '@mui/material/Typography';
import Grid from '@mui/material/Grid';
import CardContent from '@mui/material/CardContent';
import CardActions from '@mui/material/CardActions';
import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import IconButton from '@mui/material/IconButton';
import Tooltip from '@mui/material/Tooltip';
import { PixelFrame } from '../components/pixel/index.js';
import Breadcrumbs from '@mui/material/Breadcrumbs';
import Link from '@mui/material/Link';
import Fade from '@mui/material/Fade';
import {
  BookmarkRemoveIcon,
  MenuBookIcon,
  InboxIcon as EmptyIcon,
} from '../components/pixel/icons.jsx';
import { PixelPageHeader } from '../components/pixel/index.js';

export async function loader({ request }) {
  return fetchBookmarks({ signal: request.signal });
}

export default function BookmarksPage() {
  const bookmarks = useLoaderData();
  const revalidator = useRevalidator();
  useDocumentTitle('Bài học đã lưu');

  async function handleRemove(id) {
    try {
      await removeBookmarkById(id);
      revalidator.revalidate();
    } catch (err) {
      console.error('Failed to remove bookmark:', err);
    }
  }

  const isEmpty = bookmarks.length === 0;

  return (
    <Fade in timeout={300}>
      <Box>
        <Breadcrumbs sx={{ mb: 2 }}>
          <Link component={RouterLink} to="/" underline="hover" color="inherit">
            Trang chủ
          </Link>
          <Typography color="text.primary">Bài học đã lưu</Typography>
        </Breadcrumbs>

        <PixelPageHeader title="Bài học đã lưu" />

        {isEmpty ? (
          <PixelFrame
            variant="default"
            sx={{ p: 6, textAlign: 'center', mt: 4 }}
          >
            <EmptyIcon sx={{ fontSize: 64, color: 'text.disabled', mb: 2 }} />
            <Typography variant="h6" color="text.secondary">
              Bạn chưa lưu bài học nào
            </Typography>
            <Typography variant="body2" color="text.disabled" sx={{ mb: 3 }}>
              Hãy nhấn vào biểu tượng Bookmark ở các bài học để lưu lại và xem
              sau.
            </Typography>
            <Button variant="contained" component={RouterLink} to="/">
              Khám phá bài học
            </Button>
          </PixelFrame>
        ) : (
          <Grid container spacing={3} sx={{ mt: 1 }}>
            {bookmarks.map((bookmark) => (
              <Grid key={bookmark.bookmark_id} size={{ xs: 12, sm: 6, md: 4 }}>
                <PixelFrame
                  variant="raised"
                  sx={{
                    height: '100%',
                    display: 'flex',
                    flexDirection: 'column',
                  }}
                >
                  <CardContent sx={{ flexGrow: 1 }}>
                    <Box
                      sx={{
                        display: 'flex',
                        alignItems: 'center',
                        gap: 1,
                        mb: 1,
                      }}
                    >
                      {/* Pixel square indicator */}
                      <Box
                        sx={{
                          width: 12,
                          height: 12,
                          bgcolor: bookmark.group_color,
                        }}
                      />
                      <Typography
                        variant="caption"
                        color="text.secondary"
                        fontWeight={600}
                      >
                        {bookmark.group_name_vi}
                      </Typography>
                    </Box>
                    <Typography variant="h6" component="h2" gutterBottom>
                      {bookmark.lesson_name_vi}
                    </Typography>
                    <Typography variant="body2" color="text.secondary">
                      Đã lưu vào{' '}
                      {new Date(bookmark.created_at).toLocaleDateString(
                        'vi-VN',
                      )}
                    </Typography>
                  </CardContent>
                  <CardActions
                    sx={{ justifyContent: 'space-between', px: 2, pb: 2 }}
                  >
                    <Button
                      size="small"
                      startIcon={<MenuBookIcon />}
                      component={RouterLink}
                      to={`/lessons/${bookmark.lesson_slug}`}
                    >
                      Học ngay
                    </Button>
                    <Tooltip title="Bỏ lưu">
                      <IconButton
                        size="small"
                        color="error"
                        onClick={() => handleRemove(bookmark.bookmark_id)}
                      >
                        <BookmarkRemoveIcon />
                      </IconButton>
                    </Tooltip>
                  </CardActions>
                </PixelFrame>
              </Grid>
            ))}
          </Grid>
        )}
      </Box>
    </Fade>
  );
}
