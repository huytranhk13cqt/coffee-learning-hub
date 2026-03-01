import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import Chip from '@mui/material/Chip';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';

const LEVEL_COLORS = {
  healthy: 'success.main',
  warning: 'warning.main',
  critical: 'error.main',
};

const ISSUE_SECTIONS = [
  {
    key: 'lessons_without_exercises',
    label: 'Lessons without exercises',
    nameKey: 'name',
  },
  {
    key: 'lessons_without_sections',
    label: 'Lessons without sections',
    nameKey: 'name',
  },
  {
    key: 'categories_without_lessons',
    label: 'Empty categories',
    nameKey: 'name',
  },
  { key: 'topics_without_categories', label: 'Empty topics', nameKey: 'name' },
  { key: 'unpublished_lessons', label: 'Unpublished lessons', nameKey: 'name' },
];

export default function AdminContentHealth({ health }) {
  if (!health?.data && !health?.score) return null;
  const data = health.data || health;
  const { score } = data;

  return (
    <Card>
      <CardContent>
        <Box sx={{ display: 'flex', alignItems: 'center', gap: 1.5, mb: 2 }}>
          <Box
            sx={{
              width: 16,
              height: 16,
              borderRadius: '50%',
              bgcolor: LEVEL_COLORS[score?.level] || 'grey.500',
              flexShrink: 0,
            }}
          />
          <Typography variant="h4">Content Health</Typography>
          <Chip
            label={`${score?.total_issues ?? 0} issues`}
            size="small"
            color={
              score?.level === 'healthy'
                ? 'success'
                : score?.level === 'warning'
                  ? 'warning'
                  : 'error'
            }
          />
        </Box>

        {ISSUE_SECTIONS.map(({ key, label, nameKey }) => {
          const items = data[key];
          if (!items || items.length === 0) return null;
          return (
            <Box key={key} sx={{ mb: 2 }}>
              <Typography variant="subtitle2">
                {label} ({items.length})
              </Typography>
              <List dense disablePadding>
                {items.slice(0, 5).map((item) => (
                  <ListItem key={item.id} sx={{ px: 0 }}>
                    <ListItemText
                      primary={item[nameKey]}
                      secondary={item.category || item.topic || null}
                    />
                  </ListItem>
                ))}
                {items.length > 5 && (
                  <Typography variant="caption" color="text.secondary">
                    +{items.length - 5} more
                  </Typography>
                )}
              </List>
            </Box>
          );
        })}

        {score?.total_issues === 0 && (
          <Typography variant="body2" color="success.main">
            All content is healthy
          </Typography>
        )}
      </CardContent>
    </Card>
  );
}
