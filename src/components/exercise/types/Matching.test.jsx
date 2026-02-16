import { describe, it, expect, vi } from 'vitest';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import Matching from './Matching.jsx';
import { createExercise } from './fixtures.js';

// leftItems: Dog, Cat | rightItems: Bark, Meow
const exercise = createExercise('matching');

function setup(props = {}) {
  const onAnswerChange = vi.fn();
  render(
    <Matching
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

describe('Matching', () => {
  it('renders left and right column items', () => {
    setup();
    expect(
      screen.getByRole('button', { name: /Chọn Dog/ }),
    ).toBeInTheDocument();
    expect(
      screen.getByRole('button', { name: /Chọn Cat/ }),
    ).toBeInTheDocument();
    expect(
      screen.getByRole('button', { name: /Ghép Bark/ }),
    ).toBeInTheDocument();
    expect(
      screen.getByRole('button', { name: /Ghép Meow/ }),
    ).toBeInTheDocument();
  });

  it('creates a pair by clicking left then right', async () => {
    const user = userEvent.setup();
    setup();

    await user.click(screen.getByRole('button', { name: /Chọn Dog/ }));
    await user.click(screen.getByRole('button', { name: /Ghép Bark/ }));

    // Pair created — remove button confirms it
    expect(
      screen.getByRole('button', { name: /Xóa cặp Dog — Bark/ }),
    ).toBeInTheDocument();
  });

  it('reports pairs via onAnswerChange when all items paired', async () => {
    const user = userEvent.setup();
    const { onAnswerChange } = setup();

    // Pair Dog → Bark (incomplete: 1 of 2)
    await user.click(screen.getByRole('button', { name: /Chọn Dog/ }));
    await user.click(screen.getByRole('button', { name: /Ghép Bark/ }));
    expect(onAnswerChange).toHaveBeenLastCalledWith(null);

    // Pair Cat → Meow (complete: 2 of 2)
    await user.click(screen.getByRole('button', { name: /Chọn Cat/ }));
    await user.click(screen.getByRole('button', { name: /Ghép Meow/ }));
    expect(onAnswerChange).toHaveBeenLastCalledWith([
      { leftId: 'l1', rightId: 'r1' },
      { leftId: 'l2', rightId: 'r2' },
    ]);
  });

  it('removes a pair and reports null', async () => {
    const user = userEvent.setup();
    const { onAnswerChange } = setup();

    // Create all pairs
    await user.click(screen.getByRole('button', { name: /Chọn Dog/ }));
    await user.click(screen.getByRole('button', { name: /Ghép Bark/ }));
    await user.click(screen.getByRole('button', { name: /Chọn Cat/ }));
    await user.click(screen.getByRole('button', { name: /Ghép Meow/ }));
    onAnswerChange.mockClear();

    // Remove Dog—Bark pair
    await user.click(
      screen.getByRole('button', { name: /Xóa cặp Dog — Bark/ }),
    );

    // Back to incomplete — answer is null
    expect(onAnswerChange).toHaveBeenLastCalledWith(null);
  });

  it('disables left chips when disabled', () => {
    setup({ disabled: true });
    expect(screen.getByRole('button', { name: /Chọn Dog/ })).toHaveAttribute(
      'aria-disabled',
      'true',
    );
  });
});
