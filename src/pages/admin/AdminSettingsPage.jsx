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
  getAllProviderStatus,
  setProviderApiKey,
  removeProviderApiKey,
} from '../../api/admin.js';

const IMAGE_PROVIDERS = [
  { id: 'gemini', label: 'Google Gemini', placeholder: 'AIza...' },
  { id: 'openai', label: 'OpenAI', placeholder: 'sk-...' },
  { id: 'stability', label: 'Stability AI', placeholder: 'sk-...' },
];

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

  // Image provider keys state — keyed by provider id
  const [providerStatus, setProviderStatus] = useState({});
  const [providerKeys, setProviderKeys] = useState({});
  const [providerSaving, setProviderSaving] = useState({});

  useEffect(() => {
    fetchApiKeyStatus()
      .then(setApiKeyStatus)
      .catch(() => setApiKeyStatus(null));
    getAllProviderStatus()
      .then((res) => setProviderStatus(res.providers || {}))
      .catch(() => setProviderStatus({}));
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

  // ─── Claude API Key handlers ──────────────────────────

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

  // ─── Image provider key handlers ──────────────────────

  async function handleSaveProviderKey(providerId) {
    const key = providerKeys[providerId]?.trim();
    if (!key) return;
    setProviderSaving((s) => ({ ...s, [providerId]: true }));
    try {
      const res = await setProviderApiKey(providerId, key);
      setProviderStatus((s) => ({ ...s, [providerId]: res }));
      setProviderKeys((k) => ({ ...k, [providerId]: '' }));
      setSnackbar({ severity: 'success', text: `${providerId} API key saved` });
    } catch (err) {
      setSnackbar({ severity: 'error', text: err.message });
    } finally {
      setProviderSaving((s) => ({ ...s, [providerId]: false }));
    }
  }

  async function handleRemoveProviderKey(providerId) {
    setProviderSaving((s) => ({ ...s, [providerId]: true }));
    try {
      await removeProviderApiKey(providerId);
      setProviderStatus((s) => ({
        ...s,
        [providerId]: { configured: false, maskedKey: null },
      }));
      setSnackbar({
        severity: 'success',
        text: `${providerId} API key removed`,
      });
    } catch (err) {
      setSnackbar({ severity: 'error', text: err.message });
    } finally {
      setProviderSaving((s) => ({ ...s, [providerId]: false }));
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
          Used by Content Generation. Key is stored in server memory only.
        </Typography>
      </Paper>

      {/* Image Generation Provider Keys */}
      <Paper sx={{ p: 3, mb: 3, maxWidth: 500 }}>
        <Typography variant="h4" sx={{ mb: 2 }}>
          Image Generation API Keys
        </Typography>

        <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
          Used by Asset Studio. Keys are stored in server memory only and reset
          when server restarts.
        </Typography>

        {IMAGE_PROVIDERS.map((p) => {
          const status = providerStatus[p.id];
          const isSaving = !!providerSaving[p.id];
          const keyValue = providerKeys[p.id] || '';

          return (
            <Box key={p.id} sx={{ mb: 2.5 }}>
              <Stack
                direction="row"
                spacing={1}
                alignItems="center"
                sx={{ mb: 1 }}
              >
                <Typography variant="subtitle2">{p.label}</Typography>
                {status?.configured ? (
                  <Chip
                    label={`Configured (${status.maskedKey})`}
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
                value={keyValue}
                onChange={(e) =>
                  setProviderKeys((k) => ({
                    ...k,
                    [p.id]: e.target.value,
                  }))
                }
                placeholder={p.placeholder}
                autoComplete="off"
              />

              <Stack direction="row" spacing={1}>
                <Button
                  size="small"
                  variant="contained"
                  startIcon={<SaveIcon />}
                  onClick={() => handleSaveProviderKey(p.id)}
                  loading={isSaving}
                  disabled={!keyValue.trim()}
                >
                  Save
                </Button>
                {status?.configured && (
                  <Button
                    size="small"
                    color="error"
                    startIcon={<DeleteIcon />}
                    onClick={() => handleRemoveProviderKey(p.id)}
                    loading={isSaving}
                  >
                    Remove
                  </Button>
                )}
              </Stack>
            </Box>
          );
        })}
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
          Version: <strong>Phase 5 (dev)</strong>
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
