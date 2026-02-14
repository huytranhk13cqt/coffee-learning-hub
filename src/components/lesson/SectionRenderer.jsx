import sectionRegistry from './sectionRegistry.js';

export default function SectionRenderer({ sections }) {
  if (!sections || sections.length === 0) return null;

  return sections.map((section) => {
    const Component = sectionRegistry[section.type];
    if (!Component) return null;

    return <Component key={section.id} section={section} />;
  });
}
