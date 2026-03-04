import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import IconButton from '@mui/material/IconButton';
import AddIcon from '@mui/icons-material/Add';
import DeleteIcon from '@mui/icons-material/Delete';
import AdminFormField from '../AdminFormField.jsx';

export default function MatchingEditor({ form, setForm, errors }) {
  function handleAddPair() {
    setForm((prev) => ({
      ...prev,
      matching_pairs: [
        ...prev.matching_pairs,
        {
          left_content: '',
          left_content_vi: '',
          right_content: '',
          right_content_vi: '',
        },
      ],
    }));
  }

  function handleRemovePair(index) {
    setForm((prev) => ({
      ...prev,
      matching_pairs: prev.matching_pairs.filter((_, i) => i !== index),
    }));
  }

  function handlePairField(index, field, value) {
    setForm((prev) => ({
      ...prev,
      matching_pairs: prev.matching_pairs.map((pair, i) =>
        i === index ? { ...pair, [field]: value } : pair,
      ),
    }));
  }

  return (
    <Box>
      {form.matching_pairs.map((pair, idx) => (
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
          <Box sx={{ display: 'flex', alignItems: 'center', gap: 1, mb: 1 }}>
            <AdminFormField
              label="Left"
              value={pair.left_content}
              onChange={(e) =>
                handlePairField(idx, 'left_content', e.target.value)
              }
              sx={{ flex: 1, mb: 0 }}
            />
            <AdminFormField
              label="Left (VI)"
              value={pair.left_content_vi}
              onChange={(e) =>
                handlePairField(idx, 'left_content_vi', e.target.value)
              }
              sx={{ flex: 1, mb: 0 }}
            />
            <Typography variant="body2" sx={{ px: 1 }}>
              ↔
            </Typography>
            <AdminFormField
              label="Right"
              value={pair.right_content}
              onChange={(e) =>
                handlePairField(idx, 'right_content', e.target.value)
              }
              sx={{ flex: 1, mb: 0 }}
            />
            <AdminFormField
              label="Right (VI)"
              value={pair.right_content_vi}
              onChange={(e) =>
                handlePairField(idx, 'right_content_vi', e.target.value)
              }
              sx={{ flex: 1, mb: 0 }}
            />
            <IconButton
              size="small"
              color="error"
              onClick={() => handleRemovePair(idx)}
              disabled={form.matching_pairs.length <= 2}
              title="Remove"
            >
              <DeleteIcon fontSize="small" />
            </IconButton>
          </Box>
        </Box>
      ))}

      <Button
        size="small"
        startIcon={<AddIcon />}
        onClick={handleAddPair}
        disabled={form.matching_pairs.length >= 10}
      >
        Add Pair
      </Button>

      {errors.matching_pairs && (
        <Typography
          color="error"
          variant="caption"
          sx={{ display: 'block', mt: 1 }}
        >
          {errors.matching_pairs}
        </Typography>
      )}
    </Box>
  );
}
