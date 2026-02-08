import {
  Box,
  Typography,
  Card,
  CardContent,
  List,
  ListItem,
  ListItemText,
} from '@mui/material';

export default function UsageSection({ usages }) {
  if (!usages.length) return null;

  return (
    <Box>
      <Typography variant="h6" gutterBottom>
        Cách sử dụng
      </Typography>

      <Box sx={{ display: 'flex', flexDirection: 'column', gap: 2 }}>
        {usages.map((usage) => (
          <Card key={usage.id} variant="outlined">
            <CardContent>
              <Typography variant="subtitle1" fontWeight={600}>
                {usage.title}
              </Typography>
              {usage.title_vi && (
                <Typography variant="body2" color="text.secondary" gutterBottom>
                  {usage.title_vi}
                </Typography>
              )}

              <Typography variant="body2" sx={{ mt: 1 }}>
                {usage.description_vi || usage.description}
              </Typography>

              {usage.examples.length > 0 && (
                <List dense sx={{ mt: 1 }}>
                  {usage.examples.map((ex) => (
                    <ListItem key={ex.id} sx={{ px: 0 }}>
                      <ListItemText
                        primary={ex.sentence}
                        secondary={ex.sentence_vi}
                        slotProps={{
                          primary: { sx: { fontStyle: 'italic' } },
                        }}
                      />
                    </ListItem>
                  ))}
                </List>
              )}
            </CardContent>
          </Card>
        ))}
      </Box>
    </Box>
  );
}
