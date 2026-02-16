import TextField from '@mui/material/TextField';
import Box from '@mui/material/Box';
import MarkdownContent from '../../lesson/MarkdownContent.jsx';

/**
 * CodeOutput exercise: student sees a code snippet and predicts the output.
 *
 * exercise.content: markdown with a fenced code block (syntax highlighted)
 * exercise.correct_answer: expected output text (validated server-side)
 */
export default function CodeOutput({
  exercise,
  answer,
  onAnswerChange,
  disabled,
}) {
  return (
    <Box>
      {exercise.content && (
        <MarkdownContent
          content={exercise.content}
          sx={{ mb: 2, '& p:last-child': { mb: 0 } }}
        />
      )}

      <TextField
        fullWidth
        size="small"
        label="Dự đoán output"
        placeholder="Nhập kết quả output..."
        value={answer || ''}
        onChange={(e) => onAnswerChange(e.target.value)}
        disabled={disabled}
        autoComplete="off"
        multiline
        minRows={1}
        maxRows={4}
      />
    </Box>
  );
}
