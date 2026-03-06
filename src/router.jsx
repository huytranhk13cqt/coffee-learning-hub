import { createBrowserRouter } from 'react-router';
import Layout from './components/Layout.jsx';
import HomePage, { loader as homeLoader } from './pages/HomePage.jsx';
import ErrorPage from './pages/ErrorPage.jsx';
import { fetchGamificationStats } from './api/gamification.js';

async function rootLoader() {
  try {
    const gamification = await fetchGamificationStats();
    return { gamification };
  } catch {
    return { gamification: null };
  }
}

const router = createBrowserRouter([
  {
    id: 'root',
    path: '/',
    Component: Layout,
    ErrorBoundary: ErrorPage,
    loader: rootLoader,
    children: [
      {
        index: true,
        Component: HomePage,
        loader: homeLoader,
      },
      {
        path: 'dashboard',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/DashboardPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'achievements',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/AchievementsPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'bookmarks',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/BookmarksPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'review',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/ReviewPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'settings',
        lazy: async () => {
          const { default: Component } =
            await import('./pages/SettingsPage.jsx');
          return { Component };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'paths',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/LearningPathsPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'paths/:slug',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/PathDetailPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'lessons/:slug',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/LessonPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'lessons/:lessonId/exercises',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/ExercisePage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'lessons/:lessonId/results',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/ResultsPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
    ],
  },

  // Admin routes — separate route tree, own layout, own theme
  {
    path: '/admin/login',
    lazy: async () => {
      const { default: Component, loader } =
        await import('./pages/admin/AdminLoginPage.jsx');
      return { Component, loader };
    },
    ErrorBoundary: ErrorPage,
  },
  {
    path: '/admin',
    lazy: async () => {
      const { default: Component, loader } =
        await import('./components/admin/AdminLayout.jsx');
      return { Component, loader };
    },
    ErrorBoundary: ErrorPage,
    children: [
      {
        index: true,
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/admin/AdminDashboardPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'topics',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/admin/AdminTopicsPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'categories',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/admin/AdminCategoriesPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'lessons',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/admin/AdminLessonsPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'lessons/new',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/admin/AdminLessonFormPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'lessons/:id/edit',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/admin/AdminLessonFormPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'lessons/:id/sections',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/admin/AdminSectionsPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'exercises',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/admin/AdminExercisesPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'paths',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/admin/AdminLearningPathsPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'paths/new',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/admin/AdminLearningPathFormPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'paths/:id/edit',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/admin/AdminLearningPathFormPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'activity',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/admin/AdminActivityLogPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'review',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/admin/AdminReviewPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'weak-spots',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/admin/AdminWeakSpotsPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'settings',
        lazy: async () => {
          const { default: Component } =
            await import('./pages/admin/AdminSettingsPage.jsx');
          return { Component };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'generate',
        lazy: async () => {
          const { default: Component } =
            await import('./pages/admin/AdminContentGenerationPage.jsx');
          return { Component };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'import',
        lazy: async () => {
          const { default: Component } =
            await import('./pages/admin/AdminYamlImportPage.jsx');
          return { Component };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'assets',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/admin/AdminAssetStudioPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'exercises/new',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/admin/AdminExerciseFormPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'exercises/:id/edit',
        lazy: async () => {
          const { default: Component, loader } =
            await import('./pages/admin/AdminExerciseFormPage.jsx');
          return { Component, loader };
        },
        ErrorBoundary: ErrorPage,
      },
    ],
  },
]);

export default router;
