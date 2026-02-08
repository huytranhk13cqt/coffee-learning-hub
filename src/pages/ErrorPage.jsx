import { useRouteError } from 'react-router';
import { Typography, Box, Button } from '@mui/material';

export default function ErrorPage() {
  const error = useRouteError();

  return (
    <Box sx={{ textAlign: 'center', py: 8 }}>
      <Typography variant="h4" gutterBottom>
        Something went wrong
      </Typography>
      <Typography color="text.secondary" sx={{ mb: 3 }}>
        {error?.message || 'An unexpected error occurred'}
      </Typography>
      <Button variant="contained" onClick={() => window.location.reload()}>
        Try again
      </Button>
    </Box>
  );
}
