import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import MarkdownContent from '../MarkdownContent.jsx';

export default function MarkdownSection({ section }) {
  return (
    <Box>
      {section.title_vi && (
        <Typography variant="h6" gutterBottom>
          {section.title_vi}
        </Typography>
      )}
      <MarkdownContent content={section.content_vi || section.content} />
    </Box>
  );
}
