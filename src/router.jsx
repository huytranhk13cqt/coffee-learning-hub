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
    ],
  },
]);

export default router;
