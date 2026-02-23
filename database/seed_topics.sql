-- ============================================================================
-- SEED DATA: Topics (meta-groups for categories)
-- Run AFTER: migration 017 + all category seed files
-- ============================================================================

-- Insert topics (6 domain groups)
INSERT INTO topic (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('English Grammar', 'Ngữ Pháp Tiếng Anh',
 'Master English grammar tenses and sentence structures',
 'Nắm vững thì và cấu trúc câu tiếng Anh',
 'Translate', '#10b981', 1),

('Computer Science', 'Khoa Học Máy Tính',
 'Programming, cybersecurity, data science, and systems thinking',
 'Lập trình, bảo mật, khoa học dữ liệu và tư duy hệ thống',
 'Computer', '#3b82f6', 2),

('Natural Sciences', 'Khoa Học Tự Nhiên',
 'Mathematics, physics, chemistry, and biology',
 'Toán học, vật lý, hóa học và sinh học',
 'Science', '#06b6d4', 3),

('Social Sciences', 'Khoa Học Xã Hội',
 'Psychology, economics, philosophy, and history',
 'Tâm lý học, kinh tế học, triết học và lịch sử',
 'HistoryEdu', '#8b5cf6', 4),

('Creative Arts', 'Nghệ Thuật Sáng Tạo',
 'Design principles, music theory, and visual arts',
 'Nguyên tắc thiết kế, lý thuyết âm nhạc và nghệ thuật thị giác',
 'Palette', '#f43f5e', 5),

('Business & Life Skills', 'Kinh Doanh & Kỹ Năng Sống',
 'Management, finance, and effective learning techniques',
 'Quản lý, tài chính và kỹ thuật học tập hiệu quả',
 'TrendingUp', '#f59e0b', 6)
ON CONFLICT (name) DO NOTHING;


-- Assign categories to topics
-- English Grammar
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'English Grammar')
WHERE name IN ('Present', 'Past', 'Future');

-- Computer Science
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Computer Science')
WHERE name IN ('Python Basics', 'Cybersecurity Basics', 'Data Science', 'Systems Thinking');

-- Natural Sciences
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Natural Sciences')
WHERE name IN ('Math Foundations', 'Physics Fundamentals', 'Chemistry Basics', 'Medicine & Biology');

-- Social Sciences
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Social Sciences')
WHERE name IN ('Psychology 101', 'Economics 101', 'Philosophy', 'World History');

-- Creative Arts
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Creative Arts')
WHERE name IN ('UI/UX Design Basics', 'Music Theory');

-- Business & Life Skills
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Business & Life Skills')
WHERE name IN ('Management', 'Personal Finance', 'Learning Methods');
