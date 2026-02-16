-- ============================================================================
-- SEED DATA: Psychology 101 (4 lessons)
-- Category: Psychology 101 (ID 8)
-- Lessons: IDs 28-31
-- Compatible with: schema.sql v7
-- ============================================================================


-- ============================================================================
-- CATEGORY 8: Psychology 101
-- ============================================================================

INSERT INTO category (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('Psychology 101', 'Tâm Lý Học 101', 'Explore the fundamentals of human psychology: memory, cognitive biases, motivation, and emotional intelligence', 'Khám phá nền tảng tâm lý học con người: trí nhớ, thiên kiến nhận thức, động lực và trí tuệ cảm xúc', 'Psychology', '#8b5cf6', 8);


-- ############################################################################
-- LESSON 28: MEMORY & LEARNING (lesson_id = 28)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(8, 'Memory & Learning', 'Trí Nhớ & Học Tập', 'psych-memory', 'Understand how memory works: encoding, storage, retrieval, and spaced repetition', 'Hiểu cách trí nhớ hoạt động: mã hóa, lưu trữ, truy xuất và ôn tập giãn cách', 'beginner', 25, 1);

-- Usages (IDs 84-86)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(28, 'Short-term vs long-term memory', 'Trí nhớ ngắn hạn và dài hạn', 'Short-term memory holds about 7 items for 20-30 seconds. Long-term memory can store unlimited information for years.', 'Trí nhớ ngắn hạn chứa khoảng 7 mục trong 20-30 giây. Trí nhớ dài hạn có thể lưu trữ thông tin không giới hạn trong nhiều năm.', 'Psychology', TRUE, 1),
(28, 'Encoding and consolidation', 'Mã hóa và củng cố', 'Encoding transforms sensory input into memory traces. Consolidation strengthens these traces during sleep and rest.', 'Mã hóa chuyển đổi thông tin giác quan thành dấu vết trí nhớ. Củng cố tăng cường các dấu vết này trong khi ngủ và nghỉ ngơi.', 'Lightbulb', TRUE, 2),
(28, 'Retrieval and spaced repetition', 'Truy xuất và ôn tập giãn cách', 'Actively recalling information strengthens memory pathways. Spacing reviews over time is more effective than cramming.', 'Chủ động nhớ lại thông tin tăng cường đường dẫn trí nhớ. Giãn cách ôn tập theo thời gian hiệu quả hơn học nhồi nhét.', 'School', TRUE, 3);

-- Examples for usage 84 (IDs 163-164)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(84, 'You can remember a phone number long enough to dial it, but forget it minutes later — that is short-term memory in action.', 'Bạn có thể nhớ số điện thoại đủ lâu để gọi, nhưng quên nó vài phút sau — đó là trí nhớ ngắn hạn hoạt động.', 'George Miller (1956) found that short-term memory holds about 7 plus or minus 2 items — known as Miller''s Law.', 'George Miller (1956) phát hiện trí nhớ ngắn hạn chứa khoảng 7 cộng trừ 2 mục — gọi là Định luật Miller.', 'short-term memory', 1),
(84, 'You can still recall your childhood address decades later because it was transferred to long-term memory through repeated use.', 'Bạn vẫn nhớ địa chỉ thời thơ ấu sau nhiều thập kỷ vì nó đã được chuyển vào trí nhớ dài hạn qua sử dụng lặp lại.', 'Long-term memory has virtually unlimited capacity and can last a lifetime, unlike short-term memory which fades quickly.', 'Trí nhớ dài hạn có dung lượng gần như không giới hạn và có thể kéo dài cả đời, không như trí nhớ ngắn hạn phai nhạt nhanh.', 'long-term memory', 2);

-- Examples for usage 85 (IDs 165-166)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(85, 'Creating a vivid mental image of a new vocabulary word helps encode it more deeply than simply reading it.', 'Tạo hình ảnh tinh thần sống động về từ vựng mới giúp mã hóa sâu hơn so với chỉ đọc nó.', 'Dual coding theory (Paivio, 1971) shows that combining verbal and visual encoding creates stronger memories.', 'Lý thuyết mã hóa kép (Paivio, 1971) cho thấy kết hợp mã hóa bằng lời và hình ảnh tạo trí nhớ mạnh hơn.', 'encoding', 1),
(85, 'Students who get a good night''s sleep after studying remember more than those who stay up all night cramming.', 'Học sinh ngủ đủ giấc sau khi học nhớ nhiều hơn những người thức cả đêm nhồi nhét.', 'During sleep, the brain replays and consolidates new memories, moving them from the hippocampus to the neocortex.', 'Trong khi ngủ, não phát lại và củng cố ký ức mới, chuyển chúng từ hồi hải mã sang vỏ não mới.', 'consolidation', 2);

-- Examples for usage 86 (IDs 167-168)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(86, 'Testing yourself on material is more effective than re-reading it — this is called the testing effect.', 'Tự kiểm tra bản thân về tài liệu hiệu quả hơn đọc lại — đây gọi là hiệu ứng kiểm tra.', 'Roediger & Karpicke (2006) demonstrated that retrieval practice produces better long-term retention than repeated studying.', 'Roediger & Karpicke (2006) chứng minh rằng thực hành truy xuất tạo ra khả năng ghi nhớ dài hạn tốt hơn học lặp lại.', 'testing effect', 1),
(86, 'Reviewing notes 1 day, 3 days, 7 days, and 14 days after learning follows the spaced repetition principle.', 'Ôn tập ghi chú sau 1 ngày, 3 ngày, 7 ngày và 14 ngày sau khi học tuân theo nguyên tắc ôn tập giãn cách.', 'Ebbinghaus (1885) discovered the forgetting curve: memory decays exponentially without review, but each review flattens the curve.', 'Ebbinghaus (1885) phát hiện đường cong quên: trí nhớ suy giảm theo hàm mũ nếu không ôn, nhưng mỗi lần ôn làm phẳng đường cong.', 'spaced repetition', 2);

-- Tips (IDs 83-85)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(28, 'Use active recall, not passive review', 'Dùng nhớ lại chủ động, không ôn tập thụ động', 'Close your notes and try to recall the material from memory. This struggle to remember is what strengthens neural pathways. Re-reading feels easy but produces weak memories — active recall feels harder but works much better.', 'Đóng ghi chú lại và cố gắng nhớ lại tài liệu từ trí nhớ. Sự nỗ lực nhớ lại chính là điều tăng cường đường dẫn thần kinh. Đọc lại cảm thấy dễ nhưng tạo ký ức yếu — nhớ lại chủ động khó hơn nhưng hiệu quả hơn nhiều.', 'general', 'high', 'Lightbulb', 1),
(28, 'Do not cram — space it out', 'Đừng nhồi nhét — hãy giãn cách', 'Cramming the night before an exam creates fragile short-term memories that fade quickly. Instead, study the same material in shorter sessions spread over several days. This takes the same total time but produces dramatically better retention.', 'Nhồi nhét trước đêm thi tạo ký ức ngắn hạn mong manh phai nhạt nhanh. Thay vào đó, học cùng tài liệu trong các buổi ngắn hơn trải đều nhiều ngày. Tổng thời gian bằng nhau nhưng khả năng ghi nhớ tốt hơn đáng kể.', 'common_mistake', 'high', 'Warning', 2),
(28, 'Sleep is a memory superpower', 'Giấc ngủ là siêu năng lực trí nhớ', 'Study the hardest material right before bed. During sleep, your brain actively consolidates new memories. Research shows that sleeping after learning improves recall by 20-40% compared to staying awake for the same period.', 'Học tài liệu khó nhất ngay trước khi ngủ. Khi ngủ, não bạn chủ động củng cố ký ức mới. Nghiên cứu cho thấy ngủ sau khi học cải thiện khả năng nhớ lại 20-40% so với thức cùng khoảng thời gian đó.', 'shortcut', 'medium', 'AutoAwesome', 3);

-- Sections (IDs 46-48)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(28, 'markdown', 'How Memory Works', 'Trí Nhớ Hoạt Động Như Thế Nào',
'## The Three Stages of Memory

Memory is not a single system — it involves **three key processes**:

### 1. Encoding
Converting sensory information into a form the brain can store. The deeper you process information, the better you remember it.

- **Shallow processing:** Reading words without thinking about meaning
- **Deep processing:** Connecting new information to what you already know

### 2. Storage
Information moves through stages:

| Stage | Capacity | Duration | Example |
|-------|----------|----------|---------|
| Sensory | Large | < 1 second | Seeing a flash of lightning |
| Short-term | ~7 items | 20-30 sec | Remembering a phone number |
| Long-term | Unlimited | Years to lifetime | Your childhood memories |

### 3. Retrieval
Accessing stored memories when needed. **The act of retrieving a memory actually strengthens it** — this is why self-testing works better than re-reading.

> **The Ebbinghaus Forgetting Curve (1885):** Without review, we forget ~50% within an hour, ~70% within 24 hours. Spaced repetition combats this by reviewing at optimal intervals.',
'## Ba Giai Đoạn Của Trí Nhớ

Trí nhớ không phải một hệ thống đơn lẻ — nó gồm **ba quá trình chính**:

### 1. Mã hóa
Chuyển đổi thông tin giác quan thành dạng não có thể lưu trữ. Bạn xử lý thông tin càng sâu, bạn nhớ càng tốt.

- **Xử lý nông:** Đọc từ mà không suy nghĩ về ý nghĩa
- **Xử lý sâu:** Kết nối thông tin mới với những gì bạn đã biết

### 2. Lưu trữ
Thông tin di chuyển qua các giai đoạn:

| Giai đoạn | Dung lượng | Thời gian | Ví dụ |
|-----------|------------|-----------|-------|
| Giác quan | Lớn | < 1 giây | Nhìn thấy tia chớp |
| Ngắn hạn | ~7 mục | 20-30 giây | Nhớ số điện thoại |
| Dài hạn | Không giới hạn | Nhiều năm đến cả đời | Ký ức tuổi thơ |

### 3. Truy xuất
Truy cập ký ức đã lưu khi cần. **Hành động truy xuất ký ức thực sự tăng cường nó** — đây là lý do tự kiểm tra hiệu quả hơn đọc lại.

> **Đường cong quên Ebbinghaus (1885):** Không ôn tập, ta quên ~50% trong vòng 1 giờ, ~70% trong 24 giờ. Ôn tập giãn cách chống lại điều này bằng cách ôn ở khoảng cách tối ưu.', 1, '{}'),

(28, 'key_points', 'Key Points', 'Điểm chính',
'- Memory has **3 stages**: encoding (input), storage (saving), retrieval (recall)
- **Short-term memory** holds ~7 items for 20-30 seconds (Miller''s Law, 1956)
- **Long-term memory** has unlimited capacity and can last a lifetime
- The **Ebbinghaus forgetting curve** shows we forget ~70% within 24 hours without review
- **Active recall** (self-testing) strengthens memory far more than passive re-reading
- **Spaced repetition** — reviewing at increasing intervals — is the most effective study technique',
'- Trí nhớ có **3 giai đoạn**: mã hóa (đầu vào), lưu trữ (lưu), truy xuất (nhớ lại)
- **Trí nhớ ngắn hạn** chứa ~7 mục trong 20-30 giây (Định luật Miller, 1956)
- **Trí nhớ dài hạn** có dung lượng không giới hạn và có thể kéo dài cả đời
- **Đường cong quên Ebbinghaus** cho thấy ta quên ~70% trong 24 giờ nếu không ôn
- **Nhớ lại chủ động** (tự kiểm tra) tăng cường trí nhớ hơn nhiều so với đọc lại thụ động
- **Ôn tập giãn cách** — ôn ở khoảng cách tăng dần — là kỹ thuật học hiệu quả nhất', 2, '{}'),

(28, 'info_box', 'The Testing Effect', 'Hiệu Ứng Kiểm Tra',
'**Surprising finding:** Testing yourself on material is one of the most powerful learning strategies — even more effective than additional study time.

Roediger & Karpicke (2006) found that students who studied once then took a practice test **remembered 50% more** after one week than students who studied the material four times.

**Why it works:**
- Retrieval strengthens the neural pathways to that memory
- It reveals gaps in your knowledge early
- It mimics the actual conditions of using that knowledge

**Apply it now:** After reading this lesson, close it and try to list the three stages of memory from recall!',
'**Phát hiện bất ngờ:** Tự kiểm tra bản thân về tài liệu là một trong những chiến lược học tập mạnh nhất — thậm chí hiệu quả hơn thời gian học thêm.

Roediger & Karpicke (2006) phát hiện học sinh học một lần rồi làm bài kiểm tra thực hành **nhớ nhiều hơn 50%** sau một tuần so với học sinh học tài liệu bốn lần.

**Tại sao hiệu quả:**
- Truy xuất tăng cường đường dẫn thần kinh đến ký ức đó
- Nó phát hiện lỗ hổng kiến thức sớm
- Nó mô phỏng điều kiện thực tế sử dụng kiến thức

**Áp dụng ngay:** Sau khi đọc bài này, đóng lại và thử liệt kê ba giai đoạn của trí nhớ từ trí nhớ!', 3, '{"variant": "tip"}');

-- Chart section: Ebbinghaus forgetting curve (order_index 4)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(28, 'chart', 'The Forgetting Curve', 'Đường cong quên lãng',
'The **Ebbinghaus forgetting curve** (1885) shows how memory fades without review. The blue line shows natural forgetting; the green line shows how **spaced repetition** maintains retention above 80% by reviewing at increasing intervals.',
'**Đường cong quên lãng Ebbinghaus** (1885) cho thấy trí nhớ phai nhạt khi không ôn tập. Đường xanh dương thể hiện quên tự nhiên; đường xanh lá cho thấy **ôn tập giãn cách** duy trì trí nhớ trên 80% bằng cách ôn ở khoảng cách tăng dần.', 4,
'{"chartType": "line", "xKey": "time", "series": [{"dataKey": "noReview", "name": "Without review"}, {"dataKey": "spacedRepetition", "name": "Spaced repetition"}], "data": [{"time": "0h", "noReview": 100, "spacedRepetition": 100}, {"time": "1h", "noReview": 58, "spacedRepetition": 95}, {"time": "1d", "noReview": 33, "spacedRepetition": 80}, {"time": "3d", "noReview": 28, "spacedRepetition": 75}, {"time": "7d", "noReview": 25, "spacedRepetition": 85}, {"time": "30d", "noReview": 21, "spacedRepetition": 90}]}');

-- Exercise 190: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(28, 'multiple_choice', 'easy', 'How many items can short-term memory typically hold at once?', 'Trí nhớ ngắn hạn thường có thể chứa bao nhiêu mục cùng lúc?', 'According to Miller''s Law (1956), the capacity of short-term memory is:', 'Theo Định luật Miller (1956), dung lượng trí nhớ ngắn hạn là:', 'George Miller''s classic 1956 paper found that short-term memory capacity is approximately 7 plus or minus 2 items (5-9 items). This is one of the most cited findings in cognitive psychology.', 'Bài báo kinh điển năm 1956 của George Miller phát hiện dung lượng trí nhớ ngắn hạn khoảng 7 cộng trừ 2 mục (5-9 mục). Đây là một trong những phát hiện được trích dẫn nhiều nhất trong tâm lý học nhận thức.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(190, 'A', '3 plus or minus 1', FALSE, 'This is too low — the actual capacity is about 7 items', 1),
(190, 'B', '7 plus or minus 2', TRUE, 'Correct! Miller''s Law states short-term memory holds approximately 5-9 items', 2),
(190, 'C', '12 plus or minus 3', FALSE, 'This overestimates short-term memory capacity significantly', 3),
(190, 'D', 'Unlimited items', FALSE, 'That describes long-term memory — short-term memory is very limited', 4);

-- Exercise 191: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(28, 'fill_blank', 'medium', 'Fill in the name of the famous memory research phenomenon.', 'Điền tên hiện tượng nghiên cứu trí nhớ nổi tiếng.', 'The ___ curve, discovered by Hermann Ebbinghaus in 1885, shows that memory decays exponentially without review.', 'Đường cong ___, được phát hiện bởi Hermann Ebbinghaus năm 1885, cho thấy trí nhớ suy giảm theo hàm mũ nếu không ôn tập.', 'forgetting', 'The Ebbinghaus forgetting curve demonstrates that without reinforcement, we forget approximately 50% within an hour and 70% within 24 hours.', 'Đường cong quên Ebbinghaus chứng minh rằng không có củng cố, chúng ta quên khoảng 50% trong vòng 1 giờ và 70% trong 24 giờ.', 15, 2);

-- Exercise 192: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(28, 'error_correction', 'medium', 'Fix the incorrect statement about memory.', 'Sửa phát biểu sai về trí nhớ.', 'Re-reading notes multiple times is the most effective way to strengthen long-term memory.', 'Đọc lại ghi chú nhiều lần là cách hiệu quả nhất để tăng cường trí nhớ dài hạn.', 'Actively recalling information from memory is the most effective way to strengthen long-term memory.', 'Re-reading is a passive strategy that feels effective but produces weak memory traces. Active recall — testing yourself without looking at notes — forces your brain to strengthen retrieval pathways, which is far more effective for long-term retention.', 'Đọc lại là chiến lược thụ động có cảm giác hiệu quả nhưng tạo dấu vết trí nhớ yếu. Nhớ lại chủ động — tự kiểm tra mà không nhìn ghi chú — buộc não tăng cường đường dẫn truy xuất, hiệu quả hơn nhiều cho việc ghi nhớ dài hạn.', 'Think about the difference between passive and active learning strategies.', 'Hãy nghĩ về sự khác biệt giữa chiến lược học thụ động và chủ động.', 15, 3);

-- Exercise 193: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(28, 'sentence_transform', 'medium', 'Rewrite this cramming strategy as a spaced repetition strategy.', 'Viết lại chiến lược nhồi nhét này thành chiến lược ôn tập giãn cách.', 'Study everything in one 4-hour session the night before the exam.', 'Học mọi thứ trong một buổi 4 giờ đêm trước kỳ thi.', 'Study in four 1-hour sessions spaced over several days before the exam.', 'Spaced repetition breaks study time into multiple shorter sessions spread over days, rather than one long cramming session. The total time can be the same but retention improves dramatically.', 'Ôn tập giãn cách chia thời gian học thành nhiều buổi ngắn hơn trải đều nhiều ngày, thay vì một buổi nhồi nhét dài. Tổng thời gian có thể bằng nhau nhưng khả năng ghi nhớ cải thiện đáng kể.', 15, 4);

-- Exercise 194: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(28, 'arrange_words', 'easy', 'Arrange the three stages of memory in the correct order.', 'Sắp xếp ba giai đoạn của trí nhớ theo đúng thứ tự.', '["Retrieval", "Storage", "Encoding"]', 'Encoding, Storage, Retrieval', 'Information must first be encoded (converted to a memory trace), then stored (maintained over time), and finally retrieved (accessed when needed). This is the standard memory model in cognitive psychology.', 'Thông tin phải được mã hóa trước (chuyển thành dấu vết trí nhớ), sau đó lưu trữ (duy trì theo thời gian), và cuối cùng truy xuất (truy cập khi cần). Đây là mô hình trí nhớ tiêu chuẩn trong tâm lý học nhận thức.', 10, 5);

-- Exercise 195: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(28, 'matching', 'easy', 'Match each memory concept to its description.', 'Nối mỗi khái niệm trí nhớ với mô tả tương ứng.', 'These are the fundamental concepts of how memory works. Understanding each stage helps you develop better study strategies.', 'Đây là các khái niệm cơ bản về cách trí nhớ hoạt động. Hiểu mỗi giai đoạn giúp bạn phát triển chiến lược học tốt hơn.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(195, 'Short-term memory', 'Trí nhớ ngắn hạn', 'Holds ~7 items for 20-30 seconds', 'Chứa ~7 mục trong 20-30 giây', 1),
(195, 'Forgetting curve', 'Đường cong quên', 'Memory decays exponentially without review', 'Trí nhớ suy giảm theo hàm mũ nếu không ôn', 2),
(195, 'Active recall', 'Nhớ lại chủ động', 'Self-testing to strengthen memory', 'Tự kiểm tra để tăng cường trí nhớ', 3),
(195, 'Consolidation', 'Củng cố', 'Brain strengthens memories during sleep', 'Não tăng cường ký ức khi ngủ', 4);

-- Exercise 196: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(28, 'true_false', 'easy', 'Is this statement about memory correct?', 'Phát biểu này về trí nhớ có đúng không?', 'Cramming (studying everything in one long session) is just as effective as spaced repetition for long-term memory.', 'Nhồi nhét (học mọi thứ trong một buổi dài) hiệu quả ngang với ôn tập giãn cách cho trí nhớ dài hạn.', 'false', 'False! Research consistently shows that spaced repetition produces dramatically better long-term retention than cramming. Cramming may work for a test the next day, but the information fades rapidly. Spaced repetition strengthens memories through the Ebbinghaus spacing effect.', 'Sai! Nghiên cứu liên tục cho thấy ôn tập giãn cách tạo ra khả năng ghi nhớ dài hạn tốt hơn đáng kể so với nhồi nhét. Nhồi nhét có thể hiệu quả cho bài kiểm tra ngày mai, nhưng thông tin phai nhạt nhanh. Ôn tập giãn cách tăng cường ký ức thông qua hiệu ứng giãn cách Ebbinghaus.', 5, 7);


-- ############################################################################
-- LESSON 29: COGNITIVE BIASES (lesson_id = 29)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(8, 'Cognitive Biases', 'Thiên Kiến Nhận Thức', 'psych-cognitive-biases', 'Recognize the mental shortcuts that distort our thinking: confirmation bias, anchoring, and more', 'Nhận biết các lối tắt tinh thần làm sai lệch suy nghĩ: thiên kiến xác nhận, neo, và hơn nữa', 'intermediate', 30, 2);

-- Usages (IDs 87-89)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(29, 'Recognizing confirmation bias', 'Nhận biết thiên kiến xác nhận', 'Confirmation bias is the tendency to search for, interpret, and remember information that confirms our existing beliefs.', 'Thiên kiến xác nhận là xu hướng tìm kiếm, diễn giải và ghi nhớ thông tin xác nhận niềm tin hiện có của chúng ta.', 'Psychology', TRUE, 1),
(29, 'Understanding the anchoring effect', 'Hiểu hiệu ứng neo', 'Anchoring occurs when we rely too heavily on the first piece of information we encounter when making decisions.', 'Hiệu ứng neo xảy ra khi chúng ta dựa quá nhiều vào thông tin đầu tiên gặp phải khi ra quyết định.', 'Lightbulb', TRUE, 2),
(29, 'Avoiding the Dunning-Kruger effect', 'Tránh hiệu ứng Dunning-Kruger', 'The Dunning-Kruger effect describes how people with limited knowledge overestimate their competence, while experts underestimate theirs.', 'Hiệu ứng Dunning-Kruger mô tả cách người có kiến thức hạn chế đánh giá quá cao năng lực, trong khi chuyên gia đánh giá quá thấp năng lực của họ.', 'School', TRUE, 3);

-- Examples for usage 87 (IDs 169-170)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(87, 'A person who believes a certain diet is best will only read articles supporting that diet and ignore contradicting evidence.', 'Một người tin rằng chế độ ăn nào đó tốt nhất sẽ chỉ đọc bài viết ủng hộ chế độ đó và bỏ qua bằng chứng mâu thuẫn.', 'Confirmation bias was first described by Peter Wason (1960). It affects everything from medical diagnoses to political opinions.', 'Thiên kiến xác nhận được Peter Wason mô tả lần đầu (1960). Nó ảnh hưởng mọi thứ từ chẩn đoán y khoa đến quan điểm chính trị.', 'confirmation bias', 1),
(87, 'During a job interview, if you form a positive first impression, you tend to interpret all subsequent answers favorably.', 'Trong phỏng vấn việc làm, nếu bạn có ấn tượng đầu tiên tích cực, bạn có xu hướng diễn giải mọi câu trả lời sau đó một cách thuận lợi.', 'This is also called the halo effect — one positive trait influences our perception of everything else about a person.', 'Đây còn gọi là hiệu ứng hào quang — một đặc điểm tích cực ảnh hưởng đến nhận thức của ta về mọi thứ khác của một người.', 'first impression', 2);

-- Examples for usage 88 (IDs 171-172)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(88, 'If a shirt was originally priced at $100 and is now $40, it feels like a great deal — even if the shirt is only worth $30.', 'Nếu áo ban đầu giá $100 và giờ $40, cảm thấy như hời — dù áo chỉ đáng $30.', 'The original $100 price acts as an anchor, making $40 seem reasonable by comparison. Retailers use this strategy constantly.', 'Giá gốc $100 đóng vai trò neo, làm $40 có vẻ hợp lý khi so sánh. Nhà bán lẻ sử dụng chiến lược này liên tục.', 'anchoring', 1),
(88, 'In salary negotiation, the first number mentioned tends to anchor the entire discussion around that figure.', 'Trong đàm phán lương, con số đầu tiên được đề cập có xu hướng neo toàn bộ cuộc thảo luận quanh con số đó.', 'Tversky & Kahneman (1974) demonstrated that even random numbers can serve as anchors and influence judgments about unrelated topics.', 'Tversky & Kahneman (1974) chứng minh rằng ngay cả số ngẫu nhiên cũng có thể làm neo và ảnh hưởng đánh giá về chủ đề không liên quan.', 'first number', 2);

-- Examples for usage 89 (IDs 173-174)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(89, 'A beginner programmer who just learned loops might think they can build any software, not realizing how much they do not know yet.', 'Lập trình viên mới học vòng lặp có thể nghĩ họ có thể xây bất kỳ phần mềm nào, không nhận ra còn bao nhiêu chưa biết.', 'Dunning & Kruger (1999) showed that incompetence robs people of the ability to recognize their own incompetence — a metacognitive failure.', 'Dunning & Kruger (1999) cho thấy sự thiếu năng lực cướp đi khả năng nhận ra sự thiếu năng lực của chính mình — một thất bại siêu nhận thức.', 'Dunning-Kruger', 1),
(89, 'An expert chess player often says "I still have so much to learn" despite being far better than most — experts are more aware of what they do not know.', 'Kỳ thủ chuyên gia thường nói "Tôi còn nhiều phải học" dù giỏi hơn hầu hết — chuyên gia nhận thức rõ hơn những gì họ không biết.', 'As expertise increases, confidence dips (the "valley of despair") before rising again with true mastery — this is the Dunning-Kruger curve.', 'Khi chuyên môn tăng, tự tin giảm ("thung lũng tuyệt vọng") trước khi tăng lại với sự thành thạo thật — đây là đường cong Dunning-Kruger.', 'expert', 2);

-- Tips (IDs 86-88)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(29, 'Actively seek disconfirming evidence', 'Chủ động tìm bằng chứng phản bác', 'When you believe something strongly, deliberately look for evidence that contradicts it. Ask yourself: "What would change my mind?" This is the most powerful antidote to confirmation bias. Scientists use this principle — they try to disprove their own hypotheses.', 'Khi bạn tin điều gì mạnh mẽ, cố ý tìm bằng chứng mâu thuẫn với nó. Tự hỏi: "Điều gì sẽ thay đổi suy nghĩ của tôi?" Đây là thuốc giải mạnh nhất cho thiên kiến xác nhận. Nhà khoa học dùng nguyên tắc này — họ cố bác bỏ giả thuyết của chính mình.', 'general', 'high', 'Lightbulb', 1),
(29, 'Beware of the sunk cost fallacy', 'Cẩn thận với ngụy biện chi phí chìm', 'Do not continue something just because you have already invested time or money. The sunk cost fallacy makes us think "I have spent 3 years on this, so I cannot quit now." But past costs are gone — only future benefits should guide decisions.', 'Đừng tiếp tục điều gì chỉ vì bạn đã đầu tư thời gian hoặc tiền bạc. Ngụy biện chi phí chìm khiến ta nghĩ "Tôi đã bỏ 3 năm vào việc này, nên không thể bỏ." Nhưng chi phí quá khứ đã mất — chỉ lợi ích tương lai mới nên hướng dẫn quyết định.', 'common_mistake', 'high', 'Warning', 2),
(29, 'Use the "consider the opposite" technique', 'Dùng kỹ thuật "xem xét điều ngược lại"', 'Before making a decision, force yourself to argue the opposite position for 2 minutes. Research by Lord, Lepper & Preston (1984) found this simple technique significantly reduces bias in judgment.', 'Trước khi ra quyết định, buộc bản thân lập luận theo vị trí ngược lại trong 2 phút. Nghiên cứu của Lord, Lepper & Preston (1984) phát hiện kỹ thuật đơn giản này giảm đáng kể thiên kiến trong đánh giá.', 'shortcut', 'medium', 'AutoAwesome', 3);

-- Sections (IDs 49-51)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(29, 'markdown', 'Common Cognitive Biases', 'Các Thiên Kiến Nhận Thức Phổ Biến',
'## What Are Cognitive Biases?

Cognitive biases are **systematic errors in thinking** that affect our decisions and judgments. They are mental shortcuts (heuristics) that usually help us think faster, but sometimes lead us astray.

### The Big Five Cognitive Biases

| Bias | Description | Example |
|------|-------------|---------|
| **Confirmation bias** | Favoring information that confirms beliefs | Only reading news you agree with |
| **Anchoring** | Over-relying on the first information received | Judging a sale price based on the "original" price |
| **Dunning-Kruger** | Beginners overestimate, experts underestimate skill | A novice thinking they are an expert after one lesson |
| **Sunk cost fallacy** | Continuing due to past investment | Watching a bad movie because you paid for the ticket |
| **Availability heuristic** | Judging likelihood by how easily examples come to mind | Fearing plane crashes more than car accidents |

### Why Do Biases Exist?

Biases evolved as **survival shortcuts**. In dangerous environments, quick (imperfect) decisions were better than slow (perfect) ones. Today, these same shortcuts can mislead us in complex modern situations.

> **Key insight (Kahneman, 2011):** Our brain has two systems — System 1 (fast, automatic, bias-prone) and System 2 (slow, deliberate, logical). Most biases come from System 1 thinking.',
'## Thiên Kiến Nhận Thức Là Gì?

Thiên kiến nhận thức là **lỗi hệ thống trong suy nghĩ** ảnh hưởng đến quyết định và đánh giá. Chúng là lối tắt tinh thần (phương pháp suy luận) thường giúp ta suy nghĩ nhanh hơn, nhưng đôi khi dẫn ta đi lạc.

### Năm Thiên Kiến Nhận Thức Lớn

| Thiên kiến | Mô tả | Ví dụ |
|------------|-------|-------|
| **Thiên kiến xác nhận** | Ưu tiên thông tin xác nhận niềm tin | Chỉ đọc tin tức bạn đồng ý |
| **Neo** | Dựa quá nhiều vào thông tin đầu tiên nhận được | Đánh giá giá giảm dựa trên giá "gốc" |
| **Dunning-Kruger** | Người mới đánh giá quá cao, chuyên gia đánh giá quá thấp | Người mới nghĩ mình là chuyên gia sau một bài học |
| **Ngụy biện chi phí chìm** | Tiếp tục vì đã đầu tư | Xem phim dở vì đã mua vé |
| **Suy luận sẵn có** | Đánh giá khả năng xảy ra bởi ví dụ dễ nhớ | Sợ tai nạn máy bay hơn tai nạn ô tô |

### Tại Sao Thiên Kiến Tồn Tại?

Thiên kiến tiến hóa như **lối tắt sinh tồn**. Trong môi trường nguy hiểm, quyết định nhanh (không hoàn hảo) tốt hơn quyết định chậm (hoàn hảo). Ngày nay, cùng những lối tắt này có thể đánh lừa ta trong tình huống hiện đại phức tạp.

> **Nhận định chính (Kahneman, 2011):** Não có hai hệ thống — Hệ thống 1 (nhanh, tự động, dễ thiên kiến) và Hệ thống 2 (chậm, có chủ đích, logic). Hầu hết thiên kiến đến từ suy nghĩ Hệ thống 1.', 1, '{}'),

(29, 'key_points', 'Key Points', 'Điểm chính',
'- **Cognitive biases** are systematic thinking errors that affect decisions and judgments
- **Confirmation bias:** We seek information that confirms what we already believe (Wason, 1960)
- **Anchoring:** The first number or fact we hear disproportionately influences our judgment (Tversky & Kahneman, 1974)
- **Dunning-Kruger effect:** Beginners overestimate their ability, while experts underestimate theirs
- **Sunk cost fallacy:** Continuing something because of past investment, not future value
- **Availability heuristic:** Judging probability by how easily examples come to mind, not actual statistics',
'- **Thiên kiến nhận thức** là lỗi suy nghĩ hệ thống ảnh hưởng đến quyết định và đánh giá
- **Thiên kiến xác nhận:** Ta tìm thông tin xác nhận điều ta đã tin (Wason, 1960)
- **Neo:** Số hoặc sự kiện đầu tiên ta nghe ảnh hưởng không cân xứng đến đánh giá (Tversky & Kahneman, 1974)
- **Hiệu ứng Dunning-Kruger:** Người mới đánh giá quá cao năng lực, chuyên gia đánh giá quá thấp
- **Ngụy biện chi phí chìm:** Tiếp tục vì đầu tư quá khứ, không phải giá trị tương lai
- **Suy luận sẵn có:** Đánh giá xác suất bởi ví dụ dễ nhớ, không phải thống kê thực tế', 2, '{}'),

(29, 'info_box', 'System 1 vs System 2', 'Hệ Thống 1 vs Hệ Thống 2',
'**Daniel Kahneman''s two-system model (2011)** explains why biases happen:

**System 1 — Fast Thinking:**
- Automatic, effortless, always on
- Makes quick judgments and snap decisions
- Source of most cognitive biases
- Example: Instantly knowing 2 + 2 = 4

**System 2 — Slow Thinking:**
- Deliberate, effortful, requires concentration
- Used for complex reasoning and analysis
- Can override System 1, but is "lazy" — it often accepts System 1''s suggestions
- Example: Calculating 37 x 24 in your head

**Practical tip:** When making important decisions, slow down and engage System 2. Ask yourself: "Am I reacting on instinct, or thinking this through carefully?"',
'**Mô hình hai hệ thống của Daniel Kahneman (2011)** giải thích tại sao thiên kiến xảy ra:

**Hệ thống 1 — Suy Nghĩ Nhanh:**
- Tự động, không tốn sức, luôn hoạt động
- Đưa ra đánh giá nhanh và quyết định tức thì
- Nguồn gốc của hầu hết thiên kiến nhận thức
- Ví dụ: Biết ngay 2 + 2 = 4

**Hệ thống 2 — Suy Nghĩ Chậm:**
- Có chủ đích, tốn sức, cần tập trung
- Dùng cho lập luận và phân tích phức tạp
- Có thể ghi đè Hệ thống 1, nhưng "lười" — thường chấp nhận gợi ý của Hệ thống 1
- Ví dụ: Tính 37 x 24 trong đầu

**Mẹo thực tế:** Khi ra quyết định quan trọng, hãy chậm lại và kích hoạt Hệ thống 2. Tự hỏi: "Tôi đang phản ứng theo bản năng, hay suy nghĩ kỹ lưỡng?"', 3, '{"variant": "info"}');

-- Exercise 197: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(29, 'multiple_choice', 'easy', 'What is confirmation bias?', 'Thiên kiến xác nhận là gì?', 'Confirmation bias is one of the most common cognitive biases. Which description best defines it?', 'Thiên kiến xác nhận là một trong những thiên kiến nhận thức phổ biến nhất. Mô tả nào định nghĩa nó tốt nhất?', 'Confirmation bias (Wason, 1960) is the tendency to favor information that supports our existing beliefs while ignoring or discounting contradictory evidence. It affects perception, memory, and interpretation.', 'Thiên kiến xác nhận (Wason, 1960) là xu hướng ưu tiên thông tin ủng hộ niềm tin hiện có trong khi bỏ qua hoặc hạ thấp bằng chứng mâu thuẫn. Nó ảnh hưởng đến nhận thức, trí nhớ và diễn giải.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(197, 'A', 'The tendency to seek information that confirms our existing beliefs', TRUE, 'Correct! Confirmation bias makes us favor evidence that supports what we already think', 1),
(197, 'B', 'The tendency to over-rely on the first piece of information encountered', FALSE, 'This describes the anchoring effect, not confirmation bias', 2),
(197, 'C', 'The tendency for beginners to overestimate their abilities', FALSE, 'This describes the Dunning-Kruger effect, not confirmation bias', 3),
(197, 'D', 'The tendency to continue investing because of past costs', FALSE, 'This describes the sunk cost fallacy, not confirmation bias', 4);

-- Exercise 198: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(29, 'fill_blank', 'medium', 'Fill in the name of this cognitive bias.', 'Điền tên thiên kiến nhận thức này.', 'The ___-Kruger effect describes how people with limited knowledge tend to overestimate their competence in a subject.', 'Hiệu ứng ___-Kruger mô tả cách người có kiến thức hạn chế có xu hướng đánh giá quá cao năng lực của họ.', 'Dunning', 'The Dunning-Kruger effect was identified by psychologists David Dunning and Justin Kruger in 1999. It shows that metacognition (awareness of one''s own thinking) is essential for accurate self-assessment.', 'Hiệu ứng Dunning-Kruger được xác định bởi nhà tâm lý học David Dunning và Justin Kruger năm 1999. Nó cho thấy siêu nhận thức (nhận thức về suy nghĩ của chính mình) cần thiết cho tự đánh giá chính xác.', 15, 2);

-- Exercise 199: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(29, 'error_correction', 'medium', 'Fix the incorrect statement about the sunk cost fallacy.', 'Sửa phát biểu sai về ngụy biện chi phí chìm.', 'The sunk cost fallacy means we should continue investing in something because we have already spent a lot of time and money on it.', 'Ngụy biện chi phí chìm nghĩa là chúng ta nên tiếp tục đầu tư vào điều gì đó vì đã bỏ nhiều thời gian và tiền bạc.', 'The sunk cost fallacy means we mistakenly continue investing in something because we have already spent a lot of time and money on it.', 'The sunk cost fallacy is a cognitive bias, not rational behavior. The original statement incorrectly presents it as something "we should" do. Rational decision-making should be based on future value, not past investment. Adding "mistakenly" correctly identifies it as an error in thinking.', 'Ngụy biện chi phí chìm là thiên kiến nhận thức, không phải hành vi hợp lý. Câu gốc sai khi trình bày đó là điều "nên" làm. Quyết định hợp lý nên dựa trên giá trị tương lai, không phải đầu tư đã qua. Thêm "sai lầm" xác định đúng đây là lỗi suy nghĩ.', 'Is the sunk cost fallacy a rational decision or a thinking error?', 'Ngụy biện chi phí chìm là quyết định hợp lý hay lỗi suy nghĩ?', 15, 3);

-- Exercise 200: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(29, 'sentence_transform', 'medium', 'Rewrite this biased statement to remove the confirmation bias.', 'Viết lại phát biểu thiên kiến này để loại bỏ thiên kiến xác nhận.', 'I only read articles that support my view that remote work is better than office work.', 'Tôi chỉ đọc bài viết ủng hộ quan điểm của tôi rằng làm việc từ xa tốt hơn làm việc văn phòng.', 'I read articles both supporting and opposing remote work to form a balanced view.', 'To counter confirmation bias, you should actively seek out information from both sides of an argument. This is called the "consider the opposite" strategy.', 'Để chống thiên kiến xác nhận, bạn nên chủ động tìm kiếm thông tin từ cả hai phía của lập luận. Đây gọi là chiến lược "xem xét điều ngược lại".', 15, 4);

-- Exercise 201: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(29, 'arrange_words', 'easy', 'Arrange the Dunning-Kruger effect stages from beginner to expert.', 'Sắp xếp các giai đoạn hiệu ứng Dunning-Kruger từ người mới đến chuyên gia.', '["Conscious competence", "Unconscious incompetence", "Unconscious competence", "Conscious incompetence"]', 'Unconscious incompetence, Conscious incompetence, Conscious competence, Unconscious competence', 'The four stages of competence: (1) You do not know what you do not know, (2) You realize how much you do not know, (3) You can do it with effort, (4) You can do it automatically. This maps to the Dunning-Kruger curve.', 'Bốn giai đoạn năng lực: (1) Bạn không biết điều bạn không biết, (2) Bạn nhận ra còn bao nhiêu không biết, (3) Bạn có thể làm với nỗ lực, (4) Bạn có thể làm tự động. Điều này tương ứng với đường cong Dunning-Kruger.', 10, 5);

-- Exercise 202: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(29, 'matching', 'easy', 'Match each cognitive bias to its real-world example.', 'Nối mỗi thiên kiến nhận thức với ví dụ thực tế.', 'Cognitive biases affect everyday decisions from shopping to career choices. Recognizing them in real scenarios is the first step to thinking more clearly.', 'Thiên kiến nhận thức ảnh hưởng đến quyết định hàng ngày từ mua sắm đến lựa chọn nghề nghiệp. Nhận ra chúng trong tình huống thực là bước đầu tiên để suy nghĩ rõ ràng hơn.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(202, 'Confirmation bias', 'Thiên kiến xác nhận', 'Only reading news you agree with', 'Chỉ đọc tin tức bạn đồng ý', 1),
(202, 'Anchoring effect', 'Hiệu ứng neo', 'A high original price makes a sale price seem cheap', 'Giá gốc cao làm giá giảm có vẻ rẻ', 2),
(202, 'Sunk cost fallacy', 'Ngụy biện chi phí chìm', 'Finishing a bad book because you already read half', 'Đọc hết sách dở vì đã đọc nửa', 3),
(202, 'Availability heuristic', 'Suy luận sẵn có', 'Fearing sharks after watching a shark movie', 'Sợ cá mập sau khi xem phim cá mập', 4);

-- Exercise 203: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(29, 'true_false', 'easy', 'Is this statement about cognitive biases correct?', 'Phát biểu này về thiên kiến nhận thức có đúng không?', 'Cognitive biases only affect uneducated people. Highly intelligent and well-educated people are immune to them.', 'Thiên kiến nhận thức chỉ ảnh hưởng đến người ít học. Người thông minh và có giáo dục cao miễn nhiễm với chúng.', 'false', 'False! Research shows that cognitive biases affect everyone, regardless of intelligence or education. In fact, highly intelligent people can be even more skilled at rationalizing their biased thinking. Awareness and deliberate strategies are needed to counteract biases.', 'Sai! Nghiên cứu cho thấy thiên kiến nhận thức ảnh hưởng đến mọi người, bất kể trí thông minh hay giáo dục. Thực tế, người thông minh cao có thể giỏi hơn trong hợp lý hóa suy nghĩ thiên kiến. Cần nhận thức và chiến lược có chủ đích để chống lại thiên kiến.', 5, 7);


-- ############################################################################
-- LESSON 30: MOTIVATION THEORY (lesson_id = 30)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(8, 'Motivation Theory', 'Lý Thuyết Động Lực', 'psych-motivation', 'Explore what drives human behavior: Maslow''s hierarchy, intrinsic motivation, and flow state', 'Khám phá điều thúc đẩy hành vi con người: tháp nhu cầu Maslow, động lực nội tại và trạng thái dòng chảy', 'beginner', 25, 3);

-- Usages (IDs 90-92)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(30, 'Maslow''s hierarchy of needs', 'Tháp nhu cầu Maslow', 'Maslow (1943) proposed five levels of human needs, from basic survival to self-actualization, that motivate behavior.', 'Maslow (1943) đề xuất năm mức nhu cầu con người, từ sinh tồn cơ bản đến tự thực hiện, thúc đẩy hành vi.', 'Favorite', TRUE, 1),
(30, 'Intrinsic vs extrinsic motivation', 'Động lực nội tại và ngoại tại', 'Intrinsic motivation comes from internal satisfaction, while extrinsic motivation comes from external rewards like money or grades.', 'Động lực nội tại đến từ sự thỏa mãn bên trong, trong khi động lực ngoại tại đến từ phần thưởng bên ngoài như tiền bạc hoặc điểm số.', 'EmojiEmotions', TRUE, 2),
(30, 'Flow state and optimal challenge', 'Trạng thái dòng chảy và thử thách tối ưu', 'Flow (Csikszentmihalyi, 1990) occurs when challenge matches skill — you feel fully absorbed, lose track of time, and perform at your best.', 'Dòng chảy (Csikszentmihalyi, 1990) xảy ra khi thử thách phù hợp kỹ năng — bạn hoàn toàn tập trung, quên thời gian và thể hiện tốt nhất.', 'School', TRUE, 3);

-- Examples for usage 90 (IDs 175-176)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(90, 'A hungry person focuses on finding food before thinking about career goals — basic needs must be met first.', 'Người đói tập trung tìm thức ăn trước khi nghĩ đến mục tiêu nghề nghiệp — nhu cầu cơ bản phải được đáp ứng trước.', 'Maslow''s hierarchy has five levels: physiological, safety, love/belonging, esteem, and self-actualization. Lower levels must be satisfied before higher ones become motivating.', 'Tháp Maslow có năm mức: sinh lý, an toàn, tình yêu/thuộc về, tôn trọng và tự thực hiện. Mức thấp phải được thỏa mãn trước khi mức cao trở nên thúc đẩy.', 'Maslow', 1),
(90, 'An artist who creates purely for the joy of expression has reached the self-actualization level of Maslow''s hierarchy.', 'Nghệ sĩ sáng tạo thuần túy vì niềm vui biểu đạt đã đạt mức tự thực hiện trong tháp Maslow.', 'Self-actualization — the highest level — means fulfilling your full potential. Maslow estimated only about 2% of people fully reach this level.', 'Tự thực hiện — mức cao nhất — nghĩa là phát huy hết tiềm năng. Maslow ước tính chỉ khoảng 2% người đạt đến mức này hoàn toàn.', 'self-actualization', 2);

-- Examples for usage 91 (IDs 177-178)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(91, 'A child who reads books because they genuinely enjoy stories is intrinsically motivated — no reward is needed.', 'Trẻ đọc sách vì thật sự thích truyện là có động lực nội tại — không cần phần thưởng.', 'Intrinsic motivation tends to be more sustainable and leads to deeper learning than extrinsic motivation.', 'Động lực nội tại thường bền vững hơn và dẫn đến học sâu hơn động lực ngoại tại.', 'intrinsic', 1),
(91, 'A student who studies only to get a high grade is extrinsically motivated — they might stop studying once grades no longer matter.', 'Học sinh chỉ học để được điểm cao là có động lực ngoại tại — họ có thể ngừng học khi điểm không còn quan trọng.', 'Deci & Ryan''s Self-Determination Theory (1985) shows that autonomy, competence, and relatedness are the three basic psychological needs driving intrinsic motivation.', 'Lý thuyết Tự quyết của Deci & Ryan (1985) cho thấy tự chủ, năng lực và mối quan hệ là ba nhu cầu tâm lý cơ bản thúc đẩy động lực nội tại.', 'extrinsic', 2);

-- Examples for usage 92 (IDs 179-180)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(92, 'A programmer solving a challenging but achievable bug loses track of time for hours — they are in a flow state.', 'Lập trình viên giải quyết lỗi khó nhưng có thể làm được mất dấu thời gian hàng giờ — họ đang trong trạng thái dòng chảy.', 'Flow requires a balance: if the task is too easy, you feel bored; if too hard, you feel anxious. The sweet spot in between produces flow.', 'Dòng chảy cần sự cân bằng: nếu nhiệm vụ quá dễ, bạn chán; nếu quá khó, bạn lo lắng. Điểm ngọt ở giữa tạo ra dòng chảy.', 'flow state', 1),
(92, 'A gamer playing at just the right difficulty level feels completely absorbed — this is flow applied to game design.', 'Game thủ chơi ở mức độ khó vừa phải cảm thấy hoàn toàn tập trung — đây là dòng chảy áp dụng vào thiết kế game.', 'Csikszentmihalyi (1990) identified flow as the state of optimal experience. It requires clear goals, immediate feedback, and a challenge-skill balance.', 'Csikszentmihalyi (1990) xác định dòng chảy là trạng thái trải nghiệm tối ưu. Nó cần mục tiêu rõ ràng, phản hồi tức thì và cân bằng thử thách-kỹ năng.', 'Csikszentmihalyi', 2);

-- Tips (IDs 89-91)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(30, 'Protect intrinsic motivation from over-rewarding', 'Bảo vệ động lực nội tại khỏi thưởng quá nhiều', 'The overjustification effect (Lepper et al., 1973) shows that adding external rewards for activities people already enjoy can actually DECREASE intrinsic motivation. If a child loves drawing, paying them per drawing can make them stop drawing for fun.', 'Hiệu ứng biện minh quá mức (Lepper et al., 1973) cho thấy thêm phần thưởng bên ngoài cho hoạt động người ta đã thích thực sự có thể GIẢM động lực nội tại. Nếu trẻ thích vẽ, trả tiền mỗi bức vẽ có thể khiến trẻ ngừng vẽ vì vui.', 'common_mistake', 'high', 'Warning', 1),
(30, 'Find your flow zone', 'Tìm vùng dòng chảy của bạn', 'To enter flow, choose tasks that are about 4% beyond your current skill level — challenging enough to engage you, but not so hard that you feel overwhelmed. Break large goals into smaller challenges that match this balance.', 'Để vào dòng chảy, chọn nhiệm vụ khó hơn khoảng 4% so với mức kỹ năng hiện tại — đủ thử thách để thu hút bạn, nhưng không khó đến mức choáng ngợp. Chia mục tiêu lớn thành thử thách nhỏ phù hợp cân bằng này.', 'general', 'high', 'Lightbulb', 2),
(30, 'Use autonomy, competence, relatedness', 'Dùng tự chủ, năng lực, mối quan hệ', 'Self-Determination Theory says you can boost motivation by ensuring three things: autonomy (feeling of choice), competence (feeling of progress), and relatedness (feeling of connection with others). This applies to learning, work, and exercise habits.', 'Lý thuyết Tự quyết nói bạn có thể tăng động lực bằng cách đảm bảo ba điều: tự chủ (cảm giác được chọn), năng lực (cảm giác tiến bộ) và mối quan hệ (cảm giác kết nối với người khác). Áp dụng cho học tập, công việc và tập thể dục.', 'shortcut', 'medium', 'AutoAwesome', 3);

-- Sections (IDs 52-54)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(30, 'markdown', 'What Drives Human Behavior', 'Điều Gì Thúc Đẩy Hành Vi Con Người',
'## Maslow''s Hierarchy of Needs (1943)

Humans are motivated by **five levels of needs**, from basic to advanced:

| Level | Need | Example |
|-------|------|---------|
| 5 (top) | **Self-actualization** | Pursuing creative potential |
| 4 | **Esteem** | Recognition, achievement |
| 3 | **Love/Belonging** | Friendships, family |
| 2 | **Safety** | Job security, health |
| 1 (base) | **Physiological** | Food, water, shelter |

> Lower needs must be **substantially satisfied** before higher needs become strong motivators.

## Intrinsic vs Extrinsic Motivation

- **Intrinsic:** Doing something because it is inherently enjoyable or interesting
- **Extrinsic:** Doing something for an external reward (money, grades, praise)

Research consistently shows that **intrinsic motivation** leads to better learning, creativity, and well-being.

## Flow State (Csikszentmihalyi, 1990)

Flow is the state of **complete absorption** in an activity. It requires:
- **Clear goals** — you know what you are trying to achieve
- **Immediate feedback** — you know how well you are doing
- **Challenge-skill balance** — the task is not too easy or too hard',
'## Tháp Nhu Cầu Maslow (1943)

Con người được thúc đẩy bởi **năm mức nhu cầu**, từ cơ bản đến nâng cao:

| Mức | Nhu cầu | Ví dụ |
|-----|---------|-------|
| 5 (đỉnh) | **Tự thực hiện** | Theo đuổi tiềm năng sáng tạo |
| 4 | **Tôn trọng** | Công nhận, thành tựu |
| 3 | **Tình yêu/Thuộc về** | Tình bạn, gia đình |
| 2 | **An toàn** | Công việc ổn định, sức khỏe |
| 1 (đáy) | **Sinh lý** | Thức ăn, nước, nơi ở |

> Nhu cầu thấp phải được **thỏa mãn đáng kể** trước khi nhu cầu cao trở thành động lực mạnh.

## Động Lực Nội Tại vs Ngoại Tại

- **Nội tại:** Làm điều gì đó vì bản chất nó thú vị hoặc hấp dẫn
- **Ngoại tại:** Làm điều gì đó vì phần thưởng bên ngoài (tiền, điểm, khen ngợi)

Nghiên cứu liên tục cho thấy **động lực nội tại** dẫn đến học tốt hơn, sáng tạo hơn và hạnh phúc hơn.

## Trạng Thái Dòng Chảy (Csikszentmihalyi, 1990)

Dòng chảy là trạng thái **hoàn toàn tập trung** vào hoạt động. Nó cần:
- **Mục tiêu rõ ràng** — bạn biết mình đang cố đạt gì
- **Phản hồi tức thì** — bạn biết mình đang làm tốt như nào
- **Cân bằng thử thách-kỹ năng** — nhiệm vụ không quá dễ hay quá khó', 1, '{}'),

(30, 'key_points', 'Key Points', 'Điểm chính',
'- **Maslow''s hierarchy** has 5 levels: physiological, safety, love/belonging, esteem, self-actualization
- Lower needs must be met before higher needs become **strong motivators**
- **Intrinsic motivation** (internal enjoyment) produces deeper learning than **extrinsic** (external rewards)
- **Self-Determination Theory** (Deci & Ryan, 1985): autonomy + competence + relatedness = motivation
- **Flow state** (Csikszentmihalyi, 1990) requires clear goals, immediate feedback, and challenge-skill balance
- The **overjustification effect** warns that adding rewards for enjoyable activities can reduce intrinsic motivation',
'- **Tháp Maslow** có 5 mức: sinh lý, an toàn, tình yêu/thuộc về, tôn trọng, tự thực hiện
- Nhu cầu thấp phải được đáp ứng trước khi nhu cầu cao trở thành **động lực mạnh**
- **Động lực nội tại** (thỏa mãn bên trong) tạo học sâu hơn **ngoại tại** (phần thưởng bên ngoài)
- **Lý thuyết Tự quyết** (Deci & Ryan, 1985): tự chủ + năng lực + mối quan hệ = động lực
- **Trạng thái dòng chảy** (Csikszentmihalyi, 1990) cần mục tiêu rõ, phản hồi tức thì, cân bằng thử thách-kỹ năng
- **Hiệu ứng biện minh quá mức** cảnh báo thêm phần thưởng cho hoạt động thú vị có thể giảm động lực nội tại', 2, '{}'),

(30, 'info_box', 'The Overjustification Effect', 'Hiệu Ứng Biện Minh Quá Mức',
'**Warning:** External rewards can DESTROY internal motivation!

In a famous study (Lepper, Greene & Nisbett, 1973), children who loved drawing were divided into three groups:
- **Group A:** Promised a reward for drawing (expected reward)
- **Group B:** Given a surprise reward after drawing (unexpected reward)
- **Group C:** No reward (control)

**Result:** Group A drew significantly **less** in later free time. The expected reward turned play into work!

**Practical lesson:** Be careful with rewards for activities that are already enjoyable. Use rewards sparingly and unexpectedly when you must. Focus instead on fostering autonomy, competence, and relatedness.',
'**Cảnh báo:** Phần thưởng bên ngoài có thể PHÁ HỦY động lực bên trong!

Trong nghiên cứu nổi tiếng (Lepper, Greene & Nisbett, 1973), trẻ em thích vẽ được chia ba nhóm:
- **Nhóm A:** Được hứa thưởng khi vẽ (phần thưởng dự kiến)
- **Nhóm B:** Được thưởng bất ngờ sau khi vẽ (phần thưởng bất ngờ)
- **Nhóm C:** Không thưởng (nhóm đối chứng)

**Kết quả:** Nhóm A vẽ ít hơn đáng kể trong thời gian rảnh sau đó. Phần thưởng dự kiến biến chơi thành công việc!

**Bài học thực tế:** Cẩn thận với phần thưởng cho hoạt động đã thú vị. Dùng phần thưởng ít và bất ngờ khi cần. Thay vào đó tập trung nuôi dưỡng tự chủ, năng lực và mối quan hệ.', 3, '{"variant": "warning"}');

-- Diagram section: Maslow's hierarchy of needs (order_index 4)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(30, 'diagram', 'Maslow''s Hierarchy', 'Tháp nhu cầu Maslow',
'Maslow''s hierarchy (1943) proposes that humans must satisfy **lower needs before higher ones**. Basic survival needs come first; self-actualization is only pursued when safety, belonging, and esteem are met.',
'Tháp nhu cầu Maslow (1943) đề xuất con người phải thỏa mãn **nhu cầu thấp trước nhu cầu cao**. Nhu cầu sinh tồn cơ bản đến trước; tự thực hiện chỉ được theo đuổi khi an toàn, thuộc về và tôn trọng đã được đáp ứng.', 4,
'{"code": "graph BT\n    E[\"Physiological: food, water, shelter\"] --> D[\"Safety: security, stability, health\"]\n    D --> C[\"Love & Belonging: relationships, community\"]\n    C --> B[\"Esteem: respect, achievement, confidence\"]\n    B --> A[\"Self-Actualization: full potential, creativity\"]"}');

-- Exercise 204: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(30, 'multiple_choice', 'easy', 'What is the highest level in Maslow''s hierarchy of needs?', 'Mức cao nhất trong tháp nhu cầu Maslow là gì?', 'Maslow proposed five levels of human needs. Which one is at the top of the pyramid?', 'Maslow đề xuất năm mức nhu cầu con người. Mức nào ở đỉnh tháp?', 'Self-actualization is the highest level in Maslow''s hierarchy (1943). It represents the desire to fulfill one''s full potential and become the best version of oneself.', 'Tự thực hiện là mức cao nhất trong tháp Maslow (1943). Nó đại diện cho mong muốn phát huy hết tiềm năng và trở thành phiên bản tốt nhất của chính mình.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(204, 'A', 'Safety needs', FALSE, 'Safety is the second level from the bottom, not the top', 1),
(204, 'B', 'Esteem needs', FALSE, 'Esteem is the fourth level — close to the top but not the highest', 2),
(204, 'C', 'Self-actualization', TRUE, 'Correct! Self-actualization is the peak of Maslow''s pyramid', 3),
(204, 'D', 'Love and belonging', FALSE, 'Love and belonging is the third (middle) level', 4);

-- Exercise 205: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(30, 'fill_blank', 'medium', 'Fill in the name of this psychological state.', 'Điền tên trạng thái tâm lý này.', 'The ___ state, described by Csikszentmihalyi (1990), occurs when a person is fully immersed in an activity with complete focus and enjoyment.', 'Trạng thái ___, được Csikszentmihalyi (1990) mô tả, xảy ra khi một người hoàn toàn đắm chìm trong hoạt động với sự tập trung và thích thú trọn vẹn.', 'flow', 'Flow is the state of optimal experience where challenge matches skill. You feel completely absorbed, lose track of time, and performance peaks. Csikszentmihalyi called it "the psychology of optimal experience."', 'Dòng chảy là trạng thái trải nghiệm tối ưu khi thử thách phù hợp kỹ năng. Bạn hoàn toàn tập trung, quên thời gian và hiệu suất đỉnh cao. Csikszentmihalyi gọi nó là "tâm lý học của trải nghiệm tối ưu."', 15, 2);

-- Exercise 206: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(30, 'error_correction', 'medium', 'Fix the incorrect statement about motivation.', 'Sửa phát biểu sai về động lực.', 'Extrinsic motivation such as money and grades always leads to better learning outcomes than intrinsic motivation.', 'Động lực ngoại tại như tiền bạc và điểm số luôn dẫn đến kết quả học tốt hơn động lực nội tại.', 'Intrinsic motivation such as curiosity and enjoyment generally leads to better learning outcomes than extrinsic motivation.', 'Research consistently shows that intrinsic motivation — driven by curiosity, enjoyment, and personal interest — produces deeper learning and longer retention than extrinsic motivation. Extrinsic rewards can even undermine intrinsic motivation, a phenomenon known as the overjustification effect.', 'Nghiên cứu liên tục cho thấy động lực nội tại — thúc đẩy bởi tò mò, thích thú và sở thích cá nhân — tạo ra học tập sâu hơn và ghi nhớ lâu hơn so với động lực ngoại tại. Phần thưởng bên ngoài thậm chí có thể làm suy yếu động lực nội tại, hiện tượng gọi là hiệu ứng biện minh quá mức.', 'Think about which type of motivation leads to deeper engagement with learning material.', 'Hãy nghĩ loại động lực nào dẫn đến sự gắn kết sâu hơn với tài liệu học.', 15, 3);

-- Exercise 207: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(30, 'sentence_transform', 'medium', 'Rewrite this extrinsic motivation approach as an intrinsic motivation approach.', 'Viết lại cách tiếp cận động lực ngoại tại này thành cách tiếp cận động lực nội tại.', 'I study psychology only to pass the exam and get a good grade.', 'Tôi học tâm lý chỉ để thi đậu và được điểm tốt.', 'I study psychology because understanding human behavior is fascinating and helps me in daily life.', 'Extrinsic motivation focuses on external rewards (grades, money). Intrinsic motivation focuses on internal satisfaction (curiosity, enjoyment, personal growth). Shifting from "I have to" to "I want to" is the key transformation.', 'Động lực ngoại tại tập trung vào phần thưởng bên ngoài (điểm, tiền). Động lực nội tại tập trung vào sự thỏa mãn bên trong (tò mò, thích thú, phát triển cá nhân). Chuyển từ "phải làm" sang "muốn làm" là sự chuyển đổi then chốt.', 15, 4);

-- Exercise 208: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(30, 'arrange_words', 'easy', 'Arrange Maslow''s hierarchy of needs from the base (lowest) to the top (highest).', 'Sắp xếp tháp nhu cầu Maslow từ đáy (thấp nhất) đến đỉnh (cao nhất).', '["Esteem", "Physiological", "Self-actualization", "Safety", "Love/Belonging"]', 'Physiological, Safety, Love/Belonging, Esteem, Self-actualization', 'Maslow''s hierarchy from bottom to top: (1) Physiological (food, water), (2) Safety (security), (3) Love/Belonging (relationships), (4) Esteem (recognition), (5) Self-actualization (fulfilling potential).', 'Tháp Maslow từ đáy lên đỉnh: (1) Sinh lý (thức ăn, nước), (2) An toàn (bảo đảm), (3) Tình yêu/Thuộc về (quan hệ), (4) Tôn trọng (công nhận), (5) Tự thực hiện (phát huy tiềm năng).', 10, 5);

-- Exercise 209: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(30, 'matching', 'easy', 'Match each motivation concept to its key researcher.', 'Nối mỗi khái niệm động lực với nhà nghiên cứu chính.', 'These researchers made foundational contributions to our understanding of human motivation. Their theories are still widely used in education, management, and psychology today.', 'Các nhà nghiên cứu này có đóng góp nền tảng cho hiểu biết của chúng ta về động lực con người. Lý thuyết của họ vẫn được sử dụng rộng rãi trong giáo dục, quản lý và tâm lý học ngày nay.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(209, 'Hierarchy of needs', 'Tháp nhu cầu', 'Maslow (1943)', 'Maslow (1943)', 1),
(209, 'Flow state', 'Trạng thái dòng chảy', 'Csikszentmihalyi (1990)', 'Csikszentmihalyi (1990)', 2),
(209, 'Self-Determination Theory', 'Lý thuyết Tự quyết', 'Deci & Ryan (1985)', 'Deci & Ryan (1985)', 3),
(209, 'Overjustification effect', 'Hiệu ứng biện minh quá mức', 'Lepper et al. (1973)', 'Lepper et al. (1973)', 4);

-- Exercise 210: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(30, 'true_false', 'easy', 'Is this statement about flow state correct?', 'Phát biểu này về trạng thái dòng chảy có đúng không?', 'Flow state can only occur during leisure activities like gaming or sports, not during work or studying.', 'Trạng thái dòng chảy chỉ xảy ra trong hoạt động giải trí như chơi game hoặc thể thao, không trong công việc hay học tập.', 'false', 'False! Flow can occur in ANY activity — work, studying, coding, music, sports, art, or even conversation — as long as three conditions are met: clear goals, immediate feedback, and a balance between challenge and skill level.', 'Sai! Dòng chảy có thể xảy ra trong BẤT KỲ hoạt động nào — công việc, học tập, lập trình, âm nhạc, thể thao, nghệ thuật, hoặc thậm chí trò chuyện — miễn là ba điều kiện được đáp ứng: mục tiêu rõ ràng, phản hồi tức thì và cân bằng giữa thử thách và mức kỹ năng.', 5, 7);


-- ############################################################################
-- LESSON 31: EMOTIONAL INTELLIGENCE (lesson_id = 31)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(8, 'Emotional Intelligence', 'Trí Tuệ Cảm Xúc', 'psych-emotional-intelligence', 'Develop self-awareness, empathy, and social skills using Goleman''s EQ framework', 'Phát triển tự nhận thức, đồng cảm và kỹ năng xã hội bằng khung EQ của Goleman', 'intermediate', 30, 4);

-- Usages (IDs 93-95)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(31, 'Self-awareness and self-regulation', 'Tự nhận thức và tự điều chỉnh', 'Self-awareness means recognizing your own emotions; self-regulation means managing them constructively rather than reacting impulsively.', 'Tự nhận thức là nhận biết cảm xúc của mình; tự điều chỉnh là quản lý chúng một cách xây dựng thay vì phản ứng bốc đồng.', 'EmojiEmotions', TRUE, 1),
(31, 'Empathy and perspective-taking', 'Đồng cảm và nhìn từ góc độ người khác', 'Empathy is the ability to understand and share the feelings of others, which is essential for meaningful relationships and effective communication.', 'Đồng cảm là khả năng hiểu và chia sẻ cảm xúc của người khác, cần thiết cho mối quan hệ có ý nghĩa và giao tiếp hiệu quả.', 'Favorite', TRUE, 2),
(31, 'Social skills and relationship management', 'Kỹ năng xã hội và quản lý mối quan hệ', 'Social skills include communication, conflict resolution, teamwork, and influence — the ability to navigate relationships effectively.', 'Kỹ năng xã hội gồm giao tiếp, giải quyết xung đột, làm việc nhóm và ảnh hưởng — khả năng điều hướng mối quan hệ hiệu quả.', 'People', TRUE, 3);

-- Examples for usage 93 (IDs 181-182)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(93, 'Before responding to a frustrating email, you pause and notice you are feeling angry — that pause is self-awareness in action.', 'Trước khi trả lời email gây bực bội, bạn dừng lại và nhận ra mình đang tức giận — khoảng dừng đó là tự nhận thức trong hành động.', 'Self-awareness is the foundation of emotional intelligence. Without recognizing your emotions, you cannot manage them effectively.', 'Tự nhận thức là nền tảng của trí tuệ cảm xúc. Không nhận ra cảm xúc, bạn không thể quản lý chúng hiệu quả.', 'self-awareness', 1),
(93, 'Instead of yelling when stressed, you take a walk to calm down — this is self-regulation, managing emotions rather than being controlled by them.', 'Thay vì hét khi căng thẳng, bạn đi dạo để bình tĩnh — đây là tự điều chỉnh, quản lý cảm xúc thay vì bị chúng kiểm soát.', 'Goleman (1995) identified self-regulation as the ability to redirect disruptive emotions and adapt to changing circumstances.', 'Goleman (1995) xác định tự điều chỉnh là khả năng chuyển hướng cảm xúc gây rối và thích ứng với hoàn cảnh thay đổi.', 'self-regulation', 2);

-- Examples for usage 94 (IDs 183-184)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(94, 'When your friend fails an exam, you feel their disappointment and offer comfort — this demonstrates empathy.', 'Khi bạn bè trượt kỳ thi, bạn cảm nhận sự thất vọng của họ và an ủi — điều này thể hiện sự đồng cảm.', 'Empathy has two components: cognitive empathy (understanding another''s perspective) and affective empathy (feeling what they feel).', 'Đồng cảm có hai thành phần: đồng cảm nhận thức (hiểu góc nhìn người khác) và đồng cảm cảm xúc (cảm nhận điều họ cảm thấy).', 'empathy', 1),
(94, 'A doctor who says "I understand this must be frightening for you" is using empathy to build trust with a patient.', 'Bác sĩ nói "Tôi hiểu điều này chắc hẳn đáng sợ với bạn" đang dùng đồng cảm để xây dựng niềm tin với bệnh nhân.', 'Research shows that empathetic doctors have patients who recover faster and comply better with treatment plans.', 'Nghiên cứu cho thấy bác sĩ đồng cảm có bệnh nhân hồi phục nhanh hơn và tuân thủ kế hoạch điều trị tốt hơn.', 'trust', 2);

-- Examples for usage 95 (IDs 185-186)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(95, 'A team leader who mediates a conflict between two colleagues by listening to both sides and finding common ground shows strong social skills.', 'Trưởng nhóm hòa giải xung đột giữa hai đồng nghiệp bằng cách lắng nghe cả hai bên và tìm điểm chung cho thấy kỹ năng xã hội mạnh.', 'Social skills in Goleman''s model include influence, communication, conflict management, collaboration, and team capabilities.', 'Kỹ năng xã hội trong mô hình Goleman bao gồm ảnh hưởng, giao tiếp, quản lý xung đột, hợp tác và khả năng làm việc nhóm.', 'social skills', 1),
(95, 'A project manager who communicates clearly, motivates the team, and handles disagreements constructively has high emotional intelligence.', 'Quản lý dự án giao tiếp rõ ràng, tạo động lực cho nhóm và xử lý bất đồng xây dựng có trí tuệ cảm xúc cao.', 'Goleman (1998) found that emotional intelligence accounts for nearly 90% of what distinguishes star performers from average ones in leadership positions.', 'Goleman (1998) phát hiện trí tuệ cảm xúc chiếm gần 90% điều phân biệt người xuất sắc với người trung bình ở vị trí lãnh đạo.', 'emotional intelligence', 2);

-- Tips (IDs 92-94)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(31, 'Practice the 6-second pause', 'Thực hành khoảng dừng 6 giây', 'When you feel a strong emotion, pause for 6 seconds before reacting. This gives your prefrontal cortex (rational brain) time to catch up with your amygdala (emotional brain). Goleman calls this the "amygdala hijack" — strong emotions bypass rational thinking.', 'Khi cảm thấy cảm xúc mạnh, dừng 6 giây trước khi phản ứng. Điều này cho vỏ não trước trán (não lý trí) thời gian bắt kịp hạch hạnh nhân (não cảm xúc). Goleman gọi đây là "chiếm quyền hạch hạnh nhân" — cảm xúc mạnh bỏ qua suy nghĩ lý trí.', 'general', 'high', 'Lightbulb', 1),
(31, 'Empathy is not the same as agreement', 'Đồng cảm không giống đồng ý', 'A common mistake is thinking empathy means you have to agree with someone. Empathy means UNDERSTANDING their perspective, not necessarily sharing it. You can empathize with someone''s frustration while still disagreeing with their conclusion.', 'Lỗi phổ biến là nghĩ đồng cảm nghĩa là phải đồng ý với ai đó. Đồng cảm nghĩa là HIỂU góc nhìn của họ, không nhất thiết chia sẻ nó. Bạn có thể đồng cảm với sự bực bội của ai đó mà vẫn không đồng ý với kết luận của họ.', 'common_mistake', 'high', 'Warning', 2),
(31, 'Name the emotion to tame it', 'Gọi tên cảm xúc để thuần hóa nó', 'Research by Lieberman et al. (2007) shows that simply labeling an emotion ("I am feeling anxious") reduces its intensity by activating the prefrontal cortex. This technique is called "affect labeling" — putting feelings into words helps regulate them.', 'Nghiên cứu của Lieberman et al. (2007) cho thấy chỉ cần gọi tên cảm xúc ("Tôi đang lo lắng") giảm cường độ bằng cách kích hoạt vỏ não trước trán. Kỹ thuật này gọi là "gán nhãn cảm xúc" — đặt cảm xúc thành lời giúp điều chỉnh chúng.', 'shortcut', 'medium', 'AutoAwesome', 3);

-- Sections (IDs 55-57)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(31, 'markdown', 'Goleman''s Emotional Intelligence Model', 'Mô Hình Trí Tuệ Cảm Xúc Của Goleman',
'## What Is Emotional Intelligence?

Emotional Intelligence (EQ) is the ability to **recognize, understand, and manage** your own emotions and the emotions of others. Daniel Goleman (1995) popularized the concept and proposed five key components:

### The Five Components of EQ

| Component | Description | Example |
|-----------|-------------|---------|
| **Self-awareness** | Recognizing your own emotions | Noticing you feel anxious before a presentation |
| **Self-regulation** | Managing emotions constructively | Taking a deep breath instead of snapping at someone |
| **Motivation** | Internal drive beyond external rewards | Pursuing goals because they align with your values |
| **Empathy** | Understanding others'' feelings | Sensing a colleague is overwhelmed without them saying it |
| **Social skills** | Managing relationships effectively | Resolving a team conflict fairly |

### Why EQ Matters

Goleman''s research (1998) found that EQ is **twice as important** as IQ and technical skills combined for outstanding performance, especially in leadership roles.

> **Key finding:** The most successful leaders are not the smartest — they are the ones who handle emotions (their own and others'') most skillfully.',
'## Trí Tuệ Cảm Xúc Là Gì?

Trí tuệ cảm xúc (EQ) là khả năng **nhận biết, hiểu và quản lý** cảm xúc của bản thân và người khác. Daniel Goleman (1995) phổ biến khái niệm này và đề xuất năm thành phần chính:

### Năm Thành Phần Của EQ

| Thành phần | Mô tả | Ví dụ |
|------------|-------|-------|
| **Tự nhận thức** | Nhận biết cảm xúc của mình | Nhận ra bạn lo lắng trước bài thuyết trình |
| **Tự điều chỉnh** | Quản lý cảm xúc xây dựng | Hít thở sâu thay vì cáu gắt |
| **Động lực** | Động lực nội tại vượt ngoài phần thưởng | Theo đuổi mục tiêu phù hợp giá trị |
| **Đồng cảm** | Hiểu cảm xúc người khác | Cảm nhận đồng nghiệp choáng ngợp dù họ không nói |
| **Kỹ năng xã hội** | Quản lý mối quan hệ hiệu quả | Giải quyết xung đột nhóm công bằng |

### Tại Sao EQ Quan Trọng

Nghiên cứu của Goleman (1998) phát hiện EQ **quan trọng gấp đôi** IQ và kỹ năng kỹ thuật cộng lại cho thành tích xuất sắc, đặc biệt trong vai trò lãnh đạo.

> **Phát hiện chính:** Những lãnh đạo thành công nhất không phải thông minh nhất — họ là người xử lý cảm xúc (của mình và người khác) khéo léo nhất.', 1, '{}'),

(31, 'key_points', 'Key Points', 'Điểm chính',
'- **Emotional Intelligence (EQ)** is the ability to recognize, understand, and manage emotions (Goleman, 1995)
- **5 components:** self-awareness, self-regulation, motivation, empathy, social skills
- EQ is **twice as important** as IQ for outstanding performance in leadership (Goleman, 1998)
- **Self-awareness** is the foundation — you cannot manage what you do not recognize
- **Empathy** has two types: cognitive (understanding perspective) and affective (feeling emotions)
- **Affect labeling** — naming your emotions — reduces their intensity (Lieberman et al., 2007)',
'- **Trí tuệ cảm xúc (EQ)** là khả năng nhận biết, hiểu và quản lý cảm xúc (Goleman, 1995)
- **5 thành phần:** tự nhận thức, tự điều chỉnh, động lực, đồng cảm, kỹ năng xã hội
- EQ **quan trọng gấp đôi** IQ cho thành tích xuất sắc trong lãnh đạo (Goleman, 1998)
- **Tự nhận thức** là nền tảng — bạn không thể quản lý điều bạn không nhận ra
- **Đồng cảm** có hai loại: nhận thức (hiểu góc nhìn) và cảm xúc (cảm nhận cảm xúc)
- **Gán nhãn cảm xúc** — gọi tên cảm xúc — giảm cường độ (Lieberman et al., 2007)', 2, '{}'),

(31, 'info_box', 'The Amygdala Hijack', 'Chiếm Quyền Hạch Hạnh Nhân',
'**Why we lose control of our emotions:**

The amygdala is the brain''s "alarm system." When it detects a threat (real or perceived), it triggers a fight-or-flight response **before** your rational brain (prefrontal cortex) can evaluate the situation. Goleman calls this an "amygdala hijack."

**Signs of an amygdala hijack:**
- Sudden, intense emotional reaction
- Feeling "out of control"
- Physical symptoms (racing heart, tight chest)
- Saying or doing something you later regret

**How to prevent it:**
1. **Pause** — Take 6 seconds before responding
2. **Name it** — Label the emotion ("I am feeling frustrated")
3. **Breathe** — Deep breathing activates the parasympathetic nervous system
4. **Reappraise** — Ask "Is this really a threat, or am I overreacting?"',
'**Tại sao ta mất kiểm soát cảm xúc:**

Hạch hạnh nhân là "hệ thống báo động" của não. Khi phát hiện mối đe dọa (thật hoặc nhận thức), nó kích hoạt phản ứng chiến-hoặc-chạy **trước khi** não lý trí (vỏ não trước trán) đánh giá tình huống. Goleman gọi đây là "chiếm quyền hạch hạnh nhân."

**Dấu hiệu bị chiếm quyền hạch hạnh nhân:**
- Phản ứng cảm xúc đột ngột, mãnh liệt
- Cảm giác "mất kiểm soát"
- Triệu chứng thể chất (tim đập nhanh, ngực tức)
- Nói hoặc làm điều sau đó hối hận

**Cách ngăn chặn:**
1. **Dừng lại** — Chờ 6 giây trước khi phản ứng
2. **Gọi tên** — Gán nhãn cảm xúc ("Tôi đang bực bội")
3. **Thở** — Hít thở sâu kích hoạt hệ thần kinh phó giao cảm
4. **Đánh giá lại** — Hỏi "Đây có thật sự là mối đe dọa, hay tôi phản ứng quá?"', 3, '{"variant": "warning"}');

-- Exercise 211: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(31, 'multiple_choice', 'easy', 'How many components does Goleman''s Emotional Intelligence model have?', 'Mô hình Trí tuệ Cảm xúc của Goleman có bao nhiêu thành phần?', 'Daniel Goleman (1995) proposed a model of emotional intelligence with multiple components. How many are there?', 'Daniel Goleman (1995) đề xuất mô hình trí tuệ cảm xúc với nhiều thành phần. Có bao nhiêu thành phần?', 'Goleman''s model has five components: self-awareness, self-regulation, motivation, empathy, and social skills. Each builds on the previous ones, with self-awareness as the foundation.', 'Mô hình Goleman có năm thành phần: tự nhận thức, tự điều chỉnh, động lực, đồng cảm và kỹ năng xã hội. Mỗi thành phần xây dựng trên các thành phần trước, với tự nhận thức là nền tảng.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(211, 'A', '3 components', FALSE, 'Goleman''s model has more than 3 components', 1),
(211, 'B', '5 components', TRUE, 'Correct! The five components are: self-awareness, self-regulation, motivation, empathy, and social skills', 2),
(211, 'C', '7 components', FALSE, 'This overestimates the number — Goleman identified exactly 5 key components', 3),
(211, 'D', '10 components', FALSE, 'Goleman''s model is more focused — it has 5 core components, not 10', 4);

-- Exercise 212: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(31, 'fill_blank', 'medium', 'Fill in the missing component of emotional intelligence.', 'Điền thành phần còn thiếu của trí tuệ cảm xúc.', '___ is the ability to understand and share the feelings of another person, and it is a core component of emotional intelligence.', '___ là khả năng hiểu và chia sẻ cảm xúc của người khác, và nó là thành phần cốt lõi của trí tuệ cảm xúc.', 'Empathy', 'Empathy allows us to connect with others emotionally, understand their perspective, and respond appropriately. Goleman (1995) identified it as one of the five pillars of emotional intelligence.', 'Đồng cảm cho phép chúng ta kết nối cảm xúc với người khác, hiểu góc nhìn của họ và phản ứng phù hợp. Goleman (1995) xác định nó là một trong năm trụ cột của trí tuệ cảm xúc.', 15, 2);

-- Exercise 213: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(31, 'error_correction', 'medium', 'Fix the incorrect statement about emotional intelligence.', 'Sửa phát biểu sai về trí tuệ cảm xúc.', 'Emotional intelligence means suppressing your emotions so they do not affect your decisions.', 'Trí tuệ cảm xúc nghĩa là đè nén cảm xúc để chúng không ảnh hưởng đến quyết định.', 'Emotional intelligence means understanding and managing your emotions so they positively inform your decisions.', 'Emotional intelligence is not about suppressing emotions — that leads to emotional burnout and poor decision-making. True EQ involves recognizing emotions, understanding their causes, and channeling them constructively. Daniel Goleman''s model identifies five components: self-awareness, self-regulation, motivation, empathy, and social skills.', 'Trí tuệ cảm xúc không phải đè nén cảm xúc — điều đó dẫn đến kiệt sức cảm xúc và quyết định kém. EQ thực sự bao gồm nhận biết cảm xúc, hiểu nguyên nhân và điều hướng chúng mang tính xây dựng. Mô hình của Daniel Goleman xác định năm thành phần: tự nhận thức, tự điều chỉnh, động lực, đồng cảm và kỹ năng xã hội.', 'EQ is not about getting rid of emotions — it is about using them wisely.', 'EQ không phải loại bỏ cảm xúc — mà là sử dụng chúng khôn ngoan.', 15, 3);

-- Exercise 214: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(31, 'sentence_transform', 'medium', 'Rewrite this low-EQ response as a high-EQ response.', 'Viết lại phản ứng EQ thấp này thành phản ứng EQ cao.', 'Your idea is terrible and will never work.', 'Ý tưởng của bạn tệ và sẽ không bao giờ hiệu quả.', 'I see a different approach working better. Can we discuss the potential challenges of your idea together?', 'A high-EQ response combines self-regulation (not reacting harshly), empathy (respecting the other person''s effort), and social skills (constructive communication). It addresses the issue without attacking the person.', 'Phản ứng EQ cao kết hợp tự điều chỉnh (không phản ứng gay gắt), đồng cảm (tôn trọng nỗ lực người khác) và kỹ năng xã hội (giao tiếp xây dựng). Nó giải quyết vấn đề mà không tấn công con người.', 15, 4);

-- Exercise 215: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(31, 'arrange_words', 'easy', 'Arrange the steps to handle an amygdala hijack in the correct order.', 'Sắp xếp các bước xử lý chiếm quyền hạch hạnh nhân theo đúng thứ tự.', '["Breathe deeply", "Reappraise the situation", "Pause for 6 seconds", "Name the emotion"]', 'Pause for 6 seconds, Name the emotion, Breathe deeply, Reappraise the situation', 'First pause to interrupt the automatic reaction, then name the emotion to activate your prefrontal cortex, breathe to calm your nervous system, and finally reappraise whether the perceived threat is real.', 'Đầu tiên dừng lại để ngắt phản ứng tự động, sau đó gọi tên cảm xúc để kích hoạt vỏ não trước trán, thở để làm dịu hệ thần kinh, và cuối cùng đánh giá lại liệu mối đe dọa nhận thức có thật không.', 10, 5);

-- Exercise 216: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(31, 'matching', 'easy', 'Match each EQ component to its description.', 'Nối mỗi thành phần EQ với mô tả tương ứng.', 'Goleman''s five EQ components work together: self-awareness and self-regulation are personal competencies, while empathy and social skills are social competencies. Motivation bridges both domains.', 'Năm thành phần EQ của Goleman hoạt động cùng nhau: tự nhận thức và tự điều chỉnh là năng lực cá nhân, trong khi đồng cảm và kỹ năng xã hội là năng lực xã hội. Động lực kết nối cả hai lĩnh vực.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(216, 'Self-awareness', 'Tự nhận thức', 'Recognizing your own emotions', 'Nhận biết cảm xúc của mình', 1),
(216, 'Self-regulation', 'Tự điều chỉnh', 'Managing emotions constructively', 'Quản lý cảm xúc xây dựng', 2),
(216, 'Empathy', 'Đồng cảm', 'Understanding others'' feelings', 'Hiểu cảm xúc người khác', 3),
(216, 'Social skills', 'Kỹ năng xã hội', 'Navigating relationships effectively', 'Điều hướng mối quan hệ hiệu quả', 4);

-- Exercise 217: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(31, 'true_false', 'easy', 'Is this statement about emotional intelligence correct?', 'Phát biểu này về trí tuệ cảm xúc có đúng không?', 'According to Goleman, emotional intelligence (EQ) is a fixed trait that you are born with and cannot improve over time.', 'Theo Goleman, trí tuệ cảm xúc (EQ) là đặc điểm cố định mà bạn sinh ra đã có và không thể cải thiện theo thời gian.', 'false', 'False! Unlike IQ, which is relatively stable, emotional intelligence can be developed and improved throughout life. Goleman (1995) emphasized that EQ skills — self-awareness, empathy, self-regulation — are learnable through practice, feedback, and deliberate effort.', 'Sai! Khác với IQ tương đối ổn định, trí tuệ cảm xúc có thể phát triển và cải thiện suốt đời. Goleman (1995) nhấn mạnh kỹ năng EQ — tự nhận thức, đồng cảm, tự điều chỉnh — có thể học được qua thực hành, phản hồi và nỗ lực có chủ đích.', 5, 7);


-- ############################################################################
-- COMPARISON: Memory & Learning vs Motivation Theory (IDs 28 and 30)
-- ############################################################################

INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(28, 30, 'Core focus', 'Trọng tâm chính', 'HOW we store and retrieve information — the mechanics of memory encoding, consolidation, and recall', 'CÁCH chúng ta lưu trữ và truy xuất thông tin — cơ chế mã hóa, củng cố và nhớ lại trí nhớ', 'WHY we take action — the psychological forces (needs, rewards, flow) that drive behavior', 'TẠI SAO chúng ta hành động — các lực tâm lý (nhu cầu, phần thưởng, dòng chảy) thúc đẩy hành vi', 'Spaced repetition improves recall by 70% (Ebbinghaus)', 'Ôn tập giãn cách cải thiện khả năng nhớ 70% (Ebbinghaus)', 'Intrinsic motivation leads to deeper learning (Deci & Ryan)', 'Động lực nội tại dẫn đến học sâu hơn (Deci & Ryan)', 'Memory tells you HOW to learn effectively; motivation tells you WHY you keep learning. Both are essential for sustained learning success.', 'Trí nhớ cho bạn biết CÁCH học hiệu quả; động lực cho bạn biết TẠI SAO bạn tiếp tục học. Cả hai đều cần thiết cho thành công học tập bền vững.', 1);


-- ############################################################################
-- VERIFICATION QUERIES
-- ############################################################################

-- Verify lesson completeness
SELECT l.id, l.name, l.slug,
  (SELECT COUNT(*) FROM lesson_usage WHERE lesson_id = l.id) AS usages,
  (SELECT COUNT(*) FROM tip WHERE lesson_id = l.id) AS tips,
  (SELECT COUNT(*) FROM lesson_section WHERE lesson_id = l.id) AS sections,
  (SELECT COUNT(*) FROM exercise WHERE lesson_id = l.id) AS exercises
FROM lesson l WHERE l.group_id = 8 ORDER BY l.order_index;
