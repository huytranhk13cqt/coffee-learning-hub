-- ============================================================================
-- SEED DATA: Medicine & Biology (Category 17)
-- Category: Medicine & Biology (ID 17, order_index 17)
-- Lessons: body-systems-overview, immune-system, genetics-fundamentals
-- Compatible with: schema.sql v7+
-- Applied AFTER: seed_personal_finance (category 18) or standalone
-- ============================================================================


-- ============================================================================
-- CATEGORY 17: Medicine & Biology
-- ============================================================================

INSERT INTO category (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('Medicine & Biology', 'Y Học & Sinh Học',
 'Explore human anatomy, physiology, and biological systems',
 'Khám phá giải phẫu người, sinh lý học và các hệ thống sinh học',
 'Biotech', '#ec4899', 17);


-- ############################################################################
-- LESSON 1: HUMAN BODY SYSTEMS (slug: body-systems-overview)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Human Body Systems', 'Các Hệ Thống Cơ Thể Người',
  'body-systems-overview',
  'Explore the major organ systems and how they work together',
  'Khám phá các hệ thống cơ quan chính và cách chúng phối hợp',
  'beginner', 30, 1
FROM category WHERE name = 'Medicine & Biology';


-- ============================================================================
-- LESSON USAGES: body-systems-overview
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'body-systems-overview'),
 'Cardiovascular System', 'Hệ Tim Mạch',
 'The cardiovascular system consists of the heart, blood vessels, and blood. It transports oxygen, nutrients, hormones, and waste products throughout the body, keeping every cell alive and functioning.',
 'Hệ tim mạch gồm tim, mạch máu và máu. Nó vận chuyển oxy, chất dinh dưỡng, hormone và chất thải khắp cơ thể, giữ cho mọi tế bào sống và hoạt động.',
 'Favorite', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'body-systems-overview'),
 'Nervous System', 'Hệ Thần Kinh',
 'The nervous system is the body''s communication network, consisting of the brain, spinal cord, and peripheral nerves. It processes sensory information, coordinates movement, and regulates all body functions.',
 'Hệ thần kinh là mạng lưới liên lạc của cơ thể, gồm não, tủy sống và dây thần kinh ngoại biên. Nó xử lý thông tin cảm giác, phối hợp chuyển động và điều chỉnh mọi chức năng cơ thể.',
 'Psychology', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'body-systems-overview'),
 'Digestive System', 'Hệ Tiêu Hóa',
 'The digestive system breaks down food into nutrients the body can absorb and use for energy, growth, and repair. It spans from the mouth to the large intestine, involving multiple organs working in sequence.',
 'Hệ tiêu hóa phân giải thức ăn thành chất dinh dưỡng cơ thể có thể hấp thụ và sử dụng cho năng lượng, tăng trưởng và sửa chữa. Nó trải dài từ miệng đến ruột già, gồm nhiều cơ quan hoạt động theo trình tự.',
 'Science', TRUE, 3);


-- ============================================================================
-- LESSON SECTIONS: body-systems-overview
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

-- Section 1: markdown overview
((SELECT id FROM lesson WHERE slug = 'body-systems-overview'),
 'markdown', 'Overview of Human Body Systems', 'Tổng Quan Các Hệ Thống Cơ Thể Người',
'## The Human Body: An Integrated System

The human body contains **11 major organ systems**, each with a specialized function — yet all working together to maintain life.

### Key Organ Systems

| System | Primary Function | Key Organs |
|--------|-----------------|------------|
| **Cardiovascular** | Transport blood, oxygen, nutrients | Heart, blood vessels, blood |
| **Nervous** | Communication and control | Brain, spinal cord, nerves |
| **Digestive** | Break down food, absorb nutrients | Stomach, intestines, liver |
| **Respiratory** | Gas exchange (O₂ in, CO₂ out) | Lungs, trachea, diaphragm |
| **Skeletal** | Structure, protection, movement | Bones, cartilage, joints |
| **Muscular** | Movement and posture | Skeletal, smooth, cardiac muscle |

### Homeostasis: The Body''s Balance

> **Homeostasis** is the body''s ability to maintain a stable internal environment despite external changes.

Examples:
- Body temperature held at ~37°C (98.6°F)
- Blood pH kept between 7.35–7.45
- Blood glucose regulated by insulin and glucagon

The **skin** is the body''s largest organ, forming a protective barrier between internal systems and the outside world.',

'## Cơ Thể Người: Một Hệ Thống Tích Hợp

Cơ thể người có **11 hệ cơ quan chính**, mỗi hệ có chức năng chuyên biệt — nhưng tất cả hoạt động cùng nhau để duy trì sự sống.

### Các Hệ Cơ Quan Chính

| Hệ | Chức năng chính | Cơ quan quan trọng |
|----|----------------|-------------------|
| **Tim mạch** | Vận chuyển máu, oxy, chất dinh dưỡng | Tim, mạch máu, máu |
| **Thần kinh** | Liên lạc và điều khiển | Não, tủy sống, dây thần kinh |
| **Tiêu hóa** | Phân giải thức ăn, hấp thụ chất dinh dưỡng | Dạ dày, ruột, gan |
| **Hô hấp** | Trao đổi khí (O₂ vào, CO₂ ra) | Phổi, khí quản, cơ hoành |
| **Xương** | Cấu trúc, bảo vệ, chuyển động | Xương, sụn, khớp |
| **Cơ** | Chuyển động và duy trì tư thế | Cơ xương, cơ trơn, cơ tim |

### Cân Bằng Nội Môi: Sự Cân Bằng Của Cơ Thể

> **Cân bằng nội môi** là khả năng cơ thể duy trì môi trường bên trong ổn định bất chấp những thay đổi bên ngoài.

Ví dụ:
- Nhiệt độ cơ thể duy trì ở ~37°C
- pH máu được giữ trong khoảng 7,35–7,45
- Glucose máu được điều chỉnh bởi insulin và glucagon

**Da** là cơ quan lớn nhất của cơ thể, tạo ra hàng rào bảo vệ giữa các hệ thống bên trong và thế giới bên ngoài.',
 1, '{}'),

-- Section 2: key_points
((SELECT id FROM lesson WHERE slug = 'body-systems-overview'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["Hệ tim mạch bơm máu chứa oxy và chất dinh dưỡng đến mọi tế bào trong cơ thể", "Hệ thần kinh trung ương gồm não và tủy sống — chúng điều khiển mọi chức năng cơ thể có ý thức và vô thức", "Hệ tiêu hóa phân giải thức ăn qua nhiều giai đoạn: cơ học (nhai) và hóa học (enzyme)", "Da là cơ quan lớn nhất — bảo vệ, điều nhiệt và cảm giác cùng lúc", "Cân bằng nội môi là quá trình cơ thể tự điều chỉnh để duy trì môi trường bên trong ổn định"]'::jsonb),

-- Section 3: info_box (homeostasis)
((SELECT id FROM lesson WHERE slug = 'body-systems-overview'),
 'info_box', 'What Is Homeostasis?', 'Cân Bằng Nội Môi Là Gì?',
 '**Homeostasis** is one of the most fundamental concepts in biology. It refers to the body''s continuous effort to maintain a stable internal environment — even when external conditions change dramatically.

**Classic examples:**
- **Temperature regulation:** When you exercise, you sweat to cool down. When you''re cold, you shiver to generate heat.
- **Blood sugar control:** After eating, the pancreas releases insulin to lower blood glucose. Between meals, glucagon raises it.
- **Blood pressure:** The heart rate increases or decreases to maintain adequate blood flow to organs.

Failure of homeostasis leads to disease. Diabetes, for example, is a homeostatic failure where blood glucose can no longer be regulated properly.',

 '**Cân bằng nội môi** là một trong những khái niệm cơ bản nhất trong sinh học. Nó đề cập đến nỗ lực liên tục của cơ thể để duy trì môi trường bên trong ổn định — ngay cả khi điều kiện bên ngoài thay đổi mạnh mẽ.

**Ví dụ điển hình:**
- **Điều chỉnh nhiệt độ:** Khi tập thể dục, bạn đổ mồ hôi để làm mát. Khi lạnh, bạn run để tạo nhiệt.
- **Kiểm soát đường huyết:** Sau khi ăn, tụy tiết insulin để giảm glucose máu. Giữa các bữa ăn, glucagon làm tăng nó.
- **Huyết áp:** Nhịp tim tăng hoặc giảm để duy trì lưu lượng máu đủ đến các cơ quan.

Sự thất bại của cân bằng nội môi dẫn đến bệnh tật. Ví dụ, tiểu đường là sự thất bại cân bằng nội môi khi glucose máu không còn được điều chỉnh đúng.',
 3, '{"type": "info"}'::jsonb);


-- ============================================================================
-- EXERCISES: body-systems-overview (7 exercises)
-- ============================================================================

-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'body-systems-overview'),
 'fill_blank', 'easy',
 'The ___ system transports blood and oxygen throughout the body.',
 'Hệ ___ vận chuyển máu và oxy khắp cơ thể.',
 'cardiovascular',
 'The cardiovascular system — made up of the heart, blood vessels, and blood — is the body''s transport network. It delivers oxygen and nutrients to every cell and removes carbon dioxide and waste products.',
 'Hệ tim mạch — gồm tim, mạch máu và máu — là mạng lưới vận chuyển của cơ thể. Nó cung cấp oxy và chất dinh dưỡng cho mọi tế bào và loại bỏ carbon dioxide và chất thải.',
 1);

-- Exercise 2: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'body-systems-overview'),
 'multiple_choice', 'easy',
 'How many chambers does the human heart have?',
 'Tim người có bao nhiêu buồng?',
 'The human heart has 4 chambers: two atria (upper chambers that receive blood) and two ventricles (lower chambers that pump blood out). The right side pumps blood to the lungs; the left side pumps oxygenated blood to the rest of the body.',
 'Tim người có 4 buồng: hai tâm nhĩ (buồng trên nhận máu) và hai tâm thất (buồng dưới bơm máu ra). Phía phải bơm máu đến phổi; phía trái bơm máu đã oxy hóa đến phần còn lại của cơ thể.',
 2);

WITH mc_ex AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'body-systems-overview')
  AND type = 'multiple_choice'
  AND order_index = 2
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, '2', '2', FALSE, 1 FROM mc_ex
UNION ALL SELECT id, 'B'::option_label, '3', '3', FALSE, 2 FROM mc_ex
UNION ALL SELECT id, 'C'::option_label, '4', '4', TRUE, 3 FROM mc_ex
UNION ALL SELECT id, 'D'::option_label, '5', '5', FALSE, 4 FROM mc_ex;


-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'body-systems-overview'),
 'true_false', 'easy',
 'The brain is part of the peripheral nervous system.',
 'Não là một phần của hệ thần kinh ngoại biên.',
 'false',
 'False. The brain is part of the CENTRAL nervous system (CNS), along with the spinal cord. The peripheral nervous system (PNS) consists of nerves that extend beyond the brain and spinal cord to the rest of the body.',
 'Sai. Não là một phần của hệ thần kinh TRUNG ƯƠNG (CNS), cùng với tủy sống. Hệ thần kinh ngoại biên (PNS) gồm các dây thần kinh kéo dài ngoài não và tủy sống đến phần còn lại của cơ thể.',
 3);

-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'body-systems-overview'),
 'fill_blank', 'easy',
 'The ___ is the largest organ in the human body.',
 '___ là cơ quan lớn nhất trong cơ thể người.',
 'skin',
 'The skin (integumentary system) is the largest organ, covering about 2 square meters in adults. It acts as a protective barrier, regulates body temperature through sweating, provides sensation, and synthesizes vitamin D from sunlight.',
 'Da (hệ bì) là cơ quan lớn nhất, bao phủ khoảng 2 mét vuông ở người trưởng thành. Nó đóng vai trò hàng rào bảo vệ, điều chỉnh nhiệt độ cơ thể qua đổ mồ hôi, cung cấp cảm giác và tổng hợp vitamin D từ ánh sáng mặt trời.',
 4);

-- Exercise 5: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'body-systems-overview'),
 'multiple_choice', 'easy',
 'What is the primary function of red blood cells?',
 'Chức năng chính của tế bào hồng cầu là gì?',
 'Red blood cells (erythrocytes) contain hemoglobin, a protein that binds to oxygen in the lungs and carries it to tissues throughout the body. They lack a nucleus when mature, which allows more space for hemoglobin.',
 'Hồng cầu (tế bào hồng cầu) chứa hemoglobin, một protein gắn kết với oxy ở phổi và vận chuyển đến các mô khắp cơ thể. Chúng không có nhân khi trưởng thành, giúp có nhiều không gian hơn cho hemoglobin.',
 5);

WITH mc_ex2 AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'body-systems-overview')
  AND type = 'multiple_choice'
  AND order_index = 5
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'Fight infection', 'Chống nhiễm trùng', FALSE, 1 FROM mc_ex2
UNION ALL SELECT id, 'B'::option_label, 'Carry oxygen', 'Vận chuyển oxy', TRUE, 2 FROM mc_ex2
UNION ALL SELECT id, 'C'::option_label, 'Produce antibodies', 'Sản xuất kháng thể', FALSE, 3 FROM mc_ex2
UNION ALL SELECT id, 'D'::option_label, 'Clot blood', 'Đông máu', FALSE, 4 FROM mc_ex2;


-- Exercise 6: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'body-systems-overview'),
 'true_false', 'easy',
 'The stomach produces hydrochloric acid to help digest food.',
 'Dạ dày sản xuất axit clohydric để giúp tiêu hóa thức ăn.',
 'true',
 'True. The stomach secretes hydrochloric acid (HCl), which creates an acidic environment (pH 1.5–3.5) that activates digestive enzymes like pepsin. This acid also kills most bacteria and pathogens that enter with food.',
 'Đúng. Dạ dày tiết axit clohydric (HCl), tạo ra môi trường axit (pH 1,5–3,5) kích hoạt các enzyme tiêu hóa như pepsin. Axit này cũng tiêu diệt hầu hết vi khuẩn và mầm bệnh đi vào cùng thức ăn.',
 6);

-- Exercise 7: error_correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'body-systems-overview'),
 'error_correction', 'medium',
 'Fix the error in this sentence: "The lungs absorb oxygen and releases carbon dioxide during breathe."',
 'Sửa lỗi trong câu này: "The lungs absorb oxygen and releases carbon dioxide during breathe."',
 'The lungs absorb oxygen and release carbon dioxide during breathing.',
 'Two errors: (1) "releases" should be "release" — subject "lungs" is plural, so the verb must also be plural. (2) "during breathe" should be "during breathing" — after a preposition, the gerund form (-ing) is required.',
 'Hai lỗi: (1) "releases" phải là "release" — chủ ngữ "lungs" là số nhiều nên động từ cũng phải số nhiều. (2) "during breathe" phải là "during breathing" — sau giới từ, dạng danh động từ (-ing) là bắt buộc.',
 7);


-- ############################################################################
-- LESSON 2: HOW THE IMMUNE SYSTEM WORKS (slug: immune-system)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'How the Immune System Works', 'Hệ Miễn Dịch Hoạt Động Như Thế Nào',
  'immune-system',
  'Understand innate immunity, adaptive immunity, and how vaccines work',
  'Hiểu miễn dịch bẩm sinh, miễn dịch thích ứng và cách vaccine hoạt động',
  'intermediate', 35, 2
FROM category WHERE name = 'Medicine & Biology';


-- ============================================================================
-- LESSON USAGES: immune-system
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'immune-system'),
 'Innate Immunity', 'Miễn Dịch Bẩm Sinh',
 'Innate immunity is the body''s first and fastest line of defense — a non-specific response that attacks any foreign invader. It includes physical barriers (skin, mucus), fever, inflammation, and phagocytes that engulf pathogens within minutes to hours.',
 'Miễn dịch bẩm sinh là tuyến phòng thủ đầu tiên và nhanh nhất của cơ thể — phản ứng không đặc hiệu tấn công bất kỳ kẻ xâm nhập nào. Nó bao gồm các hàng rào vật lý (da, chất nhầy), sốt, viêm và tế bào thực bào tiêu diệt mầm bệnh trong vòng vài phút đến vài giờ.',
 'Shield', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'immune-system'),
 'Adaptive Immunity', 'Miễn Dịch Thích Ứng',
 'Adaptive immunity is the body''s targeted, long-term defense system. It takes days to activate but produces a highly specific response against particular pathogens. Crucially, it creates memory cells that allow a faster, stronger response upon re-exposure to the same pathogen.',
 'Miễn dịch thích ứng là hệ thống phòng thủ có mục tiêu và dài hạn của cơ thể. Mất vài ngày để kích hoạt nhưng tạo ra phản ứng đặc hiệu cao chống lại các mầm bệnh cụ thể. Quan trọng hơn, nó tạo ra tế bào nhớ cho phép phản ứng nhanh hơn, mạnh hơn khi tiếp xúc lại với cùng mầm bệnh.',
 'Biotech', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'immune-system'),
 'Vaccines', 'Vaccine',
 'Vaccines train the adaptive immune system by introducing a harmless form of a pathogen — a weakened virus, inactivated bacterium, or just a protein fragment. The immune system mounts a response and forms memory cells, so when the real pathogen appears, it is defeated rapidly.',
 'Vaccine huấn luyện hệ miễn dịch thích ứng bằng cách đưa vào một dạng vô hại của mầm bệnh — virus yếu, vi khuẩn bất hoạt, hoặc chỉ một đoạn protein. Hệ miễn dịch phản ứng và tạo tế bào nhớ, vì vậy khi mầm bệnh thực sự xuất hiện, nó bị đánh bại nhanh chóng.',
 'HealthAndSafety', TRUE, 3);


-- ============================================================================
-- LESSON SECTIONS: immune-system
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

-- Section 1: markdown overview
((SELECT id FROM lesson WHERE slug = 'immune-system'),
 'markdown', 'The Immune System: Two Layers of Defense', 'Hệ Miễn Dịch: Hai Lớp Phòng Thủ',
'## How Your Body Fights Infection

The immune system is your body''s defense against pathogens (bacteria, viruses, fungi, parasites). It operates in two coordinated layers.

### Layer 1: Innate Immunity (Fast but Non-Specific)

Activated within **minutes to hours**:

| Defense | Description |
|---------|-------------|
| **Skin & mucous membranes** | Physical barrier — stops most pathogens from entering |
| **Fever** | Elevated temperature slows pathogen replication |
| **Inflammation** | Increases blood flow to infection site; recruits immune cells |
| **Phagocytes** | Neutrophils and macrophages engulf and destroy pathogens |
| **Natural killer cells** | Detect and destroy infected or cancerous cells |

### Layer 2: Adaptive Immunity (Slow but Precise)

Activated within **days to weeks**:

- **B-cells** — produce antibodies that bind to specific antigens on pathogens
- **T-cells** — cytotoxic T-cells kill infected cells; helper T-cells coordinate the response
- **Memory cells** — persist after infection and enable faster responses to future encounters

### The Role of Vaccines

Vaccines exploit adaptive immunity''s memory system. By presenting a safe antigen, they train memory cells **without causing disease** — so the real pathogen is recognized and defeated before symptoms develop.',

'## Cơ Thể Bạn Chống Nhiễm Trùng Như Thế Nào

Hệ miễn dịch là hàng phòng thủ của cơ thể chống lại mầm bệnh (vi khuẩn, virus, nấm, ký sinh trùng). Nó hoạt động theo hai lớp phối hợp.

### Lớp 1: Miễn Dịch Bẩm Sinh (Nhanh nhưng Không Đặc Hiệu)

Kích hoạt trong **vài phút đến vài giờ**:

| Phòng thủ | Mô tả |
|-----------|-------|
| **Da & màng nhầy** | Hàng rào vật lý — ngăn hầu hết mầm bệnh xâm nhập |
| **Sốt** | Nhiệt độ tăng làm chậm sự nhân lên của mầm bệnh |
| **Viêm** | Tăng lưu lượng máu đến vị trí nhiễm trùng; chiêu tập tế bào miễn dịch |
| **Thực bào** | Bạch cầu trung tính và đại thực bào nuốt và tiêu diệt mầm bệnh |
| **Tế bào diệt tự nhiên** | Phát hiện và tiêu diệt tế bào bị nhiễm hoặc tế bào ung thư |

### Lớp 2: Miễn Dịch Thích Ứng (Chậm nhưng Chính Xác)

Kích hoạt trong **vài ngày đến vài tuần**:

- **Tế bào B** — sản xuất kháng thể gắn vào kháng nguyên cụ thể trên mầm bệnh
- **Tế bào T** — tế bào T gây độc tiêu diệt tế bào bị nhiễm; tế bào T hỗ trợ phối hợp phản ứng
- **Tế bào nhớ** — tồn tại sau khi nhiễm trùng và tạo ra phản ứng nhanh hơn khi gặp lại

### Vai Trò Của Vaccine

Vaccine khai thác hệ thống nhớ của miễn dịch thích ứng. Bằng cách trình bày kháng nguyên an toàn, chúng huấn luyện tế bào nhớ **mà không gây bệnh** — vì vậy mầm bệnh thực sự được nhận ra và tiêu diệt trước khi triệu chứng phát triển.',
 1, '{}'),

-- Section 2: key_points
((SELECT id FROM lesson WHERE slug = 'immune-system'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["Miễn dịch bẩm sinh là phản ứng không đặc hiệu, nhanh — kích hoạt trong vài phút, tấn công mọi kẻ xâm nhập ngoại lai", "Miễn dịch thích ứng mất vài ngày nhưng đặc hiệu cao — nhắm mục tiêu vào kháng nguyên cụ thể của từng mầm bệnh", "Tế bào B sản xuất kháng thể; tế bào T tiêu diệt tế bào bị nhiễm và phối hợp phản ứng miễn dịch", "Tế bào nhớ là lý do bạn ít khi mắc cùng một bệnh hai lần — chúng nhớ mầm bệnh và phản ứng nhanh hơn", "Vaccine tạo ra miễn dịch bằng cách giả lập nhiễm trùng một cách an toàn, kích hoạt tế bào nhớ mà không gây bệnh"]'::jsonb),

-- Section 3: diagram (Mermaid flowchart of immune response)
((SELECT id FROM lesson WHERE slug = 'immune-system'),
 'diagram', 'Immune Response Flowchart', 'Sơ Đồ Phản Ứng Miễn Dịch',
 'Step-by-step flow of how the immune system responds to a pathogen: from first contact through innate defenses to adaptive immunity and recovery.',
 'Luồng từng bước về cách hệ miễn dịch phản ứng với mầm bệnh: từ tiếp xúc đầu tiên qua phòng thủ bẩm sinh đến miễn dịch thích ứng và hồi phục.',
 3,
 '{"code":"graph TD\n  A[Pathogen Enters] --> B{First Line of Defense}\n  B --> C[Skin & Mucous Membranes]\n  B --> D[Innate Immune Response]\n  D --> E[Phagocytes Attack]\n  D --> F{Threat Cleared?}\n  F -->|No| G[Adaptive Immune Response]\n  G --> H[T-cells Activated]\n  G --> I[B-cells Produce Antibodies]\n  F -->|Yes| J[Recovery]"}'::jsonb);


-- ============================================================================
-- EXERCISES: immune-system (7 exercises)
-- ============================================================================

-- Exercise 1: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'immune-system'),
 'multiple_choice', 'medium',
 'Which cells are responsible for producing antibodies?',
 'Tế bào nào chịu trách nhiệm sản xuất kháng thể?',
 'B-cells (B lymphocytes) are the antibody factories of the immune system. When activated by helper T-cells and antigen contact, B-cells differentiate into plasma cells that secrete large quantities of specific antibodies into the bloodstream.',
 'Tế bào B (tế bào lympho B) là nhà máy kháng thể của hệ miễn dịch. Khi được kích hoạt bởi tế bào T hỗ trợ và tiếp xúc kháng nguyên, tế bào B biệt hóa thành tế bào plasma tiết ra lượng lớn kháng thể đặc hiệu vào máu.',
 1);

WITH mc_ex AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'immune-system')
  AND type = 'multiple_choice'
  AND order_index = 1
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'T-cells', 'Tế bào T', FALSE, 1 FROM mc_ex
UNION ALL SELECT id, 'B'::option_label, 'B-cells', 'Tế bào B', TRUE, 2 FROM mc_ex
UNION ALL SELECT id, 'C'::option_label, 'Neutrophils', 'Bạch cầu trung tính', FALSE, 3 FROM mc_ex
UNION ALL SELECT id, 'D'::option_label, 'Macrophages', 'Đại thực bào', FALSE, 4 FROM mc_ex;


-- Exercise 2: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'immune-system'),
 'fill_blank', 'medium',
 'The immune system has two main divisions: innate and ___ immunity.',
 'Hệ miễn dịch có hai bộ phận chính: miễn dịch bẩm sinh và miễn dịch ___.',
 'adaptive',
 'Innate immunity is the fast, non-specific first response. Adaptive (or acquired) immunity is slower but highly targeted — it learns to recognize specific pathogens and forms immunological memory to fight them more effectively on re-exposure.',
 'Miễn dịch bẩm sinh là phản ứng đầu tiên nhanh, không đặc hiệu. Miễn dịch thích ứng (hay thu được) chậm hơn nhưng có mục tiêu cao — nó học cách nhận ra các mầm bệnh cụ thể và hình thành trí nhớ miễn dịch để chống lại chúng hiệu quả hơn khi tiếp xúc lại.',
 2);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'immune-system'),
 'true_false', 'easy',
 'Vaccines work by introducing a weakened or inactive form of a pathogen.',
 'Vaccine hoạt động bằng cách đưa vào một dạng yếu hoặc bất hoạt của mầm bệnh.',
 'true',
 'True. Most traditional vaccines use weakened (attenuated) live pathogens, inactivated (killed) pathogens, or isolated proteins from pathogens. Newer mRNA vaccines (like COVID-19 vaccines) use genetic instructions to make the immune system produce a pathogen protein itself — but the principle is the same: train without causing disease.',
 'Đúng. Hầu hết vaccine truyền thống sử dụng mầm bệnh sống yếu (giảm độc lực), mầm bệnh bất hoạt (đã chết), hoặc protein phân lập từ mầm bệnh. Vaccine mRNA mới hơn (như vaccine COVID-19) dùng hướng dẫn di truyền để hệ miễn dịch tự sản xuất protein của mầm bệnh — nhưng nguyên tắc giống nhau: huấn luyện mà không gây bệnh.',
 3);

-- Exercise 4: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'immune-system'),
 'multiple_choice', 'medium',
 'Which white blood cells engulf and destroy pathogens?',
 'Loại bạch cầu nào nuốt và tiêu diệt mầm bệnh?',
 'Phagocytes (Greek: "cell eaters") include neutrophils and macrophages. They use a process called phagocytosis — extending their membrane around a pathogen, engulfing it into a vesicle, then destroying it with enzymes and reactive oxygen species.',
 'Tế bào thực bào (tiếng Hy Lạp: "tế bào ăn") gồm bạch cầu trung tính và đại thực bào. Chúng dùng quá trình gọi là thực bào — mở rộng màng tế bào quanh mầm bệnh, nuốt vào túi, sau đó phá hủy bằng enzyme và các loài oxy phản ứng.',
 4);

WITH mc_ex2 AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'immune-system')
  AND type = 'multiple_choice'
  AND order_index = 4
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'B-cells', 'Tế bào B', FALSE, 1 FROM mc_ex2
UNION ALL SELECT id, 'B'::option_label, 'T-cells', 'Tế bào T', FALSE, 2 FROM mc_ex2
UNION ALL SELECT id, 'C'::option_label, 'Phagocytes', 'Tế bào thực bào', TRUE, 3 FROM mc_ex2
UNION ALL SELECT id, 'D'::option_label, 'Platelets', 'Tiểu cầu', FALSE, 4 FROM mc_ex2;


-- Exercise 5: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'immune-system'),
 'fill_blank', 'medium',
 'Antibodies are proteins that specifically target ___ on pathogens.',
 'Kháng thể là các protein đặc hiệu nhắm vào ___ trên mầm bệnh.',
 'antigens',
 'Antigens are molecules (usually proteins or polysaccharides) on the surface of pathogens that the immune system recognizes as foreign. Each antibody is shaped to bind only to a specific antigen — like a lock and key. This specificity is what makes adaptive immunity so powerful.',
 'Kháng nguyên là các phân tử (thường là protein hoặc polysaccharide) trên bề mặt mầm bệnh mà hệ miễn dịch nhận ra là ngoại lai. Mỗi kháng thể được định hình để chỉ gắn vào một kháng nguyên cụ thể — như ổ khóa và chìa khóa. Tính đặc hiệu này là điều làm cho miễn dịch thích ứng mạnh mẽ như vậy.',
 5);

-- Exercise 6: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'immune-system'),
 'true_false', 'medium',
 'Once you recover from a disease, your adaptive immune system has no memory of it.',
 'Sau khi bạn hồi phục từ một bệnh, hệ miễn dịch thích ứng không có ký ức về nó.',
 'false',
 'False. After recovering from an infection, long-lived memory B-cells and memory T-cells persist in your body for years or even decades. These cells remember the pathogen''s antigens, so if you encounter the same pathogen again, the immune response is much faster and stronger — often clearing the infection before symptoms appear.',
 'Sai. Sau khi hồi phục từ nhiễm trùng, tế bào B nhớ và tế bào T nhớ tồn tại trong cơ thể bạn nhiều năm hoặc thậm chí nhiều thập kỷ. Những tế bào này nhớ kháng nguyên của mầm bệnh, vì vậy nếu bạn gặp lại cùng mầm bệnh, phản ứng miễn dịch nhanh hơn và mạnh hơn nhiều — thường loại bỏ nhiễm trùng trước khi triệu chứng xuất hiện.',
 6);

-- Exercise 7: sentence_transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'immune-system'),
 'sentence_transform', 'medium',
 'Transform "Vaccines prevent disease" to explain the mechanism.',
 'Chuyển đổi "Vaccines prevent disease" để giải thích cơ chế.',
 'Vaccines prevent disease by training the immune system to recognize and fight specific pathogens.',
 'The original sentence states only the outcome. A complete mechanistic explanation adds how: vaccines introduce a safe antigen → the adaptive immune system responds → memory cells form → future infections are neutralized before causing illness.',
 'Câu gốc chỉ nêu kết quả. Một giải thích cơ chế đầy đủ bổ sung cách thực hiện: vaccine đưa vào kháng nguyên an toàn → hệ miễn dịch thích ứng phản ứng → tế bào nhớ hình thành → nhiễm trùng tương lai bị vô hiệu hóa trước khi gây bệnh.',
 7);


-- ############################################################################
-- LESSON 3: GENETICS FUNDAMENTALS (slug: genetics-fundamentals)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Genetics Fundamentals', 'Cơ Bản Di Truyền Học',
  'genetics-fundamentals',
  'Understand DNA, genes, chromosomes, and how traits are inherited',
  'Hiểu DNA, gen, nhiễm sắc thể và cách tính trạng di truyền',
  'intermediate', 40, 3
FROM category WHERE name = 'Medicine & Biology';


-- ============================================================================
-- LESSON USAGES: genetics-fundamentals
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'genetics-fundamentals'),
 'DNA Structure', 'Cấu Trúc DNA',
 'DNA (deoxyribonucleic acid) is a double-helix molecule made of nucleotide base pairs. The four bases — adenine (A), thymine (T), cytosine (C), and guanine (G) — pair specifically: A with T, and C with G. This complementary pairing enables accurate DNA replication.',
 'DNA (axit deoxyribonucleic) là phân tử xoắn kép tạo thành từ các cặp bazơ nucleotide. Bốn bazơ — adenine (A), thymine (T), cytosine (C) và guanine (G) — ghép cặp cụ thể: A với T, và C với G. Sự ghép cặp bổ sung này cho phép sao chép DNA chính xác.',
 'Science', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'genetics-fundamentals'),
 'Genes and Traits', 'Gen và Tính Trạng',
 'A gene is a specific segment of DNA that contains the instructions to build a protein. Proteins carry out virtually every function in the body. The complete set of genes in an organism is called its genome. Humans have approximately 20,000–25,000 protein-coding genes.',
 'Gen là một đoạn DNA cụ thể chứa hướng dẫn để tạo ra protein. Protein thực hiện hầu hết mọi chức năng trong cơ thể. Tập hợp đầy đủ các gen trong một sinh vật gọi là hệ gen. Con người có khoảng 20.000–25.000 gen mã hóa protein.',
 'Biotech', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'genetics-fundamentals'),
 'Dominant and Recessive', 'Trội và Lặn',
 'Most traits are controlled by two alleles (gene variants) — one from each parent. A dominant allele is expressed whenever present (even with one copy). A recessive allele is only expressed when both copies are recessive. This explains why traits can skip generations.',
 'Hầu hết tính trạng được kiểm soát bởi hai alen (biến thể gen) — một từ mỗi cha mẹ. Alen trội được biểu hiện bất cứ khi nào có mặt (ngay cả với một bản sao). Alen lặn chỉ được biểu hiện khi cả hai bản sao đều là lặn. Điều này giải thích tại sao tính trạng có thể bỏ qua các thế hệ.',
 'AccountTree', TRUE, 3);


-- ============================================================================
-- LESSON SECTIONS: genetics-fundamentals
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

-- Section 1: markdown overview
((SELECT id FROM lesson WHERE slug = 'genetics-fundamentals'),
 'markdown', 'The Blueprint of Life', 'Bản Thiết Kế Của Sự Sống',
'## Genetics: From DNA to Traits

Genetics explains how biological information is stored, copied, and passed from parents to offspring.

### DNA: The Molecule of Heredity

DNA is a **double helix** — two strands wound around each other. Each strand is a sequence of four nucleotide bases:

| Base | Pairs With | Symbol |
|------|-----------|--------|
| Adenine | Thymine | A–T |
| Cytosine | Guanine | C–G |

> Every human cell contains about **3 billion base pairs**, encoding ~20,000 genes.

### From DNA to Protein: The Central Dogma

$$\text{DNA} \xrightarrow{\text{transcription}} \text{RNA} \xrightarrow{\text{translation}} \text{Protein}$$

1. **Transcription** — DNA is copied into messenger RNA (mRNA) in the nucleus
2. **Translation** — ribosomes read the mRNA and assemble a chain of amino acids into a protein

### Chromosomes, Genes, and Alleles

- **Chromosome** — a long, coiled DNA molecule; humans have 46 (23 pairs)
- **Gene** — a segment of DNA coding for a specific protein
- **Allele** — a variant form of a gene (e.g., brown eye allele vs. blue eye allele)
- **Genotype** — the genetic makeup (which alleles you carry)
- **Phenotype** — the observable trait (what you actually look like or how you function)',

'## Di Truyền Học: Từ DNA Đến Tính Trạng

Di truyền học giải thích cách thông tin sinh học được lưu trữ, sao chép và truyền từ cha mẹ sang con cái.

### DNA: Phân Tử Di Truyền

DNA là **xoắn kép** — hai sợi quấn quanh nhau. Mỗi sợi là một chuỗi bốn bazơ nucleotide:

| Bazơ | Ghép cặp với | Ký hiệu |
|------|-------------|---------|
| Adenine | Thymine | A–T |
| Cytosine | Guanine | C–G |

> Mỗi tế bào người chứa khoảng **3 tỷ cặp bazơ**, mã hóa ~20.000 gen.

### Từ DNA Đến Protein: Học Thuyết Trung Tâm

$$\text{DNA} \xrightarrow{\text{phiên mã}} \text{RNA} \xrightarrow{\text{dịch mã}} \text{Protein}$$

1. **Phiên mã** — DNA được sao chép thành RNA thông tin (mRNA) trong nhân tế bào
2. **Dịch mã** — ribosome đọc mRNA và lắp ráp chuỗi axit amin thành protein

### Nhiễm Sắc Thể, Gen và Alen

- **Nhiễm sắc thể** — phân tử DNA dài, cuộn lại; người có 46 chiếc (23 cặp)
- **Gen** — đoạn DNA mã hóa một protein cụ thể
- **Alen** — dạng biến thể của một gen (ví dụ: alen mắt nâu so với alen mắt xanh)
- **Kiểu gen** — cấu tạo di truyền (bạn mang những alen nào)
- **Kiểu hình** — tính trạng có thể quan sát (bạn thực sự trông như thế nào hoặc hoạt động như thế nào)',
 1, '{}'),

-- Section 2: key_points
((SELECT id FROM lesson WHERE slug = 'genetics-fundamentals'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["DNA là phân tử xoắn kép tạo thành từ 4 bazơ nucleotide: A ghép với T, C ghép với G — quy tắc này đảm bảo sao chép chính xác", "Gen là đoạn DNA mã hóa protein; con người có ~20.000–25.000 gen mã hóa protein trên 46 nhiễm sắc thể", "Kiểu gen là cấu tạo di truyền (các alen bạn mang); kiểu hình là tính trạng có thể quan sát được", "Alen trội được biểu hiện ngay cả khi chỉ có một bản sao; alen lặn cần hai bản sao mới được biểu hiện", "Đột biến là thay đổi trong trình tự DNA — hầu hết vô hại, một số có lợi, một số gây bệnh di truyền"]'::jsonb),

-- Section 3: info_box (DNA vs RNA)
((SELECT id FROM lesson WHERE slug = 'genetics-fundamentals'),
 'info_box', 'DNA vs RNA: Key Differences', 'DNA vs RNA: Sự Khác Biệt Chính',
 '**DNA and RNA are both nucleic acids but serve different roles:**

| Feature | DNA | RNA |
|---------|-----|-----|
| **Sugar** | Deoxyribose | Ribose |
| **Bases** | A, T, C, G | A, U, C, G (U = Uracil replaces T) |
| **Strands** | Double-stranded | Usually single-stranded |
| **Location** | Mainly in nucleus | Nucleus and cytoplasm |
| **Role** | Long-term storage of genetic info | Carries instructions from DNA to ribosomes |
| **Stability** | Very stable | Less stable (degrades faster) |

**Why it matters:** mRNA vaccines (like Pfizer-BioNTech COVID-19) deliver mRNA into cells. Cells read the mRNA and produce a viral protein, training the immune system — without ever using real DNA.',

 '**DNA và RNA đều là axit nucleic nhưng phục vụ các vai trò khác nhau:**

| Đặc điểm | DNA | RNA |
|----------|-----|-----|
| **Đường** | Deoxyribose | Ribose |
| **Bazơ** | A, T, C, G | A, U, C, G (U = Uracil thay thế T) |
| **Sợi** | Hai sợi | Thường một sợi |
| **Vị trí** | Chủ yếu trong nhân | Nhân và tế bào chất |
| **Vai trò** | Lưu trữ thông tin di truyền dài hạn | Mang hướng dẫn từ DNA đến ribosome |
| **Độ bền** | Rất bền | Kém bền hơn (phân hủy nhanh hơn) |

**Tại sao quan trọng:** Vaccine mRNA (như Pfizer-BioNTech COVID-19) đưa mRNA vào tế bào. Tế bào đọc mRNA và sản xuất protein virus, huấn luyện hệ miễn dịch — mà không bao giờ sử dụng DNA thực.',
 3, '{"type": "info"}'::jsonb);


-- ============================================================================
-- EXERCISES: genetics-fundamentals (7 exercises)
-- ============================================================================

-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'genetics-fundamentals'),
 'fill_blank', 'easy',
 'The molecule that carries genetic information is called ___.',
 'Phân tử mang thông tin di truyền được gọi là ___.',
 'DNA',
 'DNA (deoxyribonucleic acid) is the molecule that stores the genetic instructions for the development, functioning, growth, and reproduction of all known living organisms. It is organized into chromosomes inside the cell nucleus.',
 'DNA (axit deoxyribonucleic) là phân tử lưu trữ hướng dẫn di truyền cho sự phát triển, hoạt động, tăng trưởng và sinh sản của tất cả sinh vật sống đã biết. Nó được tổ chức thành các nhiễm sắc thể bên trong nhân tế bào.',
 1);

-- Exercise 2: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'genetics-fundamentals'),
 'multiple_choice', 'easy',
 'How many chromosomes does a typical human cell contain?',
 'Tế bào người điển hình chứa bao nhiêu nhiễm sắc thể?',
 'Humans have 46 chromosomes arranged in 23 pairs — one chromosome in each pair inherited from the mother, one from the father. Exceptions include gametes (sperm and egg cells) which have 23 chromosomes each, and cells with chromosomal abnormalities.',
 'Người có 46 nhiễm sắc thể được sắp xếp thành 23 cặp — một nhiễm sắc thể trong mỗi cặp thừa hưởng từ mẹ, một từ cha. Ngoại lệ bao gồm tế bào sinh dục (tinh trùng và tế bào trứng) có 23 nhiễm sắc thể mỗi loại, và tế bào có bất thường nhiễm sắc thể.',
 2);

WITH mc_ex AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'genetics-fundamentals')
  AND type = 'multiple_choice'
  AND order_index = 2
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, '23', '23', FALSE, 1 FROM mc_ex
UNION ALL SELECT id, 'B'::option_label, '46', '46', TRUE, 2 FROM mc_ex
UNION ALL SELECT id, 'C'::option_label, '48', '48', FALSE, 3 FROM mc_ex
UNION ALL SELECT id, 'D'::option_label, '92', '92', FALSE, 4 FROM mc_ex;


-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'genetics-fundamentals'),
 'true_false', 'easy',
 'Genes are segments of DNA that code for specific proteins.',
 'Gen là các đoạn DNA mã hóa cho các protein cụ thể.',
 'true',
 'True. A gene is a specific sequence of DNA nucleotides that contains the instructions to build a particular protein. Through transcription and translation, cells convert gene sequences into functional proteins that carry out nearly every biological process.',
 'Đúng. Gen là một chuỗi nucleotide DNA cụ thể chứa hướng dẫn để tạo ra một protein cụ thể. Qua quá trình phiên mã và dịch mã, tế bào chuyển đổi trình tự gen thành protein chức năng thực hiện hầu hết mọi quá trình sinh học.',
 3);

-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'genetics-fundamentals'),
 'fill_blank', 'medium',
 'A ___ allele is expressed even when only one copy is present.',
 'Alen ___ được biểu hiện ngay cả khi chỉ có một bản sao.',
 'dominant',
 'A dominant allele masks the effect of a recessive allele when both are present (heterozygous condition). For example, if B = brown eyes (dominant) and b = blue eyes (recessive), then both BB and Bb individuals have brown eyes. Only bb individuals have blue eyes.',
 'Alen trội che khuất tác dụng của alen lặn khi cả hai đều có mặt (trạng thái dị hợp). Ví dụ, nếu B = mắt nâu (trội) và b = mắt xanh (lặn), thì cả cá nhân BB và Bb đều có mắt nâu. Chỉ cá nhân bb mới có mắt xanh.',
 4);

-- Exercise 5: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'genetics-fundamentals'),
 'multiple_choice', 'medium',
 'What is a genotype?',
 'Kiểu gen là gì?',
 'Genotype refers to the specific alleles an organism carries for a given trait. It is the genetic blueprint, regardless of what is expressed. Phenotype, in contrast, is the observable physical or biochemical characteristic — determined by both genotype and environmental influences.',
 'Kiểu gen đề cập đến các alen cụ thể mà sinh vật mang cho một tính trạng nhất định. Đó là bản thiết kế di truyền, bất kể điều gì được biểu hiện. Kiểu hình, ngược lại, là đặc điểm vật lý hoặc hóa sinh có thể quan sát — được xác định bởi cả kiểu gen lẫn ảnh hưởng môi trường.',
 5);

WITH mc_ex2 AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'genetics-fundamentals')
  AND type = 'multiple_choice'
  AND order_index = 5
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'The physical appearance', 'Ngoại hình vật lý', FALSE, 1 FROM mc_ex2
UNION ALL SELECT id, 'B'::option_label, 'The genetic makeup', 'Cấu tạo di truyền', TRUE, 2 FROM mc_ex2
UNION ALL SELECT id, 'C'::option_label, 'The chromosome number', 'Số lượng nhiễm sắc thể', FALSE, 3 FROM mc_ex2
UNION ALL SELECT id, 'D'::option_label, 'A mutation', 'Một đột biến', FALSE, 4 FROM mc_ex2;


-- Exercise 6: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'genetics-fundamentals'),
 'true_false', 'medium',
 'Recessive traits are always harmful.',
 'Tính trạng lặn luôn gây hại.',
 'false',
 'False. Recessive traits are simply traits that require two copies of the recessive allele to be expressed — they are not inherently harmful. Many recessive traits are neutral (e.g., blue eyes, attached earlobes) or even beneficial. Some recessive alleles can be harmful only in the homozygous state (e.g., sickle cell anemia), but even these can be protective in the heterozygous state.',
 'Sai. Tính trạng lặn đơn giản là tính trạng cần hai bản sao của alen lặn mới được biểu hiện — chúng không vốn dĩ gây hại. Nhiều tính trạng lặn là trung tính (ví dụ: mắt xanh, dái tai dính) hoặc thậm chí có lợi. Một số alen lặn chỉ có thể gây hại ở trạng thái đồng hợp (ví dụ: bệnh thiếu máu hồng cầu hình liềm), nhưng ngay cả những alen này cũng có thể bảo vệ ở trạng thái dị hợp.',
 6);

-- Exercise 7: arrange_words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'genetics-fundamentals'),
 'arrange_words', 'medium',
 'Arrange these words to form a correct statement about DNA structure.',
 'Sắp xếp các từ này để tạo thành một phát biểu đúng về cấu trúc DNA.',
 'DNA is a double helix made of nucleotide base pairs',
 '["DNA", "is", "a", "double", "helix", "made", "of", "nucleotide", "base", "pairs"]',
 'DNA''s double helix structure was first described by Watson and Crick in 1953. The helix is formed by two complementary strands of nucleotides wound around each other. The bases (A, T, C, G) point inward and pair across the two strands, stabilizing the structure.',
 'Cấu trúc xoắn kép của DNA lần đầu được mô tả bởi Watson và Crick năm 1953. Xoắn kép được tạo thành bởi hai sợi nucleotide bổ sung quấn quanh nhau. Các bazơ (A, T, C, G) hướng vào trong và ghép cặp qua hai sợi, ổn định cấu trúc.',
 7);
