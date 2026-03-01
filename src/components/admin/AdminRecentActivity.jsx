import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Typography from '@mui/material/Typography';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import Chip from '@mui/material/Chip';
import Box from '@mui/material/Box';
import MenuBookIcon from '@mui/icons-material/MenuBook';
import AssignmentIcon from '@mui/icons-material/Assignment';
import FolderOpenIcon from '@mui/icons-material/FolderOpen';
import CategoryIcon from '@mui/icons-material/Category';

const TYPE_ICONS = {
  lesson: MenuBookIcon,
  exercise: AssignmentIcon,
  topic: FolderOpenIcon,
  category: CategoryIcon,
};

const TYPE_COLORS = {
  lesson: 'primary',
  exercise: 'warning',
  topic: 'info',
  category: 'secondary',
};

function relativeTime(timestamp) {
  const now = Date.now();
  const diff = now - new Date(timestamp).getTime();
  const mins = Math.floor(diff / 60000);
  if (mins < 1) return 'just now';
  if (mins < 60) return `${mins}m ago`;
  const hours = Math.floor(mins / 60);
  if (hours < 24) return `${hours}h ago`;
  const days = Math.floor(hours / 24);
  if (days === 1) return 'yesterday';
  if (days < 30) return `${days}d ago`;
  return new Date(timestamp).toLocaleDateString();
}

export default function AdminRecentActivity({ activity }) {
  const items = activity?.data ?? activity ?? [];

  return (
    <Card>
      <CardContent>
        <Typography variant="h4" gutterBottom>
          Recent Activity
        </Typography>
        {items.length === 0 ? (
          <Typography variant="body2" color="text.secondary">
            No recent activity
          </Typography>
        ) : (
          <List disablePadding sx={{ maxHeight: 360, overflowY: 'auto' }}>
            {items.slice(0, 10).map((item, i) => {
              const Icon = TYPE_ICONS[item.type] || MenuBookIcon;
              return (
                <ListItem
                  key={`${item.type}-${item.id}-${i}`}
                  sx={{ px: 0 }}
                  secondaryAction={
                    <Chip
                      label={item.type}
                      size="small"
                      color={TYPE_COLORS[item.type] || 'default'}
                      variant="outlined"
                    />
                  }
                >
                  <ListItemIcon sx={{ minWidth: 36 }}>
                    <Icon fontSize="small" />
                  </ListItemIcon>
                  <ListItemText
                    primary={
                      <Typography variant="body2" noWrap sx={{ maxWidth: 180 }}>
                        {item.name}
                      </Typography>
                    }
                    secondary={
                      <Box component="span">
                        {item.action} {relativeTime(item.timestamp)}
                      </Box>
                    }
                  />
                </ListItem>
              );
            })}
          </List>
        )}
      </CardContent>
    </Card>
  );
}
