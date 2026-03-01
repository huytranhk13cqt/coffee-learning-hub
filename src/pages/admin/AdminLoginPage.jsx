import { useState } from 'react';
import { redirect } from 'react-router';
import { ThemeProvider } from '@mui/material/styles';
import CssBaseline from '@mui/material/CssBaseline';
import Box from '@mui/material/Box';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Typography from '@mui/material/Typography';
import TextField from '@mui/material/TextField';
import Button from '@mui/material/Button';
import Alert from '@mui/material/Alert';
import LockIcon from '@mui/icons-material/Lock';
import pixelTheme from '../../theme/pixelTheme.js';
import { adminVerify } from '../../api/admin.js';
import { useAdminAuth } from '../../hooks/useAdminAuth.js';

import '@fontsource/press-start-2p/400.css';
import '@fontsource/silkscreen/400.css';
import '@fontsource/vt323/400.css';

export async function loader() {
  try {
    const { authenticated } = await adminVerify();
    if (authenticated) return redirect('/admin');
  } catch {
    /* continue to login page */
  }
  return null;
}

export default function AdminLoginPage() {
  const [password, setPassword] = useState('');
  const { error, loading, login } = useAdminAuth();

  function handleSubmit(e) {
    e.preventDefault();
    login(password);
  }

  return (
    <ThemeProvider theme={pixelTheme}>
      <CssBaseline enableColorScheme />
      <Box
        sx={{
          minHeight: '100vh',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          bgcolor: 'background.default',
          p: 2,
        }}
      >
        <Card sx={{ maxWidth: 400, width: '100%' }}>
          <CardContent sx={{ p: 4 }}>
            <Box sx={{ textAlign: 'center', mb: 3 }}>
              <LockIcon
                sx={{ fontSize: '2.5rem', color: 'primary.main', mb: 2 }}
              />
              <Typography variant="h2" gutterBottom>
                ADMIN LOGIN
              </Typography>
              <Typography variant="body2" color="text.secondary">
                Enter the admin password
              </Typography>
            </Box>

            <Box component="form" onSubmit={handleSubmit}>
              <TextField
                fullWidth
                type="password"
                label="Password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                autoFocus
                sx={{ mb: 2 }}
              />

              {error && (
                <Alert severity="error" sx={{ mb: 2, borderRadius: 0 }}>
                  {error}
                </Alert>
              )}

              <Button
                type="submit"
                variant="contained"
                fullWidth
                size="large"
                loading={loading}
                disabled={!password}
              >
                LOG IN
              </Button>
            </Box>

            <Typography
              variant="caption"
              color="text.secondary"
              sx={{ display: 'block', textAlign: 'center', mt: 3 }}
            >
              Learning Hub Admin Panel
            </Typography>
          </CardContent>
        </Card>
      </Box>
    </ThemeProvider>
  );
}
