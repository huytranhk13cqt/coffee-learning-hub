import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import Tooltip from '@mui/material/Tooltip';
import { PixelFrame } from '../pixel/index.js';
import { AddIcon, UploadFileIcon } from '../pixel/icons.jsx';

const ACTIONS = [
  { label: '+ Topic', tooltip: 'Coming in Phase 2' },
  { label: '+ Lesson', tooltip: 'Coming in Phase 2' },
  { label: '+ Exercise', tooltip: 'Coming in Phase 2' },
  { label: 'Import YAML', tooltip: 'Coming in Phase 2', icon: UploadFileIcon },
];

export default function AdminQuickCreate() {
  return (
    <PixelFrame variant="raised" sx={{ p: 3 }}>
      <Typography variant="h4" gutterBottom>
        Quick Actions
      </Typography>
      <Box sx={{ display: 'flex', gap: 2, flexWrap: 'wrap' }}>
        {ACTIONS.map(({ label, tooltip, icon: Icon }) => (
          <Tooltip key={label} title={tooltip}>
            <span>
              <Button
                variant="outlined"
                disabled
                startIcon={Icon ? <Icon /> : <AddIcon />}
              >
                {label}
              </Button>
            </span>
          </Tooltip>
        ))}
      </Box>
    </PixelFrame>
  );
}
