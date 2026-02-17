import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import Chip from '@mui/material/Chip';
import * as Icons from './achievementIcons.js';

export default function AchievementCard({ achievement }) {
  const { nameVi, descriptionVi, icon, xpReward, earned, earnedAt } =
    achievement;

  const IconComponent = Icons[icon] ?? Icons.EmojiEvents;

  return (
    <Card
      variant="outlined"
      sx={{
        opacity: earned ? 1 : 0.5,
        transition: 'opacity 0.2s',
        '&:hover': { opacity: 1 },
      }}
    >
      <CardContent sx={{ display: 'flex', gap: 2, alignItems: 'center' }}>
        <Box
          sx={{
            width: 48,
            height: 48,
            borderRadius: '50%',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            bgcolor: earned ? 'warning.main' : 'action.disabledBackground',
            color: earned ? 'warning.contrastText' : 'text.disabled',
            flexShrink: 0,
          }}
        >
          <IconComponent sx={{ fontSize: 28 }} />
        </Box>
        <Box sx={{ flex: 1, minWidth: 0 }}>
          <Typography variant="subtitle2" fontWeight={700} noWrap>
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
      </CardContent>
    </Card>
  );
}
