-- ============================================================================
-- SEED DATA: Knowledge Learning Application
-- Sample data for testing and development
-- Compatible with: schema.sql v3.0.0 (PostgreSQL 17)
-- ============================================================================


-- ============================================================================
-- CATEGORIES
-- ============================================================================

INSERT INTO category (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('Present', 'Thì Hiện Tại', 'Tenses describing current time, habits, and general truths', 'Các thì diễn tả thời điểm hiện tại, thói quen và sự thật chung', 'AccessTime', '#10b981', 1),
('Past', 'Thì Quá Khứ', 'Tenses describing completed actions and past events', 'Các thì diễn tả hành động đã hoàn thành và sự kiện trong quá khứ', 'History', '#f59e0b', 2),
('Future', 'Thì Tương Lai', 'Tenses describing future events, plans, and predictions', 'Các thì diễn tả sự kiện tương lai, kế hoạch và dự đoán', 'Update', '#6366f1', 3);


-- ============================================================================
-- LESSONS (12 Tenses)
-- ============================================================================

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
-- Present Tenses
(1, 'Simple Present', 'Thì Hiện Tại Đơn', 'simple-present',
    'Express habits, facts, and general truths',
    'Diễn tả thói quen, sự thật và chân lý chung',
    'beginner', 30, 1),

(1, 'Present Continuous', 'Thì Hiện Tại Tiếp Diễn', 'present-continuous',
    'Actions happening right now or temporary situations',
    'Hành động đang xảy ra hoặc tình huống tạm thời',
    'beginner', 30, 2),

(1, 'Present Perfect', 'Thì Hiện Tại Hoàn Thành', 'present-perfect',
    'Past actions with present relevance',
    'Hành động quá khứ có liên quan đến hiện tại',
    'intermediate', 45, 3),

(1, 'Present Perfect Continuous', 'Thì Hiện Tại Hoàn Thành Tiếp Diễn', 'present-perfect-continuous',
    'Actions that started in the past and continue to now',
    'Hành động bắt đầu trong quá khứ và tiếp tục đến hiện tại',
    'intermediate', 45, 4),

-- Past Tenses
(2, 'Simple Past', 'Thì Quá Khứ Đơn', 'simple-past',
    'Completed actions at a specific time in the past',
    'Hành động đã hoàn thành tại thời điểm cụ thể trong quá khứ',
    'beginner', 30, 1),

(2, 'Past Continuous', 'Thì Quá Khứ Tiếp Diễn', 'past-continuous',
    'Actions in progress at a specific time in the past',
    'Hành động đang diễn ra tại thời điểm trong quá khứ',
    'beginner', 35, 2),

(2, 'Past Perfect', 'Thì Quá Khứ Hoàn Thành', 'past-perfect',
    'Actions completed before another past action',
    'Hành động hoàn thành trước một hành động khác trong quá khứ',
    'intermediate', 45, 3),

(2, 'Past Perfect Continuous', 'Thì Quá Khứ Hoàn Thành Tiếp Diễn', 'past-perfect-continuous',
    'Duration of actions before another past action',
    'Thời lượng của hành động trước một hành động khác trong quá khứ',
    'advanced', 50, 4),

-- Future Tenses
(3, 'Simple Future', 'Thì Tương Lai Đơn', 'simple-future',
    'Predictions, promises, and spontaneous decisions',
    'Dự đoán, lời hứa và quyết định tức thì',
    'beginner', 30, 1),

(3, 'Future Continuous', 'Thì Tương Lai Tiếp Diễn', 'future-continuous',
    'Actions in progress at a specific future time',
    'Hành động đang diễn ra tại thời điểm trong tương lai',
    'intermediate', 40, 2),

(3, 'Future Perfect', 'Thì Tương Lai Hoàn Thành', 'future-perfect',
    'Actions completed before a future time',
    'Hành động sẽ hoàn thành trước một thời điểm trong tương lai',
    'intermediate', 45, 3),

(3, 'Future Perfect Continuous', 'Thì Tương Lai Hoàn Thành Tiếp Diễn', 'future-perfect-continuous',
    'Duration of actions up to a future point',
    'Thời lượng của hành động cho đến một thời điểm trong tương lai',
    'advanced', 50, 4);


-- ============================================================================
-- FORMULAS - Simple Present (lesson_id = 1)
-- ============================================================================

INSERT INTO formula (lesson_id, type, subject_note, structure, structure_vi, example, example_vi, note, order_index) VALUES
(1, 'affirmative', 'I/You/We/They + V | He/She/It + V(s/es)',
    'S + V(s/es)',
    'Chủ ngữ + Động từ (thêm s/es với ngôi 3 số ít)',
    'She works at a hospital.',
    'Cô ấy làm việc ở bệnh viện.',
    'Thêm -es sau các động từ kết thúc bằng: -o, -s, -x, -z, -ch, -sh (goes, watches, washes)',
    1),

(1, 'negative', 'I/You/We/They + do not | He/She/It + does not',
    'S + do/does + not + V',
    'Chủ ngữ + do/does + not + Động từ nguyên mẫu',
    'She does not (doesn''t) work on Sundays.',
    'Cô ấy không làm việc vào Chủ nhật.',
    'Viết tắt: do not = don''t, does not = doesn''t',
    2),

(1, 'interrogative', 'Do + I/you/we/they | Does + he/she/it',
    'Do/Does + S + V?',
    'Do/Does + Chủ ngữ + Động từ nguyên mẫu?',
    'Does she work at a hospital?',
    'Cô ấy có làm việc ở bệnh viện không?',
    'Trả lời: Yes, she does. / No, she doesn''t.',
    3);


-- ============================================================================
-- FORMULAS - Present Continuous (lesson_id = 2)
-- ============================================================================

INSERT INTO formula (lesson_id, type, subject_note, structure, structure_vi, example, example_vi, note, order_index) VALUES
(2, 'affirmative', 'I + am | He/She/It + is | You/We/They + are',
    'S + am/is/are + V-ing',
    'Chủ ngữ + am/is/are + Động từ thêm -ing',
    'I am studying English now.',
    'Tôi đang học tiếng Anh bây giờ.',
    'Quy tắc thêm -ing: bỏ -e cuối (make → making), gấp đôi phụ âm cuối (run → running)',
    1),

(2, 'negative', NULL,
    'S + am/is/are + not + V-ing',
    'Chủ ngữ + am/is/are + not + Động từ thêm -ing',
    'She is not (isn''t) working today.',
    'Cô ấy không làm việc hôm nay.',
    'Viết tắt: is not = isn''t, are not = aren''t',
    2),

(2, 'interrogative', NULL,
    'Am/Is/Are + S + V-ing?',
    'Am/Is/Are + Chủ ngữ + Động từ thêm -ing?',
    'Are you listening to me?',
    'Bạn có đang nghe tôi nói không?',
    'Trả lời: Yes, I am. / No, I''m not.',
    3);


-- ============================================================================
-- USAGES - Simple Present (lesson_id = 1)
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(1, 'Habits and routines',
    'Thói quen và hoạt động thường ngày',
    'Used to describe actions that happen regularly or repeatedly.',
    'Dùng để diễn tả các hành động xảy ra thường xuyên hoặc lặp đi lặp lại.',
    'Repeat', TRUE, 1),

(1, 'General truths and facts',
    'Sự thật chung và chân lý',
    'Used to state facts, scientific truths, and things that are generally accepted as true.',
    'Dùng để nói về sự thật, chân lý khoa học và những điều được chấp nhận là đúng.',
    'Science', TRUE, 2),

(1, 'Permanent situations',
    'Tình huống cố định, lâu dài',
    'Used to describe situations that are permanent or long-lasting.',
    'Dùng để diễn tả tình huống cố định hoặc kéo dài lâu.',
    'Home', TRUE, 3),

(1, 'Scheduled events',
    'Sự kiện theo lịch trình',
    'Used for scheduled or timetabled events, especially with transportation.',
    'Dùng cho các sự kiện theo lịch trình, đặc biệt với phương tiện giao thông.',
    'Schedule', FALSE, 4),

(1, 'Instructions and directions',
    'Hướng dẫn và chỉ đường',
    'Used in instructions, recipes, and giving directions.',
    'Dùng trong hướng dẫn, công thức nấu ăn và chỉ đường.',
    'Directions', FALSE, 5);


-- ============================================================================
-- EXAMPLES - For Usage 1 (Habits and routines)
-- ============================================================================

INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(1, 'I wake up at 6 AM every day.',
    'Tôi thức dậy lúc 6 giờ sáng mỗi ngày.',
    '"Every day" indicates this is a regular habit.',
    '"Every day" cho thấy đây là thói quen thường xuyên.',
    'wake up', 1),

(1, 'She always drinks coffee in the morning.',
    'Cô ấy luôn uống cà phê vào buổi sáng.',
    '"Always" emphasizes the habitual nature of the action.',
    '"Always" nhấn mạnh tính chất thói quen của hành động.',
    'always drinks', 2),

(1, 'They go to the gym three times a week.',
    'Họ đến phòng gym ba lần một tuần.',
    'Frequency expression "three times a week" shows regularity.',
    'Cụm từ tần suất "ba lần một tuần" cho thấy tính thường xuyên.',
    'go', 3);


-- ============================================================================
-- EXAMPLES - For Usage 2 (General truths)
-- ============================================================================

INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(2, 'Water boils at 100 degrees Celsius.',
    'Nước sôi ở 100 độ C.',
    'Scientific fact - always true regardless of time.',
    'Sự thật khoa học - luôn đúng bất kể thời gian.',
    'boils', 1),

(2, 'The Earth revolves around the Sun.',
    'Trái Đất quay quanh Mặt Trời.',
    'Universal truth about our solar system.',
    'Chân lý về hệ mặt trời của chúng ta.',
    'revolves', 2),

(2, 'Cats are mammals.',
    'Mèo là động vật có vú.',
    'General classification fact.',
    'Sự thật về phân loại chung.',
    'are', 3);


-- ============================================================================
-- SIGNAL WORDS - Simple Present (lesson_id = 1)
-- ============================================================================

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


-- ============================================================================
-- TIPS - Simple Present (lesson_id = 1)
-- ============================================================================

INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(1, 'Third person singular rule',
    'Quy tắc ngôi thứ 3 số ít',
    'Remember: He/She/It always needs -s or -es at the end of the verb. Common mistake: "She work" ❌ → "She works" ✓',
    'Nhớ: He/She/It luôn cần thêm -s hoặc -es vào cuối động từ. Lỗi thường gặp: "She work" ❌ → "She works" ✓',
    'common_mistake', 'high', 'Warning', 1),

(1, 'Position of frequency adverbs',
    'Vị trí trạng từ tần suất',
    'Frequency adverbs (always, usually, often, sometimes, rarely, never) go BEFORE main verbs but AFTER "be": "I always eat" but "I am always happy"',
    'Trạng từ tần suất đứng TRƯỚC động từ thường nhưng SAU động từ "be": "I always eat" nhưng "I am always happy"',
    'memory', 'high', 'Lightbulb', 2),

(1, 'Don''t confuse with Present Continuous',
    'Đừng nhầm với Hiện tại tiếp diễn',
    'Simple Present = habits/facts (I drink coffee every morning) vs Present Continuous = happening now (I am drinking coffee now)',
    'Hiện tại đơn = thói quen/sự thật (Tôi uống cà phê mỗi sáng) vs Hiện tại tiếp diễn = đang xảy ra (Tôi đang uống cà phê)',
    'comparison', 'medium', 'Compare', 3),

(1, 'Spelling rules for -es',
    'Quy tắc chính tả thêm -es',
    'Add -es (not just -s) after verbs ending in: -o (goes), -s (misses), -x (fixes), -z (buzzes), -ch (watches), -sh (washes)',
    'Thêm -es (không chỉ -s) sau động từ kết thúc bằng: -o (goes), -s (misses), -x (fixes), -z (buzzes), -ch (watches), -sh (washes)',
    'memory', 'medium', 'Spellcheck', 4);


-- ============================================================================
-- LESSON COMPARISONS
-- ============================================================================

INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(1, 2, 'Time reference',
    'Tham chiếu thời gian',
    'Describes habits, routines, and permanent situations',
    'Diễn tả thói quen, hoạt động thường ngày và tình huống cố định',
    'Describes actions happening right now or temporary situations',
    'Diễn tả hành động đang xảy ra ngay bây giờ hoặc tình huống tạm thời',
    'I work at a bank. (permanent job)',
    'Tôi làm việc ở ngân hàng. (công việc cố định)',
    'I am working from home today. (temporary)',
    'Hôm nay tôi đang làm việc ở nhà. (tạm thời)',
    'Ask yourself: Is this a habit/fact OR is it happening right now?',
    'Tự hỏi: Đây là thói quen/sự thật HAY đang xảy ra ngay bây giờ?',
    1),

(1, 2, 'Signal words',
    'Dấu hiệu nhận biết',
    'always, usually, often, sometimes, rarely, never, every day',
    'always, usually, often, sometimes, rarely, never, every day',
    'now, right now, at the moment, currently, today',
    'now, right now, at the moment, currently, today',
    'I always drink tea.',
    'Tôi luôn uống trà.',
    'I am drinking tea right now.',
    'Tôi đang uống trà ngay bây giờ.',
    'Look for time words! "Every day" = Simple Present, "Right now" = Present Continuous',
    'Tìm từ chỉ thời gian! "Every day" = Hiện tại đơn, "Right now" = Hiện tại tiếp diễn',
    2),

(1, 5, 'Time frame',
    'Khung thời gian',
    'Present time - habits, facts, permanent situations',
    'Thời điểm hiện tại - thói quen, sự thật, tình huống cố định',
    'Past time - completed actions at a specific time',
    'Thời điểm quá khứ - hành động đã hoàn thành tại thời điểm cụ thể',
    'I live in Hanoi.',
    'Tôi sống ở Hà Nội.',
    'I lived in Hanoi last year.',
    'Năm ngoái tôi sống ở Hà Nội.',
    'Simple Present = now/always true, Simple Past = finished/specific past time',
    'Hiện tại đơn = bây giờ/luôn đúng, Quá khứ đơn = đã xong/thời điểm cụ thể trong quá khứ',
    1);


-- ============================================================================
-- EXERCISES - Simple Present (lesson_id = 1)
-- ============================================================================

-- Multiple Choice Exercise
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(1, 'multiple_choice', 'easy',
    'Choose the correct form of the verb.',
    'Chọn dạng đúng của động từ.',
    'She ___ to school every day.',
    'Cô ấy ___ đến trường mỗi ngày.',
    'With "she" (third person singular), we add -es to "go" → "goes". "Every day" indicates a habit, so we use Simple Present.',
    'Với "she" (ngôi 3 số ít), ta thêm -es vào "go" → "goes". "Every day" chỉ thói quen nên dùng Hiện tại đơn.',
    10, 1);

INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(1, 'A', 'go', FALSE, 'Missing -es for third person singular', 1),
(1, 'B', 'goes', TRUE, 'Correct! "Goes" is the third person singular form', 2),
(1, 'C', 'going', FALSE, 'This is the -ing form, used for continuous tenses', 3),
(1, 'D', 'went', FALSE, 'This is past tense, but we need present tense', 4);


-- Fill in the blank Exercise
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(1, 'fill_blank', 'easy',
    'Fill in the blank with the correct form of the verb in brackets.',
    'Điền vào chỗ trống với dạng đúng của động từ trong ngoặc.',
    'Water ___ (boil) at 100 degrees Celsius.',
    'Nước ___ (sôi) ở 100 độ C.',
    'boils',
    'This is a scientific fact (general truth), so we use Simple Present. "Water" is third person singular, so we add -s.',
    'Đây là sự thật khoa học (chân lý chung) nên dùng Hiện tại đơn. "Water" là ngôi 3 số ít nên thêm -s.',
    10, 2);


-- Error Correction Exercise
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(1, 'error_correction', 'medium',
    'Find and correct the error in this sentence.',
    'Tìm và sửa lỗi trong câu sau.',
    'He don''t like coffee.',
    'Anh ấy don''t thích cà phê.',
    'He doesn''t like coffee.',
    'With "he" (third person singular), we must use "doesn''t" instead of "don''t".',
    'Với "he" (ngôi 3 số ít), ta phải dùng "doesn''t" thay vì "don''t".',
    'Check the auxiliary verb with third person singular.',
    'Kiểm tra trợ động từ với ngôi 3 số ít.',
    15, 3);


-- Sentence Transformation Exercise
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(1, 'sentence_transform', 'medium',
    'Change this affirmative sentence into a negative sentence.',
    'Chuyển câu khẳng định sau thành câu phủ định.',
    'They play football on Saturdays.',
    'Họ chơi bóng đá vào các ngày thứ Bảy.',
    'They don''t play football on Saturdays.',
    'To make negative: add "do not" (don''t) before the main verb. The verb stays in base form.',
    'Để tạo câu phủ định: thêm "do not" (don''t) trước động từ chính. Động từ giữ nguyên dạng nguyên mẫu.',
    15, 4);


-- Arrange Words Exercise
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(1, 'arrange_words', 'easy',
    'Arrange the words to make a correct sentence.',
    'Sắp xếp các từ để tạo thành câu đúng.',
    '["usually", "breakfast", "I", "at", "have", "7 AM"]',
    'I usually have breakfast at 7 AM.',
    'The correct order is: Subject (I) + Frequency adverb (usually) + Verb (have) + Object (breakfast) + Time (at 7 AM).',
    'Thứ tự đúng: Chủ ngữ (I) + Trạng từ tần suất (usually) + Động từ (have) + Tân ngữ (breakfast) + Thời gian (at 7 AM).',
    10, 5);


-- Matching Exercise
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(1, 'matching', 'easy',
    'Match the subjects with the correct verb forms.',
    'Nối chủ ngữ với dạng động từ đúng.',
    'Third person singular (he, she, it) uses verb + s/es. Other subjects use base form.',
    'Ngôi 3 số ít (he, she, it) dùng động từ + s/es. Các ngôi khác dùng dạng nguyên mẫu.',
    10, 6);

INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(6, 'She', 'Cô ấy', 'works', 'làm việc (có s)', 1),
(6, 'They', 'Họ', 'work', 'làm việc', 2),
(6, 'It', 'Nó', 'rains', 'mưa (có s)', 3),
(6, 'We', 'Chúng tôi', 'play', 'chơi', 4);


-- True/False Exercise
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(1, 'true_false', 'easy',
    'Is this sentence grammatically correct?',
    'Câu này đúng ngữ pháp không?',
    'The Sun rises in the east.',
    'Mặt trời mọc ở phía đông.',
    'true',
    'This sentence is correct. It expresses a general truth/fact, using Simple Present. "The Sun" is third person singular, so "rises" (with -s) is correct.',
    'Câu này đúng. Nó diễn tả sự thật chung, dùng Hiện tại đơn. "The Sun" là ngôi 3 số ít nên "rises" (có -s) là đúng.',
    5, 7);


-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

-- Check data integrity
SELECT 'Categories' AS entity, COUNT(*)::int AS count FROM category
UNION ALL
SELECT 'Lessons', COUNT(*)::int FROM lesson
UNION ALL
SELECT 'Formulas', COUNT(*)::int FROM formula
UNION ALL
SELECT 'Usages', COUNT(*)::int FROM lesson_usage
UNION ALL
SELECT 'Examples', COUNT(*)::int FROM example
UNION ALL
SELECT 'Signal Words', COUNT(*)::int FROM signal_word
UNION ALL
SELECT 'Tips', COUNT(*)::int FROM tip
UNION ALL
SELECT 'Comparisons', COUNT(*)::int FROM lesson_comparison
UNION ALL
SELECT 'Exercises', COUNT(*)::int FROM exercise
UNION ALL
SELECT 'Exercise Options', COUNT(*)::int FROM exercise_option
UNION ALL
SELECT 'Matching Pairs', COUNT(*)::int FROM matching_pair;

-- Verify lesson summary view works
SELECT * FROM v_lesson_summary LIMIT 5;

-- Verify database stats view works
SELECT * FROM v_database_stats;
