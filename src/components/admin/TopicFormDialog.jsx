import { useState, useEffect } from 'react';
import Dialog from '@mui/material/Dialog';
import DialogTitle from '@mui/material/DialogTitle';
import DialogContent from '@mui/material/DialogContent';
import DialogActions from '@mui/material/DialogActions';
import Button from '@mui/material/Button';
import AdminFormField from './AdminFormField.jsx';
import ColorPickerField from './ColorPickerField.jsx';
import IconPickerField from './IconPickerField.jsx';

const EMPTY_FORM = {
  name: '',
  name_vi: '',
  description: '',
  description_vi: '',
  icon: '',
  color: '',
};

export default function TopicFormDialog({
  open,
  onClose,
  onSave,
  initialData,
}) {
  const [form, setForm] = useState(EMPTY_FORM);
  const [errors, setErrors] = useState({});
  const [saving, setSaving] = useState(false);

  const isEdit = !!initialData;

  useEffect(() => {
    if (open) {
      setForm(
        initialData
          ? {
              name: initialData.name || '',
              name_vi: initialData.name_vi || '',
              description: initialData.description || '',
              description_vi: initialData.description_vi || '',
              icon: initialData.icon || '',
              color: initialData.color || '',
            }
          : EMPTY_FORM,
      );
      setErrors({});
      setSaving(false);
    }
  }, [open, initialData]);

  function handleChange(field) {
    return (e) => {
      const value = typeof e === 'string' ? e : e.target.value;
      setForm((prev) => ({ ...prev, [field]: value }));
      if (errors[field]) setErrors((prev) => ({ ...prev, [field]: null }));
    };
  }

  function validate() {
    const errs = {};
    if (!form.name.trim()) errs.name = 'Name is required';
    if (!form.name_vi.trim()) errs.name_vi = 'Vietnamese name is required';
    if (!form.color || !/^#[0-9A-Fa-f]{6}$/.test(form.color))
      errs.color = 'Valid hex color is required';
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
      const payload = { ...form };
      if (!payload.description) payload.description = null;
      if (!payload.description_vi) payload.description_vi = null;
      if (!payload.icon) payload.icon = null;
      await onSave(payload);
      onClose();
    } catch (err) {
      setErrors({ _server: err.message });
    } finally {
      setSaving(false);
    }
  }

  return (
    <Dialog
      open={open}
      onClose={saving ? undefined : onClose}
      maxWidth="sm"
      fullWidth
    >
      <DialogTitle>{isEdit ? 'Edit Topic' : 'New Topic'}</DialogTitle>
      <DialogContent>
        <AdminFormField
          label="Name"
          value={form.name}
          onChange={handleChange('name')}
          error={!!errors.name}
          helperText={errors.name}
          sx={{ mt: 1 }}
        />
        <AdminFormField
          label="Name (Vietnamese)"
          value={form.name_vi}
          onChange={handleChange('name_vi')}
          error={!!errors.name_vi}
          helperText={errors.name_vi}
        />
        <AdminFormField
          label="Description"
          value={form.description}
          onChange={handleChange('description')}
          multiline
          rows={2}
        />
        <AdminFormField
          label="Description (Vietnamese)"
          value={form.description_vi}
          onChange={handleChange('description_vi')}
          multiline
          rows={2}
        />
        <IconPickerField
          value={form.icon}
          onChange={handleChange('icon')}
          label="Icon"
        />
        <ColorPickerField
          value={form.color}
          onChange={handleChange('color')}
          label="Color"
          error={!!errors.color}
          helperText={errors.color}
        />
        {errors._server && (
          <AdminFormField
            value=""
            error
            helperText={errors._server}
            sx={{ display: 'none' }}
          />
        )}
      </DialogContent>
      <DialogActions>
        <Button onClick={onClose} disabled={saving}>
          Cancel
        </Button>
        <Button onClick={handleSubmit} variant="contained" loading={saving}>
          {isEdit ? 'Save' : 'Create'}
        </Button>
      </DialogActions>
    </Dialog>
  );
}
