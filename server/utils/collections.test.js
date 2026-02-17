import { describe, it, expect } from 'vitest';
import { groupBy, shuffle } from './collections.js';

describe('groupBy', () => {
  it('groups items by key function', () => {
    const items = [
      { type: 'a', id: 1 },
      { type: 'b', id: 2 },
      { type: 'a', id: 3 },
    ];
    const result = groupBy(items, (i) => i.type);
    expect(result).toBeInstanceOf(Map);
    expect(result.get('a')).toEqual([
      { type: 'a', id: 1 },
      { type: 'a', id: 3 },
    ]);
    expect(result.get('b')).toEqual([{ type: 'b', id: 2 }]);
  });

  it('returns empty map for empty array', () => {
    const result = groupBy([], (x) => x);
    expect(result.size).toBe(0);
  });

  it('handles numeric keys', () => {
    const items = [
      { exerciseId: 10, text: 'A' },
      { exerciseId: 10, text: 'B' },
      { exerciseId: 20, text: 'C' },
    ];
    const result = groupBy(items, (i) => i.exerciseId);
    expect(result.get(10)).toHaveLength(2);
    expect(result.get(20)).toHaveLength(1);
  });

  it('preserves insertion order within each group', () => {
    const items = [
      { g: 1, v: 'first' },
      { g: 1, v: 'second' },
      { g: 1, v: 'third' },
    ];
    const result = groupBy(items, (i) => i.g);
    expect(result.get(1).map((i) => i.v)).toEqual(['first', 'second', 'third']);
  });
});

describe('shuffle', () => {
  it('returns a new array (does not mutate input)', () => {
    const original = [1, 2, 3, 4, 5];
    const frozen = Object.freeze([...original]);
    const result = shuffle(frozen);
    expect(frozen).toEqual(original);
    expect(result).not.toBe(frozen);
  });

  it('preserves all elements', () => {
    const input = [1, 2, 3, 4, 5];
    const result = shuffle(input);
    expect(result).toHaveLength(input.length);
    expect(result.sort()).toEqual(input.sort());
  });

  it('returns empty array for empty input', () => {
    expect(shuffle([])).toEqual([]);
  });

  it('returns single-element array unchanged', () => {
    expect(shuffle([42])).toEqual([42]);
  });
});
