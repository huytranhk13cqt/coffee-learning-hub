import Typography from '@mui/material/Typography';
import { PixelFrame } from '../../pixel/index.js';
import MarkdownContent from '../MarkdownContent.jsx';

export default function KeyPointsSection({ section }) {
  return (
    <PixelFrame variant="default" sx={{ p: 2.5 }}>
      <Typography variant="h6" gutterBottom>
        {section.title_vi || section.title || 'Điểm chính'}
      </Typography>
      <MarkdownContent content={section.content_vi || section.content} />
    </PixelFrame>
  );
}
