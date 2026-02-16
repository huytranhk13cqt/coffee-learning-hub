import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, waitFor } from '@testing-library/react';
import DiagramSection from './DiagramSection.jsx';

// Mock mermaid — JSDOM cannot render SVG diagrams
const mockRender = vi.fn();
vi.mock('mermaid', () => ({
  default: {
    initialize: vi.fn(),
    render: (...args) => mockRender(...args),
  },
}));

// Mock useColorScheme — component uses it for dark mode detection
vi.mock('@mui/material/styles', async (importOriginal) => {
  const actual = await importOriginal();
  return { ...actual, useColorScheme: () => ({ mode: 'light' }) };
});

// Mock MarkdownContent — avoids pulling in marked + hljs + KaTeX + DOMPurify
vi.mock('../MarkdownContent.jsx', () => ({
  default: ({ content }) => <div data-testid="markdown-content">{content}</div>,
}));

function renderSection(metadata, overrides = {}) {
  const section = {
    id: 1,
    type: 'diagram',
    title: null,
    title_vi: null,
    content: null,
    content_vi: null,
    metadata,
    order_index: 4,
    ...overrides,
  };

  return render(<DiagramSection section={section} />);
}

describe('DiagramSection', () => {
  beforeEach(() => {
    mockRender.mockReset();
  });

  it('returns null when metadata has no code', () => {
    const { container } = renderSection({});
    expect(container.innerHTML).toBe('');
  });

  it('calls mermaid.render with diagram code', async () => {
    mockRender.mockResolvedValue({ svg: '<svg>diagram</svg>' });
    renderSection({ code: 'graph TD\n  A --> B' });

    await waitFor(() => {
      expect(mockRender).toHaveBeenCalledWith(
        expect.stringMatching(/^mermaid/),
        'graph TD\n  A --> B',
      );
    });
  });

  it('renders SVG output from mermaid', async () => {
    mockRender.mockResolvedValue({
      svg: '<svg data-testid="mermaid-svg">ok</svg>',
    });
    renderSection({ code: 'graph TD\n  A --> B' });

    await waitFor(() => {
      expect(screen.getByTestId('mermaid-svg')).toBeInTheDocument();
    });
  });

  it('shows error fallback on render failure', async () => {
    mockRender.mockRejectedValue(new Error('Parse error'));
    renderSection({ code: 'invalid---syntax' });

    await waitFor(() => {
      expect(screen.getByRole('alert')).toBeInTheDocument();
    });

    // Error fallback shows the code as a code block
    expect(screen.getByTestId('markdown-content')).toHaveTextContent(
      'invalid---syntax',
    );
  });

  it('renders title when title_vi is provided', async () => {
    mockRender.mockResolvedValue({ svg: '<svg>ok</svg>' });
    renderSection({ code: 'graph TD\n  A --> B' }, { title_vi: 'Lưu đồ' });

    expect(screen.getByText('Lưu đồ')).toBeInTheDocument();

    // Wait for mermaid.render promise to settle and avoid act() warning
    await waitFor(() => expect(mockRender).toHaveBeenCalled());
  });

  it('renders caption via MarkdownContent', async () => {
    mockRender.mockResolvedValue({ svg: '<svg>ok</svg>' });
    renderSection(
      { code: 'graph TD\n  A --> B' },
      { content_vi: 'This diagram shows a flow.' },
    );

    const captions = screen.getAllByTestId('markdown-content');
    expect(captions.some((el) => el.textContent.includes('This diagram'))).toBe(
      true,
    );

    await waitFor(() => expect(mockRender).toHaveBeenCalled());
  });
});
