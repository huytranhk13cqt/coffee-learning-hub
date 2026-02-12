import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import Paper from '@mui/material/Paper';
import Alert from '@mui/material/Alert';
import MarkdownContent from './MarkdownContent.jsx';

// --- Section type components ---

function MarkdownSection({ section }) {
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

function KeyPointsSection({ section }) {
  return (
    <Paper variant="outlined" sx={{ p: 2.5 }}>
      <Typography variant="h6" gutterBottom>
        {section.title_vi || section.title || 'Điểm chính'}
      </Typography>
      <MarkdownContent content={section.content_vi || section.content} />
    </Paper>
  );
}

const INFO_BOX_SEVERITY = {
  info: 'info',
  warning: 'warning',
  tip: 'success',
  example: 'info',
};

function InfoBoxSection({ section }) {
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

// --- Section type registry ---

const SECTION_REGISTRY = {
  markdown: MarkdownSection,
  key_points: KeyPointsSection,
  info_box: InfoBoxSection,
};

// --- Main renderer ---

export default function SectionRenderer({ sections }) {
  if (!sections || sections.length === 0) return null;

  return sections.map((section) => {
    const Component = SECTION_REGISTRY[section.type];
    if (!Component) return null;

    return <Component key={section.id} section={section} />;
  });
}
