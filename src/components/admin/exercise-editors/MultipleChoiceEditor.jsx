import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import IconButton from '@mui/material/IconButton';
import Chip from '@mui/material/Chip';
import Radio from '@mui/material/Radio';
import Collapse from '@mui/material/Collapse';
import AddIcon from '@mui/icons-material/Add';
import DeleteIcon from '@mui/icons-material/Delete';
import AdminFormField from '../AdminFormField.jsx';
import { useState } from 'react';

const LABELS = ['A', 'B', 'C', 'D', 'E', 'F'];

export default function MultipleChoiceEditor({ form, setForm, errors }) {
  const [expandedIdx, setExpandedIdx] = useState(null);

  function handleAddOption() {
    setForm((prev) => {
      if (prev.options.length >= 6) return prev;
      return {
        ...prev,
        options: [
          ...prev.options,
          {
            label: LABELS[prev.options.length],
            content: '',
            content_vi: '',
            is_correct: false,
            explanation: '',
            explanation_vi: '',
          },
        ],
      };
    });
  }

  function handleRemoveOption(index) {
    setForm((prev) => {
      const newOptions = prev.options
        .filter((_, i) => i !== index)
        .map((opt, i) => ({ ...opt, label: LABELS[i] }));
      return { ...prev, options: newOptions };
    });
    if (expandedIdx === index) setExpandedIdx(null);
  }

  function handleCorrectChange(index) {
    setForm((prev) => ({
      ...prev,
      options: prev.options.map((opt, i) => ({
        ...opt,
        is_correct: i === index,
      })),
    }));
  }

  function handleOptionField(index, field, value) {
    setForm((prev) => ({
      ...prev,
      options: prev.options.map((opt, i) =>
        i === index ? { ...opt, [field]: value } : opt,
      ),
    }));
  }

  return (
    <Box>
      {form.options.map((option, idx) => (
        <Box
          key={idx}
          sx={{
            border: 1,
            borderColor: 'divider',
            borderRadius: 1,
            p: 2,
            mb: 1.5,
          }}
        >
          <Box
            sx={{
              display: 'flex',
              alignItems: 'center',
              gap: 1,
              mb: expandedIdx === idx ? 1.5 : 0,
            }}
          >
            <Chip label={option.label} size="small" color="primary" />
            <Radio
              checked={option.is_correct}
              onChange={() => handleCorrectChange(idx)}
              size="small"
            />
            <AdminFormField
              label="Content"
              value={option.content}
              onChange={(e) =>
                handleOptionField(idx, 'content', e.target.value)
              }
              sx={{ flex: 1, mb: 0 }}
            />
            <AdminFormField
              label="Content (VI)"
              value={option.content_vi}
              onChange={(e) =>
                handleOptionField(idx, 'content_vi', e.target.value)
              }
              sx={{ flex: 1, mb: 0 }}
            />
            <IconButton
              size="small"
              onClick={() =>
                setExpandedIdx((prev) => (prev === idx ? null : idx))
              }
              title="Explanation"
            >
              <Typography variant="caption">Exp</Typography>
            </IconButton>
            <IconButton
              size="small"
              color="error"
              onClick={() => handleRemoveOption(idx)}
              disabled={form.options.length <= 2}
              title="Remove"
            >
              <DeleteIcon fontSize="small" />
            </IconButton>
          </Box>

          <Collapse in={expandedIdx === idx}>
            <Box sx={{ display: 'flex', gap: 1 }}>
              <AdminFormField
                label="Explanation"
                value={option.explanation}
                onChange={(e) =>
                  handleOptionField(idx, 'explanation', e.target.value)
                }
                sx={{ flex: 1 }}
              />
              <AdminFormField
                label="Explanation (VI)"
                value={option.explanation_vi}
                onChange={(e) =>
                  handleOptionField(idx, 'explanation_vi', e.target.value)
                }
                sx={{ flex: 1 }}
              />
            </Box>
          </Collapse>
        </Box>
      ))}

      <Button
        size="small"
        startIcon={<AddIcon />}
        onClick={handleAddOption}
        disabled={form.options.length >= 6}
      >
        Add Option
      </Button>

      {errors.options && (
        <Typography
          color="error"
          variant="caption"
          sx={{ display: 'block', mt: 1 }}
        >
          {errors.options}
        </Typography>
      )}
    </Box>
  );
}
