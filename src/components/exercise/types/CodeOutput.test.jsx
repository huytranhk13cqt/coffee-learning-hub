import { describe, it, expect, vi } from 'vitest';
import { render, screen, fireEvent } from '@testing-library/react';
import CodeOutput from './CodeOutput.jsx';
import { createExercise } from './fixtures.js';

// Mock MarkdownContent — avoids pulling in marked + hljs + KaTeX + DOMPurify
vi.mock('../../lesson/MarkdownContent.jsx', () => ({
  default: ({ content }) => <div data-testid="markdown-content">{content}</div>,
}));

const exercise = createExercise('code_output');

function setup(props = {}) {
  const onAnswerChange = vi.fn();
  render(
    <CodeOutput
      exercise={exercise}
      answer={null}
      onAnswerChange={onAnswerChange}
      disabled={false}
      {...props}
    />,
  );
  return { onAnswerChange };
}

describe('CodeOutput', () => {
  it('renders code content via MarkdownContent', () => {
    setup();
    // toHaveTextContent normalizes whitespace, so check key substring
    expect(screen.getByTestId('markdown-content')).toHaveTextContent(
      'print("Hello")',
    );
  });

  it('renders text field with accessible label', () => {
    setup();
    expect(screen.getByLabelText('Dự đoán output')).toBeInTheDocument();
  });

  it('calls onAnswerChange on input', () => {
    const { onAnswerChange } = setup();
    fireEvent.change(screen.getByLabelText('Dự đoán output'), {
      target: { value: 'Hello' },
    });
    expect(onAnswerChange).toHaveBeenCalledWith('Hello');
  });

  it('displays existing answer value', () => {
    setup({ answer: '42' });
    expect(screen.getByLabelText('Dự đoán output')).toHaveValue('42');
  });

  it('disables input when disabled', () => {
    setup({ disabled: true });
    expect(screen.getByLabelText('Dự đoán output')).toBeDisabled();
  });
});
