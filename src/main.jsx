import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { RouterProvider } from 'react-router'
import { CircularProgress, Box } from '@mui/material'
import router from './router.jsx'

function AppLoading() {
  return (
    <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
      <CircularProgress />
    </Box>
  )
}

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <RouterProvider router={router} fallbackElement={<AppLoading />} />
  </StrictMode>,
)
