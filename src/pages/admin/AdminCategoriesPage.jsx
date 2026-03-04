import { useState, useEffect, useMemo } from 'react';
import { useLoaderData } from 'react-router';
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
  fetchAdminCategories,
  fetchAdminTopics,
  createAdminCategory,
  updateAdminCategory,
  deleteAdminCategory,
  reorderAdminCategories,
} from '../../api/admin.js';
import AdminDataTable from '../../components/admin/AdminDataTable.jsx';
import CategoryFormDialog from '../../components/admin/CategoryFormDialog.jsx';
import DeleteConfirmDialog from '../../components/admin/DeleteConfirmDialog.jsx';

export async function loader() {
  const [categoriesRes, topicsRes] = await Promise.all([
    fetchAdminCategories(),
    fetchAdminTopics(),
  ]);
  return { categories: categoriesRes.data, topics: topicsRes.data };
}

export default function AdminCategoriesPage() {
  const loaderData = useLoaderData();
  const [categories, setCategories] = useState(loaderData?.categories || []);
  const [topics, setTopics] = useState(loaderData?.topics || []);
  const [topicFilter, setTopicFilter] = useState('');
  const [formOpen, setFormOpen] = useState(false);
  const [editItem, setEditItem] = useState(null);
  const [deleteItem, setDeleteItem] = useState(null);
  const [deleting, setDeleting] = useState(false);

  useEffect(() => {
    setCategories(loaderData?.categories || []);
    setTopics(loaderData?.topics || []);
  }, [loaderData]);

  const filteredCategories = useMemo(() => {
    if (!topicFilter) return categories;
    return categories.filter((c) => c.topic_id === Number(topicFilter));
  }, [categories, topicFilter]);

  const columns = useMemo(
    () => [
      { accessorKey: 'name', header: 'Name' },
      { accessorKey: 'name_vi', header: 'Name (VI)' },
      {
        accessorKey: 'topic_name',
        header: 'Topic',
        cell: ({ getValue }) =>
          getValue() || <em style={{ opacity: 0.5 }}>None</em>,
      },
      {
        accessorKey: 'color',
        header: 'Color',
        size: 80,
        cell: ({ getValue }) => (
          <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
            <Box
              sx={{
                width: 20,
                height: 20,
                bgcolor: getValue(),
                border: '2px solid',
                borderColor: 'divider',
              }}
            />
            <Typography variant="caption">{getValue()}</Typography>
          </Box>
        ),
      },
      {
        accessorKey: 'lesson_count',
        header: 'Lessons',
        size: 80,
        cell: ({ getValue }) => (
          <Chip label={getValue()} size="small" variant="outlined" />
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
              onClick={() => {
                setEditItem(row.original);
                setFormOpen(true);
              }}
            >
              <EditIcon fontSize="small" />
            </IconButton>
            <IconButton
              size="small"
              color="error"
              onClick={() => setDeleteItem(row.original)}
            >
              <DeleteIcon fontSize="small" />
            </IconButton>
          </Box>
        ),
      },
    ],
    [],
  );

  async function handleSave(data) {
    if (editItem) {
      const res = await updateAdminCategory(editItem.id, data);
      const topicName =
        topics.find((t) => t.id === res.data.topic_id)?.name || null;
      setCategories((prev) =>
        prev.map((c) =>
          c.id === editItem.id
            ? { ...c, ...res.data, topic_name: topicName }
            : c,
        ),
      );
    } else {
      const res = await createAdminCategory(data);
      const topicName =
        topics.find((t) => t.id === res.data.topic_id)?.name || null;
      setCategories((prev) => [
        ...prev,
        { ...res.data, topic_name: topicName, lesson_count: 0 },
      ]);
    }
  }

  async function handleDelete() {
    if (!deleteItem) return;
    setDeleting(true);
    try {
      await deleteAdminCategory(deleteItem.id);
      setCategories((prev) => prev.filter((c) => c.id !== deleteItem.id));
      setDeleteItem(null);
    } finally {
      setDeleting(false);
    }
  }

  function handleReorder(reordered) {
    setCategories(reordered);
    reorderAdminCategories(reordered.map((c) => c.id));
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
        <Typography variant="h2">Categories</Typography>
        <Button
          variant="contained"
          startIcon={<AddIcon />}
          onClick={() => {
            setEditItem(null);
            setFormOpen(true);
          }}
        >
          New Category
        </Button>
      </Box>

      <TextField
        select
        size="small"
        label="Filter by Topic"
        value={topicFilter}
        onChange={(e) => setTopicFilter(e.target.value)}
        sx={{ mb: 2, minWidth: 200 }}
      >
        <MenuItem value="">All Topics</MenuItem>
        {topics.map((t) => (
          <MenuItem key={t.id} value={t.id}>
            {t.name}
          </MenuItem>
        ))}
      </TextField>

      <AdminDataTable
        data={filteredCategories}
        columns={columns}
        searchPlaceholder="Search categories..."
        onReorder={handleReorder}
      />

      <CategoryFormDialog
        open={formOpen}
        onClose={() => {
          setFormOpen(false);
          setEditItem(null);
        }}
        onSave={handleSave}
        initialData={editItem}
        topics={topics}
      />

      <DeleteConfirmDialog
        open={!!deleteItem}
        title="Delete Category"
        message={`Delete "${deleteItem?.name}"? This will fail if the category has lessons.`}
        onConfirm={handleDelete}
        onCancel={() => setDeleteItem(null)}
        loading={deleting}
      />
    </Box>
  );
}
