import { useState, useEffect, useRef } from 'react';
import Chip from '@mui/material/Chip';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Paper from '@mui/material/Paper';
import Stack from '@mui/material/Stack';

export default function Matching({
  exercise,
  answer: _answer,
  onAnswerChange,
  disabled,
}) {
  const leftItems = exercise.leftItems || [];
  const rightItems = exercise.rightItems || [];
  const onAnswerChangeRef = useRef(onAnswerChange);

  useEffect(() => {
    onAnswerChangeRef.current = onAnswerChange;
  });

  // Pairs: [{ leftId, rightId }]
  // Reset handled by key={exercise.id} on parent ExerciseRenderer
  const [pairs, setPairs] = useState([]);
  const [selectedLeft, setSelectedLeft] = useState(null);

  // Sync answer
  useEffect(() => {
    if (pairs.length === leftItems.length && pairs.length > 0) {
      onAnswerChangeRef.current(pairs);
    } else {
      onAnswerChangeRef.current(null);
    }
  }, [pairs, leftItems.length]);

  const pairedLeftIds = new Set(pairs.map((p) => p.leftId));
  const pairedRightIds = new Set(pairs.map((p) => p.rightId));

  const handleLeftClick = (id) => {
    if (disabled || pairedLeftIds.has(id)) return;
    setSelectedLeft(id);
  };

  const handleRightClick = (id) => {
    if (disabled || pairedRightIds.has(id) || selectedLeft === null) return;
    setPairs((prev) => [...prev, { leftId: selectedLeft, rightId: id }]);
    setSelectedLeft(null);
  };

  const handleRemovePair = (leftId) => {
    if (disabled) return;
    setPairs((prev) => prev.filter((p) => p.leftId !== leftId));
  };

  return (
    <Box>
      {/* Paired items display */}
      {pairs.length > 0 && (
        <Paper variant="outlined" sx={{ p: 1.5, mb: 2 }}>
          <Stack spacing={1}>
            {pairs.map((pair) => {
              const left = leftItems.find((l) => l.id === pair.leftId);
              const right = rightItems.find((r) => r.id === pair.rightId);
              return (
                <Box
                  key={pair.leftId}
                  sx={{ display: 'flex', alignItems: 'center', gap: 1 }}
                >
                  <Chip label={left?.content} color="primary" size="small" />
                  <Typography variant="body2">—</Typography>
                  <Chip label={right?.content} color="secondary" size="small" />
                  {!disabled && (
                    <Chip
                      label="x"
                      size="small"
                      variant="outlined"
                      onClick={() => handleRemovePair(pair.leftId)}
                      aria-label={`Xóa cặp ${left?.content} — ${right?.content}`}
                      sx={{ ml: 'auto', minWidth: 32 }}
                    />
                  )}
                </Box>
              );
            })}
          </Stack>
        </Paper>
      )}

      {/* Matching columns */}
      <Box sx={{ display: 'flex', gap: 3 }}>
        {/* Left column */}
        <Stack spacing={1} sx={{ flex: 1 }}>
          <Typography variant="caption" color="text.secondary" fontWeight={600}>
            Chọn bên trái trước
          </Typography>
          {leftItems.map((item) => {
            const isPaired = pairedLeftIds.has(item.id);
            const isSelected = selectedLeft === item.id;
            return (
              <Chip
                key={item.id}
                label={item.content}
                color={isSelected ? 'primary' : 'default'}
                variant={isPaired ? 'outlined' : 'filled'}
                onClick={() => handleLeftClick(item.id)}
                disabled={disabled || isPaired}
                aria-label={`Chọn ${item.content} để ghép cặp`}
                sx={{
                  opacity: isPaired ? 0.4 : 1,
                  justifyContent: 'flex-start',
                }}
              />
            );
          })}
        </Stack>

        {/* Right column */}
        <Stack spacing={1} sx={{ flex: 1 }}>
          <Typography variant="caption" color="text.secondary" fontWeight={600}>
            Rồi chọn bên phải
          </Typography>
          {rightItems.map((item) => {
            const isPaired = pairedRightIds.has(item.id);
            return (
              <Chip
                key={item.id}
                label={item.content}
                color={
                  selectedLeft !== null && !isPaired ? 'secondary' : 'default'
                }
                variant={isPaired ? 'outlined' : 'filled'}
                onClick={() => handleRightClick(item.id)}
                disabled={disabled || isPaired || selectedLeft === null}
                aria-label={`Ghép ${item.content} với mục đã chọn`}
                sx={{
                  opacity: isPaired ? 0.4 : 1,
                  justifyContent: 'flex-start',
                }}
              />
            );
          })}
        </Stack>
      </Box>
    </Box>
  );
}
