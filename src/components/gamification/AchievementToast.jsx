import { useState } from 'react';
import Snackbar from '@mui/material/Snackbar';
import Alert from '@mui/material/Alert';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import { EmojiEventsIcon } from '../pixel/icons.jsx';
import { PixelParticles } from '../pixel/index.js';
import { ANIMATION } from '../../theme/pixelUtils.js';

/**
 * Shows a celebratory toast when new achievements are earned.
 * Uses index-based approach: advances through the achievements array
 * one by one, showing each as a Snackbar toast.
 *
 * Enhanced with pixel scale-in animation + sparkle particle burst.
 */
export default function AchievementToast({ achievements = [] }) {
  const [shownCount, setShownCount] = useState(0);

  const current = achievements[shownCount] ?? null;

  const handleClose = (_event, reason) => {
    if (reason === 'clickaway') return;
    setShownCount((prev) => prev + 1);
  };

  if (!current) return null;

  return (
    <Snackbar
      open
      autoHideDuration={4000}
      onClose={handleClose}
      anchorOrigin={{ vertical: 'top', horizontal: 'center' }}
    >
      <Alert
        onClose={handleClose}
        severity="success"
        variant="filled"
        icon={
          <EmojiEventsIcon
            sx={{ ...ANIMATION.bounce, animationDelay: '0.2s' }}
          />
        }
        sx={{
          width: '100%',
          position: 'relative',
          overflow: 'visible',
          ...ANIMATION.scaleIn,
          boxShadow: '0 0 16px var(--mui-palette-success-main)',
        }}
      >
        <PixelParticles active preset="sparkle" />
        <Box>
          <Typography variant="subtitle2" fontWeight={700}>
            {current.nameVi}
          </Typography>
          <Typography variant="caption">+{current.xpReward} XP</Typography>
        </Box>
      </Alert>
    </Snackbar>
  );
}
