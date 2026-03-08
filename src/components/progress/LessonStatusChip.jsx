import Chip from '@mui/material/Chip';
import { CheckCircleIcon, PlayCircleOutlineIcon } from '../pixel/icons.jsx';

const STATUS_CONFIG = {
  completed: {
    label: 'Hoàn thành',
    color: 'success',
    icon: <CheckCircleIcon />,
  },
  in_progress: {
    label: 'Đang học',
    color: 'warning',
    icon: <PlayCircleOutlineIcon />,
  },
};

export default function LessonStatusChip({ status, size = 'small' }) {
  const config = STATUS_CONFIG[status];
  if (!config) return null;

  return (
    <Chip
      label={config.label}
      color={config.color}
      icon={config.icon}
      size={size}
      variant="outlined"
    />
  );
}
