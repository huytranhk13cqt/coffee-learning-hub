import { useLoaderData } from 'react-router';
import { fetchGroups } from '../api/groups.js';
import {
  Typography,
  Grid,
  Card,
  CardContent,
  Box,
  Chip,
} from '@mui/material';

export async function loader({ request }) {
  return fetchGroups({ signal: request.signal });
}

export default function HomePage() {
  const groups = useLoaderData();

  return (
    <>
      <Typography variant="h4" component="h1" gutterBottom>
        English Grammar
      </Typography>
      <Typography variant="subtitle1" color="text.secondary" sx={{ mb: 4 }}>
        Chọn nhóm thì để bắt đầu học
      </Typography>

      <Grid container spacing={3}>
        {groups.map((group) => (
          <Grid key={group.id} size={{ xs: 12, sm: 6, md: 4 }}>
            <Card
              sx={{
                height: '100%',
                borderTop: 4,
                borderColor: group.color,
              }}
            >
              <CardContent>
                <Typography variant="h5" gutterBottom>
                  {group.name}
                </Typography>
                <Typography variant="subtitle2" color="text.secondary" gutterBottom>
                  {group.name_vi}
                </Typography>
                <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
                  {group.description_vi}
                </Typography>
                <Box sx={{ display: 'flex', gap: 1 }}>
                  <Chip
                    label={`${group.lesson_count} bài học`}
                    size="small"
                    sx={{ backgroundColor: group.color, color: '#fff' }}
                  />
                </Box>
              </CardContent>
            </Card>
          </Grid>
        ))}
      </Grid>
    </>
  );
}
