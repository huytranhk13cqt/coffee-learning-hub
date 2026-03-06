import { useState, useEffect, useMemo } from 'react';
import { useLoaderData, useNavigate } from 'react-router';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import IconButton from '@mui/material/IconButton';
import Chip from '@mui/material/Chip';
import Switch from '@mui/material/Switch';
import AddIcon from '@mui/icons-material/Add';
import EditIcon from '@mui/icons-material/Edit';
import DeleteIcon from '@mui/icons-material/Delete';
import {
  fetchAdminPaths,
  deleteAdminPath,
  reorderAdminPaths,
  toggleAdminPathActive,
} from '../../api/admin.js';
import AdminDataTable from '../../components/admin/AdminDataTable.jsx';
import DeleteConfirmDialog from '../../components/admin/DeleteConfirmDialog.jsx';

export async function loader() {
  const res = await fetchAdminPaths();
  return { paths: res.data };
}

export default function AdminLearningPathsPage() {
  const loaderData = useLoaderData();
  const navigate = useNavigate();
  const [paths, setPaths] = useState(loaderData?.paths || []);
  const [deleteItem, setDeleteItem] = useState(null);
  const [deleting, setDeleting] = useState(false);

  useEffect(() => {
    setPaths(loaderData?.paths || []);
  }, [loaderData]);

  async function handleToggleActive(id) {
    const res = await toggleAdminPathActive(id);
    setPaths((prev) =>
      prev.map((p) =>
        p.id === id ? { ...p, is_active: res.data.is_active } : p,
      ),
    );
  }

  const columns = useMemo(
    () => [
      {
        accessorKey: 'name',
        header: 'Name',
        cell: ({ row }) => (
          <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
            <Box
              sx={{
                width: 12,
                height: 12,
                bgcolor: row.original.color,
                flexShrink: 0,
              }}
            />
            <span>{row.original.name}</span>
          </Box>
        ),
      },
      { accessorKey: 'name_vi', header: 'Name (VI)' },
      {
        accessorKey: 'step_count',
        header: 'Steps',
        size: 80,
        cell: ({ getValue }) => (
          <Chip label={getValue()} size="small" variant="outlined" />
        ),
      },
      {
        accessorKey: 'estimated_days',
        header: 'Days',
        size: 80,
      },
      {
        accessorKey: 'is_featured',
        header: 'Featured',
        size: 100,
        cell: ({ getValue }) =>
          getValue() ? (
            <Chip label="Featured" size="small" color="success" />
          ) : null,
      },
      {
        accessorKey: 'is_active',
        header: 'Active',
        size: 80,
        enableSorting: false,
        cell: ({ row }) => (
          <Switch
            size="small"
            checked={row.original.is_active}
            onChange={() => handleToggleActive(row.original.id)}
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
              onClick={() => navigate(`/admin/paths/${row.original.id}/edit`)}
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
      await deleteAdminPath(deleteItem.id);
      setPaths((prev) => prev.filter((p) => p.id !== deleteItem.id));
      setDeleteItem(null);
    } finally {
      setDeleting(false);
    }
  }

  function handleReorder(reordered) {
    setPaths(reordered);
    reorderAdminPaths(reordered.map((p) => p.id));
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
        <Typography variant="h2">Learning Paths</Typography>
        <Button
          variant="contained"
          startIcon={<AddIcon />}
          onClick={() => navigate('/admin/paths/new')}
        >
          New Path
        </Button>
      </Box>

      <AdminDataTable
        data={paths}
        columns={columns}
        searchPlaceholder="Search paths..."
        onReorder={handleReorder}
      />

      <DeleteConfirmDialog
        open={!!deleteItem}
        title="Delete Learning Path"
        message={`Delete "${deleteItem?.name}"? All steps will be permanently deleted.`}
        onConfirm={handleDelete}
        onCancel={() => setDeleteItem(null)}
        loading={deleting}
      />
    </Box>
  );
}
