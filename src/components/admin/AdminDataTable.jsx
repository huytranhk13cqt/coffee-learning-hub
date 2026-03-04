import { useState, useMemo, useCallback } from 'react';
import {
  useReactTable,
  getCoreRowModel,
  getSortedRowModel,
  getFilteredRowModel,
  getPaginationRowModel,
  flexRender,
} from '@tanstack/react-table';
import {
  DndContext,
  closestCenter,
  KeyboardSensor,
  PointerSensor,
  useSensor,
  useSensors,
} from '@dnd-kit/core';
import {
  SortableContext,
  verticalListSortingStrategy,
} from '@dnd-kit/sortable';
import { restrictToVerticalAxis } from '@dnd-kit/modifiers';
import Box from '@mui/material/Box';
import Table from '@mui/material/Table';
import TableHead from '@mui/material/TableHead';
import TableBody from '@mui/material/TableBody';
import TableRow from '@mui/material/TableRow';
import TableCell from '@mui/material/TableCell';
import TablePagination from '@mui/material/TablePagination';
import TableSortLabel from '@mui/material/TableSortLabel';
import TextField from '@mui/material/TextField';
import Typography from '@mui/material/Typography';
import Skeleton from '@mui/material/Skeleton';
import Paper from '@mui/material/Paper';
import InputAdornment from '@mui/material/InputAdornment';
import SearchIcon from '@mui/icons-material/Search';
import { DragHandleCell, SortableTableRow } from './DragHandle.jsx';

export default function AdminDataTable({
  data,
  columns,
  searchPlaceholder = 'Search...',
  onReorder,
  pageSize = 20,
  loading = false,
}) {
  const [sorting, setSorting] = useState([]);
  const [globalFilter, setGlobalFilter] = useState('');
  const [pagination, setPagination] = useState({ pageIndex: 0, pageSize });

  const allColumns = useMemo(() => {
    if (!onReorder) return columns;
    return [
      {
        id: '_drag',
        header: '',
        size: 48,
        enableSorting: false,
        cell: ({ row }) => <DragHandleCell id={row.original.id} />,
      },
      ...columns,
    ];
  }, [columns, onReorder]);

  const table = useReactTable({
    data: data || [],
    columns: allColumns,
    state: { sorting, globalFilter, pagination },
    onSortingChange: setSorting,
    onGlobalFilterChange: setGlobalFilter,
    onPaginationChange: setPagination,
    getCoreRowModel: getCoreRowModel(),
    getSortedRowModel: getSortedRowModel(),
    getFilteredRowModel: getFilteredRowModel(),
    getPaginationRowModel: getPaginationRowModel(),
  });

  const sensors = useSensors(
    useSensor(PointerSensor, { activationConstraint: { distance: 5 } }),
    useSensor(KeyboardSensor),
  );

  const handleDragEnd = useCallback(
    (event) => {
      const { active, over } = event;
      if (!over || active.id === over.id || !onReorder) return;

      const oldIndex = data.findIndex((item) => item.id === active.id);
      const newIndex = data.findIndex((item) => item.id === over.id);
      if (oldIndex === -1 || newIndex === -1) return;

      const reordered = [...data];
      const [moved] = reordered.splice(oldIndex, 1);
      reordered.splice(newIndex, 0, moved);
      onReorder(reordered);
    },
    [data, onReorder],
  );

  const rowIds = useMemo(() => (data || []).map((item) => item.id), [data]);

  if (loading) {
    return (
      <Paper sx={{ p: 2 }}>
        {Array.from({ length: 5 }).map((_, i) => (
          <Skeleton key={i} height={48} sx={{ mb: 1 }} />
        ))}
      </Paper>
    );
  }

  const rows = table.getRowModel().rows;

  const tableContent = (
    <Table size="small">
      <TableHead>
        {table.getHeaderGroups().map((headerGroup) => (
          <TableRow key={headerGroup.id}>
            {headerGroup.headers.map((header) => (
              <TableCell
                key={header.id}
                sx={{
                  width: header.getSize(),
                  fontFamily: '"Silkscreen", cursive',
                  fontSize: '0.8rem',
                  borderBottom: '2px solid',
                  borderColor: 'divider',
                }}
              >
                {header.isPlaceholder ? null : header.column.getCanSort() ? (
                  <TableSortLabel
                    active={!!header.column.getIsSorted()}
                    direction={header.column.getIsSorted() || 'asc'}
                    onClick={header.column.getToggleSortingHandler()}
                  >
                    {flexRender(
                      header.column.columnDef.header,
                      header.getContext(),
                    )}
                  </TableSortLabel>
                ) : (
                  flexRender(
                    header.column.columnDef.header,
                    header.getContext(),
                  )
                )}
              </TableCell>
            ))}
          </TableRow>
        ))}
      </TableHead>
      <TableBody>
        {rows.length === 0 ? (
          <TableRow>
            <TableCell
              colSpan={allColumns.length}
              align="center"
              sx={{ py: 4 }}
            >
              <Typography variant="body2" color="text.secondary">
                No data found
              </Typography>
            </TableCell>
          </TableRow>
        ) : onReorder ? (
          rows.map((row) => (
            <SortableTableRow key={row.original.id} id={row.original.id} hover>
              {row.getVisibleCells().map((cell) => (
                <TableCell key={cell.id}>
                  {flexRender(cell.column.columnDef.cell, cell.getContext())}
                </TableCell>
              ))}
            </SortableTableRow>
          ))
        ) : (
          rows.map((row) => (
            <TableRow key={row.id} hover>
              {row.getVisibleCells().map((cell) => (
                <TableCell key={cell.id}>
                  {flexRender(cell.column.columnDef.cell, cell.getContext())}
                </TableCell>
              ))}
            </TableRow>
          ))
        )}
      </TableBody>
    </Table>
  );

  return (
    <Box>
      <TextField
        size="small"
        variant="outlined"
        placeholder={searchPlaceholder}
        value={globalFilter}
        onChange={(e) => setGlobalFilter(e.target.value)}
        slotProps={{
          input: {
            startAdornment: (
              <InputAdornment position="start">
                <SearchIcon fontSize="small" />
              </InputAdornment>
            ),
          },
        }}
        sx={{ mb: 2, maxWidth: 360 }}
      />

      <Paper sx={{ overflow: 'auto' }}>
        {onReorder ? (
          <DndContext
            sensors={sensors}
            collisionDetection={closestCenter}
            modifiers={[restrictToVerticalAxis]}
            onDragEnd={handleDragEnd}
          >
            <SortableContext
              items={rowIds}
              strategy={verticalListSortingStrategy}
            >
              {tableContent}
            </SortableContext>
          </DndContext>
        ) : (
          tableContent
        )}
      </Paper>

      <TablePagination
        component="div"
        count={table.getFilteredRowModel().rows.length}
        page={pagination.pageIndex}
        onPageChange={(_, page) =>
          setPagination((prev) => ({ ...prev, pageIndex: page }))
        }
        rowsPerPage={pagination.pageSize}
        onRowsPerPageChange={(e) =>
          setPagination({
            pageIndex: 0,
            pageSize: parseInt(e.target.value, 10),
          })
        }
        rowsPerPageOptions={[10, 20, 50]}
      />
    </Box>
  );
}
