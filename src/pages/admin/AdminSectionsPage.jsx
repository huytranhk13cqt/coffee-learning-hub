import { useState, useEffect, useCallback } from 'react';
import { useLoaderData, useNavigate, useParams } from 'react-router';
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
  useSortable,
} from '@dnd-kit/sortable';
import { restrictToVerticalAxis } from '@dnd-kit/modifiers';
import { CSS } from '@dnd-kit/utilities';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import Paper from '@mui/material/Paper';
import Chip from '@mui/material/Chip';
import IconButton from '@mui/material/IconButton';
import Collapse from '@mui/material/Collapse';
import TextField from '@mui/material/TextField';
import MenuItem from '@mui/material/MenuItem';
import ArrowBackIcon from '@mui/icons-material/ArrowBack';
import AddIcon from '@mui/icons-material/Add';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import ExpandLessIcon from '@mui/icons-material/ExpandLess';
import DeleteIcon from '@mui/icons-material/Delete';
import SaveIcon from '@mui/icons-material/Save';
import DragIndicatorIcon from '@mui/icons-material/DragIndicator';
import {
  fetchAdminSections,
  createAdminSection,
  updateAdminSection,
  deleteAdminSection,
  reorderAdminSections,
} from '../../api/admin.js';
import DeleteConfirmDialog from '../../components/admin/DeleteConfirmDialog.jsx';

const SECTION_TYPES = [
  'markdown',
  'key_points',
  'info_box',
  'audio',
  'video',
  'chart',
  'diagram',
  'image',
  'interactive_chart',
];

const TEXT_TYPES = new Set(['markdown', 'key_points', 'info_box']);

export async function loader({ params }) {
  return fetchAdminSections(params.id);
}

function SortableSectionCard({
  section,
  expanded,
  onToggle,
  onSave,
  onDelete,
}) {
  const {
    attributes,
    listeners,
    setNodeRef,
    transform,
    transition,
    isDragging,
  } = useSortable({ id: section.id });

  const style = {
    transform: CSS.Transform.toString(transform),
    transition,
    opacity: isDragging ? 0.5 : 1,
  };

  const [form, setForm] = useState({
    title: section.title || '',
    title_vi: section.title_vi || '',
    content: section.content || '',
    content_vi: section.content_vi || '',
    metadata: JSON.stringify(section.metadata || {}, null, 2),
  });
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    setForm({
      title: section.title || '',
      title_vi: section.title_vi || '',
      content: section.content || '',
      content_vi: section.content_vi || '',
      metadata: JSON.stringify(section.metadata || {}, null, 2),
    });
  }, [section]);

  function handleChange(field) {
    return (e) => setForm((prev) => ({ ...prev, [field]: e.target.value }));
  }

  async function handleSave() {
    setSaving(true);
    try {
      let metadata;
      try {
        metadata = JSON.parse(form.metadata);
      } catch {
        metadata = section.metadata || {};
      }
      await onSave(section.id, {
        title: form.title || null,
        title_vi: form.title_vi || null,
        content: form.content || null,
        content_vi: form.content_vi || null,
        metadata,
      });
    } finally {
      setSaving(false);
    }
  }

  const isTextType = TEXT_TYPES.has(section.type);
  const contentPreview = section.content
    ? section.content.slice(0, 100) +
      (section.content.length > 100 ? '...' : '')
    : '';

  return (
    <Paper ref={setNodeRef} style={style} sx={{ mb: 2, overflow: 'hidden' }}>
      <Box
        sx={{
          display: 'flex',
          alignItems: 'center',
          gap: 1,
          px: 2,
          py: 1.5,
          borderBottom: expanded ? '2px solid' : 'none',
          borderColor: 'divider',
        }}
      >
        <IconButton
          size="small"
          sx={{ cursor: 'grab', '&:active': { cursor: 'grabbing' } }}
          {...attributes}
          {...listeners}
        >
          <DragIndicatorIcon fontSize="small" />
        </IconButton>

        <Chip
          label={section.type}
          size="small"
          color="primary"
          variant="outlined"
        />

        <Typography variant="body1" sx={{ flex: 1, fontWeight: 'bold' }}>
          {section.title || <em style={{ opacity: 0.5 }}>Untitled</em>}
        </Typography>

        {!expanded && contentPreview && (
          <Typography
            variant="caption"
            color="text.secondary"
            sx={{
              flex: 2,
              overflow: 'hidden',
              textOverflow: 'ellipsis',
              whiteSpace: 'nowrap',
            }}
          >
            {contentPreview}
          </Typography>
        )}

        <IconButton
          size="small"
          color="error"
          onClick={() => onDelete(section)}
        >
          <DeleteIcon fontSize="small" />
        </IconButton>

        <IconButton size="small" onClick={onToggle}>
          {expanded ? <ExpandLessIcon /> : <ExpandMoreIcon />}
        </IconButton>
      </Box>

      <Collapse in={expanded}>
        <Box sx={{ p: 2 }}>
          <TextField
            fullWidth
            size="small"
            label="Title"
            value={form.title}
            onChange={handleChange('title')}
            sx={{ mb: 2 }}
          />
          <TextField
            fullWidth
            size="small"
            label="Title (Vietnamese)"
            value={form.title_vi}
            onChange={handleChange('title_vi')}
            sx={{ mb: 2 }}
          />
          {isTextType ? (
            <>
              <TextField
                fullWidth
                size="small"
                label="Content"
                value={form.content}
                onChange={handleChange('content')}
                multiline
                rows={6}
                sx={{ mb: 2 }}
              />
              <TextField
                fullWidth
                size="small"
                label="Content (Vietnamese)"
                value={form.content_vi}
                onChange={handleChange('content_vi')}
                multiline
                rows={6}
                sx={{ mb: 2 }}
              />
            </>
          ) : (
            <TextField
              fullWidth
              size="small"
              label="Content (URL or reference)"
              value={form.content}
              onChange={handleChange('content')}
              sx={{ mb: 2 }}
            />
          )}
          <TextField
            fullWidth
            size="small"
            label="Metadata (JSON)"
            value={form.metadata}
            onChange={handleChange('metadata')}
            multiline
            rows={4}
            sx={{ mb: 2 }}
          />
          <Button
            variant="contained"
            size="small"
            startIcon={<SaveIcon />}
            onClick={handleSave}
            loading={saving}
          >
            Save Section
          </Button>
        </Box>
      </Collapse>
    </Paper>
  );
}

export default function AdminSectionsPage() {
  const loaderData = useLoaderData();
  const navigate = useNavigate();
  const { id: lessonId } = useParams();

  const [lesson, setLesson] = useState(loaderData?.data?.lesson || null);
  const [sections, setSections] = useState(loaderData?.data?.sections || []);
  const [expandedId, setExpandedId] = useState(null);
  const [deleteItem, setDeleteItem] = useState(null);
  const [deleting, setDeleting] = useState(false);
  const [addingType, setAddingType] = useState('');

  useEffect(() => {
    setLesson(loaderData?.data?.lesson || null);
    setSections(loaderData?.data?.sections || []);
  }, [loaderData]);

  const sensors = useSensors(
    useSensor(PointerSensor, { activationConstraint: { distance: 5 } }),
    useSensor(KeyboardSensor),
  );

  const handleDragEnd = useCallback(
    (event) => {
      const { active, over } = event;
      if (!over || active.id === over.id) return;

      const oldIndex = sections.findIndex((s) => s.id === active.id);
      const newIndex = sections.findIndex((s) => s.id === over.id);
      if (oldIndex === -1 || newIndex === -1) return;

      const reordered = [...sections];
      const [moved] = reordered.splice(oldIndex, 1);
      reordered.splice(newIndex, 0, moved);
      setSections(reordered);
      reorderAdminSections(
        lessonId,
        reordered.map((s) => s.id),
      );
    },
    [sections, lessonId],
  );

  async function handleAddSection() {
    if (!addingType) return;
    try {
      const res = await createAdminSection(lessonId, { type: addingType });
      setSections((prev) => [...prev, res.data]);
      setExpandedId(res.data.id);
      setAddingType('');
    } catch {
      // Silently handle — user can retry
    }
  }

  async function handleSaveSection(sectionId, data) {
    const res = await updateAdminSection(sectionId, data);
    setSections((prev) =>
      prev.map((s) => (s.id === sectionId ? { ...s, ...res.data } : s)),
    );
  }

  async function handleDelete() {
    if (!deleteItem) return;
    setDeleting(true);
    try {
      await deleteAdminSection(deleteItem.id);
      setSections((prev) => prev.filter((s) => s.id !== deleteItem.id));
      setDeleteItem(null);
    } finally {
      setDeleting(false);
    }
  }

  const sectionIds = sections.map((s) => s.id);

  return (
    <Box>
      <Box sx={{ display: 'flex', alignItems: 'center', gap: 2, mb: 3 }}>
        <Button
          startIcon={<ArrowBackIcon />}
          onClick={() => navigate('/admin/lessons')}
        >
          Back
        </Button>
        <Typography variant="h2">
          Sections: {lesson?.name || 'Loading...'}
        </Typography>
      </Box>

      <DndContext
        sensors={sensors}
        collisionDetection={closestCenter}
        modifiers={[restrictToVerticalAxis]}
        onDragEnd={handleDragEnd}
      >
        <SortableContext
          items={sectionIds}
          strategy={verticalListSortingStrategy}
        >
          {sections.map((section) => (
            <SortableSectionCard
              key={section.id}
              section={section}
              expanded={expandedId === section.id}
              onToggle={() =>
                setExpandedId((prev) =>
                  prev === section.id ? null : section.id,
                )
              }
              onSave={handleSaveSection}
              onDelete={setDeleteItem}
            />
          ))}
        </SortableContext>
      </DndContext>

      {sections.length === 0 && (
        <Paper sx={{ p: 4, textAlign: 'center', mb: 2 }}>
          <Typography variant="body1" color="text.secondary">
            No sections yet. Add one below.
          </Typography>
        </Paper>
      )}

      <Paper sx={{ p: 2, display: 'flex', alignItems: 'center', gap: 2 }}>
        <Typography variant="body2" sx={{ whiteSpace: 'nowrap' }}>
          Add Section:
        </Typography>
        <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 0.5, flex: 1 }}>
          {SECTION_TYPES.map((type) => (
            <Chip
              key={type}
              label={type}
              size="small"
              variant={addingType === type ? 'filled' : 'outlined'}
              color={addingType === type ? 'primary' : 'default'}
              onClick={() => setAddingType(type)}
              sx={{ cursor: 'pointer' }}
            />
          ))}
        </Box>
        <Button
          variant="contained"
          size="small"
          startIcon={<AddIcon />}
          onClick={handleAddSection}
          disabled={!addingType}
        >
          Add
        </Button>
      </Paper>

      <DeleteConfirmDialog
        open={!!deleteItem}
        title="Delete Section"
        message={`Delete this ${deleteItem?.type} section? This cannot be undone.`}
        onConfirm={handleDelete}
        onCancel={() => setDeleteItem(null)}
        loading={deleting}
      />
    </Box>
  );
}
