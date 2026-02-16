-- ============================================================================
-- SEED DATA: Philosophy (1 lesson)
-- Category: Philosophy (ID 12)
-- Lesson: Logic & Critical Thinking (ID 35)
-- Compatible with: schema.sql v7
-- Prerequisite: categories 1-11 and lessons 1-34 must already exist
-- NOTE: migration 008 expands chk_category_order to 0-20 (required for order_index 12)
-- ============================================================================


-- ============================================================================
-- CATEGORY 12: Philosophy
-- ============================================================================

INSERT INTO category (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('Philosophy', 'Triết Học', 'Explore the foundations of logical reasoning, critical thinking, and philosophical argumentation', 'Khám phá nền tảng của lập luận logic, tư duy phản biện và luận chứng triết học', 'Psychology', '#7c3aed', 12);


-- ############################################################################
-- LESSON 35: LOGIC & CRITICAL THINKING (lesson_id = 35)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(12, 'Logic & Critical Thinking', 'Logic & Tư Duy Phản Biện', 'philosophy-logic-critical-thinking', 'Learn to construct valid arguments, identify logical fallacies, and reason from premises to conclusions', 'Học cách xây dựng luận chứng hợp lệ, nhận diện ngụy biện logic và suy luận từ tiền đề đến kết luận', 'intermediate', 35, 1);

-- Usages (IDs 105-107)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(35, 'Deductive vs inductive reasoning', 'Suy luận diễn dịch và quy nạp', 'Deductive reasoning moves from general premises to a specific conclusion — if the premises are true and the form is valid, the conclusion must be true. Inductive reasoning moves from specific observations to a general conclusion — the conclusion is probable but never certain.', 'Suy luận diễn dịch đi từ tiền đề tổng quát đến kết luận cụ thể — nếu tiền đề đúng và hình thức hợp lệ, kết luận phải đúng. Suy luận quy nạp đi từ quan sát cụ thể đến kết luận tổng quát — kết luận có khả năng nhưng không bao giờ chắc chắn.', 'Psychology', TRUE, 1),
(35, 'Identifying common logical fallacies', 'Nhận diện các ngụy biện logic phổ biến', 'A logical fallacy is a flaw in reasoning that makes an argument invalid or misleading. Recognizing fallacies helps you evaluate arguments critically and avoid being persuaded by faulty logic.', 'Ngụy biện logic là lỗi trong lập luận khiến luận chứng không hợp lệ hoặc gây hiểu lầm. Nhận biết ngụy biện giúp bạn đánh giá luận chứng phản biện và tránh bị thuyết phục bởi logic sai lầm.', 'Lightbulb', TRUE, 2),
(35, 'Constructing and evaluating valid arguments', 'Xây dựng và đánh giá luận chứng hợp lệ', 'A valid argument has a logical structure where the conclusion follows necessarily from the premises. A sound argument is valid AND has true premises. Learning to distinguish validity from soundness is fundamental to clear thinking.', 'Luận chứng hợp lệ có cấu trúc logic mà kết luận theo sau tất yếu từ tiền đề. Luận chứng vững chắc vừa hợp lệ VÀ có tiền đề đúng. Học cách phân biệt tính hợp lệ với tính vững chắc là nền tảng của tư duy rõ ràng.', 'School', TRUE, 3);

-- Examples for usage 105 (IDs 205-206)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(105, 'All humans are mortal. Socrates is a human. Therefore, Socrates is mortal.', 'Mọi người đều phải chết. Socrates là con người. Vậy, Socrates phải chết.', 'This is a classic deductive syllogism (Aristotle). If both premises are true, the conclusion is guaranteed — it cannot be false. The reasoning flows from the general ("all humans") to the specific ("Socrates").', 'Đây là tam đoạn luận diễn dịch kinh điển (Aristotle). Nếu cả hai tiền đề đúng, kết luận được đảm bảo — không thể sai. Lập luận đi từ tổng quát ("mọi người") đến cụ thể ("Socrates").', 'deductive', 1),
(105, 'The sun has risen every morning for all of recorded history. Therefore, the sun will rise tomorrow.', 'Mặt trời đã mọc mỗi sáng trong suốt lịch sử được ghi chép. Vậy, mặt trời sẽ mọc ngày mai.', 'This is inductive reasoning — past observations lead to a probable conclusion, but it is never logically guaranteed. David Hume (1739) called this the "problem of induction": no amount of past evidence can prove a future event with certainty.', 'Đây là suy luận quy nạp — quan sát quá khứ dẫn đến kết luận có khả năng, nhưng không bao giờ được đảm bảo logic. David Hume (1739) gọi đây là "vấn đề quy nạp": không lượng bằng chứng quá khứ nào có thể chứng minh sự kiện tương lai một cách chắc chắn.', 'inductive', 2);

-- Examples for usage 106 (IDs 207-208)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(106, 'You cannot trust Dr. Lee''s research on climate change because she is funded by an environmental organization.', 'Bạn không thể tin nghiên cứu của Tiến sĩ Lee về biến đổi khí hậu vì bà được tài trợ bởi tổ chức môi trường.', 'This is an ad hominem fallacy — attacking the person rather than the argument. The funding source does not automatically invalidate the research; one must evaluate the evidence and methodology on their own merits.', 'Đây là ngụy biện ad hominem — tấn công người thay vì luận chứng. Nguồn tài trợ không tự động vô hiệu hóa nghiên cứu; cần đánh giá bằng chứng và phương pháp dựa trên giá trị riêng của chúng.', 'ad hominem', 1),
(106, 'Either you support banning all cars from the city or you do not care about the environment at all.', 'Hoặc bạn ủng hộ cấm tất cả ô tô khỏi thành phố hoặc bạn hoàn toàn không quan tâm đến môi trường.', 'This is a false dilemma (black-or-white fallacy) — presenting only two extreme options when many intermediate positions exist. One can care about the environment while supporting moderate transportation policies.', 'Đây là ngụy biện lưỡng nan giả (ngụy biện đen-hoặc-trắng) — chỉ đưa ra hai lựa chọn cực đoan khi có nhiều vị trí trung gian. Người ta có thể quan tâm môi trường mà vẫn ủng hộ chính sách giao thông ôn hòa.', 'false dilemma', 2);

-- Examples for usage 107 (IDs 209-210)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(107, 'Premise 1: All birds have wings. Premise 2: Penguins are birds. Conclusion: Penguins have wings. — This argument is both valid and sound.', 'Tiền đề 1: Mọi loài chim đều có cánh. Tiền đề 2: Chim cánh cụt là chim. Kết luận: Chim cánh cụt có cánh. — Luận chứng này vừa hợp lệ vừa vững chắc.', 'The argument is valid because the conclusion follows logically from the premises. It is also sound because both premises are actually true (penguins do have wings, though they use them for swimming, not flying).', 'Luận chứng hợp lệ vì kết luận theo sau logic từ tiền đề. Nó cũng vững chắc vì cả hai tiền đề thực sự đúng (chim cánh cụt có cánh, dù dùng để bơi, không bay).', 'valid and sound', 1),
(107, 'Premise 1: All fish can fly. Premise 2: A salmon is a fish. Conclusion: A salmon can fly. — This argument is valid but NOT sound.', 'Tiền đề 1: Mọi loài cá đều biết bay. Tiền đề 2: Cá hồi là cá. Kết luận: Cá hồi biết bay. — Luận chứng này hợp lệ nhưng KHÔNG vững chắc.', 'The logical structure is perfect — if the premises were true, the conclusion would have to be true. But Premise 1 is false ("all fish can fly"), so despite being valid in form, the argument is unsound and the conclusion is false.', 'Cấu trúc logic hoàn hảo — nếu tiền đề đúng, kết luận phải đúng. Nhưng Tiền đề 1 sai ("mọi loài cá đều biết bay"), nên dù hợp lệ về hình thức, luận chứng không vững chắc và kết luận sai.', 'valid but NOT sound', 2);

-- Tips (IDs 104-106)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(35, 'Always question your assumptions', 'Luôn đặt câu hỏi về giả định của bạn', 'Every argument rests on premises — some stated, some hidden. Before accepting any conclusion, ask: "What assumptions am I making? Are they actually true?" Socrates built his entire method on this principle: question everything, especially what seems obvious. The strongest thinkers are those who examine their own beliefs most rigorously.', 'Mọi luận chứng đều dựa trên tiền đề — một số được nêu rõ, một số ẩn giấu. Trước khi chấp nhận bất kỳ kết luận nào, hãy hỏi: "Tôi đang giả định điều gì? Chúng có thực sự đúng không?" Socrates xây dựng toàn bộ phương pháp trên nguyên tắc này: đặt câu hỏi về mọi thứ, đặc biệt những gì có vẻ hiển nhiên. Những người tư duy mạnh nhất là những người kiểm tra niềm tin của chính mình nghiêm ngặt nhất.', 'general', 'high', 'Lightbulb', 1),
(35, 'Correlation is not causation', 'Tương quan không phải nhân quả', 'One of the most common reasoning errors is assuming that because two things occur together, one causes the other. Ice cream sales and drowning rates both rise in summer — but ice cream does not cause drowning. Always ask: "Is there a third factor (a confound) that explains both?" This mistake appears constantly in news headlines, advertising, and everyday arguments.', 'Một trong những lỗi lập luận phổ biến nhất là giả định rằng vì hai thứ xảy ra cùng nhau, một thứ gây ra thứ kia. Doanh số kem và tỷ lệ đuối nước đều tăng vào mùa hè — nhưng kem không gây đuối nước. Luôn hỏi: "Có yếu tố thứ ba (yếu tố gây nhiễu) giải thích cả hai không?" Sai lầm này xuất hiện liên tục trong tiêu đề tin tức, quảng cáo và lập luận hàng ngày.', 'common_mistake', 'high', 'Warning', 2),
(35, 'Look for hidden premises in arguments', 'Tìm tiền đề ẩn trong luận chứng', 'Many persuasive arguments rely on unstated assumptions. When someone says "She went to a top university, so she must be intelligent," the hidden premise is "everyone at top universities is intelligent" — which is debatable. Practice making implicit premises explicit: this reveals where arguments are weakest and where you should push back.', 'Nhiều luận chứng thuyết phục dựa vào giả định không được nêu rõ. Khi ai đó nói "Cô ấy học trường đại học hàng đầu, nên cô ấy phải thông minh," tiền đề ẩn là "mọi người ở trường đại học hàng đầu đều thông minh" — điều này có thể tranh luận. Thực hành biến tiền đề ngầm thành rõ ràng: điều này cho thấy luận chứng yếu nhất ở đâu và bạn nên phản biện ở đâu.', 'shortcut', 'medium', 'Info', 3);

-- Sections (IDs 67-69)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(35, 'markdown', 'The Structure of Logical Arguments', 'Cấu Trúc Của Luận Chứng Logic',
'## How Arguments Work

An **argument** in philosophy is not a quarrel — it is a structured set of statements where **premises** lead to a **conclusion**.

### Formal Argument Structure

```
Premise 1:   All mammals are warm-blooded.
Premise 2:   A whale is a mammal.
─────────────────────────────────────────
Conclusion:  Therefore, a whale is warm-blooded.
```

This is a **valid deductive argument**: the conclusion follows necessarily from the premises.

### Deduction vs Induction

| | Deductive | Inductive |
|---|---|---|
| **Direction** | General → Specific | Specific → General |
| **Certainty** | Conclusion is guaranteed (if valid + sound) | Conclusion is probable, never certain |
| **Example** | All X are Y. Z is X. Therefore Z is Y. | Every X we have observed is Y. Therefore all X are probably Y. |
| **Strength** | Cannot be "somewhat valid" — either valid or not | Can be strong or weak depending on evidence |

### Valid vs Invalid Reasoning

**Valid (modus ponens):**
```
If it rains, the ground gets wet.
It is raining.
∴ The ground is wet.          ✓
```

**Invalid (affirming the consequent):**
```
If it rains, the ground gets wet.
The ground is wet.
∴ It is raining.              ✗ (a sprinkler could have caused it)
```

### A Thought Experiment: The Ship of Theseus

Imagine a ship whose wooden planks are replaced one by one over many years. After every plank has been replaced, is it still the same ship? What if someone rebuilds a second ship from all the removed planks — which one is the "real" Ship of Theseus?

This ancient puzzle (attributed to Plutarch) challenges our assumptions about **identity and change**. There is no single "correct" answer — the value lies in examining your reasoning and the hidden premises behind your intuitions.',
'## Cách Luận Chứng Hoạt Động

Một **luận chứng** trong triết học không phải cuộc cãi vã — nó là tập hợp có cấu trúc các phát biểu mà **tiền đề** dẫn đến **kết luận**.

### Cấu Trúc Luận Chứng Hình Thức

```
Tiền đề 1:   Mọi động vật có vú đều máu nóng.
Tiền đề 2:   Cá voi là động vật có vú.
─────────────────────────────────────────
Kết luận:    Vậy, cá voi là máu nóng.
```

Đây là **luận chứng diễn dịch hợp lệ**: kết luận theo sau tất yếu từ tiền đề.

### Diễn Dịch vs Quy Nạp

| | Diễn dịch | Quy nạp |
|---|---|---|
| **Hướng** | Tổng quát → Cụ thể | Cụ thể → Tổng quát |
| **Chắc chắn** | Kết luận được đảm bảo (nếu hợp lệ + vững chắc) | Kết luận có khả năng, không bao giờ chắc chắn |
| **Ví dụ** | Mọi X là Y. Z là X. Vậy Z là Y. | Mọi X ta quan sát được là Y. Vậy tất cả X có lẽ là Y. |
| **Sức mạnh** | Không thể "hơi hợp lệ" — hoặc hợp lệ hoặc không | Có thể mạnh hoặc yếu tùy bằng chứng |

### Lập Luận Hợp Lệ vs Không Hợp Lệ

**Hợp lệ (modus ponens):**
```
Nếu trời mưa, mặt đất ướt.
Trời đang mưa.
∴ Mặt đất ướt.               ✓
```

**Không hợp lệ (khẳng định hệ quả):**
```
Nếu trời mưa, mặt đất ướt.
Mặt đất ướt.
∴ Trời đang mưa.             ✗ (vòi phun nước có thể gây ra)
```

### Thí Nghiệm Tư Duy: Con Tàu Theseus

Hãy tưởng tượng một con tàu có các tấm gỗ được thay thế từng tấm một qua nhiều năm. Sau khi mọi tấm đã được thay, nó có còn là cùng một con tàu không? Nếu ai đó xây lại con tàu thứ hai từ tất cả các tấm gỗ đã tháo — con nào là con tàu Theseus "thật"?

Câu đố cổ đại này (gán cho Plutarch) thách thức giả định của chúng ta về **bản sắc và sự thay đổi**. Không có câu trả lời "đúng" duy nhất — giá trị nằm ở việc kiểm tra lập luận và tiền đề ẩn đằng sau trực giác của bạn.', 1, '{}'),

(35, 'key_points', 'Key Points', 'Điểm Chính',
'- **Deductive reasoning** moves from general premises to a specific conclusion — the conclusion is guaranteed if the argument is valid and the premises are true
- **Inductive reasoning** moves from specific observations to a general conclusion — the conclusion is probable but never logically certain
- A **valid** argument has correct logical form (conclusion follows from premises), regardless of whether premises are actually true
- A **sound** argument is valid AND has true premises — this is the gold standard of reasoning
- **Logical fallacies** are errors in reasoning: ad hominem (attack the person), false dilemma (only two options), straw man (misrepresent the argument), appeal to authority (trust status over evidence)
- **Correlation does not imply causation** — two things occurring together does not mean one causes the other',
'- **Suy luận diễn dịch** đi từ tiền đề tổng quát đến kết luận cụ thể — kết luận được đảm bảo nếu luận chứng hợp lệ và tiền đề đúng
- **Suy luận quy nạp** đi từ quan sát cụ thể đến kết luận tổng quát — kết luận có khả năng nhưng không bao giờ chắc chắn về mặt logic
- Luận chứng **hợp lệ** có hình thức logic đúng (kết luận theo sau từ tiền đề), bất kể tiền đề có thực sự đúng hay không
- Luận chứng **vững chắc** vừa hợp lệ VÀ có tiền đề đúng — đây là tiêu chuẩn vàng của lập luận
- **Ngụy biện logic** là lỗi trong lập luận: ad hominem (tấn công người), lưỡng nan giả (chỉ hai lựa chọn), người rơm (xuyên tạc luận chứng), viện dẫn quyền uy (tin vào vị thế hơn bằng chứng)
- **Tương quan không ngụ ý nhân quả** — hai thứ xảy ra cùng nhau không có nghĩa một thứ gây ra thứ kia', 2, '{}'),

(35, 'info_box', 'The Trolley Problem', 'Bài Toán Toa Xe',
'**A famous thought experiment by Philippa Foot (1967):**

A runaway trolley is heading toward five people tied to the tracks. You are standing next to a lever. If you pull the lever, the trolley will switch to a side track — but one person is tied to that track and will be killed.

**Do you pull the lever?**

- **Utilitarian view:** Yes — saving five lives at the cost of one produces the greatest good for the greatest number.
- **Deontological view:** No — actively choosing to kill someone (even to save others) violates the moral rule against taking a life.
- **Virtue ethics view:** What would a virtuous person do? The answer depends on character, not calculation.

There is no "right" answer. The value of this thought experiment is that it **forces you to examine the hidden premises behind your moral intuitions** — exactly the skill that critical thinking develops.

**Try this:** After choosing your answer, argue the opposite position for two minutes. What did you discover about your reasoning?',
'**Thí nghiệm tư duy nổi tiếng của Philippa Foot (1967):**

Một toa xe mất kiểm soát đang lao về phía năm người bị trói trên đường ray. Bạn đang đứng cạnh một cần gạt. Nếu bạn kéo cần gạt, toa xe sẽ chuyển sang đường ray phụ — nhưng một người bị trói trên đường ray đó và sẽ bị giết.

**Bạn có kéo cần gạt không?**

- **Quan điểm công lợi:** Có — cứu năm mạng sống với cái giá một mạng tạo ra lợi ích lớn nhất cho số đông nhất.
- **Quan điểm nghĩa vụ luận:** Không — chủ động chọn giết ai đó (dù để cứu người khác) vi phạm quy tắc đạo đức chống lại việc cướp đi mạng sống.
- **Quan điểm đức hạnh:** Một người đức hạnh sẽ làm gì? Câu trả lời phụ thuộc vào phẩm cách, không phải phép tính.

Không có câu trả lời "đúng". Giá trị của thí nghiệm tư duy này là nó **buộc bạn kiểm tra tiền đề ẩn đằng sau trực giác đạo đức** — chính xác kỹ năng mà tư duy phản biện phát triển.

**Thử điều này:** Sau khi chọn câu trả lời, hãy lập luận theo vị trí ngược lại trong hai phút. Bạn phát hiện điều gì về lập luận của mình?', 3, '{"variant": "warning"}');

-- Diagram section: argument evaluation flowchart (order_index 4)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(35, 'diagram', 'Evaluating Arguments', 'Đánh giá luận chứng',
'This flowchart shows how to evaluate any deductive argument. First check **validity** (does the conclusion follow logically?), then check **soundness** (are the premises actually true?). A sound argument is both valid AND has true premises.',
'Lưu đồ này cho thấy cách đánh giá bất kỳ luận chứng diễn dịch nào. Đầu tiên kiểm tra **tính hợp lệ** (kết luận có theo logic?), rồi kiểm tra **tính đúng đắn** (tiền đề có thật sự đúng?). Luận chứng đúng đắn vừa hợp lệ VÀ có tiền đề đúng.', 4,
'{"code": "graph TD\n    A([Evaluate Argument]) --> B{Does conclusion follow logically from premises?}\n    B -->|Yes| C[Valid Argument]\n    B -->|No| D[Invalid Argument]\n    C --> E{Are all premises actually true?}\n    E -->|Yes| F[Sound Argument]\n    E -->|No| G[Valid but Unsound]"}');

-- Exercise 239: Multiple Choice (11 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(35, 'multiple_choice', 'easy', 'Which type of reasoning moves from general premises to a specific conclusion?', 'Loại suy luận nào đi từ tiền đề tổng quát đến kết luận cụ thể?', 'Select the reasoning method where the conclusion is guaranteed if the premises are true and the form is valid.', 'Chọn phương pháp suy luận mà kết luận được đảm bảo nếu tiền đề đúng và hình thức hợp lệ.', 'Deductive reasoning moves from the general to the specific. If the premises are true and the logical form is valid, the conclusion must be true. Aristotle formalized this in his theory of syllogisms. Inductive reasoning, by contrast, moves from specific observations to general conclusions and can only produce probable (not certain) conclusions.', 'Suy luận diễn dịch đi từ tổng quát đến cụ thể. Nếu tiền đề đúng và hình thức logic hợp lệ, kết luận phải đúng. Aristotle hình thức hóa điều này trong lý thuyết tam đoạn luận. Suy luận quy nạp, ngược lại, đi từ quan sát cụ thể đến kết luận tổng quát và chỉ có thể tạo kết luận có khả năng (không chắc chắn).', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(239, 'A', 'Inductive reasoning', FALSE, 'Inductive reasoning moves in the opposite direction — from specific observations to general conclusions', 1),
(239, 'B', 'Abductive reasoning', FALSE, 'Abductive reasoning infers the most likely explanation for an observation — it is different from deduction', 2),
(239, 'C', 'Deductive reasoning', TRUE, 'Correct! Deductive reasoning guarantees the conclusion if the premises are true and the form is valid', 3),
(239, 'D', 'Analogical reasoning', FALSE, 'Analogical reasoning draws conclusions based on similarities between cases — it does not guarantee conclusions', 4);

-- Exercise 240: Fill Blank (12 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(35, 'fill_blank', 'easy', 'Fill in the name of this common logical fallacy.', 'Điền tên của ngụy biện logic phổ biến này.', 'Attacking the character or motives of a person making an argument, rather than addressing the argument itself, is called an ___ fallacy.', 'Tấn công tính cách hoặc động cơ của người đưa ra luận chứng, thay vì giải quyết luận chứng, được gọi là ngụy biện ___.', 'ad hominem', 'Ad hominem (Latin for "to the person") is one of the most common informal fallacies. It occurs when someone dismisses an argument by attacking the person making it rather than engaging with the evidence or logic. Example: "You cannot trust his opinion on economics because he is not wealthy."', 'Ad hominem (tiếng Latin nghĩa là "đến người") là một trong những ngụy biện phi hình thức phổ biến nhất. Nó xảy ra khi ai đó bác bỏ luận chứng bằng cách tấn công người đưa ra nó thay vì tham gia với bằng chứng hoặc logic. Ví dụ: "Bạn không thể tin ý kiến của anh ấy về kinh tế vì anh ấy không giàu."', 10, 2);

-- Exercise 241: Error Correction (14 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(35, 'error_correction', 'medium', 'Fix the logical error in this argument.', 'Sửa lỗi logic trong luận chứng này.', 'If a student studies hard, they will pass the exam. Maria passed the exam. Therefore, Maria studied hard.', 'Nếu học sinh học chăm, họ sẽ đỗ. Maria đã đỗ. Vậy, Maria đã học chăm.', 'If a student studies hard, they will pass the exam. Maria studied hard. Therefore, Maria passed the exam.', 'The original argument commits the fallacy of "affirming the consequent." Just because the exam was passed does not mean studying hard was the cause — Maria could have guessed correctly or copied. The corrected version uses valid modus ponens: affirming the antecedent (the "if" part) to derive the consequent.', 'Luận chứng gốc mắc ngụy biện "khẳng định hệ quả." Chỉ vì đỗ không có nghĩa học chăm là nguyên nhân — Maria có thể đoán đúng hoặc sao chép. Phiên bản sửa dùng modus ponens hợp lệ: khẳng định tiền kiện (phần "nếu") để suy ra hệ quả.', 'The original affirms the consequent instead of the antecedent. Which part should be affirmed?', 'Bản gốc khẳng định hệ quả thay vì tiền kiện. Phần nào nên được khẳng định?', 15, 3);

-- Exercise 242: Sentence Transform (12 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(35, 'sentence_transform', 'medium', 'Rewrite this inductive argument as a deductive argument with explicit premises.', 'Viết lại luận chứng quy nạp này thành luận chứng diễn dịch với tiền đề rõ ràng.', 'Every cat I have ever seen has four legs, so all cats have four legs.', 'Mọi con mèo tôi từng thấy đều có bốn chân, nên tất cả mèo đều có bốn chân.', 'All cats are four-legged animals. My pet is a cat. Therefore, my pet has four legs.', 'The inductive version draws a general conclusion from limited observations ("every cat I have seen"), which can never be certain. The deductive version starts from a general premise ("all cats are four-legged animals") and applies it to a specific case, guaranteeing the conclusion if the premises are true.', 'Phiên bản quy nạp rút kết luận tổng quát từ quan sát hạn chế ("mọi con mèo tôi từng thấy"), không bao giờ chắc chắn. Phiên bản diễn dịch bắt đầu từ tiền đề tổng quát ("tất cả mèo là động vật bốn chân") và áp dụng vào trường hợp cụ thể, đảm bảo kết luận nếu tiền đề đúng.', 15, 4);

-- Exercise 243: Arrange Words (11 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(35, 'arrange_words', 'easy', 'Arrange these words to form a valid deductive conclusion from the premises: "All philosophers question assumptions" and "Socrates is a philosopher."', 'Sắp xếp các từ để tạo kết luận diễn dịch hợp lệ từ tiền đề: "Mọi triết gia đều đặt câu hỏi về giả định" và "Socrates là triết gia."', '["assumptions", "Socrates", "Therefore,", "questions"]', 'Therefore, Socrates questions assumptions', 'This follows the classic syllogistic form (modus ponens): All A are B, C is A, therefore C is B. The conclusion must apply the general predicate ("questions assumptions") to the specific subject ("Socrates") because Socrates belongs to the category of philosophers.', 'Điều này tuân theo hình thức tam đoạn luận kinh điển (modus ponens): Mọi A là B, C là A, vậy C là B. Kết luận phải áp dụng thuộc tính tổng quát ("đặt câu hỏi về giả định") cho chủ thể cụ thể ("Socrates") vì Socrates thuộc nhóm triết gia.', 10, 5);

-- Exercise 244: Matching (9 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(35, 'matching', 'easy', 'Match each logical fallacy to its description.', 'Nối mỗi ngụy biện logic với mô tả tương ứng.', 'These four fallacies are among the most common errors in everyday reasoning. Learning to recognize them by name helps you identify flawed arguments quickly in debates, media, and daily conversations.', 'Bốn ngụy biện này nằm trong số các lỗi phổ biến nhất trong lập luận hàng ngày. Học cách nhận biết chúng theo tên giúp bạn xác định nhanh các luận chứng sai trong tranh luận, truyền thông và hội thoại hàng ngày.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(244, 'Ad hominem', 'Ad hominem', 'Attacking the person instead of the argument', 'Tấn công người thay vì luận chứng', 1),
(244, 'Straw man', 'Người rơm', 'Misrepresenting an argument to make it easier to attack', 'Xuyên tạc luận chứng để dễ tấn công hơn', 2),
(244, 'False dilemma', 'Lưỡng nan giả', 'Presenting only two options when more exist', 'Chỉ đưa ra hai lựa chọn khi có nhiều hơn', 3),
(244, 'Appeal to authority', 'Viện dẫn quyền uy', 'Using someone''s status rather than evidence to support a claim', 'Dùng vị thế của ai đó thay vì bằng chứng để ủng hộ tuyên bố', 4);

-- Exercise 245: True/False (12 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(35, 'true_false', 'easy', 'Is this statement about logic correct?', 'Phát biểu này về logic có đúng không?', 'An argument can be logically valid even if its premises are false.', 'Một luận chứng có thể hợp lệ về mặt logic ngay cả khi tiền đề của nó sai.', 'true', 'True! Validity refers only to the logical structure of an argument — whether the conclusion follows from the premises. It says nothing about whether the premises are actually true. For example: "All fish can fly. A salmon is a fish. Therefore, a salmon can fly." The form is valid (the conclusion follows), but the argument is unsound because Premise 1 is false. An argument that is both valid AND has true premises is called "sound."', 'Đúng! Tính hợp lệ chỉ đề cập đến cấu trúc logic của luận chứng — liệu kết luận có theo sau từ tiền đề hay không. Nó không nói gì về việc tiền đề có thực sự đúng hay không. Ví dụ: "Mọi loài cá đều biết bay. Cá hồi là cá. Vậy, cá hồi biết bay." Hình thức hợp lệ (kết luận theo sau), nhưng luận chứng không vững chắc vì Tiền đề 1 sai. Luận chứng vừa hợp lệ VÀ có tiền đề đúng được gọi là "vững chắc."', 5, 7);


-- ############################################################################
-- COMPARISON: History (lesson 33) vs Philosophy (lesson 35)
-- ############################################################################

INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(33, 35, 'Analyzing the past', 'Phân tích quá khứ', 'History examines events, dates, and social changes through empirical evidence — it asks "What happened?" and "Why did it happen?" based on documented records and artifacts.', 'Lịch sử kiểm tra sự kiện, ngày tháng và thay đổi xã hội qua bằng chứng thực nghiệm — nó hỏi "Chuyện gì đã xảy ra?" và "Tại sao nó xảy ra?" dựa trên hồ sơ và hiện vật được ghi lại.', 'Philosophy questions the meaning, ethics, and logic behind historical events — it asks "Was it morally justified?" and "What assumptions underlie our interpretation of what happened?"', 'Triết học đặt câu hỏi về ý nghĩa, đạo đức và logic đằng sau sự kiện lịch sử — nó hỏi "Nó có chính đáng về mặt đạo đức không?" và "Giả định nào nằm dưới cách diễn giải của chúng ta về những gì đã xảy ra?"', 'A historian studies the causes and timeline of the French Revolution using primary sources and records.', 'Nhà sử học nghiên cứu nguyên nhân và dòng thời gian của Cách mạng Pháp sử dụng nguồn sơ cấp và hồ sơ.', 'A philosopher asks whether violent revolution is ever morally justified, and examines the logical structure of arguments for and against it.', 'Triết gia hỏi liệu cách mạng bạo lực có bao giờ chính đáng về đạo đức hay không, và kiểm tra cấu trúc logic của luận chứng ủng hộ và phản đối.', 'History and philosophy complement each other — history provides the facts, philosophy provides the framework for interpreting and evaluating them. Studying both makes you a stronger critical thinker.', 'Lịch sử và triết học bổ sung cho nhau — lịch sử cung cấp sự kiện, triết học cung cấp khuôn khổ để diễn giải và đánh giá chúng. Học cả hai giúp bạn trở thành người tư duy phản biện mạnh hơn.', 1);


-- ============================================================================
-- VERIFICATION QUERY
-- ============================================================================
-- SELECT l.id, l.name, l.slug,
--   (SELECT COUNT(*) FROM lesson_usage WHERE lesson_id = l.id) AS usages,
--   (SELECT COUNT(*) FROM tip WHERE lesson_id = l.id) AS tips,
--   (SELECT COUNT(*) FROM lesson_section WHERE lesson_id = l.id) AS sections,
--   (SELECT COUNT(*) FROM exercise WHERE lesson_id = l.id) AS exercises
-- FROM lesson l WHERE l.group_id = 12 ORDER BY l.order_index;
--
-- Expected result:
-- id | name                       | slug                                | usages | tips | sections | exercises
-- 35 | Logic & Critical Thinking  | philosophy-logic-critical-thinking  |      3 |    3 |        3 |         7
