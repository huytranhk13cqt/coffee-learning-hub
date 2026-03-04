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
import exerciseEditorRegistry from '../../components/admin/exercise-editors/index.js';
import {
  fetchAdminExercise,
  fetchAdminLessons,
  createAdminExercise,
  updateAdminExercise,
} from '../../api/admin.js';

export async function loader({ params }) {
  if (params.id) {
    const [exerciseRes, lessonsRes] = await Promise.all([
      fetchAdminExercise(params.id),
      fetchAdminLessons(),
    ]);
    return { exercise: exerciseRes.data, lessons: lessonsRes.data };
  }
  const lessonsRes = await fetchAdminLessons();
  return { exercise: null, lessons: lessonsRes.data };
}

const EXERCISE_TYPES = [
  { value: 'multiple_choice', label: 'Multiple Choice' },
  { value: 'fill_blank', label: 'Fill Blank' },
  { value: 'error_correction', label: 'Error Correction' },
  { value: 'sentence_transform', label: 'Sentence Transform' },
  { value: 'arrange_words', label: 'Arrange Words' },
  { value: 'matching', label: 'Matching' },
  { value: 'true_false', label: 'True / False' },
  { value: 'code_output', label: 'Code Output' },
];

const DIFFICULTIES = [
  { value: 'easy', label: 'Easy' },
  { value: 'medium', label: 'Medium' },
  { value: 'hard', label: 'Hard' },
];

const EMPTY_FORM = {
  lesson_id: '',
  type: 'multiple_choice',
  difficulty: 'medium',
  question: '',
  question_vi: '',
  content: '',
  content_vi: '',
  context: '',
  context_vi: '',
  correct_answer: '',
  word_bank: [],
  explanation: '',
  explanation_vi: '',
  hint: '',
  hint_vi: '',
  image_url: '',
  audio_url: '',
  points: 10,
  time_limit: '',
  is_active: true,
  options: [
    {
      label: 'A',
      content: '',
      content_vi: '',
      is_correct: false,
      explanation: '',
      explanation_vi: '',
    },
    {
      label: 'B',
      content: '',
      content_vi: '',
      is_correct: false,
      explanation: '',
      explanation_vi: '',
    },
  ],
  matching_pairs: [],
};

function exerciseToForm(ex) {
  return {
    lesson_id: ex.lesson_id ?? '',
    type: ex.type || 'multiple_choice',
    difficulty: ex.difficulty || 'medium',
    question: ex.question || '',
    question_vi: ex.question_vi || '',
    content: ex.content || '',
    content_vi: ex.content_vi || '',
    context: ex.context || '',
    context_vi: ex.context_vi || '',
    correct_answer: ex.correct_answer || '',
    word_bank: Array.isArray(ex.word_bank) ? ex.word_bank : [],
    explanation: ex.explanation || '',
    explanation_vi: ex.explanation_vi || '',
    hint: ex.hint || '',
    hint_vi: ex.hint_vi || '',
    image_url: ex.image_url || '',
    audio_url: ex.audio_url || '',
    points: ex.points ?? 10,
    time_limit: ex.time_limit ?? '',
    is_active: ex.is_active ?? true,
    options: (ex.options || []).map((o) => ({
      label: o.label || '',
      content: o.content || '',
      content_vi: o.content_vi || '',
      is_correct: o.is_correct ?? false,
      explanation: o.explanation || '',
      explanation_vi: o.explanation_vi || '',
    })),
    matching_pairs: (ex.matching_pairs || []).map((p) => ({
      left_content: p.left_content || '',
      left_content_vi: p.left_content_vi || '',
      right_content: p.right_content || '',
      right_content_vi: p.right_content_vi || '',
    })),
  };
}

export default function AdminExerciseFormPage() {
  const loaderData = useLoaderData();
  const navigate = useNavigate();
  const { id } = useParams();
  const isEdit = !!id;

  const [form, setForm] = useState(EMPTY_FORM);
  const [lessons, setLessons] = useState(loaderData?.lessons || []);
  const [errors, setErrors] = useState({});
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    setLessons(loaderData?.lessons || []);
    if (loaderData?.exercise) {
      setForm(exerciseToForm(loaderData.exercise));
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

  function handleTypeChange(newType) {
    setForm((prev) => {
      const next = { ...prev, type: newType };
      if (newType !== 'multiple_choice') next.options = [];
      if (newType !== 'matching') next.matching_pairs = [];
      if (newType !== 'arrange_words') next.word_bank = [];
      if (newType === 'multiple_choice' || newType === 'matching') {
        next.correct_answer = '';
      }
      if (newType === 'true_false') next.correct_answer = 'true';
      if (newType === 'multiple_choice' && prev.options.length === 0) {
        next.options = [
          {
            label: 'A',
            content: '',
            content_vi: '',
            is_correct: false,
            explanation: '',
            explanation_vi: '',
          },
          {
            label: 'B',
            content: '',
            content_vi: '',
            is_correct: false,
            explanation: '',
            explanation_vi: '',
          },
        ];
      }
      if (newType === 'matching' && prev.matching_pairs.length === 0) {
        next.matching_pairs = [
          {
            left_content: '',
            left_content_vi: '',
            right_content: '',
            right_content_vi: '',
          },
          {
            left_content: '',
            left_content_vi: '',
            right_content: '',
            right_content_vi: '',
          },
        ];
      }
      return next;
    });
  }

  function validate() {
    const errs = {};
    if (!form.lesson_id) errs.lesson_id = 'Lesson is required';
    if (!form.question.trim()) errs.question = 'Question is required';

    if (form.type === 'multiple_choice') {
      if (form.options.length < 2) errs.options = 'At least 2 options required';
      if (!form.options.some((o) => o.is_correct))
        errs.options = 'One option must be correct';
      if (form.options.some((o) => !o.content.trim()))
        errs.options = 'All options need content';
    }
    if (form.type === 'matching') {
      if (form.matching_pairs.length < 2)
        errs.matching_pairs = 'At least 2 pairs required';
    }
    if (
      [
        'fill_blank',
        'error_correction',
        'sentence_transform',
        'code_output',
      ].includes(form.type)
    ) {
      if (!form.correct_answer.trim())
        errs.correct_answer = 'Correct answer is required';
    }
    if (form.type === 'arrange_words') {
      if (form.word_bank.length < 2)
        errs.word_bank = 'At least 2 words required';
      if (!form.correct_answer.trim())
        errs.correct_answer = 'Correct answer is required';
    }
    if (form.type === 'true_false') {
      if (!['true', 'false'].includes(form.correct_answer)) {
        errs.correct_answer = 'Must be true or false';
      }
    }
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
        lesson_id: Number(form.lesson_id),
        type: form.type,
        difficulty: form.difficulty,
        question: form.question,
        question_vi: form.question_vi || null,
        content: form.content || null,
        content_vi: form.content_vi || null,
        context: form.context || null,
        context_vi: form.context_vi || null,
        correct_answer: form.correct_answer || null,
        word_bank: form.word_bank.length > 0 ? form.word_bank : null,
        explanation: form.explanation || null,
        explanation_vi: form.explanation_vi || null,
        hint: form.hint || null,
        hint_vi: form.hint_vi || null,
        image_url: form.image_url || null,
        audio_url: form.audio_url || null,
        points: Number(form.points) || 10,
        time_limit: form.time_limit ? Number(form.time_limit) : null,
        is_active: form.is_active,
      };

      if (form.type === 'multiple_choice') {
        payload.options = form.options;
        payload.matching_pairs = [];
      } else if (form.type === 'matching') {
        payload.matching_pairs = form.matching_pairs;
        payload.options = [];
      } else {
        payload.options = [];
        payload.matching_pairs = [];
      }

      if (isEdit) {
        await updateAdminExercise(id, payload);
      } else {
        await createAdminExercise(payload);
      }
      navigate('/admin/exercises');
    } catch (err) {
      setErrors({ _server: err.message });
    } finally {
      setSaving(false);
    }
  }

  const TypeEditor = exerciseEditorRegistry[form.type];

  return (
    <Box>
      <Box sx={{ display: 'flex', alignItems: 'center', gap: 2, mb: 3 }}>
        <Button
          startIcon={<ArrowBackIcon />}
          onClick={() => navigate('/admin/exercises')}
        >
          Back
        </Button>
        <Typography variant="h2">
          {isEdit ? 'Edit Exercise' : 'New Exercise'}
        </Typography>
      </Box>

      {errors._server && (
        <Typography color="error" sx={{ mb: 2 }}>
          {errors._server}
        </Typography>
      )}

      {/* Paper 1: Basic Info */}
      <Paper sx={{ p: 3, mb: 3 }}>
        <Typography variant="h4" sx={{ mb: 2 }}>
          Basic Info
        </Typography>
        <Grid container spacing={2}>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              select
              label="Lesson"
              value={form.lesson_id}
              onChange={handleChange('lesson_id')}
              error={!!errors.lesson_id}
              helperText={errors.lesson_id}
            >
              <MenuItem value="">
                <em>Select lesson</em>
              </MenuItem>
              {lessons.map((l) => (
                <MenuItem key={l.id} value={l.id}>
                  {l.name}
                </MenuItem>
              ))}
            </AdminFormField>
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              select
              label="Type"
              value={form.type}
              onChange={(e) => handleTypeChange(e.target.value)}
            >
              {EXERCISE_TYPES.map((t) => (
                <MenuItem key={t.value} value={t.value}>
                  {t.label}
                </MenuItem>
              ))}
            </AdminFormField>
          </Grid>
          <Grid size={{ xs: 12, md: 4 }}>
            <AdminFormField
              select
              label="Difficulty"
              value={form.difficulty}
              onChange={handleChange('difficulty')}
            >
              {DIFFICULTIES.map((d) => (
                <MenuItem key={d.value} value={d.value}>
                  {d.label}
                </MenuItem>
              ))}
            </AdminFormField>
          </Grid>
          <Grid size={{ xs: 12, md: 4 }}>
            <AdminFormField
              label="Points"
              type="number"
              value={form.points}
              onChange={handleChange('points')}
              inputProps={{ min: 1, max: 100 }}
            />
          </Grid>
          <Grid size={{ xs: 12, md: 4 }}>
            <AdminFormField
              label="Time Limit (seconds)"
              type="number"
              value={form.time_limit}
              onChange={handleChange('time_limit')}
              inputProps={{ min: 1 }}
            />
          </Grid>
          <Grid size={12}>
            <FormControlLabel
              control={
                <Switch
                  checked={form.is_active}
                  onChange={handleChange('is_active')}
                />
              }
              label="Active"
            />
          </Grid>
        </Grid>
      </Paper>

      {/* Paper 2: Question & Content */}
      <Paper sx={{ p: 3, mb: 3 }}>
        <Typography variant="h4" sx={{ mb: 2 }}>
          Question & Content
        </Typography>
        <Grid container spacing={2}>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              label="Question"
              value={form.question}
              onChange={handleChange('question')}
              error={!!errors.question}
              helperText={errors.question}
            />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              label="Question (Vietnamese)"
              value={form.question_vi}
              onChange={handleChange('question_vi')}
            />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              label="Content"
              value={form.content}
              onChange={handleChange('content')}
              multiline
              rows={3}
            />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              label="Content (Vietnamese)"
              value={form.content_vi}
              onChange={handleChange('content_vi')}
              multiline
              rows={3}
            />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              label="Context"
              value={form.context}
              onChange={handleChange('context')}
              multiline
              rows={2}
            />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              label="Context (Vietnamese)"
              value={form.context_vi}
              onChange={handleChange('context_vi')}
              multiline
              rows={2}
            />
          </Grid>
        </Grid>
      </Paper>

      {/* Paper 3: Type-Specific */}
      <Paper sx={{ p: 3, mb: 3 }}>
        <Typography variant="h4" sx={{ mb: 2 }}>
          {form.type
            .replace(/_/g, ' ')
            .replace(/\b\w/g, (c) => c.toUpperCase())}{' '}
          Settings
        </Typography>
        {TypeEditor && (
          <TypeEditor form={form} setForm={setForm} errors={errors} />
        )}
      </Paper>

      {/* Paper 4: Hints & Explanation */}
      <Paper sx={{ p: 3, mb: 3 }}>
        <Typography variant="h4" sx={{ mb: 2 }}>
          Hints & Explanation
        </Typography>
        <Grid container spacing={2}>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              label="Explanation"
              value={form.explanation}
              onChange={handleChange('explanation')}
              multiline
              rows={3}
            />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              label="Explanation (Vietnamese)"
              value={form.explanation_vi}
              onChange={handleChange('explanation_vi')}
              multiline
              rows={3}
            />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              label="Hint"
              value={form.hint}
              onChange={handleChange('hint')}
              inputProps={{ maxLength: 255 }}
            />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <AdminFormField
              label="Hint (Vietnamese)"
              value={form.hint_vi}
              onChange={handleChange('hint_vi')}
              inputProps={{ maxLength: 255 }}
            />
          </Grid>
        </Grid>
      </Paper>

      <Divider sx={{ mb: 3 }} />

      <Box sx={{ display: 'flex', gap: 2, justifyContent: 'flex-end' }}>
        <Button onClick={() => navigate('/admin/exercises')}>Cancel</Button>
        <Button
          variant="contained"
          startIcon={<SaveIcon />}
          onClick={handleSubmit}
          loading={saving}
        >
          {isEdit ? 'Save Changes' : 'Create Exercise'}
        </Button>
      </Box>
    </Box>
  );
}
