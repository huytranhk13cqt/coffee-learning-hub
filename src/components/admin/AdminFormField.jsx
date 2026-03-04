import TextField from '@mui/material/TextField';

export default function AdminFormField({ sx, ...props }) {
  return (
    <TextField
      fullWidth
      variant="outlined"
      size="small"
      sx={{ mb: 2, ...sx }}
      {...props}
    />
  );
}
