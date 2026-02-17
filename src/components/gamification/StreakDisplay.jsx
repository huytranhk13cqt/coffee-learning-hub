import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Tooltip from '@mui/material/Tooltip';
import LocalFireDepartmentIcon from '@mui/icons-material/LocalFireDepartment';

export default function StreakDisplay({ streak = 0 }) {
  if (streak <= 0) return null;

  return (
    <Tooltip title={`Chuỗi ${streak} ngày liên tiếp`}>
      <Box
        sx={{
          display: 'flex',
          alignItems: 'center',
          gap: 0.3,
          cursor: 'default',
        }}
        aria-label={`Chuỗi ${streak} ngày`}
      >
        <LocalFireDepartmentIcon
          sx={{ fontSize: 20, color: 'warning.main' }}
          aria-hidden="true"
        />
        <Typography variant="body2" fontWeight={700} color="inherit">
          {streak}
        </Typography>
      </Box>
    </Tooltip>
  );
}
