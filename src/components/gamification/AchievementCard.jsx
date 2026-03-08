import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import Chip from '@mui/material/Chip';
import * as Icons from './achievementIcons.js';
import { PixelFrame } from '../pixel/index.js';
import { FONT, ANIMATION } from '../../theme/pixelUtils.js';

export default function AchievementCard({ achievement }) {
  const { nameVi, descriptionVi, icon, xpReward, earned, earnedAt } =
    achievement;

  const IconComponent = Icons[icon] ?? Icons.EmojiEvents;

  return (
    <PixelFrame
      variant={earned ? 'raised' : 'default'}
      glow={earned}
      sx={{
        p: 2,
        opacity: earned ? 1 : 0.5,
        transition: 'opacity 0.15s steps(3, end)',
        '&:hover': { opacity: 1 },
      }}
    >
      <Box sx={{ display: 'flex', gap: 2, alignItems: 'center' }}>
        {/* Pixel square icon badge — no border-radius for pixel aesthetic */}
        <Box
          sx={{
            width: 48,
            height: 48,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            bgcolor: earned ? 'warning.main' : 'action.disabledBackground',
            color: earned ? 'warning.contrastText' : 'text.disabled',
            flexShrink: 0,
            border: '2px solid',
            borderColor: earned ? 'warning.dark' : 'divider',
            boxShadow: earned ? '2px 2px 0 0 rgba(0,0,0,0.12)' : 'none',
          }}
        >
          <IconComponent
            sx={{ fontSize: 28, ...(earned ? ANIMATION.bounce : {}) }}
          />
        </Box>
        <Box sx={{ flex: 1, minWidth: 0 }}>
          <Typography
            variant="subtitle2"
            noWrap
            sx={{ fontFamily: FONT.pixel, fontSize: '0.85rem' }}
          >
            {nameVi}
          </Typography>
          <Typography variant="caption" color="text.secondary" display="block">
            {descriptionVi}
          </Typography>
          <Box sx={{ display: 'flex', gap: 1, mt: 0.5, alignItems: 'center' }}>
            <Chip
              label={`+${xpReward} XP`}
              size="small"
              color="primary"
              variant="outlined"
            />
            {earned && earnedAt && (
              <Typography variant="caption" color="text.secondary">
                {new Date(earnedAt).toLocaleDateString('vi-VN')}
              </Typography>
            )}
          </Box>
        </Box>
      </Box>
    </PixelFrame>
  );
}
