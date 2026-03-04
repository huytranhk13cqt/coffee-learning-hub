import { useSortable } from '@dnd-kit/sortable';
import { CSS } from '@dnd-kit/utilities';
import IconButton from '@mui/material/IconButton';
import DragIndicatorIcon from '@mui/icons-material/DragIndicator';
import TableRow from '@mui/material/TableRow';

export function DragHandleCell({ id }) {
  const { attributes, listeners } = useSortable({ id });

  return (
    <IconButton
      size="small"
      sx={{ cursor: 'grab', '&:active': { cursor: 'grabbing' } }}
      {...attributes}
      {...listeners}
    >
      <DragIndicatorIcon fontSize="small" />
    </IconButton>
  );
}

export function SortableTableRow({ id, children, ...props }) {
  const { attributes, setNodeRef, transform, transition, isDragging } =
    useSortable({ id });

  const style = {
    transform: CSS.Transform.toString(transform),
    transition,
    opacity: isDragging ? 0.5 : 1,
  };

  return (
    <TableRow ref={setNodeRef} style={style} {...attributes} {...props}>
      {children}
    </TableRow>
  );
}
