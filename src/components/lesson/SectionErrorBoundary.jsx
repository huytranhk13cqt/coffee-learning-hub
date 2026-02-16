import { Component } from 'react';
import Alert from '@mui/material/Alert';

/**
 * Lightweight error boundary for lazy-loaded lesson sections.
 *
 * Catches chunk-load failures (network errors, 404) and render errors
 * from ChartSection / DiagramSection without crashing the entire
 * LessonPage. Only the failed section shows a fallback message.
 */
export default class SectionErrorBoundary extends Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError() {
    return { hasError: true };
  }

  render() {
    if (this.state.hasError) {
      return (
        <Alert severity="warning" sx={{ my: 1 }}>
          Không thể tải nội dung phần này. Vui lòng tải lại trang.
        </Alert>
      );
    }
    return this.props.children;
  }
}
