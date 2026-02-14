import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  build: {
    target: ['es2020', 'safari13'],
    rollupOptions: {
      output: {
        manualChunks(id) {
          if (id.includes('node_modules')) {
            if (id.includes('katex')) {
              return 'vendor-katex';
            }
            if (id.includes('@mui/') || id.includes('@emotion/')) {
              return 'vendor-mui';
            }
            if (id.includes('react-router')) {
              return 'vendor-router';
            }
            if (id.includes('react-dom') || id.includes('/react/')) {
              return 'vendor-react';
            }
          }
        },
      },
    },
  },
  server: {
    host: true,
    proxy: {
      '/api': {
        target: 'http://localhost:3001',
        changeOrigin: true,
      },
    },
  },
});
