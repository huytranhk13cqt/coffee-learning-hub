import { useContext } from 'react';
import { GamificationContext } from '../contexts/gamificationContext.js';

export function useGamification() {
  return useContext(GamificationContext);
}
