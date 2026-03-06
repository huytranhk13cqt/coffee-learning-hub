import { useState, useCallback } from 'react';
import { Link as RouterLink } from 'react-router';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Paper from '@mui/material/Paper';
import Button from '@mui/material/Button';
import Stack from '@mui/material/Stack';
import Alert from '@mui/material/Alert';
import Chip from '@mui/material/Chip';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import Snackbar from '@mui/material/Snackbar';
import UploadFileIcon from '@mui/icons-material/UploadFile';
import CheckCircleIcon from '@mui/icons-material/CheckCircle';
import ErrorIcon from '@mui/icons-material/Error';
import ClearIcon from '@mui/icons-material/Clear';
import PublishIcon from '@mui/icons-material/Publish';
import VerifiedIcon from '@mui/icons-material/Verified';
import AdminFormField from '../../components/admin/AdminFormField.jsx';
import { validateYamlImport, executeYamlImport } from '../../api/admin.js';

export default function AdminYamlImportPage() {
  const [yaml, setYaml] = useState('');
  const [mode, setMode] = useState('upload'); // upload | paste
  const [validating, setValidating] = useState(false);
  const [importing, setImporting] = useState(false);
  const [validation, setValidation] = useState(null);
  const [importResult, setImportResult] = useState(null);
  const [snackbar, setSnackbar] = useState(null);

  const handleFileDrop = useCallback((e) => {
    e.preventDefault();
    const file = e.dataTransfer?.files?.[0] || e.target?.files?.[0];
    if (!file) return;
    if (!file.name.match(/\.ya?ml$/i)) {
      setSnackbar({
        severity: 'error',
        text: 'Only .yaml/.yml files accepted',
      });
      return;
    }
    const reader = new FileReader();
    reader.onload = (ev) => {
      setYaml(ev.target.result);
      setValidation(null);
      setImportResult(null);
    };
    reader.readAsText(file);
  }, []);

  function handleDragOver(e) {
    e.preventDefault();
  }

  function handleClear() {
    setYaml('');
    setValidation(null);
    setImportResult(null);
  }

  async function handleValidate() {
    if (!yaml.trim()) return;
    setValidating(true);
    setImportResult(null);
    try {
      const res = await validateYamlImport(yaml);
      setValidation(res);
    } catch (err) {
      setValidation({ valid: false, errors: [err.message] });
    } finally {
      setValidating(false);
    }
  }

  async function handleImport() {
    if (!yaml.trim()) return;
    setImporting(true);
    try {
      const res = await executeYamlImport(yaml);
      setImportResult(res);
      setSnackbar({ severity: 'success', text: 'Import successful!' });
    } catch (err) {
      setSnackbar({ severity: 'error', text: err.message });
    } finally {
      setImporting(false);
    }
  }

  const isValid = validation?.valid === true;

  return (
    <Box>
      <Typography variant="h2" sx={{ mb: 3 }}>
        YAML Import
      </Typography>

      {/* Upload / Paste toggle */}
      <Stack direction="row" spacing={1} sx={{ mb: 2 }}>
        <Chip
          label="Upload File"
          onClick={() => setMode('upload')}
          variant={mode === 'upload' ? 'filled' : 'outlined'}
          color={mode === 'upload' ? 'primary' : 'default'}
        />
        <Chip
          label="Paste YAML"
          onClick={() => setMode('paste')}
          variant={mode === 'paste' ? 'filled' : 'outlined'}
          color={mode === 'paste' ? 'primary' : 'default'}
        />
      </Stack>

      {/* Upload area */}
      {mode === 'upload' && (
        <Paper
          sx={{
            p: 4,
            mb: 3,
            textAlign: 'center',
            border: '2px dashed',
            borderColor: 'divider',
            cursor: 'pointer',
            '&:hover': { borderColor: 'primary.main' },
          }}
          onDrop={handleFileDrop}
          onDragOver={handleDragOver}
          onClick={() => document.getElementById('yaml-file-input').click()}
        >
          <UploadFileIcon
            sx={{ fontSize: 48, color: 'text.secondary', mb: 1 }}
          />
          <Typography variant="body1">
            Drag & drop a .yaml/.yml file here, or click to browse
          </Typography>
          <input
            id="yaml-file-input"
            type="file"
            accept=".yaml,.yml"
            onChange={handleFileDrop}
            style={{ display: 'none' }}
          />
        </Paper>
      )}

      {/* Paste area */}
      {mode === 'paste' && (
        <Paper sx={{ p: 3, mb: 3 }}>
          <AdminFormField
            label="Paste YAML Content"
            value={yaml}
            onChange={(e) => {
              setYaml(e.target.value);
              setValidation(null);
              setImportResult(null);
            }}
            multiline
            rows={12}
            placeholder="slug: my-lesson&#10;name: My Lesson&#10;..."
            sx={{ mb: 0, fontFamily: 'monospace' }}
            slotProps={{
              input: { sx: { fontFamily: 'monospace', fontSize: '0.85rem' } },
            }}
          />
        </Paper>
      )}

      {/* YAML preview (if uploaded via file) */}
      {yaml && mode === 'upload' && (
        <Paper sx={{ p: 2, mb: 3, maxHeight: 300, overflow: 'auto' }}>
          <Typography variant="subtitle2" sx={{ mb: 1 }}>
            File Content Preview
          </Typography>
          <Box
            component="pre"
            sx={{
              fontSize: '0.8rem',
              fontFamily: 'monospace',
              whiteSpace: 'pre-wrap',
              wordBreak: 'break-word',
            }}
          >
            {yaml.slice(0, 5000)}
            {yaml.length > 5000 && '\n... (truncated)'}
          </Box>
        </Paper>
      )}

      {/* Action buttons */}
      <Stack direction="row" spacing={2} sx={{ mb: 3 }}>
        <Button
          variant="contained"
          startIcon={<VerifiedIcon />}
          onClick={handleValidate}
          loading={validating}
          disabled={!yaml.trim()}
        >
          Validate
        </Button>
        <Button
          variant="contained"
          color="success"
          startIcon={<PublishIcon />}
          onClick={handleImport}
          loading={importing}
          disabled={!isValid}
        >
          Import
        </Button>
        {yaml && (
          <Button startIcon={<ClearIcon />} onClick={handleClear}>
            Clear
          </Button>
        )}
      </Stack>

      {/* Validation results */}
      {validation && (
        <Paper sx={{ p: 3, mb: 3 }}>
          <Typography variant="h4" sx={{ mb: 2 }}>
            Validation Result
          </Typography>

          {isValid ? (
            <>
              <Alert severity="success" sx={{ mb: 2 }}>
                YAML is valid and ready to import
              </Alert>
              {validation.summary && (
                <List dense>
                  <ListItem>
                    <ListItemIcon>
                      <CheckCircleIcon color="success" />
                    </ListItemIcon>
                    <ListItemText
                      primary={validation.summary.name}
                      secondary={`Type: ${validation.type}`}
                    />
                  </ListItem>
                  {validation.summary.sections != null && (
                    <ListItem>
                      <ListItemIcon>
                        <CheckCircleIcon color="success" />
                      </ListItemIcon>
                      <ListItemText
                        primary={`${validation.summary.sections} sections`}
                      />
                    </ListItem>
                  )}
                  {validation.summary.exercises != null && (
                    <ListItem>
                      <ListItemIcon>
                        <CheckCircleIcon color="success" />
                      </ListItemIcon>
                      <ListItemText
                        primary={`${validation.summary.exercises} exercises`}
                      />
                    </ListItem>
                  )}
                </List>
              )}
            </>
          ) : (
            <>
              <Alert severity="error" sx={{ mb: 2 }}>
                Validation failed — fix the errors below
              </Alert>
              <List dense>
                {(validation.errors || []).map((err, i) => (
                  <ListItem key={i}>
                    <ListItemIcon>
                      <ErrorIcon color="error" />
                    </ListItemIcon>
                    <ListItemText primary={err} />
                  </ListItem>
                ))}
              </List>
            </>
          )}
        </Paper>
      )}

      {/* Import result */}
      {importResult && (
        <Paper sx={{ p: 3 }}>
          <Alert severity="success" sx={{ mb: 2 }}>
            Successfully imported!
          </Alert>
          <Typography variant="body2" sx={{ mb: 1 }}>
            Type: <strong>{importResult.type}</strong> | Slug:{' '}
            <strong>{importResult.slug}</strong> | ID:{' '}
            <strong>{importResult.id}</strong>
          </Typography>
          {importResult.stats && (
            <Stack direction="row" spacing={1} sx={{ mb: 2 }}>
              {importResult.stats.sections != null && (
                <Chip
                  label={`${importResult.stats.sections} sections`}
                  size="small"
                  color="success"
                  variant="outlined"
                />
              )}
              {importResult.stats.exercises != null && (
                <Chip
                  label={`${importResult.stats.exercises} exercises`}
                  size="small"
                  color="success"
                  variant="outlined"
                />
              )}
            </Stack>
          )}
          {importResult.slug && (
            <Button
              component={RouterLink}
              to={`/lessons/${importResult.slug}`}
              variant="outlined"
              size="small"
            >
              View Lesson
            </Button>
          )}
        </Paper>
      )}

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
