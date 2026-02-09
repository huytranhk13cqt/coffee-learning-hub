import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    globals: true,
    include: ['**/*.test.js'],
    coverage: {
      provider: 'v8',
      reporter: ['text', 'lcov'],
      include: ['**/*.js'],
      exclude: [
        'node_modules/**',
        'vitest.config.js',
        'eslint.config.js',
        '**/*.test.js',
      ],
    },
  },
});
