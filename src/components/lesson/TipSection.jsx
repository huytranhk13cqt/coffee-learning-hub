import { useState } from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Accordion from '@mui/material/Accordion';
import AccordionSummary from '@mui/material/AccordionSummary';
import AccordionDetails from '@mui/material/AccordionDetails';
import Chip from '@mui/material/Chip';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';

const CATEGORY_LABELS = {
  memory: 'Ghi nhớ',
  common_mistake: 'Lỗi thường gặp',
  comparison: 'So sánh',
  native_usage: 'Cách dùng tự nhiên',
  shortcut: 'Mẹo nhanh',
  general: 'Mẹo chung',
};

const IMPORTANCE_COLORS = {
  high: 'error',
  medium: 'warning',
  low: 'default',
};

export default function TipSection({ tips }) {
  const [expanded, setExpanded] = useState(false);

  if (!tips.length) return null;

  return (
    <Box>
      <Typography variant="h6" gutterBottom>
        Mẹo ghi nhớ
      </Typography>

      {tips.map((tip) => (
        <Accordion
          key={tip.id}
          expanded={expanded === tip.id}
          onChange={(_, isExpanded) => setExpanded(isExpanded ? tip.id : false)}
        >
          <AccordionSummary expandIcon={<ExpandMoreIcon />}>
            <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
              <Typography>
                {tip.title_vi || tip.title || CATEGORY_LABELS[tip.category]}
              </Typography>
              <Chip
                label={CATEGORY_LABELS[tip.category]}
                size="small"
                color={IMPORTANCE_COLORS[tip.importance] || 'default'}
                variant="outlined"
              />
            </Box>
          </AccordionSummary>
          <AccordionDetails>
            <Typography variant="body2">
              {tip.content_vi || tip.content}
            </Typography>
          </AccordionDetails>
        </Accordion>
      ))}
    </Box>
  );
}
