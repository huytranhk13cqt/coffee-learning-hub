-- ============================================================================
-- SEED DATA: Philosophy — Extra Lessons
-- Adds 2 lessons to existing category 'Philosophy' (ID 12)
-- Prerequisite: seed_philosophy.sql must have been applied (lesson 35 exists)
-- lesson order_index continues from 1 (existing) → 3, 4
-- ============================================================================


-- ############################################################################
-- LESSON: EPISTEMOLOGY: THEORY OF KNOWLEDGE (slug = epistemology-basics)
-- order_index = 3
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Epistemology: Theory of Knowledge',
  'Nhận Thức Luận: Lý Thuyết Tri Thức',
  'epistemology-basics',
  'Explore what we can know, how we know it, and the limits of knowledge',
  'Khám phá những gì chúng ta có thể biết, cách chúng ta biết và giới hạn của tri thức',
  'intermediate',
  35,
  3
FROM category WHERE name = 'Philosophy';

-- Usages
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'epistemology-basics'),
  'Justified True Belief',
  'Niềm Tin Đúng Có Cơ Sở',
  'Plato''s classical definition of knowledge is "justified true belief" (JTB): to know something, the belief must be (1) true, (2) held by the knower, and (3) justified by adequate reasons or evidence. All three conditions are necessary — true belief without justification is lucky guessing, and justified false belief is honest error.',
  'Định nghĩa cổ điển của Plato về tri thức là "niềm tin đúng có cơ sở" (JTB): để biết điều gì đó, niềm tin phải (1) đúng, (2) được người biết tin, và (3) được biện minh bởi lý do hoặc bằng chứng đầy đủ. Cả ba điều kiện đều cần thiết — niềm tin đúng không có biện minh là đoán may mắn, và niềm tin sai có biện minh là lỗi trung thực.',
  'Lightbulb',
  TRUE,
  1
),
(
  (SELECT id FROM lesson WHERE slug = 'epistemology-basics'),
  'Rationalism vs Empiricism',
  'Chủ Nghĩa Duy Lý vs Chủ Nghĩa Kinh Nghiệm',
  'Rationalism holds that reason is the primary source of knowledge — some truths can be known independently of experience (a priori). Empiricism holds that all knowledge ultimately derives from sensory experience (a posteriori). This debate shaped modern philosophy: Descartes and Leibniz championed rationalism, while Locke, Berkeley, and Hume defended empiricism.',
  'Chủ nghĩa duy lý cho rằng lý trí là nguồn tri thức chính — một số sự thật có thể được biết độc lập với kinh nghiệm (a priori). Chủ nghĩa kinh nghiệm cho rằng mọi tri thức cuối cùng đến từ kinh nghiệm giác quan (a posteriori). Cuộc tranh luận này định hình triết học hiện đại: Descartes và Leibniz là nhà vô địch của chủ nghĩa duy lý, trong khi Locke, Berkeley và Hume bảo vệ chủ nghĩa kinh nghiệm.',
  'Psychology',
  TRUE,
  2
);

-- Sections
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'epistemology-basics'),
  'markdown',
  'What Can We Know?',
  'Chúng Ta Có Thể Biết Gì?',
  '## Epistemology: The Study of Knowledge

**Epistemology** (from Greek *episteme* = knowledge, *logos* = study) is the branch of philosophy that investigates the nature, sources, and limits of human knowledge. At its core: **What do we know? How do we know it? Can we be certain?**

### The Classic Definition: Justified True Belief

Plato (in the *Meno* and *Theaetetus*) proposed that knowledge = **Justified True Belief (JTB)**:

| Condition | Requirement | Example |
|-----------|-------------|---------|
| **True** | The belief must correspond to reality | "The Earth orbits the Sun" is true |
| **Believed** | The person must actually hold the belief | You must believe it, not just say it |
| **Justified** | There must be good reasons/evidence | Based on astronomical observation, not guessing |

### The Gettier Problem (1963)

Edmund Gettier published a famous 3-page paper showing JTB is insufficient. His examples: a person might have *justified true belief* that is actually just lucky coincidence — accidentally meeting the JTB criteria without genuinely knowing.

**Example:** You check your phone at 2:14pm and see "2:14." You form the justified true belief "it is 2:14pm." But your phone is stopped — it just happens to show the correct time by coincidence. You have JTB, but do you *know* the time?

This remains one of philosophy''s most active research problems.

### Two Sources of Knowledge

| | **Rationalism** | **Empiricism** |
|---|---|---|
| **Key claim** | Reason is the primary source of knowledge | Experience is the primary source of knowledge |
| **A priori knowledge** | Yes — mathematical truths, logical truths | Minimal — only trivial analytic truths |
| **Key thinkers** | Descartes, Leibniz, Spinoza | Locke, Hume, Berkeley |
| **Famous claim** | "I think, therefore I am" (Descartes) | "Nothing is in the intellect that was not first in the senses" (Locke) |

### Skepticism

**Skepticism** is the view that knowledge is difficult or impossible to achieve. Descartes used radical skepticism as a *method*: what if an evil demon deceives you about everything? What can you know with absolute certainty? His answer: *Cogito ergo sum* — "I think, therefore I am." The act of doubting proves the existence of the doubter.',
  '## Nhận Thức Luận: Nghiên Cứu Tri Thức

**Nhận thức luận** (từ tiếng Hy Lạp *episteme* = tri thức, *logos* = nghiên cứu) là nhánh triết học điều tra bản chất, nguồn gốc và giới hạn của tri thức con người. Cốt lõi của nó: **Chúng ta biết gì? Chúng ta biết như thế nào? Chúng ta có thể chắc chắn không?**

### Định Nghĩa Cổ Điển: Niềm Tin Đúng Có Cơ Sở

Plato (trong *Meno* và *Theaetetus*) đề xuất rằng tri thức = **Niềm Tin Đúng Có Cơ Sở (JTB)**:

| Điều kiện | Yêu cầu | Ví dụ |
|----------|---------|-------|
| **Đúng** | Niềm tin phải tương ứng với thực tế | "Trái Đất quay quanh Mặt Trời" là đúng |
| **Được tin** | Người đó phải thực sự giữ niềm tin | Bạn phải tin nó, không chỉ nói |
| **Có cơ sở** | Phải có lý do/bằng chứng tốt | Dựa trên quan sát thiên văn, không phải đoán |

### Vấn Đề Gettier (1963)

Edmund Gettier đã xuất bản bài báo nổi tiếng 3 trang cho thấy JTB không đủ. Các ví dụ của ông: một người có thể có *niềm tin đúng có cơ sở* thực ra chỉ là sự trùng hợp may mắn — vô tình đáp ứng tiêu chí JTB mà không thực sự biết.

**Ví dụ:** Bạn kiểm tra điện thoại lúc 2:14 chiều và thấy "2:14." Bạn hình thành niềm tin đúng có cơ sở "bây giờ là 2:14 chiều." Nhưng điện thoại của bạn đã dừng — nó chỉ tình cờ hiển thị đúng giờ. Bạn có JTB, nhưng bạn có *biết* giờ không?

Đây vẫn là một trong những vấn đề nghiên cứu tích cực nhất của triết học.

### Hai Nguồn Tri Thức

| | **Chủ nghĩa duy lý** | **Chủ nghĩa kinh nghiệm** |
|---|---|---|
| **Tuyên bố chính** | Lý trí là nguồn tri thức chính | Kinh nghiệm là nguồn tri thức chính |
| **Tri thức a priori** | Có — sự thật toán học, logic | Tối thiểu — chỉ sự thật phân tích tầm thường |
| **Nhà tư tưởng chính** | Descartes, Leibniz, Spinoza | Locke, Hume, Berkeley |
| **Tuyên bố nổi tiếng** | "Tôi suy nghĩ, vậy tôi tồn tại" (Descartes) | "Không có gì trong trí tuệ mà không trước tiên trong giác quan" (Locke) |

### Chủ Nghĩa Hoài Nghi

**Chủ nghĩa hoài nghi** là quan điểm cho rằng tri thức khó đạt được hoặc không thể. Descartes dùng chủ nghĩa hoài nghi cực đoan như một *phương pháp*: nếu một quỷ dữ lừa dối bạn về mọi thứ thì sao? Bạn có thể biết gì với sự chắc chắn tuyệt đối? Câu trả lời của ông: *Cogito ergo sum* — "Tôi suy nghĩ, vậy tôi tồn tại." Hành động nghi ngờ chứng minh sự tồn tại của người nghi ngờ.',
  1,
  '{}'
),
(
  (SELECT id FROM lesson WHERE slug = 'epistemology-basics'),
  'key_points',
  'Key Points',
  'Điểm Chính',
  '- **Epistemology** is the branch of philosophy that studies the nature, sources, and limits of knowledge
- Plato''s classical definition: knowledge = **Justified True Belief** (the belief is true, held, and justified)
- The **Gettier Problem** (1963) shows JTB is insufficient — you can meet all three conditions by lucky coincidence without truly knowing
- **Rationalism**: knowledge comes primarily from reason; key thinkers: Descartes, Leibniz, Spinoza
- **Empiricism**: all knowledge ultimately comes from sensory experience; key thinkers: Locke, Hume, Berkeley
- **"I think, therefore I am"** (Cogito ergo sum) is Descartes'' bedrock of certainty — the act of thinking proves existence
- **Skepticism** doubts whether reliable knowledge is possible; Descartes used it as a method to find indubitable truths
- **A priori** knowledge is independent of experience (math, logic); **a posteriori** requires experience (scientific facts)',
  '- **Nhận thức luận** là nhánh triết học nghiên cứu bản chất, nguồn gốc và giới hạn của tri thức
- Định nghĩa cổ điển của Plato: tri thức = **Niềm Tin Đúng Có Cơ Sở** (niềm tin đúng, được giữ và có cơ sở)
- **Vấn đề Gettier** (1963) cho thấy JTB không đủ — bạn có thể đáp ứng cả ba điều kiện bằng sự trùng hợp may mắn mà không thực sự biết
- **Chủ nghĩa duy lý**: tri thức đến chủ yếu từ lý trí; nhà tư tưởng chính: Descartes, Leibniz, Spinoza
- **Chủ nghĩa kinh nghiệm**: mọi tri thức cuối cùng đến từ kinh nghiệm giác quan; nhà tư tưởng chính: Locke, Hume, Berkeley
- **"Tôi suy nghĩ, vậy tôi tồn tại"** (Cogito ergo sum) là nền tảng chắc chắn của Descartes — hành động suy nghĩ chứng minh sự tồn tại
- **Chủ nghĩa hoài nghi** nghi ngờ liệu tri thức đáng tin cậy có thể có được; Descartes dùng nó như phương pháp để tìm sự thật không thể nghi ngờ
- Tri thức **a priori** độc lập với kinh nghiệm (toán học, logic); **a posteriori** cần kinh nghiệm (sự kiện khoa học)',
  2,
  '{}'
),
(
  (SELECT id FROM lesson WHERE slug = 'epistemology-basics'),
  'info_box',
  'Plato''s Definition of Knowledge',
  'Định Nghĩa Tri Thức Của Plato',
  '**Plato''s definition of knowledge as "justified true belief" has dominated Western philosophy for over 2,000 years** — and yet a 3-page paper published in 1963 showed it was fundamentally incomplete.

**The Gettier cases (simplified):**

Imagine you see what appears to be a sheep in a field. You form the justified belief "there is a sheep in that field." What you don''t know is: the thing you see is actually a large white rock shaped like a sheep. However, hidden behind a hill, there IS a real sheep in the field.

Your belief "there is a sheep in that field" is:
- ✓ **True** (there is a sheep — behind the hill)
- ✓ **Believed** (you believe it)
- ✓ **Justified** (the rock looked exactly like a sheep)

But do you really **know** there is a sheep? Most philosophers say no — your justified true belief is accidentally true.

**Why this matters:** Gettier cases forced philosophers to realize that knowledge requires something more than JTB — perhaps a fourth condition, or a completely different analysis. This question remains one of philosophy''s most active research problems, with no consensus solution after 60 years.',
  '**Định nghĩa tri thức của Plato là "niềm tin đúng có cơ sở" đã thống trị triết học phương Tây hơn 2.000 năm** — và tuy nhiên một bài báo 3 trang xuất bản năm 1963 đã cho thấy nó về cơ bản không đầy đủ.

**Các trường hợp Gettier (đơn giản hóa):**

Hãy tưởng tượng bạn thấy thứ trông như một con cừu trên đồng. Bạn hình thành niềm tin có cơ sở "có một con cừu trên đồng đó." Điều bạn không biết là: thứ bạn thấy thực ra là một tảng đá trắng lớn hình con cừu. Tuy nhiên, ẩn sau một ngọn đồi, CÓ một con cừu thật trên đồng.

Niềm tin của bạn "có một con cừu trên đồng đó" là:
- ✓ **Đúng** (có một con cừu — sau ngọn đồi)
- ✓ **Được tin** (bạn tin nó)
- ✓ **Có cơ sở** (tảng đá trông chính xác như con cừu)

Nhưng bạn có thực sự **biết** có con cừu không? Hầu hết các triết gia nói không — niềm tin đúng có cơ sở của bạn là đúng một cách tình cờ.

**Tại sao điều này quan trọng:** Các trường hợp Gettier buộc các triết gia nhận ra rằng tri thức đòi hỏi thứ gì đó nhiều hơn JTB — có thể là điều kiện thứ tư, hoặc phân tích hoàn toàn khác. Câu hỏi này vẫn là một trong những vấn đề nghiên cứu tích cực nhất của triết học, không có giải pháp đồng thuận sau 60 năm.',
  3,
  '{"variant": "tip"}'
);

-- Exercises
-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'epistemology-basics'),
  'fill_blank',
  'easy',
  'Fill in the missing word in Plato''s definition of knowledge.',
  'Điền từ còn thiếu trong định nghĩa tri thức của Plato.',
  'Plato defined knowledge as ___ true belief.',
  'Plato định nghĩa tri thức là niềm tin đúng ___.',
  'justified',
  'Plato''s Justified True Belief (JTB) theory requires three conditions: the belief must be (1) true — it corresponds to reality, (2) believed — the person actually holds it, and (3) justified — there are adequate reasons or evidence supporting it. The "justified" condition is what distinguishes knowledge from lucky guessing: if you happen to guess a correct answer without any reasoning, you have a true belief, but not knowledge.',
  'Lý thuyết Niềm Tin Đúng Có Cơ Sở (JTB) của Plato yêu cầu ba điều kiện: niềm tin phải (1) đúng — nó tương ứng với thực tế, (2) được tin — người đó thực sự giữ nó, và (3) có cơ sở — có lý do hoặc bằng chứng đầy đủ hỗ trợ nó. Điều kiện "có cơ sở" là điều phân biệt tri thức khỏi đoán may mắn: nếu bạn tình cờ đoán đúng câu trả lời mà không có lý luận, bạn có niềm tin đúng, nhưng không có tri thức.',
  10,
  1
);

-- Exercise 2: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'epistemology-basics'),
  'multiple_choice',
  'easy',
  'Which philosopher championed rationalism?',
  'Triết gia nào là nhà vô địch của chủ nghĩa duy lý?',
  'Rationalism holds that reason — not sensory experience — is the primary source of reliable knowledge.',
  'Chủ nghĩa duy lý cho rằng lý trí — không phải kinh nghiệm giác quan — là nguồn tri thức đáng tin cậy chính.',
  'René Descartes (1596-1650) is the quintessential rationalist. His famous *Meditations on First Philosophy* used methodological doubt — imagining an evil demon deceiving him about everything — to find one indubitable truth: *Cogito ergo sum* (I think, therefore I am). From this bedrock of pure reason, he tried to rebuild all knowledge. Descartes also argued that the existence of God and the external world could be proven by reason alone.',
  'René Descartes (1596-1650) là nhà duy lý điển hình. *Suy Tưởng Về Triết Học Đầu Tiên* nổi tiếng của ông sử dụng nghi ngờ có phương pháp — tưởng tượng một quỷ dữ lừa dối ông về mọi thứ — để tìm một sự thật không thể nghi ngờ: *Cogito ergo sum* (Tôi suy nghĩ, vậy tôi tồn tại). Từ nền tảng lý trí thuần túy này, ông cố gắng xây dựng lại mọi tri thức. Descartes cũng lập luận rằng sự tồn tại của Chúa và thế giới bên ngoài có thể được chứng minh chỉ bằng lý trí.',
  10,
  2
);
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, explanation, order_index) VALUES
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'epistemology-basics') AND order_index = 2),
  'A', 'John Locke', 'John Locke', FALSE,
  'John Locke was the quintessential empiricist — he argued the mind starts as a "blank slate" (tabula rasa) filled by experience',
  1
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'epistemology-basics') AND order_index = 2),
  'B', 'David Hume', 'David Hume', FALSE,
  'David Hume was a radical empiricist who argued even cause-and-effect is based on habit of experience, not reason',
  2
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'epistemology-basics') AND order_index = 2),
  'C', 'René Descartes', 'René Descartes', TRUE,
  'Correct! Descartes championed rationalism — his Cogito ("I think, therefore I am") exemplifies knowledge derived from pure reason',
  3
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'epistemology-basics') AND order_index = 2),
  'D', 'William James', 'William James', FALSE,
  'William James was a pragmatist — he judged ideas by their practical consequences, a different philosophical tradition',
  4
);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'epistemology-basics'),
  'true_false',
  'easy',
  'Is this statement about empiricism correct?',
  'Phát biểu này về chủ nghĩa kinh nghiệm có đúng không?',
  'Empiricism holds that all knowledge comes from sensory experience.',
  'Chủ nghĩa kinh nghiệm cho rằng mọi tri thức đến từ kinh nghiệm giác quan.',
  'true',
  'True! Empiricism (from Greek *empeiria* = experience) holds that all substantive knowledge ultimately derives from sensory experience (seeing, hearing, touching, tasting, smelling). John Locke (1632-1704) famously argued the human mind begins as a "blank slate" (tabula rasa) — all ideas come from experience. David Hume pushed this further, arguing even our idea of cause-and-effect is just a habit formed by observing events in sequence.',
  'Đúng! Chủ nghĩa kinh nghiệm (từ tiếng Hy Lạp *empeiria* = kinh nghiệm) cho rằng mọi tri thức thực chất cuối cùng đến từ kinh nghiệm giác quan (nhìn, nghe, chạm, nếm, ngửi). John Locke (1632-1704) nổi tiếng lập luận tâm trí con người bắt đầu như "tờ giấy trắng" (tabula rasa) — mọi ý tưởng đến từ kinh nghiệm. David Hume đẩy điều này xa hơn, lập luận ngay cả ý tưởng về nguyên nhân-kết quả của chúng ta chỉ là thói quen được hình thành bằng cách quan sát các sự kiện theo trình tự.',
  5,
  3
);

-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'epistemology-basics'),
  'fill_blank',
  'medium',
  'Fill in the philosophical position that doubts whether reliable knowledge is possible.',
  'Điền lập trường triết học nghi ngờ liệu tri thức đáng tin cậy có thể có được.',
  'The philosophical puzzle of whether we can trust our senses is called the problem of ___.',
  'Câu đố triết học về việc liệu chúng ta có thể tin vào giác quan của mình được gọi là vấn đề ___.',
  'skepticism',
  'Skepticism (from Greek *skeptikos* = reflective, inquiring) is the philosophical position that questions the possibility of certain knowledge. The problem of skepticism asks: can we trust our senses? Could we be dreaming? Could a powerful deceiver be manipulating our perceptions? Descartes used skepticism as a method — by doubting everything possible, he sought to find what could not be doubted. His answer was the Cogito: the act of doubting itself proves the doubter exists.',
  'Chủ nghĩa hoài nghi (từ tiếng Hy Lạp *skeptikos* = phản tư, tìm tòi) là lập trường triết học đặt câu hỏi về khả năng tri thức chắc chắn. Vấn đề hoài nghi hỏi: chúng ta có thể tin vào giác quan không? Chúng ta có thể đang mơ? Có thể một kẻ lừa đảo quyền năng đang thao túng nhận thức của chúng ta? Descartes dùng chủ nghĩa hoài nghi như phương pháp — bằng cách nghi ngờ mọi thứ có thể, ông tìm kiếm điều không thể nghi ngờ. Câu trả lời của ông là Cogito: chính hành động nghi ngờ chứng minh người nghi ngờ tồn tại.',
  10,
  4
);

-- Exercise 5: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'epistemology-basics'),
  'true_false',
  'easy',
  'Is this statement about Descartes correct?',
  'Phát biểu này về Descartes có đúng không?',
  '"I think, therefore I am" (Cogito ergo sum) was written by Descartes.',
  '"Tôi suy nghĩ, vậy tôi tồn tại" (Cogito ergo sum) được viết bởi Descartes.',
  'true',
  'True! René Descartes wrote *Cogito ergo sum* (I think, therefore I am) in his *Discourse on the Method* (1637) and elaborated on it in his *Meditations on First Philosophy* (1641). It is the most famous sentence in the history of philosophy. After doubting everything possible, Descartes found one thing he could not doubt: the very fact that he was doubting proved he existed as a thinking thing. This became the foundation of his entire philosophical system.',
  'Đúng! René Descartes đã viết *Cogito ergo sum* (Tôi suy nghĩ, vậy tôi tồn tại) trong *Discourse on the Method* (1637) và mở rộng nó trong *Meditations on First Philosophy* (1641). Đây là câu nổi tiếng nhất trong lịch sử triết học. Sau khi nghi ngờ mọi thứ có thể, Descartes tìm thấy một điều ông không thể nghi ngờ: chính thực tế là ông đang nghi ngờ đã chứng minh ông tồn tại như một thứ suy nghĩ. Điều này trở thành nền tảng của toàn bộ hệ thống triết học của ông.',
  5,
  5
);


-- ############################################################################
-- LESSON: POLITICAL PHILOSOPHY (slug = political-philosophy)
-- order_index = 4
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Political Philosophy',
  'Triết Học Chính Trị',
  'political-philosophy',
  'Examine social contract theory, justice, and the foundations of government',
  'Xem xét lý thuyết khế ước xã hội, công lý và nền tảng của chính quyền',
  'intermediate',
  40,
  4
FROM category WHERE name = 'Philosophy';

-- Usages
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'political-philosophy'),
  'Social Contract',
  'Khế Ước Xã Hội',
  'Social contract theory holds that political authority derives from an agreement (implicit or explicit) among individuals who give up some natural freedoms in exchange for the security and benefits of organized society. Different thinkers imagined different "states of nature" before government — and reached different conclusions about what the social contract requires.',
  'Lý thuyết khế ước xã hội cho rằng thẩm quyền chính trị bắt nguồn từ một thỏa thuận (ngầm định hoặc rõ ràng) giữa các cá nhân từ bỏ một số tự do tự nhiên để đổi lấy sự bảo vệ và lợi ích của xã hội có tổ chức. Các nhà tư tưởng khác nhau tưởng tượng các "trạng thái tự nhiên" khác nhau trước chính quyền — và đạt được kết luận khác nhau về những gì khế ước xã hội yêu cầu.',
  'Handshake',
  TRUE,
  1
),
(
  (SELECT id FROM lesson WHERE slug = 'political-philosophy'),
  'Justice and Rights',
  'Công Lý và Quyền',
  'What is justice, and what rights do individuals possess? John Rawls proposed the "veil of ignorance" thought experiment: design a society without knowing your position in it. This ensures principles chosen will be fair to all, since you might end up at the bottom. Robert Nozick countered with the "minimal state": individual rights are paramount and redistribution violates property rights.',
  'Công lý là gì, và cá nhân có những quyền gì? John Rawls đề xuất thí nghiệm tư duy "bức màn vô tri": thiết kế xã hội mà không biết vị trí của bạn trong đó. Điều này đảm bảo các nguyên tắc được chọn sẽ công bằng với tất cả, vì bạn có thể kết thúc ở dưới cùng. Robert Nozick phản bác bằng "nhà nước tối thiểu": quyền cá nhân là tối thượng và phân phối lại vi phạm quyền sở hữu.',
  'Balance',
  TRUE,
  2
);

-- Sections
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'political-philosophy'),
  'markdown',
  'The Foundations of Political Authority',
  'Nền Tảng Của Thẩm Quyền Chính Trị',
  '## Political Philosophy: Authority, Justice, and Rights

**Political philosophy** asks foundational questions about government and society: *Why should we obey laws? What justifies political authority? What is a just society? What rights do we have?*

### The State of Nature and Social Contract

The social contract theorists imagined what life would be like **without** government — the "state of nature" — and asked what rational beings would agree to in order to escape it.

| Thinker | State of Nature | Social Contract | Government Type |
|---------|----------------|-----------------|-----------------|
| **Thomas Hobbes** (1651) | "Solitary, poor, nasty, brutish, and short" | Total surrender of rights | Absolute Sovereign (Leviathan) |
| **John Locke** (1689) | Generally peaceful, but rights not secure | Surrender *some* rights | Limited government protecting life, liberty, property |
| **Jean-Jacques Rousseau** (1762) | "Noble savage" — naturally good | General Will | Democratic republic |

### Locke''s Influence on Modern Democracy

Locke''s *Second Treatise of Government* (1689) argued:
1. People have **natural rights** to life, liberty, and property
2. Government exists to protect those rights
3. If government fails, the people have the right to **revolt**

This directly influenced the US Declaration of Independence ("life, liberty, and the pursuit of happiness") and the French Declaration of the Rights of Man.

### Rawls and the Veil of Ignorance

John Rawls (*A Theory of Justice*, 1971) proposed a thought experiment to determine principles of justice:

> *Imagine you are designing a society, but you do not know what position you will occupy — you might be rich or poor, talented or disadvantaged, any race or gender. What principles would you choose?*

Rawls argued rational people would choose:
1. **Equal basic liberties** for everyone
2. **Difference principle**: inequalities are only justified if they benefit the least advantaged members of society',
  '## Triết Học Chính Trị: Thẩm Quyền, Công Lý và Quyền

**Triết học chính trị** đặt ra những câu hỏi nền tảng về chính quyền và xã hội: *Tại sao chúng ta phải tuân theo luật pháp? Điều gì biện minh cho thẩm quyền chính trị? Một xã hội công bằng là gì? Chúng ta có những quyền gì?*

### Trạng Thái Tự Nhiên và Khế Ước Xã Hội

Các nhà lý thuyết khế ước xã hội tưởng tượng cuộc sống sẽ như thế nào **không có** chính quyền — "trạng thái tự nhiên" — và hỏi những con người lý trí sẽ đồng ý điều gì để thoát khỏi nó.

| Nhà tư tưởng | Trạng thái tự nhiên | Khế ước xã hội | Loại chính quyền |
|-------------|---------------------|----------------|------------------|
| **Thomas Hobbes** (1651) | "Cô đơn, nghèo nàn, khó chịu, tàn nhẫn và ngắn ngủi" | Từ bỏ toàn bộ quyền | Chủ quyền tuyệt đối (Leviathan) |
| **John Locke** (1689) | Thường hòa bình, nhưng quyền không được bảo đảm | Từ bỏ *một số* quyền | Chính quyền giới hạn bảo vệ sự sống, tự do, tài sản |
| **Jean-Jacques Rousseau** (1762) | "Noble savage" — tự nhiên tốt | Ý chí chung | Cộng hòa dân chủ |

### Ảnh Hưởng Của Locke Đến Nền Dân Chủ Hiện Đại

*Second Treatise of Government* (1689) của Locke lập luận:
1. Con người có **quyền tự nhiên** về sự sống, tự do và tài sản
2. Chính quyền tồn tại để bảo vệ những quyền đó
3. Nếu chính quyền thất bại, người dân có quyền **nổi dậy**

Điều này trực tiếp ảnh hưởng đến Tuyên Ngôn Độc Lập Mỹ ("sự sống, tự do và quyền mưu cầu hạnh phúc") và Tuyên Ngôn Quyền Con Người của Pháp.

### Rawls và Bức Màn Vô Tri

John Rawls (*A Theory of Justice*, 1971) đề xuất thí nghiệm tư duy để xác định nguyên tắc công lý:

> *Hãy tưởng tượng bạn đang thiết kế xã hội, nhưng bạn không biết vị trí mình sẽ chiếm — bạn có thể giàu hoặc nghèo, tài năng hoặc thiếu thốn, bất kỳ chủng tộc hoặc giới tính nào. Bạn sẽ chọn nguyên tắc nào?*

Rawls lập luận những người có lý trí sẽ chọn:
1. **Quyền tự do cơ bản bình đẳng** cho tất cả mọi người
2. **Nguyên tắc khác biệt**: bất bình đẳng chỉ được biện minh nếu chúng có lợi cho những thành viên ít được ưu ái nhất trong xã hội',
  1,
  '{}'
),
(
  (SELECT id FROM lesson WHERE slug = 'political-philosophy'),
  'key_points',
  'Key Points',
  'Điểm Chính',
  '- **Political philosophy** asks: why should we obey laws, what justifies authority, and what makes a society just?
- **Social contract theory** holds that political authority derives from an agreement among individuals
- **Hobbes**: state of nature is war of all against all → needs absolute sovereign to impose order (Leviathan)
- **Locke**: government derives legitimacy from the **consent of the governed** and must protect life, liberty, and property
- **Rousseau**: the **general will** of the people should govern — individuals surrender private interests for the common good
- **Rawls''s veil of ignorance**: design society without knowing your position — leads to fairness as justice
- **Rawls''s difference principle**: inequalities only justified if they benefit the least advantaged
- **Anarchism** advocates the abolition of all coercive forms of government — individuals are capable of self-governance',
  '- **Triết học chính trị** hỏi: tại sao chúng ta phải tuân theo luật pháp, điều gì biện minh cho thẩm quyền, và điều gì tạo nên xã hội công bằng?
- **Lý thuyết khế ước xã hội** cho rằng thẩm quyền chính trị bắt nguồn từ thỏa thuận giữa các cá nhân
- **Hobbes**: trạng thái tự nhiên là chiến tranh tất cả chống tất cả → cần chủ quyền tuyệt đối để áp đặt trật tự (Leviathan)
- **Locke**: chính quyền nhận tính hợp pháp từ **sự đồng ý của người bị cai trị** và phải bảo vệ sự sống, tự do và tài sản
- **Rousseau**: **ý chí chung** của nhân dân nên cai trị — các cá nhân từ bỏ lợi ích tư nhân vì lợi ích chung
- **Bức màn vô tri của Rawls**: thiết kế xã hội mà không biết vị trí của bạn — dẫn đến công bằng như công lý
- **Nguyên tắc khác biệt của Rawls**: bất bình đẳng chỉ được biện minh nếu chúng có lợi cho người ít được ưu ái nhất
- **Chủ nghĩa vô chính phủ** ủng hộ bãi bỏ mọi hình thức chính quyền cưỡng ép — các cá nhân có khả năng tự quản',
  2,
  '{}'
),
(
  (SELECT id FROM lesson WHERE slug = 'political-philosophy'),
  'diagram',
  'Social Contract Theories Compared',
  'So Sánh Các Lý Thuyết Khế Ước Xã Hội',
  'This diagram shows how the three major social contract theorists each begin from a "state of nature" and arrive at different conclusions about the ideal form of government.',
  'Sơ đồ này cho thấy cách ba nhà lý thuyết khế ước xã hội lớn mỗi người bắt đầu từ "trạng thái tự nhiên" và đạt đến kết luận khác nhau về hình thức chính quyền lý tưởng.',
  3,
  '{"code": "graph TD\n    A[State of Nature] --> B[Social Contract]\n    B --> C[Government]\n    C --> D{Type}\n    D --> E[Hobbes: Absolute Sovereign]\n    D --> F[Locke: Limited Government]\n    D --> G[Rousseau: General Will]"}'
);

-- Exercises
-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'political-philosophy'),
  'fill_blank',
  'easy',
  'Fill in the missing word from Hobbes''s famous description of life without government.',
  'Điền từ còn thiếu từ mô tả nổi tiếng của Hobbes về cuộc sống không có chính quyền.',
  'Hobbes described life in the state of nature as ''solitary, poor, nasty, brutish, and ___''.',
  'Hobbes mô tả cuộc sống trong trạng thái tự nhiên là ''cô đơn, nghèo nàn, khó chịu, tàn nhẫn và ___''.',
  'short',
  'Thomas Hobbes wrote this famous description in *Leviathan* (1651). Without government, he argued, life in the "state of nature" would be a constant "war of every man against every man." The full phrase — "solitary, poor, nasty, brutish, and short" — captures Hobbes''s bleak view of human nature without social order. This justified his conclusion that people should surrender all their natural rights to an absolute sovereign who would impose peace and order.',
  'Thomas Hobbes đã viết mô tả nổi tiếng này trong *Leviathan* (1651). Không có chính quyền, ông lập luận, cuộc sống trong "trạng thái tự nhiên" sẽ là một "cuộc chiến của mọi người chống lại mọi người" liên tục. Cụm từ đầy đủ — "cô đơn, nghèo nàn, khó chịu, tàn nhẫn và ngắn ngủi" — nắm bắt quan điểm ảm đạm của Hobbes về bản chất con người không có trật tự xã hội. Điều này biện minh cho kết luận của ông rằng người dân nên từ bỏ tất cả quyền tự nhiên của họ cho một chủ quyền tuyệt đối áp đặt hòa bình và trật tự.',
  10,
  1
);

-- Exercise 2: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'political-philosophy'),
  'multiple_choice',
  'easy',
  'Who argued that governments derive their legitimacy from the consent of the governed?',
  'Ai lập luận rằng chính quyền nhận tính hợp pháp từ sự đồng ý của người bị cai trị?',
  'This philosopher''s ideas directly influenced the American Declaration of Independence and modern liberal democracy.',
  'Ý tưởng của triết gia này đã trực tiếp ảnh hưởng đến Tuyên Ngôn Độc Lập Mỹ và nền dân chủ tự do hiện đại.',
  'John Locke (1632-1704) argued in his *Second Treatise of Government* (1689) that governments derive their just powers from the consent of the governed. When a government violates the natural rights of its citizens (to life, liberty, and property), the people have the right to dissolve it and form a new one. This idea was so influential that Thomas Jefferson paraphrased it almost word-for-word in the Declaration of Independence (1776).',
  'John Locke (1632-1704) lập luận trong *Second Treatise of Government* (1689) rằng chính quyền nhận quyền lực chính đáng từ sự đồng ý của người bị cai trị. Khi chính quyền vi phạm quyền tự nhiên của công dân (về sự sống, tự do và tài sản), người dân có quyền giải tán nó và thành lập một chính quyền mới. Ý tưởng này có ảnh hưởng đến mức Thomas Jefferson đã diễn đạt lại gần như từng chữ trong Tuyên Ngôn Độc Lập (1776).',
  10,
  2
);
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, explanation, order_index) VALUES
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'political-philosophy') AND order_index = 2),
  'A', 'Hobbes', 'Hobbes', FALSE,
  'Hobbes argued for absolute sovereign power — the opposite of government by consent',
  1
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'political-philosophy') AND order_index = 2),
  'B', 'Plato', 'Plato', FALSE,
  'Plato advocated for philosopher-kings ruling an ideal republic — not democratic consent',
  2
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'political-philosophy') AND order_index = 2),
  'C', 'Locke', 'Locke', TRUE,
  'Correct! Locke''s consent-of-the-governed principle directly influenced the American Declaration of Independence',
  3
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'political-philosophy') AND order_index = 2),
  'D', 'Nietzsche', 'Nietzsche', FALSE,
  'Nietzsche was a 19th century philosopher who focused on power, will, and the "will to power" — not social contract theory',
  4
);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'political-philosophy'),
  'true_false',
  'easy',
  'Is this statement about social contract theory correct?',
  'Phát biểu này về lý thuyết khế ước xã hội có đúng không?',
  'The social contract theory suggests people give up some freedoms in exchange for protection and order.',
  'Lý thuyết khế ước xã hội gợi ý rằng người dân từ bỏ một số tự do để đổi lấy sự bảo vệ và trật tự.',
  'true',
  'True! Social contract theory holds that political authority and the obligation to obey laws arise from an agreement — people trade some natural freedoms for the security and benefits that organized government provides. The extent of this trade-off varies by thinker: Hobbes wanted to give up almost everything to an absolute sovereign; Locke wanted to surrender only the right to personally enforce natural rights; Rousseau wanted individuals to merge their private will into the "general will."',
  'Đúng! Lý thuyết khế ước xã hội cho rằng thẩm quyền chính trị và nghĩa vụ tuân thủ luật pháp phát sinh từ một thỏa thuận — con người đánh đổi một số tự do tự nhiên để lấy sự bảo vệ và lợi ích mà chính quyền có tổ chức cung cấp. Mức độ đánh đổi này khác nhau theo nhà tư tưởng: Hobbes muốn từ bỏ gần như mọi thứ cho chủ quyền tuyệt đối; Locke muốn chỉ từ bỏ quyền tự cưỡng chế quyền tự nhiên; Rousseau muốn các cá nhân hợp nhất ý chí tư nhân vào "ý chí chung."',
  5,
  3
);

-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'political-philosophy'),
  'fill_blank',
  'medium',
  'Fill in the missing word from Rawls''s famous thought experiment.',
  'Điền từ còn thiếu từ thí nghiệm tư duy nổi tiếng của Rawls.',
  'John Rawls proposed the "veil of ___" thought experiment to design a fair society.',
  'John Rawls đề xuất thí nghiệm tư duy "bức màn ___" để thiết kế một xã hội công bằng.',
  'ignorance',
  'The "veil of ignorance" (from Rawls''s *A Theory of Justice*, 1971) is a thought experiment: imagine you must choose the fundamental principles of your society, but you are behind a "veil" that prevents you from knowing your place in it — your wealth, talent, gender, race, or generation. Rawls argued that rational people designing society under this veil would choose fair principles, because they would not want to risk ending up in the worst position. This yields his two principles of justice: equal basic liberties and the difference principle.',
  '"Bức màn vô tri" (từ *A Theory of Justice* của Rawls, 1971) là một thí nghiệm tư duy: hãy tưởng tượng bạn phải chọn các nguyên tắc nền tảng của xã hội, nhưng bạn ở sau "bức màn" ngăn bạn biết vị trí của mình trong đó — tài sản, tài năng, giới tính, chủng tộc hoặc thế hệ. Rawls lập luận rằng những người có lý trí thiết kế xã hội đằng sau bức màn này sẽ chọn các nguyên tắc công bằng, vì họ không muốn mạo hiểm kết thúc ở vị trí tệ nhất. Điều này dẫn đến hai nguyên tắc công lý của ông: quyền tự do cơ bản bình đẳng và nguyên tắc khác biệt.',
  10,
  4
);

-- Exercise 5: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'political-philosophy'),
  'true_false',
  'easy',
  'Is this statement about anarchism correct?',
  'Phát biểu này về chủ nghĩa vô chính phủ có đúng không?',
  'Anarchism advocates for the abolition of all forms of government.',
  'Chủ nghĩa vô chính phủ ủng hộ việc bãi bỏ mọi hình thức chính quyền.',
  'true',
  'True! Anarchism (from Greek *an* = without, *arche* = ruler) advocates for a society without coercive authority structures — no state, no government, no hierarchy imposed by force. Major anarchist thinkers include Pierre-Joseph Proudhon (who declared "property is theft"), Mikhail Bakunin, and Peter Kropotkin. Importantly, anarchism is NOT chaos — most anarchists propose voluntary cooperation, mutual aid, and self-governing communities as alternatives to state authority.',
  'Đúng! Chủ nghĩa vô chính phủ (từ tiếng Hy Lạp *an* = không có, *arche* = người cai trị) ủng hộ một xã hội không có cấu trúc thẩm quyền cưỡng ép — không nhà nước, không chính quyền, không phân cấp áp đặt bằng vũ lực. Các nhà tư tưởng vô chính phủ lớn bao gồm Pierre-Joseph Proudhon (người tuyên bố "tài sản là ăn trộm"), Mikhail Bakunin và Peter Kropotkin. Quan trọng là, chủ nghĩa vô chính phủ KHÔNG phải là hỗn loạn — hầu hết những người vô chính phủ đề xuất hợp tác tự nguyện, tương trợ và cộng đồng tự quản là sự thay thế cho thẩm quyền nhà nước.',
  5,
  5
);


-- ============================================================================
-- VERIFICATION QUERY
-- ============================================================================

SELECT l.id, l.name, l.slug,
  (SELECT COUNT(*) FROM lesson_usage WHERE lesson_id = l.id) AS usages,
  (SELECT COUNT(*) FROM lesson_section WHERE lesson_id = l.id) AS sections,
  (SELECT COUNT(*) FROM exercise WHERE lesson_id = l.id) AS exercises
FROM lesson l
WHERE l.group_id = (SELECT id FROM category WHERE name = 'Philosophy')
ORDER BY l.order_index;
