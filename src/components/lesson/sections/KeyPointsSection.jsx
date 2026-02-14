import Typography from '@mui/material/Typography';
import Paper from '@mui/material/Paper';
import MarkdownContent from '../MarkdownContent.jsx';

export default function KeyPointsSection({ section }) {
  return (
    <Paper variant="outlined" sx={{ p: 2.5 }}>
      <Typography variant="h6" gutterBottom>
        {section.title_vi || section.title || 'Điểm chính'}
      </Typography>
      <MarkdownContent content={section.content_vi || section.content} />
    </Paper>
  );
}
