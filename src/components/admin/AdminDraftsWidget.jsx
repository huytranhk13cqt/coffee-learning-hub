import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Typography from '@mui/material/Typography';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';
import Chip from '@mui/material/Chip';
import Box from '@mui/material/Box';

export default function AdminDraftsWidget({ drafts }) {
  const items = drafts?.data ?? drafts ?? [];

  return (
    <Card>
      <CardContent>
        <Box sx={{ display: 'flex', alignItems: 'center', gap: 1, mb: 1 }}>
          <Typography variant="h4">Drafts</Typography>
          {items.length > 0 && (
            <Chip label={items.length} size="small" color="warning" />
          )}
        </Box>

        {items.length === 0 ? (
          <Typography variant="body2" color="text.secondary">
            No incomplete lessons
          </Typography>
        ) : (
          <>
            <List disablePadding sx={{ maxHeight: 320, overflowY: 'auto' }}>
              {items.slice(0, 8).map((draft) => {
                const missing = [];
                if (draft.exercise_count === 0) missing.push('exercises');
                if (draft.section_count === 0) missing.push('sections');
                return (
                  <ListItem key={draft.id} sx={{ px: 0 }}>
                    <ListItemText
                      primary={draft.name}
                      secondary={
                        <Box component="span">
                          {draft.category} &middot; {draft.exercise_count}{' '}
                          exercises / {draft.section_count} sections
                        </Box>
                      }
                    />
                    {missing.length > 0 && (
                      <Chip
                        label={`No ${missing.join(', ')}`}
                        size="small"
                        color="error"
                        variant="outlined"
                      />
                    )}
                  </ListItem>
                );
              })}
            </List>
            <Typography
              variant="caption"
              color="text.secondary"
              sx={{ mt: 1, display: 'block' }}
            >
              Lessons missing exercises or sections
            </Typography>
          </>
        )}
      </CardContent>
    </Card>
  );
}
