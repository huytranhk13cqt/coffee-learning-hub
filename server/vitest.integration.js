import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    globals: true,
    include: ['tests/integration/**/*.test.js'],
    globalSetup: ['tests/integration/global-setup.js'],
    testTimeout: 15000,
    hookTimeout: 30000,
    coverage: {
      provider: 'v8',
      reporter: ['text', 'lcov'],
      include: ['repositories/**/*.js', 'services/**/*.js'],
      exclude: ['node_modules/**', '**/*.test.js'],
    },
  },
});
