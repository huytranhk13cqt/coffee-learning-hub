import { lazy } from 'react';
import MarkdownSection from './sections/MarkdownSection.jsx';
import KeyPointsSection from './sections/KeyPointsSection.jsx';
import InfoBoxSection from './sections/InfoBoxSection.jsx';
import AudioSection from './sections/AudioSection.jsx';
import VideoSection from './sections/VideoSection.jsx';
import ImageSection from './sections/ImageSection.jsx';

/**
 * Section Registry: maps lesson_section.type → React component.
 *
 * Mirrors the exercise registry pattern (exercise/registry.js).
 * Each component receives { section } with:
 *   { id, type, title, title_vi, content, content_vi, metadata, order_index }
 *
 * Heavy-dependency sections (chart, diagram, interactive_chart) are lazy-loaded
 * via React.lazy to keep the initial LessonPage bundle small. SectionRenderer
 * wraps all entries in <Suspense> so lazy components load on demand.
 *
 * To add a new section type:
 * 1. Create src/components/lesson/sections/NewType.jsx
 * 2. Add one entry here (static import or lazy)
 * 3. Run migration to add the type to lesson_section_type ENUM
 */
const sectionRegistry = {
  markdown: MarkdownSection,
  key_points: KeyPointsSection,
  info_box: InfoBoxSection,
  audio: AudioSection,
  video: VideoSection,
  image: ImageSection,
  chart: lazy(() => import('./sections/ChartSection.jsx')),
  diagram: lazy(() => import('./sections/DiagramSection.jsx')),
  interactive_chart: lazy(
    () => import('./sections/InteractiveChartSection.jsx'),
  ),
};

export default sectionRegistry;
