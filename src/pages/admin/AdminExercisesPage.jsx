import { useState, useEffect, useMemo } from 'react';
import { useLoaderData, useNavigate } from 'react-router';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import IconButton from '@mui/material/IconButton';
import Chip from '@mui/material/Chip';
import MenuItem from '@mui/material/MenuItem';
import TextField from '@mui/material/TextField';
import AddIcon from '@mui/icons-material/Add';
import EditIcon from '@mui/icons-material/Edit';
import DeleteIcon from '@mui/icons-material/Delete';
import {
  fetchAdminExercises,
  fetchAdminLessons,
  deleteAdminExercise,
  reorderAdminExercises,
} from '../../api/admin.js';
import AdminDataTable from '../../components/admin/AdminDataTable.jsx';
import DeleteConfirmDialog from '../../components/admin/DeleteConfirmDialog.jsx';

export async function loader() {
  const [exercisesRes, lessonsRes] = await Promise.all([
    fetchAdminExercises(),
    fetchAdminLessons(),
  ]);
  return { exercises: exercisesRes.data, lessons: lessonsRes.data };
}

const EXERCISE_TYPES = [
  'multiple_choice',
  'fill_blank',
  'error_correction',
  'sentence_transform',
  'arrange_words',
  'matching',
  'true_false',
  'code_output',
];

const DIFFICULTIES = ['easy', 'medium', 'hard'];

const DIFFICULTY_COLORS = {
  easy: 'success',
  medium: 'warning',
  hard: 'error',
};

export default function AdminExercisesPage() {
  const loaderData = useLoaderData();
  const navigate = useNavigate();
  const [exercises, setExercises] = useState(loaderData?.exercises || []);
  const [lessons, setLessons] = useState(loaderData?.lessons || []);
  const [lessonFilter, setLessonFilter] = useState('');
  const [typeFilter, setTypeFilter] = useState('');
  const [difficultyFilter, setDifficultyFilter] = useState('');
  const [deleteItem, setDeleteItem] = useState(null);
  const [deleting, setDeleting] = useState(false);

  useEffect(() => {
    setExercises(loaderData?.exercises || []);
    setLessons(loaderData?.lessons || []);
  }, [loaderData]);

  const filteredExercises = useMemo(() => {
    let result = exercises;
    if (lessonFilter)
      result = result.filter((e) => e.lesson_id === Number(lessonFilter));
    if (typeFilter) result = result.filter((e) => e.type === typeFilter);
    if (difficultyFilter)
      result = result.filter((e) => e.difficulty === difficultyFilter);
    return result;
  }, [exercises, lessonFilter, typeFilter, difficultyFilter]);

  const columns = useMemo(
    () => [
      {
        accessorKey: 'question',
        header: 'Question',
        cell: ({ getValue }) => {
          const val = getValue() || '';
          return val.length > 60 ? val.slice(0, 60) + '...' : val;
        },
      },
      {
        accessorKey: 'type',
        header: 'Type',
        size: 150,
        cell: ({ getValue }) => (
          <Chip label={getValue().replace(/_/g, ' ')} size="small" />
        ),
      },
      {
        accessorKey: 'difficulty',
        header: 'Difficulty',
        size: 110,
        cell: ({ getValue }) => (
          <Chip
            label={getValue()}
            size="small"
            color={DIFFICULTY_COLORS[getValue()] || 'default'}
          />
        ),
      },
      { accessorKey: 'lesson_name', header: 'Lesson' },
      {
        accessorKey: 'points',
        header: 'Points',
        size: 80,
        cell: ({ getValue }) => getValue(),
      },
      {
        accessorKey: 'is_active',
        header: 'Active',
        size: 90,
        cell: ({ getValue }) => (
          <Chip
            label={getValue() ? 'Active' : 'Inactive'}
            size="small"
            color={getValue() ? 'success' : 'default'}
            variant={getValue() ? 'filled' : 'outlined'}
          />
        ),
      },
      {
        id: 'actions',
        header: 'Actions',
        size: 100,
        enableSorting: false,
        cell: ({ row }) => (
          <Box sx={{ display: 'flex', gap: 0.5 }}>
            <IconButton
              size="small"
              onClick={() =>
                navigate(`/admin/exercises/${row.original.id}/edit`)
              }
              title="Edit"
            >
              <EditIcon fontSize="small" />
            </IconButton>
            <IconButton
              size="small"
              color="error"
              onClick={() => setDeleteItem(row.original)}
              title="Delete"
            >
              <DeleteIcon fontSize="small" />
            </IconButton>
          </Box>
        ),
      },
    ],
    [navigate],
  );

  async function handleDelete() {
    if (!deleteItem) return;
    setDeleting(true);
    try {
      await deleteAdminExercise(deleteItem.id);
      setExercises((prev) => prev.filter((e) => e.id !== deleteItem.id));
      setDeleteItem(null);
    } finally {
      setDeleting(false);
    }
  }

  async function handleReorder(reorderedExercises) {
    setExercises(reorderedExercises);
    await reorderAdminExercises(
      lessonFilter,
      reorderedExercises.map((e) => e.id),
    );
  }

  return (
    <Box>
      <Box
        sx={{
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center',
          mb: 3,
        }}
      >
        <Typography variant="h2">Exercises</Typography>
        <Button
          variant="contained"
          startIcon={<AddIcon />}
          onClick={() => navigate('/admin/exercises/new')}
        >
          New Exercise
        </Button>
      </Box>

      <Box sx={{ display: 'flex', gap: 2, mb: 2, flexWrap: 'wrap' }}>
        <TextField
          select
          size="small"
          label="Filter by Lesson"
          value={lessonFilter}
          onChange={(e) => setLessonFilter(e.target.value)}
          sx={{ minWidth: 200 }}
        >
          <MenuItem value="">All Lessons</MenuItem>
          {lessons.map((l) => (
            <MenuItem key={l.id} value={l.id}>
              {l.name}
            </MenuItem>
          ))}
        </TextField>

        <TextField
          select
          size="small"
          label="Filter by Type"
          value={typeFilter}
          onChange={(e) => setTypeFilter(e.target.value)}
          sx={{ minWidth: 180 }}
        >
          <MenuItem value="">All Types</MenuItem>
          {EXERCISE_TYPES.map((t) => (
            <MenuItem key={t} value={t}>
              {t.replace(/_/g, ' ')}
            </MenuItem>
          ))}
        </TextField>

        <TextField
          select
          size="small"
          label="Filter by Difficulty"
          value={difficultyFilter}
          onChange={(e) => setDifficultyFilter(e.target.value)}
          sx={{ minWidth: 160 }}
        >
          <MenuItem value="">All Difficulties</MenuItem>
          {DIFFICULTIES.map((d) => (
            <MenuItem key={d} value={d}>
              {d}
            </MenuItem>
          ))}
        </TextField>
      </Box>

      <AdminDataTable
        data={filteredExercises}
        columns={columns}
        searchPlaceholder="Search exercises..."
        onReorder={lessonFilter ? handleReorder : undefined}
      />

      <DeleteConfirmDialog
        open={!!deleteItem}
        title="Delete Exercise"
        message={`Delete this exercise? This action cannot be undone.`}
        onConfirm={handleDelete}
        onCancel={() => setDeleteItem(null)}
        loading={deleting}
      />
    </Box>
  );
}
