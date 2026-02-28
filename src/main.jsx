import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { RouterProvider } from 'react-router';
import InitColorSchemeScript from '@mui/material/InitColorSchemeScript';
import CircularProgress from '@mui/material/CircularProgress';
import Box from '@mui/material/Box';
import router from './router.jsx';

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <InitColorSchemeScript attribute="data-color-scheme" />
    <RouterProvider
      router={router}
      fallbackElement={
        <Box
          sx={{
            display: 'flex',
            justifyContent: 'center',
            alignItems: 'center',
            height: '100vh',
          }}
        >
          <CircularProgress />
        </Box>
      }
    />
  </StrictMode>,
);

// Core Web Vitals reporting (fire-and-forget)
import { onCLS, onINP, onLCP } from 'web-vitals';

function reportMetric({ name, value, rating }) {
  if (import.meta.env.DEV) {
    console.log(`[Web Vitals] ${name}: ${Math.round(value)}ms (${rating})`);
  }
}

onCLS(reportMetric);
onINP(reportMetric);
onLCP(reportMetric);

// Register PWA service worker (vite-plugin-pwa virtual module, no-op in dev)
// Use .then() to avoid top-level await incompatibility with es2020/safari13 target
import('virtual:pwa-register')
  .then(({ registerSW }) => {
    registerSW({ onNeedRefresh() {}, onOfflineReady() {} });
  })
  .catch(() => {
    // PWA plugin not active in dev mode — silently ignore
  });
