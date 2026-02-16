import { Suspense } from 'react';
import CircularProgress from '@mui/material/CircularProgress';
import Paper from '@mui/material/Paper';
import SectionErrorBoundary from './SectionErrorBoundary.jsx';
import sectionRegistry from './sectionRegistry.js';

const SectionFallback = (
  <Paper
    variant="outlined"
    sx={{ p: 4, display: 'flex', justifyContent: 'center' }}
  >
    <CircularProgress size={28} />
  </Paper>
);

export default function SectionRenderer({ sections }) {
  if (!sections || sections.length === 0) return null;

  return sections.map((section) => {
    const Component = sectionRegistry[section.type];
    if (!Component) return null;

    return (
      <SectionErrorBoundary key={section.id}>
        <Suspense fallback={SectionFallback}>
          <Component section={section} />
        </Suspense>
      </SectionErrorBoundary>
    );
  });
}
