import Typography from '@mui/material/Typography';
import Alert from '@mui/material/Alert';
import MarkdownContent from '../MarkdownContent.jsx';

const INFO_BOX_SEVERITY = {
  info: 'info',
  warning: 'warning',
  tip: 'success',
  example: 'info',
};

export default function InfoBoxSection({ section }) {
  const variant = section.metadata?.variant || 'info';
  const severity = INFO_BOX_SEVERITY[variant] || 'info';

  return (
    <Alert
      severity={severity}
      sx={{ '& .MuiAlert-message': { width: '100%' } }}
    >
      {section.title_vi && (
        <Typography variant="subtitle2" fontWeight={600} gutterBottom>
          {section.title_vi}
        </Typography>
      )}
      <MarkdownContent
        content={section.content_vi || section.content}
        sx={{ '& p:last-child': { mb: 0 } }}
      />
    </Alert>
  );
}
