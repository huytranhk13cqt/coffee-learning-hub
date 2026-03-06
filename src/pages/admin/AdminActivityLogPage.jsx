import { useState } from 'react';
import { useLoaderData, useNavigate } from 'react-router';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Paper from '@mui/material/Paper';
import Table from '@mui/material/Table';
import TableHead from '@mui/material/TableHead';
import TableBody from '@mui/material/TableBody';
import TableRow from '@mui/material/TableRow';
import TableCell from '@mui/material/TableCell';
import MenuItem from '@mui/material/MenuItem';
import TextField from '@mui/material/TextField';
import Button from '@mui/material/Button';
import Chip from '@mui/material/Chip';
import Collapse from '@mui/material/Collapse';
import IconButton from '@mui/material/IconButton';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import ExpandLessIcon from '@mui/icons-material/ExpandLess';
import { fetchAdminActivityLog } from '../../api/admin.js';

const ACTIONS = [
  '',
  'create',
  'update',
  'delete',
  'reorder',
  'toggle_active',
  'login',
  'logout',
];
const ENTITY_TYPES = [
  '',
  'topic',
  'category',
  'lesson',
  'section',
  'exercise',
  'learning_path',
  'admin',
];
const PAGE_SIZES = [25, 50, 100];

const ACTION_COLORS = {
  create: 'success',
  update: 'info',
  delete: 'error',
  reorder: 'warning',
  toggle_active: 'warning',
  login: 'default',
  logout: 'default',
};

export async function loader({ request }) {
  const url = new URL(request.url);
  const page = url.searchParams.get('page') || 1;
  const pageSize = url.searchParams.get('pageSize') || 25;
  const action = url.searchParams.get('action') || '';
  const entityType = url.searchParams.get('entityType') || '';
  const res = await fetchAdminActivityLog({
    page,
    pageSize,
    action,
    entityType,
  });
  return {
    ...res,
    filters: {
      page: Number(page),
      pageSize: Number(pageSize),
      action,
      entityType,
    },
  };
}

function MetadataCell({ metadata }) {
  const [expanded, setExpanded] = useState(false);

  if (!metadata || Object.keys(metadata).length === 0) {
    return (
      <Typography variant="caption" color="text.secondary">
        -
      </Typography>
    );
  }

  const preview = JSON.stringify(metadata).slice(0, 60);

  return (
    <Box>
      <Box sx={{ display: 'flex', alignItems: 'center', gap: 0.5 }}>
        <Typography
          variant="caption"
          sx={{ fontFamily: 'monospace', fontSize: '0.75rem' }}
        >
          {expanded ? '' : preview.length >= 60 ? preview + '...' : preview}
        </Typography>
        <IconButton size="small" onClick={() => setExpanded(!expanded)}>
          {expanded ? (
            <ExpandLessIcon fontSize="small" />
          ) : (
            <ExpandMoreIcon fontSize="small" />
          )}
        </IconButton>
      </Box>
      <Collapse in={expanded}>
        <Box
          component="pre"
          sx={{
            fontSize: '0.75rem',
            fontFamily: 'monospace',
            bgcolor: 'action.hover',
            p: 1,
            mt: 0.5,
            maxWidth: 300,
            overflow: 'auto',
            whiteSpace: 'pre-wrap',
            wordBreak: 'break-all',
          }}
        >
          {JSON.stringify(metadata, null, 2)}
        </Box>
      </Collapse>
    </Box>
  );
}

export default function AdminActivityLogPage() {
  const loaderData = useLoaderData();
  const navigate = useNavigate();

  const data = loaderData?.data || [];
  const pagination = loaderData?.pagination || {};
  const filters = loaderData?.filters || {
    page: 1,
    pageSize: 25,
    action: '',
    entityType: '',
  };

  function updateFilters(newFilters) {
    const merged = { ...filters, ...newFilters, page: newFilters.page ?? 1 };
    const params = new URLSearchParams();
    if (merged.page && merged.page > 1) params.set('page', merged.page);
    if (merged.pageSize && merged.pageSize !== 25)
      params.set('pageSize', merged.pageSize);
    if (merged.action) params.set('action', merged.action);
    if (merged.entityType) params.set('entityType', merged.entityType);
    const qs = params.toString();
    navigate(`/admin/activity${qs ? `?${qs}` : ''}`, { replace: true });
  }

  function formatDate(iso) {
    const d = new Date(iso);
    return d.toLocaleString('en-GB', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit',
    });
  }

  return (
    <Box>
      <Typography variant="h2" sx={{ mb: 3 }}>
        Activity Log
      </Typography>

      <Box sx={{ display: 'flex', gap: 2, mb: 3, flexWrap: 'wrap' }}>
        <TextField
          select
          size="small"
          label="Action"
          value={filters.action}
          onChange={(e) => updateFilters({ action: e.target.value })}
          sx={{ minWidth: 150 }}
        >
          <MenuItem value="">All Actions</MenuItem>
          {ACTIONS.filter(Boolean).map((a) => (
            <MenuItem key={a} value={a}>
              {a}
            </MenuItem>
          ))}
        </TextField>

        <TextField
          select
          size="small"
          label="Entity Type"
          value={filters.entityType}
          onChange={(e) => updateFilters({ entityType: e.target.value })}
          sx={{ minWidth: 160 }}
        >
          <MenuItem value="">All Types</MenuItem>
          {ENTITY_TYPES.filter(Boolean).map((t) => (
            <MenuItem key={t} value={t}>
              {t}
            </MenuItem>
          ))}
        </TextField>

        <TextField
          select
          size="small"
          label="Page Size"
          value={filters.pageSize}
          onChange={(e) => updateFilters({ pageSize: Number(e.target.value) })}
          sx={{ minWidth: 100 }}
        >
          {PAGE_SIZES.map((s) => (
            <MenuItem key={s} value={s}>
              {s}
            </MenuItem>
          ))}
        </TextField>
      </Box>

      <Paper sx={{ overflow: 'auto', mb: 2 }}>
        <Table size="small">
          <TableHead>
            <TableRow>
              <TableCell
                sx={{
                  fontFamily: '"Silkscreen", cursive',
                  fontSize: '0.8rem',
                  borderBottom: '2px solid',
                  borderColor: 'divider',
                }}
              >
                Time
              </TableCell>
              <TableCell
                sx={{
                  fontFamily: '"Silkscreen", cursive',
                  fontSize: '0.8rem',
                  borderBottom: '2px solid',
                  borderColor: 'divider',
                }}
              >
                Action
              </TableCell>
              <TableCell
                sx={{
                  fontFamily: '"Silkscreen", cursive',
                  fontSize: '0.8rem',
                  borderBottom: '2px solid',
                  borderColor: 'divider',
                }}
              >
                Entity
              </TableCell>
              <TableCell
                sx={{
                  fontFamily: '"Silkscreen", cursive',
                  fontSize: '0.8rem',
                  borderBottom: '2px solid',
                  borderColor: 'divider',
                }}
              >
                ID
              </TableCell>
              <TableCell
                sx={{
                  fontFamily: '"Silkscreen", cursive',
                  fontSize: '0.8rem',
                  borderBottom: '2px solid',
                  borderColor: 'divider',
                }}
              >
                Details
              </TableCell>
              <TableCell
                sx={{
                  fontFamily: '"Silkscreen", cursive',
                  fontSize: '0.8rem',
                  borderBottom: '2px solid',
                  borderColor: 'divider',
                }}
              >
                IP
              </TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {data.length === 0 ? (
              <TableRow>
                <TableCell colSpan={6} align="center" sx={{ py: 4 }}>
                  <Typography variant="body2" color="text.secondary">
                    No activity logs found
                  </Typography>
                </TableCell>
              </TableRow>
            ) : (
              data.map((row) => (
                <TableRow key={row.id} hover>
                  <TableCell sx={{ whiteSpace: 'nowrap' }}>
                    <Typography variant="caption">
                      {formatDate(row.created_at)}
                    </Typography>
                  </TableCell>
                  <TableCell>
                    <Chip
                      label={row.action}
                      size="small"
                      color={ACTION_COLORS[row.action] || 'default'}
                    />
                  </TableCell>
                  <TableCell>
                    <Chip
                      label={row.entity_type}
                      size="small"
                      variant="outlined"
                    />
                  </TableCell>
                  <TableCell>{row.entity_id || '-'}</TableCell>
                  <TableCell>
                    <MetadataCell metadata={row.metadata} />
                  </TableCell>
                  <TableCell>
                    <Typography
                      variant="caption"
                      sx={{ fontFamily: 'monospace' }}
                    >
                      {row.ip_address || '-'}
                    </Typography>
                  </TableCell>
                </TableRow>
              ))
            )}
          </TableBody>
        </Table>
      </Paper>

      <Box
        sx={{
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center',
        }}
      >
        <Typography variant="body2" color="text.secondary">
          Page {pagination.page || 1} of {pagination.totalPages || 1} (
          {pagination.total || 0} total)
        </Typography>
        <Box sx={{ display: 'flex', gap: 1 }}>
          <Button
            size="small"
            disabled={!pagination.page || pagination.page <= 1}
            onClick={() => updateFilters({ page: pagination.page - 1 })}
          >
            Previous
          </Button>
          <Button
            size="small"
            disabled={
              !pagination.page || pagination.page >= pagination.totalPages
            }
            onClick={() => updateFilters({ page: pagination.page + 1 })}
          >
            Next
          </Button>
        </Box>
      </Box>
    </Box>
  );
}
