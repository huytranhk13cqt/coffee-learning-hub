-- =============================================================================
-- Seed: Science & Nature New Categories
-- Categories: Astronomy & Space, Environmental Science,
--             Agriculture & Botany, Urban Farming
-- =============================================================================

-- =============================================================================
-- CATEGORY: Astronomy & Space
-- =============================================================================

-- Lesson 1: The Universe and Our Solar System
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'The Universe and Our Solar System', 'Vũ Trụ và Hệ Mặt Trời', 'universe-solar-system',
  'Explore the scale, structure, and wonders of our solar system and universe.',
  'Khám phá quy mô, cấu trúc và những kỳ quan của hệ mặt trời và vũ trụ.',
  'beginner', 35, 1
FROM category WHERE name = 'Astronomy & Space';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'universe-solar-system'),
 'Understanding cosmic scale', 'Hiểu quy mô vũ trụ',
 'Grasping that light from Andromeda takes 2.5 million years to reach us.',
 'Nắm bắt rằng ánh sáng từ Andromeda mất 2.5 triệu năm để đến được chúng ta.', 1),
((SELECT id FROM lesson WHERE slug = 'universe-solar-system'),
 'Planetary science', 'Khoa học hành tinh',
 'Understanding why Venus is hotter than Mercury despite being farther from the Sun.',
 'Hiểu tại sao Sao Kim nóng hơn Sao Thủy dù ở xa Mặt Trời hơn.', 2),
((SELECT id FROM lesson WHERE slug = 'universe-solar-system'),
 'Space exploration context', 'Bối cảnh khám phá không gian',
 'Understanding what makes Mars a candidate for human colonization.',
 'Hiểu điều gì làm Sao Hỏa trở thành ứng cử viên cho thuộc địa hóa của con người.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'universe-solar-system'),
 'markdown', 'Our Place in the Universe', 'Vị Trí Của Chúng Ta Trong Vũ Trụ',
 E'## The Scale of the Universe\n\nUniverse → Filaments → Galaxy Clusters → Galaxies → Star Systems → Planets\n\n### Our Solar System\n\n**The Sun**: 99.86% of all solar system mass. 1.4 million km diameter (109 Earths).\n\n| Planet | Type | Key Feature |\n|--------|------|-------------|\n| Mercury | Rocky | No atmosphere, extreme temperatures |\n| Venus | Rocky | Runaway greenhouse effect (462°C) |\n| Earth | Rocky | Liquid water, life |\n| Mars | Rocky | Thin CO₂ atmosphere, ice caps, Olympus Mons |\n| Jupiter | Gas giant | Great Red Spot, 95 moons, 318× Earth mass |\n| Saturn | Gas giant | Ring system, least dense planet |\n| Uranus | Ice giant | Rotates on its side (98° axial tilt) |\n| Neptune | Ice giant | Strongest winds in solar system (2,100 km/h) |\n\n### Cosmic Distances\n\n- **Astronomical Unit (AU)**: Earth-Sun distance = 150 million km\n- **Light year**: Distance light travels in 1 year ≈ 9.46 × 10¹² km\n- Nearest star (Proxima Centauri): **4.24 light-years** away\n- Milky Way diameter: **100,000 light-years**\n- Observable universe: **93 billion light-years** in diameter\n\n### The Greenhouse Effect — Venus vs Mars\n\n- **Venus**: Dense CO₂ atmosphere traps heat → 462°C surface (hotter than Mercury!)\n- **Mars**: Thin atmosphere → no heat retention → average -63°C\n- **Earth**: Goldilocks zone with moderate greenhouse effect → ~15°C',
 E'## Quy Mô Của Vũ Trụ\n\nVũ trụ → Sợi → Cụm thiên hà → Thiên hà → Hệ sao → Hành tinh\n\n### Hệ Mặt Trời Của Chúng Ta\n\n**Mặt Trời**: 99.86% tổng khối lượng hệ mặt trời. Đường kính 1.4 triệu km (109 Trái Đất).\n\n| Hành tinh | Loại | Đặc điểm chính |\n|-----------|------|----------------|\n| Sao Thủy | Đá | Không có khí quyển, nhiệt độ cực đoan |\n| Sao Kim | Đá | Hiệu ứng nhà kính mất kiểm soát (462°C) |\n| Trái Đất | Đá | Nước lỏng, sự sống |\n| Sao Hỏa | Đá | Khí quyển CO₂ mỏng, nắp băng, Olympus Mons |\n| Sao Mộc | Khí khổng lồ | Đốm Đỏ Lớn, 95 mặt trăng |\n| Sao Thổ | Khí khổng lồ | Hệ vòng đai, mật độ thấp nhất |\n| Sao Thiên Vương | Băng khổng lồ | Quay nghiêng 98° |\n| Sao Hải Vương | Băng khổng lồ | Gió mạnh nhất trong hệ mặt trời |\n\n### Khoảng Cách Vũ Trụ\n\n- **Đơn vị thiên văn (AU)**: Khoảng cách Trái Đất-Mặt Trời = 150 triệu km\n- **Năm ánh sáng**: Khoảng cách ánh sáng đi trong 1 năm ≈ 9.46 × 10¹² km\n- Ngân Hà: đường kính **100.000 năm ánh sáng**',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'universe-solar-system'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["The Sun contains 99.86% of solar system mass — planets are tiny by comparison", "Venus is hotter than Mercury (462°C) due to runaway greenhouse effect from dense CO₂ atmosphere", "1 light-year ≈ 9.46 trillion km; nearest star is 4.24 light-years away", "Observable universe is 93 billion light-years wide — containing 200+ billion galaxies", "Jupiter has 95 moons and is 318 times Earth''s mass — more than all other planets combined"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'universe-solar-system'),
 'info_box', 'The Pale Blue Dot', 'Chấm Xanh Nhạt',
 'In 1990, Voyager 1 photographed Earth from 6 billion km away. Carl Sagan called it the "Pale Blue Dot": "Look again at that dot. That''s here. That''s home. That''s us." Earth appears as a fraction of a pixel against the vastness of space — the most humbling perspective in astronomy.',
 'Năm 1990, Voyager 1 chụp ảnh Trái Đất từ cách xa 6 tỷ km. Carl Sagan gọi nó là "Chấm Xanh Nhạt": "Nhìn lại chấm đó. Đó là đây. Đó là nhà. Đó là chúng ta." Trái Đất xuất hiện như một phần nhỏ của một điểm ảnh so với sự bao la của không gian — góc nhìn khiêm tốn nhất trong thiên văn học.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'universe-solar-system'),
 'multiple_choice', 'easy',
 'Why is Venus hotter than Mercury, despite being farther from the Sun?',
 'Tại sao Sao Kim nóng hơn Sao Thủy, mặc dù ở xa Mặt Trời hơn?',
 'B',
 'Venus has a dense CO₂ atmosphere that creates a powerful greenhouse effect, trapping solar heat. Surface temperature: 462°C. Mercury has almost no atmosphere, so heat escapes quickly. Despite being closer to the Sun, Mercury''s temperature swings wildly from 430°C (day) to -180°C (night). Venus''s greenhouse effect makes it hotter and more consistent.',
 'Sao Kim có khí quyển CO₂ dày đặc tạo ra hiệu ứng nhà kính mạnh mẽ, giữ nhiệt mặt trời. Nhiệt độ bề mặt: 462°C. Sao Thủy gần như không có khí quyển nên nhiệt thoát ra nhanh. Mặc dù gần Mặt Trời hơn, nhiệt độ của Sao Thủy dao động mạnh từ 430°C (ngày) đến -180°C (đêm).',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'universe-solar-system') AND order_index = 1),
 'A', 'Venus is larger and generates more internal heat', 'Sao Kim lớn hơn và tạo ra nhiều nhiệt nội bộ hơn'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'universe-solar-system') AND order_index = 1),
 'B', 'Venus has a dense CO₂ atmosphere causing a runaway greenhouse effect', 'Sao Kim có khí quyển CO₂ dày gây ra hiệu ứng nhà kính mất kiểm soát'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'universe-solar-system') AND order_index = 1),
 'C', 'Venus rotates faster, generating more friction heat', 'Sao Kim quay nhanh hơn, tạo ra nhiều nhiệt ma sát hơn'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'universe-solar-system') AND order_index = 1),
 'D', 'Venus reflects more sunlight back toward Mercury', 'Sao Kim phản chiếu nhiều ánh sáng mặt trời trở lại về phía Sao Thủy');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'universe-solar-system'),
 'fill_blank', 'easy',
 'The distance light travels in one year, approximately 9.46 trillion kilometers, is called a _____.',
 'Khoảng cách ánh sáng đi trong một năm, xấp xỉ 9.46 nghìn tỷ km, được gọi là _____.',
 'light-year',
 'A light-year is a unit of DISTANCE (not time), equal to ~9.46 × 10¹² km. It is used for astronomical distances because meters and kilometers are impractically small at cosmic scales. The nearest star system (Alpha Centauri) is 4.37 light-years away — sending a radio signal there takes 4.37 years at the speed of light.',
 'Năm ánh sáng là đơn vị KHOẢNG CÁCH (không phải thời gian), bằng ~9.46 × 10¹² km. Nó được sử dụng cho khoảng cách thiên văn vì mét và km quá nhỏ ở quy mô vũ trụ. Hệ sao gần nhất (Alpha Centauri) cách 4.37 năm ánh sáng — gửi tín hiệu vô tuyến đến đó mất 4.37 năm ở tốc độ ánh sáng.',
 2),
((SELECT id FROM lesson WHERE slug = 'universe-solar-system'),
 'true_false', 'easy',
 'Jupiter is the largest planet in our solar system and contains more mass than all other planets combined.',
 'Sao Mộc là hành tinh lớn nhất trong hệ mặt trời và chứa nhiều khối lượng hơn tất cả các hành tinh khác cộng lại.',
 'true',
 'Jupiter is 318 times Earth''s mass and more massive than all other planets in the solar system combined. Its enormous gravity has shaped the solar system — it deflects comets and asteroids, acting as a shield for the inner planets. Jupiter is a gas giant with 95 known moons (as of 2023), including four large Galilean moons.',
 'Sao Mộc có khối lượng gấp 318 lần Trái Đất và lớn hơn tất cả các hành tinh khác trong hệ mặt trời cộng lại. Lực hấp dẫn khổng lồ của nó đã định hình hệ mặt trời — nó lệch hướng sao chổi và tiểu hành tinh, hoạt động như một tấm khiên cho các hành tinh bên trong.',
 3),
((SELECT id FROM lesson WHERE slug = 'universe-solar-system'),
 'fill_blank', 'medium',
 'The standard unit of distance in the solar system, equal to the Earth-Sun distance of 150 million km, is the _____ Unit.',
 'Đơn vị khoảng cách tiêu chuẩn trong hệ mặt trời, bằng khoảng cách Trái Đất-Mặt Trời là 150 triệu km, là Đơn vị _____.',
 'Astronomical',
 'The Astronomical Unit (AU) is the average Earth-Sun distance (~149.6 million km). It simplifies solar system measurements: Mars is 1.52 AU, Jupiter is 5.2 AU, Neptune is 30 AU from the Sun. Voyager 1 is currently ~160 AU away — well beyond the solar system.',
 'Đơn vị Thiên văn (AU) là khoảng cách trung bình Trái Đất-Mặt Trời (~149.6 triệu km). Nó đơn giản hóa các phép đo hệ mặt trời: Sao Hỏa cách 1.52 AU, Sao Mộc 5.2 AU, Sao Hải Vương 30 AU từ Mặt Trời. Voyager 1 hiện cách ~160 AU — ngoài hệ mặt trời.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'universe-solar-system'),
 'arrange_words', 'medium',
 'Arrange to describe Earth''s position in the solar system.',
 'Sắp xếp để mô tả vị trí của Trái Đất trong hệ mặt trời.',
 'Earth is the third planet from the Sun in the habitable zone',
 '["habitable", "planet", "zone", "the", "third", "from", "Sun", "Earth", "in", "the", "is"]',
 'Earth is the third planet from the Sun, located in the "habitable zone" (also called the Goldilocks zone) — the range of distances where liquid water can exist on a planet''s surface. Too close = too hot (Venus), too far = too cold (Mars). Earth''s position, atmosphere, and geology have combined to support life for ~3.8 billion years.',
 'Trái Đất là hành tinh thứ ba từ Mặt Trời, nằm trong "vùng có thể ở được" (còn gọi là vùng Goldilocks) — phạm vi khoảng cách nơi nước lỏng có thể tồn tại trên bề mặt hành tinh. Quá gần = quá nóng (Sao Kim), quá xa = quá lạnh (Sao Hỏa).',
 5);

-- Lesson 2: Stars, Black Holes & Cosmology
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Stars, Black Holes & Cosmology', 'Các Ngôi Sao, Lỗ Đen & Vũ Trụ Học', 'stars-black-holes-cosmology',
  'Understand stellar evolution, black holes, and the origin of the universe.',
  'Hiểu sự tiến hóa của sao, lỗ đen và nguồn gốc của vũ trụ.',
  'intermediate', 45, 2
FROM category WHERE name = 'Astronomy & Space';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'stars-black-holes-cosmology'),
 'Understanding stellar origins', 'Hiểu nguồn gốc sao',
 'Knowing why "we are made of starstuff" — carbon, iron in our bodies came from supernovae.',
 'Biết tại sao "chúng ta được tạo ra từ vật liệu sao" — carbon, sắt trong cơ thể đến từ siêu tân tinh.', 1),
((SELECT id FROM lesson WHERE slug = 'stars-black-holes-cosmology'),
 'Cosmological perspective', 'Góc nhìn vũ trụ học',
 'Understanding the Big Bang and cosmic microwave background radiation as evidence.',
 'Hiểu Big Bang và bức xạ nền vi sóng vũ trụ như bằng chứng.', 2),
((SELECT id FROM lesson WHERE slug = 'stars-black-holes-cosmology'),
 'Black hole concepts', 'Khái niệm lỗ đen',
 'Understanding why information cannot escape a black hole''s event horizon.',
 'Hiểu tại sao thông tin không thể thoát khỏi chân trời sự kiện của lỗ đen.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'stars-black-holes-cosmology'),
 'markdown', 'From Big Bang to Black Holes', 'Từ Big Bang Đến Lỗ Đen',
 E'## The Life of Stars\n\n### Stellar Life Cycle\n\n```\nNebula → Protostar → Main Sequence Star\n                              ↓\n             [Low mass]              [High mass]\n          Red Giant              Red Supergiant\n             ↓                         ↓\n         Planetary              Supernova\n          Nebula                    ↓\n             ↓            Neutron Star or Black Hole\n         White Dwarf\n```\n\n### The Sun''s Fate\n\n- Currently: Main sequence (hydrogen fusion), ~4.6 billion years old, ~5 billion years left\n- Will expand to Red Giant (engulfing Mercury, Venus, possibly Earth)\n- Will shed outer layers → Planetary Nebula\n- Core will remain as White Dwarf (Earth-sized, Sun-mass)\n\n### Black Holes\n\n- Formed when massive stars (>20 solar masses) explode as supernovae\n- **Event Horizon**: the point of no return — escape velocity exceeds speed of light\n- **Schwarzschild Radius**: size of event horizon = 2GM/c²\n- **Hawking Radiation**: black holes slowly evaporate over astronomical timescales\n- Supermassive BHs (millions-billions of solar masses) reside at galaxy centers\n\n### The Big Bang & Cosmology\n\n- Universe began ~**13.8 billion years ago** from an extremely hot, dense state\n- Evidence: cosmic microwave background (CMB) radiation — "echo" of the Big Bang\n- Universe is expanding: galaxies moving away from each other (Hubble''s Law)\n- **Dark Matter**: 27% of universe — does not interact with light, inferred from gravitational effects\n- **Dark Energy**: 68% of universe — causes accelerating expansion (discovered 1998)',
 E'## Vòng Đời Của Các Ngôi Sao\n\n### Chu Kỳ Sống Của Sao\n\nTinh vân → Ngôi sao nguyên thủy → Sao chuỗi chính → [Sao khối lượng thấp: Sao khổng lồ đỏ → Tinh vân hành tinh → Sao lùn trắng] hoặc [Sao khối lượng cao: Sao siêu khổng lồ đỏ → Siêu tân tinh → Sao neutron/Lỗ đen]\n\n### Lỗ Đen\n\n- Hình thành khi các ngôi sao khổng lồ (>20 khối lượng mặt trời) nổ tung như siêu tân tinh\n- **Chân trời sự kiện**: điểm không thể quay lại — vận tốc thoát vượt quá tốc độ ánh sáng\n- **Bức xạ Hawking**: lỗ đen từ từ bay hơi theo thang thời gian thiên văn\n\n### Big Bang & Vũ Trụ Học\n\n- Vũ trụ bắt đầu ~**13.8 tỷ năm trước** từ trạng thái cực nóng, cực đặc\n- Bằng chứng: bức xạ nền vi sóng vũ trụ (CMB) — "tiếng vang" của Big Bang\n- **Vật chất tối**: 27% vũ trụ — **Năng lượng tối**: 68% vũ trụ',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'stars-black-holes-cosmology'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["Stellar life cycle: nebula → main sequence → red giant → white dwarf (low mass) OR supernova → black hole (high mass)", "Event horizon: boundary of a black hole where escape velocity = speed of light", "Big Bang: universe began 13.8 billion years ago; CMB radiation is the observational evidence", "Dark matter (27%) + dark energy (68%) = 95% of universe is unknown stuff", "All elements heavier than hydrogen were forged inside stars — we are literally made of stardust"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'stars-black-holes-cosmology'),
 'info_box', 'We Are Stardust', 'Chúng Ta Là Bụi Sao',
 'Every atom in your body heavier than hydrogen was created inside a star. Carbon in your DNA, iron in your blood, calcium in your bones — all forged in stellar nuclear furnaces and scattered by supernova explosions billions of years ago. As Carl Sagan said: "The cosmos is within us. We are made of star-stuff."',
 'Mỗi nguyên tử trong cơ thể bạn nặng hơn hydro được tạo ra bên trong một ngôi sao. Carbon trong DNA, sắt trong máu, canxi trong xương — tất cả được rèn trong lò hạt nhân sao và phân tán bởi vụ nổ siêu tân tinh hàng tỷ năm trước. Như Carl Sagan nói: "Vũ trụ ở trong chúng ta. Chúng ta được tạo ra từ vật liệu sao."',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'stars-black-holes-cosmology'),
 'multiple_choice', 'medium',
 'What is the event horizon of a black hole?',
 'Chân trời sự kiện của lỗ đen là gì?',
 'B',
 'The event horizon is the boundary around a black hole at which the escape velocity equals the speed of light. Nothing — not even light — can escape from within the event horizon. It is a "point of no return," not a physical surface. An object crossing the event horizon cannot communicate with the outside universe.',
 'Chân trời sự kiện là ranh giới xung quanh lỗ đen mà tại đó vận tốc thoát bằng tốc độ ánh sáng. Không có gì — ngay cả ánh sáng — không thể thoát khỏi trong chân trời sự kiện. Đó là "điểm không thể quay lại," không phải bề mặt vật lý.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'stars-black-holes-cosmology') AND order_index = 1),
 'A', 'The physical surface of the black hole', 'Bề mặt vật lý của lỗ đen'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'stars-black-holes-cosmology') AND order_index = 1),
 'B', 'The boundary beyond which nothing can escape, including light', 'Ranh giới mà từ đó không gì có thể thoát ra, kể cả ánh sáng'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'stars-black-holes-cosmology') AND order_index = 1),
 'C', 'The region where gravity is strongest inside the black hole', 'Vùng có trọng lực mạnh nhất bên trong lỗ đen'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'stars-black-holes-cosmology') AND order_index = 1),
 'D', 'The cloud of gas surrounding a black hole', 'Đám mây khí bao quanh lỗ đen');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'stars-black-holes-cosmology'),
 'fill_blank', 'medium',
 'The "echo" of the Big Bang — faint microwave radiation permeating all of space — is called Cosmic Microwave _____ radiation.',
 '"Tiếng vang" của Big Bang — bức xạ vi sóng mờ nhạt thấm khắp không gian — được gọi là bức xạ Nền Vi Sóng Vũ Trụ (___).',
 'Background',
 'The Cosmic Microwave Background (CMB) is thermal radiation left over from the early universe (~380,000 years after the Big Bang). Discovered in 1965 by Penzias and Wilson, it is the most important evidence for the Big Bang theory. The CMB is nearly uniform at 2.725K (-270°C) with tiny fluctuations that seeded galaxy formation.',
 'Bức xạ Nền Vi Sóng Vũ Trụ (CMB) là bức xạ nhiệt còn lại từ vũ trụ sơ khai (~380,000 năm sau Big Bang). Được phát hiện năm 1965 bởi Penzias và Wilson, đây là bằng chứng quan trọng nhất cho lý thuyết Big Bang. CMB gần như đồng đều ở 2.725K với các biến động nhỏ đã gieo mầm cho sự hình thành thiên hà.',
 2),
((SELECT id FROM lesson WHERE slug = 'stars-black-holes-cosmology'),
 'true_false', 'medium',
 'The Sun will eventually explode as a supernova at the end of its life.',
 'Mặt Trời cuối cùng sẽ nổ tung như một siêu tân tinh vào cuối vòng đời của nó.',
 'false',
 'The Sun is not massive enough for a supernova. Only stars with masses greater than ~8 solar masses end in supernovae. The Sun will instead expand into a Red Giant in ~5 billion years, then shed its outer layers as a Planetary Nebula, leaving behind a dense White Dwarf — about Earth-sized but retaining most of the Sun''s mass.',
 'Mặt Trời không đủ khối lượng cho siêu tân tinh. Chỉ các ngôi sao có khối lượng lớn hơn ~8 lần khối lượng mặt trời mới kết thúc bằng siêu tân tinh. Thay vào đó, Mặt Trời sẽ mở rộng thành Sao Khổng Lồ Đỏ trong ~5 tỷ năm, sau đó thải lớp ngoài như Tinh Vân Hành Tinh, để lại một Sao Lùn Trắng dày đặc.',
 3),
((SELECT id FROM lesson WHERE slug = 'stars-black-holes-cosmology'),
 'fill_blank', 'easy',
 'The universe began approximately 13.8 billion years ago in an event known as the Big _____.',
 'Vũ trụ bắt đầu khoảng 13.8 tỷ năm trước trong một sự kiện được gọi là Big _____.',
 'Bang',
 'The Big Bang Theory is the prevailing cosmological model for the universe''s origin. It describes the universe beginning from an extremely hot, dense singularity and expanding ever since. The name "Big Bang" was ironically coined by critic Fred Hoyle in 1949 — who preferred the competing "Steady State" theory.',
 'Lý thuyết Big Bang là mô hình vũ trụ học phổ biến về nguồn gốc của vũ trụ. Nó mô tả vũ trụ bắt đầu từ một điểm kỳ dị cực nóng, cực đặc và mở rộng kể từ đó. Tên "Big Bang" được đặt một cách châm biếm bởi nhà phê bình Fred Hoyle năm 1949 — người thích lý thuyết "Trạng thái Ổn định" cạnh tranh.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'stars-black-holes-cosmology'),
 'arrange_words', 'medium',
 'Arrange to describe the fate of our Sun.',
 'Sắp xếp để mô tả số phận của Mặt Trời.',
 'The Sun will become a red giant then a white dwarf',
 '["then", "white", "a", "The", "red", "will", "a", "Sun", "become", "dwarf", "giant"]',
 'In ~5 billion years, the Sun will exhaust its hydrogen fuel and begin fusing helium, expanding into a Red Giant (possibly as large as Earth''s orbit). After losing its outer layers, the dense core remains as a White Dwarf — the size of Earth but with the Sun''s mass, slowly cooling over trillions of years.',
 'Trong ~5 tỷ năm, Mặt Trời sẽ cạn kiệt nhiên liệu hydro và bắt đầu tổng hợp heli, mở rộng thành Sao Khổng Lồ Đỏ. Sau khi mất lớp ngoài, lõi dày đặc vẫn còn lại như một Sao Lùn Trắng — kích thước Trái Đất nhưng khối lượng Mặt Trời, dần nguội lạnh qua hàng nghìn tỷ năm.',
 5);

-- =============================================================================
-- CATEGORY: Environmental Science
-- =============================================================================

-- Lesson 3: Climate Change Science
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Climate Change Science', 'Khoa Học Biến Đổi Khí Hậu', 'climate-change-science',
  'Understand the mechanisms, evidence, and impacts of climate change.',
  'Hiểu cơ chế, bằng chứng và tác động của biến đổi khí hậu.',
  'beginner', 35, 1
FROM category WHERE name = 'Environmental Science';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'climate-change-science'),
 'Understanding climate mechanisms', 'Hiểu cơ chế khí hậu',
 'Explaining why CO₂ at 420 ppm differs from pre-industrial 280 ppm in warming effect.',
 'Giải thích tại sao CO₂ ở 420 ppm khác với mức tiền công nghiệp 280 ppm về hiệu ứng làm ấm.', 1),
((SELECT id FROM lesson WHERE slug = 'climate-change-science'),
 'Evaluating climate policy', 'Đánh giá chính sách khí hậu',
 'Understanding carbon pricing mechanisms and their effectiveness.',
 'Hiểu cơ chế định giá carbon và hiệu quả của chúng.', 2),
((SELECT id FROM lesson WHERE slug = 'climate-change-science'),
 'Personal carbon footprint', 'Dấu chân carbon cá nhân',
 'Calculating the carbon impact of diet choices (meat vs plant-based).',
 'Tính toán tác động carbon của lựa chọn chế độ ăn (thịt vs thực vật).', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'climate-change-science'),
 'markdown', 'The Science Behind Climate Change', 'Khoa Học Đằng Sau Biến Đổi Khí Hậu',
 E'## How the Greenhouse Effect Works\n\nThe natural greenhouse effect is essential for life — without it, Earth would be -18°C. The problem is the **enhanced** greenhouse effect from human emissions.\n\n### Greenhouse Gases (GHGs)\n\n| Gas | Sources | Global Warming Potential (100yr) |\n|-----|---------|----------------------------------|\n| **CO₂** | Fossil fuels, deforestation | 1 (baseline) |\n| **CH₄** (Methane) | Livestock, natural gas, wetlands | 28-36× CO₂ |\n| **N₂O** (Nitrous oxide) | Fertilizers, agriculture | 265× CO₂ |\n| **HFCs** | Refrigerants | 1,000-9,000× CO₂ |\n\n### Key Evidence for Human-Caused Warming\n\n1. **CO₂ concentration**: Pre-industrial ~280 ppm → today **420+ ppm** (highest in 3 million years)\n2. **Temperature record**: Global average +1.2°C since 1880, with acceleration post-1970\n3. **Carbon isotope signature**: Fossil fuel carbon has distinctive isotope ratio (depleted C-14)\n4. **Ocean acidification**: Oceans absorb CO₂ → pH dropped 0.1 units → 30% more acidic\n5. **Ice cores**: Direct correlation between CO₂ and temperature over 800,000 years\n\n### Tipping Points (Non-linear Risks)\n\n- **Arctic sea ice loss** → less reflection → more warming (ice-albedo feedback)\n- **Permafrost thaw** → releases methane → accelerates warming\n- **Amazon dieback** → converts from carbon sink to carbon source\n- These are irreversible on human timescales once triggered',
 E'## Hiệu Ứng Nhà Kính Hoạt Động Như Thế Nào\n\nHiệu ứng nhà kính tự nhiên là thiết yếu cho sự sống — không có nó, Trái Đất sẽ ở -18°C. Vấn đề là hiệu ứng nhà kính **tăng cường** từ khí thải của con người.\n\n### Khí Nhà Kính (GHGs)\n\n| Khí | Nguồn | Tiềm năng nóng lên toàn cầu |\n|-----|-------|-----------------------------|\n| **CO₂** | Nhiên liệu hóa thạch | 1 (cơ sở) |\n| **CH₄** (Methane) | Chăn nuôi, khí đốt tự nhiên | 28-36× CO₂ |\n| **N₂O** (Nitrous oxide) | Phân bón, nông nghiệp | 265× CO₂ |\n\n### Bằng Chứng Chính Cho Sự Nóng Lên Do Con Người\n\n1. **Nồng độ CO₂**: Tiền công nghiệp ~280 ppm → ngày nay **420+ ppm**\n2. **Hồ sơ nhiệt độ**: Trung bình toàn cầu +1.2°C từ năm 1880\n3. **Axit hóa đại dương**: Đại dương hấp thụ CO₂ → pH giảm 0.1 đơn vị → axit hơn 30%',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'climate-change-science'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["CO₂ concentration has risen from 280 ppm (pre-industrial) to 420+ ppm today — highest in 3 million years", "Methane (CH₄) is 28-36× more potent than CO₂ as a greenhouse gas over 100 years", "Five lines of evidence: CO₂ records, temperature records, isotope signatures, ocean pH, ice cores", "Tipping points: Arctic albedo feedback, permafrost methane release, Amazon dieback — all irreversible", "1.5°C of warming is the threshold target; we are currently at ~1.2°C above pre-industrial"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'climate-change-science'),
 'info_box', 'Scientific Consensus', 'Đồng Thuận Khoa Học',
 'Multiple independent studies of scientific literature found that 97%+ of actively publishing climate scientists agree that current warming is primarily human-caused. This is comparable to the scientific consensus on evolution and vaccine safety. The IPCC (Intergovernmental Panel on Climate Change) synthesizes thousands of peer-reviewed studies per report.',
 'Nhiều nghiên cứu độc lập về tài liệu khoa học cho thấy hơn 97% nhà khoa học khí hậu đang tích cực công bố đồng ý rằng sự ấm lên hiện tại chủ yếu do con người gây ra. Điều này tương đương với sự đồng thuận khoa học về tiến hóa và an toàn vaccine. IPCC tổng hợp hàng nghìn nghiên cứu được bình duyệt cho mỗi báo cáo.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'climate-change-science'),
 'multiple_choice', 'easy',
 'Which greenhouse gas has a Global Warming Potential approximately 28-36 times greater than CO₂?',
 'Khí nhà kính nào có Tiềm năng Nóng lên Toàn cầu khoảng 28-36 lần lớn hơn CO₂?',
 'B',
 'Methane (CH₄) is 28-36× more potent than CO₂ over 100 years and 80× more potent over 20 years. It comes from livestock digestion, natural gas leaks, wetlands, and landfills. Despite its shorter atmospheric lifetime (~12 years vs CO₂''s hundreds of years), its high short-term potency makes it a priority for rapid climate action.',
 'Methane (CH₄) có tiềm năng mạnh hơn CO₂ 28-36 lần trong 100 năm và 80 lần trong 20 năm. Nó đến từ tiêu hóa gia súc, rò rỉ khí đốt tự nhiên, đất ngập nước và bãi chôn lấp. Mặc dù có thời gian tồn tại trong khí quyển ngắn hơn (~12 năm so với hàng trăm năm của CO₂), tiềm năng ngắn hạn cao của nó làm cho nó là ưu tiên hành động khí hậu nhanh.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'climate-change-science') AND order_index = 1),
 'A', 'Nitrous oxide (N₂O)', 'Nitrous oxide (N₂O)'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'climate-change-science') AND order_index = 1),
 'B', 'Methane (CH₄)', 'Methane (CH₄)'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'climate-change-science') AND order_index = 1),
 'C', 'Carbon dioxide (CO₂)', 'Carbon dioxide (CO₂)'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'climate-change-science') AND order_index = 1),
 'D', 'Water vapor (H₂O)', 'Water vapor (H₂O)');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'climate-change-science'),
 'fill_blank', 'easy',
 'Current atmospheric CO₂ concentration is over _____ parts per million (ppm), compared to ~280 ppm before industrialization.',
 'Nồng độ CO₂ trong khí quyển hiện tại hơn _____ phần triệu (ppm), so với ~280 ppm trước khi công nghiệp hóa.',
 '420',
 '420+ ppm is the current CO₂ concentration — the highest in at least 3 million years. The pre-industrial level was ~280 ppm. This 50% increase represents an enormous perturbation to the atmosphere accumulated over just 200 years of industrial activity. CO₂ measured at Mauna Loa Observatory (Hawaii) since 1958 shows continuous increase.',
 '420+ ppm là nồng độ CO₂ hiện tại — cao nhất trong ít nhất 3 triệu năm. Mức tiền công nghiệp là ~280 ppm. Sự tăng 50% này đại diện cho một sự nhiễu loạn khổng lồ đối với khí quyển được tích lũy chỉ trong 200 năm hoạt động công nghiệp.',
 2),
((SELECT id FROM lesson WHERE slug = 'climate-change-science'),
 'true_false', 'medium',
 'Ocean acidification is caused by oceans absorbing excess CO₂ from the atmosphere.',
 'Axit hóa đại dương được gây ra bởi đại dương hấp thụ CO₂ dư thừa từ khí quyển.',
 'true',
 'Oceans absorb about 25-30% of anthropogenic CO₂ emissions. When CO₂ dissolves in seawater, it forms carbonic acid (H₂CO₃), which lowers ocean pH. Since industrialization, average ocean pH has dropped from 8.2 to 8.1 — seemingly small, but pH is logarithmic, meaning ~30% more acidic. This threatens shell-forming organisms (corals, mollusks, plankton).',
 'Đại dương hấp thụ khoảng 25-30% lượng khí thải CO₂ từ con người. Khi CO₂ hòa tan trong nước biển, nó tạo thành axit carbonic (H₂CO₃), làm giảm pH đại dương. Kể từ công nghiệp hóa, pH đại dương trung bình đã giảm từ 8.2 xuống 8.1 — có vẻ nhỏ, nhưng pH là logarit, nghĩa là ~30% axit hơn.',
 3),
((SELECT id FROM lesson WHERE slug = 'climate-change-science'),
 'sentence_transform', 'medium',
 'Rewrite to correctly describe tipping points: "Climate tipping points are predictable, linear changes that can be easily reversed by reducing emissions."',
 'Viết lại để mô tả đúng điểm tới hạn: "Điểm tới hạn khí hậu là những thay đổi tuyến tính có thể dự đoán được và có thể dễ dàng đảo ngược bằng cách giảm phát thải."',
 'Climate tipping points are irreversible, non-linear changes that self-reinforce beyond a critical threshold.',
 'Tipping points are non-linear and self-reinforcing (positive feedback loops), not linear and reversible. Once triggered, they continue regardless of emission reductions — they are self-sustaining. Examples: Arctic sea ice loss reduces reflectivity → more warming → more ice loss → feedback loop that continues even if emissions stop.',
 'Điểm tới hạn là phi tuyến tính và tự tăng cường (vòng phản hồi dương), không phải tuyến tính và có thể đảo ngược. Một khi được kích hoạt, chúng tiếp tục bất kể việc giảm phát thải — chúng tự duy trì. Ví dụ: mất băng biển Bắc Cực làm giảm khả năng phản xạ → nóng lên nhiều hơn → mất băng nhiều hơn → vòng phản hồi tiếp tục ngay cả khi phát thải dừng lại.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'climate-change-science'),
 'arrange_words', 'medium',
 'Arrange to describe the ice-albedo feedback loop.',
 'Sắp xếp để mô tả vòng phản hồi albedo băng.',
 'Melting ice reduces reflection causing more warming and further ice loss',
 '["and", "warming", "Melting", "loss", "further", "reflection", "causes", "more", "reducing", "ice", "ice"]',
 'The ice-albedo feedback: ice and snow reflect 80-90% of sunlight (high albedo). When ice melts, dark ocean or land is exposed (low albedo, absorbs 90%+ of sunlight). This absorbed heat causes more warming → more ice melts → more dark surface exposed → amplifying loop. This is why the Arctic is warming 3-4× faster than the global average.',
 'Phản hồi albedo băng: băng và tuyết phản xạ 80-90% ánh sáng mặt trời (albedo cao). Khi băng tan, đại dương hoặc đất tối được lộ ra (albedo thấp, hấp thụ hơn 90% ánh sáng mặt trời). Nhiệt được hấp thụ này gây ra nóng lên nhiều hơn → nhiều băng tan hơn → nhiều bề mặt tối hơn được lộ ra → vòng lặp khuếch đại.',
 5);

-- Lesson 4: Ecology and Biodiversity
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Ecology and Biodiversity', 'Sinh Thái Học và Đa Dạng Sinh Học', 'ecology-biodiversity',
  'Understand ecosystems, food webs, and the importance of biodiversity.',
  'Hiểu hệ sinh thái, mạng lưới thức ăn và tầm quan trọng của đa dạng sinh học.',
  'intermediate', 35, 2
FROM category WHERE name = 'Environmental Science';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'ecology-biodiversity'),
 'Understanding ecosystem services', 'Hiểu dịch vụ hệ sinh thái',
 'Quantifying how wetlands provide flood protection worth billions of dollars.',
 'Định lượng cách đất ngập nước cung cấp bảo vệ lũ lụt trị giá hàng tỷ đô la.', 1),
((SELECT id FROM lesson WHERE slug = 'ecology-biodiversity'),
 'Keystone species', 'Loài chủ chốt',
 'Understanding why removing wolves from Yellowstone cascaded through the entire ecosystem.',
 'Hiểu tại sao loại bỏ sói khỏi Yellowstone ảnh hưởng dây chuyền toàn bộ hệ sinh thái.', 2),
((SELECT id FROM lesson WHERE slug = 'ecology-biodiversity'),
 'Conservation decision-making', 'Ra quyết định bảo tồn',
 'Prioritizing species conservation using the IUCN Red List categories.',
 'Ưu tiên bảo tồn loài bằng cách sử dụng các danh mục Sách Đỏ IUCN.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'ecology-biodiversity'),
 'markdown', 'Ecosystems and Biodiversity', 'Hệ Sinh Thái và Đa Dạng Sinh Học',
 E'## The Web of Life\n\n### Ecosystem Structure\n\n**Trophic Levels** (energy pyramid):\n```\nTertiary consumers (apex predators)\nSecondary consumers (carnivores)\nPrimary consumers (herbivores)\nProducers (plants, algae, phytoplankton)\nDecomposers (bacteria, fungi) ← break down everything\n```\n\n**10% Rule**: Only ~10% of energy transfers between trophic levels. A 1,000 calorie plant feeds 100 calories of herbivore which feeds 10 calories of carnivore.\n\n### Keystone Species\n\nA **keystone species** has a disproportionately large impact on its ecosystem relative to its biomass:\n\n- **Sea otters**: Eat sea urchins → prevents urchin explosion → protects kelp forests\n- **Wolves in Yellowstone**: Controlled elk → elk stopped overgrazing riverbanks → vegetation regrew → beaver habitat → river flow changed (*trophic cascade*)\n- **Bees**: Pollinate 75% of flowering plant species and 35% of global food supply\n\n### Biodiversity Metrics\n\n- **Species richness**: Number of different species\n- **Species evenness**: How evenly distributed the populations are\n- **Genetic diversity**: Variety within a species (resilience against disease)\n\n### Ecosystem Services (economic value)\n\n| Service | Example | Estimated Value |\n|---------|---------|----------------|\n| Pollination | Crop production | $235B/year |\n| Water purification | Wetlands filter water | $4.9T/year global |\n| Carbon sequestration | Forests store CO₂ | $125B/year |\n| Flood control | Coastal wetlands | $23B/year US |\n\n> The entire global ecosystem services value is estimated at $125 trillion/year — more than global GDP.',
 E'## Mạng Sống\n\n### Cấu Trúc Hệ Sinh Thái\n\n**Cấp dinh dưỡng** (tháp năng lượng):\n- Người tiêu thụ bậc ba (săn mồi đỉnh)\n- Người tiêu thụ bậc hai (ăn thịt)\n- Người tiêu thụ bậc một (ăn cỏ)\n- Nhà sản xuất (thực vật, tảo)\n- Người phân hủy (vi khuẩn, nấm)\n\n**Quy tắc 10%**: Chỉ ~10% năng lượng chuyển giữa các cấp dinh dưỡng.\n\n### Loài Chủ Chốt\n\n**Loài chủ chốt** có tác động lớn không tương xứng với sinh khối của chúng:\n\n- **Sói tại Yellowstone**: Kiểm soát nai → nai ngừng ăn cỏ quá mức ở bờ sông → thực vật phát triển → môi trường sống hải ly → dòng chảy sông thay đổi (*tầng sinh thái*)\n- **Ong**: Thụ phấn 75% các loài thực vật có hoa và 35% nguồn cung thực phẩm toàn cầu',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'ecology-biodiversity'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["10% rule: only 10% of energy transfers between trophic levels — explains why apex predators are rare", "Keystone species: disproportionate ecosystem impact; removing one can cascade through entire system", "Trophic cascade: wolf removal → elk overgrazing → riverbank erosion → changed river morphology", "Ecosystem services are worth ~$125 trillion/year globally — more than global GDP", "Biodiversity = insurance policy: more species = more resilience against disturbances and disease"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'ecology-biodiversity'),
 'info_box', 'Wolves Change Rivers', 'Sói Thay Đổi Dòng Sông',
 'When wolves were reintroduced to Yellowstone in 1995, they did something unexpected: they changed the course of rivers. By controlling elk numbers, vegetation regrew on riverbanks. This attracted beavers, which built dams, changing water flow patterns. The entire watershed transformed — a classic trophic cascade demonstrating interconnectedness.',
 'Khi sói được tái đưa vào Yellowstone năm 1995, chúng đã làm điều bất ngờ: thay đổi dòng chảy của sông. Bằng cách kiểm soát số lượng nai, thực vật phát triển lại trên bờ sông. Điều này thu hút hải ly, xây dựng đập, thay đổi mô hình dòng chảy nước. Toàn bộ lưu vực được chuyển đổi — tầng sinh thái điển hình thể hiện sự kết nối.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'ecology-biodiversity'),
 'multiple_choice', 'easy',
 'What does the "10% rule" in ecology describe?',
 'Quy tắc "10%" trong sinh thái học mô tả điều gì?',
 'C',
 'The 10% rule states that approximately 10% of the energy stored at one trophic level is converted to biomass at the next level — the rest is lost as heat, respiration, and waste. This explains why food chains are rarely longer than 4-5 levels (energy runs out) and why apex predators have much smaller populations than their prey.',
 'Quy tắc 10% phát biểu rằng khoảng 10% năng lượng được lưu trữ ở một cấp dinh dưỡng được chuyển đổi thành sinh khối ở cấp tiếp theo — phần còn lại bị mất dưới dạng nhiệt, hô hấp và chất thải. Điều này giải thích tại sao chuỗi thức ăn hiếm khi dài hơn 4-5 cấp (năng lượng cạn kiệt) và tại sao các loài săn mồi đỉnh có quần thể nhỏ hơn nhiều so với con mồi của chúng.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'ecology-biodiversity') AND order_index = 1),
 'A', '10% of species survive in any given ecosystem', '10% loài sống sót trong bất kỳ hệ sinh thái nhất định nào'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'ecology-biodiversity') AND order_index = 1),
 'B', '10% of biodiversity is found in rainforests', '10% đa dạng sinh học được tìm thấy trong rừng nhiệt đới'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'ecology-biodiversity') AND order_index = 1),
 'C', '10% of energy transfers between trophic levels', '10% năng lượng chuyển giữa các cấp dinh dưỡng'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'ecology-biodiversity') AND order_index = 1),
 'D', '10% of ecosystems are protected by law', '10% hệ sinh thái được bảo vệ bởi pháp luật');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'ecology-biodiversity'),
 'fill_blank', 'medium',
 'A species that has a disproportionately large impact on its ecosystem relative to its abundance is called a _____ species.',
 'Loài có tác động lớn không tương xứng với hệ sinh thái so với số lượng của nó được gọi là loài _____.',
 'keystone',
 'Keystone species (coined by ecologist Robert Paine in 1969, from the architecture term for the central stone in an arch) hold their ecosystems together. Remove them and the ecosystem collapses or changes fundamentally. Paine demonstrated this by removing sea stars (Pisaster) from a tidal pool — the mussel population exploded and crowded out other species.',
 'Loài chủ chốt (được đặt ra bởi nhà sinh thái học Robert Paine năm 1969, từ thuật ngữ kiến trúc cho viên đá trung tâm trong vòm cung) giữ cho hệ sinh thái của chúng lại với nhau. Loại bỏ chúng và hệ sinh thái sụp đổ hoặc thay đổi cơ bản.',
 2),
((SELECT id FROM lesson WHERE slug = 'ecology-biodiversity'),
 'true_false', 'easy',
 'Decomposers like bacteria and fungi are not considered part of food webs because they do not prey on living organisms.',
 'Các sinh vật phân hủy như vi khuẩn và nấm không được coi là một phần của mạng lưới thức ăn vì chúng không săn mồi sinh vật sống.',
 'false',
 'Decomposers ARE essential components of all food webs. They break down dead organic matter (detritus), returning nutrients to the soil and making them available for producers (plants). Without decomposers, dead organic material would accumulate indefinitely, nutrients would become locked up, and ecosystems would collapse.',
 'Sinh vật phân hủy LÀ thành phần thiết yếu của tất cả mạng lưới thức ăn. Chúng phân hủy vật chất hữu cơ chết (mảnh vụn), trả lại chất dinh dưỡng cho đất và cung cấp chúng cho nhà sản xuất (thực vật). Không có sinh vật phân hủy, vật liệu hữu cơ chết sẽ tích lũy vô thời hạn.',
 3),
((SELECT id FROM lesson WHERE slug = 'ecology-biodiversity'),
 'fill_blank', 'medium',
 'When removing a predator causes cascading changes throughout an ecosystem — as occurred with wolves in Yellowstone — it is called a trophic _____.',
 'Khi loại bỏ một loài săn mồi gây ra những thay đổi dây chuyền trong suốt hệ sinh thái — như xảy ra với sói ở Yellowstone — nó được gọi là _____ dinh dưỡng.',
 'cascade',
 'A trophic cascade occurs when a change at one trophic level ripples up or down through the food web. Top-down cascades: predator removal → prey population explosion → overgrazing. The Yellowstone wolf reintroduction is the most famous trophic cascade study — it ultimately changed river morphology through multiple cascading effects.',
 'Tầng dinh dưỡng xảy ra khi một sự thay đổi ở một cấp dinh dưỡng lan ra khắp mạng lưới thức ăn. Tầng từ trên xuống: loại bỏ săn mồi → bùng nổ quần thể con mồi → ăn cỏ quá mức. Việc tái đưa sói vào Yellowstone là nghiên cứu tầng dinh dưỡng nổi tiếng nhất.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'ecology-biodiversity'),
 'arrange_words', 'easy',
 'Arrange to state the 10% energy transfer rule.',
 'Sắp xếp để phát biểu quy tắc chuyển 10% năng lượng.',
 'Only ten percent of energy transfers between each trophic level',
 '["trophic", "between", "percent", "energy", "each", "Only", "transfers", "level", "ten"]',
 'The 10% Rule (ecological pyramid of energy): At each trophic level, only approximately 10% of the chemical energy becomes incorporated into new biomass. The other ~90% is used for cellular respiration, movement, and is lost as heat. This is why eating plant-based food is ~10x more energy-efficient than eating meat.',
 'Quy tắc 10% (tháp năng lượng sinh thái): Ở mỗi cấp dinh dưỡng, chỉ khoảng 10% năng lượng hóa học được tích hợp vào sinh khối mới. ~90% còn lại được sử dụng cho hô hấp tế bào, chuyển động và bị mất dưới dạng nhiệt. Đây là lý do tại sao ăn thực phẩm từ thực vật hiệu quả năng lượng hơn ~10 lần so với ăn thịt.',
 5);

-- =============================================================================
-- CATEGORY: Agriculture & Botany
-- =============================================================================

-- Lesson 5: Plant Biology Basics
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Plant Biology Basics', 'Sinh Học Thực Vật Cơ Bản', 'plant-biology-basics',
  'Understand how plants grow, photosynthesize, and respond to their environment.',
  'Hiểu cách thực vật phát triển, quang hợp và phản ứng với môi trường.',
  'beginner', 30, 1
FROM category WHERE name = 'Agriculture & Botany';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'plant-biology-basics'),
 'Understanding fertilizer NPK', 'Hiểu NPK phân bón',
 'Choosing the right nitrogen-heavy fertilizer for leafy growth vs phosphorus for flowering.',
 'Chọn phân bón giàu nitơ cho tăng trưởng lá vs phốt pho cho ra hoa.', 1),
((SELECT id FROM lesson WHERE slug = 'plant-biology-basics'),
 'Optimizing plant growth', 'Tối ưu hóa tăng trưởng thực vật',
 'Understanding why plants in low light become "leggy" as they stretch toward the source.',
 'Hiểu tại sao thực vật trong ánh sáng thấp trở nên "gầy" khi chúng vươn về phía nguồn.', 2),
((SELECT id FROM lesson WHERE slug = 'plant-biology-basics'),
 'Crop production', 'Sản xuất cây trồng',
 'Understanding C3 vs C4 plants to predict which crops suit which climates.',
 'Hiểu cây C3 vs C4 để dự đoán cây trồng nào phù hợp với khí hậu nào.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'plant-biology-basics'),
 'markdown', 'How Plants Work', 'Cách Thực Vật Hoạt Động',
 E'## Plant Anatomy\n\n| Structure | Function |\n|-----------|----------|\n| **Roots** | Anchor, absorb water + minerals, store energy |\n| **Stem** | Transport (xylem up, phloem down), structural support |\n| **Leaves** | Primary site of photosynthesis |\n| **Flowers** | Reproduction |\n| **Seeds** | Dispersal of genetic material |\n\n### Photosynthesis\n\n**The equation**: CO₂ + H₂O + light → C₆H₁₂O₆ (glucose) + O₂\n\nOccurs in **chloroplasts** using chlorophyll (green pigment)\n\n**Two stages**:\n1. **Light reactions** (thylakoids): Convert light → ATP + NADPH\n2. **Calvin cycle** (stroma): Use ATP + NADPH + CO₂ → glucose\n\n### Plant Nutrients\n\n**Macronutrients** (NPK — on fertilizer labels):\n- **Nitrogen (N)**: Leaf and stem growth, chlorophyll production\n- **Phosphorus (P)**: Root development, flowering, fruiting\n- **Potassium (K)**: Disease resistance, water regulation\n\n**Micronutrients**: Iron, manganese, zinc, copper (needed in trace amounts)\n\n### Plant Hormones\n\n| Hormone | Effect |\n|---------|--------|\n| **Auxin** | Cell elongation; phototropism (bending toward light) |\n| **Gibberellin** | Stem elongation, germination |\n| **Cytokinin** | Cell division, delays senescence |\n| **Ethylene** | Fruit ripening, leaf drop |\n| **Abscisic acid** | Stress response, stomata closure in drought |',
 E'## Giải Phẫu Thực Vật\n\n| Cấu trúc | Chức năng |\n|----------|----------|\n| **Rễ** | Neo, hấp thu nước + khoáng chất |\n| **Thân** | Vận chuyển (xylem lên, phloem xuống), hỗ trợ cấu trúc |\n| **Lá** | Vị trí chính của quang hợp |\n\n### Quang Hợp\n\n**Phương trình**: CO₂ + H₂O + ánh sáng → C₆H₁₂O₆ (glucose) + O₂\n\nXảy ra trong **lục lạp** sử dụng chlorophyll\n\n### Chất Dinh Dưỡng Thực Vật (NPK)\n\n- **Nitơ (N)**: Tăng trưởng lá và thân, sản xuất chlorophyll\n- **Phốt pho (P)**: Phát triển rễ, ra hoa, đậu quả\n- **Kali (K)**: Kháng bệnh, điều tiết nước',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'plant-biology-basics'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["Photosynthesis: CO₂ + H₂O + light → glucose + O₂ (occurs in chloroplasts using chlorophyll)", "NPK fertilizer: Nitrogen=leaves/growth, Phosphorus=roots/flowers, Potassium=disease resistance", "Xylem: water transport upward; Phloem: sugar transport downward (bidirectional)", "Auxin causes phototropism — cells elongate on the shaded side, bending plant toward light", "Ethylene is the ripening hormone — why storing fruits together speeds ripening"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'plant-biology-basics'),
 'info_box', 'Ethylene and Fruit Ripening', 'Ethylene và Chín Trái Cây',
 'Ethylene gas is produced by ripening fruit and triggers ripening in nearby fruit — a positive feedback loop. This is why one rotten apple spoils the barrel. Conversely, keeping unripe fruit near a ripe banana (which produces lots of ethylene) speeds ripening. Commercial fruit shippers store fruit in low-oxygen, low-ethylene environments to control ripening timing.',
 'Khí ethylene được tạo ra bởi trái cây chín và kích hoạt sự chín trong trái cây gần đó — vòng phản hồi dương. Đây là lý do tại sao một quả táo thối làm hỏng cả thùng. Ngược lại, giữ trái cây chưa chín gần chuối chín (tạo ra nhiều ethylene) tăng tốc sự chín. Nhà vận chuyển trái cây thương mại lưu trữ trái cây trong môi trường ít oxy, ít ethylene.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'plant-biology-basics'),
 'multiple_choice', 'easy',
 'What does the "N" in NPK fertilizer stand for, and what does it primarily promote?',
 '"N" trong phân bón NPK viết tắt cho điều gì và nó chủ yếu thúc đẩy điều gì?',
 'A',
 'N = Nitrogen. Nitrogen is essential for chlorophyll production and amino acid synthesis, directly driving vegetative growth (leaves and stems). High-nitrogen fertilizers are used for lawns and leafy vegetables. Phosphorus (P) supports roots and flowers; Potassium (K) supports disease resistance and water regulation.',
 'N = Nitơ. Nitơ thiết yếu cho sản xuất chlorophyll và tổng hợp amino acid, trực tiếp thúc đẩy tăng trưởng sinh dưỡng (lá và thân). Phân bón giàu nitơ được sử dụng cho bãi cỏ và rau lá. Phốt pho (P) hỗ trợ rễ và hoa; Kali (K) hỗ trợ kháng bệnh và điều tiết nước.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'plant-biology-basics') AND order_index = 1),
 'A', 'Nitrogen — promotes leaf and stem growth', 'Nitơ — thúc đẩy tăng trưởng lá và thân'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'plant-biology-basics') AND order_index = 1),
 'B', 'Neon — provides atmospheric trace elements', 'Neon — cung cấp nguyên tố vi lượng khí quyển'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'plant-biology-basics') AND order_index = 1),
 'C', 'Nickel — supports root development', 'Niken — hỗ trợ phát triển rễ'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'plant-biology-basics') AND order_index = 1),
 'D', 'Nutrients — general mineral balance', 'Chất dinh dưỡng — cân bằng khoáng chất tổng hợp');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'plant-biology-basics'),
 'fill_blank', 'easy',
 'Photosynthesis uses CO₂, water, and light to produce glucose and _____ gas.',
 'Quang hợp sử dụng CO₂, nước và ánh sáng để tạo ra glucose và khí _____.',
 'oxygen',
 'Photosynthesis: 6CO₂ + 6H₂O + light energy → C₆H₁₂O₆ + 6O₂. Oxygen is released as a byproduct of splitting water molecules (photolysis) during the light reactions. All of Earth''s atmospheric oxygen was produced by photosynthesis over billions of years — primarily by ancient cyanobacteria.',
 'Quang hợp: 6CO₂ + 6H₂O + năng lượng ánh sáng → C₆H₁₂O₆ + 6O₂. Oxy được giải phóng như sản phẩm phụ của việc tách phân tử nước (quang phân) trong các phản ứng ánh sáng. Tất cả oxy khí quyển Trái Đất được sản xuất bởi quang hợp qua hàng tỷ năm — chủ yếu bởi vi khuẩn lam cổ đại.',
 2),
((SELECT id FROM lesson WHERE slug = 'plant-biology-basics'),
 'true_false', 'medium',
 'Xylem transports water from roots to leaves, while phloem transports sugars from leaves to the rest of the plant.',
 'Xylem vận chuyển nước từ rễ đến lá, trong khi phloem vận chuyển đường từ lá đến phần còn lại của cây.',
 'true',
 'Correct! Xylem (dead cells forming tubes) transports water and dissolved minerals from roots upward via transpiration pull. Phloem (living cells) transports dissolved sugars (produced by photosynthesis) from leaves to roots, fruits, and growing tips — the direction can be bidirectional based on need.',
 'Đúng! Xylem (tế bào chết tạo thành ống) vận chuyển nước và khoáng chất hòa tan từ rễ đi lên thông qua lực kéo thoát hơi nước. Phloem (tế bào sống) vận chuyển đường hòa tan (được tạo ra bởi quang hợp) từ lá đến rễ, quả và đầu mọc — hướng có thể hai chiều tùy thuộc vào nhu cầu.',
 3),
((SELECT id FROM lesson WHERE slug = 'plant-biology-basics'),
 'fill_blank', 'medium',
 'The plant hormone responsible for bending toward light (phototropism) by causing cell elongation on the shaded side is called _____.',
 'Hormone thực vật chịu trách nhiệm uốn về phía ánh sáng (hướng quang) bằng cách gây ra sự kéo dài tế bào ở phía bóng tối được gọi là _____.',
 'auxin',
 'Auxin (primarily IAA - indole-3-acetic acid) is distributed unevenly in stems when light shines from one side. The shaded side accumulates more auxin, causing those cells to elongate more than the lit side. This asymmetric growth causes the characteristic bending toward light seen in phototropism.',
 'Auxin (chủ yếu là IAA - axit indole-3-acetic) được phân phối không đều trong thân khi ánh sáng chiếu từ một phía. Phía bóng tối tích lũy nhiều auxin hơn, khiến các tế bào đó kéo dài nhiều hơn phía có ánh sáng. Sự tăng trưởng bất cân xứng này gây ra sự uốn về phía ánh sáng đặc trưng được thấy trong hướng quang.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'plant-biology-basics'),
 'arrange_words', 'easy',
 'Arrange the simplified photosynthesis equation inputs and outputs.',
 'Sắp xếp các đầu vào và đầu ra của phương trình quang hợp đơn giản hóa.',
 'Carbon dioxide and water with light produce glucose and oxygen',
 '["and", "produce", "Carbon", "water", "glucose", "with", "dioxide", "oxygen", "light"]',
 'Photosynthesis converts inorganic molecules (CO₂ and H₂O) into organic molecules (glucose) using light energy. It is the foundation of almost all food webs on Earth — plants capture solar energy and convert it into chemical energy that all other organisms (herbivores, carnivores, decomposers) depend on.',
 'Quang hợp chuyển đổi các phân tử vô cơ (CO₂ và H₂O) thành phân tử hữu cơ (glucose) sử dụng năng lượng ánh sáng. Đây là nền tảng của hầu hết tất cả mạng lưới thức ăn trên Trái Đất — thực vật thu năng lượng mặt trời và chuyển đổi thành năng lượng hóa học mà tất cả sinh vật khác phụ thuộc vào.',
 5);

-- Lesson 6: Modern Agriculture and Sustainable Farming
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Modern Agriculture and Sustainable Farming', 'Nông Nghiệp Hiện Đại và Canh Tác Bền Vững', 'modern-agriculture-sustainability',
  'Explore how modern agriculture works and how to make it more sustainable.',
  'Khám phá cách nông nghiệp hiện đại hoạt động và làm thế nào để bền vững hơn.',
  'intermediate', 40, 2
FROM category WHERE name = 'Agriculture & Botany';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'modern-agriculture-sustainability'),
 'Crop rotation planning', 'Lập kế hoạch luân canh',
 'Rotating legumes (nitrogen-fixing) with cereals to reduce fertilizer need.',
 'Luân canh cây họ đậu (cố định nitơ) với ngũ cốc để giảm nhu cầu phân bón.', 1),
((SELECT id FROM lesson WHERE slug = 'modern-agriculture-sustainability'),
 'Understanding GMOs', 'Hiểu về GMO',
 'Distinguishing between different types of genetic modification and their applications.',
 'Phân biệt giữa các loại biến đổi gen khác nhau và ứng dụng của chúng.', 2),
((SELECT id FROM lesson WHERE slug = 'modern-agriculture-sustainability'),
 'Soil health management', 'Quản lý sức khỏe đất',
 'Using cover crops to prevent erosion and maintain soil organic matter.',
 'Sử dụng cây che phủ để ngăn xói mòn và duy trì chất hữu cơ trong đất.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'modern-agriculture-sustainability'),
 'markdown', 'Agriculture: Feeding 8 Billion People', 'Nông Nghiệp: Nuôi Sống 8 Tỷ Người',
 E'## The Green Revolution and Beyond\n\nThe Green Revolution (1950s-1970s) tripled crop yields through high-yield varieties, synthetic fertilizers, pesticides, and irrigation — averting predicted famines.\n\n### Key Agricultural Practices\n\n**Crop Rotation**:\n- Alternating crops each season to break pest cycles and restore nutrients\n- Legume rotation: soybeans/beans fix atmospheric nitrogen via rhizobium bacteria\n- Benefits: reduces fertilizer need, breaks disease cycles, improves soil structure\n\n**Integrated Pest Management (IPM)**:\n- Biological controls first (predator insects, parasites)\n- Cultural controls (timing, resistant varieties)\n- Chemical controls (pesticides) as last resort\n- Reduces pesticide use 50-90% vs conventional\n\n### GMO Technology\n\n| Type | Example | Purpose |\n|------|---------|--------|\n| **Herbicide resistance** | Roundup Ready crops | Survive broad-spectrum herbicides |\n| **Pest resistance** | Bt corn | Produces natural insecticide (Bacillus thuringiensis) |\n| **Nutritional enhancement** | Golden Rice | Produces beta-carotene (Vitamin A source) |\n| **Disease resistance** | Papaya ringspot | Saved Hawaii''s papaya industry |\n\n### Sustainable Practices\n\n- **No-till farming**: Don''t plow — preserves soil structure, reduces erosion, sequesters carbon\n- **Cover crops**: Plant off-season crops (legumes, grasses) to prevent erosion and add organic matter\n- **Precision agriculture**: GPS + sensors + data → targeted fertilizer/water application\n- **Agroforestry**: Trees + crops + livestock together — mimics natural ecosystems',
 E'## Cách Mạng Xanh và Tiếp Theo\n\nCách mạng Xanh (những năm 1950-1970) đã tăng gấp ba năng suất cây trồng thông qua giống năng suất cao, phân bón tổng hợp, thuốc trừ sâu và tưới tiêu — ngăn chặn nạn đói được dự đoán.\n\n### Các Thực Hành Nông Nghiệp Chính\n\n**Luân canh**:\n- Xen kẽ cây trồng theo mùa để phá chu kỳ sâu bệnh và phục hồi chất dinh dưỡng\n- Luân canh cây họ đậu: đậu tương/đậu cố định nitơ khí quyển qua vi khuẩn rhizobium\n\n**Quản Lý Dịch Hại Tích Hợp (IPM)**:\n- Kiểm soát sinh học trước tiên (côn trùng thiên địch, ký sinh trùng)\n- Hóa chất (thuốc trừ sâu) như phương án cuối cùng\n\n**Thực Hành Bền Vững**:\n- **Canh tác không cày**: Bảo tồn cấu trúc đất, giảm xói mòn\n- **Cây che phủ**: Ngăn xói mòn và thêm chất hữu cơ\n- **Nông nghiệp chính xác**: GPS + cảm biến + dữ liệu → bón phân/tưới nước có mục tiêu',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'modern-agriculture-sustainability'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["Crop rotation with legumes fixes atmospheric nitrogen via rhizobium bacteria — reducing fertilizer needs", "IPM: biological controls first, chemical pesticides last — reduces pesticide use 50-90%", "GMOs are diverse: some resist herbicides, others produce natural pesticides, some enhance nutrition", "No-till farming preserves soil structure, reduces erosion, and sequesters carbon in soil", "Precision agriculture uses GPS+sensors to apply exactly the right inputs where needed — reducing waste"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'modern-agriculture-sustainability'),
 'info_box', 'Norman Borlaug and the Green Revolution', 'Norman Borlaug và Cách Mạng Xanh',
 'Norman Borlaug developed high-yield, disease-resistant wheat varieties that increased wheat yields 6-8× and saved an estimated 1 billion lives from famine. He won the Nobel Peace Prize in 1970. He is often called "the man who saved more lives than anyone in history."',
 'Norman Borlaug đã phát triển các giống lúa mì năng suất cao, kháng bệnh tăng sản lượng lúa mì 6-8 lần và cứu sống ước tính 1 tỷ người khỏi nạn đói. Ông đã giành Giải Nobel Hòa bình năm 1970. Ông thường được gọi là "người đã cứu sống nhiều người hơn bất kỳ ai trong lịch sử."',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'modern-agriculture-sustainability'),
 'multiple_choice', 'easy',
 'What is the primary soil benefit of including legumes in crop rotation?',
 'Lợi ích đất chính của việc đưa cây họ đậu vào luân canh là gì?',
 'B',
 'Legumes (soybeans, peas, clover, alfalfa) host nitrogen-fixing bacteria (rhizobia) in root nodules. These bacteria convert atmospheric N₂ into ammonia (NH₃), which the plant and surrounding soil can use. After the legume crop, the soil has higher nitrogen content, reducing the need for synthetic nitrogen fertilizers.',
 'Cây họ đậu (đậu tương, đậu Hà Lan, cỏ ba lá, cỏ linh lăng) chứa vi khuẩn cố định nitơ (rhizobia) trong nốt rễ. Những vi khuẩn này chuyển đổi N₂ khí quyển thành amoniac (NH₃), mà cây và đất xung quanh có thể sử dụng. Sau vụ cây họ đậu, đất có hàm lượng nitơ cao hơn, giảm nhu cầu phân bón nitơ tổng hợp.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'modern-agriculture-sustainability') AND order_index = 1),
 'A', 'Legumes add phosphorus to the soil', 'Cây họ đậu thêm phốt pho vào đất'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'modern-agriculture-sustainability') AND order_index = 1),
 'B', 'Legumes fix atmospheric nitrogen through root bacteria', 'Cây họ đậu cố định nitơ khí quyển thông qua vi khuẩn rễ'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'modern-agriculture-sustainability') AND order_index = 1),
 'C', 'Legumes break pest cycles by attracting beneficial insects', 'Cây họ đậu phá chu kỳ sâu bệnh bằng cách thu hút côn trùng có ích'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'modern-agriculture-sustainability') AND order_index = 1),
 'D', 'Legumes improve drainage by breaking up clay soil', 'Cây họ đậu cải thiện thoát nước bằng cách phá vỡ đất sét');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'modern-agriculture-sustainability'),
 'true_false', 'medium',
 'All GMO crops are designed to resist herbicides, which leads to increased herbicide use.',
 'Tất cả cây trồng GMO được thiết kế để kháng thuốc diệt cỏ, dẫn đến tăng sử dụng thuốc diệt cỏ.',
 'false',
 'GMOs are diverse — herbicide resistance is just one application. Others include Bt crops (produce natural insecticide, reducing pesticide use), Golden Rice (produces Vitamin A to address malnutrition), disease-resistant papaya (no pesticide benefit, pathogen resistance), and drought-tolerant varieties. Grouping all GMOs as "herbicide resistant" is inaccurate.',
 'GMO rất đa dạng — kháng thuốc diệt cỏ chỉ là một ứng dụng. Các ứng dụng khác bao gồm cây Bt (sản xuất thuốc trừ sâu tự nhiên, giảm sử dụng thuốc trừ sâu), Gạo Vàng (sản xuất Vitamin A để giải quyết suy dinh dưỡng), đu đủ kháng bệnh. Gộp tất cả GMO là "kháng thuốc diệt cỏ" là không chính xác.',
 2),
((SELECT id FROM lesson WHERE slug = 'modern-agriculture-sustainability'),
 'fill_blank', 'medium',
 'Planting crops between main crop seasons to prevent soil erosion and add organic matter is called _____ cropping.',
 'Trồng cây giữa các mùa cây trồng chính để ngăn xói mòn đất và thêm chất hữu cơ được gọi là canh tác cây _____.',
 'cover',
 'Cover crops (also called green manure) are planted between cash crop seasons. Examples: winter rye, crimson clover, buckwheat. They protect bare soil from erosion, suppress weeds, and when tilled in (or left to decompose), add organic matter and nutrients. Legume cover crops also fix nitrogen.',
 'Cây che phủ (còn gọi là phân xanh) được trồng giữa các mùa cây trồng thương phẩm. Ví dụ: lúa mạch đen mùa đông, cỏ ba lá đỏ tươi, kiều mạch. Chúng bảo vệ đất trần khỏi xói mòn, ức chế cỏ dại và khi được cày vào (hoặc để phân hủy), thêm chất hữu cơ và chất dinh dưỡng.',
 3),
((SELECT id FROM lesson WHERE slug = 'modern-agriculture-sustainability'),
 'sentence_transform', 'medium',
 'Rewrite to correctly describe no-till farming benefits: "No-till farming reduces crop yields because the soil is not properly aerated."',
 'Viết lại để mô tả đúng lợi ích của canh tác không cày: "Canh tác không cày làm giảm năng suất cây trồng vì đất không được thông khí đúng cách."',
 'No-till farming preserves soil structure, reduces erosion, and sequesters carbon while maintaining comparable crop yields.',
 'No-till (or conservation tillage) preserves soil structure by avoiding plowing. Benefits: reduces erosion by 90%+, retains soil moisture, preserves earthworms and microbiome, sequesters carbon in soil organic matter. Modern research shows no-till yields are comparable or higher than conventional tillage for most crops when properly managed.',
 'Không cày (hoặc canh tác bảo tồn) bảo tồn cấu trúc đất bằng cách tránh cày. Lợi ích: giảm xói mòn hơn 90%, giữ độ ẩm đất, bảo tồn giun đất và vi sinh vật, cô lập carbon trong chất hữu cơ đất. Nghiên cứu hiện đại cho thấy năng suất không cày tương đương hoặc cao hơn so với canh tác truyền thống cho hầu hết cây trồng khi được quản lý đúng cách.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'modern-agriculture-sustainability'),
 'arrange_words', 'medium',
 'Arrange to describe integrated pest management priority.',
 'Sắp xếp để mô tả ưu tiên quản lý dịch hại tích hợp.',
 'IPM uses biological controls first and chemical pesticides only as a last resort',
 '["last", "biological", "IPM", "controls", "uses", "pesticides", "chemical", "first", "only", "a", "as", "and", "resort"]',
 'IPM (Integrated Pest Management) is a hierarchical approach: cultural controls (resistant varieties, timing) → biological controls (beneficial predators, parasites) → chemical controls (targeted pesticides, last resort). This sequence minimizes environmental impact while maintaining effectiveness. IPM can reduce pesticide use by 50-90% compared to calendar-based spraying.',
 'IPM (Quản lý Dịch hại Tích hợp) là cách tiếp cận phân cấp: kiểm soát văn hóa (giống kháng bệnh, thời gian) → kiểm soát sinh học (thiên địch, ký sinh trùng) → kiểm soát hóa chất (thuốc trừ sâu có mục tiêu, phương án cuối cùng). Trình tự này giảm thiểu tác động môi trường trong khi duy trì hiệu quả.',
 5);

-- =============================================================================
-- CATEGORY: Urban Farming
-- =============================================================================

-- Lesson 7: Introduction to Urban Farming
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Introduction to Urban Farming', 'Giới Thiệu Về Nông Nghiệp Đô Thị', 'intro-urban-farming',
  'Discover urban farming methods and how cities can produce their own food.',
  'Khám phá các phương pháp nông nghiệp đô thị và cách các thành phố có thể sản xuất thực phẩm.',
  'beginner', 30, 1
FROM category WHERE name = 'Urban Farming';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-urban-farming'),
 'Rooftop garden design', 'Thiết kế vườn sân thượng',
 'Planning a rooftop vegetable garden using lightweight growing media.',
 'Lập kế hoạch vườn rau sân thượng bằng vật liệu trồng trọt nhẹ.', 1),
((SELECT id FROM lesson WHERE slug = 'intro-urban-farming'),
 'Community garden management', 'Quản lý vườn cộng đồng',
 'Organizing plot allocation and shared resource management in community spaces.',
 'Tổ chức phân bổ ô trồng và quản lý tài nguyên chung trong không gian cộng đồng.', 2),
((SELECT id FROM lesson WHERE slug = 'intro-urban-farming'),
 'Food security planning', 'Lập kế hoạch an ninh lương thực',
 'Using urban farming to reduce food deserts in low-income neighborhoods.',
 'Sử dụng nông nghiệp đô thị để giảm vùng thiếu thực phẩm ở khu vực thu nhập thấp.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-urban-farming'),
 'markdown', 'Growing Food in Cities', 'Trồng Thực Phẩm Trong Thành Phố',
 E'## Urban Farming Methods\n\n### Container Gardening\n\n- Grow in pots, buckets, raised beds on balconies, rooftops, windowsills\n- Advantages: controlled soil, portability, year-round indoor growing\n- Key: drainage, appropriate pot size, quality growing mix\n\n### Hydroponics\n\nGrowing plants in nutrient-rich water without soil:\n\n| System | Description | Best For |\n|--------|-------------|----------|\n| **Kratky** | Passive; no pump needed | Leafy greens, simple |\n| **DWC** (Deep Water Culture) | Roots suspended in oxygenated water | Fast growth |\n| **NFT** (Nutrient Film Technique) | Thin film of water over roots | Commercial scale |\n| **Aeroponics** | Roots misted with nutrients | Fastest growth, complex |\n\n### Vertical Farming\n\n- Stacking growing layers with artificial LED lighting\n- Can produce 100× more food per square meter than traditional farming\n- Low water use (70-95% less vs conventional)\n- No pesticides needed (controlled environment)\n- Higher upfront cost, electricity-dependent\n\n### Benefits of Urban Agriculture\n\n- Reduces "food miles" (transport emissions)\n- Addresses food deserts (low-income areas with poor food access)\n- Community building, mental health benefits\n- Reduces urban heat island effect (green coverage)\n- Educational value for children and communities',
 E'## Các Phương Pháp Nông Nghiệp Đô Thị\n\n### Làm Vườn Trong Chậu\n\n- Trồng trong chậu, xô, luống nâng cao trên ban công, sân thượng, bậu cửa sổ\n- Ưu điểm: kiểm soát đất, di động, trồng trong nhà quanh năm\n\n### Thủy Canh\n\nTrồng cây trong nước giàu dinh dưỡng mà không có đất:\n\n| Hệ thống | Mô tả | Phù hợp nhất |\n|----------|-------|-------------|\n| **Kratky** | Thụ động; không cần bơm | Rau lá xanh |\n| **DWC** | Rễ ngâm trong nước có oxy | Tăng trưởng nhanh |\n| **NFT** | Màng nước mỏng trên rễ | Quy mô thương mại |\n\n### Nông Nghiệp Dọc\n\n- Xếp lớp trồng trọt với đèn LED nhân tạo\n- Có thể sản xuất nhiều thực phẩm hơn 100 lần mỗi m² so với nông nghiệp truyền thống\n- Sử dụng ít nước (70-95% ít hơn)\n- Không cần thuốc trừ sâu (môi trường kiểm soát)',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'intro-urban-farming'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["Urban farming methods: container gardening, hydroponics, vertical farming, rooftop gardens, community plots", "Hydroponics grows plants without soil in nutrient solution — faster growth, 70-95% less water", "Vertical farming produces 100× more food per m² using LED lighting in stacked layers", "Urban farms reduce food miles, combat food deserts, and provide community mental health benefits", "Kratky method: simplest hydroponics — passive, no electricity, ideal for beginners growing leafy greens"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'intro-urban-farming'),
 'info_box', 'Singapore Food Security', 'An Ninh Lương Thực Singapore',
 'Singapore imports 90% of its food from 170+ countries. The government''s "30 by 30" goal aims to produce 30% of nutritional needs locally by 2030 through high-tech urban farming. Vertical farms producing 100 tons of vegetables per year now operate in industrial zones, using 95% less land and water than traditional farms.',
 'Singapore nhập khẩu 90% thực phẩm từ hơn 170 quốc gia. Mục tiêu "30 by 30" của chính phủ nhằm sản xuất 30% nhu cầu dinh dưỡng trong nước vào năm 2030 thông qua nông nghiệp đô thị công nghệ cao. Các trang trại dọc sản xuất 100 tấn rau mỗi năm nay hoạt động trong khu công nghiệp, sử dụng ít đất và nước hơn 95% so với trang trại truyền thống.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-urban-farming'),
 'multiple_choice', 'easy',
 'What is the key advantage of vertical farming over traditional field farming?',
 'Lợi thế chính của nông nghiệp dọc so với canh tác đồng ruộng truyền thống là gì?',
 'C',
 'Vertical farming''s primary advantage is land use efficiency — by stacking growing layers, it can produce 100× more food per square meter. This makes it viable in dense urban environments where land is scarce and expensive. It also uses 70-95% less water, requires no pesticides, and can grow year-round regardless of climate.',
 'Lợi thế chính của nông nghiệp dọc là hiệu quả sử dụng đất — bằng cách xếp chồng các lớp trồng trọt, nó có thể sản xuất nhiều thực phẩm hơn 100 lần mỗi m². Điều này làm cho nó khả thi ở môi trường đô thị dày đặc nơi đất khan hiếm và đắt tiền. Nó cũng sử dụng ít nước hơn 70-95%, không cần thuốc trừ sâu và có thể trồng quanh năm.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-urban-farming') AND order_index = 1),
 'A', 'Lower initial investment cost', 'Chi phí đầu tư ban đầu thấp hơn'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-urban-farming') AND order_index = 1),
 'B', 'Greater crop variety options', 'Nhiều lựa chọn đa dạng cây trồng hơn'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-urban-farming') AND order_index = 1),
 'C', 'Produces far more food per square meter of land', 'Sản xuất nhiều thực phẩm hơn nhiều mỗi m² đất'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-urban-farming') AND order_index = 1),
 'D', 'Requires no artificial lighting', 'Không cần ánh sáng nhân tạo');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-urban-farming'),
 'fill_blank', 'easy',
 'Growing plants in a nutrient-rich water solution without any soil is called _____.',
 'Trồng cây trong dung dịch nước giàu dinh dưỡng mà không có đất nào được gọi là _____.',
 'hydroponics',
 'Hydroponics (from Greek: hydro = water, ponos = labor) delivers nutrients directly to plant roots via water, eliminating soil as the medium. Plants grow faster (30-50% faster than soil) because roots don''t need to search for nutrients. Used commercially for lettuce, herbs, tomatoes, and strawberries.',
 'Thủy canh (từ tiếng Hy Lạp: hydro = nước, ponos = lao động) cung cấp chất dinh dưỡng trực tiếp đến rễ cây qua nước, loại bỏ đất như môi trường. Cây trồng nhanh hơn (30-50% nhanh hơn so với đất) vì rễ không cần tìm kiếm chất dinh dưỡng.',
 2),
((SELECT id FROM lesson WHERE slug = 'intro-urban-farming'),
 'true_false', 'medium',
 'Urban farms are only suitable for growing leafy greens and herbs — root vegetables and fruiting crops cannot be grown in cities.',
 'Trang trại đô thị chỉ phù hợp để trồng rau lá xanh và thảo mộc — rau củ và cây cho quả không thể trồng trong thành phố.',
 'false',
 'Urban farming can produce a wide variety of crops including root vegetables (carrots, radishes, potatoes), fruiting crops (tomatoes, peppers, cucumbers, strawberries), and even tree fruits (dwarf apple trees). The key is selecting appropriate container sizes and providing adequate support. Fruiting crops need more light and space than leafy greens.',
 'Nông nghiệp đô thị có thể sản xuất nhiều loại cây trồng bao gồm rau củ (cà rốt, củ cải, khoai tây), cây cho quả (cà chua, ớt, dưa leo, dâu tây) và thậm chí cây ăn quả (cây táo lùn). Chìa khóa là chọn kích thước chậu phù hợp và cung cấp đủ hỗ trợ.',
 3),
((SELECT id FROM lesson WHERE slug = 'intro-urban-farming'),
 'fill_blank', 'medium',
 'Areas in cities where residents have poor access to fresh, healthy food are known as food _____.',
 'Các khu vực trong thành phố nơi cư dân có khả năng tiếp cận kém với thực phẩm tươi lành mạnh được gọi là vùng thiếu _____.',
 'deserts',
 'Food deserts are geographic areas (often low-income urban neighborhoods) where residents lack convenient access to affordable, nutritious food. Studies link food deserts to higher rates of obesity, diabetes, and cardiovascular disease. Urban farms, community gardens, and farmers markets are key interventions to address food deserts.',
 'Vùng thiếu thực phẩm là các khu vực địa lý (thường là khu dân cư đô thị thu nhập thấp) nơi cư dân thiếu khả năng tiếp cận thuận tiện với thực phẩm lành mạnh, giá cả phải chăng. Các nghiên cứu liên kết vùng thiếu thực phẩm với tỷ lệ béo phì, tiểu đường và bệnh tim mạch cao hơn.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-urban-farming'),
 'arrange_words', 'easy',
 'Arrange to describe the Kratky hydroponic method.',
 'Sắp xếp để mô tả phương pháp thủy canh Kratky.',
 'Kratky is a passive hydroponic system requiring no pump or electricity',
 '["passive", "a", "or", "Kratky", "system", "is", "electricity", "no", "requiring", "pump", "hydroponic"]',
 'The Kratky method (developed by B.A. Kratky at University of Hawaii) is the simplest hydroponic system: a container of nutrient solution with a net pot holding the plant. As the plant drinks the solution, an air gap forms above the water, providing oxygen to roots. No pumps, no timers, no electricity — ideal for beginners.',
 'Phương pháp Kratky (được phát triển bởi B.A. Kratky tại Đại học Hawaii) là hệ thống thủy canh đơn giản nhất: bình chứa dung dịch dinh dưỡng với lọ lưới giữ cây. Khi cây uống dung dịch, khoảng không khí hình thành phía trên nước, cung cấp oxy cho rễ. Không có bơm, không có bộ hẹn giờ, không có điện.',
 5);

-- Lesson 8: Aquaponics & Advanced Urban Systems
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Aquaponics & Advanced Urban Systems', 'Nuôi Trồng Kết Hợp & Hệ Thống Đô Thị Nâng Cao', 'aquaponics-urban-systems',
  'Combine fish farming and plant growing in integrated aquaponic systems.',
  'Kết hợp nuôi cá và trồng cây trong hệ thống nuôi trồng kết hợp tích hợp.',
  'intermediate', 40, 2
FROM category WHERE name = 'Urban Farming';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'aquaponics-urban-systems'),
 'Setting up an aquaponic system', 'Thiết lập hệ thống nuôi trồng kết hợp',
 'Building a small tilapia + lettuce aquaponic system for home food production.',
 'Xây dựng hệ thống nuôi trồng kết hợp rô phi nhỏ + rau diếp để sản xuất thực phẩm tại nhà.', 1),
((SELECT id FROM lesson WHERE slug = 'aquaponics-urban-systems'),
 'Balancing the nitrogen cycle', 'Cân bằng chu trình nitơ',
 'Managing ammonia levels through bacterial colonies in an aquaponic system.',
 'Quản lý mức amoniac thông qua khuẩn lạc vi khuẩn trong hệ thống nuôi trồng kết hợp.', 2),
((SELECT id FROM lesson WHERE slug = 'aquaponics-urban-systems'),
 'Commercial urban food production', 'Sản xuất thực phẩm đô thị thương mại',
 'Evaluating container farm economics for a restaurant direct supply chain.',
 'Đánh giá kinh tế trang trại container để cung cấp chuỗi cung ứng trực tiếp cho nhà hàng.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'aquaponics-urban-systems'),
 'markdown', 'Aquaponics: Fish + Plants in Symbiosis', 'Nuôi Trồng Kết Hợp: Cá + Cây Trong Cộng Sinh',
 E'## How Aquaponics Works\n\nAquaponics combines aquaculture (fish farming) + hydroponics (soilless plant growing) in a symbiotic loop:\n\n```\nFish produce waste (ammonia)\n    ↓\nNitrifying bacteria convert: NH₃ → NO₂⁻ → NO₃⁻\n    ↓\nPlants absorb nitrates as fertilizer\n    ↓\nCleaned water returns to fish tank\n```\n\n### The Nitrogen Cycle\n\n**Stage 1**: Fish excrete ammonium (NH₄⁺) and waste\n**Stage 2**: *Nitrosomonas* bacteria oxidize NH₃ → NO₂⁻ (toxic to fish)\n**Stage 3**: *Nitrobacter* bacteria oxidize NO₂⁻ → NO₃⁻ (plant nutrient)\n**Stage 4**: Plants uptake NO₃⁻ → water is purified\n\n### System Components\n\n- **Fish tank**: Tilapia (hardy), trout (cold water), perch, catfish\n- **Grow beds**: Media beds (gravel), raft (floating), NFT channels\n- **Biofilter**: Where nitrogen-converting bacteria colonize\n- **Water pump**: Circulates water between fish tank and grow beds\n\n### Benefits vs Limitations\n\n| Benefit | Limitation |\n|---------|------------|\n| Produces fish + vegetables simultaneously | Complex to set up/balance |\n| Uses 90-95% less water than soil farming | Higher initial cost |\n| No synthetic fertilizers needed | Requires electricity for pumps |\n| Year-round production | Fish care adds daily responsibility |\n| Very high yield per area | Learning curve for nitrogen cycle management |',
 E'## Nuôi Trồng Kết Hợp Hoạt Động Như Thế Nào\n\nNuôi trồng kết hợp kết hợp nuôi trồng thủy sản (nuôi cá) + thủy canh (trồng không đất) trong vòng cộng sinh:\n\n```\nCá tạo ra chất thải (amoniac)\n    ↓\nVi khuẩn nitrat hóa chuyển đổi: NH₃ → NO₂⁻ → NO₃⁻\n    ↓\nCây hấp thụ nitrat làm phân bón\n    ↓\nNước được làm sạch trả lại bể cá\n```\n\n### Chu Trình Nitơ\n\n- Cá thải amoniac (NH₄⁺)\n- Vi khuẩn *Nitrosomonas* oxy hóa NH₃ → NO₂⁻ (độc cho cá)\n- Vi khuẩn *Nitrobacter* oxy hóa NO₂⁻ → NO₃⁻ (dinh dưỡng cho cây)\n- Cây hấp thụ NO₃⁻ → nước được tinh khiết',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'aquaponics-urban-systems'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["Aquaponics = aquaculture (fish) + hydroponics (plants) in a closed-loop symbiotic system", "Nitrogen cycle: fish waste (NH₃) → Nitrosomonas bacteria → NO₂⁻ → Nitrobacter → NO₃⁻ → plant uptake", "Uses 90-95% less water than soil farming — water is continuously recycled", "Popular fish: tilapia (hardy, fast-growing, warm water), trout (cold water), perch, catfish", "Key challenge: maintaining bacterial colony balance — too much ammonia kills fish, too little stunts plants"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'aquaponics-urban-systems'),
 'info_box', 'Ancient Aquaponics', 'Nuôi Trồng Kết Hợp Cổ Đại',
 'Aquaponics is not a modern invention. The Aztec "chinampas" (floating gardens, ~1200-1400 CE) combined fish farming in canals with highly productive raised bed gardens. In ancient China, rice paddies with fish have been cultivated for over 2,000 years — a traditional form of integrated agriculture still practiced today.',
 'Nuôi trồng kết hợp không phải là phát minh hiện đại. "Chinampas" của người Aztec (vườn nổi, khoảng 1200-1400 sau CN) kết hợp nuôi cá trong kênh với các vườn luống nâng cao năng suất cao. Ở Trung Quốc cổ đại, ruộng lúa kết hợp cá đã được canh tác hơn 2.000 năm — một hình thức nông nghiệp tích hợp truyền thống vẫn được thực hành ngày nay.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'aquaponics-urban-systems'),
 'multiple_choice', 'medium',
 'In an aquaponic system, what role do nitrifying bacteria play?',
 'Trong hệ thống nuôi trồng kết hợp, vi khuẩn nitrat hóa đóng vai trò gì?',
 'B',
 'Nitrifying bacteria (Nitrosomonas and Nitrobacter) are the biological bridge in aquaponics. They convert toxic ammonia (fish waste) into nitrites, then into nitrates — which are harmless to fish at normal concentrations and an ideal plant fertilizer. Without these bacteria, ammonia accumulates and kills the fish.',
 'Vi khuẩn nitrat hóa (Nitrosomonas và Nitrobacter) là cầu nối sinh học trong nuôi trồng kết hợp. Chúng chuyển đổi amoniac độc (chất thải cá) thành nitrit, sau đó thành nitrat — vô hại cho cá ở nồng độ bình thường và là phân bón lý tưởng cho cây. Không có những vi khuẩn này, amoniac tích lũy và giết chết cá.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'aquaponics-urban-systems') AND order_index = 1),
 'A', 'They produce oxygen for the fish to breathe', 'Chúng tạo ra oxy cho cá thở'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'aquaponics-urban-systems') AND order_index = 1),
 'B', 'They convert toxic ammonia into plant-usable nitrates', 'Chúng chuyển đổi amoniac độc hại thành nitrat mà cây có thể sử dụng'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'aquaponics-urban-systems') AND order_index = 1),
 'C', 'They compete with plants for nutrients', 'Chúng cạnh tranh với cây để lấy chất dinh dưỡng'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'aquaponics-urban-systems') AND order_index = 1),
 'D', 'They directly feed the fish with decomposed plant matter', 'Chúng nuôi cá trực tiếp bằng chất thực vật đã phân hủy');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'aquaponics-urban-systems'),
 'fill_blank', 'medium',
 'In aquaponics, fish waste provides _____ for the plants, while plants clean the water for the fish.',
 'Trong nuôi trồng kết hợp, chất thải cá cung cấp _____ cho cây, trong khi cây làm sạch nước cho cá.',
 'nutrients',
 'The symbiotic relationship: fish produce waste (containing ammonia/nitrogen compounds), which bacteria convert to nitrates — the primary plant fertilizer. Plants absorb these nutrients, cleaning the water. The cleaned water returns to the fish tank. This closed loop eliminates the need for synthetic fertilizers and produces two food products.',
 'Mối quan hệ cộng sinh: cá tạo ra chất thải (chứa amoniac/hợp chất nitơ), vi khuẩn chuyển đổi thành nitrat — phân bón thực vật chính. Cây hấp thụ các chất dinh dưỡng này, làm sạch nước. Nước sạch trả lại bể cá. Vòng kín này loại bỏ nhu cầu phân bón tổng hợp và sản xuất hai sản phẩm thực phẩm.',
 2),
((SELECT id FROM lesson WHERE slug = 'aquaponics-urban-systems'),
 'true_false', 'easy',
 'Aquaponic systems require 90-95% less water than traditional soil-based farming.',
 'Hệ thống nuôi trồng kết hợp yêu cầu ít nước hơn 90-95% so với canh tác đất truyền thống.',
 'true',
 'Correct. In aquaponics, water is continuously recycled between the fish tank and plant grow beds. The only water lost is through evaporation and transpiration by plants. Traditional soil farming loses enormous amounts to runoff and evaporation. This 90-95% water reduction makes aquaponics highly suitable for water-scarce urban environments.',
 'Đúng. Trong nuôi trồng kết hợp, nước được liên tục tái chế giữa bể cá và luống trồng cây. Nước duy nhất bị mất là qua bay hơi và thoát hơi nước của cây. Canh tác đất truyền thống mất lượng nước khổng lồ do chảy tràn và bay hơi.',
 3),
((SELECT id FROM lesson WHERE slug = 'aquaponics-urban-systems'),
 'sentence_transform', 'medium',
 'Rewrite to describe the correct aquaponics flow: "In aquaponics, plants produce nutrients that feed the fish, and fish clean the water for the plants."',
 'Viết lại để mô tả dòng chảy nuôi trồng kết hợp đúng: "Trong nuôi trồng kết hợp, cây tạo ra chất dinh dưỡng nuôi cá, và cá làm sạch nước cho cây."',
 'In aquaponics, fish produce waste that bacteria convert to nutrients for plants, and plants clean the water for the fish.',
 'The flow is reversed in the original statement. The correct cycle is: Fish → produce waste → nitrifying bacteria convert to nitrates → plants absorb nitrates (nutrients) → clean water returns to fish. Fish do not "clean" the water; plants do. Plants do not "feed" fish; fish feed themselves and their waste feeds plants.',
 'Dòng chảy bị đảo ngược trong câu gốc. Chu kỳ đúng là: Cá → tạo ra chất thải → vi khuẩn nitrat hóa chuyển đổi thành nitrat → cây hấp thụ nitrat (chất dinh dưỡng) → nước sạch trả lại cá. Cá không "làm sạch" nước; cây làm. Cây không "nuôi" cá; cá tự nuôi và chất thải của chúng nuôi cây.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'aquaponics-urban-systems'),
 'arrange_words', 'medium',
 'Arrange to describe the aquaponic nitrogen cycle sequence.',
 'Sắp xếp để mô tả trình tự chu trình nitơ nuôi trồng kết hợp.',
 'Fish waste becomes ammonia which bacteria convert to nitrates for plants',
 '["convert", "bacteria", "waste", "which", "Fish", "to", "plants", "nitrates", "ammonia", "for", "becomes"]',
 'The nitrogen cycle is the heart of aquaponics: Fish excrete ammonia → Nitrosomonas bacteria convert NH₃ to NO₂⁻ → Nitrobacter bacteria convert NO₂⁻ to NO₃⁻ (nitrate) → plants absorb NO₃⁻ → clean water returns to fish. This biological filter (biofilter) must be established ("cycling" the system) before adding fish.',
 'Chu trình nitơ là trái tim của nuôi trồng kết hợp: Cá thải amoniac → Vi khuẩn Nitrosomonas chuyển đổi NH₃ thành NO₂⁻ → Vi khuẩn Nitrobacter chuyển đổi NO₂⁻ thành NO₃⁻ (nitrat) → cây hấp thụ NO₃⁻ → nước sạch trả lại cá. Bộ lọc sinh học (biofilter) này phải được thiết lập ("cycling" hệ thống) trước khi thêm cá.',
 5);
