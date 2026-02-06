import { useState } from 'react'
import {
  ThemeProvider,
  createTheme,
  CssBaseline,
  Container,
  Typography,
  Button,
  Box,
  Card,
  CardContent,
  Stack
} from '@mui/material'
import AddIcon from '@mui/icons-material/Add'
import RemoveIcon from '@mui/icons-material/Remove'

const theme = createTheme({
  palette: {
    mode: 'light',
    primary: {
      main: '#6366f1',
    },
    secondary: {
      main: '#ec4899',
    },
  },
})

function App() {
  const [count, setCount] = useState(0)

  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <Container maxWidth="sm">
        <Box sx={{ py: 8, textAlign: 'center' }}>
          <Typography variant="h3" component="h1" gutterBottom>
            Project Relax
          </Typography>
          <Typography variant="subtitle1" color="text.secondary" gutterBottom>
            Vite + React + MUI
          </Typography>

          <Card sx={{ mt: 4 }}>
            <CardContent>
              <Typography variant="h4" sx={{ mb: 3 }}>
                Count: {count}
              </Typography>
              <Stack direction="row" spacing={2} justifyContent="center">
                <Button
                  variant="contained"
                  startIcon={<RemoveIcon />}
                  onClick={() => setCount(c => c - 1)}
                >
                  Decrease
                </Button>
                <Button
                  variant="contained"
                  color="secondary"
                  startIcon={<AddIcon />}
                  onClick={() => setCount(c => c + 1)}
                >
                  Increase
                </Button>
              </Stack>
            </CardContent>
          </Card>
        </Box>
      </Container>
    </ThemeProvider>
  )
}

export default App
