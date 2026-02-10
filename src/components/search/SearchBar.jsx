import { useState, useRef, useCallback } from 'react';
import { useNavigate } from 'react-router';
import Autocomplete from '@mui/material/Autocomplete';
import TextField from '@mui/material/TextField';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import CircularProgress from '@mui/material/CircularProgress';
import InputAdornment from '@mui/material/InputAdornment';
import SearchIcon from '@mui/icons-material/Search';
import { searchLessons } from '../../api/lessons.js';
import { DIFFICULTY_LABELS } from '../../constants/difficulty.js';

const DEBOUNCE_MS = 300;
const MIN_QUERY_LENGTH = 2;

export default function SearchBar() {
  const navigate = useNavigate();
  const [options, setOptions] = useState([]);
  const [loading, setLoading] = useState(false);
  const [inputValue, setInputValue] = useState('');
  const timerRef = useRef(null);
  const abortRef = useRef(null);

  const fetchResults = useCallback((query) => {
    // Cancel previous in-flight request
    if (abortRef.current) abortRef.current.abort();

    if (!query || query.length < MIN_QUERY_LENGTH) {
      setOptions([]);
      setLoading(false);
      return;
    }

    setLoading(true);
    const controller = new AbortController();
    abortRef.current = controller;

    searchLessons(query, { signal: controller.signal })
      .then((results) => {
        setOptions(results);
        setLoading(false);
      })
      .catch((err) => {
        if (err.name !== 'AbortError') {
          setOptions([]);
          setLoading(false);
        }
      });
  }, []);

  const handleInputChange = useCallback(
    (_event, value, reason) => {
      setInputValue(value);
      if (reason !== 'input') return;

      clearTimeout(timerRef.current);
      timerRef.current = setTimeout(
        () => fetchResults(value.trim()),
        DEBOUNCE_MS,
      );
    },
    [fetchResults],
  );

  const handleSelect = useCallback(
    (_event, value) => {
      if (value && typeof value === 'object' && value.slug) {
        navigate(`/lessons/${value.slug}`);
        setInputValue('');
        setOptions([]);
      }
    },
    [navigate],
  );

  return (
    <Autocomplete
      freeSolo
      options={options}
      loading={loading}
      inputValue={inputValue}
      onInputChange={handleInputChange}
      onChange={handleSelect}
      filterOptions={(x) => x}
      getOptionLabel={(opt) =>
        typeof opt === 'string' ? opt : opt.name_vi || ''
      }
      noOptionsText={
        inputValue.length >= MIN_QUERY_LENGTH
          ? 'Không tìm thấy bài học'
          : 'Nhập ít nhất 2 ký tự'
      }
      renderOption={({ key, ...props }, option) => (
        <Box component="li" key={key} {...props} sx={{ gap: 1.5 }}>
          <Box
            sx={{
              width: 10,
              height: 10,
              borderRadius: '50%',
              backgroundColor: option.group_color,
              flexShrink: 0,
            }}
          />
          <Box sx={{ minWidth: 0, flex: 1 }}>
            <Typography variant="body2" noWrap>
              {option.name_vi}
            </Typography>
            <Typography variant="caption" color="text.secondary" noWrap>
              {option.group_name_vi} ·{' '}
              {DIFFICULTY_LABELS[option.difficulty] || option.difficulty}
            </Typography>
          </Box>
        </Box>
      )}
      renderInput={(params) => (
        <TextField
          {...params}
          placeholder="Tìm bài học..."
          aria-label="Tìm kiếm bài học"
          size="small"
          sx={{
            width: { xs: 160, sm: 240, md: 280 },
            '& .MuiOutlinedInput-root': {
              backgroundColor: 'rgba(255,255,255,0.15)',
              color: 'inherit',
              '& fieldset': { borderColor: 'rgba(255,255,255,0.3)' },
              '&:hover fieldset': { borderColor: 'rgba(255,255,255,0.5)' },
              '&.Mui-focused fieldset': {
                borderColor: 'rgba(255,255,255,0.7)',
              },
            },
            '& .MuiInputBase-input::placeholder': {
              color: 'rgba(255,255,255,0.7)',
              opacity: 1,
            },
          }}
          slotProps={{
            input: {
              ...params.InputProps,
              startAdornment: (
                <InputAdornment position="start">
                  <SearchIcon
                    sx={{ color: 'rgba(255,255,255,0.7)', fontSize: 20 }}
                  />
                </InputAdornment>
              ),
              endAdornment: (
                <>
                  {loading && <CircularProgress color="inherit" size={18} />}
                  {params.InputProps.endAdornment}
                </>
              ),
            },
          }}
        />
      )}
      slotProps={{
        popper: { sx: { zIndex: 1300 } },
      }}
    />
  );
}
