import { describe, it, expect, vi } from 'vitest';
import { render, screen } from '@testing-library/react';
import { ThemeProvider, createTheme } from '@mui/material/styles';
import ChartSection from './ChartSection.jsx';

// Mock recharts — JSDOM cannot measure container dimensions
vi.mock('recharts', () => {
  const Wrapper = ({ children }) => <div data-testid="chart">{children}</div>;
  const Series = ({ dataKey }) => <div data-testid={`series-${dataKey}`} />;
  return {
    ResponsiveContainer: ({ children }) => (
      <div data-testid="responsive-container">{children}</div>
    ),
    BarChart: Wrapper,
    Bar: Series,
    LineChart: Wrapper,
    Line: Series,
    AreaChart: Wrapper,
    Area: Series,
    PieChart: Wrapper,
    Pie: ({ dataKey }) => <div data-testid={`pie-${dataKey}`} />,
    Cell: () => null,
    XAxis: () => null,
    YAxis: () => null,
    CartesianGrid: () => null,
    Tooltip: () => null,
    Legend: () => null,
  };
});

// Mock MarkdownContent — avoids pulling in marked + hljs + KaTeX + DOMPurify
vi.mock('../MarkdownContent.jsx', () => ({
  default: ({ content }) => <div data-testid="markdown-caption">{content}</div>,
}));

const theme = createTheme();

function renderSection(metadata, overrides = {}) {
  const section = {
    id: 1,
    type: 'chart',
    title: null,
    title_vi: null,
    content: null,
    content_vi: null,
    metadata,
    order_index: 4,
    ...overrides,
  };

  return render(
    <ThemeProvider theme={theme}>
      <ChartSection section={section} />
    </ThemeProvider>,
  );
}

describe('ChartSection', () => {
  it('returns null when metadata has no data', () => {
    const { container } = renderSection({ chartType: 'bar', data: [] });
    expect(container.innerHTML).toBe('');
  });

  it('returns null when chartType is missing', () => {
    const { container } = renderSection({
      data: [{ name: 'A', value: 10 }],
    });
    expect(container.innerHTML).toBe('');
  });

  it('renders a bar chart with series', () => {
    renderSection({
      chartType: 'bar',
      data: [{ name: 'A', value: 10 }],
      xKey: 'name',
      dataKey: 'value',
    });

    expect(screen.getByTestId('responsive-container')).toBeInTheDocument();
    expect(screen.getByTestId('series-value')).toBeInTheDocument();
  });

  it('renders a line chart', () => {
    renderSection({
      chartType: 'line',
      data: [{ x: 1, y: 5 }],
      xKey: 'x',
      dataKey: 'y',
    });

    expect(screen.getByTestId('series-y')).toBeInTheDocument();
  });

  it('renders a pie chart', () => {
    renderSection({
      chartType: 'pie',
      data: [{ name: 'Slice', value: 42 }],
      dataKey: 'value',
    });

    expect(screen.getByTestId('pie-value')).toBeInTheDocument();
  });

  it('renders multiple series', () => {
    renderSection({
      chartType: 'bar',
      data: [{ month: 'Jan', sales: 100, costs: 80 }],
      xKey: 'month',
      series: [
        { dataKey: 'sales', name: 'Sales' },
        { dataKey: 'costs', name: 'Costs' },
      ],
    });

    expect(screen.getByTestId('series-sales')).toBeInTheDocument();
    expect(screen.getByTestId('series-costs')).toBeInTheDocument();
  });

  it('renders title when title_vi is provided', () => {
    renderSection(
      {
        chartType: 'bar',
        data: [{ name: 'A', value: 10 }],
        xKey: 'name',
        dataKey: 'value',
      },
      { title_vi: 'Biểu đồ thống kê' },
    );

    expect(screen.getByText('Biểu đồ thống kê')).toBeInTheDocument();
  });

  it('renders caption via MarkdownContent', () => {
    renderSection(
      {
        chartType: 'bar',
        data: [{ name: 'A', value: 10 }],
        xKey: 'name',
        dataKey: 'value',
      },
      { content_vi: 'Chart shows sample data.' },
    );

    expect(screen.getByTestId('markdown-caption')).toHaveTextContent(
      'Chart shows sample data.',
    );
  });
});
