import { useRouteError, Link as RouterLink } from 'react-router';
import { useDocumentTitle } from '../hooks/useDocumentTitle.js';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import Stack from '@mui/material/Stack';

function getErrorInfo(error) {
  const status = error?.status;
  if (status === 404) {
    return {
      title: 'Không tìm thấy trang',
      message: error?.message || 'Trang bạn tìm không tồn tại.',
      showRetry: false,
    };
  }
  if (status === 408 || status === 0) {
    return {
      title: 'Lỗi kết nối',
      message:
        'Không thể kết nối đến máy chủ. Vui lòng kiểm tra mạng và thử lại.',
      showRetry: true,
    };
  }
  if (status >= 500) {
    return {
      title: 'Lỗi máy chủ',
      message: 'Máy chủ gặp sự cố. Vui lòng thử lại sau.',
      showRetry: true,
    };
  }
  return {
    title: 'Có lỗi xảy ra',
    message: error?.message || 'Vui lòng thử lại sau.',
    showRetry: true,
  };
}

export default function ErrorPage() {
  const error = useRouteError();
  const { title, message, showRetry } = getErrorInfo(error);
  useDocumentTitle(title);

  return (
    <Box sx={{ textAlign: 'center', py: 8 }}>
      <Typography variant="h4" component="h1" gutterBottom>
        {title}
      </Typography>
      <Typography color="text.secondary" sx={{ mb: 3 }}>
        {message}
      </Typography>
      <Stack direction="row" spacing={2} justifyContent="center">
        {showRetry && (
          <Button variant="outlined" onClick={() => window.location.reload()}>
            Thử lại
          </Button>
        )}
        <Button variant="contained" component={RouterLink} to="/">
          Về trang chủ
        </Button>
      </Stack>
    </Box>
  );
}
