import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Tooltip from '@mui/material/Tooltip';
import BoltIcon from '@mui/icons-material/Bolt';

export default function XPDisplay({ totalXP = 0, level = 1 }) {
  return (
    <Tooltip title={`${totalXP} XP — Cấp ${level}`}>
      <Box
        sx={{
          display: 'flex',
          alignItems: 'center',
          gap: 0.3,
          cursor: 'default',
        }}
        aria-label={`${totalXP} điểm kinh nghiệm, cấp ${level}`}
      >
        <BoltIcon
          sx={{ fontSize: 20, color: 'info.main' }}
          aria-hidden="true"
        />
        <Typography variant="body2" fontWeight={700} color="inherit">
          {totalXP >= 1000 ? `${(totalXP / 1000).toFixed(1)}k` : totalXP}
        </Typography>
      </Box>
    </Tooltip>
  );
}
