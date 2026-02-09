import { useRouteError, Link as RouterLink } from 'react-router';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import Stack from '@mui/material/Stack';

export default function ErrorPage() {
  const error = useRouteError();
  const is404 = error?.status === 404;

  return (
    <Box sx={{ textAlign: 'center', py: 8 }}>
      <Typography variant="h4" gutterBottom>
        {is404 ? 'Không tìm thấy trang' : 'Có lỗi xảy ra'}
      </Typography>
      <Typography color="text.secondary" sx={{ mb: 3 }}>
        {error?.message || 'Vui lòng thử lại sau'}
      </Typography>
      <Stack direction="row" spacing={2} justifyContent="center">
        <Button variant="outlined" onClick={() => window.location.reload()}>
          Thử lại
        </Button>
        <Button variant="contained" component={RouterLink} to="/">
          Về trang chủ
        </Button>
      </Stack>
    </Box>
  );
}
