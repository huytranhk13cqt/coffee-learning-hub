import { useState, useMemo } from 'react';
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
import Slider from '@mui/material/Slider';
import Stack from '@mui/material/Stack';
import Chip from '@mui/material/Chip';
import TuneIcon from '@mui/icons-material/Tune';
import MarkdownContent from '../MarkdownContent.jsx';
import { generateChartData, getDefaultParams } from './chartGenerators.js';

/**
 * InteractiveChartSection — Explorable Explanations pattern.
 *
 * Renders a Recharts visualization with MUI Slider controls that let students
 * manipulate function parameters in real-time and observe how the chart changes.
 *
 * Expected metadata:
 *   {
 *     chartType: "line" | "bar" | "area",
 *     generator: "sine" | "quadratic" | "normal" | ... (see chartGenerators.js),
 *     xRange: [min, max, step],
 *     xKey: "x",
 *     series: [{ dataKey: "y", name: "y = f(x)", generator?: "..." }],
 *     parameters: [
 *       { key: "A", label: "Amplitude", label_vi: "Biên độ",
 *         min: 0.5, max: 3, step: 0.1, default: 1 }
 *     ],
 *     colors: ["#6366f1", ...]   // optional custom palette
 *   }
 *
 * content/content_vi: optional markdown description displayed below controls.
 */

const DEFAULT_COLORS = [
  '#6366f1',
  '#ec4899',
  '#10b981',
  '#f59e0b',
  '#3b82f6',
  '#8b5cf6',
];

export default function InteractiveChartSection({ section }) {
  const theme = useTheme();
  const metadata = section.metadata;
  const {
    chartType,
    xKey = 'x',
    series = [],
    parameters = [],
    colors,
  } = metadata || {};
  const palette = colors || DEFAULT_COLORS;
  const gridColor = theme.palette.divider;
  const textColor = theme.palette.text.secondary;

  // Parameter state — initialized from metadata defaults
  const [paramValues, setParamValues] = useState(() =>
    getDefaultParams(parameters),
  );

  // Normalize series list
  const seriesList = useMemo(() => {
    if (series.length) return series;
    const dk = metadata?.dataKey;
    if (dk) return [{ dataKey: dk, name: dk }];
    return [];
  }, [series, metadata?.dataKey]);

  // Generate data reactively when parameters change
  const data = useMemo(
    () => (metadata ? generateChartData(metadata, paramValues) : []),
    [metadata, paramValues],
  );

  function handleParamChange(key, value) {
    setParamValues((prev) => ({ ...prev, [key]: value }));
  }

  if (!chartType || !seriesList.length || !parameters.length) return null;

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
              dataKey={seriesList[0]?.dataKey || 'value'}
              nameKey={metadata.nameKey || 'name'}
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
      {/* Header */}
      <Box sx={{ display: 'flex', alignItems: 'center', gap: 1, mb: 1.5 }}>
        {section.title_vi && (
          <Typography variant="h6" sx={{ flex: 1 }}>
            {section.title_vi}
          </Typography>
        )}
        <Chip
          icon={<TuneIcon />}
          label="Tương tác"
          size="small"
          color="primary"
          variant="outlined"
        />
      </Box>

      {/* Chart Area */}
      <Box sx={{ width: '100%', height: 300, mb: 2 }}>
        <ResponsiveContainer>{chart}</ResponsiveContainer>
      </Box>

      {/* Parameter Sliders */}
      <Paper
        variant="outlined"
        sx={{
          p: 2,
          bgcolor: 'action.hover',
          borderStyle: 'dashed',
        }}
      >
        <Typography variant="subtitle2" color="text.secondary" sx={{ mb: 1.5 }}>
          Điều chỉnh tham số:
        </Typography>
        <Stack spacing={2}>
          {parameters.map((param) => (
            <Box key={param.key}>
              <Box
                sx={{
                  display: 'flex',
                  justifyContent: 'space-between',
                  alignItems: 'baseline',
                  mb: 0.5,
                }}
              >
                <Typography variant="body2" color="text.secondary">
                  {param.label_vi || param.label}
                </Typography>
                <Typography
                  variant="body2"
                  fontWeight={700}
                  color="primary.main"
                  sx={{ fontFamily: 'monospace' }}
                >
                  {paramValues[param.key]}
                </Typography>
              </Box>
              <Slider
                value={paramValues[param.key]}
                onChange={(_, val) => handleParamChange(param.key, val)}
                min={param.min}
                max={param.max}
                step={param.step}
                valueLabelDisplay="auto"
                size="small"
              />
            </Box>
          ))}
        </Stack>
      </Paper>

      {/* Description / Caption */}
      {(section.content_vi || section.content) && (
        <MarkdownContent
          content={section.content_vi || section.content}
          sx={{ mt: 2, '& p:last-child': { mb: 0 } }}
        />
      )}
    </Paper>
  );
}
