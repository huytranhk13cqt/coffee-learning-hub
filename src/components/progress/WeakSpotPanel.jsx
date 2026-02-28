import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import List from '@mui/material/List';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemText from '@mui/material/ListItemText';
import Chip from '@mui/material/Chip';
import Button from '@mui/material/Button';
import { Link as RouterLink } from 'react-router';
import WhatshotIcon from '@mui/icons-material/Whatshot';
import ArrowForwardIcon from '@mui/icons-material/ArrowForward';

export default function WeakSpotPanel({ weakSpots }) {
  if (!weakSpots || weakSpots.length === 0) return null;

  const top5 = weakSpots.slice(0, 5);

  return (
    <Paper variant="outlined" sx={{ mb: 3 }}>
      <Box
        sx={{
          px: 2.5,
          pt: 2,
          pb: 1,
          display: 'flex',
          alignItems: 'center',
          gap: 1,
        }}
      >
        <WhatshotIcon sx={{ color: 'error.main', fontSize: 20 }} />
        <Typography variant="h6" component="h2">
          Điểm yếu cần cải thiện
        </Typography>
      </Box>

      <List dense disablePadding>
        {top5.map((spot) => {
          const errorPct = Math.round(spot.error_rate * 100);
          return (
            <ListItemButton
              key={spot.id}
              component={RouterLink}
              to={`/lessons/${spot.lesson_slug}`}
              sx={{ px: 2.5 }}
            >
              <ListItemText
                primary={
                  <Typography
                    variant="body2"
                    sx={{
                      overflow: 'hidden',
                      textOverflow: 'ellipsis',
                      whiteSpace: 'nowrap',
                      maxWidth: { xs: 160, sm: 300, md: 420 },
                    }}
                  >
                    {spot.question_vi || spot.question}
                  </Typography>
                }
                secondary={
                  <Typography variant="caption" color="text.secondary">
                    {spot.category_name_vi} · {spot.total_attempts} lần thử
                  </Typography>
                }
              />
              <Box
                sx={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: 1,
                  ml: 1,
                  flexShrink: 0,
                }}
              >
                <Chip
                  label={`${errorPct}% sai`}
                  size="small"
                  color={errorPct >= 70 ? 'error' : 'warning'}
                  sx={{ fontWeight: 700, height: 22, fontSize: '0.7rem' }}
                />
              </Box>
            </ListItemButton>
          );
        })}
      </List>

      <Box
        sx={{ px: 2.5, py: 1.5, display: 'flex', justifyContent: 'flex-end' }}
      >
        <Button
          size="small"
          endIcon={<ArrowForwardIcon />}
          component={RouterLink}
          to="/review"
        >
          Ôn tập bài khó
        </Button>
      </Box>
    </Paper>
  );
}
