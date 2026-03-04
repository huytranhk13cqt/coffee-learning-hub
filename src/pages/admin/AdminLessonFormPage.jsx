import { useState, useEffect } from 'react';
import { useLoaderData, useNavigate, useParams } from 'react-router';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import Paper from '@mui/material/Paper';
import Grid from '@mui/material/Grid';
import MenuItem from '@mui/material/MenuItem';
import Switch from '@mui/material/Switch';
import FormControlLabel from '@mui/material/FormControlLabel';
import Divider from '@mui/material/Divider';
import ArrowBackIcon from '@mui/icons-material/ArrowBack';
import SaveIcon from '@mui/icons-material/Save';
import AdminFormField from '../../components/admin/AdminFormField.jsx';
import {
  fetchAdminLesson,
  fetchAdminCategories,
  createAdminLesson,
  updateAdminLesson,
} from '../../api/admin.js';

export async function loader({ params }) {
  if (params.id) {
    const [lessonRes, categoriesRes] = await Promise.all([
      fetchAdminLesson(params.id),
      fetchAdminCategories(),
    ]);
    return { lesson: lessonRes.data, categories: categoriesRes.data };
  }
  const categoriesRes = await fetchAdminCategories();
  return { lesson: null, categories: categoriesRes.data };
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
  short_desc: '',
  short_desc_vi: '',
  description: '',
  description_vi: '',
  group_id: '',
  difficulty: 'beginner',
  estimated_time: '',
  is_published: false,
};

export default function AdminLessonFormPage() {
  const loaderData = useLoaderData();
  const navigate = useNavigate();
  const { id } = useParams();
  const isEdit = !!id;

  const [form, setForm] = useState(EMPTY_FORM);
  const [categories, setCategories] = useState(loaderData?.categories || []);
  const [errors, setErrors] = useState({});
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    setCategories(loaderData?.categories || []);
    if (loaderData?.lesson) {
      const l = loaderData.lesson;
      setForm({
        name: l.name || '',
        name_vi: l.name_vi || '',
        short_desc: l.short_desc || '',
        short_desc_vi: l.short_desc_vi || '',
        description: l.description || '',
        description_vi: l.description_vi || '',
        group_id: l.group_id ?? '',
        difficulty: l.difficulty || 'beginner',
        estimated_time: l.estimated_time ?? '',
        is_published: l.is_published ?? false,
      });
    } else {
      setForm(EMPTY_FORM);
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
    if (!form.group_id) errs.group_id = 'Category is required';
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
        ...form,
        group_id: Number(form.group_id),
        estimated_time: form.estimated_time
          ? Number(form.estimated_time)
          : null,
        short_desc: form.short_desc || null,
        short_desc_vi: form.short_desc_vi || null,
        description: form.description || null,
        description_vi: form.description_vi || null,
      };

      if (isEdit) {
        await updateAdminLesson(id, payload);
      } else {
        await createAdminLesson(payload);
      }

      navigate('/admin/lessons');
    } catch (err) {
      setErrors({ _server: err.message });
    } finally {
      setSaving(false);
    }
  }

  const slugPreview = form.name ? slugify(form.name) : '';

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
          {isEdit ? 'Edit Lesson' : 'New Lesson'}
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
              label="Short Description"
              value={form.short_desc}
              onChange={handleChange('short_desc')}
              inputProps={{ maxLength: 255 }}
            />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              label="Short Description (Vietnamese)"
              value={form.short_desc_vi}
              onChange={handleChange('short_desc_vi')}
              inputProps={{ maxLength: 255 }}
            />
          </Grid>
        </Grid>
      </Paper>

      <Paper sx={{ p: 3, mb: 3 }}>
        <Typography variant="h4" sx={{ mb: 2 }}>
          Content
        </Typography>
        <AdminFormField
          label="Description"
          value={form.description}
          onChange={handleChange('description')}
          multiline
          rows={4}
        />
        <AdminFormField
          label="Description (Vietnamese)"
          value={form.description_vi}
          onChange={handleChange('description_vi')}
          multiline
          rows={4}
        />
      </Paper>

      <Paper sx={{ p: 3, mb: 3 }}>
        <Typography variant="h4" sx={{ mb: 2 }}>
          Settings
        </Typography>
        <Grid container spacing={2}>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              select
              label="Category"
              value={form.group_id}
              onChange={handleChange('group_id')}
              error={!!errors.group_id}
              helperText={errors.group_id}
            >
              <MenuItem value="">
                <em>Select category</em>
              </MenuItem>
              {categories.map((c) => (
                <MenuItem key={c.id} value={c.id}>
                  {c.name}
                </MenuItem>
              ))}
            </AdminFormField>
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              select
              label="Difficulty"
              value={form.difficulty}
              onChange={handleChange('difficulty')}
            >
              <MenuItem value="beginner">Beginner</MenuItem>
              <MenuItem value="intermediate">Intermediate</MenuItem>
              <MenuItem value="advanced">Advanced</MenuItem>
            </AdminFormField>
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              label="Estimated Time (minutes)"
              type="number"
              value={form.estimated_time}
              onChange={handleChange('estimated_time')}
              inputProps={{ min: 0 }}
            />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <FormControlLabel
              control={
                <Switch
                  checked={form.is_published}
                  onChange={handleChange('is_published')}
                />
              }
              label="Published"
              sx={{ mt: 1 }}
            />
          </Grid>
        </Grid>
      </Paper>

      <Divider sx={{ mb: 3 }} />

      <Box sx={{ display: 'flex', gap: 2, justifyContent: 'flex-end' }}>
        <Button onClick={() => navigate('/admin/lessons')}>Cancel</Button>
        <Button
          variant="contained"
          startIcon={<SaveIcon />}
          onClick={handleSubmit}
          loading={saving}
        >
          {isEdit ? 'Save Changes' : 'Create Lesson'}
        </Button>
      </Box>
    </Box>
  );
}
