-- ============================================================
-- Arts & Humanities Seed — Correct schema
-- Categories: Geography Basics, Geopolitics, Political Science & Law,
--             Literature & Creative Writing, Fine Arts & Architecture,
--             Photography & Film
-- 12 lessons total (2 per category)
-- Schema: group_id, name/name_vi, lesson_usage(title/description),
--         exercise difficulty(easy/medium/hard), exercise_option(content/content_vi)
-- ============================================================

-- ============================================================
-- LESSON 1: Physical Geography Basics (Geography Basics)
-- ============================================================
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Physical Geography Basics', 'Địa Lý Tự Nhiên Căn Bản',
  'physical-geography-basics',
  'Explore Earth''s physical systems: plate tectonics, climate zones, landforms, and the water cycle.',
  'Khám phá các hệ thống tự nhiên của Trái Đất: kiến tạo mảng, vùng khí hậu, địa hình và chu trình nước.',
  'beginner', 45, 1
FROM category WHERE name = 'Geography Basics';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'physical-geography-basics'),
   'Describe Earth''s major systems', 'Mô tả các hệ thống chính của Trái Đất',
   'Identify and explain the four major Earth systems: lithosphere, hydrosphere, atmosphere, and biosphere.',
   'Xác định và giải thích bốn hệ thống chính: thạch quyển, thủy quyển, khí quyển và sinh quyển.', 1),
  ((SELECT id FROM lesson WHERE slug = 'physical-geography-basics'),
   'Explain plate tectonics', 'Giải thích kiến tạo mảng',
   'Describe how plate movement creates mountains, earthquakes, and volcanoes.',
   'Mô tả cách chuyển động mảng tạo ra núi, động đất và núi lửa.', 2),
  ((SELECT id FROM lesson WHERE slug = 'physical-geography-basics'),
   'Classify climate zones', 'Phân loại vùng khí hậu',
   'Apply the Köppen climate classification system to identify major climate zones.',
   'Áp dụng hệ thống phân loại khí hậu Köppen để xác định các vùng khí hậu chính.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'physical-geography-basics'),
   'markdown', 'Earth''s Physical Systems', 'Các Hệ Thống Tự Nhiên của Trái Đất',
   E'## Earth''s Four Major Systems\n\n| System | Definition | Examples |\n|---|---|---|\n| **Lithosphere** | Solid outer layer (crust + upper mantle) | Mountains, tectonic plates |\n| **Hydrosphere** | All water on Earth | Oceans, rivers, glaciers |\n| **Atmosphere** | Gas layer surrounding Earth | Troposphere, stratosphere |\n| **Biosphere** | All living organisms + their environment | Forests, coral reefs |\n\n## Plate Tectonics\n\nEarth''s lithosphere is divided into about 15 major **tectonic plates** that move 2–15 cm per year.\n\n**Types of plate boundaries:**\n- **Divergent**: plates move apart → mid-ocean ridges, rift valleys\n- **Convergent**: plates collide → mountains (Himalayas), subduction zones, ocean trenches\n- **Transform**: plates slide past each other → earthquakes (San Andreas Fault)\n\n**Ring of Fire**: A 40,000 km arc around the Pacific Ocean with ~75% of Earth''s volcanoes and 90% of its earthquakes.\n\n## Climate Zones (Köppen)\n\n| Zone | Climate | Characteristics |\n|---|---|---|\n| **Tropical (A)** | Near equator | Hot year-round, heavy rain |\n| **Arid (B)** | Deserts | Low precipitation, extreme temp |\n| **Temperate (C)** | Mid-latitudes | Mild winters, warm summers |\n| **Continental (D)** | Interior landmasses | Cold winters, warm summers |\n| **Polar (E)** | High latitudes | Perpetual cold |\n\n## The Water Cycle\n\nEvaporation → condensation → precipitation → runoff/infiltration → back to evaporation.',
   E'## Bốn Hệ Thống Chính của Trái Đất\n\n- **Thạch quyển**: Lớp ngoài rắn (vỏ + lớp trên của manto)\n- **Thủy quyển**: Tất cả nước trên Trái Đất (đại dương, sông, băng hà)\n- **Khí quyển**: Lớp khí bao quanh Trái Đất\n- **Sinh quyển**: Tất cả sinh vật sống và môi trường của chúng\n\n## Kiến Tạo Mảng\n\nThạch quyển của Trái Đất được chia thành khoảng 15 mảng kiến tạo chính di chuyển 2–15 cm mỗi năm.\n\n**Các loại ranh giới mảng:**\n- **Phân kỳ**: mảng tách ra → gờ đại dương, thung lũng rift\n- **Hội tụ**: mảng va chạm → núi (Himalayas), vùng hút chìm\n- **Trượt ngang**: mảng trượt qua nhau → động đất\n\n**Vành đai lửa**: Cung 40.000 km quanh Thái Bình Dương với ~75% núi lửa và 90% động đất của Trái Đất.\n\n## Vùng Khí Hậu (Köppen)\n\n- **Nhiệt đới (A)**: Nóng quanh năm, mưa nhiều\n- **Khô hạn (B)**: Ít mưa, nhiệt độ cực đoan\n- **Ôn đới (C)**: Mùa đông ôn hòa, mùa hè ấm áp\n- **Lục địa (D)**: Mùa đông lạnh, mùa hè ấm\n- **Cực (E)**: Lạnh vĩnh cửu',
   '{}', 1),
  ((SELECT id FROM lesson WHERE slug = 'physical-geography-basics'),
   'key_points', 'Core Concepts', 'Khái Niệm Cốt Lõi',
   E'- **Four Earth systems**: lithosphere (solid), hydrosphere (water), atmosphere (gas), biosphere (life) — interconnected, not isolated\n- **Plate tectonics**: ~15 major plates moving 2–15 cm/year; creates mountains, earthquakes, volcanoes at boundaries\n- **Ring of Fire**: Pacific arc with 75% of volcanoes and 90% of earthquakes; formed by convergent plate boundaries\n- **Köppen climate zones**: A (tropical), B (arid), C (temperate), D (continental), E (polar) — latitude + ocean proximity determine classification\n- **Water cycle**: evaporation → condensation → precipitation → runoff/infiltration — continuous, closed-loop system',
   E'- **Bốn hệ thống Trái Đất**: thạch quyển (rắn), thủy quyển (nước), khí quyển (khí), sinh quyển (sự sống) — kết nối với nhau\n- **Kiến tạo mảng**: ~15 mảng di chuyển 2–15 cm/năm; tạo núi, động đất, núi lửa tại ranh giới\n- **Vành đai lửa**: cung Thái Bình Dương với 75% núi lửa và 90% động đất\n- **Vùng khí hậu Köppen**: A (nhiệt đới), B (khô), C (ôn đới), D (lục địa), E (cực) — xác định bởi vĩ độ + khoảng cách đại dương\n- **Chu trình nước**: bay hơi → ngưng tụ → mưa → dòng chảy — hệ thống vòng lặp liên tục',
   '{}', 2),
  ((SELECT id FROM lesson WHERE slug = 'physical-geography-basics'),
   'info_box', 'The Himalayas Are Still Growing', 'Dãy Himalaya Vẫn Đang Tăng Trưởng',
   'The Himalayas formed when the Indian Plate collided with the Eurasian Plate about 50 million years ago. They are still rising at about 5 mm per year because the two plates continue to converge. Mount Everest has grown measurably since it was first surveyed in 1856.',
   'Dãy Himalaya hình thành khi mảng Ấn Độ va chạm với mảng Á-Âu khoảng 50 triệu năm trước. Chúng vẫn tăng trưởng khoảng 5mm mỗi năm vì hai mảng tiếp tục hội tụ.',
   '{"variant": "tip"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'physical-geography-basics'),
   'multiple_choice', 'easy',
   'Which of Earth''s four major systems includes all of the planet''s water — oceans, rivers, glaciers, and groundwater?',
   'Hệ thống nào trong bốn hệ thống chính của Trái Đất bao gồm tất cả nước của hành tinh — đại dương, sông, băng hà và nước ngầm?',
   'B',
   'The hydrosphere encompasses all water on Earth in all its forms: liquid (oceans, rivers, lakes), solid (glaciers, ice caps), and gas (water vapor). It covers about 71% of Earth''s surface.',
   'Thủy quyển bao gồm tất cả nước trên Trái Đất dưới mọi dạng: lỏng (đại dương, sông, hồ), rắn (băng hà) và khí (hơi nước). Nó bao phủ khoảng 71% bề mặt Trái Đất.', 1),
  ((SELECT id FROM lesson WHERE slug = 'physical-geography-basics'),
   'true_false', 'easy',
   'Plate tectonics theory explains that Earth''s lithosphere is divided into moving plates, and most major earthquakes and volcanoes occur at or near plate boundaries.',
   'Lý thuyết kiến tạo mảng giải thích rằng thạch quyển của Trái Đất được chia thành các mảng di chuyển, và hầu hết động đất và núi lửa lớn xảy ra tại hoặc gần ranh giới mảng.',
   'true',
   'The vast majority of seismic and volcanic activity occurs at plate boundaries — divergent (plates moving apart), convergent (plates colliding), or transform (plates sliding past each other). The Ring of Fire is the most vivid example.',
   'Phần lớn hoạt động địa chấn và núi lửa xảy ra tại ranh giới mảng — phân kỳ, hội tụ hoặc trượt ngang. Vành đai lửa là ví dụ điển hình nhất.', 2),
  ((SELECT id FROM lesson WHERE slug = 'physical-geography-basics'),
   'fill_blank', 'easy',
   'The continuous movement of water through evaporation, condensation, precipitation, and runoff is called the water _____.',
   'Chuyển động liên tục của nước qua bay hơi, ngưng tụ, mưa và dòng chảy được gọi là _____ nước.',
   'cycle',
   'The water cycle (hydrological cycle) is a continuous, closed system that moves water between the atmosphere, land surface, and subsurface. Solar energy drives evaporation; gravity drives precipitation and runoff.',
   'Chu trình nước là hệ thống liên tục, khép kín di chuyển nước giữa khí quyển, mặt đất và lòng đất. Năng lượng mặt trời thúc đẩy bay hơi; trọng lực thúc đẩy mưa và dòng chảy.', 3),
  ((SELECT id FROM lesson WHERE slug = 'physical-geography-basics'),
   'multiple_choice', 'medium',
   'Which Köppen climate zone is found near the equator and is characterized by high temperatures year-round and abundant rainfall?',
   'Vùng khí hậu Köppen nào nằm gần xích đạo và được đặc trưng bởi nhiệt độ cao quanh năm và lượng mưa dồi dào?',
   'A',
   'Tropical climates (Köppen A) lie within about 15–25 degrees of the equator. They receive direct solar radiation year-round, resulting in consistently high temperatures (above 18°C every month) and heavy rainfall that supports tropical rainforests.',
   'Khí hậu nhiệt đới (Köppen A) nằm trong khoảng 15–25 độ từ xích đạo. Chúng nhận bức xạ mặt trời trực tiếp quanh năm, dẫn đến nhiệt độ cao nhất quán và lượng mưa lớn hỗ trợ rừng mưa nhiệt đới.', 4),
  ((SELECT id FROM lesson WHERE slug = 'physical-geography-basics'),
   'error_correction', 'medium',
   'Correct this statement: "The Ring of Fire is a calm region in the Pacific Ocean known for its beautiful coral reefs and absence of seismic activity."',
   'Sửa câu này: "Vành đai lửa là vùng yên bình ở Thái Bình Dương nổi tiếng với các rạn san hô đẹp và không có hoạt động địa chấn."',
   'The Ring of Fire is a 40,000 km arc around the Pacific Ocean known for intense seismic and volcanic activity — it contains approximately 75% of Earth''s volcanoes and generates 90% of its earthquakes.',
   'The Ring of Fire is one of the most geologically active regions on Earth, formed by a series of convergent and transform plate boundaries. The description provided confuses it with a peaceful reef system — the opposite of what it is.',
   'Vành đai lửa là một trong những vùng địa chất hoạt động nhất trên Trái Đất, được hình thành bởi chuỗi ranh giới mảng hội tụ và trượt ngang. Mô tả trên nhầm lẫn nó với hệ thống rạn san hô yên bình.', 5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'physical-geography-basics') AND order_index = 1),
   'A', 'Lithosphere', 'Thạch quyển'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'physical-geography-basics') AND order_index = 1),
   'B', 'Hydrosphere', 'Thủy quyển'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'physical-geography-basics') AND order_index = 1),
   'C', 'Atmosphere', 'Khí quyển'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'physical-geography-basics') AND order_index = 1),
   'D', 'Biosphere', 'Sinh quyển'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'physical-geography-basics') AND order_index = 4),
   'A', 'Tropical (A) — high temperatures and abundant rainfall year-round', 'Nhiệt đới (A) — nhiệt độ cao và lượng mưa dồi dào quanh năm'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'physical-geography-basics') AND order_index = 4),
   'B', 'Arid (B) — extremely low precipitation and high temperature variation', 'Khô hạn (B) — lượng mưa cực thấp và biến động nhiệt độ cao'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'physical-geography-basics') AND order_index = 4),
   'C', 'Temperate (C) — mild winters and warm to hot summers', 'Ôn đới (C) — mùa đông ôn hòa và mùa hè ấm áp đến nóng'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'physical-geography-basics') AND order_index = 4),
   'D', 'Continental (D) — cold winters and warm summers in interior regions', 'Lục địa (D) — mùa đông lạnh và mùa hè ấm ở các vùng nội địa');

-- ============================================================
-- LESSON 2: Human Geography and Population (Geography Basics)
-- ============================================================
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Human Geography and Population', 'Địa Lý Nhân Văn và Dân Số',
  'human-geography-population',
  'Study population dynamics, the demographic transition model, urbanization, and migration patterns.',
  'Nghiên cứu động lực dân số, mô hình chuyển đổi nhân khẩu học, đô thị hóa và mô hình di cư.',
  'beginner', 40, 2
FROM category WHERE name = 'Geography Basics';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'human-geography-population'),
   'Apply the demographic transition model', 'Áp dụng mô hình chuyển đổi nhân khẩu học',
   'Identify which stage of the demographic transition model a country occupies based on birth and death rates.',
   'Xác định giai đoạn nào trong mô hình chuyển đổi nhân khẩu học mà một quốc gia đang ở dựa trên tỷ lệ sinh và tử.', 1),
  ((SELECT id FROM lesson WHERE slug = 'human-geography-population'),
   'Analyze migration factors', 'Phân tích các yếu tố di cư',
   'Distinguish push factors (why people leave) from pull factors (why people move to a destination).',
   'Phân biệt các yếu tố đẩy (lý do rời đi) với các yếu tố kéo (lý do di chuyển đến điểm đến).', 2),
  ((SELECT id FROM lesson WHERE slug = 'human-geography-population'),
   'Explain urbanization trends', 'Giải thích xu hướng đô thị hóa',
   'Describe why the global population is increasingly concentrated in cities and the challenges this creates.',
   'Mô tả tại sao dân số toàn cầu ngày càng tập trung vào các thành phố và những thách thức điều này tạo ra.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'human-geography-population'),
   'markdown', 'Population Dynamics and Human Patterns', 'Động Lực Dân Số và Mô Hình Nhân Văn',
   E'## Key Population Concepts\n\n- **Birth rate (BR)**: number of live births per 1,000 people per year\n- **Death rate (DR)**: number of deaths per 1,000 people per year\n- **Natural increase rate (NIR)**: BR − DR (population growth ignoring migration)\n- **Total Fertility Rate (TFR)**: average number of children per woman; 2.1 = replacement level\n\n## Demographic Transition Model (DTM)\n\nDescribes how populations change as countries develop:\n\n| Stage | Birth Rate | Death Rate | Population | Example |\n|---|---|---|---|---|\n| **1** | High | High | Stable (low) | Pre-industrial societies |\n| **2** | High | Falling | Rapid growth | Many developing nations |\n| **3** | Falling | Low | Slowing growth | Industrializing nations |\n| **4** | Low | Low | Stable (high) | Most developed nations |\n| **5** | Below replacement | Low | Declining | Japan, Germany |\n\n## Push and Pull Factors of Migration\n\n**Push factors** (drive people to leave):\n- Poverty, unemployment, conflict, natural disasters, discrimination\n\n**Pull factors** (attract people to a destination):\n- Economic opportunity, political stability, education, healthcare, family ties\n\n## Urbanization\n\nIn 2007, for the first time in history, more than half of the world''s population lived in urban areas. By 2050, ~68% is projected to live in cities.\n\n**Challenges**: housing shortages, congestion, informal settlements (slums), pollution, infrastructure strain.',
   E'## Các Khái Niệm Dân Số Chính\n\n- **Tỷ lệ sinh (BR)**: số ca sinh sống trên 1.000 người mỗi năm\n- **Tỷ lệ tử (DR)**: số ca tử vong trên 1.000 người mỗi năm\n- **Tỷ lệ gia tăng tự nhiên (NIR)**: BR − DR\n- **Tổng tỷ suất sinh (TFR)**: trung bình số con mỗi phụ nữ; 2,1 = mức thay thế\n\n## Mô Hình Chuyển Đổi Nhân Khẩu Học (DTM)\n\n- **Giai đoạn 1**: Sinh cao, Tử cao → Dân số ổn định thấp\n- **Giai đoạn 2**: Sinh cao, Tử giảm → Tăng trưởng nhanh\n- **Giai đoạn 3**: Sinh giảm, Tử thấp → Tăng trưởng chậm lại\n- **Giai đoạn 4**: Sinh thấp, Tử thấp → Ổn định cao\n- **Giai đoạn 5**: Dưới mức thay thế, Tử thấp → Sụt giảm\n\n## Yếu Tố Đẩy và Kéo trong Di Cư\n\n**Yếu tố đẩy**: nghèo đói, thất nghiệp, xung đột, thiên tai, phân biệt đối xử\n\n**Yếu tố kéo**: cơ hội kinh tế, ổn định chính trị, giáo dục, y tế, kết nối gia đình\n\n## Đô Thị Hóa\n\nNăm 2007, lần đầu tiên trong lịch sử, hơn một nửa dân số thế giới sống ở khu vực đô thị. Đến năm 2050, dự kiến ~68% sống ở các thành phố.',
   '{}', 1),
  ((SELECT id FROM lesson WHERE slug = 'human-geography-population'),
   'key_points', 'Core Concepts', 'Khái Niệm Cốt Lõi',
   E'- **DTM stages**: Stage 1 (high BR + high DR = stable), Stage 2 (high BR + falling DR = rapid growth), Stage 4 (low BR + low DR = stable high), Stage 5 (sub-replacement = declining)\n- **Replacement level**: TFR of 2.1 children per woman maintains population size over time\n- **Push vs Pull migration**: push = leave (war, poverty); pull = attract (jobs, safety) — both needed for migration decision\n- **Urbanization tipping point**: 2007 was first year majority of world population lived in cities; projected 68% by 2050\n- **Natural increase rate** = birth rate − death rate (ignores migration); positive = growing, negative = shrinking',
   E'- **Giai đoạn DTM**: Giai đoạn 1 (BR cao + DR cao = ổn định), Giai đoạn 2 (BR cao + DR giảm = tăng nhanh), Giai đoạn 4 (BR thấp + DR thấp = ổn định cao), Giai đoạn 5 (dưới mức thay thế = sụt giảm)\n- **Mức thay thế**: TFR 2,1 con mỗi phụ nữ duy trì quy mô dân số theo thời gian\n- **Di cư đẩy vs kéo**: đẩy = rời đi (chiến tranh, nghèo đói); kéo = thu hút (việc làm, an toàn)\n- **Điểm bùng phát đô thị hóa**: 2007 là năm đầu tiên đa số dân số thế giới sống ở các thành phố\n- **Tỷ lệ gia tăng tự nhiên** = tỷ lệ sinh − tỷ lệ tử; dương = tăng trưởng, âm = thu hẹp',
   '{}', 2),
  ((SELECT id FROM lesson WHERE slug = 'human-geography-population'),
   'info_box', 'Japan''s Demographic Challenge', 'Thách Thức Nhân Khẩu Học của Nhật Bản',
   'Japan has one of the world''s lowest total fertility rates (~1.2) and is in DTM Stage 5. Its population peaked around 128 million in 2010 and has been declining since. By 2050, Japan''s population could fall below 100 million, creating severe challenges for pension systems, healthcare, and economic productivity.',
   'Nhật Bản có một trong những tổng tỷ suất sinh thấp nhất thế giới (~1,2) và đang ở giai đoạn 5 DTM. Dân số đạt đỉnh khoảng 128 triệu vào năm 2010 và đã sụt giảm kể từ đó.',
   '{"variant": "tip"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'human-geography-population'),
   'multiple_choice', 'easy',
   'People fleeing a region due to civil war, drought, or extreme poverty are responding to which type of migration factor?',
   'Người dân rời khỏi một khu vực do nội chiến, hạn hán hoặc nghèo đói cùng cực đang phản ứng với loại yếu tố di cư nào?',
   'A',
   'Push factors are conditions that drive people to leave their home region — such as conflict, natural disasters, poverty, discrimination, or lack of jobs. Pull factors are what attract migrants to a destination (better jobs, safety, family).',
   'Yếu tố đẩy là các điều kiện thúc đẩy người ta rời khỏi quê hương — như xung đột, thiên tai, nghèo đói, phân biệt đối xử. Yếu tố kéo là những gì thu hút người di cư đến điểm đến.', 1),
  ((SELECT id FROM lesson WHERE slug = 'human-geography-population'),
   'true_false', 'easy',
   'Urbanization refers to the increasing proportion of a country''s population living in cities and towns rather than rural areas.',
   'Đô thị hóa đề cập đến tỷ lệ ngày càng tăng của dân số một quốc gia sống ở các thành phố và thị trấn thay vì khu vực nông thôn.',
   'true',
   'Urbanization is both a process and a measure. As a process, it involves rural-to-urban migration and natural population growth within cities. As a measure, it is the percentage of the total population living in urban areas.',
   'Đô thị hóa vừa là một quá trình vừa là một thước đo. Như một quá trình, nó liên quan đến di cư từ nông thôn ra thành thị và tăng trưởng dân số tự nhiên trong các thành phố.', 2),
  ((SELECT id FROM lesson WHERE slug = 'human-geography-population'),
   'fill_blank', 'easy',
   'In Stage 2 of the Demographic Transition Model, birth rates remain high while death rates fall, causing rapid _____ growth.',
   'Trong Giai đoạn 2 của Mô Hình Chuyển Đổi Nhân Khẩu Học, tỷ lệ sinh vẫn cao trong khi tỷ lệ tử giảm, gây ra tăng trưởng dân số nhanh chóng.',
   'population',
   'Stage 2 of the DTM occurs when improved sanitation, medicine, and food supply lower death rates while birth rates remain high (cultural inertia). The resulting gap between birth and death rates causes rapid population growth — this is what happened during the Industrial Revolution in Europe.',
   'Giai đoạn 2 xảy ra khi vệ sinh, y học và nguồn thực phẩm được cải thiện làm giảm tỷ lệ tử trong khi tỷ lệ sinh vẫn cao. Khoảng cách giữa tỷ lệ sinh và tử gây ra tăng trưởng dân số nhanh chóng.', 3),
  ((SELECT id FROM lesson WHERE slug = 'human-geography-population'),
   'multiple_choice', 'medium',
   'Which stage of the Demographic Transition Model is characterized by both HIGH birth rates AND HIGH death rates, resulting in a slow-growing or stable low population?',
   'Giai đoạn nào của Mô Hình Chuyển Đổi Nhân Khẩu Học được đặc trưng bởi cả tỷ lệ sinh CAO và tỷ lệ tử CAO, dẫn đến dân số tăng trưởng chậm hoặc ổn định thấp?',
   'A',
   'Stage 1 represents pre-industrial societies with high birth rates (children as economic assets, high infant mortality) and high death rates (disease, famine, poor sanitation). The two rates roughly balance, keeping population low and stable.',
   'Giai đoạn 1 đại diện cho các xã hội tiền công nghiệp với tỷ lệ sinh cao (trẻ em là tài sản kinh tế, tỷ lệ tử ở trẻ sơ sinh cao) và tỷ lệ tử cao (bệnh tật, nạn đói, vệ sinh kém). Hai tỷ lệ cân bằng nhau, giữ dân số thấp và ổn định.', 4),
  ((SELECT id FROM lesson WHERE slug = 'human-geography-population'),
   'error_correction', 'medium',
   'Correct this statement: "Overpopulation is always the primary cause of poverty in developing countries."',
   'Sửa câu này: "Quá tải dân số luôn luôn là nguyên nhân chính của nghèo đói ở các nước đang phát triển."',
   'Poverty in developing countries is caused by multiple interacting factors including colonial legacies, unequal trade systems, lack of infrastructure, governance failures, and limited access to education — population size is one factor among many.',
   'The statement oversimplifies a complex relationship. High population growth can strain resources, but many densely populated countries (e.g., Netherlands, South Korea) are wealthy, while sparsely populated ones may be poor. Structural factors like governance, trade, and investment matter enormously.',
   'Câu này đơn giản hóa quá mức mối quan hệ phức tạp. Tăng trưởng dân số cao có thể gây áp lực lên tài nguyên, nhưng nhiều quốc gia đông dân (như Hà Lan, Hàn Quốc) giàu có, trong khi những quốc gia thưa dân có thể nghèo.', 5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'human-geography-population') AND order_index = 1),
   'A', 'Push factors — conditions that drive people to leave their home region', 'Yếu tố đẩy — các điều kiện thúc đẩy người ta rời khỏi quê hương'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'human-geography-population') AND order_index = 1),
   'B', 'Pull factors — attractions that draw migrants toward a destination', 'Yếu tố kéo — các sức hút thu hút người di cư đến điểm đến'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'human-geography-population') AND order_index = 1),
   'C', 'Natural increase factors — biological changes in birth and death rates', 'Yếu tố gia tăng tự nhiên — thay đổi sinh học trong tỷ lệ sinh và tử'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'human-geography-population') AND order_index = 1),
   'D', 'Urbanization factors — economic forces driving rural-to-urban movement', 'Yếu tố đô thị hóa — lực lượng kinh tế thúc đẩy di chuyển từ nông thôn ra thành thị'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'human-geography-population') AND order_index = 4),
   'A', 'Stage 1 — both birth and death rates are high, keeping population low', 'Giai đoạn 1 — cả tỷ lệ sinh và tử đều cao, giữ dân số thấp'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'human-geography-population') AND order_index = 4),
   'B', 'Stage 2 — high birth rates with falling death rates causing rapid growth', 'Giai đoạn 2 — tỷ lệ sinh cao với tỷ lệ tử giảm gây tăng trưởng nhanh'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'human-geography-population') AND order_index = 4),
   'C', 'Stage 4 — both birth and death rates are low, population is stable at a high level', 'Giai đoạn 4 — cả tỷ lệ sinh và tử đều thấp, dân số ổn định ở mức cao'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'human-geography-population') AND order_index = 4),
   'D', 'Stage 5 — birth rates fall below replacement level causing population decline', 'Giai đoạn 5 — tỷ lệ sinh giảm xuống dưới mức thay thế gây sụt giảm dân số');

-- ============================================================
-- LESSON 3: Introduction to Geopolitics (Geopolitics)
-- ============================================================
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Introduction to Geopolitics', 'Nhập Môn Địa Chính Trị',
  'intro-geopolitics',
  'Understand how geography, power, and international relations intersect to shape global politics.',
  'Hiểu cách địa lý, quyền lực và quan hệ quốc tế giao nhau để định hình chính trị toàn cầu.',
  'beginner', 45, 1
FROM category WHERE name = 'Geopolitics';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'intro-geopolitics'),
   'Explain classical geopolitical theories', 'Giải thích các lý thuyết địa chính trị cổ điển',
   'Compare Mackinder''s Heartland theory and Mahan''s sea power theory as competing visions of global dominance.',
   'So sánh lý thuyết Heartland của Mackinder và lý thuyết sức mạnh biển của Mahan như các tầm nhìn cạnh tranh về sự thống trị toàn cầu.', 1),
  ((SELECT id FROM lesson WHERE slug = 'intro-geopolitics'),
   'Distinguish soft power from hard power', 'Phân biệt quyền lực mềm và quyền lực cứng',
   'Apply Joseph Nye''s soft power concept to analyze how states project influence beyond military force.',
   'Áp dụng khái niệm quyền lực mềm của Joseph Nye để phân tích cách các quốc gia chiếu ảnh hưởng ngoài sức mạnh quân sự.', 2),
  ((SELECT id FROM lesson WHERE slug = 'intro-geopolitics'),
   'Analyze polarity in international order', 'Phân tích cực trong trật tự quốc tế',
   'Distinguish unipolar, bipolar, and multipolar world orders and their implications for stability.',
   'Phân biệt trật tự thế giới đơn cực, lưỡng cực và đa cực và các hàm ý của chúng đối với sự ổn định.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'intro-geopolitics'),
   'markdown', 'Geography, Power, and International Politics', 'Địa Lý, Quyền Lực và Chính Trị Quốc Tế',
   E'## What Is Geopolitics?\n\nGeopolitics studies how **geography influences political power** and international relations. It examines how location, resources, climate, and terrain shape state behavior and global competition.\n\n## Classical Geopolitical Theories\n\n**Halford Mackinder''s Heartland Theory (1904)**\n> "Who rules the Heartland commands the World-Island; who rules the World-Island commands the world."\n\nMackinder argued that the Central Eurasian landmass (Russia, Central Asia) was the geographic pivot of history — control it, and you control global politics.\n\n**Alfred Thayer Mahan''s Sea Power Theory (1890)**\n\nMahan argued that naval superiority determined national greatness. Control of sea lanes enables global trade and power projection — a theory that shaped US, British, and Japanese naval strategy.\n\n## Hard Power vs. Soft Power\n\n**Hard power** (Coercion + Incentives):\n- Military force, economic sanctions, financial incentives\n\n**Soft power** (Joseph Nye, 1990): The ability to attract and co-opt rather than coerce — through **culture, values, and foreign policy legitimacy**.\n\nExamples: Hollywood, K-pop, the BBC, development aid, Olympic hosting.\n\n## World Order Polarity\n\n| Polarity | Definition | Era |\n|---|---|---|\n| **Unipolar** | One dominant superpower | 1991–2008 (US dominance) |\n| **Bipolar** | Two rival superpowers | 1945–1991 (Cold War) |\n| **Multipolar** | Multiple major powers | Pre-WWI, potentially today |',
   E'## Địa Chính Trị Là Gì?\n\nĐịa chính trị nghiên cứu cách **địa lý ảnh hưởng đến quyền lực chính trị** và quan hệ quốc tế. Nó xem xét cách vị trí, tài nguyên, khí hậu và địa hình định hình hành vi quốc gia.\n\n## Các Lý Thuyết Địa Chính Trị Cổ Điển\n\n**Lý thuyết Heartland của Mackinder (1904)**\n> "Ai cai trị Heartland cai trị đảo thế giới; ai cai trị đảo thế giới cai trị thế giới."\n\nMackinder lập luận rằng lục địa trung tâm Á-Âu (Nga, Trung Á) là điểm tựa địa lý của lịch sử.\n\n**Lý thuyết sức mạnh biển của Mahan (1890)**\n\nMahan lập luận rằng ưu thế hải quân quyết định sự vĩ đại quốc gia.\n\n## Quyền Lực Cứng vs. Quyền Lực Mềm\n\n**Quyền lực cứng**: lực lượng quân sự, trừng phạt kinh tế, ưu đãi tài chính\n\n**Quyền lực mềm** (Joseph Nye, 1990): Khả năng thu hút và đồng hóa thay vì cưỡng ép — qua **văn hóa, giá trị và tính hợp pháp của chính sách đối ngoại**.\n\nVí dụ: Hollywood, K-pop, BBC, viện trợ phát triển.\n\n## Cực trong Trật Tự Thế Giới\n\n- **Đơn cực**: Một siêu cường thống trị (Mỹ 1991–2008)\n- **Lưỡng cực**: Hai siêu cường cạnh tranh (Chiến tranh Lạnh 1945–1991)\n- **Đa cực**: Nhiều cường quốc lớn (trước Thế chiến I, có thể ngày nay)',
   '{}', 1),
  ((SELECT id FROM lesson WHERE slug = 'intro-geopolitics'),
   'key_points', 'Core Concepts', 'Khái Niệm Cốt Lõi',
   E'- **Geopolitics**: how geography (location, resources, terrain) shapes political power and international relations\n- **Mackinder''s Heartland**: control of Central Eurasia = control of world politics; influenced Cold War strategy\n- **Mahan''s sea power**: naval control of trade routes = national greatness; shaped US/UK/Japanese naval strategy\n- **Hard power**: military force + economic coercion; **soft power** (Nye): attraction through culture, values, diplomacy\n- **Polarity**: unipolar (one hegemon), bipolar (two superpowers), multipolar (multiple great powers) — affects stability and conflict likelihood',
   E'- **Địa chính trị**: cách địa lý (vị trí, tài nguyên, địa hình) định hình quyền lực chính trị và quan hệ quốc tế\n- **Heartland của Mackinder**: kiểm soát Trung Á-Âu = kiểm soát chính trị thế giới\n- **Sức mạnh biển của Mahan**: kiểm soát hải quân các tuyến thương mại = sự vĩ đại quốc gia\n- **Quyền lực cứng**: lực lượng quân sự + cưỡng ép kinh tế; **quyền lực mềm** (Nye): thu hút qua văn hóa, giá trị, ngoại giao\n- **Cực**: đơn cực (một bá quyền), lưỡng cực (hai siêu cường), đa cực (nhiều cường quốc) — ảnh hưởng đến ổn định và khả năng xung đột',
   '{}', 2),
  ((SELECT id FROM lesson WHERE slug = 'intro-geopolitics'),
   'info_box', 'Brzezinski''s Chessboard', 'Bàn Cờ của Brzezinski',
   'Zbigniew Brzezinski''s 1997 book "The Grand Chessboard" updated Mackinder''s theory for the post-Cold War era, arguing that the US must prevent any Eurasian power (Russia, China, or a coalition) from achieving dominance over Eurasia. This framework has significantly influenced US foreign policy toward Eastern Europe and Central Asia.',
   'Cuốn sách "Bàn Cờ Vĩ Đại" (1997) của Brzezinski cập nhật lý thuyết Mackinder cho kỷ nguyên hậu Chiến tranh Lạnh, lập luận rằng Mỹ phải ngăn bất kỳ cường quốc Á-Âu nào (Nga, Trung Quốc hoặc liên minh) đạt được sự thống trị.',
   '{"variant": "tip"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'intro-geopolitics'),
   'multiple_choice', 'easy',
   '"Soft power" in international relations refers to:',
   '"Quyền lực mềm" trong quan hệ quốc tế đề cập đến:',
   'B',
   'Joseph Nye coined "soft power" (1990) to describe influence through attraction rather than coercion. A country with strong soft power can shape others'' preferences through the appeal of its culture, political values, and foreign policy — without threats or payments.',
   'Joseph Nye đặt ra thuật ngữ "quyền lực mềm" (1990) để mô tả ảnh hưởng qua sức hút thay vì cưỡng ép. Một quốc gia có quyền lực mềm mạnh có thể định hình sở thích của người khác qua sức hấp dẫn của văn hóa, giá trị chính trị và chính sách đối ngoại.', 1),
  ((SELECT id FROM lesson WHERE slug = 'intro-geopolitics'),
   'true_false', 'easy',
   'Halford Mackinder''s Heartland Theory argued that whoever controlled the Central Eurasian landmass held the key to world domination.',
   'Lý thuyết Heartland của Halford Mackinder lập luận rằng ai kiểm soát lục địa trung tâm Á-Âu nắm giữ chìa khóa thống trị thế giới.',
   'true',
   'Mackinder''s 1904 paper "The Geographical Pivot of History" proposed that the central Eurasian heartland — protected from sea power — was the strategic key to global control. Though dated, it influenced Cold War strategy and remains referenced in discussions of Russian and Chinese geopolitics.',
   'Bài báo 1904 của Mackinder đề xuất rằng vùng trung tâm Á-Âu — được bảo vệ khỏi sức mạnh biển — là chìa khóa chiến lược để kiểm soát toàn cầu. Dù cũ, nó đã ảnh hưởng đến chiến lược Chiến tranh Lạnh.', 2),
  ((SELECT id FROM lesson WHERE slug = 'intro-geopolitics'),
   'fill_blank', 'easy',
   'The ability to attract and co-opt rather than coerce or pay is known as _____ power, a term coined by Joseph Nye.',
   'Khả năng thu hút và đồng hóa thay vì cưỡng ép hoặc trả tiền được gọi là quyền lực _____, một thuật ngữ do Joseph Nye đặt ra.',
   'soft',
   'Soft power contrasts with hard power (military/economic coercion). Nye argued that a country''s soft power comes from three sources: its culture (when it is attractive to others), its political values (when it lives up to them), and its foreign policies (when they are seen as legitimate).',
   'Quyền lực mềm tương phản với quyền lực cứng (cưỡng ép quân sự/kinh tế). Nye lập luận rằng quyền lực mềm của một quốc gia đến từ ba nguồn: văn hóa, giá trị chính trị và chính sách đối ngoại.', 3),
  ((SELECT id FROM lesson WHERE slug = 'intro-geopolitics'),
   'multiple_choice', 'medium',
   'A multipolar world order, compared to a bipolar one, is generally characterized by:',
   'Trật tự thế giới đa cực, so với lưỡng cực, thường được đặc trưng bởi:',
   'B',
   'Multipolar systems have multiple great powers (3+) competing for influence. This creates more complex diplomacy, more potential alliance combinations, and according to some realist theorists, greater potential instability — though others argue it reduces the risk of superpower confrontation.',
   'Hệ thống đa cực có nhiều cường quốc lớn (3+) cạnh tranh ảnh hưởng. Điều này tạo ra ngoại giao phức tạp hơn, nhiều tổ hợp liên minh tiềm năng hơn, và theo một số lý thuyết hiện thực, khả năng bất ổn lớn hơn.', 4),
  ((SELECT id FROM lesson WHERE slug = 'intro-geopolitics'),
   'error_correction', 'medium',
   'Correct this statement: "Geopolitics is the study of how economic factors alone determine the outcomes of international relations and diplomatic negotiations."',
   'Sửa câu này: "Địa chính trị là nghiên cứu về cách các yếu tố kinh tế một mình quyết định kết quả của quan hệ quốc tế và đàm phán ngoại giao."',
   'Geopolitics studies how geographic factors — including location, terrain, natural resources, climate, and proximity — interact with political power to shape international relations. Economic factors are relevant but not the exclusive focus.',
   'The definition incorrectly limits geopolitics to economics alone. Geopolitics examines how GEOGRAPHY (not economics) shapes power — the physical environment of states and how location, terrain, resources, and boundaries influence political decisions.',
   'Định nghĩa này hạn chế địa chính trị vào kinh tế một mình. Địa chính trị xem xét cách ĐỊA LÝ (không phải kinh tế) định hình quyền lực — môi trường vật lý của các quốc gia và cách vị trí, địa hình, tài nguyên ảnh hưởng đến quyết định chính trị.', 5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-geopolitics') AND order_index = 1),
   'A', 'Military force and economic sanctions used to compel other states', 'Lực lượng quân sự và trừng phạt kinh tế được sử dụng để ép buộc các quốc gia khác'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-geopolitics') AND order_index = 1),
   'B', 'Influence through cultural attraction, political values, and diplomatic legitimacy', 'Ảnh hưởng qua sức hút văn hóa, giá trị chính trị và tính hợp pháp ngoại giao'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-geopolitics') AND order_index = 1),
   'C', 'Economic incentives and financial aid used to purchase political loyalty', 'Ưu đãi kinh tế và viện trợ tài chính được sử dụng để mua lòng trung thành chính trị'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-geopolitics') AND order_index = 1),
   'D', 'Nuclear deterrence and the threat of mutually assured destruction', 'Răn đe hạt nhân và mối đe dọa hủy diệt lẫn nhau được đảm bảo'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-geopolitics') AND order_index = 4),
   'A', 'Simpler diplomacy with fewer actors and more predictable alliance structures', 'Ngoại giao đơn giản hơn với ít tác nhân hơn và cấu trúc liên minh dễ đoán hơn'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-geopolitics') AND order_index = 4),
   'B', 'More complex diplomacy with multiple competing powers and shifting alliances', 'Ngoại giao phức tạp hơn với nhiều cường quốc cạnh tranh và các liên minh thay đổi'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-geopolitics') AND order_index = 4),
   'C', 'Guaranteed stability because no single power can dominate the others', 'Ổn định được đảm bảo vì không có cường quốc nào có thể thống trị những cường quốc khác'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-geopolitics') AND order_index = 4),
   'D', 'A permanent global institution that enforces international norms equally', 'Một tổ chức toàn cầu vĩnh viễn thực thi các chuẩn mực quốc tế một cách bình đẳng');


-- ============================================================
-- LESSON 4: Global Power Competition (Geopolitics)
-- ============================================================
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Global Power Competition', 'Cạnh Tranh Quyền Lực Toàn Cầu',
  'global-power-competition',
  'Explore how great powers compete through alliances, proxy conflicts, and economic influence in a multipolar world.',
  'Khám phá cách các cường quốc cạnh tranh qua liên minh, xung đột ủy nhiệm và ảnh hưởng kinh tế trong thế giới đa cực.',
  'intermediate', 45, 2
FROM category WHERE name = 'Geopolitics';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'global-power-competition'),
   'Explain balance of power theory', 'Giải thích lý thuyết cân bằng quyền lực',
   'Apply balance of power theory to explain why states form alliances against dominant powers.',
   'Áp dụng lý thuyết cân bằng quyền lực để giải thích tại sao các quốc gia hình thành liên minh chống lại các cường quốc thống trị.', 1),
  ((SELECT id FROM lesson WHERE slug = 'global-power-competition'),
   'Analyze proxy conflicts', 'Phân tích xung đột ủy nhiệm',
   'Identify how great powers use proxy wars to extend influence without direct confrontation.',
   'Xác định cách các cường quốc sử dụng chiến tranh ủy nhiệm để mở rộng ảnh hưởng mà không cần đối đầu trực tiếp.', 2),
  ((SELECT id FROM lesson WHERE slug = 'global-power-competition'),
   'Evaluate China''s rise', 'Đánh giá sự trỗi dậy của Trung Quốc',
   'Analyze the Belt and Road Initiative and South China Sea disputes as instruments of Chinese power projection.',
   'Phân tích Sáng kiến Vành đai và Con đường và tranh chấp Biển Đông như các công cụ chiếu ảnh hưởng của Trung Quốc.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'global-power-competition'),
   'markdown', 'Great Power Rivalry in the 21st Century', 'Cạnh Tranh Cường Quốc trong Thế Kỷ 21',
   E'## Balance of Power Theory\n\nRealist theory predicts that states will form alliances to **balance** against dominant powers — preventing any single state from achieving hegemony (unchallenged dominance).\n\n- **Internal balancing**: building up military capacity domestically\n- **External balancing**: forming alliances with other states\n\n**Hegemonic stability theory** (counterpoint): argues that a dominant hegemon provides global stability by enforcing rules and maintaining order — without a hegemon, international order breaks down.\n\n## Key Alliances\n\n| Alliance | Members | Purpose |\n|---|---|---|\n| **NATO** | 32 democracies | Collective defense; Article 5: attack on one = attack on all |\n| **SCO** | China, Russia, Central Asia | Security cooperation; counter-NATO narrative |\n| **AUKUS** | Australia, UK, US | Indo-Pacific security, nuclear submarine tech |\n\n## Proxy Wars\n\nGreat powers support opposing sides in **third-party conflicts** to advance their interests without direct military confrontation.\n\nExamples:\n- **Cold War**: Korea, Vietnam, Angola, Afghanistan\n- **Contemporary**: Syria (US vs Russia), Yemen (Saudi/UAE vs Iran-backed Houthis)\n\n## China''s Power Projection\n\n**Belt and Road Initiative (BRI)**: $1T+ infrastructure investment across 140+ countries — ports, railways, pipelines. Critics call it "debt-trap diplomacy."\n\n**South China Sea**: China claims ~90% via "nine-dash line"; disputed by Vietnam, Philippines, Malaysia, Brunei, Taiwan; vital trade route (~$5T/year).',
   E'## Lý Thuyết Cân Bằng Quyền Lực\n\nLý thuyết hiện thực dự đoán rằng các quốc gia sẽ hình thành liên minh để **cân bằng** chống lại các cường quốc thống trị.\n\n- **Cân bằng nội bộ**: xây dựng năng lực quân sự trong nước\n- **Cân bằng bên ngoài**: hình thành liên minh với các quốc gia khác\n\n**Lý thuyết ổn định bá quyền**: lập luận rằng bá quyền thống trị cung cấp sự ổn định toàn cầu bằng cách thực thi quy tắc.\n\n## Các Liên Minh Chính\n\n- **NATO**: 32 nền dân chủ, phòng thủ tập thể; Điều 5\n- **SCO**: Trung Quốc, Nga, Trung Á; hợp tác an ninh\n- **AUKUS**: Úc, Anh, Mỹ; an ninh Ấn Độ-Thái Bình Dương\n\n## Chiến Tranh Ủy Nhiệm\n\nCác cường quốc hỗ trợ các bên đối lập trong **xung đột bên thứ ba** để thúc đẩy lợi ích mà không cần đối đầu quân sự trực tiếp.\n\nVí dụ: Chiến tranh Lạnh (Triều Tiên, Việt Nam, Angola, Afghanistan); Đương đại (Syria, Yemen)\n\n## Chiếu Ảnh Hưởng của Trung Quốc\n\n**Sáng kiến Vành đai và Con đường (BRI)**: Đầu tư cơ sở hạ tầng trị giá $1T+ trên 140+ quốc gia.\n\n**Biển Đông**: Trung Quốc tuyên bố ~90% qua "đường chín đoạn"; tranh chấp bởi Việt Nam, Philippines, Malaysia, Brunei, Đài Loan.',
   '{}', 1),
  ((SELECT id FROM lesson WHERE slug = 'global-power-competition'),
   'key_points', 'Core Concepts', 'Khái Niệm Cốt Lõi',
   E'- **Balance of power**: states form alliances to prevent any single state from achieving unchallenged dominance; internal (military buildup) vs external (alliances)\n- **Hegemonic stability theory**: a dominant hegemon actually provides global stability by enforcing rules — its decline creates disorder\n- **Proxy wars**: great powers support opposing sides in third-party conflicts (Cold War: Korea, Vietnam; Contemporary: Syria, Yemen)\n- **NATO Article 5**: collective defense — an armed attack against one member is considered an attack against all\n- **Belt and Road Initiative**: China''s $1T+ infrastructure investment across 140+ countries — economic influence and strategic port access',
   E'- **Cân bằng quyền lực**: các quốc gia hình thành liên minh để ngăn bất kỳ quốc gia nào đạt được sự thống trị không bị thách thức\n- **Lý thuyết ổn định bá quyền**: bá quyền thống trị thực sự cung cấp sự ổn định toàn cầu bằng cách thực thi quy tắc\n- **Chiến tranh ủy nhiệm**: các cường quốc hỗ trợ các bên đối lập trong xung đột bên thứ ba\n- **Điều 5 NATO**: phòng thủ tập thể — tấn công vũ trang vào một thành viên được coi là tấn công vào tất cả\n- **Vành đai và Con đường**: đầu tư cơ sở hạ tầng $1T+ của Trung Quốc trên 140+ quốc gia',
   '{}', 2),
  ((SELECT id FROM lesson WHERE slug = 'global-power-competition'),
   'info_box', 'The Thucydides Trap', 'Bẫy Thucydides',
   'Harvard scholar Graham Allison coined "Thucydides Trap" to describe the dangerous dynamic when a rising power threatens to displace an established hegemon. Allison found that in 12 of 16 historical cases of such transitions, war resulted. The US-China relationship is widely studied through this lens.',
   'Học giả Harvard Graham Allison đặt ra thuật ngữ "Bẫy Thucydides" để mô tả động lực nguy hiểm khi một cường quốc đang trỗi dậy đe dọa thay thế bá quyền đã được thiết lập. Allison phát hiện rằng trong 12 trong số 16 trường hợp lịch sử như vậy, chiến tranh đã xảy ra.',
   '{"variant": "warning"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'global-power-competition'),
   'multiple_choice', 'easy',
   'NATO''s Article 5 — the collective defense clause — means that:',
   'Điều 5 của NATO — điều khoản phòng thủ tập thể — có nghĩa là:',
   'B',
   'Article 5 of the NATO treaty (1949) states that an armed attack against one member is considered an attack against all. It has been invoked only once — after the September 11, 2001 attacks on the United States. This collective defense guarantee is the alliance''s core deterrent.',
   'Điều 5 của hiệp ước NATO (1949) quy định rằng một cuộc tấn công vũ trang vào một thành viên được coi là tấn công vào tất cả. Nó chỉ được viện dẫn một lần — sau các cuộc tấn công ngày 11 tháng 9 năm 2001.', 1),
  ((SELECT id FROM lesson WHERE slug = 'global-power-competition'),
   'true_false', 'easy',
   'Hegemonic stability theory argues that the presence of a dominant global power (hegemon) promotes international stability by enforcing rules and maintaining order.',
   'Lý thuyết ổn định bá quyền lập luận rằng sự hiện diện của một cường quốc toàn cầu thống trị (bá quyền) thúc đẩy sự ổn định quốc tế bằng cách thực thi quy tắc và duy trì trật tự.',
   'true',
   'Hegemonic stability theory (Kindleberger, Gilpin) argues that open international systems require a dominant power willing and able to provide public goods like free trade, stable currency, and security. The US has been the dominant hegemon since 1945.',
   'Lý thuyết ổn định bá quyền (Kindleberger, Gilpin) lập luận rằng các hệ thống quốc tế mở cần một cường quốc thống trị sẵn sàng và có khả năng cung cấp hàng hóa công như tự do thương mại và ổn định tiền tệ.', 2),
  ((SELECT id FROM lesson WHERE slug = 'global-power-competition'),
   'fill_blank', 'easy',
   'Wars in which great powers support opposing sides through third parties, without direct military confrontation between the great powers themselves, are called _____ wars.',
   'Các cuộc chiến trong đó các cường quốc hỗ trợ các bên đối lập qua các bên thứ ba, mà không có đối đầu quân sự trực tiếp giữa các cường quốc, được gọi là chiến tranh _____.',
   'proxy',
   'Proxy wars allow great powers to advance their interests and test their military equipment and tactics while avoiding the catastrophic risks of direct conflict. The Cold War produced dozens of proxy conflicts across Asia, Africa, and Latin America.',
   'Chiến tranh ủy nhiệm cho phép các cường quốc thúc đẩy lợi ích và kiểm tra thiết bị quân sự trong khi tránh những rủi ro thảm khốc của xung đột trực tiếp. Chiến tranh Lạnh tạo ra hàng chục xung đột ủy nhiệm trên khắp Á, Phi và Mỹ Latinh.', 3),
  ((SELECT id FROM lesson WHERE slug = 'global-power-competition'),
   'multiple_choice', 'medium',
   'China''s Belt and Road Initiative (BRI) is best understood as:',
   'Sáng kiến Vành đai và Con đường (BRI) của Trung Quốc được hiểu tốt nhất là:',
   'B',
   'The BRI involves over $1 trillion in infrastructure investment (ports, railways, pipelines, energy) across 140+ countries. It serves China''s economic interests (new markets, excess capacity deployment) while also creating strategic leverage through port access and political influence.',
   'BRI liên quan đến hơn $1 nghìn tỷ đầu tư cơ sở hạ tầng (cảng, đường sắt, đường ống, năng lượng) trên 140+ quốc gia. Nó phục vụ lợi ích kinh tế của Trung Quốc trong khi tạo đòn bẩy chiến lược qua quyền tiếp cận cảng và ảnh hưởng chính trị.', 4),
  ((SELECT id FROM lesson WHERE slug = 'global-power-competition'),
   'error_correction', 'medium',
   'Correct this statement: "Balance of power theory predicts that weaker states will always ally with the most powerful state to share in its dominance."',
   'Sửa câu này: "Lý thuyết cân bằng quyền lực dự đoán rằng các quốc gia yếu hơn sẽ luôn liên minh với quốc gia mạnh nhất để chia sẻ sự thống trị của nó."',
   'Balance of power theory predicts the opposite: states tend to form alliances AGAINST the most powerful state to prevent it from achieving dominance, not with it.',
   'The described behavior is "bandwagoning" (joining the stronger side), not balancing. Classical balance of power theory predicts states will "balance" — aligning against the rising dominant power to preserve their autonomy.',
   'Hành vi được mô tả là "đi theo xe thắng" (joining the stronger side), không phải cân bằng. Lý thuyết cân bằng quyền lực cổ điển dự đoán các quốc gia sẽ "cân bằng" — liên kết chống lại cường quốc thống trị đang trỗi dậy để bảo tồn tự chủ.', 5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'global-power-competition') AND order_index = 1),
   'A', 'Each member must contribute 2% of GDP to NATO''s common defense budget', 'Mỗi thành viên phải đóng góp 2% GDP vào ngân sách quốc phòng chung của NATO'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'global-power-competition') AND order_index = 1),
   'B', 'An armed attack against one member is considered an attack against all members', 'Một cuộc tấn công vũ trang vào một thành viên được coi là tấn công vào tất cả các thành viên'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'global-power-competition') AND order_index = 1),
   'C', 'NATO members must automatically declare war when any member is attacked', 'Các thành viên NATO phải tự động tuyên chiến khi bất kỳ thành viên nào bị tấn công'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'global-power-competition') AND order_index = 1),
   'D', 'All NATO members must deploy troops in response to any security threat', 'Tất cả các thành viên NATO phải triển khai quân đội để đối phó với bất kỳ mối đe dọa an ninh nào'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'global-power-competition') AND order_index = 4),
   'A', 'A humanitarian aid program focused on food security and disaster relief', 'Chương trình viện trợ nhân đạo tập trung vào an ninh lương thực và cứu trợ thiên tai'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'global-power-competition') AND order_index = 4),
   'B', 'A massive infrastructure investment initiative creating economic ties and strategic leverage across Asia, Africa, and Europe', 'Sáng kiến đầu tư cơ sở hạ tầng khổng lồ tạo ra các mối quan hệ kinh tế và đòn bẩy chiến lược trên khắp Á, Phi và Âu'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'global-power-competition') AND order_index = 4),
   'C', 'A military alliance similar to NATO designed to counter US dominance in Asia', 'Một liên minh quân sự tương tự NATO được thiết kế để chống lại sự thống trị của Mỹ ở Châu Á'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'global-power-competition') AND order_index = 4),
   'D', 'A diplomatic initiative to establish new United Nations sustainable development goals', 'Một sáng kiến ngoại giao để thiết lập các mục tiêu phát triển bền vững mới của Liên Hợp Quốc');

-- ============================================================
-- LESSON 5: Political Science Foundations (Political Science & Law)
-- ============================================================
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Political Science Foundations', 'Nền Tảng Khoa Học Chính Trị',
  'political-science-foundations',
  'Master core concepts in political science: democracy, separation of powers, political ideologies, and state systems.',
  'Nắm vững các khái niệm cốt lõi trong khoa học chính trị: dân chủ, phân quyền, hệ tư tưởng chính trị và hệ thống nhà nước.',
  'beginner', 50, 1
FROM category WHERE name = 'Political Science & Law';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'political-science-foundations'),
   'Compare government systems', 'So sánh các hệ thống chính phủ',
   'Distinguish democracy, authoritarianism, and totalitarianism by their relationship to political power and civil liberties.',
   'Phân biệt dân chủ, chủ nghĩa độc đoán và chủ nghĩa toàn trị qua mối quan hệ của chúng với quyền lực chính trị và tự do dân sự.', 1),
  ((SELECT id FROM lesson WHERE slug = 'political-science-foundations'),
   'Apply separation of powers', 'Áp dụng phân quyền',
   'Explain how checks and balances prevent any single branch of government from accumulating excessive power.',
   'Giải thích cách kiểm tra và cân bằng ngăn bất kỳ nhánh chính phủ nào tích lũy quyền lực quá mức.', 2),
  ((SELECT id FROM lesson WHERE slug = 'political-science-foundations'),
   'Analyze political ideologies', 'Phân tích hệ tư tưởng chính trị',
   'Position liberalism, conservatism, socialism, and libertarianism on the political spectrum.',
   'Định vị chủ nghĩa tự do, chủ nghĩa bảo thủ, chủ nghĩa xã hội và chủ nghĩa tự do cá nhân trên phổ chính trị.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'political-science-foundations'),
   'markdown', 'Core Concepts in Political Science', 'Các Khái Niệm Cốt Lõi trong Khoa Học Chính Trị',
   E'## Types of Political Systems\n\n| System | Definition | Civil Liberties |\n|---|---|---|\n| **Democracy** | Government by the people (direct or representative) | Protected; free elections |\n| **Authoritarianism** | Concentrated power; limits on political activity | Restricted; no free elections |\n| **Totalitarianism** | State control over all aspects of public AND private life | Eliminated (propaganda, surveillance) |\n\n**Liberal democracy** adds constitutional protections for civil rights and minority protections to majority rule.\n\n## Presidential vs. Parliamentary Systems\n\n| Feature | Presidential | Parliamentary |\n|---|---|---|\n| **Executive** | Directly elected; separate from legislature | Prime Minister drawn from legislature |\n| **Accountability** | Fixed term; difficult to remove | Government falls if it loses majority |\n| **Example** | United States, Brazil | UK, Germany, India |\n\n## Separation of Powers (Montesquieu)\n\nMontesquieu''s *Spirit of the Laws* (1748) argued that liberty requires separating government into:\n- **Legislative**: makes laws (Congress, Parliament)\n- **Executive**: implements laws (President, Prime Minister)\n- **Judicial**: interprets laws (Supreme Court)\n\n**Checks and balances** — each branch limits the others.\n\n## Political Ideologies\n\n| Ideology | Core Value | Role of State |\n|---|---|---|\n| **Liberalism** | Individual freedom | Protect rights; limited state |\n| **Conservatism** | Tradition, stability | Preserve institutions |\n| **Socialism** | Equality | Redistribute wealth; state control |\n| **Libertarianism** | Maximum individual freedom | Minimal state intervention |\n\n## Federalism vs. Unitary Systems\n\n**Federalism**: Power divided between central and regional governments (US, Germany, India)\n\n**Unitary**: Power concentrated in central government, regional units subordinate (France, UK, Japan)',
   E'## Các Loại Hệ Thống Chính Trị\n\n- **Dân chủ**: Chính phủ bởi nhân dân (trực tiếp hoặc đại diện); tự do dân sự được bảo vệ\n- **Độc đoán**: Quyền lực tập trung; hạn chế hoạt động chính trị; không có bầu cử tự do\n- **Toàn trị**: Kiểm soát nhà nước đối với tất cả mọi mặt của cuộc sống công và tư\n\n**Dân chủ tự do** thêm bảo vệ hiến pháp cho quyền dân sự và thiểu số.\n\n## Hệ Thống Tổng Thống vs. Nghị Viện\n\n- **Tổng thống**: Hành pháp được bầu trực tiếp; nhiệm kỳ cố định (Mỹ, Brazil)\n- **Nghị viện**: Thủ tướng được rút ra từ cơ quan lập pháp; chính phủ sụp đổ nếu mất đa số (Anh, Đức, Ấn Độ)\n\n## Phân Quyền (Montesquieu)\n\n- **Lập pháp**: ban hành luật (Quốc hội)\n- **Hành pháp**: thực thi luật (Tổng thống, Thủ tướng)\n- **Tư pháp**: giải thích luật (Tòa án Tối cao)\n\n**Kiểm tra và cân bằng** — mỗi nhánh hạn chế các nhánh còn lại.\n\n## Hệ Tư Tưởng Chính Trị\n\n- **Chủ nghĩa tự do**: Tự do cá nhân, nhà nước hạn chế\n- **Chủ nghĩa bảo thủ**: Truyền thống, ổn định, bảo tồn thể chế\n- **Chủ nghĩa xã hội**: Bình đẳng, phân phối lại của cải\n- **Chủ nghĩa tự do cá nhân**: Tự do cá nhân tối đa, can thiệp nhà nước tối thiểu',
   '{}', 1),
  ((SELECT id FROM lesson WHERE slug = 'political-science-foundations'),
   'key_points', 'Core Concepts', 'Khái Niệm Cốt Lõi',
   E'- **Democracy vs authoritarianism**: democracy = free elections + civil liberties; authoritarianism = concentrated power + restricted politics; totalitarianism = total control of public AND private life\n- **Separation of powers** (Montesquieu): legislative, executive, judicial — each limited by others via checks and balances to prevent tyranny\n- **Presidential vs parliamentary**: presidential = fixed-term executive (US); parliamentary = PM drawn from legislature, government falls if loses majority (UK)\n- **Federalism**: power divided between central and regional governments (US, Germany); unitary = central government dominant (France, Japan)\n- **Political spectrum**: Left (socialism, redistribution) ↔ Center (liberalism) ↔ Right (conservatism, tradition); libertarianism = minimal state across both',
   E'- **Dân chủ vs độc đoán**: dân chủ = bầu cử tự do + tự do dân sự; độc đoán = quyền lực tập trung + chính trị bị hạn chế; toàn trị = kiểm soát toàn bộ cuộc sống công và tư\n- **Phân quyền** (Montesquieu): lập pháp, hành pháp, tư pháp — mỗi nhánh bị hạn chế bởi các nhánh khác\n- **Tổng thống vs nghị viện**: tổng thống = hành pháp nhiệm kỳ cố định; nghị viện = thủ tướng từ cơ quan lập pháp, chính phủ sụp đổ nếu mất đa số\n- **Liên bang**: quyền lực chia giữa trung ương và địa phương (Mỹ, Đức); đơn nhất = trung ương chiếm ưu thế (Pháp, Nhật)\n- **Phổ chính trị**: Trái (chủ nghĩa xã hội) ↔ Trung (tự do) ↔ Phải (bảo thủ)',
   '{}', 2),
  ((SELECT id FROM lesson WHERE slug = 'political-science-foundations'),
   'info_box', 'Totalitarianism vs. Authoritarianism', 'Toàn Trị vs. Độc Đoán',
   'Political scientist Juan Linz distinguished these: authoritarian regimes seek to demobilize citizens (keep them passive), while totalitarian regimes actively mobilize citizens around a single ideology (Nazism, Stalinism, Maoism). Totalitarian states attempt to transform society — authoritarian ones merely control it.',
   'Nhà khoa học chính trị Juan Linz phân biệt: chế độ độc đoán tìm cách phi huy động công dân (giữ họ thụ động), trong khi chế độ toàn trị tích cực huy động công dân xung quanh một hệ tư tưởng duy nhất (Chủ nghĩa Quốc xã, Stalin, Mao).',
   '{"variant": "tip"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'political-science-foundations'),
   'multiple_choice', 'easy',
   'A political system where power is divided between a central government and regional governments (states, provinces) is called:',
   'Hệ thống chính trị nơi quyền lực được chia giữa chính phủ trung ương và các chính phủ khu vực (tiểu bang, tỉnh) được gọi là:',
   'B',
   'Federalism divides sovereignty between central and subnational governments, each with constitutional authority in their respective domains. In the US, for example, states have powers not granted to the federal government. Unitary systems concentrate power in the central government.',
   'Liên bang chia chủ quyền giữa chính phủ trung ương và địa phương, mỗi bên có thẩm quyền hiến pháp trong lĩnh vực của mình. Ở Mỹ, các bang có quyền không được trao cho chính phủ liên bang. Hệ thống đơn nhất tập trung quyền lực ở trung ương.', 1),
  ((SELECT id FROM lesson WHERE slug = 'political-science-foundations'),
   'true_false', 'easy',
   'In parliamentary systems, the executive (Prime Minister) is drawn from the legislature and remains in power only as long as they maintain majority support in parliament.',
   'Trong hệ thống nghị viện, hành pháp (Thủ tướng) được rút ra từ cơ quan lập pháp và chỉ giữ quyền lực miễn là họ duy trì sự ủng hộ đa số trong nghị viện.',
   'true',
   'In parliamentary systems (UK, Canada, Germany, India), the head of government is the leader of the majority party or coalition in the legislature. If the government loses a vote of no confidence, it must resign — creating direct accountability to the legislature.',
   'Trong hệ thống nghị viện, người đứng đầu chính phủ là lãnh đạo đảng đa số hoặc liên minh trong cơ quan lập pháp. Nếu chính phủ thua phiếu bất tín nhiệm, họ phải từ chức.', 2),
  ((SELECT id FROM lesson WHERE slug = 'political-science-foundations'),
   'fill_blank', 'easy',
   'Montesquieu''s doctrine that legislative, executive, and judicial powers should be held by separate institutions to prevent tyranny is called the _____ of powers.',
   'Học thuyết của Montesquieu rằng các quyền lập pháp, hành pháp và tư pháp nên được nắm giữ bởi các tổ chức riêng biệt để ngăn chặn chuyên quyền được gọi là phân _____ quyền lực.',
   'separation',
   'Montesquieu''s Spirit of the Laws (1748) argued that combining legislative and executive power in the same hands creates tyranny. His theory of separation of powers deeply influenced the US Constitution, with its three branches and system of checks and balances.',
   'Tinh thần của Pháp Luật của Montesquieu (1748) lập luận rằng kết hợp quyền lập pháp và hành pháp trong cùng tay tạo ra chuyên quyền. Lý thuyết của ông ảnh hưởng sâu sắc đến Hiến pháp Mỹ.', 3),
  ((SELECT id FROM lesson WHERE slug = 'political-science-foundations'),
   'multiple_choice', 'medium',
   'According to Montesquieu, the greatest danger to liberty arises when:',
   'Theo Montesquieu, mối nguy hiểm lớn nhất đối với tự do phát sinh khi:',
   'B',
   'Montesquieu argued that concentrated power is the enemy of liberty. When the same person or body holds legislative power (making laws) and executive power (enforcing them), they can make tyrannical laws and enforce them tyrannically. Adding judicial power creates complete despotism.',
   'Montesquieu lập luận rằng quyền lực tập trung là kẻ thù của tự do. Khi cùng một người hoặc cơ quan nắm cả quyền lập pháp và hành pháp, họ có thể đưa ra và thực thi các luật chuyên quyền.', 4),
  ((SELECT id FROM lesson WHERE slug = 'political-science-foundations'),
   'error_correction', 'medium',
   'Correct this statement: "Totalitarianism and authoritarianism are the same thing — both describe any system where a government limits political opposition."',
   'Sửa câu này: "Toàn trị và độc đoán là cùng một thứ — cả hai mô tả bất kỳ hệ thống nào nơi chính phủ hạn chế đối lập chính trị."',
   'Totalitarianism and authoritarianism differ significantly. Authoritarian regimes limit political opposition but may tolerate non-political private life. Totalitarian regimes seek to control all aspects of public AND private life through ideology, propaganda, and mass mobilization.',
   'The distinction is crucial: authoritarianism seeks to demobilize society (keep people out of politics); totalitarianism actively mobilizes society around a single ideology (Nazism, Stalinism, Maoism), attempting to transform human consciousness itself.',
   'Sự phân biệt này rất quan trọng: độc đoán tìm cách phi huy động xã hội (giữ người dân ngoài chính trị); toàn trị tích cực huy động xã hội xung quanh một hệ tư tưởng duy nhất, cố gắng biến đổi chính ý thức con người.', 5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'political-science-foundations') AND order_index = 1),
   'A', 'Unitary system — power concentrated in the central government', 'Hệ thống đơn nhất — quyền lực tập trung ở chính phủ trung ương'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'political-science-foundations') AND order_index = 1),
   'B', 'Federal system — power divided between central and subnational governments', 'Hệ thống liên bang — quyền lực chia giữa chính phủ trung ương và địa phương'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'political-science-foundations') AND order_index = 1),
   'C', 'Confederate system — member states retain sovereignty over a weak center', 'Hệ thống liên hợp — các tiểu bang thành viên giữ chủ quyền trên một trung tâm yếu'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'political-science-foundations') AND order_index = 1),
   'D', 'Parliamentary system — executive drawn from and accountable to the legislature', 'Hệ thống nghị viện — hành pháp được rút ra từ và chịu trách nhiệm trước cơ quan lập pháp'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'political-science-foundations') AND order_index = 4),
   'A', 'Citizens elect representatives who make laws without any judicial oversight', 'Công dân bầu đại diện người ban hành luật mà không có sự giám sát tư pháp nào'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'political-science-foundations') AND order_index = 4),
   'B', 'Legislative, executive, and judicial powers are held by the same person or institution', 'Quyền lập pháp, hành pháp và tư pháp được nắm giữ bởi cùng một người hoặc tổ chức'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'political-science-foundations') AND order_index = 4),
   'C', 'The judiciary is elected by popular vote rather than appointed by the executive', 'Tư pháp được bầu bởi phổ thông đầu phiếu thay vì được bổ nhiệm bởi hành pháp'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'political-science-foundations') AND order_index = 4),
   'D', 'Political parties are banned and elections are conducted without opposition candidates', 'Các đảng chính trị bị cấm và bầu cử được tiến hành mà không có ứng cử viên đối lập');


-- ============================================================
-- LESSON 6: Introduction to Law Basics
-- Category: Political Science & Law (order 2)
-- ============================================================

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Introduction to Law Basics',
  'Giới Thiệu Cơ Bản Về Luật Pháp',
  'intro-law-basics',
  'Explore legal systems, rule of law, criminal vs civil law, and international law foundations.',
  'Khám phá các hệ thống pháp luật, nhà nước pháp quyền, luật hình sự vs dân sự, và nền tảng luật quốc tế.',
  'beginner', 45, 2
FROM category WHERE name = 'Political Science & Law';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'intro-law-basics'),
   'Compare common law and civil law systems',
   'So sánh hệ thống thông luật và dân luật',
   'Understand how the two dominant legal traditions differ in their sources of law and judicial decision-making.',
   'Hiểu cách hai truyền thống pháp lý chủ đạo khác nhau về nguồn luật và việc ra phán quyết tư pháp.', 1),
  ((SELECT id FROM lesson WHERE slug = 'intro-law-basics'),
   'Explain the rule of law and due process',
   'Giải thích nhà nước pháp quyền và quy trình tố tụng hợp lệ',
   'Learn why rule of law is the cornerstone of just governance and what due process protections guarantee.',
   'Tìm hiểu tại sao nhà nước pháp quyền là nền tảng của quản trị công bằng và những bảo đảm quy trình tố tụng hợp lệ.', 2),
  ((SELECT id FROM lesson WHERE slug = 'intro-law-basics'),
   'Distinguish criminal from civil law and identify sources of international law',
   'Phân biệt luật hình sự với dân sự và nhận biết các nguồn luật quốc tế',
   'Master the fundamental division between criminal and civil proceedings and understand how international law is created and enforced.',
   'Nắm vững sự phân chia cơ bản giữa tố tụng hình sự và dân sự, đồng thời hiểu cách luật quốc tế được tạo ra và thực thi.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'intro-law-basics'),
   'markdown',
   'Legal Systems: Common Law vs Civil Law',
   'Hệ Thống Pháp Luật: Thông Luật vs Dân Luật',
   E'## Two Legal Traditions\n\nTwo major legal systems dominate the world:\n\n| Feature | Common Law | Civil Law |\n|---|---|---|\n| **Origin** | England (medieval) | Roman law → Napoleon Code |\n| **Primary source** | Court decisions (precedent) | Written statutes/codes |\n| **Precedent** | Binding (stare decisis) | Persuasive only |\n| **Countries** | UK, USA, Australia, India | France, Germany, Japan, most of Latin America |\n| **Judicial role** | Active — judges make law | Passive — judges apply code |\n| **Jury trials** | Common in criminal cases | Rare |\n\n### Key Legal Concepts\n\n**Rule of Law**: No one is above the law — not even the government. Laws must be:\n- Publicly known and accessible\n- Applied equally to all persons\n- Enforced by independent courts\n- Prospective (not retroactive punishment)\n\n**Due Process**: Before the government deprives a person of life, liberty, or property, procedural protections apply:\n- **Procedural due process**: Fair procedures (notice, hearing, neutral decision-maker)\n- **Substantive due process**: Some rights are fundamental and cannot be violated regardless of procedure\n\n**Criminal vs Civil Law**:\n| Dimension | Criminal | Civil |\n|---|---|---|\n| Who sues? | State / Government | Private party |\n| Burden of proof | Beyond reasonable doubt | Preponderance of evidence (>50%) |\n| Outcome | Prison, fines, death penalty | Damages, injunctions |\n| Examples | Murder, theft, DUI | Contract disputes, negligence, divorce |\n\n**International Law Sources** (Article 38 ICJ Statute):\n1. **Treaties** — Binding agreements between states (UN Charter, WTO, Paris Agreement)\n2. **Customary international law** — State practice + opinio juris (sense of legal obligation)\n3. **General principles** — Widely recognized principles across legal systems\n4. **Judicial decisions + scholarship** — ICJ rulings, leading legal scholars (subsidiary sources)',
   E'## Hai Truyền Thống Pháp Lý\n\nHai hệ thống pháp luật lớn thống trị thế giới:\n\n| Đặc điểm | Thông Luật | Dân Luật |\n|---|---|---|\n| **Nguồn gốc** | Anh (thời trung cổ) | Luật La Mã → Bộ luật Napoleon |\n| **Nguồn chính** | Phán quyết tòa án (tiền lệ) | Đạo luật/bộ luật thành văn |\n| **Tiền lệ** | Ràng buộc (stare decisis) | Chỉ có tính thuyết phục |\n| **Các nước** | Anh, Mỹ, Úc, Ấn Độ | Pháp, Đức, Nhật Bản, phần lớn châu Mỹ Latinh |\n| **Vai trò thẩm phán** | Chủ động — thẩm phán tạo ra luật | Thụ động — thẩm phán áp dụng bộ luật |\n| **Bồi thẩm đoàn** | Phổ biến trong vụ án hình sự | Hiếm |\n\n### Các Khái Niệm Pháp Lý Chính\n\n**Nhà Nước Pháp Quyền**: Không ai đứng trên pháp luật — kể cả chính phủ. Luật phải:\n- Được công bố công khai và có thể tiếp cận\n- Áp dụng bình đẳng cho tất cả mọi người\n- Được thực thi bởi các tòa án độc lập\n- Có tính tiền định (không trừng phạt hồi tố)\n\n**Quy Trình Tố Tụng Hợp Lệ**: Trước khi chính phủ tước đoạt sự sống, tự do hoặc tài sản của một người, các bảo vệ thủ tục được áp dụng:\n- **Quy trình thủ tục**: Thủ tục công bằng (thông báo, điều trần, người ra quyết định trung lập)\n- **Quy trình nội dung**: Một số quyền là cơ bản và không thể vi phạm bất kể thủ tục\n\n**Luật Hình Sự vs Dân Sự**:\n| Chiều | Hình Sự | Dân Sự |\n|---|---|---|\n| Ai kiện? | Nhà nước / Chính phủ | Bên tư nhân |\n| Gánh nặng chứng minh | Vượt nghi ngờ hợp lý | Trọng lượng bằng chứng (>50%) |\n| Kết quả | Tù giam, phạt tiền, án tử hình | Bồi thường thiệt hại, lệnh cấm |\n| Ví dụ | Giết người, trộm cắp, DUI | Tranh chấp hợp đồng, sơ suất, ly hôn |\n\n**Nguồn Luật Quốc Tế** (Điều 38 Quy chế ICJ):\n1. **Điều ước** — Thỏa thuận ràng buộc giữa các quốc gia (Hiến chương LHQ, WTO, Thỏa thuận Paris)\n2. **Luật tập quán quốc tế** — Thực tiễn nhà nước + opinio juris (ý thức về nghĩa vụ pháp lý)\n3. **Nguyên tắc chung** — Nguyên tắc được công nhận rộng rãi trong các hệ thống pháp lý\n4. **Phán quyết tư pháp + học thuật** — Phán quyết ICJ, các học giả pháp lý hàng đầu (nguồn phụ)',
   '{}', 1),

  ((SELECT id FROM lesson WHERE slug = 'intro-law-basics'),
   'key_points',
   'Law Essentials Summary',
   'Tóm Tắt Cơ Bản Về Luật Pháp',
   E'- **Common law** relies on precedent (stare decisis); **civil law** relies on written codes — UK/US vs France/Germany\n- **Rule of law** requires law apply equally to all, be publicly known, and be enforced by independent courts\n- **Due process** protects individuals before government can take life, liberty, or property\n- **Criminal law**: state prosecutes, beyond reasonable doubt, outcome = punishment\n- **Civil law**: private party sues, preponderance of evidence, outcome = remedy (money, injunction)\n- **International law** sources: treaties (binding) → customary law → general principles → judicial decisions\n- **ICJ** (International Court of Justice) resolves disputes between states; individuals cannot sue states directly at ICJ\n- The **presumption of innocence** is a cornerstone of criminal justice: accused is innocent until proven guilty',
   E'- **Thông luật** dựa vào tiền lệ (stare decisis); **dân luật** dựa vào bộ luật thành văn — Anh/Mỹ vs Pháp/Đức\n- **Nhà nước pháp quyền** yêu cầu luật áp dụng bình đẳng cho tất cả, được công bố công khai và thực thi bởi tòa án độc lập\n- **Quy trình tố tụng hợp lệ** bảo vệ cá nhân trước khi chính phủ có thể tước đoạt sự sống, tự do hoặc tài sản\n- **Luật hình sự**: nhà nước truy tố, vượt nghi ngờ hợp lý, kết quả = hình phạt\n- **Luật dân sự**: bên tư nhân kiện, trọng lượng bằng chứng, kết quả = biện pháp khắc phục (tiền, lệnh cấm)\n- **Nguồn luật quốc tế**: điều ước (ràng buộc) → luật tập quán → nguyên tắc chung → phán quyết tư pháp\n- **ICJ** (Tòa án Công lý Quốc tế) giải quyết tranh chấp giữa các quốc gia; cá nhân không thể kiện trực tiếp các quốc gia tại ICJ\n- **Suy đoán vô tội** là nền tảng của công lý hình sự: bị cáo vô tội cho đến khi được chứng minh có tội',
   '{}', 2),

  ((SELECT id FROM lesson WHERE slug = 'intro-law-basics'),
   'info_box',
   'Famous Legal Principles',
   'Các Nguyên Tắc Pháp Lý Nổi Tiếng',
   E'**Habeas Corpus** ("you shall have the body"): Ancient English writ requiring a person under arrest to be brought before a judge. Prevents arbitrary imprisonment — one of the oldest civil liberties, traced to Magna Carta (1215).\n\n**Nullum crimen sine lege** ("no crime without law"): You cannot be punished for an act that was not a crime when committed. Protects against retroactive criminal laws.\n\n**Res judicata** ("the thing has been judged"): Once a final judgment is rendered, the same parties cannot relitigate the same case. Ensures legal finality.\n\n**Lex specialis derogat legi generali**: Specific law overrides general law. When two laws conflict, the more specific one applies — key principle in international humanitarian law.',
   E'**Habeas Corpus** ("anh phải có thân xác"): Lệnh cổ xưa của Anh yêu cầu người bị bắt giữ phải được đưa ra trước thẩm phán. Ngăn chặn bắt giam tùy tiện — một trong những quyền dân sự lâu đời nhất, có nguồn gốc từ Magna Carta (1215).\n\n**Nullum crimen sine lege** ("không có tội nếu không có luật"): Bạn không thể bị trừng phạt vì một hành vi không phải là tội phạm khi thực hiện. Bảo vệ chống lại các luật hình sự hồi tố.\n\n**Res judicata** ("vụ việc đã được xét xử"): Một khi phán quyết cuối cùng được đưa ra, các bên liên quan không thể tranh tụng lại cùng một vụ án. Đảm bảo tính chung thẩm pháp lý.\n\n**Lex specialis derogat legi generali**: Luật cụ thể ghi đè luật chung. Khi hai luật xung đột, luật cụ thể hơn được áp dụng — nguyên tắc then chốt trong luật nhân đạo quốc tế.',
   '{"variant": "tip"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'intro-law-basics'),
   'multiple_choice', 'easy',
   'In a common law system, the principle of stare decisis means that judges must:',
   'Trong hệ thống thông luật, nguyên tắc stare decisis có nghĩa là các thẩm phán phải:',
   'B',
   'Stare decisis (Latin: "to stand by things decided") is the cornerstone of common law — courts are bound by prior decisions of higher courts within the same jurisdiction. This creates consistency and predictability. Civil law systems use precedent as persuasive, not binding.',
   'Stare decisis (Latinh: "đứng vững với những điều đã được quyết định") là nền tảng của thông luật — các tòa án bị ràng buộc bởi các quyết định trước của tòa án cấp trên trong cùng thẩm quyền. Điều này tạo ra sự nhất quán và có thể đoán trước.',
   1),
  ((SELECT id FROM lesson WHERE slug = 'intro-law-basics'),
   'true_false', 'easy',
   'In a criminal trial, the burden of proof is "preponderance of evidence" — meaning the prosecution must show that guilt is more likely than not (>50%).',
   'Trong một phiên tòa hình sự, gánh nặng chứng minh là "trọng lượng bằng chứng" — có nghĩa là bên công tố phải chứng minh tội lỗi có khả năng hơn không (>50%).',
   'false',
   'False. Criminal trials require proof "beyond reasonable doubt" — a much higher standard than 50%. "Preponderance of evidence" (>50%) applies to civil cases. The higher criminal standard reflects the severe consequences (imprisonment, death) and the presumption of innocence.',
   'Sai. Các phiên tòa hình sự yêu cầu bằng chứng "vượt nghi ngờ hợp lý" — tiêu chuẩn cao hơn nhiều so với 50%. "Trọng lượng bằng chứng" (>50%) áp dụng cho vụ án dân sự. Tiêu chuẩn hình sự cao hơn phản ánh hậu quả nghiêm trọng và suy đoán vô tội.',
   2),
  ((SELECT id FROM lesson WHERE slug = 'intro-law-basics'),
   'fill_blank', 'easy',
   'The principle that no one — not even the government — is above the law is called the ___ of law.',
   'Nguyên tắc rằng không ai — kể cả chính phủ — đứng trên pháp luật được gọi là nhà nước ___ quyền.',
   'rule',
   'Rule of law is the foundational principle that all persons and institutions are subject to and accountable to the law. It requires law to be publicly known, equally applied, and enforced by independent courts. Without rule of law, arbitrary power replaces justice.',
   'Nhà nước pháp quyền là nguyên tắc nền tảng rằng tất cả mọi người và tổ chức đều chịu sự điều chỉnh và chịu trách nhiệm trước pháp luật. Nó yêu cầu luật phải được công bố công khai, áp dụng bình đẳng và thực thi bởi các tòa án độc lập.',
   3),
  ((SELECT id FROM lesson WHERE slug = 'intro-law-basics'),
   'multiple_choice', 'medium',
   'Which of the following is a PRIMARY source of international law according to Article 38 of the ICJ Statute?',
   'Điều nào sau đây là nguồn CHÍNH của luật quốc tế theo Điều 38 của Quy chế ICJ?',
   'C',
   'Article 38 of the ICJ Statute lists primary sources: (1) treaties/conventions, (2) international custom, (3) general principles of law. Judicial decisions and scholarly writings are listed as subsidiary/secondary means for determining rules of law. UN General Assembly resolutions are not formally binding sources.',
   'Điều 38 của Quy chế ICJ liệt kê các nguồn chính: (1) điều ước/công ước, (2) tập quán quốc tế, (3) nguyên tắc pháp lý chung. Phán quyết tư pháp và bài viết học thuật được liệt kê là phương tiện phụ/thứ cấp để xác định các quy tắc pháp lý.',
   4),
  ((SELECT id FROM lesson WHERE slug = 'intro-law-basics'),
   'error_correction', 'medium',
   'Correct this statement: "Civil law countries like France and Germany rely on judge-made law through court precedents, while common law countries like the UK and USA primarily use comprehensive written codes."',
   'Sửa câu này: "Các quốc gia dân luật như Pháp và Đức dựa vào luật do thẩm phán tạo ra thông qua tiền lệ tòa án, trong khi các quốc gia thông luật như Anh và Mỹ chủ yếu sử dụng bộ luật thành văn toàn diện."',
   'The statement reverses the two systems. Common law countries (UK, USA) rely on judge-made law through precedent (stare decisis). Civil law countries (France, Germany) primarily use comprehensive written codes (e.g., French Civil Code, German BGB) and treat judicial decisions as persuasive but not binding.',
   'The statement has the definitions exactly backwards. Common law = precedent-driven (UK, USA, Australia, India). Civil law = code-driven (France, Germany, Japan, most of Latin America). This is a common confusion because "civil law" as a legal tradition sounds like it should relate to civil suits, but it actually refers to the Roman/Napoleonic codification tradition.',
   'Câu này đảo ngược hai hệ thống. Thông luật = dựa trên tiền lệ (Anh, Mỹ, Úc, Ấn Độ). Dân luật = dựa trên bộ luật (Pháp, Đức, Nhật Bản, phần lớn châu Mỹ Latinh). Đây là sự nhầm lẫn phổ biến vì "dân luật" với tư cách là truyền thống pháp lý nghe có vẻ liên quan đến vụ kiện dân sự, nhưng thực ra nó đề cập đến truyền thống pháp điển hóa La Mã/Napoleon.',
   5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-law-basics') AND order_index = 1),
   'A', 'Ignore prior court decisions and decide each case from first principles', 'Bỏ qua các phán quyết tòa án trước và quyết định từng vụ án từ nguyên tắc đầu tiên'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-law-basics') AND order_index = 1),
   'B', 'Follow binding precedents set by higher courts in the same jurisdiction', 'Tuân theo tiền lệ ràng buộc của các tòa án cấp trên trong cùng thẩm quyền'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-law-basics') AND order_index = 1),
   'C', 'Apply only the written statutory code passed by the legislature', 'Chỉ áp dụng bộ luật thành văn được thông qua bởi cơ quan lập pháp'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-law-basics') AND order_index = 1),
   'D', 'Consult foreign courts as binding authorities for domestic cases', 'Tham khảo các tòa án nước ngoài là cơ quan thẩm quyền ràng buộc cho các vụ án trong nước'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-law-basics') AND order_index = 4),
   'A', 'UN General Assembly resolutions — universally binding on all member states', 'Nghị quyết Đại hội đồng LHQ — ràng buộc toàn cầu đối với tất cả các quốc gia thành viên'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-law-basics') AND order_index = 4),
   'B', 'Writings of leading international law scholars', 'Bài viết của các học giả luật quốc tế hàng đầu'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-law-basics') AND order_index = 4),
   'C', 'International customs reflecting general state practice accepted as law', 'Tập quán quốc tế phản ánh thực tiễn nhà nước chung được chấp nhận là luật'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-law-basics') AND order_index = 4),
   'D', 'Decisions by the UN Security Council on legal interpretations', 'Quyết định của Hội đồng Bảo an LHQ về giải thích pháp lý');

-- ============================================================
-- LESSON 7: Reading Literature Analytically
-- Category: Literature & Creative Writing (order 1)
-- ============================================================

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Reading Literature Analytically',
  'Đọc Văn Học Phân Tích',
  'reading-literature-analytically',
  'Master literary analysis through theme, character, narrative structure, and critical interpretation.',
  'Thành thạo phân tích văn học qua chủ đề, nhân vật, cấu trúc tự sự và diễn giải phê bình.',
  'beginner', 45, 1
FROM category WHERE name = 'Literature & Creative Writing';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'reading-literature-analytically'),
   'Identify and analyze major literary elements',
   'Nhận biết và phân tích các yếu tố văn học chính',
   'Apply analytical lenses to theme, character development, setting, and point of view in literary texts.',
   'Áp dụng các góc nhìn phân tích về chủ đề, sự phát triển nhân vật, bối cảnh và điểm nhìn trong văn bản văn học.', 1),
  ((SELECT id FROM lesson WHERE slug = 'reading-literature-analytically'),
   'Understand narrative structure and literary devices',
   'Hiểu cấu trúc tự sự và các thủ pháp văn học',
   'Recognize how plot structure, conflict, and devices like irony and symbolism create meaning.',
   'Nhận biết cách cấu trúc cốt truyện, xung đột và các thủ pháp như mỉa mai và biểu tượng tạo ra ý nghĩa.', 2),
  ((SELECT id FROM lesson WHERE slug = 'reading-literature-analytically'),
   'Apply critical reading strategies to interpret texts',
   'Áp dụng chiến lược đọc phê bình để diễn giải văn bản',
   'Use close reading and critical frameworks (reader-response, new criticism) to construct literary interpretations.',
   'Sử dụng đọc kỹ lưỡng và khung phê bình (phản hồi độc giả, phê bình mới) để xây dựng diễn giải văn học.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'reading-literature-analytically'),
   'markdown',
   'The Elements of Literary Analysis',
   'Các Yếu Tố Phân Tích Văn Học',
   E'## Literary Elements\n\n### Character\n- **Protagonist**: Central character whose journey drives the narrative\n- **Antagonist**: Force (person, nature, society, self) opposing the protagonist\n- **Dynamic character**: Changes significantly through the story (e.g., Scrooge in *A Christmas Carol*)\n- **Static character**: Remains essentially unchanged (often minor characters or foils)\n- **Foil**: Character who contrasts with protagonist to highlight qualities (e.g., Draco Malfoy vs Harry Potter)\n\n### Theme vs Topic\n- **Topic**: What the story is "about" (war, love, identity)\n- **Theme**: What the story says *about* the topic — a complete statement (e.g., "Power corrupts those who seek it to control others")\n- Themes are never single words; they require a full claim about human experience\n\n### Narrative Structure\n\n**Freytag''s Pyramid** (classic five-act structure):\n1. **Exposition** — introduce characters, setting, and initial situation\n2. **Rising Action** — series of events increasing tension; complications arise\n3. **Climax** — the turning point; highest tension; protagonist must make a crucial decision\n4. **Falling Action** — consequences of the climactic decision unfold\n5. **Resolution/Denouement** — loose ends tied; new equilibrium established\n\n### Literary Devices\n| Device | Definition | Example |\n|---|---|---|\n| **Irony** (situational) | Outcome opposite of expectation | A fire station burns down |\n| **Irony** (dramatic) | Reader knows what character doesn''t | We know the murderer; the victim doesn''t |\n| **Irony** (verbal) | Saying the opposite of what is meant | "Oh great, another Monday" |\n| **Symbolism** | Object/person representing abstract idea | Green light in *Gatsby* = hope/dream |\n| **Motif** | Recurring element reinforcing theme | Recurring mirrors in vampire stories (no reflection) |\n| **Allusion** | Reference to external work/event | "He was a real Romeo with the ladies" |\n| **Foreshadowing** | Early hints about future events | Chekhov''s Gun principle |\n| **Metaphor** | Direct comparison without "like/as" | "Life is a journey" |\n| **Simile** | Comparison using "like" or "as" | "She fought like a lion" |',
   E'## Yếu Tố Văn Học\n\n### Nhân Vật\n- **Nhân vật chính**: Nhân vật trung tâm có hành trình thúc đẩy tự sự\n- **Nhân vật phản diện**: Lực lượng (người, thiên nhiên, xã hội, bản thân) đối lập với nhân vật chính\n- **Nhân vật động**: Thay đổi đáng kể qua câu chuyện (ví dụ: Scrooge trong *Bài Ca Ngày Giáng Sinh*)\n- **Nhân vật tĩnh**: Về cơ bản không thay đổi (thường là nhân vật phụ hoặc nhân vật đối chiếu)\n- **Nhân vật đối chiếu**: Nhân vật tương phản với nhân vật chính để làm nổi bật phẩm chất\n\n### Chủ Đề vs Đề Tài\n- **Đề tài**: Câu chuyện "về" điều gì (chiến tranh, tình yêu, bản sắc)\n- **Chủ đề**: Điều câu chuyện nói *về* đề tài — một tuyên bố đầy đủ (ví dụ: "Quyền lực làm tha hóa những ai tìm kiếm nó để kiểm soát người khác")\n- Chủ đề không bao giờ là từ đơn; chúng đòi hỏi một tuyên bố đầy đủ về kinh nghiệm con người\n\n### Cấu Trúc Tự Sự\n\n**Kim Tự Tháp Freytag** (cấu trúc năm hồi cổ điển):\n1. **Mở đầu** — giới thiệu nhân vật, bối cảnh và tình huống ban đầu\n2. **Hành động tăng dần** — chuỗi sự kiện tăng căng thẳng; các biến cố nảy sinh\n3. **Cao trào** — bước ngoặt; căng thẳng cao nhất; nhân vật chính phải đưa ra quyết định quan trọng\n4. **Hành động giảm dần** — hậu quả của quyết định cao trào bộc lộ\n5. **Giải quyết** — các mối lỏng được buộc chặt; cân bằng mới được thiết lập\n\n### Thủ Pháp Văn Học\n| Thủ Pháp | Định Nghĩa | Ví Dụ |\n|---|---|---|\n| **Mỉa mai** (tình huống) | Kết quả ngược với kỳ vọng | Đồn cứu hỏa bị cháy |\n| **Mỉa mai** (kịch tính) | Độc giả biết điều nhân vật không biết | Chúng ta biết kẻ giết người; nạn nhân không biết |\n| **Mỉa mai** (ngôn từ) | Nói ngược với ý muốn | "Ồ tuyệt, lại thêm một ngày thứ Hai nữa" |\n| **Biểu tượng** | Vật/người đại diện cho ý tưởng trừu tượng | Đèn xanh trong *Gatsby* = hy vọng/giấc mơ |\n| **Mô-típ** | Yếu tố lặp lại củng cố chủ đề | Gương xuất hiện trong các câu chuyện ma cà rồng |\n| **Ám chỉ** | Tham chiếu đến tác phẩm/sự kiện bên ngoài | "Anh ấy là Romeo thực sự với phụ nữ" |\n| **Dự báo** | Gợi ý sớm về các sự kiện tương lai | Nguyên tắc Súng Chekhov |\n| **Ẩn dụ** | So sánh trực tiếp không dùng "như" | "Cuộc đời là một hành trình" |\n| **Tựa** | So sánh dùng "như" | "Cô ấy chiến đấu như sư tử" |',
   '{}', 1),

  ((SELECT id FROM lesson WHERE slug = 'reading-literature-analytically'),
   'key_points',
   'Literary Analysis Essentials',
   'Cơ Bản Phân Tích Văn Học',
   E'- **Theme ≠ topic**: Topic is a noun (war); theme is a complete statement about human experience ("War destroys the innocent along with the guilty")\n- **Dynamic characters** change due to conflict; **static characters** serve to reveal others by contrast (foils)\n- **Freytag''s Pyramid**: Exposition → Rising Action → Climax → Falling Action → Resolution\n- **Three types of irony**: situational (outcome ≠ expectation), dramatic (reader knows more), verbal (saying the opposite)\n- **Symbolism vs motif**: A symbol is a single meaningful object; a motif is a recurring pattern across a text\n- **Close reading**: Analyze specific word choices, sentence structure, imagery — not just plot summary\n- **Point of view matters**: First person (limited, intimate), third person limited (one character''s perspective), omniscient (all-knowing narrator)\n- **Conflict types**: Person vs Person, Person vs Nature, Person vs Society, Person vs Self',
   E'- **Chủ đề ≠ đề tài**: Đề tài là danh từ (chiến tranh); chủ đề là tuyên bố đầy đủ về kinh nghiệm con người\n- **Nhân vật động** thay đổi do xung đột; **nhân vật tĩnh** phục vụ để tiết lộ người khác bằng sự tương phản\n- **Kim Tự Tháp Freytag**: Mở đầu → Hành động tăng → Cao trào → Hành động giảm → Giải quyết\n- **Ba loại mỉa mai**: tình huống (kết quả ≠ kỳ vọng), kịch tính (độc giả biết nhiều hơn), ngôn từ (nói ngược lại)\n- **Biểu tượng vs mô-típ**: Biểu tượng là một đối tượng có ý nghĩa đơn; mô-típ là mẫu lặp lại trong suốt văn bản\n- **Đọc kỹ lưỡng**: Phân tích các lựa chọn từ ngữ cụ thể, cấu trúc câu, hình ảnh — không chỉ tóm tắt cốt truyện\n- **Điểm nhìn quan trọng**: Ngôi thứ nhất (hạn chế, thân mật), ngôi thứ ba hạn chế (góc nhìn một nhân vật), toàn tri (người kể biết tất cả)\n- **Các loại xung đột**: Người vs Người, Người vs Thiên Nhiên, Người vs Xã Hội, Người vs Bản Thân',
   '{}', 2),

  ((SELECT id FROM lesson WHERE slug = 'reading-literature-analytically'),
   'info_box',
   'Chekhov''s Gun Principle',
   'Nguyên Tắc Súng Chekhov',
   E'Russian playwright Anton Chekhov formulated one of literature''s most famous rules: "If in the first act you have hung a pistol on the wall, then in the following one it should be fired. Otherwise don''t put it there."\n\nThis principle of narrative economy means every significant element introduced in a story must serve a purpose. Applied to reading: pay attention to what authors emphasize — seemingly random details often become crucial later.\n\nConversely, **Chekhov''s Gun subversion** is a technique where the gun is introduced but never fired, creating deliberate anticlimax — used by postmodern writers like Samuel Beckett to challenge reader expectations.',
   E'Nhà viết kịch người Nga Anton Chekhov đã đặt ra một trong những quy tắc nổi tiếng nhất của văn học: "Nếu trong màn đầu bạn treo một khẩu súng lục trên tường, thì trong màn tiếp theo nó phải nổ. Nếu không, đừng để nó ở đó."\n\nNguyên tắc kinh tế tự sự này có nghĩa là mọi yếu tố quan trọng được đưa vào câu chuyện đều phải phục vụ một mục đích. Áp dụng khi đọc: chú ý đến những gì tác giả nhấn mạnh — các chi tiết có vẻ ngẫu nhiên thường trở nên quan trọng về sau.\n\nNgược lại, **sự lật đổ Súng Chekhov** là một kỹ thuật trong đó khẩu súng được giới thiệu nhưng không bao giờ được bắn, tạo ra sự phản cao trào có chủ ý — được các nhà văn hậu hiện đại như Samuel Beckett sử dụng để thách thức kỳ vọng của độc giả.',
   '{"variant": "tip"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'reading-literature-analytically'),
   'multiple_choice', 'easy',
   'Which of the following is an example of DRAMATIC irony?',
   'Điều nào sau đây là ví dụ về mỉa mai KỊCH TÍNH?',
   'C',
   'Dramatic irony occurs when the audience knows something a character does not. In Romeo and Juliet, the audience knows Juliet is sleeping (not dead) while Romeo believes she is actually dead — creating devastating dramatic irony. Option A is situational irony; B is verbal irony; D is simple foreshadowing.',
   'Mỉa mai kịch tính xảy ra khi khán giả biết điều gì đó mà một nhân vật không biết. Trong Romeo và Juliet, khán giả biết Juliet đang ngủ (không phải chết) trong khi Romeo tin rằng cô thực sự đã chết — tạo ra sự mỉa mai kịch tính thảm khốc.',
   1),
  ((SELECT id FROM lesson WHERE slug = 'reading-literature-analytically'),
   'true_false', 'easy',
   'A theme in a literary work can be expressed as a single word, such as "justice" or "courage."',
   'Một chủ đề trong tác phẩm văn học có thể được diễn đạt bằng một từ đơn, chẳng hạn như "công lý" hoặc "lòng dũng cảm."',
   'false',
   'False. "Justice" or "courage" are topics (or subjects), not themes. A theme makes a complete claim about human experience — it is always a full statement: e.g., "True courage means acting despite fear, not the absence of fear." Themes must express an insight or argument about the topic.',
   'Sai. "Công lý" hay "lòng dũng cảm" là đề tài (hoặc chủ thể), không phải chủ đề. Chủ đề đưa ra tuyên bố đầy đủ về kinh nghiệm con người — nó luôn là một câu hoàn chỉnh: ví dụ: "Lòng dũng cảm thực sự là hành động dù sợ hãi, không phải không có sự sợ hãi."',
   2),
  ((SELECT id FROM lesson WHERE slug = 'reading-literature-analytically'),
   'fill_blank', 'easy',
   'In Freytag''s Pyramid, the moment of highest tension where the protagonist faces a crucial decision is called the ___.',
   'Trong Kim Tự Tháp Freytag, thời điểm căng thẳng cao nhất khi nhân vật chính đối mặt với quyết định quan trọng được gọi là ___.',
   'climax',
   'The climax (or turning point) is the pivotal moment of highest dramatic tension in a narrative. It is the point of no return where the protagonist''s choice or action determines the story''s outcome. Everything before builds toward it; everything after flows from it.',
   'Cao trào (hoặc bước ngoặt) là thời điểm căng thẳng kịch tính cao nhất trong tự sự. Đây là điểm không thể quay lại nơi lựa chọn hoặc hành động của nhân vật chính quyết định kết quả của câu chuyện.',
   3),
  ((SELECT id FROM lesson WHERE slug = 'reading-literature-analytically'),
   'multiple_choice', 'medium',
   'A character who remains essentially unchanged throughout the narrative and serves mainly to highlight qualities in the protagonist by contrast is called a:',
   'Một nhân vật về cơ bản không thay đổi trong suốt tự sự và chủ yếu phục vụ để làm nổi bật các phẩm chất của nhân vật chính bằng sự tương phản được gọi là:',
   'A',
   'A foil is a character whose contrasting traits illuminate the protagonist''s qualities. Dr. Watson makes Sherlock Holmes''s genius more apparent; Draco Malfoy contrasts with Harry Potter''s humility. Foils are typically static (unchanging). An antagonist opposes the hero but need not contrast in the foil sense.',
   'Nhân vật đối chiếu có các đặc điểm tương phản làm sáng tỏ phẩm chất của nhân vật chính. Bác sĩ Watson làm cho thiên tài của Sherlock Holmes trở nên rõ ràng hơn; Draco Malfoy tương phản với sự khiêm tốn của Harry Potter.',
   4),
  ((SELECT id FROM lesson WHERE slug = 'reading-literature-analytically'),
   'error_correction', 'medium',
   'Correct this statement: "A motif and a symbol are the same thing — both are objects in a story that represent abstract ideas like love, death, or freedom."',
   'Sửa câu này: "Mô-típ và biểu tượng là cùng một thứ — cả hai đều là vật thể trong câu chuyện đại diện cho các ý tưởng trừu tượng như tình yêu, cái chết hoặc tự do."',
   'A symbol is a single object or image that represents an abstract idea (e.g., the green light in The Great Gatsby symbolizes Gatsby''s dream). A motif is a recurring element — image, phrase, or situation — that appears throughout a text to reinforce its themes. All motifs may be symbolic, but not all symbols are motifs.',
   'The statement conflates two distinct devices. A symbol can appear once and carry meaning; a motif is defined by its repetition. For example, birds might be a motif in a novel (appearing in multiple scenes, always connected to freedom), while a single dove at the end is a symbol of peace. Motifs build cumulative meaning through pattern; symbols carry immediate connotative weight.',
   'Câu này nhầm lẫn hai thủ pháp riêng biệt. Biểu tượng có thể xuất hiện một lần và mang ý nghĩa; mô-típ được định nghĩa bởi sự lặp lại của nó. Ví dụ: chim có thể là mô-típ trong tiểu thuyết (xuất hiện trong nhiều cảnh, luôn liên kết với tự do), trong khi một con bồ câu duy nhất ở cuối là biểu tượng của hòa bình.',
   5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'reading-literature-analytically') AND order_index = 1),
   'A', 'A fire station catches fire and burns to the ground', 'Một đồn cứu hỏa bị cháy và bị thiêu rụi'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'reading-literature-analytically') AND order_index = 1),
   'B', 'A character says "What lovely weather!" during a thunderstorm', 'Một nhân vật nói "Thời tiết thật đẹp!" trong cơn bão sấm sét'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'reading-literature-analytically') AND order_index = 1),
   'C', 'The audience knows Juliet is sleeping while Romeo believes she is dead', 'Khán giả biết Juliet đang ngủ trong khi Romeo tin rằng cô đã chết'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'reading-literature-analytically') AND order_index = 1),
   'D', 'A mysterious locket is mentioned early and becomes important at the end', 'Một chiếc mặt dây chuyền bí ẩn được đề cập sớm và trở nên quan trọng ở cuối'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'reading-literature-analytically') AND order_index = 4),
   'A', 'Foil — static character who contrasts with the protagonist to highlight their traits', 'Nhân vật đối chiếu — nhân vật tĩnh tương phản với nhân vật chính để làm nổi bật các đặc điểm của họ'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'reading-literature-analytically') AND order_index = 4),
   'B', 'Antagonist — character who directly opposes the protagonist''s goals', 'Nhân vật phản diện — nhân vật trực tiếp đối lập với mục tiêu của nhân vật chính'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'reading-literature-analytically') AND order_index = 4),
   'C', 'Dynamic character — character who undergoes significant internal change', 'Nhân vật động — nhân vật trải qua sự thay đổi nội tâm đáng kể'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'reading-literature-analytically') AND order_index = 4),
   'D', 'Round character — character with complex, multi-dimensional personality', 'Nhân vật tròn — nhân vật có tính cách phức tạp, đa chiều');

-- ============================================================
-- LESSON 8: Creative Writing Craft
-- Category: Literature & Creative Writing (order 2)
-- ============================================================

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Creative Writing Craft',
  'Nghệ Thuật Viết Sáng Tạo',
  'creative-writing-craft',
  'Develop your voice through narrative techniques, dialogue, scene-building, and revision strategies.',
  'Phát triển giọng văn của bạn qua kỹ thuật tự sự, đối thoại, xây dựng cảnh và chiến lược biên soạn.',
  'beginner', 40, 2
FROM category WHERE name = 'Literature & Creative Writing';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'creative-writing-craft'),
   'Apply show-don''t-tell and sensory detail techniques',
   'Áp dụng kỹ thuật "cho thấy đừng kể" và chi tiết giác quan',
   'Move beyond telling readers about emotions to showing them through concrete action, dialogue, and sensory experience.',
   'Vượt ra ngoài việc kể cho độc giả nghe về cảm xúc đến cho họ thấy qua hành động cụ thể, đối thoại và trải nghiệm giác quan.', 1),
  ((SELECT id FROM lesson WHERE slug = 'creative-writing-craft'),
   'Write effective dialogue and scene transitions',
   'Viết đối thoại hiệu quả và chuyển tiếp cảnh',
   'Craft dialogue that reveals character and advances plot, and transitions that control pacing.',
   'Tạo ra đối thoại tiết lộ nhân vật và thúc đẩy cốt truyện, và các chuyển tiếp kiểm soát nhịp độ.', 2),
  ((SELECT id FROM lesson WHERE slug = 'creative-writing-craft'),
   'Use revision strategies to strengthen first drafts',
   'Sử dụng chiến lược biên soạn để củng cố bản thảo đầu tiên',
   'Understand that first drafts are for getting ideas down; revision is where craft is truly applied.',
   'Hiểu rằng bản thảo đầu tiên là để ghi ý tưởng xuống; biên soạn là nơi nghệ thuật thực sự được áp dụng.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'creative-writing-craft'),
   'markdown',
   'Core Craft Principles',
   'Các Nguyên Tắc Nghệ Thuật Cốt Lõi',
   E'## Show, Don''t Tell\n\nThe most cited principle in fiction writing:\n- **Telling**: "Maria was nervous." → inert, flat, unconvincing\n- **Showing**: "Maria''s hands were shaking. She read the same line three times before the words stopped swimming." → the reader *experiences* the nervousness\n\nShowing uses: specific action, physical sensation, dialogue, behavior — not labels\n\n### Sensory Detail\nEngage all five senses, not just sight. Strong writing uses:\n- **Smell** — most powerful memory trigger (Proust''s madeleine)\n- **Sound** — creates atmosphere ("the overhead fan ticked like a metronome")\n- **Touch/texture** — grounds the reader physically\n- **Taste** — often neglected, extremely evocative\n- **Sight** — use specific, concrete nouns (not "a car" but "a rust-eaten ''78 Chevy")\n\n## Dialogue\n\n**What good dialogue does**:\n1. Reveals character (how they speak = who they are)\n2. Advances plot or reveals conflict\n3. Sounds natural but is MORE compressed than real speech\n4. Carries subtext — characters rarely say exactly what they mean\n\n**Dialogue mechanics**:\n- Use "said" — it''s invisible. Avoid "exclaimed," "queried," "retorted" (they distract)\n- Attribution after first line: "Hello," she said. NOT "she said hello"\n- Each new speaker = new paragraph\n- Action beats replace attribution: *He slammed the door.* "We''re done." (no "he said" needed)\n\n**Subtext example**:\n> "How was your day?" she asked, not looking up from her phone.\n> "Fine." He poured himself a drink.\n\nNotice what''s NOT said — tension lives in the gap.\n\n## Pacing and Scene Structure\n\n- **Scene**: Real-time action with conflict; slows time\n- **Summary**: Compressed narration; speeds time ("Three weeks passed.")\n- **Vary sentence length**: Short sentences = speed, tension. Longer, flowing sentences = reflection, calm.\n\n## Revision\n\nFirst drafts are allowed to be bad. As Stephen King writes: "The first draft is just you telling yourself the story."\n\n**Revision checklist**:\n- Cut adverbs (mostly modify weak verbs — replace with stronger verbs)\n- Cut passive voice where active is clearer\n- Read aloud — ear catches what eye misses\n- Test every scene: does it reveal character OR advance plot? If neither, cut it\n- Check consistency: names, timeline, physical details',
   E'## Cho Thấy, Đừng Kể\n\nNguyên tắc được trích dẫn nhiều nhất trong viết tiểu thuyết:\n- **Kể**: "Maria rất lo lắng." → trơ, phẳng, không thuyết phục\n- **Cho thấy**: "Tay Maria đang run. Cô đọc cùng một dòng ba lần trước khi các từ ngừng bơi." → độc giả *trải nghiệm* sự lo lắng\n\nCho thấy sử dụng: hành động cụ thể, cảm giác vật lý, đối thoại, hành vi — không phải nhãn hiệu\n\n### Chi Tiết Giác Quan\nKích thích tất cả năm giác quan, không chỉ thị giác:\n- **Khứu giác** — kích thích ký ức mạnh nhất\n- **Thính giác** — tạo bầu không khí\n- **Xúc giác/kết cấu** — định vị người đọc về mặt vật lý\n- **Vị giác** — thường bị bỏ qua, cực kỳ gợi cảm\n- **Thị giác** — dùng danh từ cụ thể (không phải "một chiếc xe" mà là "chiếc Chevy 78 rỉ sét")\n\n## Đối Thoại\n\n**Đối thoại tốt thực hiện**:\n1. Tiết lộ nhân vật (cách họ nói = họ là ai)\n2. Thúc đẩy cốt truyện hoặc tiết lộ xung đột\n3. Nghe tự nhiên nhưng nén HƠN so với lời nói thực\n4. Mang ẩn ý — nhân vật hiếm khi nói chính xác những gì họ muốn\n\n**Cơ chế đối thoại**:\n- Dùng "nói" — nó vô hình. Tránh "thốt lên," "truy vấn," "phản bác"\n- Gán sau dòng đầu tiên: "Xin chào," cô nói.\n- Mỗi người nói mới = đoạn văn mới\n- Nhịp hành động thay thế gán: *Anh đập cửa.* "Chúng ta xong rồi."\n\n## Nhịp Độ và Cấu Trúc Cảnh\n\n- **Cảnh**: Hành động thời gian thực với xung đột; làm chậm thời gian\n- **Tóm tắt**: Tự sự nén; tăng tốc thời gian ("Ba tuần trôi qua.")\n- **Thay đổi độ dài câu**: Câu ngắn = tốc độ, căng thẳng. Câu dài = suy nghĩ, bình tĩnh.\n\n## Biên Soạn\n\nBản thảo đầu tiên được phép xấu. Như Stephen King viết: "Bản thảo đầu tiên chỉ là bạn kể câu chuyện cho chính mình."\n\n**Danh sách kiểm tra biên soạn**:\n- Cắt bỏ trạng từ (thường bổ nghĩa cho động từ yếu — thay bằng động từ mạnh hơn)\n- Cắt bỏ thể bị động khi thể chủ động rõ ràng hơn\n- Đọc to — tai bắt được những gì mắt bỏ lỡ\n- Kiểm tra mỗi cảnh: liệu nó có tiết lộ nhân vật HOẶC thúc đẩy cốt truyện không? Nếu không, cắt bỏ',
   '{}', 1),

  ((SELECT id FROM lesson WHERE slug = 'creative-writing-craft'),
   'key_points',
   'Creative Writing Quick Reference',
   'Tham Khảo Nhanh Viết Sáng Tạo',
   E'- **Show, don''t tell**: Replace emotion labels with concrete action, physical sensation, and behavior\n- **Sensory writing**: Use all 5 senses; smell is the strongest memory trigger\n- **Dialogue**: Use "said" (invisible); each speaker gets a new paragraph; subtext > direct statement\n- **Scene vs summary**: Scenes happen in real time (slow, detailed); summaries compress time ("Years passed")\n- **Sentence rhythm**: Short = urgency/tension; long = reflection/ease. Vary deliberately.\n- **Revision principle**: First drafts are discovery; revision is craft. Never edit while composing.\n- **Cut adverbs**: "She whispered softly" → "She whispered." Strong verbs don''t need adverbial props.\n- **Chekhov''s Gun in practice**: Every element you introduce should pay off — or cut it during revision',
   E'- **Cho thấy, đừng kể**: Thay nhãn cảm xúc bằng hành động cụ thể, cảm giác vật lý và hành vi\n- **Viết giác quan**: Dùng tất cả 5 giác quan; khứu giác là kích thích ký ức mạnh nhất\n- **Đối thoại**: Dùng "nói" (vô hình); mỗi người nói một đoạn mới; ẩn ý > tuyên bố trực tiếp\n- **Cảnh vs tóm tắt**: Cảnh xảy ra trong thời gian thực (chậm, chi tiết); tóm tắt nén thời gian\n- **Nhịp câu**: Ngắn = khẩn cấp/căng thẳng; dài = suy nghĩ/thoải mái. Thay đổi có chủ ý.\n- **Nguyên tắc biên soạn**: Bản thảo đầu tiên là khám phá; biên soạn là nghệ thuật. Không bao giờ chỉnh sửa khi đang sáng tác.\n- **Cắt bỏ trạng từ**: "Cô thì thầm nhẹ nhàng" → "Cô thì thầm." Động từ mạnh không cần chống đỡ bằng trạng từ.',
   '{}', 2),

  ((SELECT id FROM lesson WHERE slug = 'creative-writing-craft'),
   'info_box',
   'Hemingway''s Iceberg Theory',
   'Lý Thuyết Tảng Băng Của Hemingway',
   E'Ernest Hemingway developed what he called the "Iceberg Theory" (or theory of omission): the power of a story comes from what is left OUT — the emotion, backstory, and implication that the reader senses but never reads directly.\n\n"If a writer of prose knows enough about what he is writing about, he may omit things he knows and the reader will still have a strong feeling of those things." — Hemingway, *Death in the Afternoon*\n\nHis story "Hills Like White Elephants" demonstrates this: a couple discusses "an operation" throughout — the word "abortion" never appears, yet readers understand completely. The iceberg''s massive weight beneath the surface gives meaning to the small tip above.',
   E'Ernest Hemingway phát triển cái mà ông gọi là "Lý Thuyết Tảng Băng" (hoặc lý thuyết về sự bỏ qua): sức mạnh của một câu chuyện đến từ những gì bị BỎ QUA — cảm xúc, lịch sử và ngụ ý mà độc giả cảm nhận nhưng không bao giờ đọc trực tiếp.\n\n"Nếu một nhà văn biết đủ về những gì anh ta viết, anh ta có thể bỏ qua những điều anh ta biết và độc giả vẫn sẽ có cảm giác mạnh mẽ về những điều đó." — Hemingway\n\nCâu chuyện "Những Ngọn Đồi Như Voi Trắng" của ông chứng minh điều này: một cặp đôi thảo luận về "một ca phẫu thuật" — từ "phá thai" không bao giờ xuất hiện, nhưng độc giả hoàn toàn hiểu.',
   '{"variant": "tip"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'creative-writing-craft'),
   'multiple_choice', 'easy',
   'Which passage best demonstrates "show, don''t tell"?',
   'Đoạn văn nào thể hiện tốt nhất "cho thấy, đừng kể"?',
   'B',
   'Option B shows anger through physical action (slamming coffee, staring, bitten words) without labeling the emotion. Option A simply tells us she was "angry." Options C and D tell through adjectives and emotion labels. Good showing gives readers the evidence; telling gives them the conclusion.',
   'Lựa chọn B cho thấy sự tức giận qua hành động vật lý (đập cà phê, nhìn chằm chằm, lời nói cắt cụt) mà không gán nhãn cảm xúc. Lựa chọn A đơn giản kể cho chúng ta biết cô ấy "tức giận." Cho thấy tốt cung cấp cho độc giả bằng chứng; kể cho họ kết luận.',
   1),
  ((SELECT id FROM lesson WHERE slug = 'creative-writing-craft'),
   'true_false', 'easy',
   'In creative writing dialogue, it is best to use varied attribution words like "exclaimed," "muttered," "retorted," and "queried" instead of the plain word "said" to keep readers engaged.',
   'Trong đối thoại viết sáng tạo, tốt nhất nên sử dụng các từ gán đa dạng như "thốt lên," "lầm bầm," "phản bác" và "truy vấn" thay vì từ đơn giản "nói" để giữ sự tham gia của độc giả.',
   'false',
   'False. "Said" is preferred because it is invisible — readers skip past it. Unusual attribution words like "exclaimed" or "retorted" draw attention to themselves, interrupting the fictional dream. Most writing guides (including Elmore Leonard''s 10 Rules) advise using "said" almost exclusively. The dialogue and action beats should carry the emotion, not the attribution word.',
   'Sai. "Nói" được ưu tiên vì nó vô hình — độc giả bỏ qua nó. Các từ gán bất thường như "thốt lên" hay "phản bác" thu hút sự chú ý vào chính chúng, làm gián đoạn giấc mơ hư cấu. Hầu hết các hướng dẫn viết đề nghị sử dụng "nói" gần như độc quyền.',
   2),
  ((SELECT id FROM lesson WHERE slug = 'creative-writing-craft'),
   'fill_blank', 'easy',
   'According to Hemingway''s Iceberg Theory, the power of a story comes from what is ___ — the emotion and implication beneath the surface.',
   'Theo Lý Thuyết Tảng Băng của Hemingway, sức mạnh của một câu chuyện đến từ những gì bị ___ — cảm xúc và ngụ ý bên dưới bề mặt.',
   'omitted',
   'Hemingway''s Iceberg Theory (theory of omission) holds that a writer who truly understands their subject can leave out much of it — the reader will sense the weight of what is unsaid. This is why implication, subtext, and restraint often create stronger emotional impact than explicit statement.',
   'Lý Thuyết Tảng Băng của Hemingway cho rằng một nhà văn thực sự hiểu chủ đề của mình có thể bỏ qua phần lớn — độc giả sẽ cảm nhận được sức nặng của những gì không được nói. Đây là lý do tại sao ngụ ý, ẩn ý và sự kiềm chế thường tạo ra tác động cảm xúc mạnh hơn so với tuyên bố rõ ràng.',
   3),
  ((SELECT id FROM lesson WHERE slug = 'creative-writing-craft'),
   'multiple_choice', 'medium',
   'A writer is revising a scene where a character does many things but none reveal their personality or advance the plot. According to revision principles, the writer should:',
   'Một nhà văn đang biên soạn một cảnh trong đó nhân vật làm nhiều việc nhưng không có gì tiết lộ tính cách của họ hay thúc đẩy cốt truyện. Theo các nguyên tắc biên soạn, nhà văn nên:',
   'D',
   'Every scene must justify its existence by either revealing character (who this person is) or advancing plot (moving the story forward). A scene that does neither is "dead weight" — it can be summarized in one transitional sentence or cut entirely. This is the core test of scene revision.',
   'Mỗi cảnh phải biện minh cho sự tồn tại của mình bằng cách tiết lộ nhân vật (người này là ai) hoặc thúc đẩy cốt truyện (đẩy câu chuyện tiến lên). Một cảnh không làm được cả hai là "tải trọng chết" — nó có thể được tóm tắt trong một câu chuyển tiếp hoặc cắt bỏ hoàn toàn.',
   4),
  ((SELECT id FROM lesson WHERE slug = 'creative-writing-craft'),
   'error_correction', 'medium',
   'Correct this statement: "In creative writing, dialogue should represent real conversation as accurately as possible, including all the ''um,'' ''uh,'' repetitions, and incomplete sentences that people use in actual speech."',
   'Sửa câu này: "Trong viết sáng tạo, đối thoại nên đại diện cho cuộc trò chuyện thực tế càng chính xác càng tốt, bao gồm tất cả ''ừm,'' ''ờ,'' sự lặp lại và câu không hoàn chỉnh mà mọi người sử dụng trong lời nói thực tế."',
   'Good dialogue sounds natural but is NOT a transcript of real speech — it is compressed, purposeful, and more articulate. Real speech is full of false starts, filler words, and tangents. Fictional dialogue cuts all of that: every line should reveal character, advance plot, or create conflict. The goal is the illusion of real speech, not real speech itself.',
   'The statement confuses verisimilitude (the appearance of reality) with literal reproduction of reality. Real conversation transcripts read as tedious and purposeless. Literary dialogue is always a stylized, compressed version of speech — it must do work. Even "ums" and false starts in fiction are deliberate choices that reveal something specific about a character under stress or uncertainty.',
   'Câu này nhầm lẫn tính chân thực (vẻ ngoài của thực tế) với sự tái tạo chữ nghĩa của thực tế. Bản ghi cuộc trò chuyện thực tế đọc như tẻ nhạt và không mục đích. Đối thoại văn học luôn là phiên bản phong cách hóa, nén của lời nói — nó phải thực hiện công việc. Ngay cả "ừm" và khởi đầu sai trong văn học là những lựa chọn có chủ ý.',
   5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'creative-writing-craft') AND order_index = 1),
   'A', 'She was angry when he arrived late again.', 'Cô ấy tức giận khi anh lại đến muộn.'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'creative-writing-craft') AND order_index = 1),
   'B', 'She slammed her coffee on the counter and stared at the door. When he finally walked in, her words came out bitten. "You said seven."', 'Cô đập cà phê xuống quầy và nhìn chằm chằm vào cửa. Khi anh cuối cùng bước vào, lời cô cắt cụt. "Anh nói bảy giờ."'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'creative-writing-craft') AND order_index = 1),
   'C', 'She was a very angry woman who felt deeply frustrated by his irresponsible behavior.', 'Cô là một người phụ nữ rất tức giận cảm thấy cực kỳ thất vọng vì hành vi vô trách nhiệm của anh.'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'creative-writing-craft') AND order_index = 1),
   'D', 'Her feelings of anger were obvious to everyone in the room who could see her emotional state.', 'Cảm xúc tức giận của cô rõ ràng với mọi người trong phòng những ai có thể thấy trạng thái cảm xúc của cô.'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'creative-writing-craft') AND order_index = 4),
   'A', 'Keep the scene as-is, since all scenes are necessary to establish the story''s world', 'Giữ nguyên cảnh, vì tất cả các cảnh đều cần thiết để thiết lập thế giới câu chuyện'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'creative-writing-craft') AND order_index = 4),
   'B', 'Add more sensory details to make the scene more vivid and immersive', 'Thêm chi tiết giác quan để làm cho cảnh sống động và đắm chìm hơn'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'creative-writing-craft') AND order_index = 4),
   'C', 'Add dialogue to the scene to make it more dynamic and interesting', 'Thêm đối thoại vào cảnh để làm cho nó năng động và thú vị hơn'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'creative-writing-craft') AND order_index = 4),
   'D', 'Cut or summarize the scene — every scene must reveal character or advance plot', 'Cắt bỏ hoặc tóm tắt cảnh — mỗi cảnh phải tiết lộ nhân vật hoặc thúc đẩy cốt truyện');

-- ============================================================
-- LESSON 9: Visual Art Fundamentals
-- Category: Fine Arts & Architecture (order 1)
-- ============================================================

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Visual Art Fundamentals',
  'Cơ Bản Nghệ Thuật Thị Giác',
  'visual-art-fundamentals',
  'Understand the elements and principles of art, color theory, and how to read visual compositions.',
  'Hiểu các yếu tố và nguyên tắc nghệ thuật, lý thuyết màu sắc và cách đọc bố cục thị giác.',
  'beginner', 45, 1
FROM category WHERE name = 'Fine Arts & Architecture';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'visual-art-fundamentals'),
   'Identify and apply the 7 elements of art',
   'Nhận biết và áp dụng 7 yếu tố nghệ thuật',
   'Understand line, shape, form, space, color, value, and texture as the building blocks of all visual art.',
   'Hiểu đường nét, hình dạng, hình thức, không gian, màu sắc, giá trị và kết cấu là các khối xây dựng của mọi nghệ thuật thị giác.', 1),
  ((SELECT id FROM lesson WHERE slug = 'visual-art-fundamentals'),
   'Explain color theory and the color wheel',
   'Giải thích lý thuyết màu sắc và vòng màu',
   'Master primary, secondary, and tertiary colors, and understand complementary, analogous, and triadic color schemes.',
   'Nắm vững màu cơ bản, thứ cấp và bậc ba, và hiểu các bảng màu bổ sung, tương tự và tam giác.', 2),
  ((SELECT id FROM lesson WHERE slug = 'visual-art-fundamentals'),
   'Analyze composition using the principles of design',
   'Phân tích bố cục sử dụng các nguyên tắc thiết kế',
   'Apply balance, contrast, emphasis, rhythm, unity, and the rule of thirds to analyze and create visual compositions.',
   'Áp dụng cân bằng, tương phản, nhấn mạnh, nhịp điệu, thống nhất và quy tắc một phần ba để phân tích và tạo bố cục thị giác.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'visual-art-fundamentals'),
   'markdown',
   'Elements and Principles of Visual Art',
   'Yếu Tố và Nguyên Tắc Nghệ Thuật Thị Giác',
   E'## The 7 Elements of Art\n\nThe building blocks of all visual composition:\n\n| Element | Definition | Example |\n|---|---|---|\n| **Line** | Mark connecting two points; defines edges and contours | Thick lines = bold/heavy; thin = delicate |\n| **Shape** | 2D enclosed area (geometric or organic) | Circle, square, amoeba-like blob |\n| **Form** | 3D shape with volume and mass | Sphere, cube, cylinder |\n| **Space** | Area around, between, or within objects | Positive space (object), negative space (background) |\n| **Color** | Property of reflected light (hue, saturation, value) | Red, blue, warm vs cool |\n| **Value** | Lightness to darkness on a scale | White → grey → black (chiaroscuro in painting) |\n| **Texture** | Surface quality (actual or implied) | Rough bark, smooth marble, impasto paint |\n\n## Color Theory\n\n**Color wheel structure**:\n- **Primary**: Red, Yellow, Blue (cannot be mixed from other colors)\n- **Secondary**: Orange (R+Y), Green (Y+B), Violet (B+R)\n- **Tertiary**: Six colors between primary and secondary (red-orange, yellow-orange, etc.)\n\n**Color temperature**:\n- **Warm colors** (red, orange, yellow): advance visually, feel energetic, intimate\n- **Cool colors** (blue, green, violet): recede visually, feel calm, distant\n\n**Color relationships (harmonies)**:\n| Harmony | Definition | Mood |\n|---|---|---|\n| **Complementary** | Colors opposite on wheel (red/green, blue/orange) | High contrast, vibrant |\n| **Analogous** | Adjacent colors (blue, blue-green, green) | Harmonious, calm |\n| **Triadic** | Three equidistant colors (red/yellow/blue) | Bold, balanced |\n| **Monochromatic** | Single hue in different values/saturations | Unified, elegant |\n\n## Principles of Design (Composition)\n\n- **Balance**: Symmetrical (mirror) vs asymmetrical (equal visual weight, not mirror)\n- **Contrast**: Difference creates visual interest (light vs dark, rough vs smooth)\n- **Emphasis/Focal Point**: Where the eye is drawn first; hierarchy of importance\n- **Rhythm**: Repetition of elements creates movement and pattern\n- **Unity**: All elements work together as a cohesive whole\n- **Rule of Thirds**: Divide canvas into 9 parts; place key elements at intersections for dynamic composition\n- **Negative Space**: Empty space around subjects; can be as important as the subject itself',
   E'## 7 Yếu Tố Nghệ Thuật\n\nCác khối xây dựng của mọi bố cục thị giác:\n\n| Yếu Tố | Định Nghĩa | Ví Dụ |\n|---|---|---|\n| **Đường nét** | Dấu kết nối hai điểm; xác định cạnh và đường viền | Đường dày = đậm/nặng; mỏng = tinh tế |\n| **Hình dạng** | Khu vực 2D kín (hình học hoặc hữu cơ) | Hình tròn, hình vuông |\n| **Hình thức** | Hình dạng 3D với thể tích và khối lượng | Cầu, hình hộp, hình trụ |\n| **Không gian** | Diện tích xung quanh, giữa hoặc bên trong vật thể | Không gian dương (vật thể), âm (nền) |\n| **Màu sắc** | Thuộc tính của ánh sáng phản chiếu | Đỏ, xanh, ấm vs lạnh |\n| **Giá trị** | Độ sáng đến tối trên thang điểm | Trắng → xám → đen |\n| **Kết cấu** | Chất lượng bề mặt (thực tế hoặc ngụ ý) | Vỏ cây thô, đá cẩm thạch mịn |\n\n## Lý Thuyết Màu Sắc\n\n**Cấu trúc vòng màu**:\n- **Cơ bản**: Đỏ, Vàng, Xanh dương (không thể pha từ màu khác)\n- **Thứ cấp**: Cam (Đỏ+Vàng), Xanh lá (Vàng+Xanh dương), Tím (Xanh dương+Đỏ)\n- **Bậc ba**: Sáu màu giữa cơ bản và thứ cấp\n\n**Quan hệ màu sắc (hài hòa)**:\n| Hài Hòa | Định Nghĩa | Tâm Trạng |\n|---|---|---|\n| **Bổ sung** | Màu đối diện trên vòng màu (đỏ/xanh lá) | Tương phản cao, rực rỡ |\n| **Tương tự** | Màu liền kề (xanh dương, xanh lá cây) | Hài hòa, bình tĩnh |\n| **Tam giác** | Ba màu cách đều nhau | Đậm, cân bằng |\n| **Đơn sắc** | Một màu ở các giá trị/độ bão hòa khác nhau | Thống nhất, thanh lịch |\n\n## Nguyên Tắc Thiết Kế (Bố Cục)\n\n- **Cân bằng**: Đối xứng (gương) vs bất đối xứng (trọng lượng thị giác bằng nhau, không gương)\n- **Tương phản**: Sự khác biệt tạo ra sự thú vị thị giác\n- **Nhấn mạnh/Điểm tiêu cự**: Nơi mắt được thu hút đầu tiên\n- **Nhịp điệu**: Lặp lại các yếu tố tạo ra chuyển động và mẫu\n- **Thống nhất**: Tất cả các yếu tố hoạt động cùng nhau như một tổng thể gắn kết\n- **Quy tắc một phần ba**: Chia canvas thành 9 phần; đặt các yếu tố chính tại các giao điểm',
   '{}', 1),

  ((SELECT id FROM lesson WHERE slug = 'visual-art-fundamentals'),
   'key_points',
   'Visual Art Quick Reference',
   'Tham Khảo Nhanh Nghệ Thuật Thị Giác',
   E'- **7 elements of art**: Line, Shape, Form, Space, Color, Value, Texture\n- **Color wheel primaries**: Red, Yellow, Blue — cannot be mixed from other colors\n- **Complementary colors** are opposite on the wheel (red/green, blue/orange) — maximum contrast\n- **Analogous colors** are adjacent on the wheel — harmonious, calming effect\n- **Warm colors** (red, orange, yellow) advance visually; **cool colors** (blue, violet) recede\n- **Value** = lightness/darkness; **chiaroscuro** = dramatic use of light/dark contrast (Caravaggio, Rembrandt)\n- **Rule of thirds**: Place focal points at intersections of a 3x3 grid, not dead center\n- **Negative space** can be as compositionally powerful as the subject itself (Japanese art, logos)',
   E'- **7 yếu tố nghệ thuật**: Đường nét, Hình dạng, Hình thức, Không gian, Màu sắc, Giá trị, Kết cấu\n- **Màu cơ bản trên vòng màu**: Đỏ, Vàng, Xanh dương — không thể pha từ màu khác\n- **Màu bổ sung** đối diện nhau trên vòng màu — tương phản tối đa\n- **Màu tương tự** liền kề nhau — hiệu ứng hài hòa, bình tĩnh\n- **Màu ấm** (đỏ, cam, vàng) tiến về phía trước thị giác; **màu lạnh** (xanh dương, tím) lùi lại\n- **Giá trị** = độ sáng/tối; **chiaroscuro** = sử dụng tương phản ánh sáng/tối ấn tượng\n- **Quy tắc một phần ba**: Đặt điểm tiêu cự tại các giao điểm lưới 3x3, không phải trung tâm\n- **Không gian âm** có thể mạnh mẽ về bố cục như chính chủ thể',
   '{}', 2),

  ((SELECT id FROM lesson WHERE slug = 'visual-art-fundamentals'),
   'info_box',
   'Chiaroscuro: The Drama of Light and Shadow',
   'Chiaroscuro: Kịch Tính Của Ánh Sáng và Bóng Tối',
   E'**Chiaroscuro** (Italian: "light-dark") is the dramatic use of contrasting light and shadow to create three-dimensional form and emotional intensity. Developed during the Renaissance, it became central to Baroque painting.\n\n**Key masters**:\n- **Caravaggio** (1571–1610): Used extreme chiaroscuro (tenebrism) — figures emerge dramatically from near-total darkness\n- **Rembrandt** (1606–1669): Warm, golden light emanating from within scenes; figures bathed in psychological light\n- **Vermeer** (1632–1675): Soft, diffuse light from a single window source, creating intimacy\n\n**Modern uses**: Noir film cinematography, dramatic portrait photography, and comic book inking all draw on chiaroscuro principles.',
   E'**Chiaroscuro** (tiếng Ý: "sáng-tối") là việc sử dụng ấn tượng của ánh sáng và bóng tối tương phản để tạo ra hình thức ba chiều và cường độ cảm xúc. Được phát triển trong thời Phục Hưng, nó trở thành trung tâm của hội họa Baroque.\n\n**Các bậc thầy chính**:\n- **Caravaggio** (1571–1610): Sử dụng chiaroscuro cực độ (tenebrism) — các nhân vật xuất hiện ấn tượng từ bóng tối gần như hoàn toàn\n- **Rembrandt** (1606–1669): Ánh sáng vàng ấm tỏa ra từ bên trong các cảnh; các nhân vật tắm trong ánh sáng tâm lý\n- **Vermeer** (1632–1675): Ánh sáng mềm, khuếch tán từ một nguồn cửa sổ đơn, tạo ra sự thân mật\n\n**Ứng dụng hiện đại**: Điện ảnh noir, nhiếp ảnh chân dung ấn tượng và tô màu truyện tranh đều dựa trên các nguyên tắc chiaroscuro.',
   '{"variant": "tip"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'visual-art-fundamentals'),
   'multiple_choice', 'easy',
   'Which pair of colors are complementary colors on the traditional color wheel?',
   'Cặp màu nào là màu bổ sung trên vòng màu truyền thống?',
   'A',
   'Red and green are directly opposite on the color wheel, making them complementary colors. Complementary colors create maximum contrast when placed together — this is why red Christmas ornaments on green trees are so visually striking. Blue/orange and yellow/violet are also complementary pairs.',
   'Đỏ và xanh lá cây trực tiếp đối diện nhau trên vòng màu, làm cho chúng trở thành màu bổ sung. Màu bổ sung tạo ra tương phản tối đa khi đặt cạnh nhau — đây là lý do tại sao đồ trang trí Giáng Sinh đỏ trên cây xanh lá trông rất ấn tượng về mặt thị giác.',
   1),
  ((SELECT id FROM lesson WHERE slug = 'visual-art-fundamentals'),
   'true_false', 'easy',
   'In visual art, "negative space" refers to the empty areas around and between subjects, which can be just as compositionally important as the subjects themselves.',
   'Trong nghệ thuật thị giác, "không gian âm" đề cập đến các khu vực trống xung quanh và giữa các chủ thể, có thể quan trọng về mặt bố cục như chính các chủ thể.',
   'true',
   'True. Negative space (the empty, background areas) is a powerful compositional tool. The FedEx logo famously contains a hidden arrow in the negative space between the "E" and "x." Japanese art and minimalist design frequently use negative space (ma) as a primary compositional element, not merely as background.',
   'Đúng. Không gian âm (các khu vực trống, nền) là một công cụ bố cục mạnh mẽ. Logo FedEx nổi tiếng chứa một mũi tên ẩn trong không gian âm giữa "E" và "x." Nghệ thuật Nhật Bản và thiết kế tối giản thường xuyên sử dụng không gian âm như một yếu tố bố cục chính.',
   2),
  ((SELECT id FROM lesson WHERE slug = 'visual-art-fundamentals'),
   'fill_blank', 'easy',
   'The dramatic use of contrasting light and shadow in painting, associated with Caravaggio and Rembrandt, is called ___.',
   'Việc sử dụng ấn tượng của ánh sáng và bóng tối tương phản trong hội họa, liên quan đến Caravaggio và Rembrandt, được gọi là ___.',
   'chiaroscuro',
   'Chiaroscuro (Italian for "light-dark") is the technique of using strong contrasts between light and dark to give the illusion of three-dimensional volume. It was a defining feature of the Baroque period and created the dramatic, theatrical quality associated with Caravaggio''s work.',
   'Chiaroscuro (tiếng Ý nghĩa là "sáng-tối") là kỹ thuật sử dụng tương phản mạnh giữa sáng và tối để tạo ảo giác về thể tích ba chiều. Đây là đặc điểm xác định của thời kỳ Baroque và tạo ra chất lượng kịch tính, sân khấu liên quan đến tác phẩm của Caravaggio.',
   3),
  ((SELECT id FROM lesson WHERE slug = 'visual-art-fundamentals'),
   'multiple_choice', 'medium',
   'An artist wants to create a calm, harmonious painting using colors that feel unified. Which color harmony strategy should they use?',
   'Một nghệ sĩ muốn tạo ra một bức tranh bình tĩnh, hài hòa sử dụng các màu cảm thấy thống nhất. Họ nên sử dụng chiến lược hài hòa màu sắc nào?',
   'C',
   'Analogous colors (adjacent on the color wheel, e.g., blue, blue-green, green) create natural harmony and calm because they share a common hue. They are found frequently in nature (sunset gradients, ocean colors). Complementary creates high contrast/energy. Triadic is bold and varied. Monochromatic is unified but can feel monotonous.',
   'Màu tương tự (liền kề trên vòng màu, ví dụ: xanh dương, xanh lam, xanh lá) tạo ra sự hài hòa và bình tĩnh tự nhiên vì chúng chia sẻ một màu sắc chung. Chúng thường được tìm thấy trong tự nhiên (gradient hoàng hôn, màu đại dương). Bổ sung tạo ra tương phản/năng lượng cao. Tam giác đậm và đa dạng.',
   4),
  ((SELECT id FROM lesson WHERE slug = 'visual-art-fundamentals'),
   'error_correction', 'medium',
   'Correct this statement: "Warm colors like blue and green tend to advance visually and appear closer to the viewer, while cool colors like red and orange recede and appear further away."',
   'Sửa câu này: "Màu ấm như xanh dương và xanh lá có xu hướng tiến về phía trước thị giác và xuất hiện gần người xem hơn, trong khi màu lạnh như đỏ và cam lùi lại và xuất hiện xa hơn."',
   'The statement has warm and cool colors reversed. Warm colors (red, orange, yellow) advance visually and appear closer. Cool colors (blue, green, violet) recede and appear more distant. This is why landscape painters use warm colors in the foreground and cool, muted colors in the background to create depth.',
   'The statement has the color temperature effects exactly backwards. Warm colors (red, orange, yellow) advance — they grab attention, feel energetic and close. Cool colors (blue, green, violet) recede — they feel calm, distant, and airy. Atmospheric perspective in landscape painting exploits this: foregrounds are warm/saturated, distant mountains are cool/grey-blue.',
   'Câu này đảo ngược hiệu ứng nhiệt độ màu. Màu ấm (đỏ, cam, vàng) tiến lên — chúng thu hút sự chú ý, cảm thấy năng động và gần. Màu lạnh (xanh dương, xanh lá, tím) lùi lại — chúng cảm thấy bình tĩnh, xa và thoáng. Phối cảnh khí quyển trong hội họa phong cảnh khai thác điều này: tiền cảnh ấm/bão hòa, núi xa mát/xám-xanh.',
   5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'visual-art-fundamentals') AND order_index = 1),
   'A', 'Red and green', 'Đỏ và xanh lá'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'visual-art-fundamentals') AND order_index = 1),
   'B', 'Red and orange', 'Đỏ và cam'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'visual-art-fundamentals') AND order_index = 1),
   'C', 'Blue and violet', 'Xanh dương và tím'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'visual-art-fundamentals') AND order_index = 1),
   'D', 'Yellow and green', 'Vàng và xanh lá'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'visual-art-fundamentals') AND order_index = 4),
   'A', 'Complementary — using colors opposite on the color wheel for maximum contrast', 'Bổ sung — sử dụng màu đối diện trên vòng màu để tương phản tối đa'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'visual-art-fundamentals') AND order_index = 4),
   'B', 'Triadic — using three colors equidistant on the wheel for bold variety', 'Tam giác — sử dụng ba màu cách đều nhau trên vòng màu để tạo ra sự đa dạng đậm'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'visual-art-fundamentals') AND order_index = 4),
   'C', 'Analogous — using adjacent colors that share a common hue for natural harmony', 'Tương tự — sử dụng các màu liền kề chia sẻ màu chung để tạo hài hòa tự nhiên'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'visual-art-fundamentals') AND order_index = 4),
   'D', 'Monochromatic — using one color in many saturations for dramatic effect', 'Đơn sắc — sử dụng một màu ở nhiều độ bão hòa để tạo hiệu ứng ấn tượng');

-- ============================================================
-- LESSON 10: Architecture Through the Ages
-- Category: Fine Arts & Architecture (order 2)
-- ============================================================

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Architecture Through the Ages',
  'Kiến Trúc Qua Các Thời Đại',
  'architecture-through-ages',
  'Survey architectural history from ancient Egypt to modernism, exploring how buildings reflect culture and technology.',
  'Khảo sát lịch sử kiến trúc từ Ai Cập cổ đại đến chủ nghĩa hiện đại, khám phá cách các công trình phản ánh văn hóa và công nghệ.',
  'beginner', 45, 2
FROM category WHERE name = 'Fine Arts & Architecture';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'architecture-through-ages'),
   'Identify major architectural styles and their defining features',
   'Nhận biết các phong cách kiến trúc chính và các đặc điểm xác định của chúng',
   'Recognize and distinguish Classical, Gothic, Renaissance, Baroque, and Modern architectural styles.',
   'Nhận biết và phân biệt các phong cách kiến trúc Cổ điển, Gothic, Phục Hưng, Baroque và Hiện đại.', 1),
  ((SELECT id FROM lesson WHERE slug = 'architecture-through-ages'),
   'Explain key structural innovations and their historical impact',
   'Giải thích các đổi mới kết cấu chính và tác động lịch sử của chúng',
   'Understand how the arch, vault, dome, flying buttress, and steel skeleton changed what buildings could be.',
   'Hiểu cách vòm, mái vòm, mái vòm cầu, đầu gối bay và khung thép thay đổi những gì các công trình có thể là.', 2),
  ((SELECT id FROM lesson WHERE slug = 'architecture-through-ages'),
   'Connect architectural choices to their cultural and social contexts',
   'Kết nối các lựa chọn kiến trúc với bối cảnh văn hóa và xã hội của chúng',
   'Understand why societies built what they built — how religion, power, climate, and technology shaped architecture.',
   'Hiểu tại sao các xã hội xây dựng những gì họ xây dựng — cách tôn giáo, quyền lực, khí hậu và công nghệ định hình kiến trúc.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'architecture-through-ages'),
   'markdown',
   'Architectural History Overview',
   'Tổng Quan Lịch Sử Kiến Trúc',
   E'## Major Architectural Periods\n\n### Ancient Architecture\n- **Egyptian** (3000–30 BCE): Post-and-lintel construction; massive scale; permanence as religious statement; Pyramids at Giza, Karnak Temple\n- **Greek** (700–31 BCE): Three orders — **Doric** (simple capitals, Parthenon), **Ionic** (scroll capitals), **Corinthian** (acanthus leaf capitals); emphasis on proportion and human scale\n- **Roman** (509 BCE–476 CE): Mastered the **arch** and **vault**; invented **concrete** (opus caementicium); Pantheon (unreinforced concrete dome, 43.3m diameter), Colosseum, aqueducts\n\n### Medieval Architecture\n- **Byzantine** (330–1453): Round domes on pendentives; mosaic interiors; Hagia Sophia (537 CE)\n- **Romanesque** (900–1200): Thick walls, round arches, small windows, barrel vaults; fortress-like churches\n- **Gothic** (1150–1500): **Flying buttresses** transferred load outward → walls could be thin and window-filled; **pointed arches** → taller structures; **ribbed vaults** → lighter ceiling; Chartres, Notre-Dame\n\n### Renaissance to Baroque\n- **Renaissance** (1400–1600): Revival of Greek/Roman forms; symmetry, proportion, Vitruvian principles; Filippo Brunelleschi''s Florence Cathedral dome (1436) — engineering breakthrough\n- **Baroque** (1600–1750): Dramatic, theatrical; curves and contrast; ornate decoration; St. Peter''s Basilica (Bernini''s colonnade), Palace of Versailles\n\n### Modern Architecture\n- **Neoclassicism** (1750–1850): Return to pure classical forms; US Capitol, Panthéon Paris\n- **Beaux-Arts** (1830–1920): Grand civic buildings; classical ornament at large scale; Grand Central Terminal\n- **Modernism** (1920–1970): "Form follows function" (Louis Sullivan); steel + glass; International Style; eliminate ornament; Mies van der Rohe, Le Corbusier, Frank Lloyd Wright\n- **Postmodernism** (1970–present): Playful return to historical references; irony; color; complexity; Frank Gehry (Guggenheim Bilbao)\n- **Sustainable/Green Architecture** (2000–present): LEED certification; passive solar; living walls; net-zero buildings',
   E'## Các Thời Kỳ Kiến Trúc Chính\n\n### Kiến Trúc Cổ Đại\n- **Ai Cập** (3000–30 TCN): Xây dựng cột-xà; quy mô khổng lồ; sự bền vững như tuyên bố tôn giáo; Kim tự tháp Giza, Đền Karnak\n- **Hy Lạp** (700–31 TCN): Ba kiểu thức — **Doric** (chóp đơn giản, Parthenon), **Ionic** (chóp cuộn), **Corinthian** (chóp lá acanthus); nhấn mạnh vào tỷ lệ và quy mô con người\n- **La Mã** (509 TCN–476 CN): Thành thạo **vòm** và **mái vòm**; phát minh ra **bê tông**; Pantheon (vòm bê tông không gia cố 43,3m đường kính), Đấu trường Colosseum, cống dẫn nước\n\n### Kiến Trúc Trung Cổ\n- **Byzantine** (330–1453): Mái vòm tròn trên tường chuyển tiếp; nội thất khảm; Hagia Sophia (537 CN)\n- **Romanesque** (900–1200): Tường dày, vòm tròn, cửa sổ nhỏ, mái vòm thùng; nhà thờ như pháo đài\n- **Gothic** (1150–1500): **Đầu gối bay** chuyển tải trọng ra ngoài → tường mỏng và nhiều cửa sổ; **vòm nhọn** → cấu trúc cao hơn; **mái vòm sườn** → trần nhẹ hơn; Chartres, Notre-Dame\n\n### Phục Hưng đến Baroque\n- **Phục Hưng** (1400–1600): Hồi sinh hình thức Hy Lạp/La Mã; đối xứng, tỷ lệ, nguyên tắc Vitruvius; Mái vòm Nhà thờ Florence của Brunelleschi (1436)\n- **Baroque** (1600–1750): Kịch tính, sân khấu; đường cong và tương phản; trang trí cầu kỳ; Vương cung Thánh đường St. Peter, Cung điện Versailles\n\n### Kiến Trúc Hiện Đại\n- **Tân Cổ Điển** (1750–1850): Trở lại hình thức cổ điển thuần túy; Điện Capitol Mỹ\n- **Chủ Nghĩa Hiện Đại** (1920–1970): "Hình thức theo chức năng" (Louis Sullivan); thép + kính; loại bỏ trang trí; Mies van der Rohe, Le Corbusier, Frank Lloyd Wright\n- **Hậu Hiện Đại** (1970–nay): Tham chiếu lịch sử vui tươi; mỉa mai; màu sắc; phức tạp; Frank Gehry (Guggenheim Bilbao)\n- **Kiến Trúc Bền Vững** (2000–nay): Chứng nhận LEED; năng lượng mặt trời thụ động; tòa nhà net-zero',
   '{}', 1),

  ((SELECT id FROM lesson WHERE slug = 'architecture-through-ages'),
   'key_points',
   'Architecture Essentials',
   'Cơ Bản Kiến Trúc',
   E'- **Greek orders**: Doric (simple, Parthenon), Ionic (scrolls), Corinthian (acanthus leaves) — still used in neoclassical buildings\n- **Roman innovations**: The arch, vault, dome, and concrete enabled unprecedented scale (Pantheon dome: 43.3m, unreinforced)\n- **Gothic breakthrough**: Flying buttresses moved structural load outside walls → huge stained-glass windows possible\n- **Renaissance principle**: Symmetry, human proportion, revival of Vitruvius — Brunelleschi''s Florence dome was an engineering revolution\n- **Modernism motto**: "Form follows function" (Sullivan); eliminate ornament; let structure be visible (Mies: "Less is more")\n- **Postmodernism**: Rejected modernist austerity; added historical allusion, color, and complexity (Venturi: "Less is a bore")\n- **Sustainable architecture**: LEED, passive solar, green roofs, net-zero — architecture responding to climate crisis\n- Architecture reveals power: temples = divine authority; cathedrals = church power; skyscrapers = corporate/financial dominance',
   E'- **Kiểu thức Hy Lạp**: Doric (đơn giản, Parthenon), Ionic (cuộn), Corinthian (lá acanthus) — vẫn được dùng trong các tòa nhà tân cổ điển\n- **Đổi mới La Mã**: Vòm, mái vòm, mái vòm cầu và bê tông cho phép quy mô chưa từng có\n- **Đột phá Gothic**: Đầu gối bay chuyển tải trọng cấu trúc ra ngoài tường → cửa sổ kính màu khổng lồ có thể có\n- **Nguyên tắc Phục Hưng**: Đối xứng, tỷ lệ con người, hồi sinh Vitruvius\n- **Khẩu hiệu Hiện đại**: "Hình thức theo chức năng" (Sullivan); loại bỏ trang trí; để cấu trúc hiển thị\n- **Hậu Hiện đại**: Từ chối sự khắc nghiệt hiện đại; thêm ám chỉ lịch sử, màu sắc và phức tạp\n- **Kiến trúc bền vững**: LEED, năng lượng mặt trời thụ động, mái nhà xanh, net-zero\n- Kiến trúc tiết lộ quyền lực: đền = thẩm quyền thần thánh; nhà thờ = quyền lực giáo hội; nhà chọc trời = sự thống trị doanh nghiệp',
   '{}', 2),

  ((SELECT id FROM lesson WHERE slug = 'architecture-through-ages'),
   'info_box',
   'The Pantheon: 2,000-Year-Old Engineering Marvel',
   'Pantheon: Kỳ Tích Kỹ Thuật 2.000 Năm Tuổi',
   E'Built in Rome around 125 CE by Emperor Hadrian, the Pantheon features the world''s largest unreinforced concrete dome — 43.3 meters in diameter, identical to its height.\n\nThe **oculus** (open circular hole, 8.8m diameter) at the dome''s apex is the only source of natural light. It lets in rain, which drains through hidden floor drains. The dome''s weight is managed through a brilliant engineering trick: the concrete becomes progressively lighter toward the top (heavy travertine at base → pumice at apex).\n\nFor nearly 1,300 years (until Brunelleschi''s Florence Cathedral dome in 1436), the Pantheon''s dome was the world''s largest. It influenced countless buildings including the US Capitol and Thomas Jefferson''s Monticello.',
   E'Được xây dựng ở Rome khoảng năm 125 CN bởi Hoàng đế Hadrian, Pantheon có mái vòm bê tông không gia cố lớn nhất thế giới — đường kính 43,3 mét, bằng với chiều cao của nó.\n\n**Oculus** (lỗ tròn mở, đường kính 8,8m) ở đỉnh mái vòm là nguồn ánh sáng tự nhiên duy nhất. Nó để mưa vào, thoát qua các cống sàn ẩn. Trọng lượng mái vòm được quản lý thông qua một thủ thuật kỹ thuật xuất sắc: bê tông trở nên nhẹ hơn dần lên phía trên (travertine nặng ở đáy → đá bọt ở đỉnh).\n\nGần 1.300 năm (cho đến mái vòm Nhà thờ Florence của Brunelleschi năm 1436), mái vòm Pantheon là mái vòm lớn nhất thế giới. Nó ảnh hưởng đến vô số công trình bao gồm Điện Capitol Mỹ và Monticello của Thomas Jefferson.',
   '{"variant": "tip"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'architecture-through-ages'),
   'multiple_choice', 'easy',
   'The Gothic architectural innovation that allowed cathedral walls to be thin and filled with stained glass was the:',
   'Đổi mới kiến trúc Gothic cho phép tường nhà thờ mỏng và đầy kính màu là:',
   'B',
   'Flying buttresses are external arched supports that transfer the lateral thrust of walls and vaults outward and downward to piers away from the building. This allowed Gothic builders to make walls thin and fill them with enormous stained-glass windows, which would have been impossible with Romanesque thick-wall construction.',
   'Đầu gối bay là các trụ đỡ vòm bên ngoài chuyển lực đẩy ngang của tường và mái vòm ra ngoài và xuống dưới đến các trụ cách xa tòa nhà. Điều này cho phép các nhà xây dựng Gothic làm tường mỏng và lấp đầy chúng bằng các cửa sổ kính màu khổng lồ.',
   1),
  ((SELECT id FROM lesson WHERE slug = 'architecture-through-ages'),
   'true_false', 'easy',
   'The modernist architectural principle "form follows function" means that a building''s aesthetic and decorative features should determine its structural design.',
   'Nguyên tắc kiến trúc hiện đại "hình thức theo chức năng" có nghĩa là các đặc điểm thẩm mỹ và trang trí của một tòa nhà nên xác định thiết kế kết cấu của nó.',
   'false',
   'False. "Form follows function" (coined by Louis Sullivan) means the OPPOSITE: a building''s form (shape, aesthetics) should emerge from and be determined by its function (purpose, use). Ornament that doesn''t serve function should be eliminated. This principle drove modernism''s rejection of historical decorative styles.',
   'Sai. "Hình thức theo chức năng" (do Louis Sullivan đặt ra) có nghĩa là NGƯỢC LẠI: hình thức của một tòa nhà (hình dạng, thẩm mỹ) nên xuất hiện từ và được xác định bởi chức năng của nó (mục đích, sử dụng). Trang trí không phục vụ chức năng nên được loại bỏ.',
   2),
  ((SELECT id FROM lesson WHERE slug = 'architecture-through-ages'),
   'fill_blank', 'easy',
   'The Romans invented a building material that enabled construction of unprecedented scale, including the Pantheon''s massive dome. This material was ___.',
   'Người La Mã đã phát minh ra vật liệu xây dựng cho phép xây dựng với quy mô chưa từng có, bao gồm mái vòm khổng lồ của Pantheon. Vật liệu này là ___.',
   'concrete',
   'Roman concrete (opus caementicium) was a revolutionary material made from volcanic ash (pozzolana), lime, seawater, and aggregates. It could be poured into molds and set underwater. The Pantheon''s dome (built c.125 CE) remained the world''s largest concrete dome for over 1,300 years.',
   'Bê tông La Mã (opus caementicium) là vật liệu cách mạng làm từ tro núi lửa (pozzolana), vôi, nước biển và cốt liệu. Nó có thể được đổ vào khuôn và đông cứng dưới nước. Mái vòm Pantheon (xây dựng khoảng 125 CN) vẫn là mái vòm bê tông lớn nhất thế giới hơn 1.300 năm.',
   3),
  ((SELECT id FROM lesson WHERE slug = 'architecture-through-ages'),
   'multiple_choice', 'medium',
   'Which architectural movement rejected the austerity and ornament-free style of modernism, often incorporating historical references, irony, and bright colors?',
   'Phong trào kiến trúc nào từ chối sự khắc nghiệt và phong cách không trang trí của chủ nghĩa hiện đại, thường kết hợp các tham chiếu lịch sử, mỉa mai và màu sắc tươi sáng?',
   'D',
   'Postmodernism (1970s–present) explicitly reacted against modernism''s rejection of history and ornament. Robert Venturi''s 1966 manifesto "Complexity and Contradiction in Architecture" challenged "less is more" with "less is a bore." Postmodern buildings quote historical styles playfully and use symbolic decoration. Examples: AT&T Building (Philip Johnson), Piazza d''Italia (Charles Moore).',
   'Chủ nghĩa Hậu hiện đại (1970s–nay) phản ứng rõ ràng chống lại việc chủ nghĩa hiện đại từ chối lịch sử và trang trí. Manifesto 1966 của Robert Venturi "Phức Tạp và Mâu Thuẫn trong Kiến Trúc" thách thức "ít hơn là nhiều hơn" bằng "ít hơn là nhàm chán." Các tòa nhà Hậu hiện đại trích dẫn các phong cách lịch sử một cách vui tươi.',
   4),
  ((SELECT id FROM lesson WHERE slug = 'architecture-through-ages'),
   'error_correction', 'medium',
   'Correct this statement: "Gothic cathedrals like Notre-Dame de Paris used thick, massive walls to support the weight of their stone roofs, which is why they had few and small windows."',
   'Sửa câu này: "Các nhà thờ Gothic như Notre-Dame de Paris sử dụng tường dày, khổng lồ để đỡ trọng lượng của mái đá, đó là lý do tại sao chúng có ít cửa sổ nhỏ."',
   'The statement describes Romanesque architecture, not Gothic. Gothic cathedrals innovated with flying buttresses that transferred structural loads away from walls, allowing walls to be thin and filled with enormous stained-glass windows. The defining visual feature of Gothic cathedrals IS their abundance of large windows — the opposite of what the statement claims.',
   'The statement confuses Romanesque and Gothic. Romanesque churches (900–1200) had thick walls, small windows, round arches — the wall bore the load. Gothic churches (1150–1500) used flying buttresses to externalize the load, enabling thin walls and vast stained-glass windows (Chartres has 176 stained-glass windows). The Gothic style was literally defined by its ability to dissolve walls into glass.',
   'Câu này nhầm lẫn kiến trúc Romanesque và Gothic. Nhà thờ Romanesque (900–1200) có tường dày, cửa sổ nhỏ, vòm tròn — tường chịu tải. Nhà thờ Gothic (1150–1500) sử dụng đầu gối bay để ngoại hóa tải trọng, cho phép tường mỏng và cửa sổ kính màu rộng lớn (Chartres có 176 cửa sổ kính màu).',
   5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'architecture-through-ages') AND order_index = 1),
   'A', 'The pointed arch — transferring load along diagonals instead of vertically', 'Vòm nhọn — chuyển tải trọng theo đường chéo thay vì theo chiều dọc'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'architecture-through-ages') AND order_index = 1),
   'B', 'The flying buttress — external support transferring structural load away from walls', 'Đầu gối bay — trụ đỡ bên ngoài chuyển tải trọng kết cấu ra khỏi tường'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'architecture-through-ages') AND order_index = 1),
   'C', 'The ribbed vault — distributing ceiling weight across arching ribs', 'Mái vòm sườn — phân phối trọng lượng trần qua các sườn vòm'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'architecture-through-ages') AND order_index = 1),
   'D', 'Roman concrete — a lightweight material that required less structural support', 'Bê tông La Mã — vật liệu nhẹ đòi hỏi ít hỗ trợ kết cấu hơn'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'architecture-through-ages') AND order_index = 4),
   'A', 'Art Nouveau — using organic, flowing plant-inspired forms', 'Art Nouveau — sử dụng hình thức hữu cơ, chảy lấy cảm hứng từ thực vật'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'architecture-through-ages') AND order_index = 4),
   'B', 'Brutalism — using raw, exposed concrete as the primary aesthetic', 'Chủ nghĩa Thô bạo — sử dụng bê tông thô, lộ thiên làm thẩm mỹ chính'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'architecture-through-ages') AND order_index = 4),
   'C', 'Deconstructivism — fragmenting building geometry to create dynamic tension', 'Giải Cấu Trúc — phân mảnh hình học tòa nhà để tạo ra căng thẳng động'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'architecture-through-ages') AND order_index = 4),
   'D', 'Postmodernism — playfully incorporating historical references and rejecting austere modernism', 'Hậu Hiện Đại — vui tươi kết hợp các tham chiếu lịch sử và từ chối chủ nghĩa hiện đại khắc nghiệt');

-- ============================================================
-- LESSON 11: Photography Fundamentals
-- Category: Photography & Film (order 1)
-- ============================================================

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Photography Fundamentals',
  'Cơ Bản Nhiếp Ảnh',
  'photography-fundamentals',
  'Master the exposure triangle, composition rules, and how cameras translate light into images.',
  'Nắm vững tam giác phơi sáng, quy tắc bố cục và cách máy ảnh chuyển đổi ánh sáng thành hình ảnh.',
  'beginner', 40, 1
FROM category WHERE name = 'Photography & Film';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'photography-fundamentals'),
   'Understand and control the exposure triangle',
   'Hiểu và kiểm soát tam giác phơi sáng',
   'Master how aperture, shutter speed, and ISO interact to control exposure and creative effects.',
   'Nắm vững cách khẩu độ, tốc độ màn trập và ISO tương tác để kiểm soát phơi sáng và hiệu ứng sáng tạo.', 1),
  ((SELECT id FROM lesson WHERE slug = 'photography-fundamentals'),
   'Apply composition principles to create stronger images',
   'Áp dụng các nguyên tắc bố cục để tạo ra hình ảnh mạnh hơn',
   'Use the rule of thirds, leading lines, framing, and depth to direct viewer attention intentionally.',
   'Sử dụng quy tắc một phần ba, đường dẫn, khung cảnh và chiều sâu để hướng dẫn sự chú ý của người xem một cách có chủ ý.', 2),
  ((SELECT id FROM lesson WHERE slug = 'photography-fundamentals'),
   'Explain how cameras capture light and form images',
   'Giải thích cách máy ảnh thu ánh sáng và tạo hình ảnh',
   'Understand sensor/film, focal length, depth of field, and how lens choice shapes visual storytelling.',
   'Hiểu cảm biến/phim, tiêu cự, chiều sâu trường ảnh và cách lựa chọn ống kính định hình kể chuyện thị giác.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'photography-fundamentals'),
   'markdown',
   'The Exposure Triangle and Camera Fundamentals',
   'Tam Giác Phơi Sáng và Cơ Bản Máy Ảnh',
   E'## The Exposure Triangle\n\nThree settings control exposure (how much light reaches the sensor):\n\n### 1. Aperture (f-stop)\n- The opening in the lens that lets light through\n- Measured in f-stops: f/1.4, f/2, f/2.8, f/4, f/5.6, f/8, f/11, f/16\n- **Counterintuitive**: Smaller f-number = LARGER opening = more light\n- **Creative effect**: Controls **depth of field**\n  - f/1.8 → shallow depth (background blurry — bokeh effect, portrait photography)\n  - f/16 → deep depth (everything sharp — landscape photography)\n\n### 2. Shutter Speed\n- How long the sensor is exposed to light\n- Range: 1/8000s to 30s (or Bulb mode)\n- **Fast shutter** (1/1000s+): Freezes motion (sports, birds in flight)\n- **Slow shutter** (1/30s–): Creates motion blur (waterfalls, light trails, panning)\n- Rule of thumb: Minimum shutter = 1/focal length (50mm lens → 1/50s minimum to avoid camera shake)\n\n### 3. ISO\n- Sensor''s sensitivity to light\n- Range: ISO 100 (base, clean) to ISO 51200 (very sensitive, noisy)\n- **Low ISO** (100–400): Bright conditions; cleanest image; most detail\n- **High ISO** (1600+): Low light conditions; introduces digital noise (grain)\n- **Trade-off**: More light sensitivity = more noise\n\n### The Triangle Relationship\nChanging any one setting requires compensating with another to maintain the same exposure:\n- Want shallow DOF (f/1.8 from f/8)? → More light enters → Speed up shutter or lower ISO\n- Want to freeze motion (1/1000s from 1/125s)? → Less time for light → Open aperture or raise ISO\n\n## Composition Principles\n\n| Principle | Application |\n|---|---|\n| **Rule of Thirds** | Divide frame into 9 parts; place subjects at intersections |\n| **Leading Lines** | Roads, rivers, fences guide eye toward subject |\n| **Framing** | Use foreground elements (arch, doorway, branches) to frame subject |\n| **Depth** | Foreground, midground, background layers create 3D feeling |\n| **Negative Space** | Empty space around subject creates breathing room and emphasis |\n| **Symmetry** | Reflections, buildings — works best with central composition |\n\n## Depth of Field\n\n**Factors that affect depth of field**:\n1. **Aperture**: Wider aperture (f/1.4) = shallower DOF\n2. **Focal length**: Longer lens (200mm) = shallower DOF than wide (24mm)\n3. **Distance**: Closer to subject = shallower DOF\n\n**Bokeh** (Japanese: blur quality): Aesthetically pleasing out-of-focus background; achieved with fast lenses (f/1.2–f/2) at close range',
   E'## Tam Giác Phơi Sáng\n\nBa thiết lập kiểm soát phơi sáng (lượng ánh sáng đến cảm biến):\n\n### 1. Khẩu Độ (f-stop)\n- Độ mở trong ống kính cho ánh sáng đi qua\n- Đo bằng f-stop: f/1.4, f/2, f/2.8, f/4, f/5.6, f/8, f/11, f/16\n- **Ngược trực giác**: Số f nhỏ hơn = Độ mở LỚN HƠN = Nhiều ánh sáng hơn\n- **Hiệu ứng sáng tạo**: Kiểm soát **chiều sâu trường ảnh**\n  - f/1.8 → chiều sâu nông (nền mờ — hiệu ứng bokeh, chụp ảnh chân dung)\n  - f/16 → chiều sâu sâu (mọi thứ sắc nét — chụp ảnh phong cảnh)\n\n### 2. Tốc Độ Màn Trập\n- Thời gian cảm biến tiếp xúc với ánh sáng\n- **Màn trập nhanh** (1/1000s+): Đóng băng chuyển động (thể thao, chim đang bay)\n- **Màn trập chậm** (1/30s–): Tạo ra mờ chuyển động (thác nước, vệt ánh sáng)\n\n### 3. ISO\n- Độ nhạy cảm biến với ánh sáng\n- **ISO thấp** (100–400): Điều kiện sáng; ảnh sạch nhất; chi tiết nhất\n- **ISO cao** (1600+): Điều kiện ánh sáng thấp; tạo nhiễu kỹ thuật số (hạt)\n\n## Nguyên Tắc Bố Cục\n\n| Nguyên Tắc | Ứng Dụng |\n|---|---|\n| **Quy Tắc Một Phần Ba** | Chia khung thành 9 phần; đặt chủ thể tại các giao điểm |\n| **Đường Dẫn** | Đường, sông, hàng rào hướng dẫn mắt về phía chủ thể |\n| **Khung Cảnh** | Sử dụng yếu tố tiền cảnh để khung chủ thể |\n| **Chiều Sâu** | Tiền cảnh, trung cảnh, hậu cảnh tạo cảm giác 3D |\n| **Không Gian Âm** | Không gian trống quanh chủ thể tạo không gian thở và nhấn mạnh |\n| **Đối Xứng** | Phản chiếu, tòa nhà — hoạt động tốt nhất với bố cục trung tâm |',
   '{}', 1),

  ((SELECT id FROM lesson WHERE slug = 'photography-fundamentals'),
   'key_points',
   'Photography Quick Reference',
   'Tham Khảo Nhanh Nhiếp Ảnh',
   E'- **Aperture**: Smaller f-number = larger opening = more light + shallower depth of field (f/1.8 = portrait blur; f/16 = sharp landscape)\n- **Shutter speed**: Fast (1/1000s+) = frozen motion; slow (1/30s–) = motion blur\n- **ISO**: Lower = cleaner image; higher = more light sensitivity + more noise/grain\n- **Exposure triangle**: Any change to one setting requires compensating with another\n- **Rule of thirds**: Place key subjects at grid intersections, not dead center\n- **Leading lines**: Use natural lines (roads, rivers) to draw the eye toward the subject\n- **Depth of field** depends on: aperture (f-number) + focal length + distance to subject\n- **Bokeh**: Shallow DOF with fast lens (f/1.2–f/2) creates pleasing background blur\n- Camera records light — photography is fundamentally about seeing and controlling light, not just pointing and shooting',
   E'- **Khẩu độ**: Số f nhỏ hơn = độ mở lớn hơn = nhiều ánh sáng + chiều sâu trường ảnh nông hơn\n- **Tốc độ màn trập**: Nhanh (1/1000s+) = chuyển động đóng băng; chậm (1/30s–) = mờ chuyển động\n- **ISO**: Thấp hơn = ảnh sạch hơn; cao hơn = độ nhạy sáng hơn + nhiều nhiễu/hạt hơn\n- **Tam giác phơi sáng**: Bất kỳ thay đổi nào với một thiết lập đều cần bù với thiết lập khác\n- **Quy tắc một phần ba**: Đặt chủ thể tại các giao điểm lưới, không phải trung tâm\n- **Đường dẫn**: Sử dụng các đường tự nhiên (đường, sông) để kéo mắt về phía chủ thể\n- **Chiều sâu trường ảnh** phụ thuộc vào: khẩu độ (số f) + tiêu cự + khoảng cách đến chủ thể\n- **Bokeh**: Chiều sâu nông với ống kính nhanh (f/1.2–f/2) tạo ra mờ nền đẹp mắt',
   '{}', 2),

  ((SELECT id FROM lesson WHERE slug = 'photography-fundamentals'),
   'info_box',
   'Henri Cartier-Bresson and "The Decisive Moment"',
   'Henri Cartier-Bresson và "Khoảnh Khắc Quyết Định"',
   E'French photographer Henri Cartier-Bresson (1908–2004) is considered the father of modern photojournalism and a master of "street photography." He introduced the concept of **"The Decisive Moment"** (L''instant décisif) — the perfect alignment of form, content, and timing that makes a photograph transcendent.\n\n"Photography is not like painting. There is a creative fraction of a second when you are taking a picture. Your eye must see a composition or an expression that life itself offers you, and you must know with intuition when to click the camera."\n\nCartier-Bresson used a small Leica camera that allowed him to be unobtrusive. He never cropped his photos — everything was composed through the viewfinder. His images capture geometry and human emotion simultaneously, finding visual order in spontaneous life.',
   E'Nhiếp ảnh gia người Pháp Henri Cartier-Bresson (1908–2004) được coi là cha đẻ của báo ảnh hiện đại và bậc thầy của "nhiếp ảnh đường phố." Ông giới thiệu khái niệm **"Khoảnh Khắc Quyết Định"** (L''instant décisif) — sự căn chỉnh hoàn hảo của hình thức, nội dung và thời điểm làm cho một bức ảnh trở nên siêu việt.\n\n"Nhiếp ảnh không giống hội họa. Có một phần giây sáng tạo khi bạn chụp ảnh. Mắt bạn phải thấy một bố cục hoặc một biểu cảm mà chính cuộc sống cung cấp cho bạn, và bạn phải biết bằng trực giác khi nào nên bấm máy."\n\nCartier-Bresson sử dụng máy ảnh Leica nhỏ cho phép ông không bị chú ý. Ông không bao giờ cắt xén ảnh của mình — mọi thứ đều được bố cục qua kính ngắm.',
   '{"variant": "tip"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'photography-fundamentals'),
   'multiple_choice', 'easy',
   'A photographer wants to photograph a running athlete and completely freeze their motion. Which shutter speed should they use?',
   'Một nhiếp ảnh gia muốn chụp ảnh một vận động viên đang chạy và hoàn toàn đóng băng chuyển động của họ. Họ nên sử dụng tốc độ màn trập nào?',
   'D',
   '1/2000s freezes fast motion. At 1/2000s, the sensor is exposed for only 0.0005 seconds — too brief for a running athlete to create blur. 1/60s would create significant blur for a running person. 1/15s would create extreme blur. 1/500s might freeze slower subjects but could still show blur for very fast motion.',
   '1/2000s đóng băng chuyển động nhanh. Ở 1/2000s, cảm biến chỉ tiếp xúc trong 0,0005 giây — quá ngắn để một vận động viên đang chạy tạo ra mờ. 1/60s sẽ tạo ra mờ đáng kể cho người đang chạy.',
   1),
  ((SELECT id FROM lesson WHERE slug = 'photography-fundamentals'),
   'true_false', 'easy',
   'In photography, a smaller f-number (like f/1.8) means a smaller aperture opening, which allows less light to reach the camera sensor.',
   'Trong nhiếp ảnh, số f nhỏ hơn (như f/1.8) có nghĩa là độ mở khẩu độ nhỏ hơn, cho phép ít ánh sáng hơn đến cảm biến máy ảnh.',
   'false',
   'False — this is the most common source of confusion in photography. Smaller f-number = LARGER aperture opening = MORE light. The f-number is a fraction (f/1.8 means focal length divided by 1.8 — a large opening). f/16 means focal length divided by 16 — a tiny opening. So f/1.8 lets in far more light than f/16.',
   'Sai — đây là nguồn nhầm lẫn phổ biến nhất trong nhiếp ảnh. Số f nhỏ hơn = Độ mở khẩu độ LỚN HƠN = Nhiều ánh sáng HƠN. Số f là một phân số (f/1.8 có nghĩa là tiêu cự chia cho 1,8 — một độ mở lớn). f/16 có nghĩa là tiêu cự chia cho 16 — một độ mở nhỏ bé.',
   2),
  ((SELECT id FROM lesson WHERE slug = 'photography-fundamentals'),
   'fill_blank', 'easy',
   'The photography composition guideline that suggests placing key subjects at the intersections of a 3×3 grid rather than dead center is called the rule of ___.',
   'Hướng dẫn bố cục nhiếp ảnh đề nghị đặt các chủ thể chính tại các giao điểm của lưới 3×3 thay vì chính giữa được gọi là quy tắc ___.',
   'thirds',
   'The rule of thirds is one of the most fundamental composition guidelines. Dividing the frame into a 3×3 grid creates four intersection points ("power points") where the eye naturally wants to rest. Placing subjects at these points creates more dynamic, visually interesting images than centering everything.',
   'Quy tắc một phần ba là một trong những hướng dẫn bố cục cơ bản nhất. Chia khung thành lưới 3×3 tạo ra bốn điểm giao nhau ("điểm sức mạnh") nơi mắt tự nhiên muốn dừng lại. Đặt chủ thể tại các điểm này tạo ra hình ảnh năng động, thú vị thị giác hơn là căn giữa mọi thứ.',
   3),
  ((SELECT id FROM lesson WHERE slug = 'photography-fundamentals'),
   'multiple_choice', 'medium',
   'A photographer shoots at f/1.8 with a 50mm lens close to their subject. The background is beautifully blurred. What is the primary reason for this blurry background effect?',
   'Một nhiếp ảnh gia chụp ở f/1.8 với ống kính 50mm gần chủ thể của họ. Nền mờ đẹp mắt. Lý do chính cho hiệu ứng nền mờ này là gì?',
   'A',
   'The wide aperture (f/1.8 = large opening) creates very shallow depth of field, meaning only objects at the focused distance are sharp — everything in front and behind falls out of focus (bokeh). This effect is amplified by being close to the subject and using a longer focal length. It is used extensively in portrait photography to isolate subjects from distracting backgrounds.',
   'Khẩu độ rộng (f/1.8 = độ mở lớn) tạo ra chiều sâu trường ảnh rất nông, có nghĩa là chỉ các vật thể ở khoảng cách tập trung mới sắc nét — mọi thứ phía trước và phía sau đều mất nét (bokeh). Hiệu ứng này được khuếch đại bởi việc ở gần chủ thể. Nó được sử dụng rộng rãi trong nhiếp ảnh chân dung.',
   4),
  ((SELECT id FROM lesson WHERE slug = 'photography-fundamentals'),
   'error_correction', 'medium',
   'Correct this statement: "Increasing ISO always improves photo quality because it makes the camera more sensitive to light, resulting in brighter and more detailed images in any situation."',
   'Sửa câu này: "Tăng ISO luôn cải thiện chất lượng ảnh vì nó làm cho máy ảnh nhạy cảm hơn với ánh sáng, dẫn đến hình ảnh sáng hơn và chi tiết hơn trong mọi tình huống."',
   'Increasing ISO makes the sensor more sensitive to light and produces brighter images in low-light situations, but it does NOT always improve quality — higher ISO introduces digital noise (grain), reduces dynamic range, and lowers image sharpness. The base ISO (usually 100) always produces the cleanest, highest-quality image. ISO should be raised only when necessary to achieve proper exposure when aperture and shutter speed cannot be adjusted further.',
   'The statement omits the critical trade-off: ISO sensitivity comes at the cost of image quality. Noise (random pixel variation) increases with ISO, causing a grainy, speckled appearance. Modern cameras handle high ISO better than older ones, but no camera eliminates noise entirely at extreme ISOs (6400+). Good photographers prefer to use low ISO (100–400) whenever lighting allows, raising ISO only as a last resort.',
   'Câu này bỏ qua sự đánh đổi quan trọng: độ nhạy ISO đến với chi phí là chất lượng hình ảnh. Nhiễu (biến động pixel ngẫu nhiên) tăng theo ISO, gây ra vẻ ngoài hạt, đốm. Nhiếp ảnh gia giỏi thích sử dụng ISO thấp (100–400) khi ánh sáng cho phép, tăng ISO chỉ như phương án cuối cùng.',
   5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'photography-fundamentals') AND order_index = 1),
   'A', '1/30s', '1/30s'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'photography-fundamentals') AND order_index = 1),
   'B', '1/125s', '1/125s'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'photography-fundamentals') AND order_index = 1),
   'C', '1/500s', '1/500s'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'photography-fundamentals') AND order_index = 1),
   'D', '1/2000s', '1/2000s'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'photography-fundamentals') AND order_index = 4),
   'A', 'The wide aperture (f/1.8) creates shallow depth of field, blurring objects not at the focused distance', 'Khẩu độ rộng (f/1.8) tạo ra chiều sâu trường ảnh nông, làm mờ các vật thể không ở khoảng cách tập trung'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'photography-fundamentals') AND order_index = 4),
   'B', 'The high shutter speed freezes all motion including background elements', 'Tốc độ màn trập cao đóng băng tất cả chuyển động bao gồm các yếu tố nền'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'photography-fundamentals') AND order_index = 4),
   'C', 'The low ISO setting reduces the camera''s ability to capture background detail', 'Cài đặt ISO thấp làm giảm khả năng của máy ảnh để nắm bắt chi tiết nền'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'photography-fundamentals') AND order_index = 4),
   'D', 'The 50mm focal length is specifically designed to create background blur in portraits', 'Tiêu cự 50mm được thiết kế đặc biệt để tạo mờ nền trong ảnh chân dung');

-- ============================================================
-- LESSON 12: Film Language and Cinematography
-- Category: Photography & Film (order 2)
-- ============================================================

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Film Language and Cinematography',
  'Ngôn Ngữ Điện Ảnh và Quay Phim',
  'film-language-cinematography',
  'Decode how filmmakers use shot types, camera movement, editing, and lighting to tell stories visually.',
  'Giải mã cách nhà làm phim sử dụng các loại cảnh quay, chuyển động máy ảnh, dựng phim và chiếu sáng để kể chuyện thị giác.',
  'beginner', 45, 2
FROM category WHERE name = 'Photography & Film';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'film-language-cinematography'),
   'Identify and explain major shot types and their emotional effects',
   'Nhận biết và giải thích các loại cảnh quay chính và tác động cảm xúc của chúng',
   'Master the vocabulary of shots from extreme close-up to extreme wide, and understand why directors choose each type.',
   'Nắm vững từ vựng của các cảnh từ cận cảnh cực độ đến toàn cảnh cực độ, và hiểu tại sao đạo diễn chọn từng loại.', 1),
  ((SELECT id FROM lesson WHERE slug = 'film-language-cinematography'),
   'Explain editing principles including the 180-degree rule and continuity editing',
   'Giải thích các nguyên tắc dựng phim bao gồm quy tắc 180 độ và dựng liên tục',
   'Understand how editing creates meaning through cuts, pacing, and the Kuleshov effect.',
   'Hiểu cách dựng phim tạo ra ý nghĩa thông qua cắt, nhịp độ và hiệu ứng Kuleshov.', 2),
  ((SELECT id FROM lesson WHERE slug = 'film-language-cinematography'),
   'Analyze how lighting schemes create mood and meaning in cinema',
   'Phân tích cách sơ đồ chiếu sáng tạo ra tâm trạng và ý nghĩa trong điện ảnh',
   'Distinguish three-point lighting, low-key (noir), and high-key lighting, and connect each to genre conventions.',
   'Phân biệt chiếu sáng ba điểm, chiếu sáng thấp (noir) và chiếu sáng cao, và kết nối mỗi loại với quy ước thể loại.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'film-language-cinematography'),
   'markdown',
   'The Grammar of Film',
   'Ngữ Pháp Điện Ảnh',
   E'## Shot Types (Framing)\n\n| Shot | Description | Typical Use |\n|---|---|---|\n| **Extreme Wide Shot (EWS)** | Subject tiny in vast environment | Establish scale, isolation |\n| **Wide Shot (WS)** | Full body + environment | Establish location, action |\n| **Medium Wide Shot** | Knees to above head | Group shots, action |\n| **Medium Shot (MS)** | Waist up | Standard dialogue |\n| **Medium Close-Up (MCU)** | Chest to head | Conversation, reaction |\n| **Close-Up (CU)** | Face fills frame | Emotion, intimacy |\n| **Extreme Close-Up (ECU)** | One feature (eye, lips, hands) | Tension, detail, obsession |\n| **Over-the-Shoulder (OTS)** | Shot over one character''s shoulder at another | Conversation, relationship |\n| **Point of View (POV)** | Camera = character''s eyes | Subjectivity, audience identification |\n\n## Camera Angles\n- **Eye level**: Neutral, observational — equal relationship with subject\n- **Low angle** (camera below subject): Subject appears powerful, dominant, threatening\n- **High angle** (camera above subject): Subject appears small, vulnerable, powerless\n- **Dutch angle** (tilted): Unease, disorientation, psychological tension\n- **Bird''s eye/Top-down**: God-like perspective; subject dehumanized or placed in context\n\n## Camera Movement\n| Movement | Technique | Effect |\n|---|---|---|\n| **Pan** | Rotate camera horizontally on fixed axis | Follow action, reveal space |\n| **Tilt** | Rotate camera vertically on fixed axis | Reveal height, power |\n| **Dolly** | Camera physically moves on tracks | Smooth, intimate approach/retreat |\n| **Zoom** | Lens focal length changes | Artificial, distancing effect |\n| **Tracking/Steadicam** | Camera follows subject smoothly | Immersive, continuous |\n| **Handheld** | Camera operator holds camera | Urgency, chaos, documentary feel |\n| **Crane/Drone** | Camera on elevated mechanical arm | Sweeping, majestic reveals |\n\n## Editing\n\n**The Kuleshov Effect** (1920s Soviet experiment): Audiences attributed different emotions to the same actor''s neutral face depending on what was cut immediately before it (bowl of soup = hunger; coffin = grief; woman = desire). Meaning is created IN THE CUT, not in individual shots.\n\n**The 180-Degree Rule**: In a dialogue scene, an imaginary "line of action" is drawn between characters. Both camera positions must stay on the SAME SIDE of this line to maintain consistent screen direction. Crossing the line (a "jump cut" in position) disorients the viewer.\n\n**Continuity Editing**: Hollywood''s dominant style — invisible editing that serves story:\n- Match on action: Cut while action is in motion (character reaching → cut to hand grasping)\n- Eyeline match: Character looks at something → cut to what they see\n- 30-degree rule: Camera positions must differ by at least 30° to avoid a jump cut\n\n## Lighting\n\n| Style | Description | Genre/Mood |\n|---|---|---|\n| **Three-Point Lighting** | Key (main), fill (shadows), backlight (separation) | Standard drama, interviews |\n| **High-Key** | Bright, minimal shadows, low contrast | Comedy, musicals, commercials |\n| **Low-Key (Noir)** | Deep shadows, high contrast, chiaroscuro | Thriller, horror, noir |\n| **Rembrandt** | Triangle of light on shadowed cheek | Dramatic portraits, historical films |',
   E'## Các Loại Cảnh Quay (Đóng Khung)\n\n| Cảnh | Mô Tả | Sử Dụng Điển Hình |\n|---|---|---|\n| **Toàn Cảnh Cực Độ** | Chủ thể nhỏ trong môi trường rộng lớn | Thiết lập quy mô, cô lập |\n| **Toàn Cảnh** | Toàn thân + môi trường | Thiết lập địa điểm, hành động |\n| **Cảnh Trung Bình** | Thắt lưng trở lên | Đối thoại tiêu chuẩn |\n| **Cận Cảnh** | Khuôn mặt lấp đầy khung | Cảm xúc, thân mật |\n| **Cận Cảnh Cực Độ** | Một đặc điểm (mắt, môi, tay) | Căng thẳng, chi tiết, ám ảnh |\n| **Qua Vai (OTS)** | Cảnh qua vai một nhân vật về phía nhân vật khác | Cuộc trò chuyện, mối quan hệ |\n| **Điểm Nhìn (POV)** | Máy ảnh = mắt nhân vật | Chủ quan, nhận dạng khán giả |\n\n## Góc Máy\n- **Ngang tầm mắt**: Trung tính, quan sát — quan hệ bình đẳng với chủ thể\n- **Góc thấp**: Chủ thể xuất hiện mạnh mẽ, thống trị, đe dọa\n- **Góc cao**: Chủ thể xuất hiện nhỏ bé, dễ bị tổn thương, không có quyền lực\n- **Góc nghiêng (Dutch)**: Bất an, mất phương hướng, căng thẳng tâm lý\n\n## Dựng Phim\n\n**Hiệu Ứng Kuleshov** (thí nghiệm Xô viết 1920s): Khán giả gán các cảm xúc khác nhau cho cùng một khuôn mặt trung tính của diễn viên tùy thuộc vào những gì được cắt ngay trước đó. Ý nghĩa được tạo ra TRONG VẾT CẮT, không phải trong các cảnh riêng lẻ.\n\n**Quy Tắc 180 Độ**: Trong cảnh đối thoại, một "đường hành động" tưởng tượng được vẽ giữa các nhân vật. Cả hai vị trí máy ảnh phải ở CÙNG MỘT BÊN của đường này để duy trì hướng màn hình nhất quán.\n\n## Chiếu Sáng\n\n| Phong Cách | Mô Tả | Thể Loại/Tâm Trạng |\n|---|---|---|\n| **Chiếu Sáng Ba Điểm** | Chìa khóa (chính), lấp đầy (bóng), đèn hậu (tách biệt) | Kịch tính tiêu chuẩn |\n| **Chiếu Sáng Cao** | Sáng, bóng tối tối thiểu | Hài kịch, nhạc kịch, quảng cáo |\n| **Chiếu Sáng Thấp (Noir)** | Bóng tối sâu, tương phản cao | Thriller, kinh dị, noir |',
   '{}', 1),

  ((SELECT id FROM lesson WHERE slug = 'film-language-cinematography'),
   'key_points',
   'Film Language Essentials',
   'Cơ Bản Ngôn Ngữ Điện Ảnh',
   E'- **Shot scale**: EWS (isolation) → WS (establish) → MS (dialogue) → CU (emotion) → ECU (obsession/detail)\n- **Low angle** = power/dominance; **high angle** = vulnerability/powerlessness; **Dutch tilt** = unease\n- **Kuleshov effect**: Meaning is created in the cut — the same shot gains different meaning depending on context\n- **180-degree rule**: Both cameras in a dialogue scene must stay on the same side of the action line\n- **Match on action**: Cut while action is in progress to create seamless visual continuity\n- **High-key lighting**: Comedy, commercials (bright, minimal shadows)\n- **Low-key lighting**: Thriller, noir (deep shadows, high contrast, chiaroscuro)\n- **Dolly vs zoom**: Dolly physically moves camera (natural perspective); zoom changes focal length (distortion effect)\n- Directors communicate emotion and meaning through EVERY choice: shot size, angle, movement, lighting — not just dialogue',
   E'- **Kích thước cảnh**: Toàn cảnh cực độ (cô lập) → Toàn cảnh (thiết lập) → Trung cảnh (đối thoại) → Cận cảnh (cảm xúc) → Cực cận (ám ảnh/chi tiết)\n- **Góc thấp** = quyền lực/thống trị; **góc cao** = dễ bị tổn thương/không có quyền lực; **góc nghiêng** = bất an\n- **Hiệu ứng Kuleshov**: Ý nghĩa được tạo ra trong vết cắt — cùng một cảnh có ý nghĩa khác nhau tùy thuộc vào bối cảnh\n- **Quy tắc 180 độ**: Cả hai máy ảnh trong cảnh đối thoại phải ở cùng một bên của đường hành động\n- **Kết hợp hành động**: Cắt trong khi hành động đang diễn ra để tạo ra sự liên tục thị giác liền mạch\n- **Chiếu sáng cao**: Hài kịch, quảng cáo (sáng, bóng tối tối thiểu)\n- **Chiếu sáng thấp**: Thriller, noir (bóng tối sâu, tương phản cao)',
   '{}', 2),

  ((SELECT id FROM lesson WHERE slug = 'film-language-cinematography'),
   'info_box',
   'The Kuleshov Effect: Editing Creates Reality',
   'Hiệu Ứng Kuleshov: Dựng Phim Tạo Ra Thực Tại',
   E'Soviet filmmaker Lev Kuleshov (1899–1970) demonstrated one of cinema''s most profound principles in the early 1920s. He took footage of actor Ivan Mozzhukhin with a perfectly neutral expression and intercut it with three different images:\n1. A bowl of soup (on a table)\n2. A girl in a coffin\n3. A woman reclining on a sofa\n\nAudiences praised Mozzhukhin''s brilliant acting — describing his expression as: hungry (soup), grieving (coffin), and lustful (woman). But the actor''s expression was IDENTICAL in all three cases.\n\n**The lesson**: Meaning in cinema is not in individual shots but in the RELATIONSHIP between shots. This is why editing is considered the most powerful tool in the filmmaker''s arsenal — an editor can make you feel things the original footage never contained.',
   E'Nhà làm phim Xô viết Lev Kuleshov (1899–1970) đã chứng minh một trong những nguyên tắc sâu sắc nhất của điện ảnh vào đầu những năm 1920. Ông lấy cảnh quay diễn viên Ivan Mozzhukhin với biểu cảm hoàn toàn trung tính và xen kẽ với ba hình ảnh khác nhau:\n1. Một bát súp (trên bàn)\n2. Một bé gái trong quan tài\n3. Một người phụ nữ nằm nghiêng trên ghế sofa\n\nKhán giả ca ngợi diễn xuất xuất sắc của Mozzhukhin — mô tả biểu cảm của anh là: đói (súp), đau buồn (quan tài) và ham muốn (người phụ nữ). Nhưng biểu cảm của diễn viên hoàn toàn GIỐNG NHAU trong cả ba trường hợp.\n\n**Bài học**: Ý nghĩa trong điện ảnh không nằm trong các cảnh riêng lẻ mà trong MỐI QUAN HỆ giữa các cảnh. Đây là lý do tại sao dựng phim được coi là công cụ mạnh nhất trong kho vũ khí của nhà làm phim.',
   '{"variant": "tip"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'film-language-cinematography'),
   'multiple_choice', 'easy',
   'A director films a villain''s face from a low camera angle, looking up at them. What emotional effect does this typically create?',
   'Một đạo diễn quay khuôn mặt của nhân vật phản diện từ góc máy thấp, nhìn lên phía họ. Điều này thường tạo ra hiệu ứng cảm xúc gì?',
   'B',
   'Low-angle shots place the camera below the subject, making the viewer look up at them. This creates a sense of power, dominance, and threat. Villains, authority figures, and powerful characters are frequently shot from low angles to amplify their menace. The opposite — high-angle shots — make subjects appear small and vulnerable.',
   'Cảnh góc thấp đặt máy ảnh bên dưới chủ thể, khiến người xem nhìn lên phía họ. Điều này tạo ra cảm giác quyền lực, thống trị và đe dọa. Nhân vật phản diện, nhân vật có thẩm quyền thường được quay từ góc thấp để khuếch đại sự đáng sợ của họ.',
   1),
  ((SELECT id FROM lesson WHERE slug = 'film-language-cinematography'),
   'true_false', 'easy',
   'The Kuleshov Effect demonstrates that the meaning audiences derive from an actor''s expression is determined entirely by the actor''s performance, independent of editing context.',
   'Hiệu ứng Kuleshov chứng minh rằng ý nghĩa khán giả thu được từ biểu cảm của diễn viên được xác định hoàn toàn bởi màn trình diễn của diễn viên, độc lập với bối cảnh dựng phim.',
   'false',
   'False — the Kuleshov Effect demonstrates the OPPOSITE. The same neutral actor expression was interpreted as hunger, grief, or lust depending entirely on which image was cut before it. Meaning is created in the RELATIONSHIP between shots (in the edit), not inherent in a single shot. This proved that editing itself is a fundamental tool of cinematic storytelling.',
   'Sai — Hiệu ứng Kuleshov chứng minh ĐIỀU NGƯỢC LẠI. Cùng biểu cảm diễn viên trung tính được diễn giải là đói, đau buồn hoặc ham muốn tùy thuộc hoàn toàn vào hình ảnh nào được cắt trước đó. Ý nghĩa được tạo ra trong MỐI QUAN HỆ giữa các cảnh, không vốn có trong một cảnh đơn lẻ.',
   2),
  ((SELECT id FROM lesson WHERE slug = 'film-language-cinematography'),
   'fill_blank', 'easy',
   'The editing rule that states both cameras in a dialogue scene must remain on the same side of an imaginary line drawn between characters is called the ___ rule.',
   'Quy tắc dựng phim quy định rằng cả hai máy ảnh trong cảnh đối thoại phải ở cùng một bên của đường tưởng tượng được vẽ giữa các nhân vật được gọi là quy tắc ___.',
   '180-degree',
   'The 180-degree rule (also called the "axis of action" rule) is a fundamental continuity editing convention. If the camera crosses the imaginary line between characters, the spatial relationship appears to reverse on screen — characters appear to switch sides, disorienting viewers. Breaking this rule is called "crossing the line" and is avoided in classical Hollywood editing.',
   'Quy tắc 180 độ (còn gọi là quy tắc "trục hành động") là quy ước dựng phim liên tục cơ bản. Nếu máy ảnh vượt qua đường tưởng tượng giữa các nhân vật, mối quan hệ không gian xuất hiện để đảo ngược trên màn hình. Phá vỡ quy tắc này được gọi là "vượt đường" và tránh trong dựng phim Hollywood cổ điển.',
   3),
  ((SELECT id FROM lesson WHERE slug = 'film-language-cinematography'),
   'multiple_choice', 'medium',
   'A horror film uses deep shadows, high contrast, and isolated pools of light, leaving large portions of the frame in darkness. This lighting approach is best described as:',
   'Một bộ phim kinh dị sử dụng bóng tối sâu, tương phản cao và các vũng ánh sáng cô lập, để lại những phần lớn của khung trong bóng tối. Cách tiếp cận chiếu sáng này được mô tả tốt nhất là:',
   'C',
   'Low-key lighting is characterized by deep shadows, high contrast, and small areas of light against large dark areas. It creates mystery, danger, and psychological tension — ideal for horror, thriller, and film noir. High-key lighting (the opposite) is bright with minimal shadows, used in comedy and musicals. Three-point lighting is the neutral standard. Rembrandt lighting is a portrait technique.',
   'Chiếu sáng thấp được đặc trưng bởi bóng tối sâu, tương phản cao và các khu vực ánh sáng nhỏ so với các khu vực tối lớn. Nó tạo ra bí ẩn, nguy hiểm và căng thẳng tâm lý — lý tưởng cho kinh dị, thriller và film noir. Chiếu sáng cao (ngược lại) sáng với bóng tối tối thiểu, dùng trong hài kịch và nhạc kịch.',
   4),
  ((SELECT id FROM lesson WHERE slug = 'film-language-cinematography'),
   'error_correction', 'medium',
   'Correct this statement: "A zoom shot and a dolly shot achieve the same visual result — both bring the subject closer or further from the viewer, creating identical cinematic effects."',
   'Sửa câu này: "Cảnh zoom và cảnh dolly đạt được cùng kết quả thị giác — cả hai đưa chủ thể gần hơn hoặc xa hơn với người xem, tạo ra hiệu ứng điện ảnh giống hệt nhau."',
   'Zoom and dolly create different visual effects. A dolly physically moves the camera — objects change size naturally as you approach. A zoom only changes focal length without movement — depth compresses or expands unnaturally. Hitchcock combined both (the Dolly zoom in Vertigo) to create psychological disorientation.',
   'The statement confuses two mechanically different techniques with distinct visual consequences. Dolly = physical movement = constant focal length = natural object growth as you approach. Zoom = focal length change = no physical movement = artificially compresses/expands depth. The Dolly-Zoom (Hitchcock in "Vertigo") combines both in opposite directions — the midground stays fixed while the background contracts or expands unnervingly.',
   'Câu này nhầm lẫn hai kỹ thuật về mặt cơ học khác nhau với những hệ quả thị giác khác nhau. Dolly = chuyển động vật lý = tỷ lệ tiêu cự không đổi = tăng trưởng tự nhiên của vật thể khi tiếp cận. Zoom = thay đổi tiêu cự = không có chuyển động vật lý = nén/mở rộng chiều sâu một cách giả tạo. Hiệu ứng Dolly-Zoom (Hitchcock trong "Vertigo") kết hợp cả hai ngược chiều nhau — trung cảnh vẫn cố định trong khi nền co lại hoặc mở rộng một cách kỳ lạ.',
   5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'film-language-cinematography') AND order_index = 1),
   'A', 'The villain appears small and vulnerable, evoking sympathy from the audience', 'Nhân vật phản diện xuất hiện nhỏ bé và dễ bị tổn thương, gợi lên sự đồng cảm từ khán giả'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'film-language-cinematography') AND order_index = 1),
   'B', 'The villain appears powerful, dominant, and threatening', 'Nhân vật phản diện xuất hiện mạnh mẽ, thống trị và đe dọa'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'film-language-cinematography') AND order_index = 1),
   'C', 'The villain appears disoriented and psychologically unstable', 'Nhân vật phản diện xuất hiện mất phương hướng và không ổn định về mặt tâm lý'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'film-language-cinematography') AND order_index = 1),
   'D', 'The villain appears distant and emotionally detached from events', 'Nhân vật phản diện xuất hiện xa cách và tách biệt về mặt cảm xúc với các sự kiện'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'film-language-cinematography') AND order_index = 4),
   'A', 'High-key lighting — bright, minimal shadows, low contrast', 'Chiếu sáng cao — sáng, bóng tối tối thiểu, tương phản thấp'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'film-language-cinematography') AND order_index = 4),
   'B', 'Three-point lighting — standard dramatic illumination with key, fill, and backlight', 'Chiếu sáng ba điểm — chiếu sáng kịch tính tiêu chuẩn với chìa khóa, lấp đầy và đèn hậu'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'film-language-cinematography') AND order_index = 4),
   'C', 'Low-key lighting — deep shadows, high contrast, darkness-dominant composition', 'Chiếu sáng thấp — bóng tối sâu, tương phản cao, bố cục bóng tối chiếm ưu thế'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'film-language-cinematography') AND order_index = 4),
   'D', 'Rembrandt lighting — triangle of light on the shadowed cheek for dramatic portraits', 'Chiếu sáng Rembrandt — tam giác ánh sáng trên má trong bóng tối cho ảnh chân dung ấn tượng');
