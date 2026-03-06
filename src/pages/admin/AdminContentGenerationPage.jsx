import { useState, useReducer, useRef, useCallback } from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Paper from '@mui/material/Paper';
import Button from '@mui/material/Button';
import Stack from '@mui/material/Stack';
import MenuItem from '@mui/material/MenuItem';
import Switch from '@mui/material/Switch';
import FormControlLabel from '@mui/material/FormControlLabel';
import Slider from '@mui/material/Slider';
import Tooltip from '@mui/material/Tooltip';
import Collapse from '@mui/material/Collapse';
import IconButton from '@mui/material/IconButton';
import Alert from '@mui/material/Alert';
import CircularProgress from '@mui/material/CircularProgress';
import Chip from '@mui/material/Chip';
import PlayArrowIcon from '@mui/icons-material/PlayArrow';
import StopIcon from '@mui/icons-material/Stop';
import ContentCopyIcon from '@mui/icons-material/ContentCopy';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import ExpandLessIcon from '@mui/icons-material/ExpandLess';
import InfoOutlinedIcon from '@mui/icons-material/InfoOutlined';
import AdminFormField from '../../components/admin/AdminFormField.jsx';
import { streamGenerate, fetchApiKeyStatus } from '../../api/admin.js';

const MODELS = [
  {
    value: 'claude-sonnet-4-6',
    label: 'Claude Sonnet 4.6',
    inputCost: 3,
    outputCost: 15,
  },
  {
    value: 'claude-opus-4-6',
    label: 'Claude Opus 4.6',
    inputCost: 5,
    outputCost: 25,
  },
  {
    value: 'claude-haiku-4-5-20251001',
    label: 'Claude Haiku 4.5',
    inputCost: 1,
    outputCost: 5,
  },
];

const SYSTEM_TEMPLATES = [
  {
    label: 'Generate Exercises',
    value: `Generate exercises in YAML format for the Learning Hub platform. Available types: multiple_choice, fill_blank, error_correction, sentence_transform, arrange_words, matching, true_false, code_output. Include question, question_vi, correct_answer, options (for MC), explanation. Difficulty: easy/medium/hard.`,
  },
  {
    label: 'Generate Lesson Content',
    value: `Generate a complete YAML lesson file for the Learning Hub. Include: slug, name, name_vi, description, description_vi, sections (types: markdown, key_points, info_box), and exercises. Follow the lesson-schema.js format.`,
  },
  {
    label: 'Improve Existing Content',
    value: `Review and improve the following educational content for accuracy, clarity, and pedagogical effectiveness. Suggest corrections, better explanations, and additional examples. Return improved content in the same format.`,
  },
  {
    label: 'Translate (EN to VI)',
    value: `Translate the following educational content from English to Vietnamese. Maintain technical accuracy and natural Vietnamese phrasing. Preserve formatting and structure.`,
  },
  { label: 'Custom', value: '' },
];

// ─── Reducer FSM ────────────────────────────────────────────

const INITIAL_STATE = {
  status: 'idle', // idle | generating | done | error
  thinking: '',
  text: '',
  usage: null,
  error: null,
};

function generationReducer(state, action) {
  switch (action.type) {
    case 'START':
      return { ...INITIAL_STATE, status: 'generating' };
    case 'THINKING':
      return { ...state, thinking: state.thinking + action.text };
    case 'TEXT':
      return { ...state, text: state.text + action.text };
    case 'USAGE':
      return { ...state, usage: action.data };
    case 'DONE':
      return { ...state, status: 'done' };
    case 'ERROR':
      return { ...state, status: 'error', error: action.error };
    case 'RESET':
      return INITIAL_STATE;
    default:
      return state;
  }
}

// ─── Component ──────────────────────────────────────────────

export default function AdminContentGenerationPage() {
  const [model, setModel] = useState('claude-sonnet-4-6');
  const [thinking, setThinking] = useState(false);
  const [webSearch, setWebSearch] = useState(false);
  const [maxTokens, setMaxTokens] = useState(4096);
  const [systemPrompt, setSystemPrompt] = useState(SYSTEM_TEMPLATES[0].value);
  const [templateIdx, setTemplateIdx] = useState(0);
  const [userPrompt, setUserPrompt] = useState('');
  const [thinkingExpanded, setThinkingExpanded] = useState(false);
  const [apiKeyReady, setApiKeyReady] = useState(null);

  const [state, dispatch] = useReducer(generationReducer, INITIAL_STATE);
  const abortRef = useRef(null);

  // Check API key status on mount
  useState(() => {
    fetchApiKeyStatus()
      .then((res) => setApiKeyReady(res?.configured ?? false))
      .catch(() => setApiKeyReady(false));
  });

  function handleTemplateChange(e) {
    const idx = Number(e.target.value);
    setTemplateIdx(idx);
    setSystemPrompt(SYSTEM_TEMPLATES[idx].value);
  }

  const handleGenerate = useCallback(() => {
    dispatch({ type: 'START' });

    const controller = streamGenerate(
      {
        model,
        prompt: userPrompt,
        systemPrompt: systemPrompt || undefined,
        thinking,
        webSearch,
        maxTokens,
      },
      {
        onThinking: (data) => dispatch({ type: 'THINKING', text: data.text }),
        onText: (data) => dispatch({ type: 'TEXT', text: data.text }),
        onUsage: (data) => dispatch({ type: 'USAGE', data }),
        onDone: () => dispatch({ type: 'DONE' }),
        onError: (data) => dispatch({ type: 'ERROR', error: data.error }),
      },
    );

    abortRef.current = controller;
  }, [model, userPrompt, systemPrompt, thinking, webSearch, maxTokens]);

  function handleCancel() {
    abortRef.current?.abort();
    dispatch({ type: 'DONE' });
  }

  function handleCopy() {
    navigator.clipboard.writeText(state.text);
  }

  const selectedModel = MODELS.find((m) => m.value === model);
  const estimatedCost = selectedModel
    ? ((150 * selectedModel.inputCost + maxTokens * selectedModel.outputCost) /
        1_000_000) *
      (thinking ? 2 : 1)
    : 0;

  const isGenerating = state.status === 'generating';
  const canGenerate = apiKeyReady && userPrompt.trim() && !isGenerating;

  return (
    <Box>
      <Typography variant="h2" sx={{ mb: 3 }}>
        Content Generation
      </Typography>

      {apiKeyReady === false && (
        <Alert severity="warning" sx={{ mb: 3 }}>
          Claude API key not configured. Go to Settings to set it up.
        </Alert>
      )}

      {/* Configuration */}
      <Paper sx={{ p: 3, mb: 3 }}>
        <Typography variant="h4" sx={{ mb: 2 }}>
          Configuration
        </Typography>

        <Stack spacing={2}>
          <AdminFormField
            select
            label="Model"
            value={model}
            onChange={(e) => setModel(e.target.value)}
          >
            {MODELS.map((m) => (
              <MenuItem key={m.value} value={m.value}>
                {m.label} (${m.inputCost}/${m.outputCost} per MTok)
              </MenuItem>
            ))}
          </AdminFormField>

          <Stack direction="row" spacing={3} alignItems="center">
            <FormControlLabel
              control={
                <Switch
                  checked={thinking}
                  onChange={(e) => setThinking(e.target.checked)}
                />
              }
              label={
                <Stack direction="row" spacing={0.5} alignItems="center">
                  <span>Extended Thinking</span>
                  <Tooltip title="Enables deeper reasoning before answering. Uses more tokens but produces better results for complex tasks.">
                    <InfoOutlinedIcon
                      sx={{ fontSize: 16, color: 'text.secondary' }}
                    />
                  </Tooltip>
                </Stack>
              }
            />
            <FormControlLabel
              control={
                <Switch
                  checked={webSearch}
                  onChange={(e) => setWebSearch(e.target.checked)}
                />
              }
              label={
                <Stack direction="row" spacing={0.5} alignItems="center">
                  <span>Web Search</span>
                  <Tooltip title="$10 per 1,000 search queries. Allows Claude to search the web for current information.">
                    <InfoOutlinedIcon
                      sx={{ fontSize: 16, color: 'text.secondary' }}
                    />
                  </Tooltip>
                </Stack>
              }
            />
          </Stack>

          <Box>
            <Typography variant="body2" sx={{ mb: 1 }}>
              Max Tokens: <strong>{maxTokens.toLocaleString()}</strong>
            </Typography>
            <Slider
              value={maxTokens}
              onChange={(_, val) => setMaxTokens(val)}
              min={100}
              max={64000}
              step={100}
              valueLabelDisplay="auto"
            />
          </Box>

          <Typography variant="caption" color="text.secondary">
            Est. cost: ~${estimatedCost.toFixed(4)} (
            {thinking ? 'with thinking' : 'no thinking'})
          </Typography>
        </Stack>
      </Paper>

      {/* Prompts */}
      <Paper sx={{ p: 3, mb: 3 }}>
        <Typography variant="h4" sx={{ mb: 2 }}>
          Prompts
        </Typography>

        <AdminFormField
          select
          label="System Prompt Template"
          value={templateIdx}
          onChange={handleTemplateChange}
          sx={{ mb: 2 }}
        >
          {SYSTEM_TEMPLATES.map((t, i) => (
            <MenuItem key={i} value={i}>
              {t.label}
            </MenuItem>
          ))}
        </AdminFormField>

        <AdminFormField
          label="System Prompt"
          value={systemPrompt}
          onChange={(e) => {
            setSystemPrompt(e.target.value);
            setTemplateIdx(SYSTEM_TEMPLATES.length - 1);
          }}
          multiline
          rows={3}
          sx={{ mb: 2 }}
        />

        <AdminFormField
          label="User Prompt"
          value={userPrompt}
          onChange={(e) => setUserPrompt(e.target.value)}
          multiline
          rows={5}
          placeholder="Describe what content you want to generate..."
        />
      </Paper>

      {/* Generate button */}
      <Stack direction="row" spacing={2} sx={{ mb: 3 }}>
        {isGenerating ? (
          <Button
            variant="contained"
            color="error"
            startIcon={<StopIcon />}
            onClick={handleCancel}
          >
            Cancel
          </Button>
        ) : (
          <Button
            variant="contained"
            startIcon={<PlayArrowIcon />}
            onClick={handleGenerate}
            disabled={!canGenerate}
          >
            Generate
          </Button>
        )}
        {state.status === 'done' && (
          <Button onClick={() => dispatch({ type: 'RESET' })}>Reset</Button>
        )}
      </Stack>

      {/* Loading indicator */}
      {isGenerating && (
        <Stack direction="row" spacing={1} alignItems="center" sx={{ mb: 2 }}>
          <CircularProgress size={20} />
          <Typography variant="body2" color="text.secondary">
            Generating...
          </Typography>
        </Stack>
      )}

      {/* Error */}
      {state.status === 'error' && (
        <Alert severity="error" sx={{ mb: 3 }}>
          {state.error}
        </Alert>
      )}

      {/* Thinking output */}
      {state.thinking && (
        <Paper sx={{ p: 2, mb: 2, bgcolor: 'action.hover' }}>
          <Stack
            direction="row"
            spacing={1}
            alignItems="center"
            sx={{ cursor: 'pointer' }}
            onClick={() => setThinkingExpanded((p) => !p)}
          >
            <IconButton size="small">
              {thinkingExpanded ? <ExpandLessIcon /> : <ExpandMoreIcon />}
            </IconButton>
            <Typography variant="subtitle2">Thinking</Typography>
            <Chip
              label={`${state.thinking.length} chars`}
              size="small"
              variant="outlined"
            />
          </Stack>
          <Collapse in={thinkingExpanded}>
            <Box
              component="pre"
              sx={{
                mt: 1,
                fontSize: '0.8rem',
                fontFamily: 'monospace',
                whiteSpace: 'pre-wrap',
                wordBreak: 'break-word',
                maxHeight: 300,
                overflow: 'auto',
              }}
            >
              {state.thinking}
            </Box>
          </Collapse>
        </Paper>
      )}

      {/* Text output */}
      {state.text && (
        <Paper sx={{ p: 3, mb: 2 }}>
          <Stack
            direction="row"
            justifyContent="space-between"
            alignItems="center"
            sx={{ mb: 2 }}
          >
            <Typography variant="h4">Response</Typography>
            <Tooltip title="Copy to clipboard">
              <IconButton onClick={handleCopy} size="small">
                <ContentCopyIcon fontSize="small" />
              </IconButton>
            </Tooltip>
          </Stack>
          <Box
            component="pre"
            sx={{
              fontSize: '0.875rem',
              fontFamily: 'monospace',
              whiteSpace: 'pre-wrap',
              wordBreak: 'break-word',
              maxHeight: 600,
              overflow: 'auto',
            }}
          >
            {state.text}
          </Box>
        </Paper>
      )}

      {/* Usage info */}
      {state.usage && (
        <Paper sx={{ p: 2 }}>
          <Typography variant="subtitle2" sx={{ mb: 1 }}>
            Usage
          </Typography>
          <Stack direction="row" spacing={2}>
            <Chip
              label={`Input: ${state.usage.input_tokens?.toLocaleString() ?? '-'}`}
              size="small"
              variant="outlined"
            />
            <Chip
              label={`Output: ${state.usage.output_tokens?.toLocaleString() ?? '-'}`}
              size="small"
              variant="outlined"
            />
          </Stack>
        </Paper>
      )}
    </Box>
  );
}
