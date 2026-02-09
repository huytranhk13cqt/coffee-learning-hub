import { useState, useEffect } from 'react';
import Chip from '@mui/material/Chip';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Paper from '@mui/material/Paper';

export default function ArrangeWords({ exercise, answer, onAnswerChange, disabled }) {
  const wordBank = exercise.word_bank || [];

  // Track selected words as ordered indices
  const [selectedIndices, setSelectedIndices] = useState([]);

  // Sync answer string from selected words
  useEffect(() => {
    const sentence = selectedIndices.map((i) => wordBank[i]).join(' ');
    onAnswerChange(sentence || null);
  }, [selectedIndices]);

  // Reset when exercise changes
  useEffect(() => {
    setSelectedIndices([]);
  }, [exercise.id]);

  const handleSelect = (index) => {
    if (disabled) return;
    setSelectedIndices((prev) => [...prev, index]);
  };

  const handleRemove = (positionInAnswer) => {
    if (disabled) return;
    setSelectedIndices((prev) => prev.filter((_, i) => i !== positionInAnswer));
  };

  const availableIndices = wordBank
    .map((_, i) => i)
    .filter((i) => !selectedIndices.includes(i));

  return (
    <Box>
      {/* Answer area */}
      <Paper
        variant="outlined"
        sx={{ p: 2, mb: 2, minHeight: 56, display: 'flex', flexWrap: 'wrap', gap: 1 }}
      >
        {selectedIndices.length === 0 ? (
          <Typography color="text.secondary" sx={{ fontStyle: 'italic' }}>
            Nhấp vào từ bên dưới để sắp xếp câu...
          </Typography>
        ) : (
          selectedIndices.map((wordIndex, posIndex) => (
            <Chip
              key={posIndex}
              label={wordBank[wordIndex]}
              color="primary"
              onClick={() => handleRemove(posIndex)}
              disabled={disabled}
            />
          ))
        )}
      </Paper>

      {/* Word bank */}
      <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 1 }}>
        {wordBank.map((word, i) => {
          const isUsed = selectedIndices.includes(i);
          return (
            <Chip
              key={i}
              label={word}
              variant={isUsed ? 'outlined' : 'filled'}
              color={isUsed ? 'default' : 'primary'}
              onClick={() => !isUsed && handleSelect(i)}
              disabled={disabled || isUsed}
              sx={{ opacity: isUsed ? 0.4 : 1 }}
            />
          );
        })}
      </Box>
    </Box>
  );
}
