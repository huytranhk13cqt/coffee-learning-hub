import Skeleton from '@mui/material/Skeleton';
import Box from '@mui/material/Box';
import Stack from '@mui/material/Stack';

export default function PageSkeleton() {
  return (
    <Box>
      <Skeleton variant="text" width="40%" height={42} sx={{ mb: 1 }} />
      <Skeleton variant="text" width="60%" height={24} sx={{ mb: 4 }} />
      <Stack spacing={3}>
        <Skeleton variant="rectangular" height={160} sx={{ borderRadius: 1 }} />
        <Skeleton variant="rectangular" height={120} sx={{ borderRadius: 1 }} />
        <Skeleton variant="rectangular" height={160} sx={{ borderRadius: 1 }} />
      </Stack>
    </Box>
  );
}
