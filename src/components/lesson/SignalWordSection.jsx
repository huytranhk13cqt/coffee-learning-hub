import { Box, Typography, Chip, Tooltip } from '@mui/material';

const CATEGORY_COLORS = {
  time: 'primary',
  frequency: 'secondary',
  duration: 'info',
  sequence: 'warning',
  other: 'default',
};

export default function SignalWordSection({ signalWords }) {
  if (!signalWords.length) return null;

  return (
    <Box>
      <Typography variant="h6" gutterBottom>
        Dấu hiệu nhận biết
      </Typography>

      <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 1 }}>
        {signalWords.map((sw) => (
          <Tooltip
            key={sw.id}
            title={
              <>
                {sw.word_vi && <div>{sw.word_vi}</div>}
                {sw.example_sentence && (
                  <div style={{ fontStyle: 'italic', marginTop: 4 }}>
                    {sw.example_sentence}
                  </div>
                )}
              </>
            }
            arrow
          >
            <Chip
              label={sw.word}
              color={CATEGORY_COLORS[sw.category] || 'default'}
              variant="outlined"
            />
          </Tooltip>
        ))}
      </Box>
    </Box>
  );
}
