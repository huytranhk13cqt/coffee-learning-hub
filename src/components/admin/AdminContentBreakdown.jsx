import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import Divider from '@mui/material/Divider';

function CSSBarChart({ items, label }) {
  if (!items || items.length === 0) return null;
  const max = Math.max(...items.map((d) => d.count), 1);

  return (
    <Box sx={{ mb: 2 }}>
      <Typography variant="subtitle2" sx={{ mb: 1 }}>
        {label}
      </Typography>
      {items.map((item) => (
        <Box
          key={item.type || item.category_name}
          sx={{
            display: 'flex',
            alignItems: 'center',
            gap: 1,
            mb: 0.5,
          }}
        >
          <Typography
            variant="caption"
            sx={{
              width: 150,
              flexShrink: 0,
              textAlign: 'right',
              overflow: 'hidden',
              textOverflow: 'ellipsis',
              whiteSpace: 'nowrap',
            }}
          >
            {(item.type || item.category_name || '').replace(/_/g, ' ')}
          </Typography>
          <Box
            sx={{
              flex: 1,
              height: 16,
              bgcolor: 'action.hover',
              position: 'relative',
            }}
          >
            <Box
              sx={{
                height: '100%',
                width: `${(item.count / max) * 100}%`,
                bgcolor: 'primary.main',
                minWidth: item.count > 0 ? 2 : 0,
              }}
            />
          </Box>
          <Typography
            variant="caption"
            sx={{ width: 40, flexShrink: 0, textAlign: 'right' }}
          >
            {item.count}
          </Typography>
        </Box>
      ))}
    </Box>
  );
}

export default function AdminContentBreakdown({ breakdown }) {
  if (!breakdown?.data && !breakdown?.exercises_by_type) return null;
  const data = breakdown.data || breakdown;

  return (
    <Card>
      <CardContent>
        <Typography variant="h4" gutterBottom>
          Content Breakdown
        </Typography>
        <CSSBarChart items={data.exercises_by_type} label="Exercises by Type" />
        <Divider sx={{ my: 2 }} />
        <CSSBarChart items={data.sections_by_type} label="Sections by Type" />
      </CardContent>
    </Card>
  );
}
