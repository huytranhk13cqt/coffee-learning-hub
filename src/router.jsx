import { createBrowserRouter } from 'react-router';
import Layout from './components/Layout.jsx';
import HomePage, { loader as homeLoader } from './pages/HomePage.jsx';
import ErrorPage from './pages/ErrorPage.jsx';

const router = createBrowserRouter([
  {
    path: '/',
    Component: Layout,
    ErrorBoundary: ErrorPage,
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
