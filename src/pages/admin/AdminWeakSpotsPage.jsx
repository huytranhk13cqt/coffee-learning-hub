import { useState, useEffect, useMemo, useCallback } from 'react';
import { useLoaderData } from 'react-router';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import MenuItem from '@mui/material/MenuItem';
import TextField from '@mui/material/TextField';
import Chip from '@mui/material/Chip';
import {
  fetchAdminWeakSpots,
  fetchAdminLessons,
  fetchAdminCategories,
} from '../../api/admin.js';
import AdminDataTable from '../../components/admin/AdminDataTable.jsx';

export async function loader() {
  const [weakSpotsRes, lessonsRes, categoriesRes] = await Promise.all([
    fetchAdminWeakSpots(),
    fetchAdminLessons(),
    fetchAdminCategories(),
  ]);
  return {
    weakSpots: weakSpotsRes.data,
    lessons: lessonsRes.data,
    categories: categoriesRes.data,
  };
}

function getErrorRateColor(rate) {
  if (rate >= 0.7) return 'error';
  if (rate >= 0.5) return 'warning';
  if (rate >= 0.3) return 'info';
  return 'success';
}

export default function AdminWeakSpotsPage() {
  const loaderData = useLoaderData();
  const [data, setData] = useState(loaderData?.weakSpots || []);
  const [lessons, setLessons] = useState(loaderData?.lessons || []);
  const [categories, setCategories] = useState(loaderData?.categories || []);
  const [loading, setLoading] = useState(false);

  const [categoryFilter, setCategoryFilter] = useState('');
  const [lessonFilter, setLessonFilter] = useState('');
  const [typeFilter, setTypeFilter] = useState('');
  const [minAttempts, setMinAttempts] = useState(5);

  useEffect(() => {
    setData(loaderData?.weakSpots || []);
    setLessons(loaderData?.lessons || []);
    setCategories(loaderData?.categories || []);
  }, [loaderData]);

  const refetch = useCallback(async (filters) => {
    setLoading(true);
    try {
      const res = await fetchAdminWeakSpots(filters);
      setData(res.data);
    } finally {
      setLoading(false);
    }
  }, []);

  function handleFilterChange(field, value) {
    const newFilters = {
      minAttempts: field === 'minAttempts' ? value : minAttempts,
      type: field === 'type' ? value : typeFilter,
      lessonId: field === 'lessonId' ? value : lessonFilter,
      categoryId: field === 'categoryId' ? value : categoryFilter,
    };

    if (field === 'minAttempts') setMinAttempts(value);
    if (field === 'type') setTypeFilter(value);
    if (field === 'lessonId') setLessonFilter(value);
    if (field === 'categoryId') {
      setCategoryFilter(value);
      setLessonFilter('');
      newFilters.lessonId = '';
    }

    const cleanFilters = {};
    if (newFilters.minAttempts && newFilters.minAttempts !== 5)
      cleanFilters.minAttempts = newFilters.minAttempts;
    if (newFilters.type) cleanFilters.type = newFilters.type;
    if (newFilters.lessonId) cleanFilters.lessonId = newFilters.lessonId;
    if (newFilters.categoryId) cleanFilters.categoryId = newFilters.categoryId;

    refetch(cleanFilters);
  }

  const filteredLessons = useMemo(() => {
    if (!categoryFilter) return lessons;
    return lessons.filter((l) => l.group_id === Number(categoryFilter));
  }, [lessons, categoryFilter]);

  const EXERCISE_TYPES = [
    'fill_blank',
    'multiple_choice',
    'error_correction',
    'sentence_transform',
    'arrange_words',
    'matching',
    'true_false',
    'code_output',
  ];

  const columns = useMemo(
    () => [
      {
        accessorKey: 'question',
        header: 'Question',
        cell: ({ getValue }) => (
          <Typography
            variant="body2"
            sx={{
              maxWidth: 300,
              overflow: 'hidden',
              textOverflow: 'ellipsis',
              whiteSpace: 'nowrap',
            }}
          >
            {getValue()}
          </Typography>
        ),
      },
      {
        accessorKey: 'type',
        header: 'Type',
        size: 120,
        cell: ({ getValue }) => (
          <Chip label={getValue()} size="small" variant="outlined" />
        ),
      },
      {
        accessorKey: 'lesson_name',
        header: 'Lesson',
        size: 160,
      },
      {
        accessorKey: 'category_name',
        header: 'Category',
        size: 140,
      },
      {
        accessorKey: 'total_attempts',
        header: 'Attempts',
        size: 100,
      },
      {
        accessorKey: 'total_errors',
        header: 'Errors',
        size: 80,
      },
      {
        accessorKey: 'error_rate',
        header: 'Error Rate',
        size: 110,
        cell: ({ getValue }) => {
          const rate = getValue();
          return (
            <Chip
              label={`${Math.round(rate * 100)}%`}
              size="small"
              color={getErrorRateColor(rate)}
            />
          );
        },
      },
      {
        accessorKey: 'unique_sessions',
        header: 'Sessions',
        size: 90,
      },
    ],
    [],
  );

  return (
    <Box>
      <Typography variant="h2" sx={{ mb: 3 }}>
        Weak Spots (All Users)
      </Typography>

      <Box sx={{ display: 'flex', gap: 2, mb: 3, flexWrap: 'wrap' }}>
        <TextField
          select
          size="small"
          label="Category"
          value={categoryFilter}
          onChange={(e) => handleFilterChange('categoryId', e.target.value)}
          sx={{ minWidth: 160 }}
        >
          <MenuItem value="">All Categories</MenuItem>
          {categories.map((c) => (
            <MenuItem key={c.id} value={c.id}>
              {c.name}
            </MenuItem>
          ))}
        </TextField>

        <TextField
          select
          size="small"
          label="Lesson"
          value={lessonFilter}
          onChange={(e) => handleFilterChange('lessonId', e.target.value)}
          sx={{ minWidth: 180 }}
        >
          <MenuItem value="">All Lessons</MenuItem>
          {filteredLessons.map((l) => (
            <MenuItem key={l.id} value={l.id}>
              {l.name}
            </MenuItem>
          ))}
        </TextField>

        <TextField
          select
          size="small"
          label="Type"
          value={typeFilter}
          onChange={(e) => handleFilterChange('type', e.target.value)}
          sx={{ minWidth: 150 }}
        >
          <MenuItem value="">All Types</MenuItem>
          {EXERCISE_TYPES.map((t) => (
            <MenuItem key={t} value={t}>
              {t}
            </MenuItem>
          ))}
        </TextField>

        <TextField
          size="small"
          type="number"
          label="Min Attempts"
          value={minAttempts}
          onChange={(e) =>
            handleFilterChange('minAttempts', Number(e.target.value) || 1)
          }
          inputProps={{ min: 1, max: 100 }}
          sx={{ width: 130 }}
        />
      </Box>

      <AdminDataTable
        data={data}
        columns={columns}
        searchPlaceholder="Search exercises..."
        loading={loading}
      />
    </Box>
  );
}
