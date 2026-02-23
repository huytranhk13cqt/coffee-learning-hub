-- ============================================================================
-- SEED DATA: Media Content Showcase (Phase 20)
-- Adds local media (images, video, audio) to lessons and exercises
--
-- Prerequisites:
--   - All category seed files must be loaded first
--   - Migration 016 (image section type) must be applied
--
-- Media files expected at:
--   /media/images/image_test_1.jpg
--   /media/images/image_test_2.jpg
--   /media/videos/video_test_1.mp4
--   /media/audios/audio_test_1.mp3
--
-- PART 1: Video sections (local MP4) on existing lessons
-- PART 2: Audio sections (local MP3) on existing lessons
-- PART 3: Image sections (local JPG) on existing lessons
-- PART 4: Exercise media (image_url, audio_url) on existing exercises
-- PART 5: New lesson "Visual Design Analysis" with media-rich exercises
-- ============================================================================


-- ============================================================================
-- PART 1: VIDEO SECTIONS on existing lessons (local MP4)
-- ============================================================================

-- Physics: second lesson — video demonstration
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'video', 'Video Demonstration', 'Video Minh Họa',
  'Watch this video to see the physical concepts in action.',
  'Xem video để thấy các khái niệm vật lý được áp dụng thực tế.',
  25,
  '{"src": "/media/videos/video_test_1.mp4"}'::jsonb
FROM lesson l
JOIN category c ON l.group_id = c.id
WHERE c.name = 'Physics Fundamentals'
ORDER BY l.order_index
LIMIT 1 OFFSET 1;

-- Mathematics: second lesson — video tutorial
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'video', 'Video Tutorial', 'Video Hướng Dẫn',
  'A step-by-step visual explanation of key mathematical concepts.',
  'Giải thích trực quan từng bước các khái niệm toán học chính.',
  25,
  '{"src": "/media/videos/video_test_1.mp4"}'::jsonb
FROM lesson l
JOIN category c ON l.group_id = c.id
WHERE c.name = 'Math Foundations'
ORDER BY l.order_index
LIMIT 1 OFFSET 1;

-- Data Science: first lesson — intro video
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'video', 'Introduction Video', 'Video Giới Thiệu',
  'An overview of core data science concepts covered in this lesson.',
  'Tổng quan các khái niệm khoa học dữ liệu cốt lõi trong bài học này.',
  25,
  '{"src": "/media/videos/video_test_1.mp4"}'::jsonb
FROM lesson l
JOIN category c ON l.group_id = c.id
WHERE c.name = 'Data Science'
ORDER BY l.order_index
LIMIT 1;


-- ============================================================================
-- PART 2: AUDIO SECTIONS on existing lessons (local MP3)
-- ============================================================================

-- Chemistry: second lesson — audio lecture
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'audio', 'Audio Lecture', 'Bài Giảng Âm Thanh',
  'Listen to this audio explanation to reinforce your understanding of chemical concepts.',
  'Nghe giải thích âm thanh để củng cố kiến thức về các khái niệm hóa học.',
  25,
  '{"src": "/media/audios/audio_test_1.mp3"}'::jsonb
FROM lesson l
JOIN category c ON l.group_id = c.id
WHERE c.name = 'Chemistry Basics'
ORDER BY l.order_index
LIMIT 1 OFFSET 1;

-- Economics: second lesson — audio overview
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'audio', 'Audio Overview', 'Tổng Quan Âm Thanh',
  'A brief audio introduction to the economic concepts in this lesson.',
  'Giới thiệu ngắn gọn qua âm thanh về các khái niệm kinh tế trong bài học này.',
  25,
  '{"src": "/media/audios/audio_test_1.mp3"}'::jsonb
FROM lesson l
JOIN category c ON l.group_id = c.id
WHERE c.name = 'Economics 101'
ORDER BY l.order_index
LIMIT 1 OFFSET 1;

-- Personal Finance: first lesson — audio tip
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'audio', 'Audio Tips', 'Mẹo Tài Chính (Âm Thanh)',
  'Listen to practical tips that complement the written content above.',
  'Nghe các mẹo thực tế bổ sung cho nội dung đã đọc ở trên.',
  25,
  '{"src": "/media/audios/audio_test_1.mp3"}'::jsonb
FROM lesson l
JOIN category c ON l.group_id = c.id
WHERE c.name = 'Personal Finance'
ORDER BY l.order_index
LIMIT 1;


-- ============================================================================
-- PART 3: IMAGE SECTIONS on existing lessons (local JPG)
-- ============================================================================

-- UI/UX Design: first lesson — example image
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'image', 'Design Example', 'Ví Dụ Thiết Kế',
  'Observe how the design principles discussed above are applied in this real example.',
  'Quan sát cách các nguyên tắc thiết kế đã thảo luận ở trên được áp dụng trong ví dụ thực tế.',
  25,
  '{"src": "/media/images/image_test_1.jpg", "alt": "Design principle example"}'::jsonb
FROM lesson l
JOIN category c ON l.group_id = c.id
WHERE c.name = 'UI/UX Design Basics'
ORDER BY l.order_index
LIMIT 1;

-- Psychology: second lesson — illustration
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'image', 'Visual Illustration', 'Minh Họa Trực Quan',
  'This image illustrates the psychological concept discussed in the lesson.',
  'Hình ảnh minh họa khái niệm tâm lý học được thảo luận trong bài.',
  25,
  '{"src": "/media/images/image_test_2.jpg", "alt": "Psychology concept illustration"}'::jsonb
FROM lesson l
JOIN category c ON l.group_id = c.id
WHERE c.name = 'Psychology 101'
ORDER BY l.order_index
LIMIT 1 OFFSET 1;

-- Medicine: first lesson — reference image
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'image', 'Reference Image', 'Hình Ảnh Tham Khảo',
  'Study this image to better understand the medical concepts covered.',
  'Nghiên cứu hình ảnh này để hiểu rõ hơn các khái niệm y học đã đề cập.',
  25,
  '{"src": "/media/images/image_test_1.jpg", "alt": "Medical reference image"}'::jsonb
FROM lesson l
JOIN category c ON l.group_id = c.id
WHERE c.name = 'Medicine & Biology'
ORDER BY l.order_index
LIMIT 1;


-- ============================================================================
-- PART 4: EXERCISE MEDIA on existing exercises
-- ============================================================================

-- Add image_url to first 2 exercises in UI/UX Design
UPDATE exercise SET image_url = '/media/images/image_test_1.jpg'
WHERE id = (
  SELECT e.id FROM exercise e
  JOIN lesson l ON e.lesson_id = l.id
  JOIN category c ON l.group_id = c.id
  WHERE c.name = 'UI/UX Design Basics'
  ORDER BY l.order_index, e.order_index
  LIMIT 1
);

UPDATE exercise SET image_url = '/media/images/image_test_2.jpg'
WHERE id = (
  SELECT e.id FROM exercise e
  JOIN lesson l ON e.lesson_id = l.id
  JOIN category c ON l.group_id = c.id
  WHERE c.name = 'UI/UX Design Basics'
  ORDER BY l.order_index, e.order_index
  LIMIT 1 OFFSET 1
);

-- Add image_url to first exercise in Mathematics
UPDATE exercise SET image_url = '/media/images/image_test_1.jpg'
WHERE id = (
  SELECT e.id FROM exercise e
  JOIN lesson l ON e.lesson_id = l.id
  JOIN category c ON l.group_id = c.id
  WHERE c.name = 'Math Foundations'
  ORDER BY l.order_index, e.order_index
  LIMIT 1
);

-- Add image_url to first exercise in Physics
UPDATE exercise SET image_url = '/media/images/image_test_2.jpg'
WHERE id = (
  SELECT e.id FROM exercise e
  JOIN lesson l ON e.lesson_id = l.id
  JOIN category c ON l.group_id = c.id
  WHERE c.name = 'Physics Fundamentals'
  ORDER BY l.order_index, e.order_index
  LIMIT 1
);

-- Add audio_url to first 2 exercises in Music Theory
UPDATE exercise SET audio_url = '/media/audios/audio_test_1.mp3'
WHERE id = (
  SELECT e.id FROM exercise e
  JOIN lesson l ON e.lesson_id = l.id
  JOIN category c ON l.group_id = c.id
  WHERE c.name = 'Music Theory'
  ORDER BY l.order_index, e.order_index
  LIMIT 1
);

UPDATE exercise SET audio_url = '/media/audios/audio_test_1.mp3'
WHERE id = (
  SELECT e.id FROM exercise e
  JOIN lesson l ON e.lesson_id = l.id
  JOIN category c ON l.group_id = c.id
  WHERE c.name = 'Music Theory'
  ORDER BY l.order_index, e.order_index
  LIMIT 1 OFFSET 1
);

-- Add audio_url to first exercise in Psychology
UPDATE exercise SET audio_url = '/media/audios/audio_test_1.mp3'
WHERE id = (
  SELECT e.id FROM exercise e
  JOIN lesson l ON e.lesson_id = l.id
  JOIN category c ON l.group_id = c.id
  WHERE c.name = 'Psychology 101'
  ORDER BY l.order_index, e.order_index
  LIMIT 1
);


-- ============================================================================
-- PART 5: NEW LESSON — "Visual Design Analysis" in UI/UX Design
-- A media-rich lesson showcasing images, video, and audio in one lesson
-- ============================================================================

-- 5A: Create the lesson
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, order_index)
SELECT c.id,
  'Visual Design Analysis',
  'Phân Tích Thiết Kế Thị Giác',
  'visual-design-analysis',
  'Learn to analyze visual designs using images, design principles, and practical examples.',
  'Học cách phân tích thiết kế thị giác bằng hình ảnh, nguyên tắc thiết kế và ví dụ thực tế.',
  'beginner',
  20
FROM category c
WHERE c.name = 'UI/UX Design Basics';


-- 5B: Lesson sections (image + video + audio — all 3 media types in one lesson)

-- Section 1: Markdown intro
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'markdown',
  'Introduction to Visual Analysis',
  'Giới Thiệu Phân Tích Thị Giác',
  E'## What is Visual Design Analysis?\n\nVisual design analysis is the process of examining a design to understand **how** and **why** it communicates effectively. This involves evaluating:\n\n- **Contrast** — differences in color, size, and shape that create visual emphasis\n- **Alignment** — how elements are positioned relative to each other\n- **Repetition** — consistent use of design elements for unity\n- **Proximity** — grouping related elements together\n- **White space** — intentional empty space that improves readability\n\nThese principles, known as **C.A.R.P.**, form the foundation of effective visual communication.',
  E'## Phân Tích Thiết Kế Thị Giác là gì?\n\nPhân tích thiết kế thị giác là quá trình xem xét một thiết kế để hiểu **cách** và **lý do** nó truyền đạt hiệu quả. Bao gồm đánh giá:\n\n- **Tương phản (Contrast)** — sự khác biệt về màu sắc, kích thước và hình dạng tạo điểm nhấn\n- **Căn chỉnh (Alignment)** — cách các phần tử được đặt tương đối với nhau\n- **Lặp lại (Repetition)** — sử dụng nhất quán các yếu tố thiết kế để tạo sự thống nhất\n- **Gần gũi (Proximity)** — nhóm các phần tử liên quan lại gần nhau\n- **Khoảng trắng (White space)** — không gian trống có chủ đích giúp cải thiện khả năng đọc\n\nCác nguyên tắc này, được gọi là **C.A.R.P.**, tạo nền tảng cho giao tiếp thị giác hiệu quả.',
  1,
  '{}'::jsonb
FROM lesson l
WHERE l.slug = 'visual-design-analysis';

-- Section 2: Image example 1
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'image',
  'Example: Design Composition',
  'Ví Dụ: Bố Cục Thiết Kế',
  'Observe the design above. Notice how contrast and alignment work together to guide your eye across the composition.',
  'Quan sát thiết kế phía trên. Chú ý cách tương phản và căn chỉnh phối hợp để dẫn dắt ánh nhìn của bạn qua bố cục.',
  2,
  '{"src": "/media/images/image_test_1.jpg", "alt": "Design composition example showing visual hierarchy"}'::jsonb
FROM lesson l
WHERE l.slug = 'visual-design-analysis';

-- Section 3: Key points
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'key_points',
  'Key Takeaways',
  'Điểm Chính Cần Nhớ',
  NULL, NULL,
  3,
  '{"points": ["Contrast creates focal points — use size, color, and weight differences", "Alignment creates visual connections between elements", "White space is not wasted space — it improves readability and focus", "The Rule of Thirds divides a canvas into 9 equal parts using 2 horizontal and 2 vertical lines", "Visual hierarchy guides the viewer through content in order of importance"], "points_vi": ["Tương phản tạo điểm nhấn — sử dụng khác biệt về kích thước, màu sắc và độ đậm", "Căn chỉnh tạo liên kết thị giác giữa các phần tử", "Khoảng trắng không phải lãng phí — nó cải thiện khả năng đọc và tập trung", "Nguyên tắc 1/3 chia canvas thành 9 phần bằng nhau bằng 2 đường ngang và 2 đường dọc", "Thứ bậc thị giác dẫn dắt người xem qua nội dung theo thứ tự quan trọng"]}'::jsonb
FROM lesson l
WHERE l.slug = 'visual-design-analysis';

-- Section 4: Second image example
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'image',
  'Example: Layout Patterns',
  'Ví Dụ: Các Mẫu Bố Cục',
  'Compare this layout with the previous example. Notice the different approach to organizing visual elements.',
  'So sánh bố cục này với ví dụ trước. Chú ý cách tiếp cận khác nhau trong việc tổ chức các yếu tố thị giác.',
  4,
  '{"src": "/media/images/image_test_2.jpg", "alt": "Layout pattern example showing different composition"}'::jsonb
FROM lesson l
WHERE l.slug = 'visual-design-analysis';

-- Section 5: Video tutorial
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'video',
  'Video: Design Analysis Walkthrough',
  'Video: Hướng Dẫn Phân Tích Thiết Kế',
  'Watch this video walkthrough demonstrating how to analyze visual compositions step by step.',
  'Xem video hướng dẫn trình bày cách phân tích bố cục thị giác từng bước.',
  5,
  '{"src": "/media/videos/video_test_1.mp4"}'::jsonb
FROM lesson l
WHERE l.slug = 'visual-design-analysis';

-- Section 6: Audio narration
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'audio',
  'Audio: Summary & Review',
  'Âm Thanh: Tóm Tắt & Ôn Tập',
  'Listen to this audio summary to reinforce the key concepts before attempting the exercises.',
  'Nghe tóm tắt âm thanh để củng cố các khái niệm chính trước khi làm bài tập.',
  6,
  '{"src": "/media/audios/audio_test_1.mp3"}'::jsonb
FROM lesson l
WHERE l.slug = 'visual-design-analysis';


-- 5C: Exercises for "Visual Design Analysis" (5 exercises with media)

-- Exercise 1: Multiple choice with image
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, image_url, explanation, explanation_vi, hint, hint_vi, order_index, points)
SELECT l.id,
  'multiple_choice', 'easy',
  'Which design principle helps create visual emphasis through differences in color, size, or shape?',
  'Nguyên tắc thiết kế nào giúp tạo điểm nhấn thị giác thông qua sự khác biệt về màu sắc, kích thước hoặc hình dạng?',
  '/media/images/image_test_1.jpg',
  'Contrast creates visual emphasis by making elements stand out from their surroundings. It is one of the most powerful tools in a designer''s toolkit for drawing attention to important content.',
  'Tương phản tạo điểm nhấn thị giác bằng cách làm nổi bật các phần tử so với xung quanh. Đây là một trong những công cụ mạnh nhất trong bộ công cụ của nhà thiết kế để thu hút sự chú ý vào nội dung quan trọng.',
  'Think about what makes certain elements "pop" in a design',
  'Hãy nghĩ về điều gì làm cho một số phần tử "nổi bật" trong thiết kế',
  1, 10
FROM lesson l
WHERE l.slug = 'visual-design-analysis';

-- Options for Exercise 1
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, explanation, explanation_vi, order_index)
SELECT e.id, 'A', 'Contrast', 'Tương phản', TRUE,
  'Correct! Contrast uses differences to create visual emphasis.',
  'Đúng! Tương phản sử dụng sự khác biệt để tạo điểm nhấn thị giác.', 1
FROM exercise e
JOIN lesson l ON e.lesson_id = l.id
WHERE l.slug = 'visual-design-analysis' AND e.order_index = 1;

INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, explanation, explanation_vi, order_index)
SELECT e.id, 'B', 'Alignment', 'Căn chỉnh', FALSE,
  'Alignment organizes elements but doesn''t specifically create emphasis.',
  'Căn chỉnh tổ chức các phần tử nhưng không tạo điểm nhấn cụ thể.', 2
FROM exercise e
JOIN lesson l ON e.lesson_id = l.id
WHERE l.slug = 'visual-design-analysis' AND e.order_index = 1;

INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, explanation, explanation_vi, order_index)
SELECT e.id, 'C', 'Repetition', 'Lặp lại', FALSE,
  'Repetition creates unity and consistency, not emphasis.',
  'Lặp lại tạo sự thống nhất và nhất quán, không phải điểm nhấn.', 3
FROM exercise e
JOIN lesson l ON e.lesson_id = l.id
WHERE l.slug = 'visual-design-analysis' AND e.order_index = 1;

INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, explanation, explanation_vi, order_index)
SELECT e.id, 'D', 'Proximity', 'Gần gũi', FALSE,
  'Proximity groups related elements but doesn''t create visual emphasis.',
  'Gần gũi nhóm các phần tử liên quan nhưng không tạo điểm nhấn thị giác.', 4
FROM exercise e
JOIN lesson l ON e.lesson_id = l.id
WHERE l.slug = 'visual-design-analysis' AND e.order_index = 1;


-- Exercise 2: True/False with image
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, image_url, correct_answer, explanation, explanation_vi, order_index, points)
SELECT l.id,
  'true_false', 'easy',
  'The Rule of Thirds divides an image into 9 equal parts using 2 horizontal and 2 vertical lines.',
  'Nguyên tắc 1/3 chia hình ảnh thành 9 phần bằng nhau bằng 2 đường ngang và 2 đường dọc.',
  '/media/images/image_test_2.jpg',
  'true',
  'The Rule of Thirds is a compositional guideline that divides the frame into 9 equal rectangles (3×3 grid). Key elements should be placed along the lines or at their intersections for a more balanced composition.',
  'Nguyên tắc 1/3 là hướng dẫn bố cục chia khung hình thành 9 hình chữ nhật bằng nhau (lưới 3×3). Các yếu tố chính nên được đặt dọc theo các đường hoặc tại giao điểm của chúng để có bố cục cân bằng hơn.',
  2, 10
FROM lesson l
WHERE l.slug = 'visual-design-analysis';


-- Exercise 3: Fill blank with image
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, image_url, correct_answer, explanation, explanation_vi, hint, hint_vi, order_index, points)
SELECT l.id,
  'fill_blank', 'medium',
  'The intentional use of empty space in a design is called _____ space.',
  'Việc sử dụng có chủ đích không gian trống trong thiết kế được gọi là khoảng _____.',
  '/media/images/image_test_1.jpg',
  'white',
  'White space (also called negative space) is the empty area between and around design elements. Despite its name, it doesn''t have to be white — it''s any unmarked space in a composition.',
  'Khoảng trắng (hay còn gọi là không gian âm) là vùng trống giữa và xung quanh các phần tử thiết kế. Dù tên gọi là "trắng", nó không nhất thiết phải là màu trắng — đó là bất kỳ không gian chưa được đánh dấu nào trong bố cục.',
  'It shares its name with a common color',
  'Nó chia sẻ tên với một màu phổ biến',
  3, 15
FROM lesson l
WHERE l.slug = 'visual-design-analysis';


-- Exercise 4: Multiple choice with audio
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, audio_url, explanation, explanation_vi, order_index, points)
SELECT l.id,
  'multiple_choice', 'medium',
  'In visual hierarchy, which method is MOST effective for indicating the primary element on a page?',
  'Trong thứ bậc thị giác, phương pháp nào HIỆU QUẢ NHẤT để chỉ ra phần tử chính trên trang?',
  '/media/audios/audio_test_1.mp3',
  'Making the primary element larger than surrounding elements is the most immediate and effective way to establish visual hierarchy. Size is processed pre-attentively by the brain.',
  'Làm cho phần tử chính lớn hơn các phần tử xung quanh là cách trực tiếp và hiệu quả nhất để thiết lập thứ bậc thị giác. Kích thước được xử lý tiền ý thức bởi não.',
  4, 15
FROM lesson l
WHERE l.slug = 'visual-design-analysis';

-- Options for Exercise 4
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, explanation, explanation_vi, order_index)
SELECT e.id, 'A', 'Using the same size for all elements', 'Sử dụng cùng kích thước cho mọi phần tử', FALSE,
  'Same-sized elements create no hierarchy — everything competes for attention equally.',
  'Các phần tử cùng kích thước không tạo thứ bậc — mọi thứ cạnh tranh sự chú ý như nhau.', 1
FROM exercise e
JOIN lesson l ON e.lesson_id = l.id
WHERE l.slug = 'visual-design-analysis' AND e.order_index = 4;

INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, explanation, explanation_vi, order_index)
SELECT e.id, 'B', 'Making the primary element significantly larger', 'Làm phần tử chính lớn hơn đáng kể', TRUE,
  'Correct! Size difference is processed pre-attentively and immediately establishes hierarchy.',
  'Đúng! Sự khác biệt kích thước được xử lý tiền ý thức và ngay lập tức thiết lập thứ bậc.', 2
FROM exercise e
JOIN lesson l ON e.lesson_id = l.id
WHERE l.slug = 'visual-design-analysis' AND e.order_index = 4;

INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, explanation, explanation_vi, order_index)
SELECT e.id, 'C', 'Placing all elements in the center', 'Đặt mọi phần tử ở giữa', FALSE,
  'Center placement doesn''t create hierarchy — it just centers everything.',
  'Đặt ở giữa không tạo thứ bậc — chỉ đơn giản là đặt mọi thứ vào trung tâm.', 3
FROM exercise e
JOIN lesson l ON e.lesson_id = l.id
WHERE l.slug = 'visual-design-analysis' AND e.order_index = 4;

INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, explanation, explanation_vi, order_index)
SELECT e.id, 'D', 'Using only one font throughout', 'Chỉ sử dụng một font chữ', FALSE,
  'A single font creates consistency but not hierarchy by itself.',
  'Một font chữ duy nhất tạo sự nhất quán nhưng không tạo thứ bậc.', 4
FROM exercise e
JOIN lesson l ON e.lesson_id = l.id
WHERE l.slug = 'visual-design-analysis' AND e.order_index = 4;


-- Exercise 5: True/False with both image and audio
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, image_url, audio_url, correct_answer, explanation, explanation_vi, order_index, points)
SELECT l.id,
  'true_false', 'easy',
  'White space in a design is considered wasted space that should be filled with content.',
  'Khoảng trắng trong thiết kế được coi là không gian lãng phí cần được lấp đầy bằng nội dung.',
  '/media/images/image_test_2.jpg',
  '/media/audios/audio_test_1.mp3',
  'false',
  'White space is NOT wasted space. It is an intentional design choice that improves readability, creates visual breathing room, and helps guide the viewer''s attention to important elements.',
  'Khoảng trắng KHÔNG PHẢI là không gian lãng phí. Đó là lựa chọn thiết kế có chủ đích giúp cải thiện khả năng đọc, tạo không gian thở cho thị giác và giúp hướng sự chú ý của người xem đến các yếu tố quan trọng.',
  5, 10
FROM lesson l
WHERE l.slug = 'visual-design-analysis';


-- ============================================================================
-- Verification query (run manually to check)
-- ============================================================================
-- SELECT
--   c.name AS category,
--   l.title AS lesson,
--   ls.type AS section_type,
--   ls.title AS section_title,
--   ls.metadata->>'src' AS media_src
-- FROM lesson_section ls
-- JOIN lesson l ON ls.lesson_id = l.id
-- JOIN category c ON l.group_id = c.id
-- WHERE ls.type IN ('video', 'audio', 'image')
-- ORDER BY c.name, l.order_index, ls.order_index;
--
-- SELECT
--   c.name AS category, l.title AS lesson,
--   e.type AS exercise_type, e.image_url, e.audio_url
-- FROM exercise e
-- JOIN lesson l ON e.lesson_id = l.id
-- JOIN category c ON l.group_id = c.id
-- WHERE e.image_url IS NOT NULL OR e.audio_url IS NOT NULL
-- ORDER BY c.name, l.order_index, e.order_index;
