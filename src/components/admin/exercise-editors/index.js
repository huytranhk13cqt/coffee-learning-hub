import MultipleChoiceEditor from './MultipleChoiceEditor.jsx';
import MatchingEditor from './MatchingEditor.jsx';
import ArrangeWordsEditor from './ArrangeWordsEditor.jsx';
import FillBlankEditor from './FillBlankEditor.jsx';
import TrueFalseEditor from './TrueFalseEditor.jsx';
import SimpleAnswerEditor from './SimpleAnswerEditor.jsx';
import CodeOutputEditor from './CodeOutputEditor.jsx';

const exerciseEditorRegistry = {
  multiple_choice: MultipleChoiceEditor,
  fill_blank: FillBlankEditor,
  matching: MatchingEditor,
  arrange_words: ArrangeWordsEditor,
  true_false: TrueFalseEditor,
  error_correction: SimpleAnswerEditor,
  sentence_transform: SimpleAnswerEditor,
  code_output: CodeOutputEditor,
};

export default exerciseEditorRegistry;
