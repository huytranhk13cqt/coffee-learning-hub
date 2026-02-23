-- ============================================================================
-- SEED DATA: Physics Fundamentals — Extra Lessons
-- Adds 2 lessons to existing category 'Physics Fundamentals'
-- Applied AFTER: seed_physics.sql
-- Do NOT re-insert the category.
-- ============================================================================


-- ############################################################################
-- LESSON 2: THERMODYNAMICS BASICS (slug: thermodynamics-basics)
-- order_index: 2  (Newton's Laws is order_index 1)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Thermodynamics Basics', 'Cơ Bản Nhiệt Động Lực Học',
  'thermodynamics-basics',
  'Understand heat, temperature, the laws of thermodynamics, and entropy',
  'Hiểu nhiệt, nhiệt độ, các định luật nhiệt động lực học và entropy',
  'intermediate', 35, 2
FROM category WHERE name = 'Physics Fundamentals';


-- ============================================================================
-- LESSON USAGES
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'thermodynamics-basics'),
 'The Laws of Thermodynamics', 'Các Định Luật Nhiệt Động Lực Học',
 'Thermodynamics has four laws (numbered 0 through 3). The zeroth law defines temperature. The first law states energy is conserved — it cannot be created or destroyed, only converted between forms. The second law states that entropy (disorder) in an isolated system always increases over time. The third law states that absolute zero (0 Kelvin) is unattainable in practice.',
 'Nhiệt động lực học có bốn định luật (đánh số từ 0 đến 3). Định luật 0 định nghĩa nhiệt độ. Định luật 1 phát biểu năng lượng được bảo toàn — không thể tạo ra hay phá hủy, chỉ chuyển đổi giữa các dạng. Định luật 2 phát biểu entropy (hỗn loạn) trong hệ cô lập luôn tăng theo thời gian. Định luật 3 phát biểu không độ tuyệt đối (0 Kelvin) không thể đạt được trong thực tế.',
 'Thermostat', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'thermodynamics-basics'),
 'Entropy and the Arrow of Time', 'Entropy và Chiều Mũi Tên Thời Gian',
 'Entropy is a measure of disorder or randomness in a system. The second law of thermodynamics says that natural processes tend toward increasing entropy — eggs scramble but do not unscramble, heat flows from hot to cold but not the reverse, perfume spreads through a room but does not spontaneously re-concentrate. Entropy gives time its directionality: the "arrow of time."',
 'Entropy là thước đo mức độ hỗn loạn hoặc ngẫu nhiên trong một hệ. Định luật 2 nhiệt động lực học nói rằng các quá trình tự nhiên có xu hướng tăng entropy — trứng được khuấy nhưng không tự khuấy ngược lại, nhiệt chảy từ nóng sang lạnh nhưng không theo chiều ngược lại, nước hoa lan khắp phòng nhưng không tự tập trung lại. Entropy cho thời gian tính định hướng: "mũi tên thời gian."',
 'Timeline', TRUE, 2);


-- ============================================================================
-- EXAMPLES (2 per usage)
-- ============================================================================

INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES

-- Usage 1: Laws of Thermodynamics
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'thermodynamics-basics') AND order_index = 1),
 'A car engine converts chemical energy (fuel) into mechanical energy (motion) and waste heat. The first law confirms total energy is conserved; the second law explains why some energy is always lost as heat and no engine can be 100% efficient.',
 'Động cơ xe chuyển đổi năng lượng hóa học (nhiên liệu) thành năng lượng cơ học (chuyển động) và nhiệt thải. Định luật 1 xác nhận tổng năng lượng được bảo toàn; định luật 2 giải thích tại sao một số năng lượng luôn thất thoát dưới dạng nhiệt và không động cơ nào có thể đạt 100% hiệu suất.',
 'The maximum theoretical efficiency of a heat engine (Carnot efficiency) depends on the temperature difference between the hot source and cold sink: η = 1 − T_cold/T_hot. A car engine operating between 2000 K and 300 K has a theoretical maximum of ~85% efficiency, but real engines are far below this due to friction and other irreversibilities.',
 'Hiệu suất lý thuyết tối đa của động cơ nhiệt (hiệu suất Carnot) phụ thuộc vào sự chênh lệch nhiệt độ giữa nguồn nóng và bộ tản nhiệt lạnh: η = 1 − T_lạnh/T_nóng. Động cơ xe hoạt động giữa 2000 K và 300 K có hiệu suất tối đa lý thuyết ~85%, nhưng động cơ thực tế thấp hơn nhiều do ma sát và các quá trình không thuận nghịch khác.',
 'first law of thermodynamics', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'thermodynamics-basics') AND order_index = 1),
 'Refrigerators and air conditioners work by moving heat from cold to warm regions — but they require external work (electricity) to do so, consistent with the second law.',
 'Tủ lạnh và máy điều hòa không khí hoạt động bằng cách chuyển nhiệt từ vùng lạnh sang vùng ấm — nhưng chúng cần công bên ngoài (điện) để làm điều này, nhất quán với định luật 2.',
 'The second law allows heat to move from cold to hot only when work is supplied. A refrigerator is not a heat destroyer — it pumps heat from the food compartment to the room. This is why the back of a refrigerator is warm and why running a fridge in an open room cannot cool the room.',
 'Định luật 2 cho phép nhiệt di chuyển từ lạnh sang nóng chỉ khi có công được cung cấp. Tủ lạnh không phải là máy phá hủy nhiệt — nó bơm nhiệt từ khoang thực phẩm ra phòng. Đây là lý do phía sau tủ lạnh ấm và tại sao chạy tủ lạnh trong phòng mở không thể làm mát phòng.',
 'second law', 2),

-- Usage 2: Entropy
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'thermodynamics-basics') AND order_index = 2),
 'When you drop ink into water, it spontaneously spreads and mixes — but the mixed ink never spontaneously separates back. This irreversibility is entropy increasing toward the higher-probability dispersed state.',
 'Khi bạn nhỏ mực vào nước, nó tự nhiên lan ra và trộn lẫn — nhưng mực đã trộn không bao giờ tự tách ra trở lại. Sự không thuận nghịch này là entropy tăng về phía trạng thái phân tán có xác suất cao hơn.',
 'There are vastly more ways for ink molecules to be spread throughout the water than concentrated in one spot. Entropy measures this: high entropy = many possible microstates = high disorder. Systems spontaneously evolve toward higher-entropy states because there are more ways to achieve them.',
 'Có nhiều cách hơn rất nhiều để các phân tử mực phân tán khắp nước so với tập trung ở một điểm. Entropy đo điều này: entropy cao = nhiều trạng thái vi mô có thể xảy ra = hỗn loạn cao. Các hệ thống tự nhiên tiến hóa về phía trạng thái entropy cao hơn vì có nhiều cách để đạt được chúng hơn.',
 'entropy', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'thermodynamics-basics') AND order_index = 2),
 'Stars burn hydrogen into helium (a low-entropy, organized nuclear reaction) while releasing enormous entropy as radiation into cold space. Life also locally decreases entropy by consuming energy — but always increases entropy of the surrounding universe.',
 'Các ngôi sao đốt hydro thành helium (phản ứng hạt nhân có tổ chức, entropy thấp) trong khi giải phóng entropy khổng lồ dưới dạng bức xạ vào không gian lạnh. Sự sống cũng giảm entropy cục bộ bằng cách tiêu thụ năng lượng — nhưng luôn tăng entropy của vũ trụ xung quanh.',
 'The second law applies to isolated systems. Living organisms are not isolated — they consume food (low-entropy energy) and excrete waste heat (high-entropy). Plants use sunlight to build ordered structures (low entropy), but the Sun loses far more entropy in the process. The total entropy of the universe always increases.',
 'Định luật 2 áp dụng cho các hệ cô lập. Sinh vật sống không cô lập — chúng tiêu thụ thực phẩm (năng lượng entropy thấp) và thải ra nhiệt thải (entropy cao). Thực vật dùng ánh sáng mặt trời để xây dựng cấu trúc có trật tự (entropy thấp), nhưng Mặt Trời mất nhiều entropy hơn trong quá trình này. Tổng entropy của vũ trụ luôn tăng.',
 'arrow of time', 2);


-- ============================================================================
-- TIPS
-- ============================================================================

INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES

((SELECT id FROM lesson WHERE slug = 'thermodynamics-basics'),
 'Temperature scales: Kelvin is absolute', 'Thang nhiệt độ: Kelvin là tuyệt đối',
 'Kelvin (K) is the SI unit of temperature. It starts at absolute zero (0 K = −273.15 °C), the coldest possible temperature where all molecular motion stops. Kelvin is essential in thermodynamics equations because Celsius and Fahrenheit have arbitrary zero points. Conversion: K = °C + 273.15. Never say "degrees Kelvin" — just "Kelvin."',
 'Kelvin (K) là đơn vị SI của nhiệt độ. Nó bắt đầu từ không độ tuyệt đối (0 K = −273,15 °C), nhiệt độ lạnh nhất có thể mà tất cả chuyển động phân tử dừng lại. Kelvin thiết yếu trong các phương trình nhiệt động lực học vì Celsius và Fahrenheit có điểm không tùy ý. Chuyển đổi: K = °C + 273,15. Đừng nói "độ Kelvin" — chỉ nói "Kelvin."',
 'common_mistake', 'high', 'Warning', 1),

((SELECT id FROM lesson WHERE slug = 'thermodynamics-basics'),
 'Heat and temperature are not the same', 'Nhiệt và nhiệt độ không giống nhau',
 'Temperature measures the average kinetic energy of molecules. Heat (Q) is the transfer of thermal energy between objects. A bathtub of warm water (30°C) contains far more heat energy than a tiny spark (1000°C) because of the much greater mass and number of molecules. Specific heat capacity determines how much energy a material absorbs per degree of temperature change.',
 'Nhiệt độ đo năng lượng động học trung bình của phân tử. Nhiệt (Q) là sự truyền năng lượng nhiệt giữa các vật. Bồn tắm nước ấm (30°C) chứa nhiều năng lượng nhiệt hơn nhiều so với tia lửa nhỏ (1000°C) vì khối lượng và số phân tử lớn hơn nhiều. Nhiệt dung riêng xác định lượng năng lượng vật liệu hấp thụ trên mỗi độ thay đổi nhiệt độ.',
 'common_mistake', 'high', 'Warning', 2),

((SELECT id FROM lesson WHERE slug = 'thermodynamics-basics'),
 'The second law and the direction of processes', 'Định luật 2 và chiều của các quá trình',
 'The second law tells you which way natural processes go. Heat always flows from hot to cold. Gases always expand into vacuum. Concentration gradients diffuse. These processes are thermodynamically irreversible in practice. The second law does not forbid the reverse — it just makes it astronomically improbable. A broken glass could theoretically reassemble, but the probability is essentially zero.',
 'Định luật 2 cho bạn biết chiều của các quá trình tự nhiên. Nhiệt luôn chảy từ nóng sang lạnh. Khí luôn giãn nở vào chân không. Gradient nồng độ khuếch tán. Các quá trình này không thuận nghịch về mặt nhiệt động lực học trong thực tế. Định luật 2 không cấm chiều ngược lại — nó chỉ làm cho nó cực kỳ ít xảy ra. Ly thủy tinh vỡ về lý thuyết có thể tự lắp ráp lại, nhưng xác suất thực tế bằng không.',
 'general', 'medium', 'Info', 3);


-- ============================================================================
-- LESSON SECTIONS (3 sections: markdown + key_points + info_box)
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

-- Section 1: markdown
((SELECT id FROM lesson WHERE slug = 'thermodynamics-basics'),
 'markdown', 'The Laws of Thermodynamics', 'Các Định Luật Nhiệt Động Lực Học',
'## Thermodynamics: Energy, Heat, and Entropy

Thermodynamics is the branch of physics that studies energy transformations, particularly involving heat and work. It underlies everything from steam engines to black holes.

### The Four Laws

| Law | Statement | Practical Meaning |
|-----|-----------|------------------|
| **Zeroth** | If A and B are each in thermal equilibrium with C, then A and B are in equilibrium with each other | Defines temperature as a measurable quantity |
| **First** | Energy cannot be created or destroyed, only converted | A car engine cannot produce more energy than the fuel contains |
| **Second** | Entropy of an isolated system always increases | Heat flows hot → cold; no 100% efficient engine is possible |
| **Third** | Entropy approaches a constant minimum as temperature → 0 K | Absolute zero (0 K) is unattainable in practice |

### The First Law: Energy Conservation

$$\Delta U = Q - W$$

- $\Delta U$ = change in internal energy
- $Q$ = heat added to the system
- $W$ = work done by the system

Energy is always conserved. When you burn fuel, chemical energy converts to heat and mechanical work — nothing is lost, only transformed.

### The Second Law: Entropy Always Increases

$$\Delta S_{universe} \geq 0$$

The entropy $S$ of the universe never decreases. Natural processes are irreversible. This is why:
- Perpetual motion machines are impossible
- All real engines waste some energy as heat
- You can not unscramble eggs

### Temperature Scales

| Scale | Freezing point of water | Boiling point | Absolute zero |
|-------|------------------------|---------------|---------------|
| Kelvin (K) | 273.15 K | 373.15 K | **0 K** |
| Celsius (°C) | 0 °C | 100 °C | −273.15 °C |
| Fahrenheit (°F) | 32 °F | 212 °F | −459.67 °F |',

'## Nhiệt Động Lực Học: Năng Lượng, Nhiệt và Entropy

Nhiệt động lực học là nhánh vật lý nghiên cứu sự biến đổi năng lượng, đặc biệt liên quan đến nhiệt và công. Nó là nền tảng cho mọi thứ từ động cơ hơi nước đến lỗ đen.

### Bốn Định Luật

| Định luật | Phát biểu | Ý nghĩa thực tế |
|-----------|----------|----------------|
| **Định luật 0** | Nếu A và B mỗi cái đang ở cân bằng nhiệt với C, thì A và B cân bằng với nhau | Định nghĩa nhiệt độ là đại lượng đo được |
| **Định luật 1** | Năng lượng không thể tạo ra hay phá hủy, chỉ chuyển đổi | Động cơ xe không thể tạo ra năng lượng nhiều hơn nhiên liệu chứa |
| **Định luật 2** | Entropy của hệ cô lập luôn tăng | Nhiệt chảy nóng → lạnh; không thể có động cơ 100% hiệu suất |
| **Định luật 3** | Entropy tiến đến hằng số tối thiểu khi nhiệt độ → 0 K | Không độ tuyệt đối (0 K) không thể đạt được trong thực tế |

### Định Luật 1: Bảo Toàn Năng Lượng

$$\Delta U = Q - W$$

- $\Delta U$ = thay đổi nội năng
- $Q$ = nhiệt thêm vào hệ
- $W$ = công do hệ thực hiện

Năng lượng luôn được bảo toàn. Khi đốt nhiên liệu, năng lượng hóa học chuyển thành nhiệt và cơ năng — không có gì mất đi, chỉ biến đổi.

### Định Luật 2: Entropy Luôn Tăng

$$\Delta S_{vũ trụ} \geq 0$$

Entropy $S$ của vũ trụ không bao giờ giảm. Các quá trình tự nhiên là không thuận nghịch. Đây là lý do:
- Máy chuyển động vĩnh cửu là không thể
- Tất cả động cơ thực tế đều lãng phí một số năng lượng dưới dạng nhiệt
- Bạn không thể "hoàn tác" trứng đã khuấy

### Thang Nhiệt Độ

| Thang | Điểm đóng băng nước | Điểm sôi | Không độ tuyệt đối |
|-------|-------------------|---------|------------------|
| Kelvin (K) | 273,15 K | 373,15 K | **0 K** |
| Celsius (°C) | 0 °C | 100 °C | −273,15 °C |
| Fahrenheit (°F) | 32 °F | 212 °F | −459,67 °F |',
 1, '{}'),

-- Section 2: key_points
((SELECT id FROM lesson WHERE slug = 'thermodynamics-basics'),
 'key_points', 'Core Thermodynamics Principles', 'Nguyên Tắc Nhiệt Động Lực Học Cốt Lõi',
 NULL, NULL,
 2,
 '["First Law: energy cannot be created or destroyed — only converted between forms (ΔU = Q − W)", "Second Law: entropy of an isolated system always increases; natural processes are irreversible", "Entropy measures disorder or randomness — systems spontaneously evolve toward higher-entropy states", "No heat engine can be 100% efficient; some energy is always wasted as heat (Carnot limit)", "Kelvin is the absolute temperature scale starting at 0 K (absolute zero), used in all thermodynamic equations"]'::jsonb),

-- Section 3: info_box (zeroth law)
((SELECT id FROM lesson WHERE slug = 'thermodynamics-basics'),
 'info_box', 'The Zeroth Law: Why Temperature Makes Sense', 'Định Luật Thứ Không: Tại Sao Nhiệt Độ Có Nghĩa',
 'The Zeroth Law of Thermodynamics was named "zeroth" because it was recognized after the first and second laws but is logically more fundamental. It states: if two systems are each in thermal equilibrium with a third system, they are in thermal equilibrium with each other. This seemingly obvious statement provides the logical foundation for temperature measurement. It justifies the existence of thermometers: when a thermometer reads 37 °C in contact with your body, both are in equilibrium at the same temperature. Without the Zeroth Law, we could not meaningfully say that two objects "have the same temperature" unless they were in direct contact with each other.',
 'Định luật Nhiệt động lực học Thứ Không được đặt tên là "thứ không" vì nó được nhận ra sau định luật 1 và 2 nhưng về mặt logic cơ bản hơn. Nó phát biểu: nếu hai hệ mỗi cái đang cân bằng nhiệt với hệ thứ ba, chúng cân bằng nhiệt với nhau. Tuyên bố có vẻ hiển nhiên này cung cấp nền tảng logic cho phép đo nhiệt độ. Nó biện minh cho sự tồn tại của nhiệt kế: khi nhiệt kế đọc 37 °C khi tiếp xúc với cơ thể bạn, cả hai đang cân bằng ở cùng nhiệt độ. Không có Định luật Thứ Không, chúng ta không thể nói có ý nghĩa rằng hai vật "có cùng nhiệt độ" trừ khi chúng tiếp xúc trực tiếp với nhau.',
 3, '{"variant": "info"}'::jsonb);


-- ============================================================================
-- EXERCISES (5 exercises)
-- ============================================================================

-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'thermodynamics-basics'),
 'fill_blank', 'easy',
 'The first law of thermodynamics states that energy cannot be created or ___, only transformed from one form to another.',
 'Định luật 1 nhiệt động lực học phát biểu rằng năng lượng không thể được tạo ra hay ___, chỉ được biến đổi từ dạng này sang dạng khác.',
 'destroyed',
 'The first law of thermodynamics is the law of conservation of energy applied to thermodynamic systems. Energy is neither created nor destroyed — it changes form. Chemical energy in fuel becomes heat and mechanical work in an engine. Electrical energy becomes light and heat in a bulb. The total energy of a closed system is always conserved.',
 'Định luật 1 nhiệt động lực học là định luật bảo toàn năng lượng áp dụng cho các hệ nhiệt động lực học. Năng lượng không được tạo ra cũng không bị phá hủy — nó thay đổi dạng. Năng lượng hóa học trong nhiên liệu trở thành nhiệt và cơ năng trong động cơ. Năng lượng điện trở thành ánh sáng và nhiệt trong bóng đèn. Tổng năng lượng của hệ kín luôn được bảo toàn.',
 'Energy is always conserved — what is the opposite of created?', 'Năng lượng luôn được bảo toàn — trái nghĩa của tạo ra là gì?',
 1);


-- Exercise 2: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'thermodynamics-basics'),
 'multiple_choice', 'easy',
 'What does entropy measure in a thermodynamic system?',
 'Entropy đo lường điều gì trong hệ nhiệt động lực học?',
 'Entropy is a measure of the disorder, randomness, or number of possible microscopic configurations (microstates) of a system. Higher entropy means more disorder and more possible arrangements. The second law states that entropy in isolated systems always increases, explaining why natural processes are irreversible.',
 'Entropy là thước đo mức độ hỗn loạn, ngẫu nhiên hoặc số lượng cấu hình vi mô có thể xảy ra (trạng thái vi mô) của hệ. Entropy cao hơn có nghĩa là hỗn loạn hơn và nhiều sắp xếp có thể hơn. Định luật 2 phát biểu entropy trong hệ cô lập luôn tăng, giải thích tại sao các quá trình tự nhiên không thuận nghịch.',
 2);

WITH mc_ex AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'thermodynamics-basics')
  AND type = 'multiple_choice'
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'The temperature of a system', 'Nhiệt độ của một hệ', FALSE, 1 FROM mc_ex
UNION ALL SELECT id, 'B'::option_label, 'The total energy stored in a system', 'Tổng năng lượng lưu trữ trong một hệ', FALSE, 2 FROM mc_ex
UNION ALL SELECT id, 'C'::option_label, 'The disorder or randomness in a system', 'Sự hỗn loạn hoặc ngẫu nhiên trong một hệ', TRUE, 3 FROM mc_ex
UNION ALL SELECT id, 'D'::option_label, 'The pressure of a system', 'Áp suất của một hệ', FALSE, 4 FROM mc_ex;


-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'thermodynamics-basics'),
 'true_false', 'easy',
 'The second law of thermodynamics states that entropy in an isolated system always increases over time.',
 'Định luật 2 nhiệt động lực học phát biểu rằng entropy trong hệ cô lập luôn tăng theo thời gian.',
 'true',
 'This is the direct statement of the second law of thermodynamics. In an isolated system (no energy or matter exchange with surroundings), entropy can never decrease spontaneously. This gives natural processes their direction: heat flows from hot to cold, gases expand, mixed substances do not spontaneously separate. It is one of the most fundamental laws in all of physics.',
 'Đây là phát biểu trực tiếp của định luật 2 nhiệt động lực học. Trong hệ cô lập (không trao đổi năng lượng hay vật chất với môi trường), entropy không bao giờ giảm tự nhiên. Điều này cho các quá trình tự nhiên có chiều hướng: nhiệt chảy từ nóng sang lạnh, khí giãn nở, các chất đã trộn lẫn không tự nhiên tách ra. Đây là một trong những định luật cơ bản nhất trong toàn bộ vật lý học.',
 3);


-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'thermodynamics-basics'),
 'fill_blank', 'easy',
 'Temperature can be measured in Kelvin, Celsius, or ___.',
 'Nhiệt độ có thể được đo bằng Kelvin, Celsius hoặc ___.',
 'Fahrenheit',
 'The three common temperature scales are Kelvin (K), Celsius (°C), and Fahrenheit (°F). Kelvin is the SI (scientific) unit and the only absolute scale. Celsius is the international standard for everyday use. Fahrenheit is used primarily in the United States. For scientific thermodynamic calculations, Kelvin is always used because its zero point (absolute zero) has physical meaning.',
 'Ba thang nhiệt độ phổ biến là Kelvin (K), Celsius (°C) và Fahrenheit (°F). Kelvin là đơn vị SI (khoa học) và là thang tuyệt đối duy nhất. Celsius là tiêu chuẩn quốc tế cho sử dụng hàng ngày. Fahrenheit được sử dụng chủ yếu ở Hoa Kỳ. Đối với các tính toán nhiệt động lực học khoa học, Kelvin luôn được sử dụng vì điểm không của nó (không độ tuyệt đối) có ý nghĩa vật lý.',
 'Think of the scale used primarily in the United States', 'Nghĩ đến thang nhiệt độ được dùng chủ yếu ở Hoa Kỳ',
 4);


-- Exercise 5: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'thermodynamics-basics'),
 'true_false', 'medium',
 'According to the laws of thermodynamics, a heat engine can be 100% efficient.',
 'Theo các định luật nhiệt động lực học, một động cơ nhiệt có thể đạt hiệu suất 100%.',
 'false',
 'The second law of thermodynamics proves that no heat engine operating between two heat reservoirs can be 100% efficient. Some energy is always wasted as heat transferred to the cold reservoir. The maximum theoretical efficiency is the Carnot efficiency: η = 1 − T_cold/T_hot. A 100% efficient heat engine would violate the second law by converting all heat to work with no waste — a perpetual motion machine of the second kind.',
 'Định luật 2 nhiệt động lực học chứng minh không động cơ nhiệt nào hoạt động giữa hai nguồn nhiệt có thể đạt 100% hiệu suất. Một số năng lượng luôn thất thoát dưới dạng nhiệt chuyển sang nguồn lạnh. Hiệu suất lý thuyết tối đa là hiệu suất Carnot: η = 1 − T_lạnh/T_nóng. Động cơ nhiệt 100% hiệu suất sẽ vi phạm định luật 2 bằng cách chuyển đổi tất cả nhiệt thành công không có lãng phí — máy chuyển động vĩnh cửu loại hai.',
 5);


-- ############################################################################
-- LESSON 3: INTRODUCTION TO QUANTUM MECHANICS
-- slug: quantum-mechanics-intro
-- order_index: 3
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Introduction to Quantum Mechanics', 'Giới Thiệu Cơ Học Lượng Tử',
  'quantum-mechanics-intro',
  'Explore wave-particle duality, the uncertainty principle, and quantum states',
  'Khám phá lưỡng tính sóng-hạt, nguyên lý bất định và trạng thái lượng tử',
  'advanced', 45, 3
FROM category WHERE name = 'Physics Fundamentals';


-- ============================================================================
-- LESSON USAGES
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'quantum-mechanics-intro'),
 'Wave-Particle Duality', 'Lưỡng Tính Sóng-Hạt',
 'Light and matter exhibit both wave-like and particle-like behavior depending on how they are observed. In the double-slit experiment, electrons fired one at a time through two slits create an interference pattern (wave behavior), but each electron lands as a point (particle behavior). The act of measurement determines which behavior is observed — a profound departure from classical physics.',
 'Ánh sáng và vật chất thể hiện cả tính chất sóng lẫn hạt tùy thuộc vào cách chúng được quan sát. Trong thí nghiệm hai khe, các electron được bắn từng cái qua hai khe tạo ra mô hình giao thoa (hành vi sóng), nhưng mỗi electron tiếp đất như một điểm (hành vi hạt). Hành động đo lường xác định hành vi nào được quan sát — một sự khác biệt sâu sắc so với vật lý cổ điển.',
 'Waves', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'quantum-mechanics-intro'),
 'Heisenberg Uncertainty Principle', 'Nguyên Lý Bất Định Heisenberg',
 'Werner Heisenberg (1927) proved that it is fundamentally impossible to simultaneously know both the exact position and exact momentum of a quantum particle with arbitrary precision. The more precisely you measure position, the less precisely you can know momentum, and vice versa. This is not due to measurement clumsiness — it is a fundamental property of quantum reality. Mathematically: Δx · Δp ≥ ℏ/2.',
 'Werner Heisenberg (1927) đã chứng minh rằng về mặt cơ bản không thể đồng thời biết cả vị trí chính xác và động lượng chính xác của một hạt lượng tử với độ chính xác tùy ý. Bạn đo vị trí càng chính xác, bạn càng ít biết động lượng, và ngược lại. Đây không phải do sự vụng về trong đo lường — đây là tính chất cơ bản của thực tại lượng tử. Về mặt toán học: Δx · Δp ≥ ℏ/2.',
 'HelpOutline', TRUE, 2);


-- ============================================================================
-- EXAMPLES (2 per usage)
-- ============================================================================

INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES

-- Usage 1: Wave-Particle Duality
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'quantum-mechanics-intro') AND order_index = 1),
 'In the famous double-slit experiment, individual photons fired one at a time through two slits gradually build up an interference pattern on a detector screen — as if each photon passed through both slits simultaneously as a wave.',
 'Trong thí nghiệm hai khe nổi tiếng, các photon đơn lẻ được bắn từng cái qua hai khe dần dần xây dựng mô hình giao thoa trên màn phát hiện — như thể mỗi photon đi qua cả hai khe đồng thời như một sóng.',
 'This experiment has been called the most beautiful experiment in physics. The strange result: when you add a detector to find out which slit the photon passed through, the interference pattern disappears and photons behave as particles. The act of observation collapses the wave-like behavior. This is the essence of quantum weirdness.',
 'Thí nghiệm này được gọi là thí nghiệm đẹp nhất trong vật lý. Kết quả kỳ lạ: khi bạn thêm máy dò để tìm xem photon đi qua khe nào, mô hình giao thoa biến mất và photon cư xử như hạt. Hành động quan sát sụp đổ hành vi giống sóng. Đây là bản chất của sự kỳ lạ lượng tử.',
 'double-slit experiment', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'quantum-mechanics-intro') AND order_index = 1),
 'The photoelectric effect (Einstein, 1905) showed that light behaves as particles (photons): light below a threshold frequency cannot eject electrons from metal regardless of intensity, but a single photon above the threshold always can.',
 'Hiệu ứng quang điện (Einstein, 1905) cho thấy ánh sáng cư xử như hạt (photon): ánh sáng dưới tần số ngưỡng không thể bắn electron ra khỏi kim loại bất kể cường độ, nhưng một photon đơn lẻ trên ngưỡng luôn có thể.',
 'Einstein won the 1921 Nobel Prize for this discovery, not relativity. The photoelectric effect proved light''s particle nature — each photon carries energy E = hf (h is Planck''s constant, f is frequency). This reconciled with light''s known wave behavior to establish the wave-particle duality at the core of quantum mechanics.',
 'Einstein đoạt giải Nobel 1921 cho khám phá này, không phải thuyết tương đối. Hiệu ứng quang điện chứng minh tính chất hạt của ánh sáng — mỗi photon mang năng lượng E = hf (h là hằng số Planck, f là tần số). Điều này hòa giải với hành vi sóng đã biết của ánh sáng để thiết lập lưỡng tính sóng-hạt là cốt lõi của cơ học lượng tử.',
 'photoelectric effect', 2),

-- Usage 2: Uncertainty Principle
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'quantum-mechanics-intro') AND order_index = 2),
 'To locate an electron precisely, you must use short-wavelength (high-energy) photons. But these high-energy photons disturb the electron''s momentum significantly. Using long-wavelength photons disturbs momentum less but gives a fuzzy position — you cannot win both.',
 'Để xác định vị trí electron chính xác, bạn phải dùng photon bước sóng ngắn (năng lượng cao). Nhưng các photon năng lượng cao này làm xáo trộn động lượng electron đáng kể. Dùng photon bước sóng dài làm xáo trộn động lượng ít hơn nhưng cho vị trí mờ — bạn không thể có cả hai.',
 'This is not about imperfect instruments. Even a theoretically perfect measuring device faces the uncertainty principle. Heisenberg showed this follows mathematically from the wave nature of matter described by the Schrödinger equation. Position and momentum are "conjugate variables" — precise knowledge of one inherently limits knowledge of the other.',
 'Đây không phải về dụng cụ không hoàn hảo. Ngay cả thiết bị đo hoàn hảo về lý thuyết cũng đối mặt với nguyên lý bất định. Heisenberg chứng minh điều này theo toán học từ tính chất sóng của vật chất được mô tả bởi phương trình Schrödinger. Vị trí và động lượng là "biến liên hợp" — kiến thức chính xác về một cái vốn dĩ giới hạn kiến thức về cái kia.',
 'uncertainty principle', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'quantum-mechanics-intro') AND order_index = 2),
 'The uncertainty principle explains why electrons do not collapse into the nucleus. Confining an electron to a tiny nucleus would mean very precise position (Δx small), requiring very large momentum uncertainty — meaning the electron would fly out at enormous speed.',
 'Nguyên lý bất định giải thích tại sao electron không sụp đổ vào hạt nhân. Giới hạn electron trong hạt nhân nhỏ có nghĩa là vị trí rất chính xác (Δx nhỏ), đòi hỏi bất định động lượng rất lớn — nghĩa là electron sẽ bay ra với tốc độ khổng lồ.',
 'This solved a major crisis in classical physics: Thomson''s atomic model predicted electrons should spiral into the nucleus within nanoseconds. The uncertainty principle provides the quantum mechanical stabilization that keeps atoms from instantly collapsing — it is why matter exists in stable forms.',
 'Điều này giải quyết một cuộc khủng hoảng lớn trong vật lý cổ điển: mô hình nguyên tử của Thomson dự đoán electron sẽ xoáy vào hạt nhân trong vài nano giây. Nguyên lý bất định cung cấp ổn định cơ học lượng tử giữ nguyên tử không sụp đổ ngay lập tức — đây là lý do vật chất tồn tại ở dạng ổn định.',
 'atomic stability', 2);


-- ============================================================================
-- TIPS
-- ============================================================================

INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES

((SELECT id FROM lesson WHERE slug = 'quantum-mechanics-intro'),
 'Quantum mechanics is not just for the very small', 'Cơ học lượng tử không chỉ dành cho thứ rất nhỏ',
 'Quantum effects are typically negligible for macroscopic objects (baseballs, cars, people) because Planck''s constant (h ≈ 6.63 × 10⁻³⁴ J·s) is incredibly tiny relative to everyday energies and momenta. However, quantum mechanics underlies all of modern technology: transistors, lasers, LEDs, MRI machines, solar cells, and quantum computers all depend on quantum effects.',
 'Các hiệu ứng lượng tử thường không đáng kể đối với vật thể vĩ mô (bóng chày, xe hơi, người) vì hằng số Planck (h ≈ 6,63 × 10⁻³⁴ J·s) cực kỳ nhỏ so với năng lượng và động lượng hàng ngày. Tuy nhiên, cơ học lượng tử là nền tảng của tất cả công nghệ hiện đại: transistor, laser, LED, máy MRI, pin mặt trời và máy tính lượng tử đều phụ thuộc vào các hiệu ứng lượng tử.',
 'general', 'high', 'Lightbulb', 1),

((SELECT id FROM lesson WHERE slug = 'quantum-mechanics-intro'),
 '"God does not play dice" — Einstein was wrong', '"Chúa không chơi xúc xắc" — Einstein đã sai',
 'Einstein famously rejected quantum mechanics'' inherent randomness, saying "God does not play dice." However, Bell''s theorem (1964) and subsequent experiments (Aspect, 1982) proved that quantum randomness is fundamental — not a result of hidden variables that we simply have not measured yet. Quantum events are genuinely random at the deepest level of physical reality.',
 'Einstein nổi tiếng từ chối tính ngẫu nhiên vốn có của cơ học lượng tử, nói rằng "Chúa không chơi xúc xắc." Tuy nhiên, định lý Bell (1964) và các thí nghiệm tiếp theo (Aspect, 1982) đã chứng minh tính ngẫu nhiên lượng tử là cơ bản — không phải kết quả của các biến ẩn mà chúng ta chưa đo được. Các sự kiện lượng tử thực sự ngẫu nhiên ở mức sâu nhất của thực tại vật lý.',
 'common_mistake', 'high', 'Warning', 2),

((SELECT id FROM lesson WHERE slug = 'quantum-mechanics-intro'),
 'Superposition collapses on measurement', 'Chồng chất sụp đổ khi đo lường',
 'A quantum system in superposition exists in multiple states simultaneously — not just unknown, but genuinely in all states at once (described by a wave function). When measured, the wave function "collapses" to one definite state. The probability of each outcome is given by Born''s rule: probability ∝ |ψ|². This interpretation (Copenhagen) remains standard but is philosophically debated.',
 'Hệ lượng tử trong chồng chất tồn tại đồng thời trong nhiều trạng thái — không chỉ là chưa biết, mà thực sự ở tất cả các trạng thái cùng một lúc (được mô tả bởi hàm sóng). Khi được đo, hàm sóng "sụp đổ" về một trạng thái xác định. Xác suất của mỗi kết quả được cho bởi quy tắc Born: xác suất ∝ |ψ|². Cách giải thích này (Copenhagen) vẫn là tiêu chuẩn nhưng đang được tranh luận về mặt triết học.',
 'general', 'medium', 'Info', 3);


-- ============================================================================
-- LESSON SECTIONS (3 sections: markdown + key_points + info_box)
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

-- Section 1: markdown
((SELECT id FROM lesson WHERE slug = 'quantum-mechanics-intro'),
 'markdown', 'The Quantum World: Where Classical Physics Breaks Down', 'Thế Giới Lượng Tử: Nơi Vật Lý Cổ Điển Sụp Đổ',
'## Quantum Mechanics: The Physics of the Very Small

Classical physics (Newton, Maxwell) works perfectly for everyday objects. But at the scale of atoms and subatomic particles, radically different rules apply.

### Wave-Particle Duality

Every quantum object (photon, electron, atom) has both wave-like and particle-like properties:

| Experiment | Wave behavior | Particle behavior |
|------------|---------------|------------------|
| Double-slit | Interference pattern | Each electron lands as a point |
| Photoelectric | — | Energy comes in discrete photon packets |
| Electron diffraction | Diffraction like X-rays | — |

The wave function $\psi(x,t)$ mathematically describes the quantum state. $|\psi|^2$ gives the probability of finding the particle at position $x$.

### The Heisenberg Uncertainty Principle

$$\Delta x \cdot \Delta p \geq \frac{\hbar}{2}$$

- $\Delta x$ = uncertainty in position
- $\Delta p$ = uncertainty in momentum
- $\hbar = h/2\pi$ = reduced Planck''s constant ≈ 1.055 × 10⁻³⁴ J·s

This is a fundamental limit, not a technological limitation. The more precisely you know position, the less precisely you can know momentum.

### Quantum Superposition

A quantum system can exist in a **superposition** of multiple states simultaneously:

$$|\psi\rangle = \alpha|0\rangle + \beta|1\rangle$$

where $|\alpha|^2 + |\beta|^2 = 1$ (probabilities sum to 1).

Measurement collapses the superposition to one definite outcome with probability given by Born''s rule.

### Key Figures

| Physicist | Contribution | Year |
|-----------|-------------|------|
| Planck | Quantization of energy (E = hf) | 1900 |
| Einstein | Photoelectric effect, photons | 1905 |
| Bohr | Hydrogen atom model | 1913 |
| Heisenberg | Uncertainty principle | 1927 |
| Schrödinger | Wave equation | 1926 |',

'## Cơ Học Lượng Tử: Vật Lý Của Thứ Rất Nhỏ

Vật lý cổ điển (Newton, Maxwell) hoạt động hoàn hảo cho các vật thể hàng ngày. Nhưng ở thang nguyên tử và hạt hạ nguyên tử, các quy tắc hoàn toàn khác nhau áp dụng.

### Lưỡng Tính Sóng-Hạt

Mọi đối tượng lượng tử (photon, electron, nguyên tử) đều có cả tính chất sóng lẫn hạt:

| Thí nghiệm | Hành vi sóng | Hành vi hạt |
|------------|------------|-----------|
| Hai khe | Mô hình giao thoa | Mỗi electron tiếp đất như một điểm |
| Quang điện | — | Năng lượng đến trong các gói photon rời rạc |
| Nhiễu xạ electron | Nhiễu xạ như tia X | — |

Hàm sóng $\psi(x,t)$ mô tả toán học trạng thái lượng tử. $|\psi|^2$ cho xác suất tìm thấy hạt tại vị trí $x$.

### Nguyên Lý Bất Định Heisenberg

$$\Delta x \cdot \Delta p \geq \frac{\hbar}{2}$$

- $\Delta x$ = bất định vị trí
- $\Delta p$ = bất định động lượng
- $\hbar = h/2\pi$ = hằng số Planck rút gọn ≈ 1,055 × 10⁻³⁴ J·s

Đây là giới hạn cơ bản, không phải hạn chế công nghệ. Bạn biết vị trí càng chính xác, bạn càng ít biết động lượng.

### Chồng Chất Lượng Tử

Hệ lượng tử có thể tồn tại đồng thời trong **chồng chất** của nhiều trạng thái:

$$|\psi\rangle = \alpha|0\rangle + \beta|1\rangle$$

trong đó $|\alpha|^2 + |\beta|^2 = 1$ (tổng xác suất bằng 1).

Phép đo sụp đổ chồng chất về một kết quả xác định với xác suất được cho bởi quy tắc Born.

### Các Nhà Vật Lý Chính

| Nhà vật lý | Đóng góp | Năm |
|------------|---------|-----|
| Planck | Lượng tử hóa năng lượng (E = hf) | 1900 |
| Einstein | Hiệu ứng quang điện, photon | 1905 |
| Bohr | Mô hình nguyên tử hydro | 1913 |
| Heisenberg | Nguyên lý bất định | 1927 |
| Schrödinger | Phương trình sóng | 1926 |',
 1, '{}'),

-- Section 2: key_points
((SELECT id FROM lesson WHERE slug = 'quantum-mechanics-intro'),
 'key_points', 'Core Quantum Mechanics Concepts', 'Khái Niệm Cốt Lõi Cơ Học Lượng Tử',
 NULL, NULL,
 2,
 '["Wave-particle duality: quantum objects exhibit both wave-like and particle-like behavior depending on how they are observed", "Heisenberg Uncertainty Principle: Δx · Δp ≥ ℏ/2 — you cannot simultaneously know exact position and exact momentum", "Superposition: a quantum system exists in multiple states simultaneously until measurement collapses it to one state", "Quantization: energy, charge, and angular momentum come in discrete packets (quanta), not continuous values", "Quantum mechanics is not intuitive but is experimentally verified to extreme precision and underlies all modern electronics"]'::jsonb),

-- Section 3: info_box (Schrödinger's Cat)
((SELECT id FROM lesson WHERE slug = 'quantum-mechanics-intro'),
 'info_box', 'Schrödinger''s Cat: A Thought Experiment', 'Con Mèo Của Schrödinger: Một Thí Nghiệm Tư Duy',
 'Erwin Schrödinger proposed his famous thought experiment in 1935 to illustrate the apparent absurdity of applying quantum superposition to macroscopic objects. A cat is placed in a sealed box with a radioactive atom, a Geiger counter, and a poison capsule. If the atom decays (a quantum event), the Geiger counter triggers and releases the poison, killing the cat. Before you open the box and observe, the atom is in a superposition of "decayed" and "not decayed." According to strict quantum mechanics, the cat is therefore simultaneously alive and dead — in superposition — until observation collapses the wave function. Schrödinger intended this as a reductio ad absurdum critique: quantum superposition cannot literally mean macroscopic objects exist in multiple states. Modern interpretations (decoherence theory, many-worlds interpretation) attempt to explain why quantum weirdness does not appear at human scales, but the thought experiment remains the most famous illustration of the measurement problem in quantum mechanics.',
 'Erwin Schrödinger đề xuất thí nghiệm tư duy nổi tiếng của mình năm 1935 để minh họa sự vô lý rõ ràng của việc áp dụng chồng chất lượng tử cho các vật thể vĩ mô. Một con mèo được đặt trong hộp kín với một nguyên tử phóng xạ, máy đếm Geiger và viên nang độc. Nếu nguyên tử phân rã (một sự kiện lượng tử), máy đếm Geiger kích hoạt và giải phóng chất độc, giết chết mèo. Trước khi bạn mở hộp và quan sát, nguyên tử đang ở chồng chất "đã phân rã" và "chưa phân rã." Theo cơ học lượng tử nghiêm ngặt, con mèo do đó đồng thời sống và chết — trong chồng chất — cho đến khi quan sát sụp đổ hàm sóng. Schrödinger dự định đây là phê phán reductio ad absurdum: chồng chất lượng tử không thể theo nghĩa đen có nghĩa là các vật thể vĩ mô tồn tại trong nhiều trạng thái. Các giải thích hiện đại (lý thuyết giải kết hợp, giải thích đa thế giới) cố gắng giải thích tại sao sự kỳ lạ lượng tử không xuất hiện ở thang con người, nhưng thí nghiệm tư duy vẫn là minh họa nổi tiếng nhất về vấn đề đo lường trong cơ học lượng tử.',
 3, '{"variant": "info"}'::jsonb);


-- ============================================================================
-- EXERCISES (5 exercises)
-- ============================================================================

-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'quantum-mechanics-intro'),
 'fill_blank', 'medium',
 'Wave-particle duality states that light and matter exhibit both ___ and particle properties.',
 'Lưỡng tính sóng-hạt phát biểu rằng ánh sáng và vật chất thể hiện cả tính chất ___ lẫn hạt.',
 'wave',
 'Wave-particle duality is one of the central principles of quantum mechanics. Quantum objects like photons and electrons cannot be described as purely waves or purely particles — they exhibit both behaviors depending on the experimental setup. When not observed, they behave as waves (producing interference patterns); when measured, they behave as particles (discrete impacts at specific locations).',
 'Lưỡng tính sóng-hạt là một trong những nguyên lý trung tâm của cơ học lượng tử. Các đối tượng lượng tử như photon và electron không thể được mô tả là thuần túy sóng hay thuần túy hạt — chúng thể hiện cả hai hành vi tùy thuộc vào thiết lập thí nghiệm. Khi không được quan sát, chúng cư xử như sóng (tạo ra mô hình giao thoa); khi được đo, chúng cư xử như hạt (các va chạm rời rạc tại các vị trí cụ thể).',
 'The other property is "particle" — what is the complementary property?', 'Tính chất kia là "hạt" — tính chất bổ sung là gì?',
 1);


-- Exercise 2: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'quantum-mechanics-intro'),
 'multiple_choice', 'medium',
 'Who formulated the uncertainty principle?',
 'Ai đã phát triển nguyên lý bất định?',
 'Werner Heisenberg formulated the uncertainty principle in 1927. It states that Δx · Δp ≥ ℏ/2 — the product of the uncertainties in position (Δx) and momentum (Δp) is always at least ℏ/2. Heisenberg later won the Nobel Prize in Physics in 1932 for his creation of quantum mechanics.',
 'Werner Heisenberg phát triển nguyên lý bất định năm 1927. Nó phát biểu rằng Δx · Δp ≥ ℏ/2 — tích của bất định vị trí (Δx) và động lượng (Δp) luôn ít nhất bằng ℏ/2. Heisenberg sau đó đoạt giải Nobel Vật lý năm 1932 vì sự tạo ra cơ học lượng tử của ông.',
 2);

WITH mc_ex AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'quantum-mechanics-intro')
  AND type = 'multiple_choice'
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'Albert Einstein', 'Albert Einstein', FALSE, 1 FROM mc_ex
UNION ALL SELECT id, 'B'::option_label, 'Niels Bohr', 'Niels Bohr', FALSE, 2 FROM mc_ex
UNION ALL SELECT id, 'C'::option_label, 'Werner Heisenberg', 'Werner Heisenberg', TRUE, 3 FROM mc_ex
UNION ALL SELECT id, 'D'::option_label, 'Erwin Schrödinger', 'Erwin Schrödinger', FALSE, 4 FROM mc_ex;


-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'quantum-mechanics-intro'),
 'true_false', 'medium',
 'At the quantum level, you cannot simultaneously know both the exact position and exact momentum of a particle.',
 'Ở mức lượng tử, bạn không thể đồng thời biết cả vị trí chính xác và động lượng chính xác của một hạt.',
 'true',
 'This is the Heisenberg Uncertainty Principle: Δx · Δp ≥ ℏ/2. The more precisely you determine a particle''s position (small Δx), the less precisely you can know its momentum (large Δp), and vice versa. This is not a limitation of our instruments or knowledge — it is a fundamental property of quantum reality arising from the wave nature of matter.',
 'Đây là Nguyên Lý Bất Định Heisenberg: Δx · Δp ≥ ℏ/2. Bạn xác định vị trí hạt càng chính xác (Δx nhỏ), bạn càng ít biết động lượng của nó (Δp lớn), và ngược lại. Đây không phải hạn chế của dụng cụ hay kiến thức của chúng ta — đây là tính chất cơ bản của thực tại lượng tử xuất phát từ tính chất sóng của vật chất.',
 3);


-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'quantum-mechanics-intro'),
 'fill_blank', 'hard',
 'A quantum system that exists in multiple states simultaneously until measured is said to be in ___.',
 'Hệ lượng tử tồn tại đồng thời trong nhiều trạng thái cho đến khi được đo được gọi là đang ở trạng thái ___.',
 'superposition',
 'Quantum superposition means a quantum system genuinely exists in multiple states simultaneously, described mathematically by a wave function that is a sum of state vectors. This is not ignorance about the true state — the system literally has no definite state until measured. Schrödinger''s cat thought experiment illustrates how strange this becomes when applied to macroscopic objects.',
 'Chồng chất lượng tử có nghĩa là hệ lượng tử thực sự tồn tại đồng thời trong nhiều trạng thái, được mô tả toán học bởi hàm sóng là tổng của các vectơ trạng thái. Đây không phải là sự thiếu hiểu biết về trạng thái thực — hệ thống theo nghĩa đen không có trạng thái xác định cho đến khi được đo. Thí nghiệm tư duy con mèo Schrödinger minh họa sự kỳ lạ này khi áp dụng cho các vật thể vĩ mô.',
 'Schrödinger''s cat illustrates this concept', 'Con mèo Schrödinger minh họa khái niệm này',
 4);


-- Exercise 5: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'quantum-mechanics-intro'),
 'true_false', 'easy',
 'Schrödinger''s cat thought experiment illustrates the concept of quantum superposition applied to a macroscopic system.',
 'Thí nghiệm tư duy con mèo Schrödinger minh họa khái niệm chồng chất lượng tử áp dụng cho hệ vĩ mô.',
 'true',
 'Schrödinger proposed this experiment to highlight the apparent absurdity of applying quantum superposition — where a system exists in multiple states simultaneously — to a macroscopic object like a cat. Before the box is opened and observed, quantum mechanics suggests the cat is simultaneously alive and dead in superposition, which mirrors the decay/non-decay superposition of the radioactive atom inside. Schrödinger meant it as a critique, but it became the most famous illustration of quantum superposition.',
 'Schrödinger đề xuất thí nghiệm này để nêu bật sự vô lý rõ ràng của việc áp dụng chồng chất lượng tử — nơi hệ tồn tại đồng thời trong nhiều trạng thái — cho một vật thể vĩ mô như mèo. Trước khi hộp được mở và quan sát, cơ học lượng tử cho rằng con mèo đồng thời sống và chết trong chồng chất, phản chiếu chồng chất phân rã/chưa phân rã của nguyên tử phóng xạ bên trong. Schrödinger muốn nó như một lời phê bình, nhưng nó trở thành minh họa nổi tiếng nhất về chồng chất lượng tử.',
 5);
