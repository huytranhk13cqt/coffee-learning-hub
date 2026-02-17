import { describe, it, expect, vi } from 'vitest';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import ArrangeWords from './ArrangeWords.jsx';
import { createExercise } from './fixtures.js';

// word_bank: ['goes', 'She', 'to', 'school']
const exercise = createExercise('arrange_words');

function setup(props = {}) {
  const onAnswerChange = vi.fn();
  render(
    <ArrangeWords
      exercise={exercise}
      answer={null}
      onAnswerChange={onAnswerChange}
      disabled={false}
      {...props}
    />,
  );
  // Clear the initial useEffect call (onAnswerChange(null) on mount)
  onAnswerChange.mockClear();
  return { onAnswerChange };
}

describe('ArrangeWords', () => {
  it('renders all word bank chips', () => {
    setup();
    for (const word of exercise.word_bank) {
      expect(screen.getByRole('button', { name: word })).toBeInTheDocument();
    }
  });

  it('shows placeholder when no words selected', () => {
    setup();
    expect(screen.getByText(/Chọn từ bên dưới/)).toBeInTheDocument();
  });

  it('builds sentence as words are clicked', async () => {
    const user = userEvent.setup();
    const { onAnswerChange } = setup();

    await user.click(screen.getByRole('button', { name: 'She' }));
    expect(onAnswerChange).toHaveBeenLastCalledWith('She');

    await user.click(screen.getByRole('button', { name: 'goes' }));
    expect(onAnswerChange).toHaveBeenLastCalledWith('She goes');

    await user.click(screen.getByRole('button', { name: 'to' }));
    expect(onAnswerChange).toHaveBeenLastCalledWith('She goes to');

    await user.click(screen.getByRole('button', { name: 'school' }));
    expect(onAnswerChange).toHaveBeenLastCalledWith('She goes to school');
  });

  it('removes word from answer when clicked in answer area', async () => {
    const user = userEvent.setup();
    const { onAnswerChange } = setup();

    // Build "She goes"
    await user.click(screen.getByRole('button', { name: 'She' }));
    await user.click(screen.getByRole('button', { name: 'goes' }));
    onAnswerChange.mockClear();

    // "She" appears in both answer area (enabled) and word bank (disabled).
    // Find the non-disabled one (answer area) and click to remove.
    const sheButtons = screen.getAllByRole('button', { name: 'She' });
    const answerChip = sheButtons.find(
      (btn) => btn.getAttribute('aria-disabled') !== 'true',
    );
    await user.click(answerChip);

    expect(onAnswerChange).toHaveBeenLastCalledWith('goes');
  });

  it('disables all chips when disabled', () => {
    setup({ disabled: true });
    const chip = screen.getByRole('button', { name: 'She' });
    expect(chip).toHaveAttribute('aria-disabled', 'true');
  });
});
