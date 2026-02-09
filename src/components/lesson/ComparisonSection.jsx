import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';

export default function ComparisonSection({ comparisons, lessonName }) {
  if (!comparisons.length) return null;

  // Group by compared_with_name
  const grouped = comparisons.reduce((acc, c) => {
    const key = c.compared_with_name;
    if (!acc[key])
      acc[key] = { name: key, nameVi: c.compared_with_name_vi, rows: [] };
    acc[key].rows.push(c);
    return acc;
  }, {});

  return (
    <Box>
      <Typography variant="h6" gutterBottom>
        So sánh với thì khác
      </Typography>

      {Object.values(grouped).map((group) => (
        <Box key={group.name} sx={{ mb: 3 }}>
          <Typography variant="subtitle1" fontWeight={600} gutterBottom>
            {lessonName} vs {group.name}
          </Typography>

          <TableContainer component={Paper} variant="outlined">
            <Table size="small">
              <TableHead>
                <TableRow>
                  <TableCell sx={{ fontWeight: 600 }}>Khía cạnh</TableCell>
                  <TableCell sx={{ fontWeight: 600 }}>{lessonName}</TableCell>
                  <TableCell sx={{ fontWeight: 600 }}>{group.name}</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {group.rows.map((row, i) => (
                  <TableRow key={i}>
                    <TableCell>
                      <Typography variant="body2" fontWeight={500}>
                        {row.aspect_vi || row.aspect}
                      </Typography>
                    </TableCell>
                    <TableCell>
                      <Typography variant="body2">
                        {row.this_lesson_point_vi || row.this_lesson_point}
                      </Typography>
                      {row.this_example && (
                        <Typography
                          variant="caption"
                          color="text.secondary"
                          sx={{
                            fontStyle: 'italic',
                            display: 'block',
                            mt: 0.5,
                          }}
                        >
                          {row.this_example}
                        </Typography>
                      )}
                    </TableCell>
                    <TableCell>
                      <Typography variant="body2">
                        {row.other_lesson_point_vi || row.other_lesson_point}
                      </Typography>
                      {row.other_example && (
                        <Typography
                          variant="caption"
                          color="text.secondary"
                          sx={{
                            fontStyle: 'italic',
                            display: 'block',
                            mt: 0.5,
                          }}
                        >
                          {row.other_example}
                        </Typography>
                      )}
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>
        </Box>
      ))}
    </Box>
  );
}
