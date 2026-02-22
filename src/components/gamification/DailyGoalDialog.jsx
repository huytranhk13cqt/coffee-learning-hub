import { useState, useEffect } from 'react';
import Dialog from '@mui/material/Dialog';
import DialogTitle from '@mui/material/DialogTitle';
import DialogContent from '@mui/material/DialogContent';
import DialogActions from '@mui/material/DialogActions';
import Button from '@mui/material/Button';
import Slider from '@mui/material/Slider';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import Chip from '@mui/material/Chip';
import Snackbar from '@mui/material/Snackbar';
import Alert from '@mui/material/Alert';
import FlagIcon from '@mui/icons-material/Flag';
import { useGamification } from '../../hooks/useGamification.js';

const PRESETS = [3, 5, 10, 15, 20];

/**
 * Dialog for setting the daily exercise goal.
 * Reads/writes to GamificationContext — uses optimistic update pattern.
 * Handles error rollback + Snackbar notification.
 */
export default function DailyGoalDialog({ open, onClose }) {
  const { stats, updateDailyGoalTarget } = useGamification();
  const currentTarget = stats?.dailyGoal?.target ?? 5;

  const [sliderValue, setSliderValue] = useState(currentTarget);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState(null);

  // Sync slider when dialog opens (in case target changed elsewhere)
  useEffect(() => {
    if (open) {
      setSliderValue(currentTarget);
      setError(null);
    }
  }, [open, currentTarget]);

  async function handleSave() {
    if (sliderValue === currentTarget) {
      onClose();
      return;
    }
    setSaving(true);
    try {
      await updateDailyGoalTarget(sliderValue);
      onClose();
    } catch {
      setError('Không thể lưu mục tiêu. Vui lòng thử lại.');
    } finally {
      setSaving(false);
    }
  }

  return (
    <>
      <Dialog
        open={open}
        onClose={saving ? undefined : onClose}
        maxWidth="xs"
        fullWidth
        aria-labelledby="daily-goal-dialog-title"
      >
        <DialogTitle id="daily-goal-dialog-title">
          <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
            <FlagIcon sx={{ color: 'success.main' }} />
            Đặt mục tiêu hàng ngày
          </Box>
        </DialogTitle>

        <DialogContent>
          <Typography variant="body2" color="text.secondary" sx={{ mb: 3 }}>
            Chọn số bài tập bạn muốn hoàn thành mỗi ngày để duy trì thói quen
            học tập.
          </Typography>

          {/* Preset chips */}
          <Box sx={{ display: 'flex', gap: 1, flexWrap: 'wrap', mb: 3 }}>
            {PRESETS.map((preset) => (
              <Chip
                key={preset}
                label={`${preset} bài`}
                onClick={() => setSliderValue(preset)}
                color={sliderValue === preset ? 'success' : 'default'}
                variant={sliderValue === preset ? 'filled' : 'outlined'}
                size="small"
                clickable
              />
            ))}
          </Box>

          {/* Slider */}
          <Box sx={{ px: 1 }}>
            <Slider
              value={sliderValue}
              onChange={(_, val) => setSliderValue(val)}
              min={1}
              max={50}
              step={1}
              marks={[
                { value: 1, label: '1' },
                { value: 10, label: '10' },
                { value: 20, label: '20' },
                { value: 30, label: '30' },
                { value: 50, label: '50' },
              ]}
              valueLabelDisplay="on"
              color="success"
              aria-label="Mục tiêu bài tập hàng ngày"
            />
          </Box>

          <Typography
            variant="body1"
            fontWeight={700}
            textAlign="center"
            sx={{ mt: 1 }}
          >
            {sliderValue} bài tập / ngày
          </Typography>
        </DialogContent>

        <DialogActions sx={{ px: 3, pb: 2 }}>
          <Button onClick={onClose} disabled={saving}>
            Hủy
          </Button>
          <Button
            variant="contained"
            color="success"
            onClick={handleSave}
            loading={saving}
          >
            Lưu mục tiêu
          </Button>
        </DialogActions>
      </Dialog>

      <Snackbar
        open={!!error}
        autoHideDuration={4000}
        onClose={() => setError(null)}
        anchorOrigin={{ vertical: 'bottom', horizontal: 'center' }}
      >
        <Alert severity="error" onClose={() => setError(null)} variant="filled">
          {error}
        </Alert>
      </Snackbar>
    </>
  );
}
