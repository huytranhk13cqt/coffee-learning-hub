-- ============================================================================
-- SEED DATA: Topics & New Categories (44 topics, 28 new categories)
-- Run AFTER: migration 019 + all existing category seed files
--
-- This file:
--   1. Clears old topic assignments & topics
--   2. Creates 44 topics (one per subject domain)
--   3. Creates 28 new categories for previously uncovered subjects
--   4. Assigns all 48 categories to their respective topics
-- ============================================================================

-- Step 1: Reset existing assignments and topics
UPDATE category SET topic_id = NULL;
DELETE FROM topic;

-- Step 2: Insert 44 topics
-- Grouped by domain for readability; order_index determines UI display order
INSERT INTO topic (name, name_vi, description, description_vi, icon, color, order_index) VALUES

-- === Technology & Computing (1-7) ===
('Coding', 'Lập Trình',
 'Programming fundamentals, software development, and algorithms',
 'Nền tảng lập trình, phát triển phần mềm và thuật toán',
 'Code', '#3b82f6', 1),

('Data', 'Dữ Liệu',
 'Data analysis, data engineering, data science, and statistics',
 'Phân tích dữ liệu, kỹ thuật dữ liệu, khoa học dữ liệu và thống kê',
 'BarChart', '#6366f1', 2),

('Cybersecurity', 'An Ninh Mạng',
 'Information security, network defense, and digital safety',
 'Bảo mật thông tin, phòng thủ mạng và an toàn kỹ thuật số',
 'Security', '#ef4444', 3),

('IoT', 'Internet Vạn Vật',
 'Internet of Things, networking, and embedded systems',
 'Internet vạn vật, mạng máy tính và hệ thống nhúng',
 'Router', '#0ea5e9', 4),

('Electronics & Hardware', 'Điện Tử & Phần Cứng',
 'Circuit design, microcontrollers, and hardware engineering',
 'Thiết kế mạch, vi điều khiển và kỹ thuật phần cứng',
 'DeveloperBoard', '#14b8a6', 5),

('Technology', 'Công Nghệ',
 'Digital literacy, AI fundamentals, and emerging technologies',
 'Kỹ năng số, nền tảng AI và công nghệ mới nổi',
 'Devices', '#64748b', 6),

('Game Design', 'Thiết Kế Trò Chơi',
 'Game development, mechanics, narrative design, and level design',
 'Phát triển game, cơ chế, thiết kế tường thuật và thiết kế level',
 'SportsEsports', '#a855f7', 7),

-- === Natural Sciences (8-12) ===
('Natural Sciences', 'Khoa Học Tự Nhiên',
 'Mathematics, physics, and chemistry',
 'Toán học, vật lý và hóa học',
 'Science', '#06b6d4', 8),

('Astronomy', 'Thiên Văn Học',
 'Stars, planets, galaxies, and the cosmos',
 'Ngôi sao, hành tinh, thiên hà và vũ trụ',
 'RocketLaunch', '#1e40af', 9),

('Environment & Sustainability', 'Môi Trường & Bền Vững',
 'Climate change, conservation, and sustainable development',
 'Biến đổi khí hậu, bảo tồn và phát triển bền vững',
 'Park', '#16a34a', 10),

('Agriculture & Botany', 'Nông Nghiệp & Thực Vật Học',
 'Crop science, plant biology, and farming techniques',
 'Khoa học cây trồng, sinh học thực vật và kỹ thuật canh tác',
 'Grass', '#65a30d', 11),

('Urban Farming', 'Nông Nghiệp Đô Thị',
 'City agriculture, vertical farming, and community gardens',
 'Nông nghiệp thành phố, canh tác thẳng đứng và vườn cộng đồng',
 'Nature', '#4ade80', 12),

-- === Life Sciences & Health (13-17) ===
('Medicine & Health', 'Y Khoa & Sức Khỏe',
 'Biology, medicine, pharmacy, and public health',
 'Sinh học, y học, dược học và y tế cộng đồng',
 'LocalHospital', '#dc2626', 13),

('Sports Science', 'Khoa Học Thể Thao',
 'Exercise physiology, nutrition for athletes, and training science',
 'Sinh lý vận động, dinh dưỡng thể thao và khoa học huấn luyện',
 'FitnessCenter', '#f97316', 14),

('Martial Arts & Self-Defense', 'Võ Thuật & Tự Vệ',
 'Combat techniques, philosophy of martial arts, and personal safety',
 'Kỹ thuật chiến đấu, triết lý võ thuật và an toàn cá nhân',
 'SportsMartialArts', '#b91c1c', 15),

('Sleep Science', 'Giấc Ngủ Học',
 'Sleep physiology, circadian rhythms, and sleep disorders',
 'Sinh lý giấc ngủ, nhịp sinh học và rối loạn giấc ngủ',
 'NightsStay', '#7c3aed', 16),

('Culinary Science', 'Khoa Học Ẩm Thực',
 'Food science, cooking chemistry, and gastronomy',
 'Khoa học thực phẩm, hóa học nấu nướng và ẩm thực',
 'Restaurant', '#ea580c', 17),

-- === Social Sciences (18-22) ===
('Psychology', 'Tâm Lý Học',
 'Human behavior, cognition, and mental health',
 'Hành vi con người, nhận thức và sức khỏe tinh thần',
 'Psychology', '#8b5cf6', 18),

('Sociology & Anthropology', 'Xã Hội Học & Nhân Học',
 'Social structures, cultural anthropology, and human societies',
 'Cấu trúc xã hội, nhân học văn hóa và xã hội loài người',
 'Groups', '#0891b2', 19),

('Gender Studies & Family', 'Giới & Gia Đình',
 'Gender theory, family dynamics, and social equality',
 'Lý thuyết giới, động lực gia đình và bình đẳng xã hội',
 'Diversity3', '#ec4899', 20),

('Criminology & Forensics', 'Tội Phạm Học & Pháp Y',
 'Criminal behavior, forensic science, and justice systems',
 'Hành vi tội phạm, khoa học pháp y và hệ thống tư pháp',
 'Policy', '#475569', 21),

('Pedagogy', 'Sư Phạm Học',
 'Teaching methods, curriculum design, and educational psychology',
 'Phương pháp giảng dạy, thiết kế chương trình và tâm lý giáo dục',
 'CastForEducation', '#0d9488', 22),

-- === Humanities (23-28) ===
('Philosophy', 'Triết Học',
 'Logic, ethics, metaphysics, and great thinkers',
 'Logic, đạo đức, siêu hình học và các nhà tư tưởng vĩ đại',
 'AutoStories', '#9333ea', 23),

('History', 'Lịch Sử',
 'World history, civilizations, and historical analysis',
 'Lịch sử thế giới, nền văn minh và phân tích lịch sử',
 'HistoryEdu', '#78716c', 24),

('Geography', 'Địa Lý',
 'Physical geography, human geography, and cartography',
 'Địa lý tự nhiên, địa lý nhân văn và bản đồ học',
 'Public', '#0284c7', 25),

('Geopolitics', 'Địa Chính Trị',
 'International relations, global power dynamics, and political geography',
 'Quan hệ quốc tế, động lực quyền lực toàn cầu và địa lý chính trị',
 'Language', '#1e3a5f', 26),

('Politics & Law', 'Chính Trị & Pháp Luật',
 'Political systems, legal principles, and governance',
 'Hệ thống chính trị, nguyên tắc pháp luật và quản trị nhà nước',
 'Gavel', '#7e22ce', 27),

('Linguistics', 'Ngôn Ngữ Học & Ngoại Ngữ',
 'Language structure, phonetics, semantics, and multilingualism',
 'Cấu trúc ngôn ngữ, ngữ âm, ngữ nghĩa và đa ngữ',
 'Translate', '#10b981', 28),

-- === Economics & Business (29-35) ===
('Economics', 'Kinh Tế Học',
 'Micro/macroeconomics, market mechanisms, and economic policy',
 'Vi mô/vĩ mô, cơ chế thị trường và chính sách kinh tế',
 'TrendingUp', '#ca8a04', 29),

('Personal Finance', 'Tài Chính Cá Nhân',
 'Budgeting, investing, tax planning, and financial literacy',
 'Quản lý ngân sách, đầu tư, thuế và kỹ năng tài chính',
 'Savings', '#f59e0b', 30),

('Marketing & Media', 'Marketing & Truyền Thông',
 'Digital marketing, brand strategy, and media communications',
 'Marketing số, chiến lược thương hiệu và truyền thông đa phương tiện',
 'Campaign', '#f43f5e', 31),

('Management & Entrepreneurship', 'Quản Trị & Khởi Nghiệp',
 'Leadership, business strategy, and startup management',
 'Lãnh đạo, chiến lược kinh doanh và quản lý startup',
 'BusinessCenter', '#d946ef', 32),

('Negotiation', 'Đàm Phán & Thuyết Phục',
 'Negotiation tactics, persuasion psychology, and conflict resolution',
 'Chiến thuật đàm phán, tâm lý thuyết phục và giải quyết xung đột',
 'Handshake', '#be185d', 33),

('Supply Chain & Logistics', 'Chuỗi Cung Ứng & Hậu Cần',
 'Inventory management, transportation, and supply chain optimization',
 'Quản lý kho, vận tải và tối ưu hóa chuỗi cung ứng',
 'LocalShipping', '#a16207', 34),

('Game Theory', 'Lý Thuyết Trò Chơi',
 'Strategic decision-making, Nash equilibrium, and applications',
 'Ra quyết định chiến lược, cân bằng Nash và ứng dụng',
 'Extension', '#4f46e5', 35),

-- === Creative Arts & Media (36-39) ===
('Design UI/UX', 'Thiết Kế UI/UX',
 'User interface, user experience, and design thinking',
 'Giao diện người dùng, trải nghiệm người dùng và tư duy thiết kế',
 'DesignServices', '#e11d48', 36),

('Music', 'Âm Nhạc',
 'Music theory, composition, and musical analysis',
 'Lý thuyết âm nhạc, sáng tác và phân tích âm nhạc',
 'MusicNote', '#db2777', 37),

('Literature & Creative Writing', 'Văn Học & Viết Lách',
 'Literary analysis, creative writing, and storytelling techniques',
 'Phân tích văn học, viết sáng tạo và kỹ thuật kể chuyện',
 'MenuBook', '#9f1239', 38),

('Fine Arts & Architecture', 'Mỹ Thuật & Kiến Trúc',
 'Visual arts, art history, and architectural principles',
 'Nghệ thuật thị giác, lịch sử nghệ thuật và nguyên tắc kiến trúc',
 'Brush', '#c026d3', 39),

('Photography & Film', 'Nhiếp Ảnh & Điện Ảnh',
 'Photography techniques, filmmaking, and visual storytelling',
 'Kỹ thuật nhiếp ảnh, làm phim và kể chuyện bằng hình ảnh',
 'CameraAlt', '#fb923c', 40),

-- === Engineering & Applied (41-42) ===
('Mechanics & DIY', 'Cơ Khí & Sửa Chữa',
 'Mechanical engineering basics, repair skills, and DIY projects',
 'Cơ khí cơ bản, kỹ năng sửa chữa và dự án tự làm',
 'Build', '#57534e', 41),

('Military Strategy', 'Quân Sự Học & Chiến Lược',
 'Military history, strategy, tactics, and leadership in combat',
 'Lịch sử quân sự, chiến lược, chiến thuật và lãnh đạo trong chiến đấu',
 'Shield', '#334155', 42),

-- === Education & Meta-learning (43-44) ===
('Systems Thinking', 'Tư Duy Hệ Thống',
 'Systems analysis, feedback loops, and holistic problem solving',
 'Phân tích hệ thống, vòng phản hồi và giải quyết vấn đề tổng thể',
 'AccountTree', '#059669', 43),

('Learning Methods', 'Phương Pháp Học Tập',
 'Study techniques, memory science, and meta-learning strategies',
 'Kỹ thuật học tập, khoa học trí nhớ và chiến lược siêu nhận thức',
 'School', '#2563eb', 44)

ON CONFLICT (name) DO NOTHING;


-- ============================================================================
-- Step 3: Create 28 new categories (for previously uncovered subjects)
-- ============================================================================

INSERT INTO category (name, name_vi, description, description_vi, color, order_index) VALUES
-- Tech & Computing
('IoT Fundamentals', 'Nền Tảng IoT',
 'Introduction to Internet of Things, sensors, and connected devices',
 'Giới thiệu Internet vạn vật, cảm biến và thiết bị kết nối',
 '#0ea5e9', 1),

('Technology Essentials', 'Công Nghệ Căn Bản',
 'Digital literacy, AI fundamentals, cloud computing, and emerging tech',
 'Kỹ năng số, nền tảng AI, điện toán đám mây và công nghệ mới',
 '#64748b', 1),

('Electronics & Hardware', 'Điện Tử & Phần Cứng',
 'Circuit design, microcontrollers, and hardware projects',
 'Thiết kế mạch, vi điều khiển và dự án phần cứng',
 '#14b8a6', 1),

('Game Design', 'Thiết Kế Trò Chơi',
 'Game mechanics, level design, and game development principles',
 'Cơ chế game, thiết kế level và nguyên tắc phát triển game',
 '#a855f7', 1),

-- Natural Sciences
('Astronomy & Space', 'Thiên Văn & Vũ Trụ',
 'Stars, planets, galaxies, cosmology, and space exploration',
 'Ngôi sao, hành tinh, thiên hà, vũ trụ học và khám phá không gian',
 '#1e40af', 1),

('Environmental Science', 'Khoa Học Môi Trường',
 'Climate, ecosystems, conservation, and sustainability',
 'Khí hậu, hệ sinh thái, bảo tồn và phát triển bền vững',
 '#16a34a', 1),

('Agriculture & Botany', 'Nông Nghiệp & Thực Vật Học',
 'Crop science, plant biology, and agricultural techniques',
 'Khoa học cây trồng, sinh học thực vật và kỹ thuật nông nghiệp',
 '#65a30d', 1),

('Urban Farming', 'Nông Nghiệp Đô Thị',
 'City farming, vertical agriculture, and community gardens',
 'Nông nghiệp thành phố, canh tác thẳng đứng và vườn cộng đồng',
 '#4ade80', 1),

-- Life Sciences & Health
('Sports Science', 'Khoa Học Thể Thao',
 'Exercise physiology, sports nutrition, and training methods',
 'Sinh lý vận động, dinh dưỡng thể thao và phương pháp huấn luyện',
 '#f97316', 1),

('Martial Arts & Self-Defense', 'Võ Thuật & Tự Vệ',
 'Martial arts history, techniques, philosophy, and self-defense',
 'Lịch sử võ thuật, kỹ thuật, triết lý và tự vệ',
 '#b91c1c', 1),

('Sleep Science', 'Giấc Ngủ Học',
 'Sleep cycles, circadian rhythms, sleep hygiene, and disorders',
 'Chu kỳ giấc ngủ, nhịp sinh học, vệ sinh giấc ngủ và rối loạn',
 '#7c3aed', 1),

('Culinary Science', 'Khoa Học Ẩm Thực',
 'Food chemistry, cooking techniques, and gastronomy',
 'Hóa học thực phẩm, kỹ thuật nấu nướng và ẩm thực',
 '#ea580c', 1),

-- Social Sciences
('Sociology & Anthropology', 'Xã Hội Học & Nhân Học',
 'Social structures, cultural anthropology, and human behavior in groups',
 'Cấu trúc xã hội, nhân học văn hóa và hành vi nhóm',
 '#0891b2', 1),

('Gender Studies & Family', 'Giới & Gia Đình',
 'Gender theory, family dynamics, and social equality',
 'Lý thuyết giới, động lực gia đình và bình đẳng xã hội',
 '#ec4899', 1),

('Criminology & Forensics', 'Tội Phạm Học & Pháp Y',
 'Criminal behavior, forensic science, and justice systems',
 'Hành vi tội phạm, khoa học pháp y và hệ thống tư pháp',
 '#475569', 1),

('Pedagogy', 'Sư Phạm Học',
 'Teaching methods, curriculum design, and educational theory',
 'Phương pháp giảng dạy, thiết kế chương trình và lý thuyết giáo dục',
 '#0d9488', 1),

-- Humanities
('Geography Basics', 'Địa Lý Cơ Bản',
 'Physical and human geography, maps, and geospatial analysis',
 'Địa lý tự nhiên và nhân văn, bản đồ và phân tích không gian',
 '#0284c7', 1),

('Geopolitics', 'Địa Chính Trị',
 'International relations, global power, and political geography',
 'Quan hệ quốc tế, quyền lực toàn cầu và địa lý chính trị',
 '#1e3a5f', 1),

('Political Science & Law', 'Chính Trị & Pháp Luật',
 'Political systems, constitutional law, and governance',
 'Hệ thống chính trị, luật hiến pháp và quản trị nhà nước',
 '#7e22ce', 1),

-- Business & Economics
('Marketing & Media', 'Marketing & Truyền Thông',
 'Digital marketing, branding, advertising, and media strategy',
 'Marketing số, xây dựng thương hiệu, quảng cáo và chiến lược truyền thông',
 '#f43f5e', 1),

('Negotiation & Persuasion', 'Đàm Phán & Thuyết Phục',
 'Negotiation strategies, influence psychology, and conflict resolution',
 'Chiến lược đàm phán, tâm lý ảnh hưởng và giải quyết xung đột',
 '#be185d', 1),

('Supply Chain & Logistics', 'Chuỗi Cung Ứng & Hậu Cần',
 'Inventory, transportation, warehousing, and supply chain management',
 'Kho bãi, vận tải, lưu kho và quản lý chuỗi cung ứng',
 '#a16207', 1),

('Game Theory', 'Lý Thuyết Trò Chơi',
 'Strategic interactions, Nash equilibrium, and decision analysis',
 'Tương tác chiến lược, cân bằng Nash và phân tích quyết định',
 '#4f46e5', 1),

-- Creative Arts
('Literature & Creative Writing', 'Văn Học & Viết Lách',
 'Literary genres, creative writing, and storytelling',
 'Thể loại văn học, viết sáng tạo và nghệ thuật kể chuyện',
 '#9f1239', 1),

('Fine Arts & Architecture', 'Mỹ Thuật & Kiến Trúc',
 'Painting, sculpture, art history, and architectural design',
 'Hội họa, điêu khắc, lịch sử nghệ thuật và thiết kế kiến trúc',
 '#c026d3', 1),

('Photography & Film', 'Nhiếp Ảnh & Điện Ảnh',
 'Camera techniques, filmmaking, editing, and visual narrative',
 'Kỹ thuật máy ảnh, làm phim, biên tập và tường thuật hình ảnh',
 '#fb923c', 1),

-- Engineering & Strategy
('Mechanics & DIY', 'Cơ Khí & Sửa Chữa',
 'Mechanical principles, repair skills, and hands-on projects',
 'Nguyên lý cơ khí, kỹ năng sửa chữa và dự án thực hành',
 '#57534e', 1),

('Military Strategy', 'Quân Sự Học & Chiến Lược',
 'Military history, strategic thinking, and tactical analysis',
 'Lịch sử quân sự, tư duy chiến lược và phân tích chiến thuật',
 '#334155', 1)

ON CONFLICT (name) DO NOTHING;


-- ============================================================================
-- Step 4: Assign ALL categories to their respective topics
-- ============================================================================

-- 1. Coding
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Coding')
WHERE name IN ('Python Basics');

-- 2. Data
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Data')
WHERE name IN ('Data Science');

-- 3. Cybersecurity
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Cybersecurity')
WHERE name IN ('Cybersecurity Basics');

-- 4. IoT
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'IoT')
WHERE name IN ('IoT Fundamentals');

-- 5. Electronics & Hardware
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Electronics & Hardware')
WHERE name IN ('Electronics & Hardware');

-- 6. Technology
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Technology')
WHERE name IN ('Technology Essentials');

-- 7. Game Design
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Game Design')
WHERE name IN ('Game Design');

-- 8. Natural Sciences
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Natural Sciences')
WHERE name IN ('Math Foundations', 'Physics Fundamentals', 'Chemistry Basics');

-- 9. Astronomy
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Astronomy')
WHERE name IN ('Astronomy & Space');

-- 10. Environment & Sustainability
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Environment & Sustainability')
WHERE name IN ('Environmental Science');

-- 11. Agriculture & Botany
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Agriculture & Botany')
WHERE name IN ('Agriculture & Botany');

-- 12. Urban Farming
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Urban Farming')
WHERE name IN ('Urban Farming');

-- 13. Medicine & Health
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Medicine & Health')
WHERE name IN ('Medicine & Biology');

-- 14. Sports Science
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Sports Science')
WHERE name IN ('Sports Science');

-- 15. Martial Arts & Self-Defense
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Martial Arts & Self-Defense')
WHERE name IN ('Martial Arts & Self-Defense');

-- 16. Sleep Science
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Sleep Science')
WHERE name IN ('Sleep Science');

-- 17. Culinary Science
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Culinary Science')
WHERE name IN ('Culinary Science');

-- 18. Psychology
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Psychology')
WHERE name IN ('Psychology 101');

-- 19. Sociology & Anthropology
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Sociology & Anthropology')
WHERE name IN ('Sociology & Anthropology');

-- 20. Gender Studies & Family
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Gender Studies & Family')
WHERE name IN ('Gender Studies & Family');

-- 21. Criminology & Forensics
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Criminology & Forensics')
WHERE name IN ('Criminology & Forensics');

-- 22. Pedagogy
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Pedagogy')
WHERE name IN ('Pedagogy');

-- 23. Philosophy
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Philosophy')
WHERE name IN ('Philosophy');

-- 24. History
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'History')
WHERE name IN ('World History');

-- 25. Geography
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Geography')
WHERE name IN ('Geography Basics');

-- 26. Geopolitics
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Geopolitics')
WHERE name IN ('Geopolitics');

-- 27. Politics & Law
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Politics & Law')
WHERE name IN ('Political Science & Law');

-- 28. Linguistics
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Linguistics')
WHERE name IN ('Present', 'Past', 'Future');

-- 29. Economics
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Economics')
WHERE name IN ('Economics 101');

-- 30. Personal Finance
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Personal Finance')
WHERE name IN ('Personal Finance');

-- 31. Marketing & Media
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Marketing & Media')
WHERE name IN ('Marketing & Media');

-- 32. Management & Entrepreneurship
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Management & Entrepreneurship')
WHERE name IN ('Management');

-- 33. Negotiation
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Negotiation')
WHERE name IN ('Negotiation & Persuasion');

-- 34. Supply Chain & Logistics
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Supply Chain & Logistics')
WHERE name IN ('Supply Chain & Logistics');

-- 35. Game Theory
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Game Theory')
WHERE name IN ('Game Theory');

-- 36. Design UI/UX
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Design UI/UX')
WHERE name IN ('UI/UX Design Basics');

-- 37. Music
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Music')
WHERE name IN ('Music Theory');

-- 38. Literature & Creative Writing
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Literature & Creative Writing')
WHERE name IN ('Literature & Creative Writing');

-- 39. Fine Arts & Architecture
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Fine Arts & Architecture')
WHERE name IN ('Fine Arts & Architecture');

-- 40. Photography & Film
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Photography & Film')
WHERE name IN ('Photography & Film');

-- 41. Mechanics & DIY
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Mechanics & DIY')
WHERE name IN ('Mechanics & DIY');

-- 42. Military Strategy
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Military Strategy')
WHERE name IN ('Military Strategy');

-- 43. Systems Thinking
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Systems Thinking')
WHERE name IN ('Systems Thinking');

-- 44. Learning Methods
UPDATE category SET topic_id = (SELECT id FROM topic WHERE name = 'Learning Methods')
WHERE name IN ('Learning Methods');
