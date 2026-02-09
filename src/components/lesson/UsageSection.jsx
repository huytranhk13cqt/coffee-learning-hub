import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';

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
