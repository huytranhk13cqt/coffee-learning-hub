import { useReducer, useCallback } from 'react';
import { submitAnswer } from '../api/exercises.js';

// --- States ---
// idle:       initial, no data loaded
// answering:  user is working on current exercise
// submitting: answer sent to server, waiting for response
// feedback:   server responded, showing correct/incorrect + explanation
// finished:   all exercises completed

const initialState = {
  phase: 'idle',
  exercises: [],
  currentIndex: 0,
  currentAnswer: null,
  showHint: false,
  feedback: null, // { isCorrect, explanation, explanationVi }
  results: [], // [{ exerciseId, isCorrect, timeTaken }]
  error: null,
  startTime: null, // timestamp when current exercise started
};

function reducer(state, action) {
  switch (action.type) {
    case 'LOAD_EXERCISES':
      return {
        ...initialState,
        phase: action.payload.length > 0 ? 'answering' : 'finished',
        exercises: action.payload,
        startTime: Date.now(),
      };

    case 'SET_ANSWER':
      return {
        ...state,
        currentAnswer: action.payload,
      };

    case 'SHOW_HINT':
      return {
        ...state,
        showHint: true,
      };

    case 'SUBMIT':
      return {
        ...state,
        phase: 'submitting',
        error: null,
      };

    case 'SUBMIT_SUCCESS': {
      const { isCorrect, explanation, explanationVi } = action.payload;
      const exercise = state.exercises[state.currentIndex];
      const timeTaken = Math.round((Date.now() - state.startTime) / 1000);

      return {
        ...state,
        phase: 'feedback',
        feedback: { isCorrect, explanation, explanationVi },
        results: [
          ...state.results,
          { exerciseId: exercise.id, isCorrect, timeTaken },
        ],
      };
    }

    case 'SUBMIT_ERROR':
      return {
        ...state,
        phase: 'answering',
        error: action.payload,
      };

    case 'NEXT': {
      const nextIndex = state.currentIndex + 1;
      const isLast = nextIndex >= state.exercises.length;

      return {
        ...state,
        phase: isLast ? 'finished' : 'answering',
        currentIndex: isLast ? state.currentIndex : nextIndex,
        currentAnswer: null,
        showHint: false,
        feedback: null,
        error: null,
        startTime: isLast ? null : Date.now(),
      };
    }

    default:
      return state;
  }
}

export function useExerciseFlow() {
  const [state, dispatch] = useReducer(reducer, initialState);

  const loadExercises = useCallback((exercises) => {
    dispatch({ type: 'LOAD_EXERCISES', payload: exercises });
  }, []);

  const setAnswer = useCallback((answer) => {
    dispatch({ type: 'SET_ANSWER', payload: answer });
  }, []);

  const showHint = useCallback(() => {
    dispatch({ type: 'SHOW_HINT' });
  }, []);

  const submit = useCallback(async () => {
    const exercise = state.exercises[state.currentIndex];
    if (!exercise || state.currentAnswer === null) return;

    dispatch({ type: 'SUBMIT' });

    const timeTaken = Math.round((Date.now() - state.startTime) / 1000);

    try {
      const result = await submitAnswer(exercise.id, {
        answer: state.currentAnswer,
        timeTaken,
      });
      dispatch({ type: 'SUBMIT_SUCCESS', payload: result });
    } catch (err) {
      dispatch({
        type: 'SUBMIT_ERROR',
        payload: err.message || 'Submit failed',
      });
    }
  }, [
    state.exercises,
    state.currentIndex,
    state.currentAnswer,
    state.startTime,
  ]);

  const next = useCallback(() => {
    dispatch({ type: 'NEXT' });
  }, []);

  const currentExercise = state.exercises[state.currentIndex] || null;

  return {
    // State
    phase: state.phase,
    currentExercise,
    currentIndex: state.currentIndex,
    totalExercises: state.exercises.length,
    currentAnswer: state.currentAnswer,
    isHintVisible: state.showHint,
    feedback: state.feedback,
    results: state.results,
    error: state.error,

    // Actions
    loadExercises,
    setAnswer,
    showHint,
    submit,
    next,
  };
}
