import { test, expect } from '@playwright/test';

// Session header for all requests
const SESSION_ID = 'e2e-test-session-' + Date.now();

test.beforeEach(async ({ context }) => {
  // Inject X-Session-Id into localStorage before each page load
  await context.addInitScript((sid) => {
    localStorage.setItem('session_id', sid);
  }, SESSION_ID);
});

test.describe('Smoke Tests', () => {
  test('homepage loads and shows categories', async ({ page }) => {
    await page.goto('/');

    // Main heading
    await expect(
      page.getByRole('heading', { name: 'Learning Hub', exact: true }),
    ).toBeVisible();

    // Should show category headings (h5)
    await expect(
      page.getByRole('heading', { name: 'Present', exact: true }),
    ).toBeVisible();
    await expect(
      page.getByRole('heading', { name: 'Past', exact: true }),
    ).toBeVisible();
    await expect(
      page.getByRole('heading', { name: 'Future', exact: true }),
    ).toBeVisible();
    await expect(
      page.getByRole('heading', { name: 'Learning Methods', exact: true }),
    ).toBeVisible();
    await expect(
      page.getByRole('heading', { name: 'Python Basics', exact: true }),
    ).toBeVisible();
  });

  test('lesson page loads theory content', async ({ page }) => {
    await page.goto('/lessons/simple-present');

    // Lesson title (h4, exact match)
    await expect(
      page.getByRole('heading', { name: 'Simple Present', exact: true }),
    ).toBeVisible();

    // Breadcrumb
    await expect(page.getByText('Trang chủ')).toBeVisible();

    // Theory content should be present (usages section)
    await expect(
      page.getByText('Habits and routines', { exact: true }),
    ).toBeVisible();

    // Exercise CTA button should exist
    await expect(page.getByRole('button', { name: /bài tập/i })).toBeVisible();
  });

  test('Python lesson shows code with syntax highlighting', async ({
    page,
  }) => {
    await page.goto('/lessons/python-variables');

    // Lesson title (exact match avoids comparison headings)
    await expect(
      page.getByRole('heading', {
        name: 'Variables & Data Types',
        exact: true,
      }),
    ).toBeVisible();

    // Should have a section with Python code
    await expect(page.getByText('name = "Alice"').first()).toBeVisible();

    // Code blocks should have syntax highlighting classes
    const codeBlock = page.locator('pre code.hljs');
    await expect(codeBlock.first()).toBeVisible();
  });

  test('exercise page loads and shows first exercise', async ({ page }) => {
    // Navigate to exercises for Simple Present (lesson_id = 1)
    await page.goto('/lessons/1/exercises');

    // Progress indicator should exist
    const progressBar = page.getByRole('progressbar');
    await expect(progressBar).toBeVisible({ timeout: 10_000 });

    // Should show some exercise content (question area)
    await expect(page.locator('.MuiPaper-root').first()).toBeVisible();
  });

  test('search finds a lesson', async ({ page }) => {
    await page.goto('/');

    // Type in search bar
    const searchInput = page.getByRole('combobox');
    await searchInput.fill('python');

    // Wait for autocomplete results
    const option = page.getByRole('option').first();
    await expect(option).toBeVisible({ timeout: 5_000 });

    // Should contain a Python lesson
    await expect(option).toContainText(/python/i);
  });

  test('dashboard loads with stats', async ({ page }) => {
    await page.goto('/dashboard');

    // Dashboard should have heading content
    await expect(page.locator('h4, h5').first()).toBeVisible({
      timeout: 5_000,
    });

    // Should show lesson count (0/N pattern — N varies with seed data)
    await expect(page.getByText(/\d+\/\d+/).first()).toBeVisible({
      timeout: 5_000,
    });
  });

  test('exercise submission shows feedback and next button', async ({
    page,
  }) => {
    // Simple Present (lesson_id=1) starts with multiple_choice exercises
    await page.goto('/lessons/1/exercises');

    // Wait for first exercise to render
    await expect(page.getByRole('progressbar')).toBeVisible({
      timeout: 10_000,
    });

    // Select first radio option (multiple_choice)
    const firstRadio = page.getByRole('radio').first();
    await expect(firstRadio).toBeVisible({ timeout: 5_000 });
    await firstRadio.click();

    // Submit answer
    await page.getByRole('button', { name: 'Kiểm tra' }).click();

    // Feedback panel appears (role="status" from FeedbackPanel)
    await expect(page.getByRole('status')).toBeVisible({ timeout: 10_000 });

    // FSM transitions to feedback phase: "next" button replaces "submit"
    await expect(
      page.getByRole('button', { name: /Câu tiếp theo|Xem kết quả/ }),
    ).toBeVisible();
  });

  test('dark mode toggle switches color scheme', async ({ page }) => {
    await page.goto('/');

    // Initially light mode — toggle shows "switch to dark"
    const toggle = page.getByRole('button', {
      name: 'Chuyển sang chế độ tối',
    });
    await expect(toggle).toBeVisible({ timeout: 5_000 });

    // Switch to dark mode — verify via user-visible button text change
    // (checking data-mui-color-scheme is fragile across MUI versions)
    await toggle.click();
    await expect(
      page.getByRole('button', { name: 'Chuyển sang chế độ sáng' }),
    ).toBeVisible();
  });
});
