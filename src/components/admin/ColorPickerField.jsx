import { useState } from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import TextField from '@mui/material/TextField';
import ButtonBase from '@mui/material/ButtonBase';
import Tooltip from '@mui/material/Tooltip';
import { PALETTE_SWATCHES } from '../../theme/palette.js';

const HEX_REGEX = /^#[0-9A-Fa-f]{6}$/;

export default function ColorPickerField({
  value,
  onChange,
  label,
  error,
  helperText,
}) {
  const [inputValue, setInputValue] = useState(value || '');
  const [prevValue, setPrevValue] = useState(value);

  if (value !== prevValue) {
    setPrevValue(value);
    setInputValue(value || '');
  }

  function handleSwatchClick(hex) {
    setInputValue(hex);
    onChange(hex);
  }

  function handleInputChange(e) {
    const v = e.target.value;
    setInputValue(v);
    if (HEX_REGEX.test(v)) {
      onChange(v);
    }
  }

  return (
    <Box sx={{ mb: 2 }}>
      {label && (
        <Typography variant="body2" sx={{ mb: 1, color: 'text.secondary' }}>
          {label}
        </Typography>
      )}
      <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 0.5, mb: 1 }}>
        {PALETTE_SWATCHES.map((c) => (
          <Tooltip key={c.hex} title={c.name}>
            <ButtonBase
              onClick={() => handleSwatchClick(c.hex)}
              sx={{
                width: 28,
                height: 28,
                bgcolor: c.hex,
                border: '2px solid',
                borderColor: value === c.hex ? 'primary.main' : 'divider',
                outline: value === c.hex ? '2px solid' : 'none',
                outlineColor: 'primary.main',
                cursor: 'pointer',
              }}
            />
          </Tooltip>
        ))}
      </Box>
      <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
        <Box
          sx={{
            width: 36,
            height: 36,
            bgcolor: HEX_REGEX.test(inputValue) ? inputValue : 'transparent',
            border: '2px solid',
            borderColor: 'divider',
            flexShrink: 0,
          }}
        />
        <TextField
          size="small"
          variant="outlined"
          placeholder="#RRGGBB"
          value={inputValue}
          onChange={handleInputChange}
          error={error}
          helperText={helperText}
          sx={{ flex: 1 }}
        />
      </Box>
    </Box>
  );
}
