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
import ListAltIcon from '@mui/icons-material/ListAlt';
import {
  fetchAdminLessons,
  fetchAdminCategories,
  deleteAdminLesson,
} from '../../api/admin.js';
import AdminDataTable from '../../components/admin/AdminDataTable.jsx';
import DeleteConfirmDialog from '../../components/admin/DeleteConfirmDialog.jsx';

export async function loader() {
  const [lessonsRes, categoriesRes] = await Promise.all([
    fetchAdminLessons(),
    fetchAdminCategories(),
  ]);
  return { lessons: lessonsRes.data, categories: categoriesRes.data };
}

const DIFFICULTY_COLORS = {
  beginner: 'success',
  intermediate: 'warning',
  advanced: 'error',
};

export default function AdminLessonsPage() {
  const loaderData = useLoaderData();
  const navigate = useNavigate();
  const [lessons, setLessons] = useState(loaderData?.lessons || []);
  const [categories, setCategories] = useState(loaderData?.categories || []);
  const [categoryFilter, setCategoryFilter] = useState('');
  const [deleteItem, setDeleteItem] = useState(null);
  const [deleting, setDeleting] = useState(false);

  useEffect(() => {
    setLessons(loaderData?.lessons || []);
    setCategories(loaderData?.categories || []);
  }, [loaderData]);

  const filteredLessons = useMemo(() => {
    if (!categoryFilter) return lessons;
    return lessons.filter((l) => l.group_id === Number(categoryFilter));
  }, [lessons, categoryFilter]);

  const columns = useMemo(
    () => [
      { accessorKey: 'name', header: 'Name' },
      { accessorKey: 'name_vi', header: 'Name (VI)' },
      { accessorKey: 'category_name', header: 'Category' },
      {
        accessorKey: 'difficulty',
        header: 'Difficulty',
        size: 120,
        cell: ({ getValue }) => (
          <Chip
            label={getValue()}
            size="small"
            color={DIFFICULTY_COLORS[getValue()] || 'default'}
          />
        ),
      },
      {
        accessorKey: 'is_published',
        header: 'Status',
        size: 100,
        cell: ({ getValue }) => (
          <Chip
            label={getValue() ? 'Published' : 'Draft'}
            size="small"
            color={getValue() ? 'success' : 'default'}
            variant={getValue() ? 'filled' : 'outlined'}
          />
        ),
      },
      {
        accessorKey: 'exercise_count',
        header: 'Exercises',
        size: 90,
        cell: ({ getValue }) => getValue(),
      },
      {
        accessorKey: 'section_count',
        header: 'Sections',
        size: 90,
        cell: ({ getValue }) => getValue(),
      },
      {
        id: 'actions',
        header: 'Actions',
        size: 140,
        enableSorting: false,
        cell: ({ row }) => (
          <Box sx={{ display: 'flex', gap: 0.5 }}>
            <IconButton
              size="small"
              onClick={() => navigate(`/admin/lessons/${row.original.id}/edit`)}
              title="Edit"
            >
              <EditIcon fontSize="small" />
            </IconButton>
            <IconButton
              size="small"
              onClick={() =>
                navigate(`/admin/lessons/${row.original.id}/sections`)
              }
              title="Sections"
            >
              <ListAltIcon fontSize="small" />
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
      await deleteAdminLesson(deleteItem.id);
      setLessons((prev) => prev.filter((l) => l.id !== deleteItem.id));
      setDeleteItem(null);
    } finally {
      setDeleting(false);
    }
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
        <Typography variant="h2">Lessons</Typography>
        <Button
          variant="contained"
          startIcon={<AddIcon />}
          onClick={() => navigate('/admin/lessons/new')}
        >
          New Lesson
        </Button>
      </Box>

      <TextField
        select
        size="small"
        label="Filter by Category"
        value={categoryFilter}
        onChange={(e) => setCategoryFilter(e.target.value)}
        sx={{ mb: 2, minWidth: 200 }}
      >
        <MenuItem value="">All Categories</MenuItem>
        {categories.map((c) => (
          <MenuItem key={c.id} value={c.id}>
            {c.name}
          </MenuItem>
        ))}
      </TextField>

      <AdminDataTable
        data={filteredLessons}
        columns={columns}
        searchPlaceholder="Search lessons..."
      />

      <DeleteConfirmDialog
        open={!!deleteItem}
        title="Delete Lesson"
        message={`Delete "${deleteItem?.name}"? All sections and exercises will be permanently deleted.`}
        onConfirm={handleDelete}
        onCancel={() => setDeleteItem(null)}
        loading={deleting}
      />
    </Box>
  );
}
