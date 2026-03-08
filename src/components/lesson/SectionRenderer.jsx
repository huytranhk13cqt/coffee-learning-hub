import { Suspense } from 'react';
import CircularProgress from '@mui/material/CircularProgress';
import { PixelFrame } from '../pixel/index.js';
import SectionErrorBoundary from './SectionErrorBoundary.jsx';
import sectionRegistry from './sectionRegistry.js';

const SectionFallback = (
  <PixelFrame
    variant="default"
    sx={{ p: 4, display: 'flex', justifyContent: 'center' }}
  >
    <CircularProgress size={28} />
  </PixelFrame>
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
