import { useState } from 'react';
import Box from '@mui/material/Box';
import Tab from '@mui/material/Tab';
import Tabs from '@mui/material/Tabs';
import Typography from '@mui/material/Typography';
import Paper from '@mui/material/Paper';
import Chip from '@mui/material/Chip';

const TYPE_LABELS = {
  affirmative: { label: 'Khẳng định (+)', color: 'success' },
  negative: { label: 'Phủ định (−)', color: 'error' },
  interrogative: { label: 'Nghi vấn (?)', color: 'info' },
};

export default function FormulaSection({ formulas }) {
  const [tab, setTab] = useState(0);

  if (!formulas.length) return null;

  const current = formulas[tab];

  return (
    <Box>
      <Typography variant="h6" gutterBottom>
        Công thức
      </Typography>

      <Tabs value={tab} onChange={(_, v) => setTab(v)} sx={{ mb: 2 }}>
        {formulas.map((f) => (
          <Tab key={f.type} label={TYPE_LABELS[f.type]?.label || f.type} />
        ))}
      </Tabs>

      <Paper variant="outlined" sx={{ p: 3 }}>
        <Typography
          variant="h5"
          sx={{ fontFamily: 'monospace', mb: 2, fontWeight: 600 }}
        >
          {current.structure}
        </Typography>

        {current.structure_vi && (
          <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
            {current.structure_vi}
          </Typography>
        )}

        {current.subject_note && (
          <Chip label={current.subject_note} size="small" sx={{ mb: 2 }} />
        )}

        <Paper sx={{ p: 2, bgcolor: 'action.hover' }}>
          <Typography variant="body1" sx={{ fontStyle: 'italic' }}>
            {current.example}
          </Typography>
          {current.example_vi && (
            <Typography variant="body2" color="text.secondary">
              → {current.example_vi}
            </Typography>
          )}
          {current.example_negative && (
            <Typography variant="body2" color="error.main" sx={{ mt: 1 }}>
              {current.example_negative}
            </Typography>
          )}
        </Paper>

        {current.note && (
          <Typography variant="body2" color="text.secondary" sx={{ mt: 2 }}>
            {current.note}
          </Typography>
        )}
      </Paper>
    </Box>
  );
}
