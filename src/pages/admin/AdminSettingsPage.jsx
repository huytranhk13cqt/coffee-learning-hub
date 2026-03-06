import { useState, useEffect } from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Paper from '@mui/material/Paper';
import Button from '@mui/material/Button';
import Alert from '@mui/material/Alert';
import Snackbar from '@mui/material/Snackbar';
import Chip from '@mui/material/Chip';
import Stack from '@mui/material/Stack';
import SaveIcon from '@mui/icons-material/Save';
import DeleteIcon from '@mui/icons-material/Delete';
import AdminFormField from '../../components/admin/AdminFormField.jsx';
import {
  changeAdminPassword,
  fetchApiKeyStatus,
  setAdminApiKey,
  removeAdminApiKey,
  getGeminiApiKeyStatus,
  setGeminiApiKey,
  removeGeminiApiKey,
} from '../../api/admin.js';

export default function AdminSettingsPage() {
  // Password form
  const [form, setForm] = useState({ current: '', newPw: '', confirm: '' });
  const [saving, setSaving] = useState(false);
  const [errors, setErrors] = useState({});
  const [snackbar, setSnackbar] = useState(null);

  // Claude API Key state
  const [apiKeyStatus, setApiKeyStatus] = useState(null);
  const [newApiKey, setNewApiKey] = useState('');
  const [apiKeySaving, setApiKeySaving] = useState(false);

  // Gemini API Key state
  const [geminiKeyStatus, setGeminiKeyStatus] = useState(null);
  const [newGeminiKey, setNewGeminiKey] = useState('');
  const [geminiKeySaving, setGeminiKeySaving] = useState(false);

  useEffect(() => {
    fetchApiKeyStatus()
      .then(setApiKeyStatus)
      .catch(() => setApiKeyStatus(null));
    getGeminiApiKeyStatus()
      .then(setGeminiKeyStatus)
      .catch(() => setGeminiKeyStatus(null));
  }, []);

  // ─── Password handlers ──────────────────────────────

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

  // ─── API Key handlers ───────────────────────────────

  async function handleSaveApiKey() {
    if (!newApiKey.trim()) return;
    setApiKeySaving(true);
    try {
      const res = await setAdminApiKey(newApiKey.trim());
      setApiKeyStatus(res);
      setNewApiKey('');
      setSnackbar({ severity: 'success', text: 'API key saved' });
    } catch (err) {
      setSnackbar({ severity: 'error', text: err.message });
    } finally {
      setApiKeySaving(false);
    }
  }

  async function handleRemoveApiKey() {
    setApiKeySaving(true);
    try {
      await removeAdminApiKey();
      setApiKeyStatus({ configured: false, maskedKey: null });
      setSnackbar({ severity: 'success', text: 'API key removed' });
    } catch (err) {
      setSnackbar({ severity: 'error', text: err.message });
    } finally {
      setApiKeySaving(false);
    }
  }

  // ─── Gemini API Key handlers ──────────────────────────

  async function handleSaveGeminiKey() {
    if (!newGeminiKey.trim()) return;
    setGeminiKeySaving(true);
    try {
      const res = await setGeminiApiKey(newGeminiKey.trim());
      setGeminiKeyStatus(res);
      setNewGeminiKey('');
      setSnackbar({ severity: 'success', text: 'Gemini API key saved' });
    } catch (err) {
      setSnackbar({ severity: 'error', text: err.message });
    } finally {
      setGeminiKeySaving(false);
    }
  }

  async function handleRemoveGeminiKey() {
    setGeminiKeySaving(true);
    try {
      await removeGeminiApiKey();
      setGeminiKeyStatus({ configured: false, maskedKey: null });
      setSnackbar({ severity: 'success', text: 'Gemini API key removed' });
    } catch (err) {
      setSnackbar({ severity: 'error', text: err.message });
    } finally {
      setGeminiKeySaving(false);
    }
  }

  return (
    <Box>
      <Typography variant="h2" sx={{ mb: 3 }}>
        Settings
      </Typography>

      {/* Claude API Key */}
      <Paper sx={{ p: 3, mb: 3, maxWidth: 500 }}>
        <Typography variant="h4" sx={{ mb: 2 }}>
          Claude API Key
        </Typography>

        <Stack direction="row" spacing={1} alignItems="center" sx={{ mb: 2 }}>
          <Typography variant="body2" color="text.secondary">
            Status:
          </Typography>
          {apiKeyStatus?.configured ? (
            <Chip
              label={`Configured (${apiKeyStatus.maskedKey})`}
              color="success"
              size="small"
            />
          ) : (
            <Chip label="Not configured" size="small" />
          )}
        </Stack>

        <AdminFormField
          label="API Key"
          type="password"
          value={newApiKey}
          onChange={(e) => setNewApiKey(e.target.value)}
          placeholder="sk-ant-..."
          autoComplete="off"
        />

        <Stack direction="row" spacing={1}>
          <Button
            variant="contained"
            startIcon={<SaveIcon />}
            onClick={handleSaveApiKey}
            loading={apiKeySaving}
            disabled={!newApiKey.trim()}
          >
            Save Key
          </Button>
          {apiKeyStatus?.configured && (
            <Button
              color="error"
              startIcon={<DeleteIcon />}
              onClick={handleRemoveApiKey}
              loading={apiKeySaving}
            >
              Remove Key
            </Button>
          )}
        </Stack>

        <Typography
          variant="caption"
          color="text.secondary"
          sx={{ display: 'block', mt: 1.5 }}
        >
          Key is stored in server memory only. Resets when server restarts. Set
          ANTHROPIC_API_KEY env var for persistence.
        </Typography>
      </Paper>

      {/* Gemini API Key */}
      <Paper sx={{ p: 3, mb: 3, maxWidth: 500 }}>
        <Typography variant="h4" sx={{ mb: 2 }}>
          Gemini API Key
        </Typography>

        <Stack direction="row" spacing={1} alignItems="center" sx={{ mb: 2 }}>
          <Typography variant="body2" color="text.secondary">
            Status:
          </Typography>
          {geminiKeyStatus?.configured ? (
            <Chip
              label={`Configured (${geminiKeyStatus.maskedKey})`}
              color="success"
              size="small"
            />
          ) : (
            <Chip label="Not configured" size="small" />
          )}
        </Stack>

        <AdminFormField
          label="API Key"
          type="password"
          value={newGeminiKey}
          onChange={(e) => setNewGeminiKey(e.target.value)}
          placeholder="AIza..."
          autoComplete="off"
        />

        <Stack direction="row" spacing={1}>
          <Button
            variant="contained"
            startIcon={<SaveIcon />}
            onClick={handleSaveGeminiKey}
            loading={geminiKeySaving}
            disabled={!newGeminiKey.trim()}
          >
            Save Key
          </Button>
          {geminiKeyStatus?.configured && (
            <Button
              color="error"
              startIcon={<DeleteIcon />}
              onClick={handleRemoveGeminiKey}
              loading={geminiKeySaving}
            >
              Remove Key
            </Button>
          )}
        </Stack>

        <Typography
          variant="caption"
          color="text.secondary"
          sx={{ display: 'block', mt: 1.5 }}
        >
          Used by Asset Studio for AI image generation. Key is stored in server
          memory only. Set GEMINI_API_KEY env var for persistence.
        </Typography>
      </Paper>

      {/* Change Password */}
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
          Version: <strong>Phase 4 (dev)</strong>
        </Typography>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 0.5 }}>
          Schema: <strong>v25</strong>
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
