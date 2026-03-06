import { useState, useReducer, useCallback, useRef } from 'react';
import { useLoaderData } from 'react-router';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Paper from '@mui/material/Paper';
import Button from '@mui/material/Button';
import Stack from '@mui/material/Stack';
import Tabs from '@mui/material/Tabs';
import Tab from '@mui/material/Tab';
import Alert from '@mui/material/Alert';
import Chip from '@mui/material/Chip';
import MenuItem from '@mui/material/MenuItem';
import Slider from '@mui/material/Slider';
import Collapse from '@mui/material/Collapse';
import IconButton from '@mui/material/IconButton';
import Tooltip from '@mui/material/Tooltip';
import Snackbar from '@mui/material/Snackbar';
import Card from '@mui/material/Card';
import CardMedia from '@mui/material/CardMedia';
import CardContent from '@mui/material/CardContent';
import CardActions from '@mui/material/CardActions';
import Grid from '@mui/material/Grid';
import Dialog from '@mui/material/Dialog';
import DialogTitle from '@mui/material/DialogTitle';
import DialogContent from '@mui/material/DialogContent';
import DialogActions from '@mui/material/DialogActions';
import CircularProgress from '@mui/material/CircularProgress';
import Pagination from '@mui/material/Pagination';
import LinearProgress from '@mui/material/LinearProgress';
import AutoFixHighIcon from '@mui/icons-material/AutoFixHigh';
import UploadFileIcon from '@mui/icons-material/UploadFile';
import CollectionsIcon from '@mui/icons-material/Collections';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import ExpandLessIcon from '@mui/icons-material/ExpandLess';
import ContentCopyIcon from '@mui/icons-material/ContentCopy';
import DeleteIcon from '@mui/icons-material/Delete';
import RefreshIcon from '@mui/icons-material/Refresh';
import SaveIcon from '@mui/icons-material/Save';
import SearchIcon from '@mui/icons-material/Search';
import InputAdornment from '@mui/material/InputAdornment';
import AdminFormField from '../../components/admin/AdminFormField.jsx';
import {
  generateAsset,
  uploadAsset,
  listAssets,
  deleteAsset,
  getGeminiApiKeyStatus,
} from '../../api/admin.js';

// ─── Constants ──────────────────────────────────────────────

const MODELS = [
  {
    value: 'gemini-2.5-flash-image',
    label: 'Nano Banana (Free)',
    price: 'FREE',
    priceColor: 'success',
  },
  {
    value: 'gemini-3.1-flash-image-preview',
    label: 'Nano Banana 2',
    price: '$0.067/img',
    priceColor: 'default',
  },
  {
    value: 'imagen-4.0-fast-generate-001',
    label: 'Imagen 4 Fast',
    price: '$0.02/img',
    priceColor: 'default',
  },
  {
    value: 'imagen-4.0-generate-001',
    label: 'Imagen 4 Standard',
    price: '$0.04/img',
    priceColor: 'default',
  },
  {
    value: 'imagen-4.0-ultra-generate-001',
    label: 'Imagen 4 Ultra',
    price: '$0.06/img',
    priceColor: 'default',
  },
];

const PRESET_PROMPTS = [
  'Pixel art Bulbasaur idle sprite, 32x32, GBA style, transparent background',
  '16x16 pixel art UI icon set, retro game style',
  'Pixel art coffee cup sprite sheet, 32x32, cozy cafe style',
  'Pixel art landscape tilemap, 16x16 tiles, nature theme',
];

const ASSET_TYPES = ['sprite', 'icon', 'background', 'tilemap', 'illustration'];

const ASPECT_RATIOS = ['1:1', '3:4', '4:3', '16:9'];

const IMAGE_SIZES = ['512', '1024', '2048', '4096'];

const PIXELATED_STYLE = {
  imageRendering: 'pixelated',
};

// ─── Generate Tab Reducer ───────────────────────────────────

const GEN_INITIAL = {
  status: 'idle', // idle | generating | preview | saving | saved | error
  images: [],
  error: null,
};

function genReducer(state, action) {
  switch (action.type) {
    case 'START':
      return { ...GEN_INITIAL, status: 'generating' };
    case 'PREVIEW':
      return { ...state, status: 'preview', images: action.images };
    case 'SAVE_START':
      return { ...state, status: 'saving' };
    case 'SAVED':
      return { ...state, status: 'saved' };
    case 'ERROR':
      return { ...state, status: 'error', error: action.error };
    case 'RESET':
      return GEN_INITIAL;
    default:
      return state;
  }
}

// ─── Loader ─────────────────────────────────────────────────

export async function loader() {
  const [keyStatus, assetsRes] = await Promise.all([
    getGeminiApiKeyStatus().catch(() => ({ configured: false })),
    listAssets({ limit: 20 }).catch(() => ({ assets: [], total: 0 })),
  ]);
  return { keyStatus, initialAssets: assetsRes };
}

// ─── Component ──────────────────────────────────────────────

export default function AdminAssetStudioPage() {
  const { keyStatus, initialAssets } = useLoaderData();
  const [tab, setTab] = useState(0);
  const [snackbar, setSnackbar] = useState(null);
  const [apiKeyReady, setApiKeyReady] = useState(
    keyStatus?.configured ?? false,
  );

  return (
    <Box>
      <Typography variant="h2" sx={{ mb: 3 }}>
        Asset Studio
      </Typography>

      <Tabs
        value={tab}
        onChange={(_, v) => setTab(v)}
        sx={{ mb: 3, borderBottom: 1, borderColor: 'divider' }}
      >
        <Tab icon={<AutoFixHighIcon />} label="Generate" iconPosition="start" />
        <Tab icon={<UploadFileIcon />} label="Upload" iconPosition="start" />
        <Tab icon={<CollectionsIcon />} label="Gallery" iconPosition="start" />
      </Tabs>

      {tab === 0 && (
        <GenerateTab
          apiKeyReady={apiKeyReady}
          setApiKeyReady={setApiKeyReady}
          setSnackbar={setSnackbar}
        />
      )}
      {tab === 1 && <UploadTab setSnackbar={setSnackbar} />}
      {tab === 2 && (
        <GalleryTab initialAssets={initialAssets} setSnackbar={setSnackbar} />
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

// ─── Generate Tab ───────────────────────────────────────────

function GenerateTab({ apiKeyReady, setSnackbar }) {
  const [model, setModel] = useState(MODELS[0].value);
  const [prompt, setPrompt] = useState('');
  const [assetName, setAssetName] = useState('');
  const [assetType, setAssetType] = useState('sprite');
  const [aspectRatio, setAspectRatio] = useState('1:1');
  const [imageSize, setImageSize] = useState('1024');
  const [numImages, setNumImages] = useState(1);
  const [configOpen, setConfigOpen] = useState(false);

  const [state, dispatch] = useReducer(genReducer, GEN_INITIAL);

  const isImagen = model.startsWith('imagen-');
  const isGenerating = state.status === 'generating';
  const canGenerate = apiKeyReady && prompt.trim() && !isGenerating;

  const handleGenerate = useCallback(async () => {
    dispatch({ type: 'START' });
    try {
      const config = {
        aspectRatio,
        type: assetType,
      };
      if (isImagen) {
        config.numberOfImages = numImages;
      } else {
        config.imageSize = imageSize;
      }

      const res = await generateAsset({
        model,
        prompt,
        name: assetName || undefined,
        config,
      });
      dispatch({ type: 'PREVIEW', images: res.assets || [] });
    } catch (err) {
      dispatch({ type: 'ERROR', error: err.message });
    }
  }, [
    model,
    prompt,
    assetName,
    assetType,
    aspectRatio,
    imageSize,
    numImages,
    isImagen,
  ]);

  function handlePresetClick(preset) {
    setPrompt(preset);
  }

  function handleCopyImage(url) {
    navigator.clipboard.writeText(url);
    setSnackbar({ severity: 'success', text: 'Image URL copied' });
  }

  return (
    <Box>
      {!apiKeyReady && (
        <Alert severity="warning" sx={{ mb: 3 }}>
          Gemini API key not configured. Go to Settings to set it up.
        </Alert>
      )}

      {/* Model selector */}
      <Paper sx={{ p: 3, mb: 3 }}>
        <Typography variant="h4" sx={{ mb: 2 }}>
          Model
        </Typography>
        <Stack direction="row" spacing={1} flexWrap="wrap" useFlexGap>
          {MODELS.map((m) => (
            <Chip
              key={m.value}
              label={
                <Stack direction="row" spacing={0.5} alignItems="center">
                  <span>{m.label}</span>
                  <Chip
                    label={m.price}
                    size="small"
                    color={m.priceColor}
                    variant="outlined"
                    sx={{ height: 20, fontSize: '0.65rem' }}
                  />
                </Stack>
              }
              onClick={() => setModel(m.value)}
              variant={model === m.value ? 'filled' : 'outlined'}
              color={model === m.value ? 'primary' : 'default'}
              sx={{ py: 2.5 }}
            />
          ))}
        </Stack>
      </Paper>

      {/* Prompt */}
      <Paper sx={{ p: 3, mb: 3 }}>
        <Typography variant="h4" sx={{ mb: 2 }}>
          Prompt
        </Typography>

        <AdminFormField
          label="Image Prompt"
          value={prompt}
          onChange={(e) => setPrompt(e.target.value)}
          multiline
          rows={3}
          placeholder="Describe the pixel art you want to generate..."
        />

        <Typography
          variant="caption"
          color="text.secondary"
          sx={{ mb: 1, display: 'block' }}
        >
          Preset prompts:
        </Typography>
        <Stack direction="row" spacing={1} flexWrap="wrap" useFlexGap>
          {PRESET_PROMPTS.map((p, i) => (
            <Chip
              key={i}
              label={p.length > 50 ? p.slice(0, 50) + '...' : p}
              size="small"
              variant="outlined"
              onClick={() => handlePresetClick(p)}
              sx={{ cursor: 'pointer' }}
            />
          ))}
        </Stack>
      </Paper>

      {/* Config (collapsible) */}
      <Paper sx={{ p: 3, mb: 3 }}>
        <Stack
          direction="row"
          alignItems="center"
          spacing={1}
          sx={{ cursor: 'pointer' }}
          onClick={() => setConfigOpen((o) => !o)}
        >
          <IconButton size="small">
            {configOpen ? <ExpandLessIcon /> : <ExpandMoreIcon />}
          </IconButton>
          <Typography variant="h4">Configuration</Typography>
        </Stack>

        <Collapse in={configOpen}>
          <Stack spacing={2} sx={{ mt: 2 }}>
            <AdminFormField
              label="Asset Name"
              value={assetName}
              onChange={(e) => setAssetName(e.target.value)}
              placeholder="my-pixel-sprite"
            />

            <AdminFormField
              select
              label="Asset Type"
              value={assetType}
              onChange={(e) => setAssetType(e.target.value)}
            >
              {ASSET_TYPES.map((t) => (
                <MenuItem key={t} value={t}>
                  {t.charAt(0).toUpperCase() + t.slice(1)}
                </MenuItem>
              ))}
            </AdminFormField>

            <AdminFormField
              select
              label="Aspect Ratio"
              value={aspectRatio}
              onChange={(e) => setAspectRatio(e.target.value)}
            >
              {ASPECT_RATIOS.map((r) => (
                <MenuItem key={r} value={r}>
                  {r}
                </MenuItem>
              ))}
            </AdminFormField>

            {isImagen ? (
              <Box>
                <Typography variant="body2" sx={{ mb: 1 }}>
                  Number of images: <strong>{numImages}</strong>
                </Typography>
                <Slider
                  value={numImages}
                  onChange={(_, val) => setNumImages(val)}
                  min={1}
                  max={4}
                  step={1}
                  marks
                  valueLabelDisplay="auto"
                />
              </Box>
            ) : (
              <AdminFormField
                select
                label="Image Size"
                value={imageSize}
                onChange={(e) => setImageSize(e.target.value)}
              >
                {IMAGE_SIZES.map((s) => (
                  <MenuItem key={s} value={s}>
                    {s === '512'
                      ? '512px'
                      : s === '1024'
                        ? '1K'
                        : s === '2048'
                          ? '2K'
                          : '4K'}
                  </MenuItem>
                ))}
              </AdminFormField>
            )}
          </Stack>
        </Collapse>
      </Paper>

      {/* Action buttons */}
      <Stack direction="row" spacing={2} sx={{ mb: 3 }}>
        <Button
          variant="contained"
          startIcon={<AutoFixHighIcon />}
          onClick={handleGenerate}
          disabled={!canGenerate}
          loading={isGenerating}
        >
          Generate
        </Button>
        {(state.status === 'preview' || state.status === 'saved') && (
          <Button
            startIcon={<RefreshIcon />}
            onClick={handleGenerate}
            disabled={!canGenerate}
          >
            Regenerate
          </Button>
        )}
        {state.status !== 'idle' && (
          <Button onClick={() => dispatch({ type: 'RESET' })}>Reset</Button>
        )}
      </Stack>

      {/* Error */}
      {state.status === 'error' && (
        <Alert severity="error" sx={{ mb: 3 }}>
          {state.error}
        </Alert>
      )}

      {/* Preview */}
      {(state.status === 'preview' ||
        state.status === 'saving' ||
        state.status === 'saved') &&
        state.images.length > 0 && (
          <Paper sx={{ p: 3 }}>
            <Typography variant="h4" sx={{ mb: 2 }}>
              Generated Images
            </Typography>
            <Grid container spacing={2}>
              {state.images.map((img, i) => (
                <Grid size={{ xs: 12, sm: 6, md: 4 }} key={i}>
                  <Card>
                    <Box
                      sx={{
                        p: 2,
                        textAlign: 'center',
                        bgcolor: 'action.hover',
                      }}
                    >
                      {/* Actual size */}
                      <Box
                        component="img"
                        src={img.path}
                        alt={img.name || `Generated ${i + 1}`}
                        sx={{
                          maxWidth: '100%',
                          maxHeight: 200,
                          ...PIXELATED_STYLE,
                        }}
                      />
                    </Box>
                    {/* Scaled up preview */}
                    <Box sx={{ p: 2, textAlign: 'center' }}>
                      <Box
                        component="img"
                        src={img.path}
                        alt={`Scaled ${i + 1}`}
                        sx={{
                          width: '100%',
                          maxHeight: 300,
                          objectFit: 'contain',
                          ...PIXELATED_STYLE,
                        }}
                      />
                    </Box>
                    <CardActions>
                      <Tooltip title="Copy URL">
                        <IconButton
                          size="small"
                          onClick={() => handleCopyImage(img.path)}
                        >
                          <ContentCopyIcon fontSize="small" />
                        </IconButton>
                      </Tooltip>
                      {img.saved && (
                        <Chip
                          label="Saved"
                          size="small"
                          color="success"
                          variant="outlined"
                        />
                      )}
                    </CardActions>
                  </Card>
                </Grid>
              ))}
            </Grid>
            {state.status === 'saved' && (
              <Alert severity="success" sx={{ mt: 2 }}>
                Images saved to gallery
              </Alert>
            )}
          </Paper>
        )}
    </Box>
  );
}

// ─── Upload Tab ─────────────────────────────────────────────

function UploadTab({ setSnackbar }) {
  const [file, setFile] = useState(null);
  const [preview, setPreview] = useState(null);
  const [name, setName] = useState('');
  const [type, setType] = useState('sprite');
  const [tags, setTags] = useState('');
  const [uploading, setUploading] = useState(false);
  const [progress, setProgress] = useState(0);
  const fileInputRef = useRef(null);

  function handleFileDrop(e) {
    e.preventDefault();
    const f = e.dataTransfer?.files?.[0] || e.target?.files?.[0];
    if (!f) return;

    const validTypes = ['image/png', 'image/gif', 'image/webp'];
    if (!validTypes.includes(f.type)) {
      setSnackbar({
        severity: 'error',
        text: 'Only PNG, GIF, WebP files accepted',
      });
      return;
    }
    if (f.size > 5 * 1024 * 1024) {
      setSnackbar({ severity: 'error', text: 'File must be under 5MB' });
      return;
    }

    setFile(f);
    setName(f.name.replace(/\.[^.]+$/, ''));

    const reader = new FileReader();
    reader.onload = (ev) => setPreview(ev.target.result);
    reader.readAsDataURL(f);
  }

  function handleDragOver(e) {
    e.preventDefault();
  }

  function handleClear() {
    setFile(null);
    setPreview(null);
    setName('');
    setTags('');
    setProgress(0);
    if (fileInputRef.current) fileInputRef.current.value = '';
  }

  async function handleUpload() {
    if (!file) return;
    setUploading(true);
    setProgress(30);
    try {
      const formData = new FormData();
      formData.append('file', file);
      formData.append('name', name || file.name);
      formData.append('type', type);
      if (tags.trim()) formData.append('tags', tags.trim());

      setProgress(60);
      await uploadAsset(formData);
      setProgress(100);
      setSnackbar({ severity: 'success', text: 'Asset uploaded successfully' });
      handleClear();
    } catch (err) {
      setSnackbar({ severity: 'error', text: err.message });
    } finally {
      setUploading(false);
    }
  }

  return (
    <Box>
      {/* Drop zone */}
      <Paper
        sx={{
          p: 4,
          mb: 3,
          textAlign: 'center',
          border: '2px dashed',
          borderColor: file ? 'success.main' : 'divider',
          cursor: 'pointer',
          '&:hover': { borderColor: 'primary.main' },
        }}
        onDrop={handleFileDrop}
        onDragOver={handleDragOver}
        onClick={() => fileInputRef.current?.click()}
      >
        <UploadFileIcon sx={{ fontSize: 48, color: 'text.secondary', mb: 1 }} />
        <Typography variant="body1">
          Drag & drop a PNG, GIF, or WebP file here, or click to browse
        </Typography>
        <Typography variant="caption" color="text.secondary">
          Max 5MB
        </Typography>
        <input
          ref={fileInputRef}
          type="file"
          accept="image/png,image/gif,image/webp"
          onChange={handleFileDrop}
          style={{ display: 'none' }}
        />
      </Paper>

      {/* Preview + metadata */}
      {file && (
        <Paper sx={{ p: 3, mb: 3 }}>
          <Stack direction={{ xs: 'column', sm: 'row' }} spacing={3}>
            {/* Preview */}
            <Box sx={{ textAlign: 'center', minWidth: 200 }}>
              <Box
                component="img"
                src={preview}
                alt="Preview"
                sx={{
                  maxWidth: 200,
                  maxHeight: 200,
                  border: 1,
                  borderColor: 'divider',
                  ...PIXELATED_STYLE,
                }}
              />
              <Typography
                variant="caption"
                color="text.secondary"
                sx={{ display: 'block', mt: 1 }}
              >
                {file.name} ({(file.size / 1024).toFixed(1)} KB)
              </Typography>
            </Box>

            {/* Metadata form */}
            <Box sx={{ flex: 1 }}>
              <AdminFormField
                label="Asset Name"
                value={name}
                onChange={(e) => setName(e.target.value)}
              />
              <AdminFormField
                select
                label="Type"
                value={type}
                onChange={(e) => setType(e.target.value)}
              >
                {ASSET_TYPES.map((t) => (
                  <MenuItem key={t} value={t}>
                    {t.charAt(0).toUpperCase() + t.slice(1)}
                  </MenuItem>
                ))}
              </AdminFormField>
              <AdminFormField
                label="Tags"
                value={tags}
                onChange={(e) => setTags(e.target.value)}
                placeholder="pixel, retro, character (comma-separated)"
              />
            </Box>
          </Stack>

          {uploading && (
            <LinearProgress
              variant="determinate"
              value={progress}
              sx={{ mt: 2 }}
            />
          )}

          <Stack direction="row" spacing={2} sx={{ mt: 2 }}>
            <Button
              variant="contained"
              startIcon={<SaveIcon />}
              onClick={handleUpload}
              loading={uploading}
              disabled={!file || !name.trim()}
            >
              Upload
            </Button>
            <Button onClick={handleClear}>Clear</Button>
          </Stack>
        </Paper>
      )}
    </Box>
  );
}

// ─── Gallery Tab ────────────────────────────────────────────

function GalleryTab({ initialAssets, setSnackbar }) {
  const [assets, setAssets] = useState(initialAssets?.assets || []);
  const [total, setTotal] = useState(initialAssets?.total || 0);
  const [page, setPage] = useState(1);
  const [filterType, setFilterType] = useState('');
  const [search, setSearch] = useState('');
  const [loading, setLoading] = useState(false);
  const [selectedAsset, setSelectedAsset] = useState(null);
  const [deleteConfirm, setDeleteConfirm] = useState(null);
  const [deleting, setDeleting] = useState(false);
  const limit = 12;

  async function fetchAssets(p = page, t = filterType) {
    setLoading(true);
    try {
      const res = await listAssets({
        page: p,
        limit,
        type: t || undefined,
        tag: search.trim() || undefined,
      });
      setAssets(res.assets || []);
      setTotal(res.total || 0);
    } catch (err) {
      setSnackbar({ severity: 'error', text: err.message });
    } finally {
      setLoading(false);
    }
  }

  function handlePageChange(_, newPage) {
    setPage(newPage);
    fetchAssets(newPage);
  }

  function handleFilterChange(e) {
    const t = e.target.value;
    setFilterType(t);
    setPage(1);
    fetchAssets(1, t);
  }

  function handleSearch() {
    setPage(1);
    fetchAssets(1);
  }

  async function handleDelete(id) {
    setDeleting(true);
    try {
      await deleteAsset(id);
      setSnackbar({ severity: 'success', text: 'Asset deleted' });
      setDeleteConfirm(null);
      setSelectedAsset(null);
      fetchAssets();
    } catch (err) {
      setSnackbar({ severity: 'error', text: err.message });
    } finally {
      setDeleting(false);
    }
  }

  function copyToClipboard(text) {
    navigator.clipboard.writeText(text);
    setSnackbar({ severity: 'success', text: 'Copied to clipboard' });
  }

  const totalPages = Math.ceil(total / limit);

  return (
    <Box>
      {/* Filters */}
      <Stack direction="row" spacing={2} sx={{ mb: 3 }} alignItems="flex-end">
        <AdminFormField
          select
          label="Filter by type"
          value={filterType}
          onChange={handleFilterChange}
          sx={{ minWidth: 160, mb: 0 }}
        >
          <MenuItem value="">All Types</MenuItem>
          {ASSET_TYPES.map((t) => (
            <MenuItem key={t} value={t}>
              {t.charAt(0).toUpperCase() + t.slice(1)}
            </MenuItem>
          ))}
        </AdminFormField>

        <AdminFormField
          label="Search"
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          onKeyDown={(e) => e.key === 'Enter' && handleSearch()}
          sx={{ mb: 0 }}
          slotProps={{
            input: {
              endAdornment: (
                <InputAdornment position="end">
                  <IconButton size="small" onClick={handleSearch}>
                    <SearchIcon />
                  </IconButton>
                </InputAdornment>
              ),
            },
          }}
        />

        <Button
          startIcon={<RefreshIcon />}
          onClick={() => fetchAssets()}
          sx={{ minWidth: 'auto', mb: '0 !important' }}
        >
          Refresh
        </Button>
      </Stack>

      {loading && <LinearProgress sx={{ mb: 2 }} />}

      {/* Grid */}
      {assets.length === 0 && !loading ? (
        <Paper sx={{ p: 4, textAlign: 'center' }}>
          <Typography color="text.secondary">
            No assets found. Generate or upload some pixel art!
          </Typography>
        </Paper>
      ) : (
        <Grid container spacing={2}>
          {assets.map((asset) => (
            <Grid size={{ xs: 12, sm: 6, md: 4, lg: 3 }} key={asset.id}>
              <Card
                sx={{
                  cursor: 'pointer',
                  '&:hover': { boxShadow: 4 },
                  transition: 'box-shadow 0.2s',
                }}
                onClick={() => setSelectedAsset(asset)}
              >
                <Box
                  sx={{
                    height: 160,
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    bgcolor: 'action.hover',
                    overflow: 'hidden',
                  }}
                >
                  <CardMedia
                    component="img"
                    image={asset.path}
                    alt={asset.name}
                    sx={{
                      maxWidth: '80%',
                      maxHeight: '80%',
                      objectFit: 'contain',
                      ...PIXELATED_STYLE,
                    }}
                  />
                </Box>
                <CardContent sx={{ pb: 1 }}>
                  <Typography variant="subtitle2" noWrap>
                    {asset.name}
                  </Typography>
                  <Stack direction="row" spacing={0.5} alignItems="center">
                    <Chip
                      label={asset.type}
                      size="small"
                      variant="outlined"
                      sx={{ fontSize: '0.65rem' }}
                    />
                    {asset.width && asset.height && (
                      <Typography variant="caption" color="text.secondary">
                        {asset.width}x{asset.height}
                      </Typography>
                    )}
                  </Stack>
                </CardContent>
              </Card>
            </Grid>
          ))}
        </Grid>
      )}

      {/* Pagination */}
      {totalPages > 1 && (
        <Box sx={{ display: 'flex', justifyContent: 'center', mt: 3 }}>
          <Pagination
            count={totalPages}
            page={page}
            onChange={handlePageChange}
            color="primary"
          />
        </Box>
      )}

      {/* Asset Detail Dialog */}
      <Dialog
        open={!!selectedAsset}
        onClose={() => setSelectedAsset(null)}
        maxWidth="sm"
        fullWidth
      >
        {selectedAsset && (
          <>
            <DialogTitle>{selectedAsset.name}</DialogTitle>
            <DialogContent>
              <Box sx={{ textAlign: 'center', mb: 2 }}>
                <Box
                  component="img"
                  src={selectedAsset.path}
                  alt={selectedAsset.name}
                  sx={{
                    maxWidth: '100%',
                    maxHeight: 400,
                    ...PIXELATED_STYLE,
                  }}
                />
              </Box>

              <Stack spacing={1}>
                <Stack direction="row" spacing={1} alignItems="center">
                  <Chip label={selectedAsset.type} size="small" />
                  {selectedAsset.width && selectedAsset.height && (
                    <Typography variant="body2" color="text.secondary">
                      {selectedAsset.width}x{selectedAsset.height}
                    </Typography>
                  )}
                  {selectedAsset.file_size && (
                    <Typography variant="body2" color="text.secondary">
                      {(selectedAsset.file_size / 1024).toFixed(1)} KB
                    </Typography>
                  )}
                </Stack>

                {selectedAsset.created_at && (
                  <Typography variant="caption" color="text.secondary">
                    Created:{' '}
                    {new Date(selectedAsset.created_at).toLocaleDateString()}
                  </Typography>
                )}

                {/* Copy usage code buttons */}
                <Typography variant="subtitle2" sx={{ mt: 1 }}>
                  Usage
                </Typography>
                <Button
                  size="small"
                  startIcon={<ContentCopyIcon />}
                  onClick={() =>
                    copyToClipboard(
                      `<img src="${selectedAsset.path}" alt="${selectedAsset.name}" style={{ imageRendering: 'pixelated' }} />`,
                    )
                  }
                >
                  Copy img tag
                </Button>
                <Button
                  size="small"
                  startIcon={<ContentCopyIcon />}
                  onClick={() =>
                    copyToClipboard(
                      `<SpriteAnimation src="${selectedAsset.path}" frameWidth={${selectedAsset.width || 32}} frameHeight={${selectedAsset.height || 32}} frameCount={4} fps={4} scale={4} />`,
                    )
                  }
                >
                  Copy SpriteAnimation
                </Button>
              </Stack>
            </DialogContent>
            <DialogActions>
              <Button
                color="error"
                startIcon={<DeleteIcon />}
                onClick={() => setDeleteConfirm(selectedAsset)}
              >
                Delete
              </Button>
              <Button onClick={() => setSelectedAsset(null)}>Close</Button>
            </DialogActions>
          </>
        )}
      </Dialog>

      {/* Delete Confirmation Dialog */}
      <Dialog open={!!deleteConfirm} onClose={() => setDeleteConfirm(null)}>
        <DialogTitle>Delete Asset</DialogTitle>
        <DialogContent>
          <Typography>
            Are you sure you want to delete &quot;{deleteConfirm?.name}&quot;?
            This action cannot be undone.
          </Typography>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setDeleteConfirm(null)}>Cancel</Button>
          <Button
            color="error"
            variant="contained"
            onClick={() => handleDelete(deleteConfirm.id)}
            loading={deleting}
          >
            Delete
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
}
