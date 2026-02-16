import { useMemo } from 'react';
import {
  ResponsiveContainer,
  BarChart,
  Bar,
  LineChart,
  Line,
  AreaChart,
  Area,
  PieChart,
  Pie,
  Cell,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
} from 'recharts';
import { useTheme } from '@mui/material/styles';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import MarkdownContent from '../MarkdownContent.jsx';

/**
 * ChartSection renders data visualizations using Recharts.
 *
 * Expected metadata:
 *   {
 *     chartType: "bar" | "line" | "area" | "pie",
 *     data: [{ name: "A", value: 10 }, ...],
 *     xKey: "name",                          // x-axis data key (cartesian only)
 *     dataKey: "value",                       // single series shorthand
 *     series: [{ dataKey: "y", name: "Y" }], // multi-series (overrides dataKey)
 *     nameKey: "name",                        // pie chart label key
 *     colors: ["#6366f1", ...]                // optional custom palette
 *   }
 *
 * content/content_vi: optional markdown caption displayed below the chart.
 */

const DEFAULT_COLORS = [
  '#6366f1',
  '#ec4899',
  '#10b981',
  '#f59e0b',
  '#3b82f6',
  '#8b5cf6',
];

export default function ChartSection({ section }) {
  const theme = useTheme();
  const { chartType, data, xKey, dataKey, series, nameKey, colors } =
    section.metadata || {};

  const palette = colors || DEFAULT_COLORS;
  const gridColor = theme.palette.divider;
  const textColor = theme.palette.text.secondary;

  // Normalize: single dataKey → one-element series array
  const seriesList = useMemo(() => {
    if (series?.length) return series;
    if (dataKey) return [{ dataKey, name: dataKey }];
    return [];
  }, [series, dataKey]);

  if (!data?.length || !chartType) return null;

  // Shared tooltip/legend styling for dark mode compatibility
  const tooltipStyle = {
    backgroundColor: theme.palette.background.paper,
    border: `1px solid ${theme.palette.divider}`,
    borderRadius: 4,
    color: theme.palette.text.primary,
  };

  const renderCartesian = (Chart, SeriesComponent, seriesProps) => (
    <Chart data={data}>
      <CartesianGrid strokeDasharray="3 3" stroke={gridColor} />
      <XAxis dataKey={xKey} tick={{ fill: textColor, fontSize: 12 }} />
      <YAxis tick={{ fill: textColor, fontSize: 12 }} />
      <Tooltip contentStyle={tooltipStyle} />
      <Legend />
      {seriesList.map((s, i) => (
        <SeriesComponent
          key={s.dataKey}
          dataKey={s.dataKey}
          name={s.name || s.dataKey}
          {...seriesProps(palette[i % palette.length])}
        />
      ))}
    </Chart>
  );

  const renderChart = () => {
    switch (chartType) {
      case 'bar':
        return renderCartesian(BarChart, Bar, (color) => ({
          fill: color,
          radius: [4, 4, 0, 0],
        }));

      case 'line':
        return renderCartesian(LineChart, Line, (color) => ({
          type: 'monotone',
          stroke: color,
          strokeWidth: 2,
          dot: false,
        }));

      case 'area':
        return renderCartesian(AreaChart, Area, (color) => ({
          type: 'monotone',
          stroke: color,
          fill: color,
          fillOpacity: 0.2,
        }));

      case 'pie':
        return (
          <PieChart>
            <Pie
              data={data}
              dataKey={dataKey || 'value'}
              nameKey={nameKey || 'name'}
              cx="50%"
              cy="50%"
              outerRadius={100}
              label={({ name, percent }) =>
                `${name} ${(percent * 100).toFixed(0)}%`
              }
            >
              {data.map((_, i) => (
                <Cell key={i} fill={palette[i % palette.length]} />
              ))}
            </Pie>
            <Tooltip contentStyle={tooltipStyle} />
            <Legend />
          </PieChart>
        );

      default:
        return null;
    }
  };

  const chart = renderChart();
  if (!chart) return null;

  return (
    <Paper variant="outlined" sx={{ p: 2.5 }}>
      {section.title_vi && (
        <Typography variant="h6" gutterBottom>
          {section.title_vi}
        </Typography>
      )}

      <Box sx={{ width: '100%', height: 300 }}>
        <ResponsiveContainer>{chart}</ResponsiveContainer>
      </Box>

      {(section.content_vi || section.content) && (
        <MarkdownContent
          content={section.content_vi || section.content}
          sx={{ mt: 1.5, '& p:last-child': { mb: 0 } }}
        />
      )}
    </Paper>
  );
}
