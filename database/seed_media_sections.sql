-- ============================================================================
-- SEED DATA: Multimedia Sections (Phase 19B)
-- Adds YouTube video and audio sections to existing lessons
--
-- VIDEO sections (order_index 20) added to FIRST lesson in:
--   - Python Basics       → Python in 100 Seconds (Fireship)
--   - World History       → Crash Course World History intro
--   - UI/UX Design        → Design principles
--
-- AUDIO sections (order_index 20) added to FIRST lesson in:
--   - Music Theory        → /media/audios/audio_test_1.mp3
--   - Psychology          → /media/audios/audio_test_1.mp3
--   - Present (English)   → /media/audios/audio_test_1.mp3
--
-- Compatible with: schema.sql v7+
-- Applied AFTER: all category seed files (categories 1–15)
-- ============================================================================


-- ============================================================================
-- VIDEO SECTIONS
-- ============================================================================

-- Python Basics: first lesson
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'video', 'Tutorial Video', 'Video Hướng Dẫn',
  NULL, NULL,
  20,
  '{"provider": "youtube", "videoId": "x7X9w_GIm1s"}'::jsonb
FROM lesson l
JOIN category c ON l.group_id = c.id
WHERE c.name = 'Python Basics'
ORDER BY l.order_index
LIMIT 1;

-- World History: first lesson
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'video', 'Tutorial Video', 'Video Hướng Dẫn',
  NULL, NULL,
  20,
  '{"provider": "youtube", "videoId": "yUe2OZv8urY"}'::jsonb
FROM lesson l
JOIN category c ON l.group_id = c.id
WHERE c.name = 'World History'
ORDER BY l.order_index
LIMIT 1;

-- UI/UX Design: first lesson
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'video', 'Tutorial Video', 'Video Hướng Dẫn',
  NULL, NULL,
  20,
  '{"provider": "youtube", "videoId": "_W0bSen8Qjg"}'::jsonb
FROM lesson l
JOIN category c ON l.group_id = c.id
WHERE c.name = 'UI/UX Design'
ORDER BY l.order_index
LIMIT 1;


-- ============================================================================
-- AUDIO SECTIONS
-- ============================================================================

-- Music Theory: first lesson
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'audio', 'Listen: Introduction', 'Nghe: Giới Thiệu',
  NULL, NULL,
  20,
  '{"src": "/media/audios/audio_test_1.mp3"}'::jsonb
FROM lesson l
JOIN category c ON l.group_id = c.id
WHERE c.name = 'Music Theory'
ORDER BY l.order_index
LIMIT 1;

-- Psychology: first lesson
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'audio', 'Listen: Introduction', 'Nghe: Giới Thiệu',
  NULL, NULL,
  20,
  '{"src": "/media/audios/audio_test_1.mp3"}'::jsonb
FROM lesson l
JOIN category c ON l.group_id = c.id
WHERE c.name = 'Psychology'
ORDER BY l.order_index
LIMIT 1;

-- Present (English Grammar): first lesson in the 'Present' category
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata)
SELECT l.id,
  'audio', 'Listen: Introduction', 'Nghe: Giới Thiệu',
  NULL, NULL,
  20,
  '{"src": "/media/audios/audio_test_1.mp3"}'::jsonb
FROM lesson l
JOIN category c ON l.group_id = c.id
WHERE c.name = 'Present'
ORDER BY l.order_index
LIMIT 1;
