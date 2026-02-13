-- ============================================================================
-- SEED DATA: Knowledge Learning Application
-- Content: 12 English Grammar Tenses + 3 Learning Methods + 4 Python Basics lessons
-- Compatible with: schema.sql v6 (PostgreSQL 17)
-- ============================================================================


-- ============================================================================
-- CATEGORIES (IDs 1-3)
-- ============================================================================

INSERT INTO category (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('Present', 'Thì Hiện Tại', 'Tenses describing current time, habits, and general truths', 'Các thì diễn tả thời điểm hiện tại, thói quen và sự thật chung', 'AccessTime', '#10b981', 1),
('Past', 'Thì Quá Khứ', 'Tenses describing completed actions and past events', 'Các thì diễn tả hành động đã hoàn thành và sự kiện trong quá khứ', 'History', '#f59e0b', 2),
('Future', 'Thì Tương Lai', 'Tenses describing future events, plans, and predictions', 'Các thì diễn tả sự kiện tương lai, kế hoạch và dự đoán', 'Update', '#6366f1', 3);


-- ============================================================================
-- LESSONS (IDs 1-12)
-- ============================================================================

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(1, 'Simple Present', 'Thì Hiện Tại Đơn', 'simple-present', 'Express habits, facts, and general truths', 'Diễn tả thói quen, sự thật và chân lý chung', 'beginner', 30, 1),
(1, 'Present Continuous', 'Thì Hiện Tại Tiếp Diễn', 'present-continuous', 'Actions happening right now or temporary situations', 'Hành động đang xảy ra hoặc tình huống tạm thời', 'beginner', 30, 2),
(1, 'Present Perfect', 'Thì Hiện Tại Hoàn Thành', 'present-perfect', 'Past actions with present relevance', 'Hành động quá khứ có liên quan đến hiện tại', 'intermediate', 45, 3),
(1, 'Present Perfect Continuous', 'Thì Hiện Tại Hoàn Thành Tiếp Diễn', 'present-perfect-continuous', 'Actions that started in the past and continue to now', 'Hành động bắt đầu trong quá khứ và tiếp tục đến hiện tại', 'intermediate', 45, 4),
(2, 'Simple Past', 'Thì Quá Khứ Đơn', 'simple-past', 'Completed actions at a specific time in the past', 'Hành động đã hoàn thành tại thời điểm cụ thể trong quá khứ', 'beginner', 30, 1),
(2, 'Past Continuous', 'Thì Quá Khứ Tiếp Diễn', 'past-continuous', 'Actions in progress at a specific time in the past', 'Hành động đang diễn ra tại thời điểm trong quá khứ', 'beginner', 35, 2),
(2, 'Past Perfect', 'Thì Quá Khứ Hoàn Thành', 'past-perfect', 'Actions completed before another past action', 'Hành động hoàn thành trước một hành động khác trong quá khứ', 'intermediate', 45, 3),
(2, 'Past Perfect Continuous', 'Thì Quá Khứ Hoàn Thành Tiếp Diễn', 'past-perfect-continuous', 'Duration of actions before another past action', 'Thời lượng của hành động trước một hành động khác trong quá khứ', 'advanced', 50, 4),
(3, 'Simple Future', 'Thì Tương Lai Đơn', 'simple-future', 'Predictions, promises, and spontaneous decisions', 'Dự đoán, lời hứa và quyết định tức thì', 'beginner', 30, 1),
(3, 'Future Continuous', 'Thì Tương Lai Tiếp Diễn', 'future-continuous', 'Actions in progress at a specific future time', 'Hành động đang diễn ra tại thời điểm trong tương lai', 'intermediate', 40, 2),
(3, 'Future Perfect', 'Thì Tương Lai Hoàn Thành', 'future-perfect', 'Actions completed before a future time', 'Hành động sẽ hoàn thành trước một thời điểm trong tương lai', 'intermediate', 45, 3),
(3, 'Future Perfect Continuous', 'Thì Tương Lai Hoàn Thành Tiếp Diễn', 'future-perfect-continuous', 'Duration of actions up to a future point', 'Thời lượng của hành động cho đến một thời điểm trong tương lai', 'advanced', 50, 4);


-- ############################################################################
-- LESSON 1: SIMPLE PRESENT (lesson_id = 1)
-- ############################################################################

-- Formulas (IDs 1-3)
INSERT INTO formula (lesson_id, type, subject_note, structure, structure_vi, example, example_vi, note, order_index) VALUES
(1, 'affirmative', 'I/You/We/They + V | He/She/It + V(s/es)', 'S + V(s/es)', 'Chủ ngữ + Động từ (thêm s/es với ngôi 3 số ít)', 'She works at a hospital.', 'Cô ấy làm việc ở bệnh viện.', 'Thêm -es sau các động từ kết thúc bằng: -o, -s, -x, -z, -ch, -sh (goes, watches, washes)', 1),
(1, 'negative', 'I/You/We/They + do not | He/She/It + does not', 'S + do/does + not + V', 'Chủ ngữ + do/does + not + Động từ nguyên mẫu', 'She does not (doesn''t) work on Sundays.', 'Cô ấy không làm việc vào Chủ nhật.', 'Viết tắt: do not = don''t, does not = doesn''t', 2),
(1, 'interrogative', 'Do + I/you/we/they | Does + he/she/it', 'Do/Does + S + V?', 'Do/Does + Chủ ngữ + Động từ nguyên mẫu?', 'Does she work at a hospital?', 'Cô ấy có làm việc ở bệnh viện không?', 'Trả lời: Yes, she does. / No, she doesn''t.', 3);

-- Usages (IDs 1-5)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(1, 'Habits and routines', 'Thói quen và hoạt động thường ngày', 'Used to describe actions that happen regularly or repeatedly.', 'Dùng để diễn tả các hành động xảy ra thường xuyên hoặc lặp đi lặp lại.', 'Repeat', TRUE, 1),
(1, 'General truths and facts', 'Sự thật chung và chân lý', 'Used to state facts, scientific truths, and things that are generally accepted as true.', 'Dùng để nói về sự thật, chân lý khoa học và những điều được chấp nhận là đúng.', 'Science', TRUE, 2),
(1, 'Permanent situations', 'Tình huống cố định, lâu dài', 'Used to describe situations that are permanent or long-lasting.', 'Dùng để diễn tả tình huống cố định hoặc kéo dài lâu.', 'Home', TRUE, 3),
(1, 'Scheduled events', 'Sự kiện theo lịch trình', 'Used for scheduled or timetabled events, especially with transportation.', 'Dùng cho các sự kiện theo lịch trình, đặc biệt với phương tiện giao thông.', 'Schedule', FALSE, 4),
(1, 'Instructions and directions', 'Hướng dẫn và chỉ đường', 'Used in instructions, recipes, and giving directions.', 'Dùng trong hướng dẫn, công thức nấu ăn và chỉ đường.', 'Directions', FALSE, 5);

-- Examples for usage 1 (IDs 1-3)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(1, 'I wake up at 6 AM every day.', 'Tôi thức dậy lúc 6 giờ sáng mỗi ngày.', '"Every day" indicates this is a regular habit.', '"Every day" cho thấy đây là thói quen thường xuyên.', 'wake up', 1),
(1, 'She always drinks coffee in the morning.', 'Cô ấy luôn uống cà phê vào buổi sáng.', '"Always" emphasizes the habitual nature of the action.', '"Always" nhấn mạnh tính chất thói quen của hành động.', 'always drinks', 2),
(1, 'They go to the gym three times a week.', 'Họ đến phòng gym ba lần một tuần.', 'Frequency expression "three times a week" shows regularity.', 'Cụm từ tần suất "ba lần một tuần" cho thấy tính thường xuyên.', 'go', 3);

-- Examples for usage 2 (IDs 4-6)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(2, 'Water boils at 100 degrees Celsius.', 'Nước sôi ở 100 độ C.', 'Scientific fact - always true regardless of time.', 'Sự thật khoa học - luôn đúng bất kể thời gian.', 'boils', 1),
(2, 'The Earth revolves around the Sun.', 'Trái Đất quay quanh Mặt Trời.', 'Universal truth about our solar system.', 'Chân lý về hệ mặt trời của chúng ta.', 'revolves', 2),
(2, 'Cats are mammals.', 'Mèo là động vật có vú.', 'General classification fact.', 'Sự thật về phân loại chung.', 'are', 3);

-- Signal words (IDs 1-10)
INSERT INTO signal_word (lesson_id, word, word_vi, category, example_sentence, example_vi, position, note, order_index) VALUES
(1, 'always', 'luôn luôn', 'frequency', 'She always arrives on time.', 'Cô ấy luôn đến đúng giờ.', 'middle', 'Đứng trước động từ thường, sau động từ to be', 1),
(1, 'usually', 'thường xuyên', 'frequency', 'I usually have breakfast at 7.', 'Tôi thường ăn sáng lúc 7 giờ.', 'middle', NULL, 2),
(1, 'often', 'thường', 'frequency', 'They often go to the cinema.', 'Họ thường đi xem phim.', 'middle', NULL, 3),
(1, 'sometimes', 'đôi khi', 'frequency', 'Sometimes I work from home.', 'Đôi khi tôi làm việc ở nhà.', 'flexible', 'Có thể đứng đầu câu hoặc giữa câu', 4),
(1, 'rarely', 'hiếm khi', 'frequency', 'He rarely eats fast food.', 'Anh ấy hiếm khi ăn đồ ăn nhanh.', 'middle', NULL, 5),
(1, 'never', 'không bao giờ', 'frequency', 'I never drink alcohol.', 'Tôi không bao giờ uống rượu.', 'middle', 'Không dùng với "not"', 6),
(1, 'every day', 'mỗi ngày', 'time', 'She exercises every day.', 'Cô ấy tập thể dục mỗi ngày.', 'end', NULL, 7),
(1, 'every week/month/year', 'mỗi tuần/tháng/năm', 'time', 'We meet every month.', 'Chúng tôi gặp nhau mỗi tháng.', 'end', NULL, 8),
(1, 'on Mondays', 'vào các ngày thứ Hai', 'time', 'The class is on Mondays.', 'Lớp học vào các ngày thứ Hai.', 'end', 'Số nhiều (Mondays) = mỗi thứ Hai', 9),
(1, 'once/twice a week', 'một/hai lần một tuần', 'frequency', 'I go swimming twice a week.', 'Tôi đi bơi hai lần một tuần.', 'end', NULL, 10);

-- Tips (IDs 1-4)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(1, 'Third person singular rule', 'Quy tắc ngôi thứ 3 số ít', 'Remember: He/She/It always needs -s or -es at the end of the verb. Common mistake: "She work" → "She works"', 'Nhớ: He/She/It luôn cần thêm -s hoặc -es vào cuối động từ. Lỗi thường gặp: "She work" → "She works"', 'common_mistake', 'high', 'Warning', 1),
(1, 'Position of frequency adverbs', 'Vị trí trạng từ tần suất', 'Frequency adverbs (always, usually, often, sometimes, rarely, never) go BEFORE main verbs but AFTER "be": "I always eat" but "I am always happy"', 'Trạng từ tần suất đứng TRƯỚC động từ thường nhưng SAU động từ "be": "I always eat" nhưng "I am always happy"', 'memory', 'high', 'Lightbulb', 2),
(1, 'Don''t confuse with Present Continuous', 'Đừng nhầm với Hiện tại tiếp diễn', 'Simple Present = habits/facts (I drink coffee every morning) vs Present Continuous = happening now (I am drinking coffee now)', 'Hiện tại đơn = thói quen/sự thật (Tôi uống cà phê mỗi sáng) vs Hiện tại tiếp diễn = đang xảy ra (Tôi đang uống cà phê)', 'comparison', 'medium', 'Compare', 3),
(1, 'Spelling rules for -es', 'Quy tắc chính tả thêm -es', 'Add -es (not just -s) after verbs ending in: -o (goes), -s (misses), -x (fixes), -z (buzzes), -ch (watches), -sh (washes)', 'Thêm -es (không chỉ -s) sau động từ kết thúc bằng: -o (goes), -s (misses), -x (fixes), -z (buzzes), -ch (watches), -sh (washes)', 'memory', 'medium', 'Spellcheck', 4);

-- Comparisons (IDs 1-3)
INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(1, 2, 'Time reference', 'Tham chiếu thời gian', 'Describes habits, routines, and permanent situations', 'Diễn tả thói quen, hoạt động thường ngày và tình huống cố định', 'Describes actions happening right now or temporary situations', 'Diễn tả hành động đang xảy ra ngay bây giờ hoặc tình huống tạm thời', 'I work at a bank. (permanent job)', 'Tôi làm việc ở ngân hàng. (công việc cố định)', 'I am working from home today. (temporary)', 'Hôm nay tôi đang làm việc ở nhà. (tạm thời)', 'Ask yourself: Is this a habit/fact OR is it happening right now?', 'Tự hỏi: Đây là thói quen/sự thật HAY đang xảy ra ngay bây giờ?', 1),
(1, 2, 'Signal words', 'Dấu hiệu nhận biết', 'always, usually, often, sometimes, rarely, never, every day', 'always, usually, often, sometimes, rarely, never, every day', 'now, right now, at the moment, currently, today', 'now, right now, at the moment, currently, today', 'I always drink tea.', 'Tôi luôn uống trà.', 'I am drinking tea right now.', 'Tôi đang uống trà ngay bây giờ.', 'Look for time words! "Every day" = Simple Present, "Right now" = Present Continuous', 'Tìm từ chỉ thời gian! "Every day" = Hiện tại đơn, "Right now" = Hiện tại tiếp diễn', 2),
(1, 5, 'Time frame', 'Khung thời gian', 'Present time - habits, facts, permanent situations', 'Thời điểm hiện tại - thói quen, sự thật, tình huống cố định', 'Past time - completed actions at a specific time', 'Thời điểm quá khứ - hành động đã hoàn thành tại thời điểm cụ thể', 'I live in Hanoi.', 'Tôi sống ở Hà Nội.', 'I lived in Hanoi last year.', 'Năm ngoái tôi sống ở Hà Nội.', 'Simple Present = now/always true, Simple Past = finished/specific past time', 'Hiện tại đơn = bây giờ/luôn đúng, Quá khứ đơn = đã xong/thời điểm cụ thể trong quá khứ', 1);

-- Exercises (IDs 1-7)
-- Exercise 1: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(1, 'multiple_choice', 'easy', 'Choose the correct form of the verb.', 'Chọn dạng đúng của động từ.', 'She ___ to school every day.', 'Cô ấy ___ đến trường mỗi ngày.', 'With "she" (third person singular), we add -es to "go" → "goes". "Every day" indicates a habit, so we use Simple Present.', 'Với "she" (ngôi 3 số ít), ta thêm -es vào "go" → "goes". "Every day" chỉ thói quen nên dùng Hiện tại đơn.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(1, 'A', 'go', FALSE, 'Missing -es for third person singular', 1),
(1, 'B', 'goes', TRUE, 'Correct! "Goes" is the third person singular form', 2),
(1, 'C', 'going', FALSE, 'This is the -ing form, used for continuous tenses', 3),
(1, 'D', 'went', FALSE, 'This is past tense, but we need present tense', 4);

-- Exercise 2: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(1, 'fill_blank', 'easy', 'Fill in the blank with the correct form of the verb in brackets.', 'Điền vào chỗ trống với dạng đúng của động từ trong ngoặc.', 'Water ___ (boil) at 100 degrees Celsius.', 'Nước ___ (sôi) ở 100 độ C.', 'boils', 'This is a scientific fact (general truth), so we use Simple Present. "Water" is third person singular, so we add -s.', 'Đây là sự thật khoa học (chân lý chung) nên dùng Hiện tại đơn. "Water" là ngôi 3 số ít nên thêm -s.', 10, 2);

-- Exercise 3: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(1, 'error_correction', 'medium', 'Find and correct the error in this sentence.', 'Tìm và sửa lỗi trong câu sau.', 'He don''t like coffee.', 'Anh ấy don''t thích cà phê.', 'He doesn''t like coffee.', 'With "he" (third person singular), we must use "doesn''t" instead of "don''t".', 'Với "he" (ngôi 3 số ít), ta phải dùng "doesn''t" thay vì "don''t".', 'Check the auxiliary verb with third person singular.', 'Kiểm tra trợ động từ với ngôi 3 số ít.', 15, 3);

-- Exercise 4: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(1, 'sentence_transform', 'medium', 'Change this affirmative sentence into a negative sentence.', 'Chuyển câu khẳng định sau thành câu phủ định.', 'They play football on Saturdays.', 'Họ chơi bóng đá vào các ngày thứ Bảy.', 'They don''t play football on Saturdays.', 'To make negative: add "do not" (don''t) before the main verb. The verb stays in base form.', 'Để tạo câu phủ định: thêm "do not" (don''t) trước động từ chính. Động từ giữ nguyên dạng nguyên mẫu.', 15, 4);

-- Exercise 5: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(1, 'arrange_words', 'easy', 'Arrange the words to make a correct sentence.', 'Sắp xếp các từ để tạo thành câu đúng.', '["usually", "breakfast", "I", "at", "have", "7 AM"]', 'I usually have breakfast at 7 AM.', 'The correct order is: Subject (I) + Frequency adverb (usually) + Verb (have) + Object (breakfast) + Time (at 7 AM).', 'Thứ tự đúng: Chủ ngữ (I) + Trạng từ tần suất (usually) + Động từ (have) + Tân ngữ (breakfast) + Thời gian (at 7 AM).', 10, 5);

-- Exercise 6: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(1, 'matching', 'easy', 'Match the subjects with the correct verb forms.', 'Nối chủ ngữ với dạng động từ đúng.', 'Third person singular (he, she, it) uses verb + s/es. Other subjects use base form.', 'Ngôi 3 số ít (he, she, it) dùng động từ + s/es. Các ngôi khác dùng dạng nguyên mẫu.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(6, 'She', 'Cô ấy', 'works', 'làm việc (có s)', 1),
(6, 'They', 'Họ', 'work', 'làm việc', 2),
(6, 'It', 'Nó', 'rains', 'mưa (có s)', 3),
(6, 'We', 'Chúng tôi', 'play', 'chơi', 4);

-- Exercise 7: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(1, 'true_false', 'easy', 'Is this sentence grammatically correct?', 'Câu này đúng ngữ pháp không?', 'The Sun rises in the east.', 'Mặt trời mọc ở phía đông.', 'true', 'This sentence is correct. It expresses a general truth/fact, using Simple Present. "The Sun" is third person singular, so "rises" (with -s) is correct.', 'Câu này đúng. Nó diễn tả sự thật chung, dùng Hiện tại đơn. "The Sun" là ngôi 3 số ít nên "rises" (có -s) là đúng.', 5, 7);


-- ############################################################################
-- LESSON 2: PRESENT CONTINUOUS (lesson_id = 2)
-- ############################################################################

-- Formulas (IDs 4-6)
INSERT INTO formula (lesson_id, type, subject_note, structure, structure_vi, example, example_vi, note, order_index) VALUES
(2, 'affirmative', 'I + am | He/She/It + is | You/We/They + are', 'S + am/is/are + V-ing', 'Chủ ngữ + am/is/are + Động từ thêm -ing', 'I am studying English now.', 'Tôi đang học tiếng Anh bây giờ.', 'Quy tắc thêm -ing: bỏ -e cuối (make → making), gấp đôi phụ âm cuối (run → running)', 1),
(2, 'negative', NULL, 'S + am/is/are + not + V-ing', 'Chủ ngữ + am/is/are + not + Động từ thêm -ing', 'She is not (isn''t) working today.', 'Cô ấy không làm việc hôm nay.', 'Viết tắt: is not = isn''t, are not = aren''t', 2),
(2, 'interrogative', NULL, 'Am/Is/Are + S + V-ing?', 'Am/Is/Are + Chủ ngữ + Động từ thêm -ing?', 'Are you listening to me?', 'Bạn có đang nghe tôi nói không?', 'Trả lời: Yes, I am. / No, I''m not.', 3);

-- Usages (IDs 6-8)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(2, 'Actions happening now', 'Hành động đang xảy ra', 'Describes actions that are in progress at the moment of speaking.', 'Diễn tả hành động đang diễn ra tại thời điểm nói.', 'PlayArrow', TRUE, 1),
(2, 'Temporary situations', 'Tình huống tạm thời', 'Describes temporary actions or situations that are not permanent.', 'Diễn tả hành động hoặc tình huống tạm thời, không cố định.', 'Timer', TRUE, 2),
(2, 'Annoying habits (with always)', 'Thói quen gây khó chịu (với always)', 'Used with "always" to express irritation about a repeated action.', 'Dùng với "always" để diễn tả sự khó chịu về hành động lặp lại.', 'Warning', FALSE, 3);

-- Examples for usage 6 (IDs 7-8)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(6, 'She is reading a book right now.', 'Cô ấy đang đọc sách ngay bây giờ.', '"Right now" signals an action in progress at this moment.', '"Right now" báo hiệu hành động đang diễn ra tại thời điểm này.', 'is reading', 1),
(6, 'They are playing football in the park.', 'Họ đang chơi bóng đá trong công viên.', 'The action is happening at the time of speaking.', 'Hành động đang xảy ra tại thời điểm nói.', 'are playing', 2);

-- Examples for usage 7 (IDs 9-10)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(7, 'I am staying with my friend this week.', 'Tuần này tôi đang ở với bạn.', '"This week" indicates a temporary arrangement, not permanent.', '"Tuần này" cho thấy sắp xếp tạm thời, không cố định.', 'am staying', 1),
(7, 'He is working at a cafe while his office is renovated.', 'Anh ấy đang làm việc ở quán cafe trong khi văn phòng sửa chữa.', 'Temporary situation — will end when the office is ready.', 'Tình huống tạm thời — sẽ kết thúc khi văn phòng xong.', 'is working', 2);

-- Examples for usage 8 (IDs 11-12)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(8, 'He is always losing his keys!', 'Anh ấy luôn làm mất chìa khóa!', '"Always" + Present Continuous expresses annoyance at a repeated action.', '"Always" + Hiện tại tiếp diễn diễn tả sự khó chịu về hành động lặp lại.', 'is always losing', 1),
(8, 'You are always complaining about the food!', 'Bạn luôn phàn nàn về đồ ăn!', 'Expresses the speaker''s irritation at a habit they find annoying.', 'Diễn tả sự bực bội của người nói về thói quen họ thấy khó chịu.', 'are always complaining', 2);

-- Signal words (IDs 11-16)
INSERT INTO signal_word (lesson_id, word, word_vi, category, example_sentence, example_vi, position, note, order_index) VALUES
(2, 'now', 'bây giờ', 'time', 'I am eating now.', 'Tôi đang ăn bây giờ.', 'end', NULL, 1),
(2, 'right now', 'ngay bây giờ', 'time', 'She is sleeping right now.', 'Cô ấy đang ngủ ngay bây giờ.', 'end', NULL, 2),
(2, 'at the moment', 'vào lúc này', 'time', 'He is studying at the moment.', 'Anh ấy đang học vào lúc này.', 'end', NULL, 3),
(2, 'currently', 'hiện tại', 'time', 'We are currently working on the project.', 'Chúng tôi hiện tại đang làm dự án.', 'middle', NULL, 4),
(2, 'today', 'hôm nay', 'time', 'I am working from home today.', 'Hôm nay tôi đang làm việc ở nhà.', 'end', NULL, 5),
(2, 'Look! / Listen!', 'Nhìn kìa! / Nghe kìa!', 'other', 'Look! The bird is flying!', 'Nhìn kìa! Con chim đang bay!', 'beginning', 'Dùng để thu hút sự chú ý đến hành động đang xảy ra', 6);

-- Tips (IDs 5-7)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(2, 'Non-progressive (stative) verbs', 'Động từ trạng thái', 'Some verbs are NOT used in continuous form: know, believe, want, like, love, hate, need, prefer, understand, belong, own. Say "I know" NOT "I am knowing".', 'Một số động từ KHÔNG dùng ở dạng tiếp diễn: know, believe, want, like, love, hate, need, prefer, understand, belong, own. Nói "I know" KHÔNG PHẢI "I am knowing".', 'common_mistake', 'high', 'Warning', 1),
(2, 'Spelling rules for -ing', 'Quy tắc chính tả thêm -ing', 'Drop silent -e: make → making. Double final consonant after short vowel: run → running, sit → sitting. Keep -ie → -ying: die → dying, lie → lying.', 'Bỏ -e câm: make → making. Gấp đôi phụ âm sau nguyên âm ngắn: run → running, sit → sitting. -ie → -ying: die → dying, lie → lying.', 'memory', 'high', 'Spellcheck', 2),
(2, 'Present Continuous for future plans', 'Hiện tại tiếp diễn cho kế hoạch tương lai', 'Present Continuous can describe arranged future plans: "I am meeting Tom tomorrow." This implies a definite arrangement.', 'Hiện tại tiếp diễn có thể diễn tả kế hoạch tương lai đã sắp xếp: "I am meeting Tom tomorrow." Ngụ ý sắp xếp chắc chắn.', 'native_usage', 'medium', 'Event', 3);

-- Comparison (ID 4)
INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(2, 3, 'Focus', 'Trọng tâm', 'Action in progress right now', 'Hành động đang diễn ra ngay bây giờ', 'Connection between past and present', 'Liên kết giữa quá khứ và hiện tại', 'I am reading this book. (in progress now)', 'Tôi đang đọc cuốn sách này. (đang diễn ra)', 'I have read this book. (finished, relevant now)', 'Tôi đã đọc cuốn sách này. (đã xong, liên quan hiện tại)', 'Continuous = in the middle of doing, Perfect = completed with present relevance', 'Tiếp diễn = đang làm giữa chừng, Hoàn thành = đã xong có liên quan hiện tại', 1);

-- Exercise 8: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(2, 'multiple_choice', 'easy', 'Choose the correct form.', 'Chọn dạng đúng.', 'Look! The children ___ in the garden.', 'Nhìn kìa! Bọn trẻ ___ trong vườn.', '"Look!" signals an action happening right now, so we use Present Continuous.', '"Look!" báo hiệu hành động đang xảy ra nên dùng Hiện tại tiếp diễn.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(8, 'A', 'play', FALSE, 'Simple Present — not for actions happening now', 1),
(8, 'B', 'are playing', TRUE, 'Correct! Present Continuous for actions in progress', 2),
(8, 'C', 'played', FALSE, 'Past tense — "Look!" signals present action', 3),
(8, 'D', 'plays', FALSE, 'Third person singular Simple Present — wrong tense', 4);

-- Exercise 9: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(2, 'fill_blank', 'easy', 'Complete with the correct form of the verb.', 'Hoàn thành với dạng đúng của động từ.', 'She ___ (study) for her exam right now.', 'Cô ấy ___ (học) cho kỳ thi ngay bây giờ.', 'is studying', '"Right now" tells us the action is happening at this moment → Present Continuous. She + is + studying.', '"Right now" cho biết hành động đang xảy ra → Hiện tại tiếp diễn. She + is + studying.', 10, 2);

-- Exercise 10: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(2, 'error_correction', 'medium', 'Find and correct the error.', 'Tìm và sửa lỗi.', 'I am knowing the answer.', 'Tôi am knowing câu trả lời.', 'I know the answer.', '"Know" is a stative verb and cannot be used in continuous form.', '"Know" là động từ trạng thái không dùng được ở dạng tiếp diễn.', 'Is this verb an action or a state?', 'Động từ này là hành động hay trạng thái?', 15, 3);

-- Exercise 11: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(2, 'sentence_transform', 'medium', 'Change to a question.', 'Chuyển thành câu hỏi.', 'They are watching TV.', 'Họ đang xem TV.', 'Are they watching TV?', 'Move "are" before the subject to form a question: Are + they + watching TV?', 'Đưa "are" lên trước chủ ngữ: Are + they + watching TV?', 15, 4);

-- Exercise 12: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(2, 'arrange_words', 'easy', 'Arrange to make a correct sentence.', 'Sắp xếp thành câu đúng.', '["is", "she", "at the moment", "cooking", "dinner"]', 'She is cooking dinner at the moment.', 'Subject (She) + is + V-ing (cooking) + Object (dinner) + Time (at the moment).', 'Chủ ngữ (She) + is + V-ing (cooking) + Tân ngữ (dinner) + Thời gian (at the moment).', 10, 5);

-- Exercise 13: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(2, 'matching', 'easy', 'Match the subjects with the correct "be" form.', 'Nối chủ ngữ với dạng "be" đúng.', 'I → am, He/She/It → is, You/We/They → are.', 'I → am, He/She/It → is, You/We/They → are.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(13, 'I', 'Tôi', 'am working', 'đang làm việc (am)', 1),
(13, 'She', 'Cô ấy', 'is reading', 'đang đọc (is)', 2),
(13, 'They', 'Họ', 'are playing', 'đang chơi (are)', 3),
(13, 'You', 'Bạn', 'are studying', 'đang học (are)', 4);

-- Exercise 14: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(2, 'true_false', 'easy', 'Is this sentence correct?', 'Câu này đúng không?', 'She is wanting a new phone.', 'Cô ấy is wanting một chiếc điện thoại mới.', 'false', '"Want" is a stative verb — it cannot be used in continuous form. Correct: "She wants a new phone."', '"Want" là động từ trạng thái — không dùng dạng tiếp diễn. Đúng: "She wants a new phone."', 5, 7);


-- ############################################################################
-- LESSON 3: PRESENT PERFECT (lesson_id = 3)
-- ############################################################################

-- Formulas (IDs 7-9)
INSERT INTO formula (lesson_id, type, subject_note, structure, structure_vi, example, example_vi, note, order_index) VALUES
(3, 'affirmative', 'I/You/We/They + have | He/She/It + has', 'S + have/has + V3 (past participle)', 'Chủ ngữ + have/has + Động từ quá khứ phân từ', 'She has visited Paris twice.', 'Cô ấy đã đến Paris hai lần.', 'V3: regular = V-ed (visited), irregular = riêng (gone, seen, eaten)', 1),
(3, 'negative', NULL, 'S + have/has + not + V3', 'Chủ ngữ + have/has + not + Động từ quá khứ phân từ', 'I have not (haven''t) finished yet.', 'Tôi chưa hoàn thành.', 'Viết tắt: have not = haven''t, has not = hasn''t', 2),
(3, 'interrogative', NULL, 'Have/Has + S + V3?', 'Have/Has + Chủ ngữ + Động từ quá khứ phân từ?', 'Have you ever been to Japan?', 'Bạn đã bao giờ đến Nhật chưa?', 'Trả lời: Yes, I have. / No, I haven''t.', 3);

-- Usages (IDs 9-11)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(3, 'Life experiences', 'Trải nghiệm cuộc sống', 'Used to talk about experiences at an unspecified time, often with ever/never.', 'Dùng để nói về trải nghiệm tại thời điểm không xác định, thường với ever/never.', 'Explore', TRUE, 1),
(3, 'Recently completed actions', 'Hành động vừa hoàn thành', 'Used for actions that just happened, often with just, already, yet.', 'Dùng cho hành động vừa xảy ra, thường với just, already, yet.', 'CheckCircle', TRUE, 2),
(3, 'Unfinished time period', 'Khoảng thời gian chưa kết thúc', 'Used for actions in a time period that is not yet finished (today, this week, this year).', 'Dùng cho hành động trong khoảng thời gian chưa kết thúc (hôm nay, tuần này, năm nay).', 'DateRange', TRUE, 3);

-- Examples for usage 9 (IDs 13-14)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(9, 'I have visited London three times.', 'Tôi đã đến London ba lần.', 'Experience — the exact time is not specified.', 'Trải nghiệm — thời điểm chính xác không được nêu.', 'have visited', 1),
(9, 'She has never eaten sushi.', 'Cô ấy chưa bao giờ ăn sushi.', '"Never" emphasizes the lack of this experience in her entire life.', '"Never" nhấn mạnh chưa có trải nghiệm này trong đời.', 'has never eaten', 2);

-- Examples for usage 10 (IDs 15-16)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(10, 'I have just finished my homework.', 'Tôi vừa hoàn thành bài tập.', '"Just" indicates the action was completed very recently.', '"Just" cho biết hành động vừa hoàn thành rất gần đây.', 'have just finished', 1),
(10, 'He has already left the office.', 'Anh ấy đã rời văn phòng rồi.', '"Already" emphasizes the action is done, perhaps sooner than expected.', '"Already" nhấn mạnh hành động đã xong, có thể sớm hơn dự kiến.', 'has already left', 2);

-- Examples for usage 11 (IDs 17-18)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(11, 'I have had three meetings today.', 'Hôm nay tôi đã có ba cuộc họp.', '"Today" is not finished yet, so we use Present Perfect.', '"Hôm nay" chưa kết thúc nên dùng Hiện tại hoàn thành.', 'have had', 1),
(11, 'She has written two reports this week.', 'Tuần này cô ấy đã viết hai báo cáo.', '"This week" is still ongoing — use Present Perfect.', '"Tuần này" vẫn đang tiếp diễn — dùng Hiện tại hoàn thành.', 'has written', 2);

-- Signal words (IDs 17-22)
INSERT INTO signal_word (lesson_id, word, word_vi, category, example_sentence, example_vi, position, note, order_index) VALUES
(3, 'ever', 'đã bao giờ', 'frequency', 'Have you ever been to Paris?', 'Bạn đã bao giờ đến Paris chưa?', 'middle', 'Chỉ dùng trong câu hỏi và phủ định', 1),
(3, 'never', 'chưa bao giờ', 'frequency', 'I have never seen snow.', 'Tôi chưa bao giờ thấy tuyết.', 'middle', 'Mang nghĩa phủ định, không dùng với not', 2),
(3, 'already', 'đã rồi', 'time', 'She has already eaten lunch.', 'Cô ấy đã ăn trưa rồi.', 'middle', 'Đứng giữa have/has và V3', 3),
(3, 'yet', 'chưa', 'time', 'I haven''t finished yet.', 'Tôi chưa hoàn thành.', 'end', 'Dùng trong câu phủ định và câu hỏi, đứng cuối câu', 4),
(3, 'just', 'vừa mới', 'time', 'He has just arrived.', 'Anh ấy vừa đến.', 'middle', 'Đứng giữa have/has và V3', 5),
(3, 'since/for', 'từ khi/trong', 'duration', 'I have lived here since 2010 / for 5 years.', 'Tôi đã sống ở đây từ 2010 / được 5 năm.', 'end', 'since + mốc thời gian, for + khoảng thời gian', 6);

-- Tips (IDs 8-10)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(3, 'Since vs For', 'Since vs For', '"Since" marks a starting point (since 2010, since Monday). "For" marks a duration (for 5 years, for two hours). Common mistake: "since 5 years" → "for 5 years".', '"Since" đánh dấu mốc thời gian (since 2010, since Monday). "For" đánh dấu khoảng thời gian (for 5 years, for two hours). Lỗi thường: "since 5 years" → "for 5 years".', 'common_mistake', 'high', 'Warning', 1),
(3, 'Gone vs Been', 'Gone vs Been', '"He has gone to Paris" = He is in Paris now (not here). "He has been to Paris" = He visited Paris before (experience, he''s back now).', '"He has gone to Paris" = Anh ấy đang ở Paris (không ở đây). "He has been to Paris" = Anh ấy đã từng đến Paris (trải nghiệm, đã về).', 'common_mistake', 'high', 'Compare', 2),
(3, 'Never use with specific past time', 'Không dùng với thời gian cụ thể quá khứ', 'WRONG: "I have seen him yesterday." RIGHT: "I saw him yesterday." Use Simple Past with specific past times (yesterday, last week, in 2020).', 'SAI: "I have seen him yesterday." ĐÚNG: "I saw him yesterday." Dùng Quá khứ đơn với thời gian cụ thể (yesterday, last week, in 2020).', 'common_mistake', 'high', 'Warning', 3);

-- Comparison (ID 5)
INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(3, 5, 'Time specificity', 'Tính cụ thể của thời gian', 'Unspecified time — focus on the result or experience', 'Thời gian không xác định — tập trung vào kết quả hoặc trải nghiệm', 'Specific time in the past — focus on when it happened', 'Thời gian cụ thể trong quá khứ — tập trung vào khi nào xảy ra', 'I have lost my keys. (result: I can''t find them now)', 'Tôi đã mất chìa khóa. (kết quả: giờ không tìm được)', 'I lost my keys yesterday. (specific time)', 'Tôi mất chìa khóa hôm qua. (thời gian cụ thể)', 'No time word = Present Perfect. Specific past time = Simple Past.', 'Không có từ chỉ thời gian = HTHT. Thời gian cụ thể quá khứ = QKĐ.', 1);

-- Exercise 15: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(3, 'multiple_choice', 'easy', 'Choose the correct form.', 'Chọn dạng đúng.', 'She ___ to Japan three times.', 'Cô ấy ___ Nhật ba lần.', '"Three times" describes life experience with no specific time → Present Perfect with "has" (she).', '"Ba lần" mô tả trải nghiệm không có thời gian cụ thể → Hiện tại hoàn thành với "has" (she).', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(15, 'A', 'has been', TRUE, 'Correct! Present Perfect for unspecified past experience', 1),
(15, 'B', 'have been', FALSE, '"She" needs "has" not "have"', 2),
(15, 'C', 'was', FALSE, 'Simple Past — needs specific time', 3),
(15, 'D', 'is being', FALSE, 'Present Continuous — wrong meaning', 4);

-- Exercise 16: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(3, 'fill_blank', 'easy', 'Complete with have/has + past participle.', 'Hoàn thành với have/has + quá khứ phân từ.', 'I ___ (not/finish) my homework yet.', 'Tôi ___ (chưa/hoàn thành) bài tập.', 'haven''t finished', '"Yet" in negative sentence → haven''t + V3. "I" uses "have".', '"Yet" trong câu phủ định → haven''t + V3. "I" dùng "have".', 10, 2);

-- Exercise 17: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(3, 'error_correction', 'medium', 'Find and correct the error.', 'Tìm và sửa lỗi.', 'I have saw that movie before.', 'Tôi have saw bộ phim đó trước đây.', 'I have seen that movie before.', '"Saw" is the past simple form. After have/has, use the past participle: see → seen.', '"Saw" là dạng quá khứ đơn. Sau have/has, dùng quá khứ phân từ: see → seen.', 'Check the verb form after "have".', 'Kiểm tra dạng động từ sau "have".', 15, 3);

-- Exercise 18: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(3, 'sentence_transform', 'medium', 'Change to a negative sentence.', 'Chuyển thành câu phủ định.', 'He has finished the project.', 'Anh ấy đã hoàn thành dự án.', 'He hasn''t finished the project.', 'Add "not" between has/have and V3: has + not + finished = hasn''t finished.', 'Thêm "not" giữa has/have và V3: has + not + finished = hasn''t finished.', 15, 4);

-- Exercise 19: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(3, 'arrange_words', 'easy', 'Arrange to make a correct sentence.', 'Sắp xếp thành câu đúng.', '["have", "I", "never", "tried", "sushi"]', 'I have never tried sushi.', 'S (I) + have + never + V3 (tried) + Object (sushi).', 'S (I) + have + never + V3 (tried) + Tân ngữ (sushi).', 10, 5);

-- Exercise 20: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(3, 'matching', 'easy', 'Match the signal words with their usage.', 'Nối từ tín hiệu với cách dùng.', 'Each signal word has a specific position and meaning in Present Perfect sentences.', 'Mỗi từ tín hiệu có vị trí và ý nghĩa cụ thể trong câu Hiện tại hoàn thành.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(20, 'just', 'vừa mới', 'recently completed action', 'hành động vừa hoàn thành', 1),
(20, 'already', 'đã rồi', 'sooner than expected', 'sớm hơn dự kiến', 2),
(20, 'yet', 'chưa', 'negative/question — end of sentence', 'phủ định/câu hỏi — cuối câu', 3),
(20, 'never', 'chưa bao giờ', 'no experience at all', 'chưa có trải nghiệm', 4);

-- Exercise 21: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(3, 'true_false', 'easy', 'Is this sentence correct?', 'Câu này đúng không?', 'I have been to France last summer.', 'Tôi have been to Pháp mùa hè năm ngoái.', 'false', '"Last summer" is a specific past time — use Simple Past: "I went to France last summer." Present Perfect cannot be used with specific past time.', '"Mùa hè năm ngoái" là thời gian cụ thể — dùng Quá khứ đơn: "I went to France last summer." Hiện tại hoàn thành không dùng với thời gian cụ thể.', 5, 7);


-- ############################################################################
-- LESSON 4: PRESENT PERFECT CONTINUOUS (lesson_id = 4)
-- ############################################################################

-- Formulas (IDs 10-12)
INSERT INTO formula (lesson_id, type, subject_note, structure, structure_vi, example, example_vi, note, order_index) VALUES
(4, 'affirmative', 'I/You/We/They + have been | He/She/It + has been', 'S + have/has + been + V-ing', 'Chủ ngữ + have/has + been + V-ing', 'I have been studying for two hours.', 'Tôi đã học được hai tiếng rồi.', 'Nhấn mạnh quá trình và thời gian kéo dài', 1),
(4, 'negative', NULL, 'S + have/has + not + been + V-ing', 'Chủ ngữ + have/has + not + been + V-ing', 'She has not (hasn''t) been sleeping well.', 'Cô ấy ngủ không ngon.', 'Viết tắt: have not been = haven''t been', 2),
(4, 'interrogative', NULL, 'Have/Has + S + been + V-ing?', 'Have/Has + Chủ ngữ + been + V-ing?', 'How long have you been waiting?', 'Bạn đã đợi bao lâu rồi?', 'Thường dùng với How long...?', 3);

-- Usages (IDs 12-14)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(4, 'Duration of ongoing actions', 'Thời lượng hành động đang tiếp diễn', 'Emphasizes how long an action has been in progress, often with for/since.', 'Nhấn mạnh hành động đã kéo dài bao lâu, thường dùng với for/since.', 'HourglassEmpty', TRUE, 1),
(4, 'Recently stopped actions with visible results', 'Hành động vừa dừng có kết quả nhìn thấy', 'Actions that recently stopped but their effects are visible now.', 'Hành động vừa dừng nhưng kết quả vẫn nhìn thấy được.', 'Visibility', TRUE, 2),
(4, 'Emphasis on process and duration', 'Nhấn mạnh quá trình và thời lượng', 'Stresses the ongoing process rather than the completed result.', 'Nhấn mạnh quá trình đang diễn ra hơn là kết quả hoàn thành.', 'Loop', TRUE, 3);

-- Examples for usage 12 (IDs 19-20)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(12, 'I have been learning English for five years.', 'Tôi đã học tiếng Anh được năm năm.', '"For five years" emphasizes the duration of the ongoing activity.', '"Năm năm" nhấn mạnh thời lượng của hoạt động đang tiếp diễn.', 'have been learning', 1),
(12, 'She has been working here since 2019.', 'Cô ấy đã làm việc ở đây từ 2019.', '"Since 2019" marks the starting point; the action is still continuing.', '"Từ 2019" đánh dấu mốc bắt đầu; hành động vẫn tiếp tục.', 'has been working', 2);

-- Examples for usage 13 (IDs 21-22)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(13, 'He is tired because he has been running.', 'Anh ấy mệt vì đã chạy bộ.', 'The running recently stopped, but the tiredness (result) is visible now.', 'Việc chạy vừa dừng, nhưng sự mệt mỏi (kết quả) vẫn thấy rõ.', 'has been running', 1),
(13, 'The ground is wet. It has been raining.', 'Mặt đất ướt. Trời đã mưa.', 'Rain stopped recently; wet ground is the visible evidence.', 'Mưa vừa tạnh; đất ướt là bằng chứng nhìn thấy.', 'has been raining', 2);

-- Examples for usage 14 (IDs 23-24)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(14, 'I have been reading this book all week.', 'Tôi đã đọc cuốn sách này cả tuần.', 'Emphasizes the ongoing process — not finished yet.', 'Nhấn mạnh quá trình đang diễn ra — chưa xong.', 'have been reading', 1),
(14, 'They have been building the bridge for two years.', 'Họ đã xây cầu được hai năm rồi.', 'Focus on the long duration of the construction process.', 'Tập trung vào thời gian dài của quá trình xây dựng.', 'have been building', 2);

-- Signal words (IDs 23-28)
INSERT INTO signal_word (lesson_id, word, word_vi, category, example_sentence, example_vi, position, note, order_index) VALUES
(4, 'for', 'trong (khoảng)', 'duration', 'I have been waiting for 30 minutes.', 'Tôi đã đợi 30 phút.', 'end', 'for + khoảng thời gian', 1),
(4, 'since', 'từ khi', 'duration', 'She has been sleeping since 10 PM.', 'Cô ấy đã ngủ từ 10 giờ tối.', 'end', 'since + mốc thời gian', 2),
(4, 'all day/morning/week', 'cả ngày/sáng/tuần', 'duration', 'He has been studying all day.', 'Anh ấy đã học cả ngày.', 'end', NULL, 3),
(4, 'how long', 'bao lâu', 'duration', 'How long have you been living here?', 'Bạn đã sống ở đây bao lâu?', 'beginning', 'Dùng trong câu hỏi', 4),
(4, 'recently', 'gần đây', 'time', 'I have been feeling tired recently.', 'Gần đây tôi thấy mệt mỏi.', 'end', NULL, 5),
(4, 'lately', 'dạo gần đây', 'time', 'Have you been exercising lately?', 'Dạo gần đây bạn có tập thể dục không?', 'end', NULL, 6);

-- Tips (IDs 11-13)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(4, 'PPC vs Present Perfect', 'HTHTTD vs HTHT', 'Present Perfect Continuous = emphasis on DURATION (I have been reading for 2 hours). Present Perfect = emphasis on RESULT (I have read 3 chapters).', 'HTHTTD = nhấn mạnh THỜI LƯỢNG (Tôi đã đọc 2 tiếng). HTHT = nhấn mạnh KẾT QUẢ (Tôi đã đọc 3 chương).', 'comparison', 'high', 'Compare', 1),
(4, 'Stative verbs exception', 'Ngoại lệ động từ trạng thái', 'Stative verbs (know, want, believe) cannot be used in PPC. Use Present Perfect instead: "I have known him for years" NOT "I have been knowing him."', 'Động từ trạng thái (know, want, believe) không dùng PPC. Dùng HTHT: "I have known him for years" KHÔNG PHẢI "I have been knowing him."', 'common_mistake', 'high', 'Warning', 2),
(4, 'Often interchangeable with PP', 'Thường dùng thay thế với HTHT', 'With "live", "work", "study" + for/since, both PP and PPC are correct: "I have lived here for 5 years" = "I have been living here for 5 years."', 'Với "live", "work", "study" + for/since, cả HTHT và HTHTTD đều đúng: "I have lived here for 5 years" = "I have been living here for 5 years."', 'native_usage', 'medium', 'Lightbulb', 3);

-- Comparison (ID 6)
INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(3, 4, 'Duration vs Result', 'Thời lượng vs Kết quả', 'Emphasizes the completed result or number', 'Nhấn mạnh kết quả hoàn thành hoặc số lượng', 'Emphasizes the duration and ongoing process', 'Nhấn mạnh thời lượng và quá trình đang diễn ra', 'I have read this book. (finished, focus on completion)', 'Tôi đã đọc xong cuốn sách này. (đã xong, tập trung hoàn thành)', 'I have been reading this book. (still reading, focus on process)', 'Tôi đang đọc cuốn sách này. (vẫn đọc, tập trung quá trình)', 'Duration/process? → PPC. Result/number? → PP.', 'Thời lượng/quá trình? → HTHTTD. Kết quả/số lượng? → HTHT.', 1);

-- Exercise 22: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(4, 'multiple_choice', 'easy', 'Choose the correct form.', 'Chọn dạng đúng.', 'She ___ all morning. She looks exhausted.', 'Cô ấy ___ cả buổi sáng. Trông cô ấy kiệt sức.', '"All morning" + visible result (exhausted) → Present Perfect Continuous emphasizes duration.', '"Cả buổi sáng" + kết quả nhìn thấy (kiệt sức) → HTHTTD nhấn mạnh thời lượng.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(22, 'A', 'has been working', TRUE, 'Correct! Duration emphasis + visible result = PPC', 1),
(22, 'B', 'has worked', FALSE, 'Present Perfect — focuses on result, not duration', 2),
(22, 'C', 'is working', FALSE, 'Present Continuous — no duration emphasis', 3),
(22, 'D', 'works', FALSE, 'Simple Present — describes habits, not duration', 4);

-- Exercise 23: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(4, 'fill_blank', 'easy', 'Complete with the correct form.', 'Hoàn thành với dạng đúng.', 'How long ___ you ___ (wait) here?', 'Bạn đã ___ (đợi) ở đây bao lâu?', 'have you been waiting', '"How long" asks about duration → PPC. Question form: Have + S + been + V-ing.', '"How long" hỏi về thời lượng → HTHTTD. Dạng câu hỏi: Have + S + been + V-ing.', 10, 2);

-- Exercise 24: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(4, 'error_correction', 'medium', 'Find and correct the error.', 'Tìm và sửa lỗi.', 'I have been knowing him for ten years.', 'Tôi have been knowing anh ấy mười năm.', 'I have known him for ten years.', '"Know" is a stative verb — cannot use continuous form. Use Present Perfect: have known.', '"Know" là động từ trạng thái — không dùng dạng tiếp diễn. Dùng HTHT: have known.', 'Is this an action verb or a state verb?', 'Đây là động từ hành động hay trạng thái?', 15, 3);

-- Exercise 25: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(4, 'sentence_transform', 'medium', 'Change to a question with "How long".', 'Chuyển thành câu hỏi với "How long".', 'They have been living in London for three years.', 'Họ đã sống ở London được ba năm.', 'How long have they been living in London?', 'How long + have + S + been + V-ing + ...? Remove the duration (for three years) since "How long" asks about it.', 'How long + have + S + been + V-ing + ...? Bỏ phần thời lượng (for three years) vì "How long" đã hỏi.', 15, 4);

-- Exercise 26: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(4, 'arrange_words', 'easy', 'Arrange to make a correct sentence.', 'Sắp xếp thành câu đúng.', '["been", "has", "it", "raining", "all day"]', 'It has been raining all day.', 'S (It) + has + been + V-ing (raining) + Duration (all day).', 'S (It) + has + been + V-ing (raining) + Thời lượng (all day).', 10, 5);

-- Exercise 27: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(4, 'matching', 'medium', 'Match the sentence halves.', 'Nối hai nửa câu.', 'Present Perfect Continuous sentences with appropriate time expressions.', 'Câu Hiện tại hoàn thành tiếp diễn với cụm thời gian phù hợp.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(27, 'I have been studying', 'Tôi đã học', 'since 8 AM', 'từ 8 giờ sáng', 1),
(27, 'She has been cooking', 'Cô ấy đã nấu ăn', 'for two hours', 'được hai tiếng', 2),
(27, 'They have been traveling', 'Họ đã đi du lịch', 'all week', 'cả tuần', 3),
(27, 'It has been snowing', 'Tuyết đã rơi', 'since yesterday', 'từ hôm qua', 4);

-- Exercise 28: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(4, 'true_false', 'easy', 'Is this sentence correct?', 'Câu này đúng không?', 'He has been working here for five years.', 'Anh ấy đã làm việc ở đây được năm năm.', 'true', 'This is correct. "For five years" indicates duration, and "work" is an action verb that can be used in continuous form.', 'Câu này đúng. "Năm năm" chỉ thời lượng, và "work" là động từ hành động có thể dùng dạng tiếp diễn.', 5, 7);


-- ############################################################################
-- LESSON 5: SIMPLE PAST (lesson_id = 5)
-- ############################################################################

-- Formulas (IDs 13-15)
INSERT INTO formula (lesson_id, type, subject_note, structure, structure_vi, example, example_vi, note, order_index) VALUES
(5, 'affirmative', 'All subjects + V2 (past form)', 'S + V2 (past form)', 'Chủ ngữ + Động từ quá khứ', 'She worked late yesterday.', 'Cô ấy làm việc muộn hôm qua.', 'Regular: V + ed (worked). Irregular: riêng (went, saw, ate)', 1),
(5, 'negative', 'All subjects + did not', 'S + did not (didn''t) + V', 'Chủ ngữ + did not + Động từ nguyên mẫu', 'She didn''t work yesterday.', 'Cô ấy không làm việc hôm qua.', 'Sau did not, động từ trở về dạng nguyên mẫu', 2),
(5, 'interrogative', 'Did + all subjects', 'Did + S + V?', 'Did + Chủ ngữ + Động từ nguyên mẫu?', 'Did she work yesterday?', 'Cô ấy có làm việc hôm qua không?', 'Trả lời: Yes, she did. / No, she didn''t.', 3);

-- Usages (IDs 15-17)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(5, 'Completed actions at specific time', 'Hành động hoàn thành tại thời điểm cụ thể', 'Describes actions that started and finished at a definite time in the past.', 'Diễn tả hành động đã bắt đầu và kết thúc tại thời điểm xác định trong quá khứ.', 'Event', TRUE, 1),
(5, 'Sequence of past events', 'Chuỗi sự kiện quá khứ', 'Describes a series of completed actions in order.', 'Diễn tả một chuỗi hành động hoàn thành theo thứ tự.', 'FormatListNumbered', TRUE, 2),
(5, 'Past habits and states', 'Thói quen và trạng thái quá khứ', 'Describes habits or states that were true in the past but not anymore.', 'Diễn tả thói quen hoặc trạng thái đúng trong quá khứ nhưng không còn nữa.', 'History', TRUE, 3);

-- Examples for usage 15 (IDs 25-26)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(15, 'I visited my grandmother last weekend.', 'Tôi đã thăm bà ngoại cuối tuần trước.', '"Last weekend" specifies when the completed action happened.', '"Cuối tuần trước" xác định khi nào hành động xảy ra.', 'visited', 1),
(15, 'They bought a new car in January.', 'Họ mua xe mới vào tháng Giêng.', '"In January" is a specific past time.', '"Vào tháng Giêng" là thời gian cụ thể quá khứ.', 'bought', 2);

-- Examples for usage 16 (IDs 27-28)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(16, 'I woke up, had breakfast, and went to work.', 'Tôi thức dậy, ăn sáng rồi đi làm.', 'Three completed actions in sequence — all Simple Past.', 'Ba hành động hoàn thành theo thứ tự — đều dùng Quá khứ đơn.', 'woke, had, went', 1),
(16, 'She entered the room and sat down.', 'Cô ấy bước vào phòng và ngồi xuống.', 'Two actions happened one after another in the past.', 'Hai hành động xảy ra liên tiếp trong quá khứ.', 'entered, sat', 2);

-- Examples for usage 17 (IDs 29-30)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(17, 'When I was young, I played football every day.', 'Khi tôi còn nhỏ, tôi chơi bóng đá mỗi ngày.', '"When I was young" establishes a past time frame for this former habit.', '"Khi tôi còn nhỏ" thiết lập khung thời gian quá khứ cho thói quen cũ.', 'played', 1),
(17, 'She lived in Paris for ten years.', 'Cô ấy đã sống ở Paris mười năm.', 'Past state that is now finished — she no longer lives there.', 'Trạng thái quá khứ đã kết thúc — cô ấy không còn sống ở đó.', 'lived', 2);

-- Signal words (IDs 29-34)
INSERT INTO signal_word (lesson_id, word, word_vi, category, example_sentence, example_vi, position, note, order_index) VALUES
(5, 'yesterday', 'hôm qua', 'time', 'I saw her yesterday.', 'Tôi gặp cô ấy hôm qua.', 'end', NULL, 1),
(5, 'last week/month/year', 'tuần/tháng/năm trước', 'time', 'We traveled to Japan last year.', 'Năm ngoái chúng tôi đi Nhật.', 'end', NULL, 2),
(5, 'ago', 'trước (đây)', 'time', 'She left two hours ago.', 'Cô ấy rời đi hai tiếng trước.', 'end', 'Luôn đứng sau khoảng thời gian: 2 days ago', 3),
(5, 'in 2020', 'vào năm 2020', 'time', 'He graduated in 2020.', 'Anh ấy tốt nghiệp năm 2020.', 'end', NULL, 4),
(5, 'when', 'khi', 'sequence', 'When I arrived, she had already left.', 'Khi tôi đến, cô ấy đã đi rồi.', 'beginning', 'Thường mở đầu mệnh đề thời gian', 5),
(5, 'then/after that', 'sau đó', 'sequence', 'I ate dinner, then I watched TV.', 'Tôi ăn tối, sau đó xem TV.', 'middle', NULL, 6);

-- Tips (IDs 14-16)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(5, 'Regular vs Irregular verbs', 'Động từ có quy tắc vs bất quy tắc', 'Regular: add -ed (worked, played, visited). Irregular: must memorize (go→went, see→saw, eat→ate, buy→bought, take→took).', 'Có quy tắc: thêm -ed (worked, played, visited). Bất quy tắc: phải học thuộc (go→went, see→saw, eat→ate, buy→bought, take→took).', 'memory', 'high', 'Lightbulb', 1),
(5, '-ed pronunciation', 'Cách phát âm -ed', 'Three sounds: /t/ after voiceless (worked, stopped), /d/ after voiced (played, called), /ɪd/ after t/d (wanted, needed).', 'Ba cách phát âm: /t/ sau âm vô thanh (worked, stopped), /d/ sau âm hữu thanh (played, called), /ɪd/ sau t/d (wanted, needed).', 'memory', 'medium', 'VolumeUp', 2),
(5, 'Did + base form', 'Did + dạng nguyên mẫu', 'In negatives and questions, use "did" + base verb. WRONG: "Did you went?" RIGHT: "Did you go?" The past form is carried by "did".', 'Trong câu phủ định và câu hỏi, dùng "did" + nguyên mẫu. SAI: "Did you went?" ĐÚNG: "Did you go?" Dạng quá khứ do "did" mang.', 'common_mistake', 'high', 'Warning', 3);

-- Comparison (ID 7)
INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(5, 6, 'Completed vs In Progress', 'Hoàn thành vs Đang diễn ra', 'Short, completed action in the past', 'Hành động ngắn, hoàn thành trong quá khứ', 'Longer action in progress when interrupted', 'Hành động dài đang diễn ra khi bị ngắt', 'I read a book yesterday. (finished)', 'Tôi đọc sách hôm qua. (đã xong)', 'I was reading when the phone rang. (in progress)', 'Tôi đang đọc thì điện thoại reo. (đang diễn ra)', 'Completed action = Simple Past. Background/interrupted action = Past Continuous.', 'Hành động hoàn thành = QKĐ. Hành động nền/bị ngắt = QKTD.', 1);

-- Exercise 29: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(5, 'multiple_choice', 'easy', 'Choose the correct past form.', 'Chọn dạng quá khứ đúng.', 'She ___ to the store yesterday.', 'Cô ấy ___ đến cửa hàng hôm qua.', '"Yesterday" signals a specific past time → Simple Past. Go → went (irregular).', '"Yesterday" báo hiệu thời gian quá khứ cụ thể → Quá khứ đơn. Go → went (bất quy tắc).', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(29, 'A', 'goes', FALSE, 'Simple Present form — wrong tense', 1),
(29, 'B', 'went', TRUE, 'Correct! "Went" is the past form of "go"', 2),
(29, 'C', 'has gone', FALSE, 'Present Perfect — not with "yesterday"', 3),
(29, 'D', 'was going', FALSE, 'Past Continuous — not a completed action here', 4);

-- Exercise 30: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(5, 'fill_blank', 'easy', 'Write the past form of the verb.', 'Viết dạng quá khứ của động từ.', 'They ___ (eat) dinner at 7 PM last night.', 'Họ ___ (ăn) tối lúc 7 giờ tối qua.', 'ate', '"Last night" = specific past time → Simple Past. Eat → ate (irregular verb).', '"Tối qua" = thời gian cụ thể → Quá khứ đơn. Eat → ate (bất quy tắc).', 10, 2);

-- Exercise 31: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(5, 'error_correction', 'medium', 'Find and correct the error.', 'Tìm và sửa lỗi.', 'Did you went to the party?', 'Did you went đến bữa tiệc?', 'Did you go to the party?', 'After "did" in questions, use the base form of the verb: go, NOT went.', 'Sau "did" trong câu hỏi, dùng nguyên mẫu: go, KHÔNG PHẢI went.', 'Check the verb form after "did".', 'Kiểm tra dạng động từ sau "did".', 15, 3);

-- Exercise 32: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(5, 'sentence_transform', 'medium', 'Change to a negative sentence.', 'Chuyển thành câu phủ định.', 'He played tennis last Saturday.', 'Anh ấy chơi tennis thứ Bảy trước.', 'He didn''t play tennis last Saturday.', 'Negative: S + didn''t + base verb. "Played" becomes "didn''t play" (base form).', 'Phủ định: S + didn''t + nguyên mẫu. "Played" thành "didn''t play" (dạng nguyên mẫu).', 15, 4);

-- Exercise 33: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(5, 'arrange_words', 'easy', 'Arrange to make a correct sentence.', 'Sắp xếp thành câu đúng.', '["bought", "she", "a", "new dress", "last week"]', 'She bought a new dress last week.', 'S (She) + V2 (bought) + Object (a new dress) + Time (last week).', 'S (She) + V2 (bought) + Tân ngữ (a new dress) + Thời gian (last week).', 10, 5);

-- Exercise 34: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(5, 'matching', 'easy', 'Match the base form with its past form.', 'Nối dạng nguyên mẫu với dạng quá khứ.', 'These are common irregular verbs you need to memorize.', 'Đây là các động từ bất quy tắc phổ biến cần học thuộc.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(34, 'go', 'đi', 'went', 'đã đi', 1),
(34, 'see', 'nhìn/thấy', 'saw', 'đã thấy', 2),
(34, 'eat', 'ăn', 'ate', 'đã ăn', 3),
(34, 'buy', 'mua', 'bought', 'đã mua', 4);

-- Exercise 35: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(5, 'true_false', 'easy', 'Is this sentence correct?', 'Câu này đúng không?', 'She didn''t went to school yesterday.', 'Cô ấy didn''t went đến trường hôm qua.', 'false', 'After "didn''t", use base form: "She didn''t go to school yesterday." NOT "didn''t went".', 'Sau "didn''t", dùng nguyên mẫu: "She didn''t go to school yesterday." KHÔNG PHẢI "didn''t went".', 5, 7);


-- ############################################################################
-- LESSON 6: PAST CONTINUOUS (lesson_id = 6)
-- ############################################################################

-- Formulas (IDs 16-18)
INSERT INTO formula (lesson_id, type, subject_note, structure, structure_vi, example, example_vi, note, order_index) VALUES
(6, 'affirmative', 'I/He/She/It + was | You/We/They + were', 'S + was/were + V-ing', 'Chủ ngữ + was/were + V-ing', 'I was studying at 8 PM last night.', 'Tôi đang học lúc 8 giờ tối qua.', 'was cho I/he/she/it, were cho you/we/they', 1),
(6, 'negative', NULL, 'S + was/were + not + V-ing', 'Chủ ngữ + was/were + not + V-ing', 'She was not (wasn''t) sleeping at that time.', 'Cô ấy không ngủ lúc đó.', 'Viết tắt: was not = wasn''t, were not = weren''t', 2),
(6, 'interrogative', NULL, 'Was/Were + S + V-ing?', 'Was/Were + Chủ ngữ + V-ing?', 'Were you watching TV when I called?', 'Bạn có đang xem TV khi tôi gọi không?', 'Trả lời: Yes, I was. / No, I wasn''t.', 3);

-- Usages (IDs 18-20)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(6, 'Action in progress at past time', 'Hành động đang diễn ra tại thời điểm quá khứ', 'Describes an action that was in progress at a specific time in the past.', 'Diễn tả hành động đang diễn ra tại thời điểm cụ thể trong quá khứ.', 'PlayArrow', TRUE, 1),
(6, 'Interrupted action', 'Hành động bị gián đoạn', 'A longer action (Past Continuous) interrupted by a shorter action (Simple Past).', 'Hành động dài (QKTD) bị gián đoạn bởi hành động ngắn (QKĐ).', 'FlashOn', TRUE, 2),
(6, 'Parallel actions', 'Hành động song song', 'Two or more actions happening at the same time in the past.', 'Hai hoặc nhiều hành động xảy ra cùng lúc trong quá khứ.', 'CompareArrows', TRUE, 3);

-- Examples for usage 18 (IDs 31-32)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(18, 'At 9 PM, I was watching a movie.', 'Lúc 9 giờ tối, tôi đang xem phim.', '"At 9 PM" specifies the exact time when the action was in progress.', '"Lúc 9 giờ tối" xác định thời điểm hành động đang diễn ra.', 'was watching', 1),
(18, 'They were sleeping when the earthquake happened.', 'Họ đang ngủ khi động đất xảy ra.', 'Sleeping was the ongoing background action at that moment.', 'Ngủ là hành động nền đang diễn ra tại thời điểm đó.', 'were sleeping', 2);

-- Examples for usage 19 (IDs 33-34)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(19, 'I was cooking when the phone rang.', 'Tôi đang nấu ăn thì điện thoại reo.', '"Was cooking" = longer action (interrupted). "Rang" = shorter action (interrupting).', '"Was cooking" = hành động dài (bị ngắt). "Rang" = hành động ngắn (gây ngắt).', 'was cooking', 1),
(19, 'She was walking home when it started to rain.', 'Cô ấy đang đi bộ về nhà thì trời bắt đầu mưa.', 'Walking (continuous) was interrupted by the rain starting (simple past).', 'Đi bộ (tiếp diễn) bị gián đoạn bởi mưa bắt đầu (quá khứ đơn).', 'was walking', 2);

-- Examples for usage 20 (IDs 35-36)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(20, 'While I was studying, my brother was playing games.', 'Trong khi tôi đang học, anh tôi đang chơi game.', '"While" connects two simultaneous actions, both in Past Continuous.', '"While" nối hai hành động đồng thời, đều dùng Quá khứ tiếp diễn.', 'was studying, was playing', 1),
(20, 'The children were laughing and the dog was barking.', 'Bọn trẻ đang cười và con chó đang sủa.', 'Multiple actions happening at the same time in the past.', 'Nhiều hành động xảy ra cùng lúc trong quá khứ.', 'were laughing, was barking', 2);

-- Signal words (IDs 35-40)
INSERT INTO signal_word (lesson_id, word, word_vi, category, example_sentence, example_vi, position, note, order_index) VALUES
(6, 'while', 'trong khi', 'duration', 'While she was reading, he was cooking.', 'Trong khi cô ấy đọc sách, anh ấy nấu ăn.', 'beginning', 'Thường dùng với Past Continuous', 1),
(6, 'when', 'khi', 'time', 'I was eating when he arrived.', 'Tôi đang ăn khi anh ấy đến.', 'middle', 'Mệnh đề "when" thường ở Simple Past', 2),
(6, 'as', 'trong khi/khi', 'time', 'As I was leaving, the phone rang.', 'Khi tôi đang đi thì điện thoại reo.', 'beginning', 'Tương tự "while" và "when"', 3),
(6, 'at 5 PM yesterday', 'lúc 5 giờ chiều hôm qua', 'time', 'At 5 PM yesterday, I was driving home.', 'Lúc 5 giờ chiều hôm qua, tôi đang lái xe về nhà.', 'beginning', NULL, 4),
(6, 'at that time', 'vào lúc đó', 'time', 'At that time, we were having dinner.', 'Vào lúc đó, chúng tôi đang ăn tối.', 'beginning', NULL, 5),
(6, 'all morning/afternoon', 'cả buổi sáng/chiều', 'duration', 'She was studying all morning.', 'Cô ấy đã học cả buổi sáng.', 'end', NULL, 6);

-- Tips (IDs 17-19)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(6, 'When vs While', 'When vs While', '"When" usually introduces the shorter action (Simple Past): "When the phone rang..." "While" usually introduces the longer action (Past Continuous): "While I was studying..."', '"When" thường giới thiệu hành động ngắn (QKĐ): "When the phone rang..." "While" thường giới thiệu hành động dài (QKTD): "While I was studying..."', 'memory', 'high', 'Compare', 1),
(6, 'Was vs Were', 'Was vs Were', 'Use "was" with I/he/she/it. Use "were" with you/we/they. Common mistake: "They was playing" → "They were playing".', 'Dùng "was" với I/he/she/it. Dùng "were" với you/we/they. Lỗi thường: "They was playing" → "They were playing".', 'common_mistake', 'high', 'Warning', 2),
(6, 'No stative verbs in Past Continuous', 'Không dùng động từ trạng thái', 'Like Present Continuous, stative verbs cannot be used: "I was knowing" is wrong. Use Simple Past: "I knew".', 'Giống Hiện tại tiếp diễn, không dùng động từ trạng thái: "I was knowing" sai. Dùng Quá khứ đơn: "I knew".', 'common_mistake', 'medium', 'Warning', 3);

-- Comparison (ID 8)
INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(5, 6, 'In Progress vs Completed', 'Đang diễn ra vs Hoàn thành', 'Action was completed (event)', 'Hành động đã hoàn thành (sự kiện)', 'Action was in progress (background)', 'Hành động đang diễn ra (nền)', 'She called me at 9 PM.', 'Cô ấy gọi tôi lúc 9 giờ tối.', 'I was reading when she called.', 'Tôi đang đọc khi cô ấy gọi.', 'Background action = Past Continuous. Event/interruption = Simple Past.', 'Hành động nền = QKTD. Sự kiện/gián đoạn = QKĐ.', 1);

-- Exercise 36: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(6, 'multiple_choice', 'easy', 'Choose the correct form.', 'Chọn dạng đúng.', 'I ___ dinner when the doorbell rang.', 'Tôi ___ tối khi chuông cửa reo.', 'Cooking was the longer action in progress, interrupted by the doorbell (Simple Past).', 'Nấu ăn là hành động dài đang diễn ra, bị gián đoạn bởi chuông cửa (QKĐ).', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(36, 'A', 'cooked', FALSE, 'Simple Past — describes completed action, not in progress', 1),
(36, 'B', 'was cooking', TRUE, 'Correct! Past Continuous for action in progress when interrupted', 2),
(36, 'C', 'am cooking', FALSE, 'Present Continuous — wrong time frame', 3),
(36, 'D', 'cook', FALSE, 'Base form — no tense marking', 4);

-- Exercise 37: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(6, 'fill_blank', 'easy', 'Complete with was/were + V-ing.', 'Hoàn thành với was/were + V-ing.', 'They ___ (play) tennis at 3 PM yesterday.', 'Họ ___ (chơi) tennis lúc 3 giờ chiều hôm qua.', 'were playing', '"They" uses "were". "At 3 PM yesterday" = specific past time → Past Continuous.', '"They" dùng "were". "Lúc 3 giờ chiều hôm qua" = thời điểm cụ thể → Quá khứ tiếp diễn.', 10, 2);

-- Exercise 38: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(6, 'error_correction', 'medium', 'Find and correct the error.', 'Tìm và sửa lỗi.', 'They was watching TV when I arrived.', 'Họ was watching TV khi tôi đến.', 'They were watching TV when I arrived.', '"They" requires "were", not "was". Was = I/he/she/it. Were = you/we/they.', '"They" cần "were" không phải "was". Was = I/he/she/it. Were = you/we/they.', 'Check the subject-verb agreement.', 'Kiểm tra sự hòa hợp chủ ngữ-động từ.', 15, 3);

-- Exercise 39: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(6, 'sentence_transform', 'medium', 'Combine using "when".', 'Kết hợp sử dụng "when".', 'I was reading a book. My friend called me.', 'Tôi đang đọc sách. Bạn tôi gọi tôi.', 'I was reading a book when my friend called me.', 'Longer action (Past Continuous) + when + shorter action (Simple Past).', 'Hành động dài (QKTD) + when + hành động ngắn (QKĐ).', 15, 4);

-- Exercise 40: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(6, 'arrange_words', 'easy', 'Arrange to make a correct sentence.', 'Sắp xếp thành câu đúng.', '["was", "she", "when", "sleeping", "arrived", "I"]', 'She was sleeping when I arrived.', 'S (She) + was + V-ing (sleeping) + when + S (I) + V2 (arrived).', 'S (She) + was + V-ing (sleeping) + when + S (I) + V2 (arrived).', 10, 5);

-- Exercise 41: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(6, 'matching', 'easy', 'Match the beginnings with the endings.', 'Nối phần đầu với phần cuối câu.', 'Interrupted action pattern: Past Continuous + when + Simple Past.', 'Mẫu hành động bị gián đoạn: QKTD + when + QKĐ.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(41, 'I was taking a shower', 'Tôi đang tắm', 'when the lights went out', 'thì đèn tắt', 1),
(41, 'She was driving home', 'Cô ấy đang lái xe về', 'when it started to rain', 'thì trời bắt đầu mưa', 2),
(41, 'We were having lunch', 'Chúng tôi đang ăn trưa', 'when the boss arrived', 'thì sếp đến', 3),
(41, 'He was crossing the street', 'Anh ấy đang băng qua đường', 'when he saw an accident', 'thì thấy một vụ tai nạn', 4);

-- Exercise 42: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(6, 'true_false', 'easy', 'Is this sentence correct?', 'Câu này đúng không?', 'While I was studying, my sister was watching TV.', 'Trong khi tôi đang học, chị tôi đang xem TV.', 'true', 'Correct! "While" connects two parallel actions, both in Past Continuous.', 'Đúng! "While" nối hai hành động song song, đều dùng Quá khứ tiếp diễn.', 5, 7);


-- ############################################################################
-- LESSON 7: PAST PERFECT (lesson_id = 7)
-- ############################################################################

-- Formulas (IDs 19-21)
INSERT INTO formula (lesson_id, type, subject_note, structure, structure_vi, example, example_vi, note, order_index) VALUES
(7, 'affirmative', 'All subjects + had', 'S + had + V3 (past participle)', 'Chủ ngữ + had + Động từ quá khứ phân từ', 'She had already left when I arrived.', 'Cô ấy đã đi rồi khi tôi đến.', 'Had dùng cho tất cả các ngôi', 1),
(7, 'negative', NULL, 'S + had + not + V3', 'Chủ ngữ + had + not + Động từ quá khứ phân từ', 'I had not (hadn''t) eaten before the meeting.', 'Tôi chưa ăn trước cuộc họp.', 'Viết tắt: had not = hadn''t', 2),
(7, 'interrogative', NULL, 'Had + S + V3?', 'Had + Chủ ngữ + Động từ quá khứ phân từ?', 'Had you finished before 5 PM?', 'Bạn đã hoàn thành trước 5 giờ chưa?', 'Trả lời: Yes, I had. / No, I hadn''t.', 3);

-- Usages (IDs 21-23)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(7, 'Action before another past action', 'Hành động trước hành động quá khứ khác', 'Describes an action that was completed before another action in the past.', 'Diễn tả hành động đã hoàn thành trước hành động khác trong quá khứ.', 'FastRewind', TRUE, 1),
(7, 'By the time / By + past time', 'Trước khi / Trước + thời gian quá khứ', 'Used with "by the time" to show what had happened before a deadline.', 'Dùng với "by the time" để chỉ điều đã xảy ra trước mốc thời gian.', 'Timer', TRUE, 2),
(7, 'Reported speech and conditionals', 'Câu tường thuật và câu điều kiện', 'Used in reported speech and third conditional sentences.', 'Dùng trong câu tường thuật và câu điều kiện loại 3.', 'FormatQuote', FALSE, 3);

-- Examples for usage 21 (IDs 37-38)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(21, 'When I arrived at the station, the train had already left.', 'Khi tôi đến ga, tàu đã rời rồi.', 'Train leaving happened BEFORE arriving → Past Perfect for the earlier action.', 'Tàu rời đi xảy ra TRƯỚC khi đến → Quá khứ hoàn thành cho hành động sớm hơn.', 'had already left', 1),
(21, 'She had studied English before she moved to London.', 'Cô ấy đã học tiếng Anh trước khi chuyển đến London.', '"Before" clarifies the sequence: studying happened first.', '"Before" làm rõ thứ tự: học xảy ra trước.', 'had studied', 2);

-- Examples for usage 22 (IDs 39-40)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(22, 'By the time we arrived, the movie had started.', 'Khi chúng tôi đến, phim đã bắt đầu.', '"By the time" + Simple Past, main clause uses Past Perfect.', '"By the time" + QKĐ, mệnh đề chính dùng Quá khứ hoàn thành.', 'had started', 1),
(22, 'By 2020, he had written three novels.', 'Đến năm 2020, anh ấy đã viết ba cuốn tiểu thuyết.', '"By 2020" sets a past deadline; the writing was completed before it.', '"Đến năm 2020" đặt mốc quá khứ; việc viết đã hoàn thành trước đó.', 'had written', 2);

-- Examples for usage 23 (IDs 41-42)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(23, 'She said she had finished the report.', 'Cô ấy nói cô ấy đã hoàn thành báo cáo.', 'Reported speech: "I have finished" becomes "she had finished".', 'Câu tường thuật: "I have finished" thành "she had finished".', 'had finished', 1),
(23, 'If I had known, I would have helped.', 'Nếu tôi biết, tôi đã giúp rồi.', 'Third conditional: If + Past Perfect, would + have + V3.', 'Câu điều kiện loại 3: If + QKHT, would + have + V3.', 'had known', 2);

-- Signal words (IDs 41-46)
INSERT INTO signal_word (lesson_id, word, word_vi, category, example_sentence, example_vi, position, note, order_index) VALUES
(7, 'before', 'trước khi', 'sequence', 'I had eaten before she arrived.', 'Tôi đã ăn trước khi cô ấy đến.', 'middle', NULL, 1),
(7, 'after', 'sau khi', 'sequence', 'After he had left, I found his wallet.', 'Sau khi anh ấy đi, tôi tìm thấy ví.', 'beginning', NULL, 2),
(7, 'by the time', 'vào lúc/khi', 'time', 'By the time I woke up, she had gone.', 'Khi tôi thức dậy, cô ấy đã đi rồi.', 'beginning', NULL, 3),
(7, 'already', 'đã rồi', 'time', 'They had already finished when we arrived.', 'Họ đã xong rồi khi chúng tôi đến.', 'middle', 'Đứng giữa had và V3', 4),
(7, 'just', 'vừa mới', 'time', 'He had just left when you called.', 'Anh ấy vừa đi khi bạn gọi.', 'middle', NULL, 5),
(7, 'never ... before', 'chưa bao giờ ... trước đó', 'frequency', 'I had never seen snow before that day.', 'Trước ngày đó tôi chưa bao giờ thấy tuyết.', 'middle', NULL, 6);

-- Tips (IDs 20-22)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(7, 'Two past actions = which first?', 'Hai hành động quá khứ = cái nào trước?', 'Past Perfect shows which action happened FIRST. "When I arrived (2nd), she had left (1st)." The earlier action uses Past Perfect.', 'Quá khứ hoàn thành cho thấy hành động nào xảy ra TRƯỚC. "Khi tôi đến (2), cô ấy đã đi (1)." Hành động sớm hơn dùng QKHT.', 'memory', 'high', 'Lightbulb', 1),
(7, 'Before/After make sequence clear', 'Before/After làm rõ thứ tự', 'With "before" and "after", the sequence is already clear, so Simple Past is also acceptable: "I ate before she arrived" = "I had eaten before she arrived."', 'Với "before" và "after", thứ tự đã rõ nên QKĐ cũng được: "I ate before she arrived" = "I had eaten before she arrived."', 'native_usage', 'medium', 'Lightbulb', 2),
(7, 'Had + V3, not had + V2', 'Had + V3, không phải had + V2', 'Common mistake: "I had went" → "I had gone." After "had", always use the past participle (V3), not the past simple (V2).', 'Lỗi thường: "I had went" → "I had gone." Sau "had" luôn dùng quá khứ phân từ (V3), không phải quá khứ đơn (V2).', 'common_mistake', 'high', 'Warning', 3);

-- Comparison (ID 9)
INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(5, 7, 'Earlier vs Later past action', 'Hành động quá khứ sớm hơn vs muộn hơn', 'Action at a specific time in the past', 'Hành động tại thời điểm cụ thể trong quá khứ', 'Action completed BEFORE another past action', 'Hành động hoàn thành TRƯỚC hành động quá khứ khác', 'She arrived at 8 PM.', 'Cô ấy đến lúc 8 giờ tối.', 'I had eaten before she arrived.', 'Tôi đã ăn trước khi cô ấy đến.', 'Two past events? Earlier one = Past Perfect. Later one = Simple Past.', 'Hai sự kiện quá khứ? Sớm hơn = QKHT. Muộn hơn = QKĐ.', 1);

-- Exercise 43: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(7, 'multiple_choice', 'medium', 'Choose the correct form.', 'Chọn dạng đúng.', 'By the time we arrived, the show ___.', 'Khi chúng tôi đến, buổi diễn ___.', '"By the time" + Simple Past signals that the main action happened earlier → Past Perfect.', '"By the time" + QKĐ cho thấy hành động chính xảy ra sớm hơn → Quá khứ hoàn thành.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(43, 'A', 'had started', TRUE, 'Correct! Past Perfect for action completed before another past event', 1),
(43, 'B', 'started', FALSE, 'Simple Past — doesn''t show the earlier sequence', 2),
(43, 'C', 'has started', FALSE, 'Present Perfect — wrong time frame (past, not present)', 3),
(43, 'D', 'was starting', FALSE, 'Past Continuous — in progress, not completed before', 4);

-- Exercise 44: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(7, 'fill_blank', 'medium', 'Complete with had + past participle.', 'Hoàn thành với had + quá khứ phân từ.', 'She ___ (never/fly) before her trip to London.', 'Cô ấy ___ (chưa bao giờ/bay) trước chuyến đi London.', 'had never flown', '"Before" signals Past Perfect. Fly → flown (irregular V3). Never goes between had and V3.', '"Before" báo hiệu QKHT. Fly → flown (bất quy tắc). Never đứng giữa had và V3.', 10, 2);

-- Exercise 45: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(7, 'error_correction', 'medium', 'Find and correct the error.', 'Tìm và sửa lỗi.', 'I had went home before the rain started.', 'Tôi had went về nhà trước khi mưa.', 'I had gone home before the rain started.', 'After "had", use V3 (past participle): go → gone, NOT went (V2).', 'Sau "had" dùng V3 (quá khứ phân từ): go → gone, KHÔNG PHẢI went (V2).', 'Check: is the verb after "had" in V2 or V3 form?', 'Kiểm tra: động từ sau "had" ở dạng V2 hay V3?', 15, 3);

-- Exercise 46: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(7, 'sentence_transform', 'medium', 'Combine using "by the time".', 'Kết hợp dùng "by the time".', 'The train left. Then I arrived at the station.', 'Tàu rời đi. Sau đó tôi đến ga.', 'By the time I arrived at the station, the train had left.', '"By the time" + later action (Simple Past), earlier action (Past Perfect).', '"By the time" + hành động sau (QKĐ), hành động trước (QKHT).', 15, 4);

-- Exercise 47: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(7, 'arrange_words', 'medium', 'Arrange to make a correct sentence.', 'Sắp xếp thành câu đúng.', '["had", "she", "already", "the movie", "seen"]', 'She had already seen the movie.', 'S (She) + had + already + V3 (seen) + Object (the movie).', 'S (She) + had + already + V3 (seen) + Tân ngữ (the movie).', 10, 5);

-- Exercise 48: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(7, 'matching', 'medium', 'Match the causes with their results.', 'Nối nguyên nhân với kết quả.', 'Earlier action (Past Perfect) caused the later situation.', 'Hành động sớm hơn (QKHT) gây ra tình huống sau đó.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(48, 'I had lost my key', 'Tôi đã mất chìa khóa', 'so I couldn''t open the door', 'nên không mở được cửa', 1),
(48, 'She had studied hard', 'Cô ấy đã học chăm', 'so she passed the exam', 'nên đã đỗ kỳ thi', 2),
(48, 'They had eaten lunch', 'Họ đã ăn trưa', 'so they weren''t hungry', 'nên không đói', 3),
(48, 'He had never traveled abroad', 'Anh ấy chưa bao giờ đi nước ngoài', 'before his trip to Paris', 'trước chuyến đi Paris', 4);

-- Exercise 49: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(7, 'true_false', 'medium', 'Is this sentence correct?', 'Câu này đúng không?', 'After she had finished dinner, she watched TV.', 'Sau khi cô ấy ăn tối xong, cô ấy xem TV.', 'true', 'Correct! "After" + Past Perfect for the first action, Simple Past for the second.', 'Đúng! "After" + QKHT cho hành động thứ nhất, QKĐ cho hành động thứ hai.', 5, 7);


-- ############################################################################
-- LESSON 8: PAST PERFECT CONTINUOUS (lesson_id = 8)
-- ############################################################################

-- Formulas (IDs 22-24)
INSERT INTO formula (lesson_id, type, subject_note, structure, structure_vi, example, example_vi, note, order_index) VALUES
(8, 'affirmative', 'All subjects + had been', 'S + had + been + V-ing', 'Chủ ngữ + had + been + V-ing', 'I had been waiting for an hour when she arrived.', 'Tôi đã đợi một tiếng khi cô ấy đến.', 'Nhấn mạnh thời lượng trước một hành động quá khứ', 1),
(8, 'negative', NULL, 'S + had + not + been + V-ing', 'Chủ ngữ + had + not + been + V-ing', 'He hadn''t been sleeping well before the exam.', 'Anh ấy đã ngủ không ngon trước kỳ thi.', 'Viết tắt: had not been = hadn''t been', 2),
(8, 'interrogative', NULL, 'Had + S + been + V-ing?', 'Had + Chủ ngữ + been + V-ing?', 'How long had you been waiting?', 'Bạn đã đợi bao lâu?', 'Thường dùng với How long...?', 3);

-- Usages (IDs 24-26)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(8, 'Duration before a past event', 'Thời lượng trước sự kiện quá khứ', 'Emphasizes how long something had been happening before another past action.', 'Nhấn mạnh điều gì đó đã diễn ra bao lâu trước hành động quá khứ khác.', 'HourglassEmpty', TRUE, 1),
(8, 'Cause of a past result', 'Nguyên nhân của kết quả quá khứ', 'The ongoing past action caused a visible result.', 'Hành động quá khứ liên tục gây ra kết quả nhìn thấy.', 'TrendingUp', TRUE, 2),
(8, 'Reported continuous actions', 'Tường thuật hành động tiếp diễn', 'Used in reported speech for actions that were in progress.', 'Dùng trong câu tường thuật cho hành động đang diễn ra.', 'FormatQuote', FALSE, 3);

-- Examples for usage 24 (IDs 43-44)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(24, 'I had been studying for three hours when she called.', 'Tôi đã học ba tiếng khi cô ấy gọi.', '"For three hours" emphasizes duration before the interruption.', '"Ba tiếng" nhấn mạnh thời lượng trước khi bị gián đoạn.', 'had been studying', 1),
(24, 'They had been living in Paris for ten years before they moved.', 'Họ đã sống ở Paris mười năm trước khi chuyển đi.', 'Duration of the action before another past event.', 'Thời lượng hành động trước sự kiện quá khứ khác.', 'had been living', 2);

-- Examples for usage 25 (IDs 45-46)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(25, 'She was tired because she had been running.', 'Cô ấy mệt vì đã chạy.', 'Running (continuous past action) caused the tiredness (past result).', 'Chạy (hành động quá khứ liên tục) gây ra mệt mỏi (kết quả quá khứ).', 'had been running', 1),
(25, 'The streets were wet because it had been raining.', 'Đường ướt vì trời đã mưa.', 'The rain had been ongoing; the wet streets were the visible result.', 'Mưa đã diễn ra liên tục; đường ướt là kết quả nhìn thấy.', 'had been raining', 2);

-- Examples for usage 26 (IDs 47-48)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(26, 'She said she had been waiting for over an hour.', 'Cô ấy nói đã đợi hơn một tiếng.', 'Reported speech: "I have been waiting" → "she had been waiting".', 'Câu tường thuật: "I have been waiting" → "she had been waiting".', 'had been waiting', 1),
(26, 'He mentioned he had been working on the project all week.', 'Anh ấy đề cập đã làm dự án cả tuần.', 'Reported speech preserves the continuous aspect with Past Perfect Continuous.', 'Câu tường thuật giữ khía cạnh tiếp diễn với Quá khứ hoàn thành tiếp diễn.', 'had been working', 2);

-- Signal words (IDs 47-52)
INSERT INTO signal_word (lesson_id, word, word_vi, category, example_sentence, example_vi, position, note, order_index) VALUES
(8, 'for', 'trong (khoảng)', 'duration', 'She had been cooking for two hours.', 'Cô ấy đã nấu ăn hai tiếng.', 'end', 'for + khoảng thời gian', 1),
(8, 'since', 'từ khi', 'duration', 'He had been working since morning.', 'Anh ấy đã làm việc từ sáng.', 'end', 'since + mốc thời gian', 2),
(8, 'all day/week', 'cả ngày/tuần', 'duration', 'It had been snowing all day.', 'Tuyết đã rơi cả ngày.', 'end', NULL, 3),
(8, 'before', 'trước khi', 'sequence', 'I had been reading before I fell asleep.', 'Tôi đã đọc sách trước khi ngủ thiếp đi.', 'middle', NULL, 4),
(8, 'by the time', 'vào lúc', 'time', 'By the time she arrived, I had been waiting for an hour.', 'Khi cô ấy đến, tôi đã đợi một tiếng.', 'beginning', NULL, 5),
(8, 'how long', 'bao lâu', 'duration', 'How long had they been traveling?', 'Họ đã đi du lịch bao lâu?', 'beginning', 'Dùng trong câu hỏi', 6);

-- Tips (IDs 23-25)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(8, 'PPC vs Past Perfect', 'QKHTTD vs QKHT', 'Past Perfect Continuous = duration/process BEFORE a past event. Past Perfect = completion BEFORE a past event. "I had been reading for 2 hours" (process) vs "I had read 3 chapters" (result).', 'QKHTTD = thời lượng/quá trình TRƯỚC sự kiện quá khứ. QKHT = hoàn thành TRƯỚC sự kiện quá khứ. "I had been reading for 2 hours" (quá trình) vs "I had read 3 chapters" (kết quả).', 'comparison', 'high', 'Compare', 1),
(8, 'No stative verbs', 'Không dùng động từ trạng thái', 'Like all continuous tenses, stative verbs cannot be used: "I had been knowing" is wrong. Use Past Perfect: "I had known."', 'Giống tất cả thì tiếp diễn, không dùng động từ trạng thái: "I had been knowing" sai. Dùng QKHT: "I had known."', 'common_mistake', 'high', 'Warning', 2),
(8, 'Rarest past tense', 'Thì quá khứ hiếm dùng nhất', 'Past Perfect Continuous is the least common past tense. It''s only needed when emphasizing DURATION before another past event. Often, Past Perfect alone is sufficient.', 'QKHTTD là thì quá khứ ít dùng nhất. Chỉ cần khi nhấn mạnh THỜI LƯỢNG trước sự kiện quá khứ. Thường QKHT là đủ.', 'native_usage', 'medium', 'Lightbulb', 3);

-- Comparison (ID 10)
INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(7, 8, 'Duration vs Completion', 'Thời lượng vs Hoàn thành', 'Emphasizes completion before past event', 'Nhấn mạnh hoàn thành trước sự kiện quá khứ', 'Emphasizes duration/process before past event', 'Nhấn mạnh thời lượng/quá trình trước sự kiện quá khứ', 'I had read 50 pages before dinner. (completed amount)', 'Tôi đã đọc 50 trang trước bữa tối. (số lượng xong)', 'I had been reading for 2 hours when she called. (duration)', 'Tôi đã đọc 2 tiếng khi cô ấy gọi. (thời lượng)', 'Focus on how long? → PPC. Focus on what was done? → PP.', 'Tập trung bao lâu? → QKHTTD. Tập trung làm gì? → QKHT.', 1);

-- Exercise 50: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(8, 'multiple_choice', 'medium', 'Choose the correct form.', 'Chọn dạng đúng.', 'She was tired because she ___ all day.', 'Cô ấy mệt vì ___ cả ngày.', '"All day" emphasizes duration, and the action caused the tiredness (past result) → Past Perfect Continuous.', '"Cả ngày" nhấn mạnh thời lượng, hành động gây ra mệt mỏi (kết quả quá khứ) → QKHTTD.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(50, 'A', 'had been working', TRUE, 'Correct! Duration before a past result = PPC', 1),
(50, 'B', 'had worked', FALSE, 'Past Perfect — emphasizes completion, not duration', 2),
(50, 'C', 'was working', FALSE, 'Past Continuous — no "before another past event" emphasis', 3),
(50, 'D', 'worked', FALSE, 'Simple Past — no duration emphasis', 4);

-- Exercise 51: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(8, 'fill_blank', 'medium', 'Complete with had been + V-ing.', 'Hoàn thành với had been + V-ing.', 'They ___ (wait) for two hours when the bus finally came.', 'Họ ___ (đợi) hai tiếng khi xe buýt cuối cùng đến.', 'had been waiting', '"For two hours" = duration before bus arrival → Past Perfect Continuous.', '"Hai tiếng" = thời lượng trước khi xe đến → QKHTTD.', 10, 2);

-- Exercise 52: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(8, 'error_correction', 'hard', 'Find and correct the error.', 'Tìm và sửa lỗi.', 'I had been knowing him for years before we became friends.', 'Tôi had been knowing anh ấy nhiều năm trước khi thành bạn.', 'I had known him for years before we became friends.', '"Know" is a stative verb — cannot use continuous. Use Past Perfect: had known.', '"Know" là động từ trạng thái — không dùng tiếp diễn. Dùng QKHT: had known.', 'Is this verb an action or a state?', 'Đây là động từ hành động hay trạng thái?', 15, 3);

-- Exercise 53: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(8, 'sentence_transform', 'hard', 'Rewrite emphasizing duration.', 'Viết lại nhấn mạnh thời lượng.', 'He studied for five hours. Then he took a break.', 'Anh ấy học năm tiếng. Sau đó nghỉ.', 'He had been studying for five hours when he took a break.', 'Duration (for five hours) + another past event → Past Perfect Continuous + when + Simple Past.', 'Thời lượng (năm tiếng) + sự kiện quá khứ khác → QKHTTD + when + QKĐ.', 15, 4);

-- Exercise 54: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(8, 'arrange_words', 'medium', 'Arrange to make a correct sentence.', 'Sắp xếp thành câu đúng.', '["had", "raining", "it", "been", "all morning"]', 'It had been raining all morning.', 'S (It) + had + been + V-ing (raining) + Duration (all morning).', 'S (It) + had + been + V-ing (raining) + Thời lượng (all morning).', 10, 5);

-- Exercise 55: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(8, 'matching', 'medium', 'Match the duration with the result.', 'Nối thời lượng với kết quả.', 'Past Perfect Continuous (cause/duration) led to a past result.', 'QKHTTD (nguyên nhân/thời lượng) dẫn đến kết quả quá khứ.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(55, 'She had been crying', 'Cô ấy đã khóc', 'Her eyes were red', 'Mắt cô ấy đỏ', 1),
(55, 'He had been running', 'Anh ấy đã chạy', 'He was out of breath', 'Anh ấy hết hơi', 2),
(55, 'It had been snowing', 'Tuyết đã rơi', 'The ground was white', 'Mặt đất trắng xóa', 3),
(55, 'They had been cooking', 'Họ đã nấu ăn', 'The kitchen smelled great', 'Bếp thơm ngon', 4);

-- Exercise 56: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(8, 'true_false', 'medium', 'Is this sentence correct?', 'Câu này đúng không?', 'He had been working at the company for ten years before he retired.', 'Anh ấy đã làm việc ở công ty mười năm trước khi nghỉ hưu.', 'true', 'Correct! Duration (for ten years) before a past event (retired) = Past Perfect Continuous.', 'Đúng! Thời lượng (mười năm) trước sự kiện quá khứ (nghỉ hưu) = QKHTTD.', 5, 7);


-- ############################################################################
-- LESSON 9: SIMPLE FUTURE (lesson_id = 9)
-- ############################################################################

-- Formulas (IDs 25-27)
INSERT INTO formula (lesson_id, type, subject_note, structure, structure_vi, example, example_vi, note, order_index) VALUES
(9, 'affirmative', 'All subjects + will', 'S + will + V (base form)', 'Chủ ngữ + will + Động từ nguyên mẫu', 'I will help you tomorrow.', 'Tôi sẽ giúp bạn ngày mai.', 'Will dùng cho tất cả các ngôi. Cũng có thể dùng: S + am/is/are + going to + V', 1),
(9, 'negative', NULL, 'S + will + not + V', 'Chủ ngữ + will + not + Động từ nguyên mẫu', 'She will not (won''t) come to the party.', 'Cô ấy sẽ không đến bữa tiệc.', 'Viết tắt: will not = won''t', 2),
(9, 'interrogative', NULL, 'Will + S + V?', 'Will + Chủ ngữ + Động từ nguyên mẫu?', 'Will you be there tomorrow?', 'Bạn sẽ ở đó ngày mai chứ?', 'Trả lời: Yes, I will. / No, I won''t.', 3);

-- Usages (IDs 27-29)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(9, 'Predictions and opinions', 'Dự đoán và ý kiến', 'Used to make predictions about the future based on opinion or belief.', 'Dùng để đưa ra dự đoán về tương lai dựa trên ý kiến hoặc niềm tin.', 'TrendingUp', TRUE, 1),
(9, 'Spontaneous decisions', 'Quyết định tức thì', 'Decisions made at the moment of speaking, not planned in advance.', 'Quyết định đưa ra tại thời điểm nói, không lên kế hoạch trước.', 'FlashOn', TRUE, 2),
(9, 'Promises and offers', 'Lời hứa và đề nghị', 'Used to make promises, offers, requests, and threats.', 'Dùng để đưa ra lời hứa, đề nghị, yêu cầu và lời đe dọa.', 'Handshake', TRUE, 3);

-- Examples for usage 27 (IDs 49-50)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(27, 'I think it will rain tomorrow.', 'Tôi nghĩ ngày mai trời sẽ mưa.', '"I think" signals a personal prediction → use "will".', '"Tôi nghĩ" báo hiệu dự đoán cá nhân → dùng "will".', 'will rain', 1),
(27, 'Technology will change the world.', 'Công nghệ sẽ thay đổi thế giới.', 'General prediction about the future.', 'Dự đoán chung về tương lai.', 'will change', 2);

-- Examples for usage 28 (IDs 51-52)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(28, 'I''m cold. I''ll close the window.', 'Tôi lạnh. Tôi sẽ đóng cửa sổ.', 'Decision made at the moment — not planned beforehand.', 'Quyết định tại thời điểm nói — không lên kế hoạch trước.', 'I''ll close', 1),
(28, 'Oh, we''re out of milk. I''ll go buy some.', 'Ồ, hết sữa rồi. Tôi sẽ đi mua.', 'Spontaneous reaction to a situation discovered now.', 'Phản ứng tức thì với tình huống vừa phát hiện.', 'I''ll go', 2);

-- Examples for usage 29 (IDs 53-54)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(29, 'I will always love you.', 'Anh sẽ luôn yêu em.', 'A promise about the future.', 'Một lời hứa về tương lai.', 'will always love', 1),
(29, 'I''ll carry that bag for you.', 'Tôi sẽ mang túi cho bạn.', 'An offer to help, decided at the moment of speaking.', 'Đề nghị giúp đỡ, quyết định tại thời điểm nói.', 'I''ll carry', 2);

-- Signal words (IDs 53-58)
INSERT INTO signal_word (lesson_id, word, word_vi, category, example_sentence, example_vi, position, note, order_index) VALUES
(9, 'tomorrow', 'ngày mai', 'time', 'I will call you tomorrow.', 'Tôi sẽ gọi cho bạn ngày mai.', 'end', NULL, 1),
(9, 'next week/month/year', 'tuần/tháng/năm tới', 'time', 'We will travel next month.', 'Chúng tôi sẽ đi du lịch tháng tới.', 'end', NULL, 2),
(9, 'in the future', 'trong tương lai', 'time', 'Robots will do most jobs in the future.', 'Robot sẽ làm hầu hết công việc trong tương lai.', 'end', NULL, 3),
(9, 'soon', 'sớm thôi', 'time', 'He will arrive soon.', 'Anh ấy sẽ đến sớm thôi.', 'end', NULL, 4),
(9, 'probably', 'có lẽ', 'other', 'She will probably agree.', 'Cô ấy có lẽ sẽ đồng ý.', 'middle', 'Đứng giữa will và V', 5),
(9, 'I think/believe', 'tôi nghĩ/tin', 'other', 'I think he will pass the exam.', 'Tôi nghĩ anh ấy sẽ đỗ.', 'beginning', 'Báo hiệu dự đoán cá nhân', 6);

-- Tips (IDs 26-28)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(9, 'Will vs Going to', 'Will vs Going to', '"Will" = predictions (I think...), spontaneous decisions, promises. "Going to" = planned decisions, evidence-based predictions. "It will rain" (opinion) vs "Look at the clouds — it''s going to rain" (evidence).', '"Will" = dự đoán (Tôi nghĩ...), quyết định tức thì, lời hứa. "Going to" = quyết định đã lên kế hoạch, dự đoán dựa trên bằng chứng. "It will rain" (ý kiến) vs "Nhìn mây kìa — it''s going to rain" (bằng chứng).', 'comparison', 'high', 'Compare', 1),
(9, 'Shall for offers/suggestions', 'Shall cho đề nghị/gợi ý', '"Shall I/we...?" is used for offers and suggestions: "Shall I open the window?" "Shall we go?" This is more formal/British.', '"Shall I/we...?" dùng cho đề nghị và gợi ý: "Shall I open the window?" "Shall we go?" Đây là cách nói trang trọng/Anh-Anh.', 'native_usage', 'medium', 'Lightbulb', 2),
(9, 'Won''t = refusal or prediction', 'Won''t = từ chối hoặc dự đoán', '"Won''t" can mean refusal ("He won''t help me" = refuses) or negative prediction ("It won''t rain tomorrow"). Context determines the meaning.', '"Won''t" có thể nghĩa là từ chối ("He won''t help me" = từ chối) hoặc dự đoán phủ định ("It won''t rain tomorrow"). Ngữ cảnh quyết định nghĩa.', 'native_usage', 'medium', 'Lightbulb', 3);

-- Comparison (ID 11)
INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(9, 10, 'Point vs Duration', 'Thời điểm vs Thời lượng', 'Simple prediction, decision, or promise about the future', 'Dự đoán đơn giản, quyết định, hoặc lời hứa về tương lai', 'Action in progress at a specific future time', 'Hành động đang diễn ra tại thời điểm cụ thể tương lai', 'I will work tomorrow.', 'Tôi sẽ làm việc ngày mai.', 'I will be working at 3 PM tomorrow.', 'Tôi sẽ đang làm việc lúc 3 giờ chiều mai.', 'Simple statement = Simple Future. In progress at specific time = Future Continuous.', 'Phát biểu đơn giản = TLĐ. Đang diễn ra tại thời điểm cụ thể = TLTD.', 1);

-- Exercise 57: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(9, 'multiple_choice', 'easy', 'Choose the correct form.', 'Chọn dạng đúng.', '"The phone is ringing!" "OK, I ___ it."', '"Điện thoại đang reo!" "OK, tôi ___ nó."', 'Spontaneous decision made at the moment of speaking → will + base verb.', 'Quyết định tức thì tại thời điểm nói → will + nguyên mẫu.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(57, 'A', 'will answer', TRUE, 'Correct! Spontaneous decision = will', 1),
(57, 'B', 'am going to answer', FALSE, '"Going to" is for planned decisions', 2),
(57, 'C', 'answer', FALSE, 'Simple Present — not for future decisions', 3),
(57, 'D', 'am answering', FALSE, 'Present Continuous — for arranged plans', 4);

-- Exercise 58: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(9, 'fill_blank', 'easy', 'Complete with will + verb.', 'Hoàn thành với will + động từ.', 'I think she ___ (pass) the exam.', 'Tôi nghĩ cô ấy ___ (đỗ) kỳ thi.', 'will pass', '"I think" signals a personal prediction → will + base verb.', '"Tôi nghĩ" báo hiệu dự đoán → will + nguyên mẫu.', 10, 2);

-- Exercise 59: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(9, 'error_correction', 'medium', 'Find and correct the error.', 'Tìm và sửa lỗi.', 'I will going to help you.', 'Tôi will going to giúp bạn.', 'I will help you.', 'Don''t combine "will" with "going to". Use either "I will help" or "I am going to help."', 'Không kết hợp "will" với "going to". Dùng "I will help" hoặc "I am going to help."', 'Can you use "will" and "going to" together?', 'Có thể dùng "will" và "going to" cùng nhau không?', 15, 3);

-- Exercise 60: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(9, 'sentence_transform', 'medium', 'Change to a negative sentence.', 'Chuyển thành câu phủ định.', 'They will attend the meeting.', 'Họ sẽ tham dự cuộc họp.', 'They won''t attend the meeting.', 'Negative: will + not = won''t. "They won''t attend the meeting."', 'Phủ định: will + not = won''t. "They won''t attend the meeting."', 15, 4);

-- Exercise 61: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(9, 'arrange_words', 'easy', 'Arrange to make a correct sentence.', 'Sắp xếp thành câu đúng.', '["will", "I", "you", "call", "tomorrow"]', 'I will call you tomorrow.', 'S (I) + will + V (call) + Object (you) + Time (tomorrow).', 'S (I) + will + V (call) + Tân ngữ (you) + Thời gian (tomorrow).', 10, 5);

-- Exercise 62: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(9, 'matching', 'easy', 'Match the situation with the response.', 'Nối tình huống với phản hồi.', 'Spontaneous decisions use "will" — decided at the moment.', 'Quyết định tức thì dùng "will" — quyết định ngay lúc đó.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(62, 'It''s cold in here.', 'Ở đây lạnh quá.', 'I''ll close the window.', 'Tôi sẽ đóng cửa sổ.', 1),
(62, 'I''m hungry.', 'Tôi đói quá.', 'I''ll make you a sandwich.', 'Tôi sẽ làm bánh mì cho bạn.', 2),
(62, 'I don''t understand this.', 'Tôi không hiểu cái này.', 'I''ll explain it to you.', 'Tôi sẽ giải thích cho bạn.', 3),
(62, 'The bag is heavy.', 'Túi nặng quá.', 'I''ll carry it for you.', 'Tôi sẽ mang giúp bạn.', 4);

-- Exercise 63: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(9, 'true_false', 'easy', 'Is this sentence correct?', 'Câu này đúng không?', 'She will probably be late.', 'Cô ấy có lẽ sẽ đến muộn.', 'true', 'Correct! "Probably" goes between "will" and the verb. This expresses a prediction.', 'Đúng! "Probably" đứng giữa "will" và động từ. Đây là dự đoán.', 5, 7);


-- ############################################################################
-- LESSON 10: FUTURE CONTINUOUS (lesson_id = 10)
-- ############################################################################

-- Formulas (IDs 28-30)
INSERT INTO formula (lesson_id, type, subject_note, structure, structure_vi, example, example_vi, note, order_index) VALUES
(10, 'affirmative', 'All subjects + will be', 'S + will + be + V-ing', 'Chủ ngữ + will + be + V-ing', 'I will be working at 3 PM tomorrow.', 'Tôi sẽ đang làm việc lúc 3 giờ chiều mai.', 'Hành động sẽ đang diễn ra tại thời điểm tương lai', 1),
(10, 'negative', NULL, 'S + will + not + be + V-ing', 'Chủ ngữ + will + not + be + V-ing', 'She won''t be attending the meeting.', 'Cô ấy sẽ không tham dự cuộc họp.', 'Viết tắt: will not be = won''t be', 2),
(10, 'interrogative', NULL, 'Will + S + be + V-ing?', 'Will + Chủ ngữ + be + V-ing?', 'Will you be using the car tomorrow?', 'Ngày mai bạn có dùng xe không?', 'Thường dùng cho câu hỏi lịch sự', 3);

-- Usages (IDs 30-32)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(10, 'Action in progress at future time', 'Hành động đang diễn ra tại thời điểm tương lai', 'Describes an action that will be in progress at a specific future time.', 'Diễn tả hành động sẽ đang diễn ra tại thời điểm cụ thể trong tương lai.', 'PlayArrow', TRUE, 1),
(10, 'Planned future actions', 'Hành động tương lai đã lên kế hoạch', 'Describes actions that are expected or planned as part of routine.', 'Diễn tả hành động được dự kiến hoặc lên kế hoạch theo thường lệ.', 'EventNote', TRUE, 2),
(10, 'Polite inquiries', 'Câu hỏi lịch sự', 'Used for polite questions about someone''s plans.', 'Dùng cho câu hỏi lịch sự về kế hoạch của ai đó.', 'QuestionAnswer', FALSE, 3);

-- Examples for usage 30 (IDs 55-56)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(30, 'This time tomorrow, I will be flying to London.', 'Giờ này ngày mai, tôi sẽ đang bay đến London.', '"This time tomorrow" specifies a future moment; flying will be in progress then.', '"Giờ này ngày mai" xác định thời điểm tương lai; bay sẽ đang diễn ra.', 'will be flying', 1),
(30, 'At 8 PM tonight, they will be having dinner.', 'Lúc 8 giờ tối nay, họ sẽ đang ăn tối.', '"At 8 PM tonight" = specific future time for an action in progress.', '"Lúc 8 giờ tối nay" = thời điểm tương lai cụ thể cho hành động đang diễn ra.', 'will be having', 2);

-- Examples for usage 31 (IDs 57-58)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(31, 'I will be seeing the doctor on Monday.', 'Thứ Hai tôi sẽ gặp bác sĩ.', 'A planned future event — part of the schedule.', 'Sự kiện tương lai đã lên kế hoạch — theo lịch.', 'will be seeing', 1),
(31, 'She will be taking the exam next Friday.', 'Thứ Sáu tới cô ấy sẽ thi.', 'Expected/scheduled action in the near future.', 'Hành động được dự kiến/lên lịch trong tương lai gần.', 'will be taking', 2);

-- Examples for usage 32 (IDs 59-60)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(32, 'Will you be using the computer this afternoon?', 'Chiều nay bạn có dùng máy tính không?', 'Polite way to ask about plans — less direct than "Will you use...?"', 'Cách hỏi lịch sự về kế hoạch — ít trực tiếp hơn "Will you use...?"', 'Will you be using', 1),
(32, 'Will you be passing the post office? I need stamps.', 'Bạn có đi qua bưu điện không? Tôi cần tem.', 'Politely asking if their plan includes this action.', 'Hỏi lịch sự xem kế hoạch có bao gồm hành động này không.', 'Will you be passing', 2);

-- Signal words (IDs 59-64)
INSERT INTO signal_word (lesson_id, word, word_vi, category, example_sentence, example_vi, position, note, order_index) VALUES
(10, 'at this time tomorrow', 'giờ này ngày mai', 'time', 'At this time tomorrow, I will be relaxing.', 'Giờ này ngày mai, tôi sẽ đang thư giãn.', 'beginning', NULL, 1),
(10, 'at 8 PM tonight', 'lúc 8 giờ tối nay', 'time', 'At 8 PM, she will be studying.', 'Lúc 8 giờ tối, cô ấy sẽ đang học.', 'beginning', NULL, 2),
(10, 'this time next week', 'giờ này tuần tới', 'time', 'This time next week, we will be traveling.', 'Giờ này tuần tới, chúng tôi sẽ đang đi du lịch.', 'beginning', NULL, 3),
(10, 'still', 'vẫn', 'duration', 'I will still be working at midnight.', 'Nửa đêm tôi vẫn sẽ đang làm việc.', 'middle', 'Đứng giữa "will" và "be"', 4),
(10, 'all day tomorrow', 'cả ngày mai', 'duration', 'She will be studying all day tomorrow.', 'Ngày mai cô ấy sẽ học cả ngày.', 'end', NULL, 5),
(10, 'when', 'khi', 'time', 'When you arrive, I will be cooking.', 'Khi bạn đến, tôi sẽ đang nấu ăn.', 'beginning', 'Mệnh đề "when" dùng Simple Present cho tương lai', 6);

-- Tips (IDs 29-31)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(10, 'Needs a future time reference', 'Cần có mốc thời gian tương lai', 'Future Continuous always needs a time reference: "at 3 PM tomorrow", "this time next week", "when you arrive". Without it, use Simple Future.', 'Tương lai tiếp diễn luôn cần mốc thời gian: "lúc 3 giờ mai", "giờ này tuần tới", "khi bạn đến". Không có thì dùng Tương lai đơn.', 'common_mistake', 'high', 'Warning', 1),
(10, 'Polite questions technique', 'Kỹ thuật câu hỏi lịch sự', '"Will you be...?" is more polite than "Will you...?" because it asks about plans rather than making a request. Compare: "Will you help me?" (request) vs "Will you be helping with the project?" (inquiry).', '"Will you be...?" lịch sự hơn "Will you...?" vì hỏi về kế hoạch thay vì yêu cầu. So sánh: "Will you help me?" (yêu cầu) vs "Will you be helping with the project?" (hỏi thăm).', 'native_usage', 'medium', 'Lightbulb', 2),
(10, 'When-clause uses Simple Present', 'Mệnh đề When dùng Hiện tại đơn', 'In time clauses about the future, use Simple Present: "When you arrive, I will be cooking." NOT "When you will arrive..."', 'Trong mệnh đề thời gian về tương lai, dùng Hiện tại đơn: "When you arrive, I will be cooking." KHÔNG PHẢI "When you will arrive..."', 'common_mistake', 'high', 'Warning', 3);

-- Comparison (ID 12)
INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(9, 10, 'In Progress vs Simple', 'Đang diễn ra vs Đơn giản', 'Simple statement about the future', 'Phát biểu đơn giản về tương lai', 'Action will be in progress at a specific time', 'Hành động sẽ đang diễn ra tại thời điểm cụ thể', 'I will work tomorrow. (general statement)', 'Tôi sẽ làm việc ngày mai. (phát biểu chung)', 'At 3 PM, I will be working. (in the middle of it)', 'Lúc 3 giờ, tôi sẽ đang làm việc. (đang giữa chừng)', 'Specific time + in progress = FC. General future = SF.', 'Thời điểm cụ thể + đang diễn ra = TLTD. Tương lai chung = TLĐ.', 1);

-- Exercise 64: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(10, 'multiple_choice', 'medium', 'Choose the correct form.', 'Chọn dạng đúng.', 'This time tomorrow, I ___ on the beach.', 'Giờ này ngày mai, tôi ___ trên bãi biển.', '"This time tomorrow" = specific future moment for an action in progress → Future Continuous.', '"Giờ này ngày mai" = thời điểm tương lai cụ thể cho hành động đang diễn ra → TLTD.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(64, 'A', 'will be relaxing', TRUE, 'Correct! Specific future time + in progress = Future Continuous', 1),
(64, 'B', 'will relax', FALSE, 'Simple Future — general, not in progress at specific time', 2),
(64, 'C', 'relax', FALSE, 'Simple Present — wrong tense for future', 3),
(64, 'D', 'am relaxing', FALSE, 'Present Continuous — future arrangement, not specific time', 4);

-- Exercise 65: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(10, 'fill_blank', 'medium', 'Complete with will be + V-ing.', 'Hoàn thành với will be + V-ing.', 'At 9 PM tonight, she ___ (watch) her favorite show.', 'Lúc 9 giờ tối nay, cô ấy ___ (xem) chương trình yêu thích.', 'will be watching', '"At 9 PM tonight" = specific future time → will be + V-ing.', '"Lúc 9 giờ tối nay" = thời điểm cụ thể → will be + V-ing.', 10, 2);

-- Exercise 66: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(10, 'error_correction', 'medium', 'Find and correct the error.', 'Tìm và sửa lỗi.', 'When you will arrive, I will be cooking.', 'Khi bạn will arrive, tôi sẽ đang nấu ăn.', 'When you arrive, I will be cooking.', 'In time clauses (when, while, before, after), use Simple Present for future, NOT "will".', 'Trong mệnh đề thời gian (when, while, before, after), dùng Hiện tại đơn cho tương lai, KHÔNG dùng "will".', 'Check the tense in the "when" clause.', 'Kiểm tra thì trong mệnh đề "when".', 15, 3);

-- Exercise 67: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(10, 'sentence_transform', 'medium', 'Rewrite with "this time tomorrow".', 'Viết lại với "giờ này ngày mai".', 'I will fly to Paris tomorrow.', 'Tôi sẽ bay đến Paris ngày mai.', 'This time tomorrow, I will be flying to Paris.', '"This time tomorrow" + action in progress → Future Continuous.', '"Giờ này ngày mai" + hành động đang diễn ra → Tương lai tiếp diễn.', 15, 4);

-- Exercise 68: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(10, 'arrange_words', 'medium', 'Arrange to make a correct sentence.', 'Sắp xếp thành câu đúng.', '["will", "be", "they", "at 10 PM", "sleeping"]', 'They will be sleeping at 10 PM.', 'S (They) + will + be + V-ing (sleeping) + Time (at 10 PM).', 'S (They) + will + be + V-ing (sleeping) + Thời gian (at 10 PM).', 10, 5);

-- Exercise 69: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(10, 'matching', 'medium', 'Match the time with the activity.', 'Nối thời gian với hoạt động.', 'Future Continuous describes what will be happening at each time.', 'Tương lai tiếp diễn diễn tả điều sẽ đang xảy ra tại mỗi thời điểm.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(69, 'At 7 AM tomorrow', 'Lúc 7 giờ sáng mai', 'I will be commuting to work', 'Tôi sẽ đang đi làm', 1),
(69, 'At noon', 'Lúc trưa', 'She will be having lunch', 'Cô ấy sẽ đang ăn trưa', 2),
(69, 'At 3 PM', 'Lúc 3 giờ chiều', 'They will be attending a meeting', 'Họ sẽ đang họp', 3),
(69, 'At 11 PM', 'Lúc 11 giờ tối', 'He will be sleeping', 'Anh ấy sẽ đang ngủ', 4);

-- Exercise 70: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(10, 'true_false', 'medium', 'Is this sentence correct?', 'Câu này đúng không?', 'Don''t call at 8 PM. I will be watching a movie.', 'Đừng gọi lúc 8 giờ tối. Tôi sẽ đang xem phim.', 'true', 'Correct! The speaker will be in the middle of watching at 8 PM → Future Continuous.', 'Đúng! Người nói sẽ đang xem phim lúc 8 giờ → Tương lai tiếp diễn.', 5, 7);


-- ############################################################################
-- LESSON 11: FUTURE PERFECT (lesson_id = 11)
-- ############################################################################

-- Formulas (IDs 31-33)
INSERT INTO formula (lesson_id, type, subject_note, structure, structure_vi, example, example_vi, note, order_index) VALUES
(11, 'affirmative', 'All subjects + will have', 'S + will + have + V3', 'Chủ ngữ + will + have + V3', 'By next year, I will have graduated.', 'Đến năm tới, tôi sẽ tốt nghiệp rồi.', 'Hành động sẽ hoàn thành trước mốc thời gian tương lai', 1),
(11, 'negative', NULL, 'S + will + not + have + V3', 'Chủ ngữ + will + not + have + V3', 'She won''t have finished by 5 PM.', 'Cô ấy sẽ chưa xong trước 5 giờ.', 'Viết tắt: will not have = won''t have', 2),
(11, 'interrogative', NULL, 'Will + S + have + V3?', 'Will + Chủ ngữ + have + V3?', 'Will you have completed the project by Friday?', 'Bạn sẽ hoàn thành dự án trước thứ Sáu chứ?', 'Trả lời: Yes, I will. / No, I won''t.', 3);

-- Usages (IDs 33-35)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(11, 'Completed before a future time', 'Hoàn thành trước thời điểm tương lai', 'Describes an action that will be finished before a deadline or future point.', 'Diễn tả hành động sẽ hoàn thành trước hạn chót hoặc mốc thời gian tương lai.', 'CheckCircle', TRUE, 1),
(11, 'Achievement by a deadline', 'Thành tựu trước hạn chót', 'Used to talk about accomplishments expected by a certain time.', 'Dùng để nói về thành tựu dự kiến trước thời điểm nhất định.', 'EmojiEvents', TRUE, 2),
(11, 'Duration by a future point', 'Thời lượng tính đến mốc tương lai', 'Used with for/since to describe how long something will have lasted.', 'Dùng với for/since để mô tả điều gì đó sẽ kéo dài bao lâu.', 'HourglassEmpty', TRUE, 3);

-- Examples for usage 33 (IDs 61-62)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(33, 'By 6 PM, I will have finished my work.', 'Đến 6 giờ chiều, tôi sẽ hoàn thành xong công việc.', '"By 6 PM" = deadline. The work will be complete before then.', '"Đến 6 giờ chiều" = hạn chót. Công việc sẽ xong trước đó.', 'will have finished', 1),
(33, 'By the time you arrive, we will have eaten dinner.', 'Khi bạn đến, chúng tôi sẽ ăn tối xong rồi.', '"By the time" + present tense for future → main clause uses Future Perfect.', '"By the time" + hiện tại đơn cho tương lai → mệnh đề chính dùng TLHT.', 'will have eaten', 2);

-- Examples for usage 34 (IDs 63-64)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(34, 'By next year, she will have written her first novel.', 'Đến năm tới, cô ấy sẽ viết xong cuốn tiểu thuyết đầu tiên.', 'Expected accomplishment by a future milestone.', 'Thành tựu dự kiến trước mốc tương lai.', 'will have written', 1),
(34, 'By 2030, they will have built 100 schools.', 'Đến năm 2030, họ sẽ xây xong 100 trường học.', 'Future achievement with a specific target date.', 'Thành tựu tương lai với mốc thời gian cụ thể.', 'will have built', 2);

-- Examples for usage 35 (IDs 65-66)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(35, 'By next month, I will have lived here for ten years.', 'Đến tháng tới, tôi sẽ sống ở đây được mười năm.', '"For ten years" = duration counted up to the future point.', '"Mười năm" = thời lượng tính đến mốc tương lai.', 'will have lived', 1),
(35, 'By December, she will have worked here for five years.', 'Đến tháng 12, cô ấy sẽ làm việc ở đây được năm năm.', 'Duration of employment counted to a future deadline.', 'Thời gian làm việc tính đến mốc tương lai.', 'will have worked', 2);

-- Signal words (IDs 65-70)
INSERT INTO signal_word (lesson_id, word, word_vi, category, example_sentence, example_vi, position, note, order_index) VALUES
(11, 'by', 'trước/đến', 'time', 'I will have left by 5 PM.', 'Tôi sẽ đi trước 5 giờ chiều.', 'end', 'Từ tín hiệu quan trọng nhất của TLHT', 1),
(11, 'by the time', 'vào lúc/khi', 'time', 'By the time you wake up, I will have left.', 'Khi bạn thức dậy, tôi sẽ đi rồi.', 'beginning', NULL, 2),
(11, 'before', 'trước khi', 'sequence', 'She will have finished before noon.', 'Cô ấy sẽ xong trước trưa.', 'end', NULL, 3),
(11, 'by next year', 'đến năm tới', 'time', 'By next year, he will have graduated.', 'Đến năm tới, anh ấy sẽ tốt nghiệp.', 'beginning', NULL, 4),
(11, 'by then', 'đến lúc đó', 'time', 'Don''t worry, I will have finished by then.', 'Đừng lo, tôi sẽ xong trước lúc đó.', 'end', NULL, 5),
(11, 'in two years', 'trong hai năm nữa', 'time', 'In two years, she will have completed her PhD.', 'Trong hai năm nữa, cô ấy sẽ hoàn thành tiến sĩ.', 'beginning', NULL, 6);

-- Tips (IDs 32-34)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(11, '"By" is the key signal', '"By" là từ tín hiệu chính', 'Almost every Future Perfect sentence contains "by" (by 5 PM, by next year, by the time...). If you see "by" + future time, think Future Perfect.', 'Hầu hết câu TLHT đều chứa "by" (by 5 PM, by next year, by the time...). Nếu thấy "by" + thời gian tương lai, nghĩ đến TLHT.', 'memory', 'high', 'Lightbulb', 1),
(11, 'Don''t confuse with Simple Future', 'Đừng nhầm với Tương lai đơn', '"I will finish at 5 PM" (moment of completion) vs "I will have finished by 5 PM" (completed before that time). Future Perfect emphasizes BEFORE the deadline.', '"I will finish at 5 PM" (thời điểm hoàn thành) vs "I will have finished by 5 PM" (xong trước thời điểm đó). TLHT nhấn mạnh TRƯỚC hạn chót.', 'comparison', 'high', 'Compare', 2),
(11, 'By the time + Simple Present', 'By the time + Hiện tại đơn', '"By the time" + Simple Present (not "will"): "By the time you arrive" NOT "By the time you will arrive." Same rule as other time clauses.', '"By the time" + Hiện tại đơn (không dùng "will"): "By the time you arrive" KHÔNG PHẢI "By the time you will arrive." Cùng quy tắc với mệnh đề thời gian khác.', 'common_mistake', 'medium', 'Warning', 3);

-- Comparison (ID 13)
INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(11, 12, 'Completion vs Duration', 'Hoàn thành vs Thời lượng', 'Emphasizes completion/result by future time', 'Nhấn mạnh hoàn thành/kết quả trước thời điểm tương lai', 'Emphasizes duration of ongoing action up to future time', 'Nhấn mạnh thời lượng hành động đang diễn ra đến thời điểm tương lai', 'By June, I will have read 20 books. (result: 20 books)', 'Đến tháng 6, tôi sẽ đọc xong 20 cuốn. (kết quả: 20 cuốn)', 'By June, I will have been reading for 6 months. (duration: 6 months)', 'Đến tháng 6, tôi sẽ đọc được 6 tháng. (thời lượng: 6 tháng)', 'Result/number = FP. Duration/process = FPC.', 'Kết quả/số lượng = TLHT. Thời lượng/quá trình = TLHTTD.', 1);

-- Exercise 71: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(11, 'multiple_choice', 'medium', 'Choose the correct form.', 'Chọn dạng đúng.', 'By next June, she ___ from university.', 'Đến tháng 6 tới, cô ấy ___ đại học.', '"By next June" = future deadline. Graduation will be complete before then → Future Perfect.', '"Đến tháng 6 tới" = hạn tương lai. Tốt nghiệp sẽ hoàn thành trước đó → TLHT.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(71, 'A', 'will have graduated', TRUE, 'Correct! Completed before future time = Future Perfect', 1),
(71, 'B', 'will graduate', FALSE, 'Simple Future — no "before deadline" emphasis', 2),
(71, 'C', 'will be graduating', FALSE, 'Future Continuous — in progress, not completed', 3),
(71, 'D', 'graduates', FALSE, 'Simple Present — wrong tense for future completion', 4);

-- Exercise 72: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(11, 'fill_blank', 'medium', 'Complete with will have + V3.', 'Hoàn thành với will have + V3.', 'By the time you arrive, I ___ (cook) dinner.', 'Khi bạn đến, tôi ___ (nấu) bữa tối xong.', 'will have cooked', '"By the time you arrive" = before your arrival → Future Perfect. Cook → cooked (regular V3).', '"Khi bạn đến" = trước khi đến → TLHT. Cook → cooked (V3 có quy tắc).', 10, 2);

-- Exercise 73: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(11, 'error_correction', 'medium', 'Find and correct the error.', 'Tìm và sửa lỗi.', 'By the time you will arrive, I will have left.', 'By the time bạn will arrive, tôi sẽ đi rồi.', 'By the time you arrive, I will have left.', '"By the time" introduces a time clause — use Simple Present, not "will".', '"By the time" mở đầu mệnh đề thời gian — dùng Hiện tại đơn, không dùng "will".', 'Check the tense in the time clause.', 'Kiểm tra thì trong mệnh đề thời gian.', 15, 3);

-- Exercise 74: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(11, 'sentence_transform', 'medium', 'Rewrite using "by next year".', 'Viết lại dùng "by next year".', 'She will save $10,000 next year.', 'Cô ấy sẽ tiết kiệm $10,000 năm tới.', 'By next year, she will have saved $10,000.', '"By next year" = completed before that time → Future Perfect: will have saved.', '"By next year" = hoàn thành trước thời điểm đó → TLHT: will have saved.', 15, 4);

-- Exercise 75: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(11, 'arrange_words', 'medium', 'Arrange to make a correct sentence.', 'Sắp xếp thành câu đúng.', '["will", "by Friday", "have", "I", "the report", "finished"]', 'By Friday, I will have finished the report.', 'By + Time (Friday) + S (I) + will + have + V3 (finished) + Object (the report).', 'By + Thời gian (Friday) + S (I) + will + have + V3 (finished) + Tân ngữ (the report).', 10, 5);

-- Exercise 76: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(11, 'matching', 'medium', 'Match the deadline with the achievement.', 'Nối hạn chót với thành tựu.', 'Future Perfect expresses what will be done by each deadline.', 'TLHT diễn tả điều sẽ hoàn thành trước mỗi hạn chót.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(76, 'By 2030', 'Đến năm 2030', 'will have built a new airport', 'sẽ xây xong sân bay mới', 1),
(76, 'By December', 'Đến tháng 12', 'will have completed the course', 'sẽ hoàn thành khóa học', 2),
(76, 'By next month', 'Đến tháng tới', 'will have moved to a new house', 'sẽ chuyển sang nhà mới', 3),
(76, 'By this evening', 'Đến tối nay', 'will have finished the book', 'sẽ đọc xong cuốn sách', 4);

-- Exercise 77: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(11, 'true_false', 'medium', 'Is this sentence correct?', 'Câu này đúng không?', 'By next year, I will have been living here for ten years.', 'Đến năm tới, tôi sẽ sống ở đây được mười năm.', 'true', 'This is actually Future Perfect Continuous (will have been living), but it is grammatically correct. With "live" + "for", both FP and FPC are acceptable.', 'Đây thực ra là TLHTTD (will have been living), nhưng ngữ pháp đúng. Với "live" + "for", cả TLHT và TLHTTD đều được.', 5, 7);


-- ############################################################################
-- LESSON 12: FUTURE PERFECT CONTINUOUS (lesson_id = 12)
-- ############################################################################

-- Formulas (IDs 34-36)
INSERT INTO formula (lesson_id, type, subject_note, structure, structure_vi, example, example_vi, note, order_index) VALUES
(12, 'affirmative', 'All subjects + will have been', 'S + will + have + been + V-ing', 'Chủ ngữ + will + have + been + V-ing', 'By June, I will have been working here for five years.', 'Đến tháng 6, tôi sẽ làm việc ở đây được năm năm.', 'Nhấn mạnh thời lượng liên tục đến mốc tương lai', 1),
(12, 'negative', NULL, 'S + will + not + have + been + V-ing', 'Chủ ngữ + will + not + have + been + V-ing', 'She won''t have been waiting long.', 'Cô ấy sẽ không đợi lâu.', 'Viết tắt: will not have been = won''t have been', 2),
(12, 'interrogative', NULL, 'Will + S + have + been + V-ing?', 'Will + Chủ ngữ + have + been + V-ing?', 'How long will you have been studying by graduation?', 'Bạn sẽ học được bao lâu tính đến lúc tốt nghiệp?', 'Thường dùng với How long...?', 3);

-- Usages (IDs 36-38)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(12, 'Duration up to a future point', 'Thời lượng đến mốc tương lai', 'Emphasizes how long an action will have been in progress by a future time.', 'Nhấn mạnh hành động sẽ diễn ra bao lâu tính đến thời điểm tương lai.', 'HourglassEmpty', TRUE, 1),
(12, 'Cause of future result', 'Nguyên nhân của kết quả tương lai', 'The ongoing action up to a future point will cause a result.', 'Hành động liên tục đến mốc tương lai sẽ gây ra kết quả.', 'TrendingUp', TRUE, 2),
(12, 'Emphasis on continuous process', 'Nhấn mạnh quá trình liên tục', 'Stresses that an activity has been ongoing and will continue up to a future point.', 'Nhấn mạnh hoạt động đã và sẽ tiếp tục diễn ra đến mốc tương lai.', 'Loop', FALSE, 3);

-- Examples for usage 36 (IDs 67-68)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(36, 'By next month, I will have been living here for ten years.', 'Đến tháng tới, tôi sẽ sống ở đây được mười năm.', '"For ten years" emphasizes the duration up to the future point.', '"Mười năm" nhấn mạnh thời lượng đến mốc tương lai.', 'will have been living', 1),
(36, 'By 5 PM, she will have been working for eight hours.', 'Đến 5 giờ chiều, cô ấy sẽ làm việc được tám tiếng.', 'Duration of working counted up to 5 PM.', 'Thời lượng làm việc tính đến 5 giờ chiều.', 'will have been working', 2);

-- Examples for usage 37 (IDs 69-70)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(37, 'He will be tired because he will have been traveling all day.', 'Anh ấy sẽ mệt vì sẽ đi du lịch cả ngày.', 'The continuous traveling will cause tiredness.', 'Việc đi du lịch liên tục sẽ gây mệt mỏi.', 'will have been traveling', 1),
(37, 'By the time the marathon ends, they will have been running for hours.', 'Khi marathon kết thúc, họ sẽ chạy được nhiều tiếng.', 'The ongoing running will result in exhaustion.', 'Việc chạy liên tục sẽ dẫn đến kiệt sức.', 'will have been running', 2);

-- Examples for usage 38 (IDs 71-72)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(38, 'By 2030, scientists will have been researching this topic for 20 years.', 'Đến 2030, các nhà khoa học sẽ nghiên cứu đề tài này được 20 năm.', 'Emphasizes the continuous, ongoing nature of the research.', 'Nhấn mạnh tính liên tục, đang diễn ra của nghiên cứu.', 'will have been researching', 1),
(38, 'Next year, we will have been studying English for six years.', 'Năm tới, chúng tôi sẽ học tiếng Anh được sáu năm.', 'The studying process has been continuous and will reach 6 years.', 'Quá trình học đã liên tục và sẽ đạt 6 năm.', 'will have been studying', 2);

-- Signal words (IDs 71-76)
INSERT INTO signal_word (lesson_id, word, word_vi, category, example_sentence, example_vi, position, note, order_index) VALUES
(12, 'by', 'trước/đến', 'time', 'By Friday, I will have been working for 5 days.', 'Đến thứ Sáu, tôi sẽ làm việc được 5 ngày.', 'beginning', 'Từ tín hiệu chính', 1),
(12, 'by the time', 'vào lúc', 'time', 'By the time she arrives, we will have been waiting for hours.', 'Khi cô ấy đến, chúng tôi sẽ đợi được nhiều tiếng.', 'beginning', NULL, 2),
(12, 'for + duration', 'trong + thời lượng', 'duration', 'She will have been teaching for 30 years.', 'Cô ấy sẽ dạy học được 30 năm.', 'end', 'for + khoảng thời gian', 3),
(12, 'by next year', 'đến năm tới', 'time', 'By next year, he will have been living abroad for a decade.', 'Đến năm tới, anh ấy sẽ sống nước ngoài được một thập kỷ.', 'beginning', NULL, 4),
(12, 'how long', 'bao lâu', 'duration', 'How long will you have been studying by graduation?', 'Bạn sẽ học được bao lâu tính đến lúc tốt nghiệp?', 'beginning', 'Dùng trong câu hỏi', 5),
(12, 'all day/week/month', 'cả ngày/tuần/tháng', 'duration', 'By evening, it will have been raining all day.', 'Đến chiều, trời sẽ mưa cả ngày.', 'end', NULL, 6);

-- Tips (IDs 35-37)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(12, 'FPC vs Future Perfect', 'TLHTTD vs TLHT', 'FPC emphasizes DURATION (how long), FP emphasizes RESULT (how much/many). "By June, I will have been reading for 6 months" (duration) vs "By June, I will have read 20 books" (result).', 'TLHTTD nhấn mạnh THỜI LƯỢNG (bao lâu), TLHT nhấn mạnh KẾT QUẢ (bao nhiêu). "Đến tháng 6, tôi sẽ đọc được 6 tháng" (thời lượng) vs "Đến tháng 6, tôi sẽ đọc xong 20 cuốn" (kết quả).', 'comparison', 'high', 'Compare', 1),
(12, 'Rarest English tense', 'Thì hiếm nhất trong tiếng Anh', 'Future Perfect Continuous is the rarest tense in everyday English. Native speakers often simplify: "By June, I will have worked here for 5 years" (FP instead of FPC). Both are correct with duration verbs.', 'TLHTTD là thì hiếm nhất trong tiếng Anh hàng ngày. Người bản ngữ thường đơn giản hóa: "By June, I will have worked here for 5 years" (TLHT thay TLHTTD). Cả hai đều đúng với động từ thời lượng.', 'native_usage', 'medium', 'Lightbulb', 2),
(12, 'No stative verbs', 'Không dùng động từ trạng thái', 'Like all continuous tenses, no stative verbs: "I will have been knowing" is wrong. Use Future Perfect: "I will have known."', 'Giống tất cả thì tiếp diễn, không dùng động từ trạng thái: "I will have been knowing" sai. Dùng TLHT: "I will have known."', 'common_mistake', 'high', 'Warning', 3);

-- Comparison (ID 14)
INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(11, 12, 'Duration vs Completion', 'Thời lượng vs Hoàn thành', 'Emphasizes completion/achievement by future point', 'Nhấn mạnh hoàn thành/thành tựu trước mốc tương lai', 'Emphasizes duration of continuous action up to future point', 'Nhấn mạnh thời lượng hành động liên tục đến mốc tương lai', 'By June, I will have completed my degree. (finished achievement)', 'Đến tháng 6, tôi sẽ hoàn thành bằng cấp. (thành tựu xong)', 'By June, I will have been studying for 4 years. (ongoing process)', 'Đến tháng 6, tôi sẽ học được 4 năm. (quá trình đang diễn ra)', 'How long? → FPC. How much/achievement? → FP.', 'Bao lâu? → TLHTTD. Bao nhiêu/thành tựu? → TLHT.', 1);

-- Exercise 78: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(12, 'multiple_choice', 'hard', 'Choose the correct form.', 'Chọn dạng đúng.', 'By next year, she ___ English for ten years.', 'Đến năm tới, cô ấy ___ tiếng Anh được mười năm.', '"For ten years" emphasizes duration up to a future point → Future Perfect Continuous.', '"Mười năm" nhấn mạnh thời lượng đến mốc tương lai → TLHTTD.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(78, 'A', 'will have been studying', TRUE, 'Correct! Duration emphasis to future point = FPC', 1),
(78, 'B', 'will have studied', FALSE, 'Future Perfect — emphasizes completion, not duration', 2),
(78, 'C', 'will be studying', FALSE, 'Future Continuous — no "by + deadline" aspect', 3),
(78, 'D', 'will study', FALSE, 'Simple Future — no duration or deadline emphasis', 4);

-- Exercise 79: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(12, 'fill_blank', 'hard', 'Complete the sentence.', 'Hoàn thành câu.', 'By 5 PM, they ___ (wait) for three hours.', 'Đến 5 giờ chiều, họ ___ (đợi) được ba tiếng.', 'will have been waiting', '"For three hours" + "by 5 PM" = duration up to future point → will have been waiting.', '"Ba tiếng" + "đến 5 giờ" = thời lượng đến mốc tương lai → will have been waiting.', 10, 2);

-- Exercise 80: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(12, 'error_correction', 'hard', 'Find and correct the error.', 'Tìm và sửa lỗi.', 'By next year, I will have been knowing her for a decade.', 'Đến năm tới, tôi will have been knowing cô ấy một thập kỷ.', 'By next year, I will have known her for a decade.', '"Know" is a stative verb — cannot use continuous. Use Future Perfect: will have known.', '"Know" là động từ trạng thái — không dùng tiếp diễn. Dùng TLHT: will have known.', 'Is this an action verb or a state verb?', 'Đây là động từ hành động hay trạng thái?', 15, 3);

-- Exercise 81: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(12, 'sentence_transform', 'hard', 'Rewrite emphasizing duration with "by the time".', 'Viết lại nhấn mạnh thời lượng với "by the time".', 'She will teach for 30 years. Then she will retire.', 'Cô ấy sẽ dạy 30 năm. Sau đó sẽ nghỉ hưu.', 'By the time she retires, she will have been teaching for 30 years.', '"By the time" + Simple Present, main clause → FPC with "for 30 years" (duration).', '"By the time" + Hiện tại đơn, mệnh đề chính → TLHTTD với "30 năm" (thời lượng).', 15, 4);

-- Exercise 82: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(12, 'arrange_words', 'hard', 'Arrange to make a correct sentence.', 'Sắp xếp thành câu đúng.', '["will", "have", "been", "by June", "for", "she", "working", "five years"]', 'By June, she will have been working for five years.', 'By + Time (June) + S (she) + will + have + been + V-ing (working) + Duration (for five years).', 'By + Thời gian (June) + S (she) + will + have + been + V-ing (working) + Thời lượng (for five years).', 10, 5);

-- Exercise 83: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(12, 'matching', 'hard', 'Match the duration with the future deadline.', 'Nối thời lượng với mốc tương lai.', 'FPC expresses how long an action will have been ongoing by a deadline.', 'TLHTTD diễn tả hành động sẽ diễn ra bao lâu tính đến mốc.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(83, 'will have been studying for 4 years', 'sẽ học được 4 năm', 'by graduation', 'đến lúc tốt nghiệp', 1),
(83, 'will have been working for 8 hours', 'sẽ làm việc được 8 tiếng', 'by 5 PM', 'đến 5 giờ chiều', 2),
(83, 'will have been living here for a decade', 'sẽ sống ở đây được một thập kỷ', 'by next year', 'đến năm tới', 3),
(83, 'will have been driving for 6 hours', 'sẽ lái xe được 6 tiếng', 'by the time we arrive', 'khi chúng tôi đến', 4);

-- Exercise 84: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(12, 'true_false', 'hard', 'Is this sentence correct?', 'Câu này đúng không?', 'By the end of this year, he will have been working at this company for twenty years.', 'Đến cuối năm nay, anh ấy sẽ làm việc ở công ty này được hai mươi năm.', 'true', 'Correct! "By the end of this year" (future deadline) + "for twenty years" (duration) = Future Perfect Continuous.', 'Đúng! "Đến cuối năm nay" (mốc tương lai) + "hai mươi năm" (thời lượng) = TLHTTD.', 5, 7);


-- ############################################################################
-- ############################################################################
-- CATEGORY 4: LEARNING METHODS (Phương Pháp Học Tập)
-- Non-grammar content — proves the Learning Hub is truly multi-domain
-- No formulas, no signal_words — uses usages, tips, exercises only
-- ############################################################################
-- ############################################################################

INSERT INTO category (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('Learning Methods', 'Phương Pháp Học Tập', 'Science-backed techniques for effective learning and memory retention', 'Các kỹ thuật học tập hiệu quả dựa trên khoa học về trí nhớ', 'Psychology', '#ec4899', 4);


-- ############################################################################
-- LESSON 13: SPACED REPETITION (lesson_id = 13)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(4, 'Spaced Repetition', 'Ôn Tập Giãn Cách', 'spaced-repetition', 'Space out your study sessions to maximize long-term retention', 'Giãn cách các buổi ôn tập để tối đa hóa trí nhớ dài hạn', 'beginner', 25, 1);

-- Usages (IDs 39-41)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(13, 'Long-term memory retention', 'Ghi nhớ dài hạn', 'Schedule reviews at increasing intervals to move information from short-term to long-term memory.', 'Lên lịch ôn tập với khoảng cách tăng dần để chuyển thông tin từ trí nhớ ngắn hạn sang dài hạn.', 'Psychology', TRUE, 1),
(13, 'Efficient exam preparation', 'Chuẩn bị thi hiệu quả', 'Start reviewing weeks before the exam with spaced sessions instead of last-minute cramming.', 'Bắt đầu ôn tập từ vài tuần trước kỳ thi với các buổi giãn cách thay vì học nhồi nhét phút cuối.', 'School', TRUE, 2),
(13, 'Mastering large volumes of material', 'Chinh phục lượng kiến thức lớn', 'Use spaced repetition to systematically learn thousands of vocabulary words, formulas, or facts.', 'Sử dụng ôn tập giãn cách để học có hệ thống hàng nghìn từ vựng, công thức, hay dữ kiện.', 'MenuBook', TRUE, 3);

-- Examples for usage 39 (IDs 72-73)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(39, 'Review new vocabulary after 1 day, then 3 days, then 7 days, then 30 days.', 'Ôn từ vựng mới sau 1 ngày, rồi 3 ngày, rồi 7 ngày, rồi 30 ngày.', 'Each review strengthens the memory trace, making it harder to forget.', 'Mỗi lần ôn tập củng cố vết nhớ, giúp khó quên hơn.', 'increasing intervals', 1),
(39, 'The Ebbinghaus forgetting curve shows we forget ~70% within 24 hours without review.', 'Đường cong quên lãng Ebbinghaus cho thấy ta quên ~70% trong 24 giờ nếu không ôn tập.', 'Spaced repetition directly combats the forgetting curve by timing reviews optimally.', 'Ôn tập giãn cách chống lại đường cong quên lãng bằng cách ôn đúng thời điểm.', 'forgetting curve', 2);

-- Examples for usage 40 (IDs 74-75)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(40, 'Start reviewing 3 weeks before the exam, spacing sessions every 2-3 days.', 'Bắt đầu ôn 3 tuần trước kỳ thi, giãn cách mỗi 2-3 ngày.', 'This gives your brain multiple chances to consolidate the material.', 'Điều này cho não nhiều cơ hội để củng cố kiến thức.', 'spacing sessions', 1),
(40, 'Instead of studying 8 hours the night before, study 1 hour daily for 8 days.', 'Thay vì học 8 tiếng đêm trước thi, hãy học 1 tiếng mỗi ngày trong 8 ngày.', 'Same total time, but distributed practice produces much better retention.', 'Cùng tổng thời gian, nhưng luyện tập phân tán cho kết quả nhớ tốt hơn nhiều.', 'distributed practice', 2);

-- Examples for usage 41 (IDs 76-77)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(41, 'Medical students use Anki flashcards to memorize thousands of anatomy terms over months.', 'Sinh viên y khoa dùng thẻ Anki để ghi nhớ hàng nghìn thuật ngữ giải phẫu qua nhiều tháng.', 'Spaced repetition software automatically schedules reviews at optimal intervals.', 'Phần mềm ôn tập giãn cách tự động lên lịch ôn ở khoảng cách tối ưu.', 'Anki flashcards', 1),
(41, 'Language learners maintain 5,000+ word vocabulary with just 15 minutes of daily review.', 'Người học ngôn ngữ duy trì 5.000+ từ vựng chỉ với 15 phút ôn tập mỗi ngày.', 'Once material is well-learned, review intervals stretch to weeks or months.', 'Khi kiến thức đã thuộc kỹ, khoảng cách ôn tập kéo dài đến vài tuần hoặc tháng.', 'daily review', 2);

-- Tips (IDs 38-40)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(13, 'The forgetting curve', 'Đường cong quên lãng', 'Hermann Ebbinghaus discovered that memory declines exponentially after learning. The optimal time to review is just BEFORE you forget — this strengthens the memory most effectively.', 'Hermann Ebbinghaus phát hiện rằng trí nhớ suy giảm theo hàm mũ sau khi học. Thời điểm tốt nhất để ôn là ngay TRƯỚC khi bạn quên — điều này củng cố trí nhớ hiệu quả nhất.', 'memory', 'high', 'Lightbulb', 1),
(13, 'Optimal review intervals', 'Khoảng cách ôn tập tối ưu', 'A proven schedule: 1 day → 3 days → 7 days → 14 days → 30 days → 90 days. Each successful review doubles the interval. If you forget, reset to a shorter interval.', 'Lịch trình đã được chứng minh: 1 ngày → 3 ngày → 7 ngày → 14 ngày → 30 ngày → 90 ngày. Mỗi lần ôn thành công, khoảng cách tăng gấp đôi. Nếu quên, quay lại khoảng ngắn hơn.', 'memory', 'high', 'Schedule', 2),
(13, 'Don''t cram — space it out', 'Đừng nhồi nhét — hãy giãn cách', 'Research shows: 1 hour across 4 days beats 4 hours in 1 day. Cramming creates short-term memory that fades within days. Spacing creates long-term memory that lasts months or years.', 'Nghiên cứu cho thấy: 1 tiếng trong 4 ngày hiệu quả hơn 4 tiếng trong 1 ngày. Nhồi nhét tạo trí nhớ ngắn hạn tan biến trong vài ngày. Giãn cách tạo trí nhớ dài hạn kéo dài hàng tháng hoặc năm.', 'common_mistake', 'high', 'Warning', 3);

-- Exercise 85: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(13, 'multiple_choice', 'easy', 'What happens to newly learned information without review?', 'Điều gì xảy ra với thông tin mới học nếu không ôn tập?', 'According to the Ebbinghaus forgetting curve, what percentage of new information is typically forgotten within 24 hours?', 'Theo đường cong quên lãng Ebbinghaus, bao nhiêu phần trăm thông tin mới thường bị quên trong 24 giờ?', 'Ebbinghaus found that approximately 70% of newly learned information is forgotten within 24 hours without any review.', 'Ebbinghaus phát hiện rằng khoảng 70% thông tin mới học bị quên trong 24 giờ nếu không ôn tập.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(85, 'A', 'About 10%', FALSE, 'This is too low — memory loss is much more dramatic than this', 1),
(85, 'B', 'About 30%', FALSE, 'This underestimates the forgetting curve', 2),
(85, 'C', 'About 70%', TRUE, 'Correct! We forget approximately 70% within 24 hours without review', 3),
(85, 'D', 'About 95%', FALSE, 'While memory loss is significant, we do retain some information', 4);

-- Exercise 86: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(13, 'fill_blank', 'easy', 'Fill in the key term.', 'Điền thuật ngữ chính.', 'The ___ curve describes how memory of new information declines over time without reinforcement.', 'Đường cong ___ mô tả cách trí nhớ về thông tin mới suy giảm theo thời gian nếu không được củng cố.', 'forgetting', 'The forgetting curve, discovered by Hermann Ebbinghaus in 1885, shows the exponential decline of memory over time.', 'Đường cong quên lãng, được Hermann Ebbinghaus phát hiện năm 1885, cho thấy sự suy giảm theo hàm mũ của trí nhớ theo thời gian.', 10, 2);

-- Exercise 87: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(13, 'error_correction', 'medium', 'Find and correct the factual error in this statement.', 'Tìm và sửa lỗi sai trong phát biểu sau.', 'Studying the same material 5 times in one day is more effective than studying it once on 5 different days.', 'Học cùng một tài liệu 5 lần trong một ngày hiệu quả hơn học 1 lần trong 5 ngày khác nhau.', 'Studying the same material once on 5 different days is more effective than studying it 5 times in one day.', 'Distributed practice across multiple days is always more effective than massed practice in a single day. This is a core principle of spaced repetition.', 'Phân tán luyện tập (distributed practice) qua nhiều ngày luôn hiệu quả hơn luyện tập tập trung (massed practice) trong một ngày. Đây là nguyên tắc cốt lõi của ôn tập giãn cách.', 'Think about which approach — cramming or spacing — research supports.', 'Hãy nghĩ xem nghiên cứu ủng hộ cách nào — nhồi nhét hay giãn cách.', 15, 3);

-- Exercise 88: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(13, 'sentence_transform', 'medium', 'Rewrite this cramming plan as a spaced repetition plan. Keep the total study time the same.', 'Viết lại kế hoạch nhồi nhét thành kế hoạch ôn tập giãn cách. Giữ nguyên tổng thời gian học.', 'Study for 6 hours the night before the exam.', 'Học 6 tiếng đêm trước kỳ thi.', 'Study for 1 hour daily for 6 days before the exam.', 'Same total time (6 hours) but distributed across 6 days instead of crammed into 1 night. Research shows this is 2-3x more effective.', 'Cùng tổng thời gian (6 giờ) nhưng phân bố qua 6 ngày thay vì dồn vào 1 đêm. Nghiên cứu cho thấy cách này hiệu quả hơn 2-3 lần.', 15, 4);

-- Exercise 89: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(13, 'arrange_words', 'easy', 'Arrange these review intervals in the correct order for a spaced repetition schedule.', 'Sắp xếp các khoảng cách ôn tập theo đúng thứ tự cho lịch ôn tập giãn cách.', '["30 days", "1 day", "14 days", "3 days", "7 days"]', '1 day, 3 days, 7 days, 14 days, 30 days', 'The intervals increase gradually: 1 → 3 → 7 → 14 → 30 days. Each successful review roughly doubles the interval.', 'Khoảng cách tăng dần: 1 → 3 → 7 → 14 → 30 ngày. Mỗi lần ôn thành công, khoảng cách tăng gấp đôi.', 10, 5);

-- Exercise 90: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(13, 'matching', 'easy', 'Match each study approach with its result.', 'Nối mỗi cách học với kết quả của nó.', 'Distributed practice (spacing) creates durable long-term memories, while massed practice (cramming) only creates temporary short-term memories.', 'Luyện tập phân tán (giãn cách) tạo trí nhớ dài hạn bền vững, trong khi luyện tập tập trung (nhồi nhét) chỉ tạo trí nhớ ngắn hạn tạm thời.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(90, 'Cramming 8 hours in 1 day', 'Nhồi nhét 8 tiếng trong 1 ngày', 'Short-term memory only', 'Chỉ trí nhớ ngắn hạn', 1),
(90, 'Spacing 1 hour across 8 days', 'Giãn cách 1 tiếng trong 8 ngày', 'Strong long-term memory', 'Trí nhớ dài hạn bền vững', 2),
(90, 'Reviewing just before forgetting', 'Ôn ngay trước khi quên', 'Maximum memory strengthening', 'Củng cố trí nhớ tối đa', 3),
(90, 'Never reviewing after learning', 'Không bao giờ ôn sau khi học', 'Forget 70% within 24 hours', 'Quên 70% trong 24 giờ', 4);

-- Exercise 91: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(13, 'true_false', 'easy', 'Is this statement about spaced repetition correct?', 'Phát biểu sau về ôn tập giãn cách có đúng không?', 'Reviewing material 5 times in one day is equally effective as reviewing it once on each of 5 different days.', 'Ôn tài liệu 5 lần trong một ngày hiệu quả tương đương với ôn 1 lần trong mỗi ngày của 5 ngày khác nhau.', 'false', 'False! Research consistently shows that spaced practice across multiple days is significantly more effective than massed practice in a single session, even with the same total study time.', 'Sai! Nghiên cứu cho thấy luyện tập giãn cách qua nhiều ngày hiệu quả hơn đáng kể so với luyện tập dồn vào một buổi, ngay cả khi tổng thời gian học bằng nhau.', 5, 7);


-- ############################################################################
-- LESSON 14: ACTIVE RECALL (lesson_id = 14)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(4, 'Active Recall', 'Nhớ Lại Chủ Động', 'active-recall', 'Test yourself instead of re-reading to learn 2-3x faster', 'Tự kiểm tra thay vì đọc lại để học nhanh hơn 2-3 lần', 'beginner', 25, 2);

-- Usages (IDs 42-44)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(14, 'Self-testing during study', 'Tự kiểm tra khi học', 'Close your books and try to recall the material from memory before checking your notes.', 'Đóng sách lại và cố gắng nhớ lại kiến thức từ trí nhớ trước khi kiểm tra ghi chú.', 'Quiz', TRUE, 1),
(14, 'Transforming notes into questions', 'Biến ghi chú thành câu hỏi', 'Instead of passively reading notes, convert them into questions and answer from memory.', 'Thay vì đọc ghi chú thụ động, hãy chuyển chúng thành câu hỏi và trả lời từ trí nhớ.', 'HelpOutline', TRUE, 2),
(14, 'Identifying knowledge gaps', 'Phát hiện lỗ hổng kiến thức', 'When you cannot recall something, you have found exactly what needs more study.', 'Khi bạn không thể nhớ lại điều gì đó, bạn đã tìm ra chính xác phần cần học thêm.', 'Search', TRUE, 3);

-- Examples for usage 42 (IDs 78-79)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(42, 'After reading a chapter, close the book and write down everything you remember.', 'Sau khi đọc một chương, đóng sách lại và viết ra mọi thứ bạn nhớ.', 'The act of retrieving information strengthens neural pathways far more than re-reading.', 'Hành động truy xuất thông tin củng cố đường dẫn thần kinh nhiều hơn đọc lại.', 'close the book', 1),
(42, 'Use blank flashcards: read the question side, try to answer BEFORE flipping.', 'Dùng thẻ ghi nhớ: đọc mặt câu hỏi, cố trả lời TRƯỚC khi lật thẻ.', 'The struggle to recall is what builds memory — even failed attempts help learning.', 'Sự cố gắng nhớ lại chính là thứ xây dựng trí nhớ — ngay cả khi trả lời sai vẫn giúp học.', 'try to answer', 2);

-- Examples for usage 43 (IDs 80-81)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(43, 'Turn each heading in your textbook into a question: "What is X? How does X work?"', 'Biến mỗi tiêu đề trong sách thành câu hỏi: "X là gì? X hoạt động thế nào?"', 'This transforms passive reading into an active testing exercise.', 'Điều này biến việc đọc thụ động thành bài kiểm tra chủ động.', 'into a question', 1),
(43, 'After a lecture, write 5 questions covering the main points without looking at your notes.', 'Sau buổi giảng, viết 5 câu hỏi về các ý chính mà không nhìn ghi chú.', 'Creating questions forces you to identify what is important and tests your understanding.', 'Tạo câu hỏi buộc bạn xác định điều gì quan trọng và kiểm tra sự hiểu biết.', '5 questions', 2);

-- Examples for usage 44 (IDs 82-83)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(44, 'When you cannot answer your own question, you have found a gap to fill.', 'Khi không thể trả lời câu hỏi của chính mình, bạn đã tìm ra lỗ hổng cần lấp.', 'Knowledge gaps only become visible when you actively test yourself.', 'Lỗ hổng kiến thức chỉ lộ ra khi bạn chủ động tự kiểm tra.', 'found a gap', 1),
(44, 'Mark difficult flashcards separately and review them more frequently.', 'Đánh dấu riêng các thẻ khó và ôn chúng thường xuyên hơn.', 'Focusing extra effort on weak areas is more efficient than reviewing everything equally.', 'Tập trung nỗ lực vào điểm yếu hiệu quả hơn ôn mọi thứ đồng đều.', 'difficult flashcards', 2);

-- Tips (IDs 41-43)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(14, 'Struggle first, then check', 'Cố gắng nhớ trước, rồi mới kiểm tra', 'Always attempt to recall information BEFORE looking at the answer. The mental struggle of retrieval — even when you fail — strengthens memory more than passive review.', 'Luôn cố gắng nhớ lại thông tin TRƯỚC KHI nhìn đáp án. Sự cố gắng truy xuất — ngay cả khi thất bại — củng cố trí nhớ hơn ôn tập thụ động.', 'memory', 'high', 'Lightbulb', 1),
(14, 'Active recall beats re-reading by 50%', 'Nhớ lại chủ động hiệu quả hơn đọc lại 50%', 'A 2008 study by Karpicke & Roediger showed that students who tested themselves remembered 50% more than those who just re-read the material after one week.', 'Nghiên cứu năm 2008 của Karpicke & Roediger cho thấy sinh viên tự kiểm tra nhớ được nhiều hơn 50% so với sinh viên chỉ đọc lại sau một tuần.', 'memory', 'high', 'TrendingUp', 2),
(14, 'Combine with spaced repetition', 'Kết hợp với ôn tập giãn cách', 'Active recall + spaced repetition is the most powerful combination in learning science. Test yourself → space out reviews → test again at increasing intervals.', 'Nhớ lại chủ động + ôn tập giãn cách là bộ đôi mạnh nhất trong khoa học học tập. Tự kiểm tra → giãn cách ôn tập → kiểm tra lại với khoảng cách tăng dần.', 'shortcut', 'medium', 'AutoAwesome', 3);

-- Exercise 92: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(14, 'multiple_choice', 'easy', 'Which study method is proven to be MOST effective for long-term retention?', 'Phương pháp học nào được chứng minh HIỆU QUẢ NHẤT cho ghi nhớ dài hạn?', 'A student has 2 hours to study for next week''s exam. Which approach leads to the best results?', 'Một học sinh có 2 giờ để ôn cho kỳ thi tuần sau. Cách nào cho kết quả tốt nhất?', 'Research consistently shows that testing yourself (active recall) produces significantly better retention than passive review methods like re-reading or highlighting.', 'Nghiên cứu cho thấy tự kiểm tra (nhớ lại chủ động) giúp ghi nhớ tốt hơn đáng kể so với các phương pháp thụ động như đọc lại hay tô màu.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(92, 'A', 'Re-read the textbook chapters twice', FALSE, 'Re-reading feels productive but creates an illusion of learning', 1),
(92, 'B', 'Highlight the key sentences in different colors', FALSE, 'Highlighting is passive — it does not require retrieval from memory', 2),
(92, 'C', 'Close the book and test yourself on the material', TRUE, 'Correct! Active recall (self-testing) is the most effective study technique', 3),
(92, 'D', 'Copy the notes neatly into a new notebook', FALSE, 'Copying notes is passive transcription, not active learning', 4);

-- Exercise 93: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(14, 'fill_blank', 'easy', 'Fill in the key term.', 'Điền thuật ngữ chính.', 'Active ___ is the practice of retrieving information from memory without looking at the material.', 'Nhớ lại ___ là hành động truy xuất thông tin từ trí nhớ mà không nhìn tài liệu.', 'recall', 'Active recall (nhớ lại chủ động) forces your brain to retrieve information, which strengthens memory far more than passive re-reading.', 'Active recall (nhớ lại chủ động) buộc não truy xuất thông tin, củng cố trí nhớ hiệu quả hơn nhiều so với đọc lại thụ động.', 10, 2);

-- Exercise 94: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(14, 'error_correction', 'medium', 'This study advice contains a common misconception. Correct it.', 'Lời khuyên học tập này chứa một quan niệm sai phổ biến. Hãy sửa lại.', 'The best way to study is to re-read your notes until the material feels familiar.', 'Cách học tốt nhất là đọc lại ghi chú cho đến khi kiến thức cảm thấy quen thuộc.', 'The best way to study is to test yourself on the material until you can recall it from memory.', 'The feeling of "familiarity" from re-reading is not true learning. Only when you can retrieve information from memory without looking at the material do you truly understand it.', 'Cảm giác "quen thuộc" khi đọc lại không phải là học thật sự. Chỉ khi bạn có thể truy xuất thông tin từ trí nhớ mà không nhìn tài liệu thì mới là hiểu thật.', 'Think about passive vs active study methods.', 'Hãy nghĩ về phương pháp học thụ động và chủ động.', 15, 3);

-- Exercise 95: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(14, 'sentence_transform', 'medium', 'Transform this passive study habit into an active recall technique.', 'Chuyển thói quen học thụ động này thành kỹ thuật nhớ lại chủ động.', 'Read your notes three times before the exam.', 'Đọc ghi chú ba lần trước kỳ thi.', 'Test yourself on the material three times before the exam.', 'Replace "read your notes" (passive) with "test yourself" (active). Same number of repetitions but far more effective because it forces your brain to retrieve information.', 'Thay "đọc ghi chú" (thụ động) bằng "tự kiểm tra" (chủ động). Cùng số lần lặp lại nhưng hiệu quả gấp nhiều lần vì buộc não truy xuất thông tin.', 15, 4);

-- Exercise 96: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(14, 'arrange_words', 'easy', 'Arrange the steps of an active recall study session in the correct order.', 'Sắp xếp các bước của buổi học chủ động theo đúng thứ tự.', '["Check your answers against the material", "Read the study material once", "Close the book and write what you remember", "Review and fill in the gaps you missed"]', 'Read the study material once, Close the book and write what you remember, Check your answers against the material, Review and fill in the gaps you missed', 'The correct order is: Read → Close → Recall → Check → Fill gaps. The key step is closing the book before attempting to recall.', 'Thứ tự đúng: Đọc → Đóng sách → Nhớ lại → Kiểm tra → Bổ sung. Bước quan trọng nhất là đóng sách trước khi cố nhớ lại.', 10, 5);

-- Exercise 97: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(14, 'matching', 'easy', 'Match each study technique to whether it is passive or active learning.', 'Nối mỗi kỹ thuật học với loại hình học thụ động hoặc chủ động.', 'Active learning techniques require you to retrieve or produce information, while passive techniques only require you to receive information.', 'Kỹ thuật học chủ động yêu cầu bạn truy xuất hoặc tạo ra thông tin, trong khi kỹ thuật thụ động chỉ yêu cầu tiếp nhận thông tin.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(97, 'Re-reading highlighted notes', 'Đọc lại ghi chú đã tô màu', 'Passive learning', 'Học thụ động', 1),
(97, 'Testing yourself with flashcards', 'Tự kiểm tra bằng thẻ ghi nhớ', 'Active learning', 'Học chủ động', 2),
(97, 'Watching a lecture video twice', 'Xem video bài giảng hai lần', 'Passive learning', 'Học thụ động', 3),
(97, 'Writing a summary from memory', 'Viết tóm tắt từ trí nhớ', 'Active learning', 'Học chủ động', 4);

-- Exercise 98: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(14, 'true_false', 'easy', 'Is this statement about study techniques correct?', 'Phát biểu sau về kỹ thuật học tập có đúng không?', 'Re-reading highlighted notes is one of the most effective study techniques for long-term retention.', 'Đọc lại ghi chú đã tô màu là một trong những kỹ thuật học tập hiệu quả nhất cho ghi nhớ dài hạn.', 'false', 'False! Research by Dunlosky et al. (2013) rated re-reading and highlighting as having LOW utility for learning. Active recall (self-testing) and spaced practice were rated as having HIGH utility.', 'Sai! Nghiên cứu của Dunlosky et al. (2013) đánh giá đọc lại và tô màu có hiệu quả THẤP. Nhớ lại chủ động (tự kiểm tra) và ôn tập giãn cách được đánh giá hiệu quả CAO.', 5, 7);


-- ############################################################################
-- LESSON 15: THE FEYNMAN TECHNIQUE (lesson_id = 15)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(4, 'The Feynman Technique', 'Kỹ Thuật Feynman', 'feynman-technique', 'Explain concepts simply to find and fill gaps in understanding', 'Giải thích đơn giản để tìm và lấp đầy lỗ hổng kiến thức', 'intermediate', 30, 3);

-- Usages (IDs 45-47)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(15, 'Understanding complex concepts', 'Hiểu các khái niệm phức tạp', 'Break down difficult ideas by trying to explain them in simple, everyday language.', 'Phân tích các ý tưởng khó bằng cách giải thích chúng bằng ngôn ngữ đơn giản, đời thường.', 'Lightbulb', TRUE, 1),
(15, 'Identifying knowledge gaps', 'Phát hiện lỗ hổng kiến thức', 'When you struggle to explain something simply, you have found where your understanding is incomplete.', 'Khi bạn gặp khó khăn trong việc giải thích đơn giản, bạn đã tìm ra chỗ hiểu chưa đầy đủ.', 'Search', TRUE, 2),
(15, 'Teaching and explaining to others', 'Giảng dạy và giải thích cho người khác', 'Use the technique to prepare clear, jargon-free explanations for students or colleagues.', 'Sử dụng kỹ thuật để chuẩn bị các giải thích rõ ràng, không thuật ngữ cho học sinh hoặc đồng nghiệp.', 'School', TRUE, 3);

-- Examples for usage 45 (IDs 84-85)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(45, 'To understand photosynthesis, try explaining it as: "Plants eat sunlight and turn it into food."', 'Để hiểu quang hợp, hãy giải thích: "Cây ăn ánh sáng mặt trời và biến thành thức ăn."', 'Simple analogies reveal whether you truly understand the core mechanism.', 'Phép so sánh đơn giản cho thấy bạn có thật sự hiểu cơ chế cốt lõi hay không.', 'simple analogy', 1),
(45, 'If you cannot explain gravity without using the word "gravitational field," keep studying.', 'Nếu không thể giải thích trọng lực mà không dùng từ "trường hấp dẫn," hãy học thêm.', 'Reliance on jargon often masks gaps in understanding.', 'Phụ thuộc vào thuật ngữ thường che giấu lỗ hổng trong hiểu biết.', 'without jargon', 2);

-- Examples for usage 46 (IDs 86-87)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(46, 'Write an explanation of how the internet works. Where you get stuck is exactly where to study more.', 'Viết giải thích về cách internet hoạt động. Chỗ bạn bị kẹt chính là chỗ cần học thêm.', 'The Feynman Technique turns confusion into a precise study target.', 'Kỹ thuật Feynman biến sự bối rối thành mục tiêu học tập chính xác.', 'where you get stuck', 1),
(46, 'If your explanation uses the phrase "it just works," you have found a gap in your knowledge.', 'Nếu giải thích của bạn dùng cụm "nó cứ hoạt động thế thôi," bạn đã tìm ra lỗ hổng.', 'Vague hand-waving is a signal that deeper study is needed.', 'Giải thích mơ hồ là dấu hiệu cần nghiên cứu sâu hơn.', 'found a gap', 2);

-- Examples for usage 47 (IDs 88-89)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(47, 'Teaching a concept to a study partner forces you to organize your thoughts clearly.', 'Giảng một khái niệm cho bạn học buộc bạn sắp xếp suy nghĩ rõ ràng.', 'The "protege effect" — teaching others helps the teacher learn more deeply.', '"Hiệu ứng đệ tử" — dạy người khác giúp người dạy hiểu sâu hơn.', 'teaching', 1),
(47, 'Create simple analogies: "An API is like a waiter — it takes your order to the kitchen and brings back food."', 'Tạo phép so sánh đơn giản: "API giống như người phục vụ — nhận đơn hàng và mang thức ăn về."', 'Good analogies connect new concepts to things people already understand.', 'Phép so sánh tốt kết nối khái niệm mới với những điều người ta đã hiểu.', 'analogy', 2);

-- Tips (IDs 44-46)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(15, 'The 4 steps of the Feynman Technique', '4 bước của Kỹ thuật Feynman', 'Step 1: Choose a concept. Step 2: Explain it in simple language as if teaching a child. Step 3: Identify gaps where your explanation breaks down. Step 4: Go back to the source, study the gaps, and simplify again.', 'Bước 1: Chọn một khái niệm. Bước 2: Giải thích bằng ngôn ngữ đơn giản như dạy trẻ em. Bước 3: Tìm lỗ hổng nơi giải thích bị vấp. Bước 4: Quay lại tài liệu, học phần thiếu, và đơn giản hóa lại.', 'memory', 'high', 'ListAlt', 1),
(15, 'Jargon is a warning sign', 'Thuật ngữ chuyên ngành là dấu hiệu cảnh báo', 'If you catch yourself using technical jargon in your explanation, stop. Jargon often hides a lack of true understanding. Replace every technical term with plain language.', 'Nếu bạn dùng thuật ngữ chuyên ngành trong giải thích, hãy dừng lại. Thuật ngữ thường che giấu sự thiếu hiểu biết thật sự. Thay mỗi thuật ngữ bằng ngôn ngữ đời thường.', 'common_mistake', 'high', 'Warning', 2),
(15, 'Named after a brilliant simplifier', 'Đặt tên theo bậc thầy đơn giản hóa', 'Richard Feynman (1918-1988) was a Nobel Prize-winning physicist famous for explaining complex quantum physics in simple terms anyone could understand. He believed: "If you can''t explain it simply, you don''t understand it well enough."', 'Richard Feynman (1918-1988) là nhà vật lý đoạt giải Nobel nổi tiếng với khả năng giải thích vật lý lượng tử phức tạp bằng ngôn ngữ ai cũng hiểu. Ông tin rằng: "Nếu bạn không thể giải thích đơn giản, bạn chưa hiểu đủ sâu."', 'general', 'medium', 'Person', 3);

-- Comparison: Spaced Repetition vs Active Recall (ID 15)
INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(13, 14, 'Core mechanism', 'Cơ chế cốt lõi', 'Controls WHEN you review — optimizes timing of practice sessions', 'Kiểm soát KHI NÀO bạn ôn — tối ưu hóa thời điểm luyện tập', 'Controls HOW you review — forces active retrieval instead of passive reading', 'Kiểm soát CÁCH bạn ôn — buộc truy xuất chủ động thay vì đọc thụ động', 'Review vocabulary after 1 day, 3 days, 7 days (timing matters)', 'Ôn từ vựng sau 1 ngày, 3 ngày, 7 ngày (thời điểm quan trọng)', 'Close the book and test yourself on the vocabulary (method matters)', 'Đóng sách và tự kiểm tra từ vựng (phương pháp quan trọng)', 'Use BOTH together for maximum effect: actively recall the material at spaced intervals.', 'Kết hợp CẢ HAI để đạt hiệu quả tối đa: chủ động nhớ lại kiến thức ở các khoảng cách giãn cách.', 1);

-- Exercise 99: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(15, 'multiple_choice', 'easy', 'What is the FIRST step of the Feynman Technique?', 'Bước ĐẦU TIÊN của Kỹ thuật Feynman là gì?', 'The Feynman Technique has 4 steps. Which one comes first?', 'Kỹ thuật Feynman có 4 bước. Bước nào đi trước?', 'Step 1 is choosing a concept to learn. You need to know what you want to understand before you can start explaining it.', 'Bước 1 là chọn một khái niệm để học. Bạn cần biết muốn hiểu gì trước khi bắt đầu giải thích.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(99, 'A', 'Choose a concept you want to understand', TRUE, 'Correct! Choosing the topic is always the first step', 1),
(99, 'B', 'Explain the concept in simple language', FALSE, 'This is Step 2 — you need to choose the concept first', 2),
(99, 'C', 'Identify gaps in your explanation', FALSE, 'This is Step 3 — comes after the explanation attempt', 3),
(99, 'D', 'Read the textbook thoroughly', FALSE, 'The Feynman Technique starts with choosing a concept, not reading', 4);

-- Exercise 100: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(15, 'fill_blank', 'easy', 'Complete the Feynman Technique rule.', 'Hoàn thành quy tắc Kỹ thuật Feynman.', 'The Feynman Technique says: explain a concept as if teaching a ___.', 'Kỹ thuật Feynman nói: giải thích khái niệm như đang dạy một ___.', 'child', 'The technique requires explaining complex ideas in such simple language that even a child could understand, forcing you to strip away jargon.', 'Kỹ thuật yêu cầu giải thích ý tưởng phức tạp bằng ngôn ngữ đơn giản đến mức trẻ em cũng hiểu, buộc bạn loại bỏ thuật ngữ.', 10, 2);

-- Exercise 101: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(15, 'error_correction', 'medium', 'This advice about the Feynman Technique contains an error. Correct it.', 'Lời khuyên về Kỹ thuật Feynman này có lỗi sai. Hãy sửa lại.', 'The Feynman Technique is most effective when you use technical jargon to explain concepts.', 'Kỹ thuật Feynman hiệu quả nhất khi bạn dùng thuật ngữ chuyên ngành để giải thích khái niệm.', 'The Feynman Technique is most effective when you use simple language to explain concepts.', 'The core principle of the Feynman Technique is to explain using simple language, not jargon. Technical jargon often masks a lack of true understanding.', 'Nguyên tắc cốt lõi của Kỹ thuật Feynman là giải thích bằng ngôn ngữ đơn giản, không dùng thuật ngữ. Thuật ngữ thường che giấu sự thiếu hiểu biết.', 'Think about what Feynman said about jargon and simplicity.', 'Hãy nghĩ về điều Feynman nói về thuật ngữ và sự đơn giản.', 15, 3);

-- Exercise 102: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(15, 'sentence_transform', 'medium', 'Simplify this jargon-heavy explanation using the Feynman Technique.', 'Đơn giản hóa giải thích nhiều thuật ngữ này bằng Kỹ thuật Feynman.', 'Photosynthesis is the biochemical process by which chloroplasts convert light energy.', 'Quang hợp là quá trình sinh hóa mà lục lạp chuyển đổi năng lượng ánh sáng.', 'Photosynthesis is how plants use sunlight to make their own food.', 'The Feynman Technique requires replacing jargon ("biochemical process," "chloroplasts," "convert light energy") with everyday language that anyone can understand.', 'Kỹ thuật Feynman đòi hỏi thay thế thuật ngữ ("biochemical process," "chloroplasts," "convert light energy") bằng ngôn ngữ hàng ngày mà ai cũng hiểu.', 15, 4);

-- Exercise 103: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(15, 'arrange_words', 'medium', 'Arrange the 4 steps of the Feynman Technique in the correct order.', 'Sắp xếp 4 bước của Kỹ thuật Feynman theo đúng thứ tự.', '["Identify gaps in your explanation", "Choose a concept to learn", "Go back and study the gaps, then simplify", "Explain it in simple language as if teaching a child"]', 'Choose a concept to learn, Explain it in simple language as if teaching a child, Identify gaps in your explanation, Go back and study the gaps, then simplify', 'The 4 steps are: Choose → Explain simply → Find gaps → Study gaps and simplify again. This cycle repeats until you can explain the concept clearly.', '4 bước: Chọn → Giải thích đơn giản → Tìm lỗ hổng → Học lại và đơn giản hóa. Chu trình lặp lại cho đến khi giải thích rõ ràng.', 10, 5);

-- Exercise 104: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(15, 'matching', 'medium', 'Match each Feynman Technique step to its purpose.', 'Nối mỗi bước Kỹ thuật Feynman với mục đích của nó.', 'Each step serves a specific purpose in the learning cycle: choosing focuses attention, explaining tests understanding, identifying gaps reveals weaknesses, and simplifying deepens mastery.', 'Mỗi bước phục vụ mục đích cụ thể: chọn tập trung sự chú ý, giải thích kiểm tra hiểu biết, tìm lỗ hổng lộ điểm yếu, đơn giản hóa tăng chiều sâu.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(104, 'Step 1: Choose a concept', 'Bước 1: Chọn khái niệm', 'Focus your attention on one topic', 'Tập trung vào một chủ đề', 1),
(104, 'Step 2: Explain simply', 'Bước 2: Giải thích đơn giản', 'Test your understanding', 'Kiểm tra sự hiểu biết', 2),
(104, 'Step 3: Identify gaps', 'Bước 3: Tìm lỗ hổng', 'Reveal what you don''t know', 'Lộ ra điều bạn chưa biết', 3),
(104, 'Step 4: Study and simplify', 'Bước 4: Học và đơn giản hóa', 'Deepen mastery of the concept', 'Hiểu sâu hơn khái niệm', 4);

-- Exercise 105: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(15, 'true_false', 'easy', 'Is this statement about the Feynman Technique correct?', 'Phát biểu sau về Kỹ thuật Feynman có đúng không?', 'If you can explain a concept using simple, everyday language without technical jargon, it means you truly understand it.', 'Nếu bạn có thể giải thích một khái niệm bằng ngôn ngữ đơn giản, đời thường, không dùng thuật ngữ chuyên ngành, điều đó có nghĩa bạn thật sự hiểu nó.', 'true', 'True! This is the core principle of the Feynman Technique. Richard Feynman believed that the ultimate test of understanding is the ability to explain something simply.', 'Đúng! Đây là nguyên tắc cốt lõi của Kỹ thuật Feynman. Richard Feynman tin rằng phép thử cao nhất của sự hiểu biết là khả năng giải thích đơn giản.', 5, 7);


-- ============================================================================
-- LESSON SECTIONS (Data-Driven Content for Learning Methods)
-- ============================================================================
-- These sections demonstrate the flexible lesson_section system.
-- They render BEFORE legacy sections (formulas, usages, signal_words, tips).
-- Grammar lessons have NO sections — they use legacy tables exclusively.

-- Lesson 13: Spaced Repetition
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
(13, 'markdown', 'What is Spaced Repetition?', 'Ôn Tập Giãn Cách là gì?',
'Spaced repetition is a **learning technique** that involves reviewing material at **increasing intervals** over time. Instead of cramming all at once, you space out your study sessions.

The idea is simple: review material **just before you''re about to forget it**. Each successful review strengthens the memory and increases the time before the next review is needed.

### How it works

1. **Learn** new material
2. **Review** after a short interval (e.g., 1 day)
3. If you remember, **increase** the interval (3 days → 7 days → 14 days)
4. If you forget, **reset** to a shorter interval

> "The spacing effect is one of the most robust findings in experimental psychology." — Cepeda et al., 2006',
'Ôn tập giãn cách là một **kỹ thuật học tập** bao gồm việc ôn lại tài liệu theo **khoảng thời gian tăng dần**. Thay vì nhồi nhét một lần, bạn giãn cách các buổi học.

Ý tưởng rất đơn giản: ôn lại tài liệu **ngay trước khi bạn sắp quên**. Mỗi lần ôn thành công sẽ củng cố trí nhớ và tăng thời gian trước lần ôn tiếp theo.

### Cách hoạt động

1. **Học** tài liệu mới
2. **Ôn lại** sau một khoảng ngắn (ví dụ: 1 ngày)
3. Nếu nhớ, **tăng** khoảng cách (3 ngày → 7 ngày → 14 ngày)
4. Nếu quên, **giảm** về khoảng cách ngắn hơn

> "Hiệu ứng giãn cách là một trong những phát hiện vững chắc nhất trong tâm lý học thực nghiệm." — Cepeda et al., 2006',
'{}', 1),

(13, 'key_points', 'Key Principles', 'Nguyên tắc chính',
'- **Forgetting is natural** — the forgetting curve shows memory decays exponentially without review
- **Timing matters** — reviewing at the right moment maximizes retention with minimal effort
- **Active recall + spacing** — combining both techniques produces the strongest long-term memories
- **Consistency beats intensity** — 15 minutes daily > 2 hours once a week',
'- **Quên là tự nhiên** — đường cong quên lãng cho thấy trí nhớ suy giảm theo hàm mũ nếu không ôn tập
- **Thời điểm rất quan trọng** — ôn đúng lúc giúp ghi nhớ tối đa với nỗ lực tối thiểu
- **Nhớ lại chủ động + giãn cách** — kết hợp cả hai kỹ thuật tạo trí nhớ dài hạn mạnh nhất
- **Đều đặn tốt hơn cường độ** — 15 phút mỗi ngày > 2 giờ mỗi tuần',
'{}', 2),

(13, 'info_box', 'Pro Tip', 'Mẹo hay',
'Start with **short intervals** (1 day, 3 days) and gradually increase. Most people try to space too far apart too quickly. Let your brain tell you when it''s ready — if you struggle to recall, shorten the interval.',
'Bắt đầu với **khoảng cách ngắn** (1 ngày, 3 ngày) và tăng dần. Hầu hết mọi người cố giãn quá xa quá nhanh. Hãy để bộ não cho bạn biết khi nào sẵn sàng — nếu bạn khó nhớ lại, hãy rút ngắn khoảng cách.',
'{"variant": "tip"}', 3);

-- Lesson 14: Active Recall
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
(14, 'markdown', 'What is Active Recall?', 'Nhớ Lại Chủ Động là gì?',
'Active recall is a **study strategy** where you actively stimulate your memory during learning, rather than passively reviewing material.

Instead of:
- Re-reading your notes ❌
- Highlighting text ❌
- Watching lectures again ❌

You should:
- **Close your notes** and try to remember what you just read ✅
- **Write down** everything you can recall from memory ✅
- **Test yourself** with questions before looking at answers ✅

### The Science

Research by Karpicke & Blunt (2011) showed that students who practiced active recall **remembered 50% more** than those who simply re-read the material, even when the re-readers spent more time studying.',
'Nhớ lại chủ động là một **chiến lược học tập** trong đó bạn chủ động kích thích trí nhớ trong khi học, thay vì ôn tập thụ động.

Thay vì:
- Đọc lại ghi chú ❌
- Tô sáng văn bản ❌
- Xem lại bài giảng ❌

Bạn nên:
- **Đóng ghi chú** và cố nhớ lại những gì vừa đọc ✅
- **Viết ra** mọi thứ bạn có thể nhớ ✅
- **Tự kiểm tra** bằng câu hỏi trước khi xem đáp án ✅

### Khoa học đằng sau

Nghiên cứu của Karpicke & Blunt (2011) cho thấy sinh viên thực hành nhớ lại chủ động **nhớ nhiều hơn 50%** so với những người chỉ đọc lại tài liệu, dù nhóm đọc lại dành nhiều thời gian hơn.',
'{}', 1),

(14, 'info_box', 'Common Misconception', 'Hiểu lầm phổ biến',
'Many students believe that **re-reading** is effective because the material feels familiar. But **familiarity is not the same as understanding**. You might recognize information when you see it, but fail to produce it when you need it — like on an exam.',
'Nhiều sinh viên tin rằng **đọc lại** hiệu quả vì tài liệu có vẻ quen thuộc. Nhưng **quen thuộc không có nghĩa là hiểu**. Bạn có thể nhận ra thông tin khi nhìn thấy, nhưng không thể tái tạo nó khi cần — như trong kỳ thi.',
'{"variant": "warning"}', 2),

(14, 'key_points', 'How to Practice Active Recall', 'Cách thực hành Nhớ Lại Chủ Động',
'1. **The Blank Page Method**: After reading a chapter, close the book and write everything you remember on a blank page
2. **Flashcards**: Create question-answer pairs and quiz yourself regularly
3. **Practice Questions**: Answer problems without looking at solutions first
4. **Teach Someone**: Explain the concept to another person (or rubber duck)
5. **Cornell Notes**: Cover the right side and use left-column cues to recall content',
'1. **Phương pháp Trang Trắng**: Sau khi đọc một chương, đóng sách và viết mọi thứ bạn nhớ ra trang trắng
2. **Flashcard**: Tạo các cặp câu hỏi-đáp và tự kiểm tra thường xuyên
3. **Câu hỏi thực hành**: Trả lời bài tập mà không xem lời giải trước
4. **Dạy ai đó**: Giải thích khái niệm cho người khác (hoặc con vịt cao su)
5. **Ghi chú Cornell**: Che phần bên phải và dùng gợi ý bên trái để nhớ lại nội dung',
'{}', 3);

-- Lesson 15: The Feynman Technique
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
(15, 'markdown', 'What is the Feynman Technique?', 'Kỹ Thuật Feynman là gì?',
'The Feynman Technique is a **mental model** for learning anything deeply. Named after Nobel Prize-winning physicist **Richard Feynman**, it forces you to understand concepts at a fundamental level.

Feynman was known as the "Great Explainer" because he could make even quantum physics accessible. His secret? **If you can''t explain it simply, you don''t understand it well enough.**

### The 4 Steps

| Step | Action | Purpose |
|------|--------|---------|
| 1 | **Choose a concept** | Focus your learning |
| 2 | **Explain it simply** | As if teaching a 12-year-old |
| 3 | **Identify gaps** | Where did you get stuck? |
| 4 | **Review and simplify** | Go back to source material |

The power of this technique is in **Step 3** — when you struggle to explain something simply, you''ve found exactly where your understanding breaks down.',
'Kỹ thuật Feynman là một **mô hình tư duy** để học bất cứ điều gì sâu sắc. Được đặt tên theo nhà vật lý đoạt giải Nobel **Richard Feynman**, nó buộc bạn phải hiểu khái niệm ở mức cơ bản nhất.

Feynman được gọi là "Nhà Giải Thích Vĩ Đại" vì ông có thể làm cho ngay cả vật lý lượng tử cũng dễ hiểu. Bí mật của ông? **Nếu bạn không thể giải thích đơn giản, bạn chưa hiểu đủ sâu.**

### 4 Bước

| Bước | Hành động | Mục đích |
|------|-----------|----------|
| 1 | **Chọn một khái niệm** | Tập trung việc học |
| 2 | **Giải thích đơn giản** | Như đang dạy học sinh 12 tuổi |
| 3 | **Tìm lỗ hổng** | Chỗ nào bạn bị kẹt? |
| 4 | **Ôn lại và đơn giản hóa** | Quay lại tài liệu gốc |

Sức mạnh của kỹ thuật này nằm ở **Bước 3** — khi bạn gặp khó khăn để giải thích đơn giản, bạn đã tìm ra chính xác chỗ mà sự hiểu biết của bạn bị đứt gãy.',
'{}', 1),

(15, 'info_box', 'Real-World Example', 'Ví dụ thực tế',
'**Trying to learn "photosynthesis"?**

Don''t say: "Photosynthesis is the biochemical process by which chloroplasts convert electromagnetic radiation into chemical energy through a series of electron transport reactions."

Say: "Plants eat sunlight. They take light energy, water from the ground, and CO₂ from the air, and turn them into sugar (food) and oxygen. The green parts of the plant are like tiny solar panels."

If you can do this, you truly understand it!',
'**Đang cố học "quang hợp"?**

Đừng nói: "Quang hợp là quá trình sinh hóa mà qua đó lục lạp chuyển đổi bức xạ điện từ thành năng lượng hóa học thông qua chuỗi phản ứng vận chuyển electron."

Hãy nói: "Cây ăn ánh sáng mặt trời. Chúng lấy năng lượng ánh sáng, nước từ đất, và CO₂ từ không khí, rồi biến thành đường (thức ăn) và oxy. Phần xanh của cây giống như tấm pin năng lượng mặt trời nhỏ xíu."

Nếu bạn có thể làm được điều này, bạn thật sự hiểu nó!',
'{"variant": "example"}', 2),

(15, 'key_points', 'Why This Works', 'Tại sao kỹ thuật này hiệu quả',
'- **Forces deep processing** — you can''t fake understanding when explaining simply
- **Reveals knowledge gaps** — jargon and vague terms indicate areas you haven''t truly grasped
- **Builds connections** — simplification requires linking new ideas to familiar concepts
- **Improves communication** — a skill valuable far beyond studying',
'- **Buộc xử lý sâu** — bạn không thể giả vờ hiểu khi giải thích đơn giản
- **Phát hiện lỗ hổng** — thuật ngữ và từ mơ hồ chỉ ra những chỗ bạn chưa thật sự nắm
- **Xây dựng kết nối** — đơn giản hóa đòi hỏi liên kết ý tưởng mới với khái niệm quen thuộc
- **Cải thiện giao tiếp** — kỹ năng có giá trị vượt xa việc học',
'{}', 3);


-- ############################################################################
-- PYTHON BASICS CONTENT (4 lessons, loaded from seed_python.sql)
-- Category 5, Lessons 16-19
-- ############################################################################
-- See database/seed_python.sql for the full Python Basics seed data.
-- That file is applied separately during development and included here by reference.
-- For fresh database setup, run: psql -f seed_data.sql && psql -f seed_python.sql


-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

SELECT 'Categories' AS entity, COUNT(*)::int AS count FROM category
UNION ALL SELECT 'Lessons', COUNT(*)::int FROM lesson
UNION ALL SELECT 'Formulas', COUNT(*)::int FROM formula
UNION ALL SELECT 'Usages', COUNT(*)::int FROM lesson_usage
UNION ALL SELECT 'Examples', COUNT(*)::int FROM example
UNION ALL SELECT 'Signal Words', COUNT(*)::int FROM signal_word
UNION ALL SELECT 'Tips', COUNT(*)::int FROM tip
UNION ALL SELECT 'Lesson Sections', COUNT(*)::int FROM lesson_section
UNION ALL SELECT 'Comparisons', COUNT(*)::int FROM lesson_comparison
UNION ALL SELECT 'Exercises', COUNT(*)::int FROM exercise
UNION ALL SELECT 'Exercise Options', COUNT(*)::int FROM exercise_option
UNION ALL SELECT 'Matching Pairs', COUNT(*)::int FROM matching_pair;

-- Verify all lessons are complete (12 grammar + 3 learning methods + 4 Python basics)
SELECT l.name, fn_lesson_is_complete(l.id) AS complete
FROM lesson l ORDER BY l.id;

-- Verify lesson summary view
SELECT * FROM v_lesson_summary;

-- Verify database stats
SELECT * FROM v_database_stats;
