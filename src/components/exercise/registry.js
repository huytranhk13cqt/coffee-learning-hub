import MultipleChoice from './types/MultipleChoice.jsx';
import FillBlank from './types/FillBlank.jsx';
import ErrorCorrection from './types/ErrorCorrection.jsx';
import SentenceTransform from './types/SentenceTransform.jsx';
import ArrangeWords from './types/ArrangeWords.jsx';
import TrueFalse from './types/TrueFalse.jsx';
import Matching from './types/Matching.jsx';
import CodeOutput from './types/CodeOutput.jsx';

/**
 * Component Registry: maps exercise type → React component.
 *
 * To add a new exercise type:
 * 1. Create src/components/exercise/types/NewType.jsx
 * 2. Add one entry here: 'new_type': NewType
 * 3. Add validation in server/services/answerValidator.js
 */
const exerciseRegistry = {
  multiple_choice: MultipleChoice,
  fill_blank: FillBlank,
  error_correction: ErrorCorrection,
  sentence_transform: SentenceTransform,
  arrange_words: ArrangeWords,
  true_false: TrueFalse,
  matching: Matching,
  code_output: CodeOutput,
};

export default exerciseRegistry;
