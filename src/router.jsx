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
]);

export default router;
