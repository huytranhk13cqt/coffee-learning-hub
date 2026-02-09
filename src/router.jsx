import { createBrowserRouter } from 'react-router';
import Layout from './components/Layout.jsx';
import HomePage, { loader as homeLoader } from './pages/HomePage.jsx';
import LessonPage, { loader as lessonLoader } from './pages/LessonPage.jsx';
import ExercisePage, { loader as exerciseLoader } from './pages/ExercisePage.jsx';
import ResultsPage, { loader as resultsLoader } from './pages/ResultsPage.jsx';
import DashboardPage, { loader as dashboardLoader } from './pages/DashboardPage.jsx';
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
        Component: DashboardPage,
        loader: dashboardLoader,
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'lessons/:slug',
        Component: LessonPage,
        loader: lessonLoader,
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'lessons/:lessonId/exercises',
        Component: ExercisePage,
        loader: exerciseLoader,
        ErrorBoundary: ErrorPage,
      },
      {
        path: 'lessons/:lessonId/results',
        Component: ResultsPage,
        loader: resultsLoader,
        ErrorBoundary: ErrorPage,
      },
    ],
  },
]);

export default router;
