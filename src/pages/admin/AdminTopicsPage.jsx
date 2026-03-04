import { useState, useEffect, useMemo } from 'react';
import { useLoaderData } from 'react-router';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import IconButton from '@mui/material/IconButton';
import Chip from '@mui/material/Chip';
import AddIcon from '@mui/icons-material/Add';
import EditIcon from '@mui/icons-material/Edit';
import DeleteIcon from '@mui/icons-material/Delete';
import {
  fetchAdminTopics,
  createAdminTopic,
  updateAdminTopic,
  deleteAdminTopic,
  reorderAdminTopics,
} from '../../api/admin.js';
import AdminDataTable from '../../components/admin/AdminDataTable.jsx';
import TopicFormDialog from '../../components/admin/TopicFormDialog.jsx';
import DeleteConfirmDialog from '../../components/admin/DeleteConfirmDialog.jsx';
import { ICON_MAP } from '../../components/admin/IconPickerField.jsx';

export async function loader() {
  return fetchAdminTopics();
}

export default function AdminTopicsPage() {
  const loaderData = useLoaderData();
  const [topics, setTopics] = useState(loaderData?.data || []);
  const [formOpen, setFormOpen] = useState(false);
  const [editItem, setEditItem] = useState(null);
  const [deleteItem, setDeleteItem] = useState(null);
  const [deleting, setDeleting] = useState(false);

  useEffect(() => {
    setTopics(loaderData?.data || []);
  }, [loaderData]);

  const columns = useMemo(
    () => [
      {
        accessorKey: 'name',
        header: 'Name',
        cell: ({ row }) => (
          <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
            {row.original.icon &&
              ICON_MAP[row.original.icon] &&
              (() => {
                const Icon = ICON_MAP[row.original.icon];
                return <Icon fontSize="small" />;
              })()}
            <span>{row.original.name}</span>
          </Box>
        ),
      },
      { accessorKey: 'name_vi', header: 'Name (VI)' },
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
        accessorKey: 'category_count',
        header: 'Categories',
        size: 100,
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
      const res = await updateAdminTopic(editItem.id, data);
      setTopics((prev) =>
        prev.map((t) => (t.id === editItem.id ? { ...t, ...res.data } : t)),
      );
    } else {
      const res = await createAdminTopic(data);
      setTopics((prev) => [...prev, { ...res.data, category_count: 0 }]);
    }
  }

  async function handleDelete() {
    if (!deleteItem) return;
    setDeleting(true);
    try {
      await deleteAdminTopic(deleteItem.id);
      setTopics((prev) => prev.filter((t) => t.id !== deleteItem.id));
      setDeleteItem(null);
    } finally {
      setDeleting(false);
    }
  }

  function handleReorder(reordered) {
    setTopics(reordered);
    reorderAdminTopics(reordered.map((t) => t.id));
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
        <Typography variant="h2">Topics</Typography>
        <Button
          variant="contained"
          startIcon={<AddIcon />}
          onClick={() => {
            setEditItem(null);
            setFormOpen(true);
          }}
        >
          New Topic
        </Button>
      </Box>

      <AdminDataTable
        data={topics}
        columns={columns}
        searchPlaceholder="Search topics..."
        onReorder={handleReorder}
      />

      <TopicFormDialog
        open={formOpen}
        onClose={() => {
          setFormOpen(false);
          setEditItem(null);
        }}
        onSave={handleSave}
        initialData={editItem}
      />

      <DeleteConfirmDialog
        open={!!deleteItem}
        title="Delete Topic"
        message={`Delete "${deleteItem?.name}"? Categories under this topic will be unlinked.`}
        onConfirm={handleDelete}
        onCancel={() => setDeleteItem(null)}
        loading={deleting}
      />
    </Box>
  );
}
