import { useState, useEffect, useRef, useMemo } from 'react';
import Chip from '@mui/material/Chip';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Paper from '@mui/material/Paper';

export default function ArrangeWords({
  exercise,
  answer: _answer,
  onAnswerChange,
  disabled,
}) {
  const wordBank = useMemo(
    () => exercise.word_bank || [],
    [exercise.word_bank],
  );
  const onAnswerChangeRef = useRef(onAnswerChange);

  useEffect(() => {
    onAnswerChangeRef.current = onAnswerChange;
  });

  // Track selected words as ordered indices
  const [selectedIndices, setSelectedIndices] = useState([]);

  // Sync answer string from selected words
  useEffect(() => {
    const sentence = selectedIndices.map((i) => wordBank[i]).join(' ');
    onAnswerChangeRef.current(sentence || null);
  }, [selectedIndices, wordBank]);

  const handleSelect = (index) => {
    if (disabled) return;
    setSelectedIndices((prev) => [...prev, index]);
  };

  const handleRemove = (positionInAnswer) => {
    if (disabled) return;
    setSelectedIndices((prev) => prev.filter((_, i) => i !== positionInAnswer));
  };

  return (
    <Box>
      {/* Answer area */}
      <Paper
        variant="outlined"
        sx={{
          p: 2,
          mb: 2,
          minHeight: 56,
          display: 'flex',
          flexWrap: 'wrap',
          gap: 1,
        }}
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
