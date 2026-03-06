import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { VitePWA } from 'vite-plugin-pwa';

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    react({
      babel: {
        plugins: ['babel-plugin-react-compiler'],
      },
    }),
    VitePWA({
      registerType: 'autoUpdate',
      includeAssets: ['icons/icon-192.png', 'icons/icon-512.png'],
      manifest: {
        name: 'Learning Hub',
        short_name: 'LearnHub',
        description:
          'Học mọi thứ — từ ngôn ngữ đến lập trình, toán học đến tâm lý học',
        theme_color: '#6366f1',
        background_color: '#0a0a0f',
        display: 'standalone',
        orientation: 'portrait-primary',
        scope: '/',
        start_url: '/',
        icons: [
          {
            src: '/icons/icon-192.png',
            sizes: '192x192',
            type: 'image/png',
            purpose: 'any maskable',
          },
          {
            src: '/icons/icon-512.png',
            sizes: '512x512',
            type: 'image/png',
            purpose: 'any maskable',
          },
        ],
      },
      workbox: {
        // Exclude Mermaid (2.2MB, lazy-loaded) and Recharts from precache —
        // they are loaded on-demand so runtime caching handles them.
        globIgnores: ['**/vendor-mermaid-*.js', '**/vendor-recharts-*.js'],
        globPatterns: ['**/*.{js,css,html,ico,png,svg,woff2}'],
        runtimeCaching: [
          {
            urlPattern: /\/api\/lessons\/.+/,
            handler: 'StaleWhileRevalidate',
            options: {
              cacheName: 'api-lessons-cache',
              expiration: { maxEntries: 100, maxAgeSeconds: 86400 * 7 },
            },
          },
          {
            urlPattern: /\/api\/home$/,
            handler: 'NetworkFirst',
            options: {
              cacheName: 'api-home-cache',
              networkTimeoutSeconds: 5,
            },
          },
          {
            urlPattern: /\/api\/(review|progress)\/.*/,
            handler: 'NetworkOnly',
          },
        ],
      },
      devOptions: {
        enabled: false,
      },
    }),
  ],
  build: {
    target: ['es2020', 'safari13'],
    // Recharts (523KB) and Mermaid (2.2MB) are lazy-loaded via React.lazy —
    // they never appear in the critical path, so the default 500KB warning is misleading.
    chunkSizeWarningLimit: 2500,
    rollupOptions: {
      output: {
        manualChunks(id) {
          if (id.includes('node_modules')) {
            // Recharts & Mermaid share d3 transitive deps → Rollup reports a
            // circular chunk warning. Both chunks are lazy-loaded via React.lazy
            // so the cycle is harmless at runtime (ES live bindings).
            if (id.includes('recharts') || id.includes('d3-')) {
              return 'vendor-recharts';
            }
            if (id.includes('mermaid')) {
              return 'vendor-mermaid';
            }
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
      '/media': {
        target: 'http://localhost:3001',
        changeOrigin: true,
      },
      '/sprites': {
        target: 'http://localhost:3001',
        changeOrigin: true,
      },
    },
  },
});
