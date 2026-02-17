import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';

/**
 * Highlight a specific word within text using theme primary color.
 * Returns the original string unchanged if the word is not found.
 */
function highlightText(text, word) {
  if (!word || !text) return text;
  const escaped = word.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  const parts = text.split(new RegExp(`(${escaped})`, 'i'));
  if (parts.length === 1) return text;
  return parts.map((part, i) =>
    part.toLowerCase() === word.toLowerCase() ? (
      <Box
        component="span"
        key={i}
        sx={{ color: 'primary.main', fontWeight: 700 }}
      >
        {part}
      </Box>
    ) : (
      <span key={i}>{part}</span>
    ),
  );
}

export default function UsageSection({ usages }) {
  if (!usages.length) return null;

  return (
    <Box>
      <Typography variant="h6" component="h2" gutterBottom>
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
                    <ListItem
                      key={ex.id}
                      sx={{
                        px: 0,
                        ...(ex.audio_url && {
                          flexDirection: 'column',
                          alignItems: 'flex-start',
                        }),
                      }}
                    >
                      <ListItemText
                        primary={highlightText(ex.sentence, ex.highlight_word)}
                        secondary={ex.sentence_vi}
                        slotProps={{
                          primary: { sx: { fontStyle: 'italic' } },
                        }}
                      />
                      {ex.audio_url && (
                        <Box
                          component="audio"
                          controls
                          src={ex.audio_url}
                          aria-label={`Nghe phát âm: ${ex.sentence}`}
                          sx={{
                            mt: 0.5,
                            height: 32,
                            maxWidth: 300,
                          }}
                        />
                      )}
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
