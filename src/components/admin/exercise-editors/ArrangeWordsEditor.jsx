import { useState } from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import Chip from '@mui/material/Chip';
import AdminFormField from '../AdminFormField.jsx';

export default function ArrangeWordsEditor({ form, setForm, errors }) {
  const [newWord, setNewWord] = useState('');

  function handleAutoSplit() {
    setForm((prev) => {
      const words = prev.correct_answer.trim().split(/\s+/).filter(Boolean);
      return { ...prev, word_bank: words };
    });
  }

  function handleAddWord() {
    if (!newWord.trim()) return;
    setForm((prev) => ({
      ...prev,
      word_bank: [...prev.word_bank, newWord.trim()],
    }));
    setNewWord('');
  }

  function handleRemoveWord(index) {
    setForm((prev) => ({
      ...prev,
      word_bank: prev.word_bank.filter((_, i) => i !== index),
    }));
  }

  return (
    <Box>
      <AdminFormField
        label="Correct Answer (expected sentence)"
        value={form.correct_answer}
        onChange={(e) =>
          setForm((prev) => ({ ...prev, correct_answer: e.target.value }))
        }
        error={!!errors.correct_answer}
        helperText={errors.correct_answer}
      />

      <Typography variant="subtitle2" sx={{ mb: 1 }}>
        Word Bank
      </Typography>

      <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 0.5, mb: 1.5 }}>
        {form.word_bank.map((word, idx) => (
          <Chip
            key={idx}
            label={word}
            size="small"
            onDelete={() => handleRemoveWord(idx)}
          />
        ))}
        {form.word_bank.length === 0 && (
          <Typography variant="caption" color="text.secondary">
            No words yet
          </Typography>
        )}
      </Box>

      <Box sx={{ display: 'flex', gap: 1, mb: 1.5 }}>
        <AdminFormField
          label="Add word"
          value={newWord}
          onChange={(e) => setNewWord(e.target.value)}
          onKeyDown={(e) => {
            if (e.key === 'Enter') {
              e.preventDefault();
              handleAddWord();
            }
          }}
          sx={{ flex: 1, mb: 0 }}
        />
        <Button size="small" variant="outlined" onClick={handleAddWord}>
          Add
        </Button>
        <Button
          size="small"
          variant="outlined"
          onClick={handleAutoSplit}
          disabled={!form.correct_answer.trim()}
        >
          Auto-split from answer
        </Button>
      </Box>

      <Typography variant="caption" color="text.secondary">
        Add extra distractor words to increase difficulty
      </Typography>

      {errors.word_bank && (
        <Typography
          color="error"
          variant="caption"
          sx={{ display: 'block', mt: 1 }}
        >
          {errors.word_bank}
        </Typography>
      )}
    </Box>
  );
}
