import { useState } from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Paper from '@mui/material/Paper';
import Button from '@mui/material/Button';
import Alert from '@mui/material/Alert';
import Snackbar from '@mui/material/Snackbar';
import SaveIcon from '@mui/icons-material/Save';
import AdminFormField from '../../components/admin/AdminFormField.jsx';
import { changeAdminPassword } from '../../api/admin.js';

export default function AdminSettingsPage() {
  const [form, setForm] = useState({ current: '', newPw: '', confirm: '' });
  const [saving, setSaving] = useState(false);
  const [errors, setErrors] = useState({});
  const [snackbar, setSnackbar] = useState(null);

  function handleChange(field) {
    return (e) => {
      setForm((prev) => ({ ...prev, [field]: e.target.value }));
      if (errors[field]) setErrors((prev) => ({ ...prev, [field]: null }));
    };
  }

  function validate() {
    const errs = {};
    if (!form.current) errs.current = 'Current password is required';
    if (!form.newPw) errs.newPw = 'New password is required';
    if (form.newPw && form.newPw.length < 8)
      errs.newPw = 'Minimum 8 characters';
    if (form.newPw !== form.confirm) errs.confirm = 'Passwords do not match';
    return errs;
  }

  async function handleSubmit() {
    const errs = validate();
    if (Object.keys(errs).length > 0) {
      setErrors(errs);
      return;
    }

    setSaving(true);
    try {
      const res = await changeAdminPassword(form.current, form.newPw);
      setForm({ current: '', newPw: '', confirm: '' });
      setSnackbar({
        severity: 'success',
        text: res.warning || 'Password changed successfully',
      });
    } catch (err) {
      setSnackbar({ severity: 'error', text: err.message });
    } finally {
      setSaving(false);
    }
  }

  return (
    <Box>
      <Typography variant="h2" sx={{ mb: 3 }}>
        Settings
      </Typography>

      <Paper sx={{ p: 3, mb: 3, maxWidth: 500 }}>
        <Typography variant="h4" sx={{ mb: 2 }}>
          Change Password
        </Typography>

        <AdminFormField
          label="Current Password"
          type="password"
          value={form.current}
          onChange={handleChange('current')}
          error={!!errors.current}
          helperText={errors.current}
          autoComplete="current-password"
        />
        <AdminFormField
          label="New Password"
          type="password"
          value={form.newPw}
          onChange={handleChange('newPw')}
          error={!!errors.newPw}
          helperText={errors.newPw}
          autoComplete="new-password"
        />
        <AdminFormField
          label="Confirm New Password"
          type="password"
          value={form.confirm}
          onChange={handleChange('confirm')}
          error={!!errors.confirm}
          helperText={errors.confirm}
          autoComplete="new-password"
        />

        <Button
          variant="contained"
          startIcon={<SaveIcon />}
          onClick={handleSubmit}
          loading={saving}
          sx={{ mt: 1 }}
        >
          Change Password
        </Button>
      </Paper>

      <Paper sx={{ p: 3, maxWidth: 500 }}>
        <Typography variant="h4" sx={{ mb: 2 }}>
          App Info
        </Typography>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 0.5 }}>
          Version: <strong>Phase 3 (dev)</strong>
        </Typography>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 0.5 }}>
          Schema: <strong>v24</strong>
        </Typography>
        <Typography variant="body2" color="text.secondary">
          Environment: <strong>{import.meta.env.MODE}</strong>
        </Typography>
      </Paper>

      <Snackbar
        open={!!snackbar}
        autoHideDuration={6000}
        onClose={() => setSnackbar(null)}
        anchorOrigin={{ vertical: 'bottom', horizontal: 'center' }}
      >
        {snackbar ? (
          <Alert
            onClose={() => setSnackbar(null)}
            severity={snackbar.severity}
            variant="filled"
          >
            {snackbar.text}
          </Alert>
        ) : undefined}
      </Snackbar>
    </Box>
  );
}
