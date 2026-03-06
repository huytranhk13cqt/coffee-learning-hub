import { useState, useEffect, useCallback, useMemo } from 'react';
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
import Grid from '@mui/material/Grid';
import Switch from '@mui/material/Switch';
import FormControlLabel from '@mui/material/FormControlLabel';
import Divider from '@mui/material/Divider';
import IconButton from '@mui/material/IconButton';
import Autocomplete from '@mui/material/Autocomplete';
import TextField from '@mui/material/TextField';
import ArrowBackIcon from '@mui/icons-material/ArrowBack';
import SaveIcon from '@mui/icons-material/Save';
import DeleteIcon from '@mui/icons-material/Delete';
import DragIndicatorIcon from '@mui/icons-material/DragIndicator';
import AddIcon from '@mui/icons-material/Add';
import AdminFormField from '../../components/admin/AdminFormField.jsx';
import IconPickerField from '../../components/admin/IconPickerField.jsx';
import {
  fetchAdminPath,
  fetchAdminLessons,
  createAdminPath,
  updateAdminPath,
  replaceAdminPathSteps,
} from '../../api/admin.js';

export async function loader({ params }) {
  if (params.id) {
    const [pathRes, lessonsRes] = await Promise.all([
      fetchAdminPath(params.id),
      fetchAdminLessons(),
    ]);
    return { path: pathRes.data, lessons: lessonsRes.data };
  }
  const lessonsRes = await fetchAdminLessons();
  return { path: null, lessons: lessonsRes.data };
}

function slugify(text) {
  return text
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/đ/g, 'd')
    .replace(/Đ/g, 'D')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-|-$/g, '');
}

const EMPTY_FORM = {
  name: '',
  name_vi: '',
  slug: '',
  description: '',
  description_vi: '',
  icon: 'RouteOutlined',
  color: '#6366f1',
  estimated_days: 7,
  is_featured: false,
  is_active: true,
};

function SortableStepItem({ step, index, onRemove }) {
  const {
    attributes,
    listeners,
    setNodeRef,
    transform,
    transition,
    isDragging,
  } = useSortable({ id: step.lesson_id });

  const style = {
    transform: CSS.Transform.toString(transform),
    transition,
    opacity: isDragging ? 0.5 : 1,
  };

  return (
    <Paper
      ref={setNodeRef}
      style={style}
      {...attributes}
      sx={{
        display: 'flex',
        alignItems: 'center',
        gap: 1,
        px: 2,
        py: 1,
        mb: 1,
      }}
    >
      <IconButton
        size="small"
        sx={{ cursor: 'grab', '&:active': { cursor: 'grabbing' } }}
        {...listeners}
      >
        <DragIndicatorIcon fontSize="small" />
      </IconButton>
      <Typography
        variant="body2"
        sx={{ fontWeight: 'bold', minWidth: 24, textAlign: 'center' }}
      >
        {index + 1}
      </Typography>
      <Box sx={{ flex: 1 }}>
        <Typography variant="body1">{step.lesson_name}</Typography>
        <Typography variant="caption" color="text.secondary">
          {step.category_name}
        </Typography>
      </Box>
      <IconButton
        size="small"
        color="error"
        onClick={() => onRemove(step.lesson_id)}
      >
        <DeleteIcon fontSize="small" />
      </IconButton>
    </Paper>
  );
}

export default function AdminLearningPathFormPage() {
  const loaderData = useLoaderData();
  const navigate = useNavigate();
  const { id } = useParams();
  const isEdit = !!id;

  const [form, setForm] = useState(EMPTY_FORM);
  const [lessons, setLessons] = useState(loaderData?.lessons || []);
  const [steps, setSteps] = useState([]);
  const [errors, setErrors] = useState({});
  const [saving, setSaving] = useState(false);
  const [savingSteps, setSavingSteps] = useState(false);
  const [stepPickerValue, setStepPickerValue] = useState(null);

  useEffect(() => {
    setLessons(loaderData?.lessons || []);
    if (loaderData?.path) {
      const p = loaderData.path;
      setForm({
        name: p.name || '',
        name_vi: p.name_vi || '',
        slug: p.slug || '',
        description: p.description || '',
        description_vi: p.description_vi || '',
        icon: p.icon || 'RouteOutlined',
        color: p.color || '#6366f1',
        estimated_days: p.estimated_days ?? 7,
        is_featured: p.is_featured ?? false,
        is_active: p.is_active ?? true,
      });
      setSteps(
        (p.steps || []).map((s) => ({
          lesson_id: s.lesson_id,
          lesson_name: s.lesson_name,
          lesson_name_vi: s.lesson_name_vi,
          category_name: s.category_name,
        })),
      );
    } else {
      setForm(EMPTY_FORM);
      setSteps([]);
    }
  }, [loaderData]);

  function handleChange(field) {
    return (e) => {
      const value =
        e.target.type === 'checkbox' ? e.target.checked : e.target.value;
      setForm((prev) => ({ ...prev, [field]: value }));
      if (errors[field]) setErrors((prev) => ({ ...prev, [field]: null }));
    };
  }

  function validate() {
    const errs = {};
    if (!form.name.trim()) errs.name = 'Name is required';
    if (!form.name_vi.trim()) errs.name_vi = 'Vietnamese name is required';
    return errs;
  }

  async function handleSubmit() {
    const errs = validate();
    if (Object.keys(errs).length > 0) {
      setErrors(errs);
      return;
    }

    setSaving(true);
    try {
      const payload = {
        name: form.name,
        name_vi: form.name_vi,
        slug: form.slug || slugify(form.name),
        description: form.description || null,
        description_vi: form.description_vi || null,
        icon: form.icon || 'RouteOutlined',
        color: form.color || '#6366f1',
        estimated_days: Number(form.estimated_days) || 7,
        is_featured: form.is_featured,
        is_active: form.is_active,
      };

      if (isEdit) {
        await updateAdminPath(id, payload);
      } else {
        const res = await createAdminPath(payload);
        navigate(`/admin/paths/${res.data.id}/edit`);
        return;
      }
      navigate('/admin/paths');
    } catch (err) {
      setErrors({ _server: err.message });
    } finally {
      setSaving(false);
    }
  }

  async function handleSaveSteps() {
    setSavingSteps(true);
    try {
      await replaceAdminPathSteps(
        id,
        steps.map((s) => ({ lesson_id: s.lesson_id })),
      );
      navigate('/admin/paths');
    } catch (err) {
      setErrors({ _steps: err.message });
    } finally {
      setSavingSteps(false);
    }
  }

  const stepLessonIds = useMemo(
    () => new Set(steps.map((s) => s.lesson_id)),
    [steps],
  );

  const availableLessons = useMemo(
    () => lessons.filter((l) => !stepLessonIds.has(l.id)),
    [lessons, stepLessonIds],
  );

  function handleAddStep(lesson) {
    if (!lesson) return;
    setSteps((prev) => [
      ...prev,
      {
        lesson_id: lesson.id,
        lesson_name: lesson.name,
        lesson_name_vi: lesson.name_vi,
        category_name: lesson.category_name,
      },
    ]);
    setStepPickerValue(null);
  }

  function handleRemoveStep(lessonId) {
    setSteps((prev) => prev.filter((s) => s.lesson_id !== lessonId));
  }

  const sensors = useSensors(
    useSensor(PointerSensor, { activationConstraint: { distance: 5 } }),
    useSensor(KeyboardSensor),
  );

  const handleDragEnd = useCallback(
    (event) => {
      const { active, over } = event;
      if (!over || active.id === over.id) return;

      const oldIndex = steps.findIndex((s) => s.lesson_id === active.id);
      const newIndex = steps.findIndex((s) => s.lesson_id === over.id);
      if (oldIndex === -1 || newIndex === -1) return;

      const reordered = [...steps];
      const [moved] = reordered.splice(oldIndex, 1);
      reordered.splice(newIndex, 0, moved);
      setSteps(reordered);
    },
    [steps],
  );

  const stepIds = useMemo(() => steps.map((s) => s.lesson_id), [steps]);

  const slugPreview = form.name ? form.slug || slugify(form.name) : '';

  return (
    <Box>
      <Box sx={{ display: 'flex', alignItems: 'center', gap: 2, mb: 3 }}>
        <Button
          startIcon={<ArrowBackIcon />}
          onClick={() => navigate('/admin/paths')}
        >
          Back
        </Button>
        <Typography variant="h2">
          {isEdit ? 'Edit Learning Path' : 'New Learning Path'}
        </Typography>
      </Box>

      {errors._server && (
        <Typography color="error" sx={{ mb: 2 }}>
          {errors._server}
        </Typography>
      )}

      <Paper sx={{ p: 3, mb: 3 }}>
        <Typography variant="h4" sx={{ mb: 2 }}>
          Basic Info
        </Typography>
        <Grid container spacing={2}>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              label="Name"
              value={form.name}
              onChange={handleChange('name')}
              error={!!errors.name}
              helperText={errors.name}
            />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              label="Name (Vietnamese)"
              value={form.name_vi}
              onChange={handleChange('name_vi')}
              error={!!errors.name_vi}
              helperText={errors.name_vi}
            />
          </Grid>
          <Grid size={12}>
            <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
              Slug preview: <strong>{slugPreview || '...'}</strong>
            </Typography>
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              label="Description"
              value={form.description}
              onChange={handleChange('description')}
              multiline
              rows={3}
            />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              label="Description (Vietnamese)"
              value={form.description_vi}
              onChange={handleChange('description_vi')}
              multiline
              rows={3}
            />
          </Grid>
        </Grid>
      </Paper>

      <Paper sx={{ p: 3, mb: 3 }}>
        <Typography variant="h4" sx={{ mb: 2 }}>
          Settings
        </Typography>
        <Grid container spacing={2}>
          <Grid size={{ xs: 12, md: 6 }}>
            <IconPickerField
              label="Icon"
              value={form.icon}
              onChange={(val) => setForm((prev) => ({ ...prev, icon: val }))}
            />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              label="Color (hex)"
              value={form.color}
              onChange={handleChange('color')}
              inputProps={{ maxLength: 7 }}
            />
          </Grid>
          <Grid size={{ xs: 12, md: 4 }}>
            <AdminFormField
              label="Estimated Days"
              type="number"
              value={form.estimated_days}
              onChange={handleChange('estimated_days')}
              inputProps={{ min: 1, max: 365 }}
            />
          </Grid>
          <Grid size={{ xs: 12, md: 4 }}>
            <FormControlLabel
              control={
                <Switch
                  checked={form.is_featured}
                  onChange={handleChange('is_featured')}
                />
              }
              label="Featured"
              sx={{ mt: 1 }}
            />
          </Grid>
          <Grid size={{ xs: 12, md: 4 }}>
            <FormControlLabel
              control={
                <Switch
                  checked={form.is_active}
                  onChange={handleChange('is_active')}
                />
              }
              label="Active"
              sx={{ mt: 1 }}
            />
          </Grid>
        </Grid>
      </Paper>

      <Box sx={{ display: 'flex', gap: 2, justifyContent: 'flex-end', mb: 3 }}>
        <Button onClick={() => navigate('/admin/paths')}>Cancel</Button>
        <Button
          variant="contained"
          startIcon={<SaveIcon />}
          onClick={handleSubmit}
          loading={saving}
        >
          {isEdit ? 'Save Metadata' : 'Create Path'}
        </Button>
      </Box>

      {isEdit && (
        <>
          <Divider sx={{ mb: 3 }} />

          <Paper sx={{ p: 3, mb: 3 }}>
            <Typography variant="h4" sx={{ mb: 2 }}>
              Steps ({steps.length} lessons)
            </Typography>

            {errors._steps && (
              <Typography color="error" sx={{ mb: 2 }}>
                {errors._steps}
              </Typography>
            )}

            <Box sx={{ mb: 2 }}>
              <Autocomplete
                value={stepPickerValue}
                onChange={(_, newVal) => handleAddStep(newVal)}
                options={availableLessons}
                getOptionLabel={(option) =>
                  `${option.name} (${option.category_name || 'No category'})`
                }
                renderInput={(params) => (
                  <TextField
                    {...params}
                    label="Add lesson to path"
                    size="small"
                    variant="outlined"
                  />
                )}
                sx={{ maxWidth: 500 }}
              />
            </Box>

            {steps.length === 0 ? (
              <Typography variant="body2" color="text.secondary" sx={{ py: 2 }}>
                No steps yet. Use the picker above to add lessons.
              </Typography>
            ) : (
              <DndContext
                sensors={sensors}
                collisionDetection={closestCenter}
                modifiers={[restrictToVerticalAxis]}
                onDragEnd={handleDragEnd}
              >
                <SortableContext
                  items={stepIds}
                  strategy={verticalListSortingStrategy}
                >
                  {steps.map((step, idx) => (
                    <SortableStepItem
                      key={step.lesson_id}
                      step={step}
                      index={idx}
                      onRemove={handleRemoveStep}
                    />
                  ))}
                </SortableContext>
              </DndContext>
            )}

            <Box sx={{ display: 'flex', justifyContent: 'flex-end', mt: 2 }}>
              <Button
                variant="contained"
                startIcon={<SaveIcon />}
                onClick={handleSaveSteps}
                loading={savingSteps}
              >
                Save Steps
              </Button>
            </Box>
          </Paper>
        </>
      )}
    </Box>
  );
}
