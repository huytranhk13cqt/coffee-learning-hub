-- ============================================================================
-- SEED DATA: Physics Fundamentals (1 lesson)
-- Category: Physics Fundamentals (ID 13)
-- Lesson: Newton's Laws of Motion
-- Compatible with: schema.sql v7+
-- Applied AFTER: seed_data, seed_python, seed_math, seed_cybersecurity,
--                seed_psychology, seed_design, seed_history, seed_music,
--                seed_philosophy (categories 1–12)
-- Demonstrates: chart section (bar — weight comparison Earth vs Moon)
-- ============================================================================

-- ============================================================================
-- CATEGORY 13: Physics Fundamentals
-- ============================================================================

INSERT INTO category (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('Physics Fundamentals', 'Vật Lý Cơ Bản',
 'Discover the laws governing our universe: mechanics, forces, motion, and energy',
 'Khám phá các định luật chi phối vũ trụ: cơ học, lực, chuyển động và năng lượng',
 'Science', '#0ea5e9', 13);


-- ############################################################################
-- LESSON: NEWTON'S LAWS OF MOTION (slug: physics-newtons-laws)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Newton''s Laws of Motion', 'Định Luật Newton Về Chuyển Động',
  'physics-newtons-laws',
  'Master Newton''s three laws: inertia, F=ma, and action-reaction pairs',
  'Nắm vững ba định luật Newton: quán tính, F=ma và cặp lực hành động-phản ứng',
  'beginner', 25, 1
FROM category WHERE name = 'Physics Fundamentals';


-- ============================================================================
-- LESSON USAGES
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'physics-newtons-laws'),
 'Newton''s First Law: Inertia', 'Định luật 1: Quán tính',
 'An object at rest stays at rest, and an object in motion stays in motion with the same speed and direction, unless acted upon by an unbalanced force. This tendency is called inertia.',
 'Một vật đứng yên sẽ tiếp tục đứng yên, và vật chuyển động sẽ tiếp tục chuyển động với cùng tốc độ và hướng, trừ khi có lực không cân bằng tác dụng vào nó. Xu hướng này gọi là quán tính.',
 'Refresh', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'physics-newtons-laws'),
 'Newton''s Second Law: F = ma', 'Định luật 2: F = ma',
 'The acceleration of an object is directly proportional to the net force and inversely proportional to its mass. F = ma, where F is force in Newtons (N), m is mass in kg, and a is acceleration in m/s².',
 'Gia tốc của vật tỉ lệ thuận với hợp lực và tỉ lệ nghịch với khối lượng. F = ma, trong đó F là lực (N), m là khối lượng (kg), a là gia tốc (m/s²).',
 'Functions', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'physics-newtons-laws'),
 'Newton''s Third Law: Action-Reaction', 'Định luật 3: Hành động và phản ứng',
 'For every action, there is an equal and opposite reaction. When object A exerts a force on object B, object B simultaneously exerts a force equal in magnitude and opposite in direction on object A.',
 'Với mỗi hành động, có một phản ứng bằng nhau và ngược chiều. Khi vật A tác dụng lực lên vật B, vật B đồng thời tác dụng lực bằng độ lớn nhưng ngược chiều lên vật A.',
 'CompareArrows', TRUE, 3);


-- ============================================================================
-- EXAMPLES (2 per usage)
-- ============================================================================

INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES

-- Usage 1: Inertia
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'physics-newtons-laws') AND order_index = 1),
 'A hockey puck sliding on ice keeps moving in a straight line because friction is nearly zero, demonstrating Newton''s First Law.',
 'Một puck khúc côn cầu trượt trên băng tiếp tục di chuyển theo đường thẳng vì ma sát gần như bằng không, minh chứng Định luật 1 Newton.',
 'Inertia is why passengers lurch forward when a car brakes — their bodies want to keep moving while the car decelerates. Seatbelts provide the unbalanced force that stops them.',
 'Quán tính là lý do hành khách bị đẩy về phía trước khi xe phanh — cơ thể muốn tiếp tục di chuyển trong khi xe giảm tốc. Dây an toàn cung cấp lực không cân bằng dừng họ lại.',
 'inertia', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'physics-newtons-laws') AND order_index = 1),
 'In outer space, a thrown ball travels in a straight line forever because there is no air resistance or friction to slow it down.',
 'Trong vũ trụ, quả bóng được ném sẽ di chuyển thẳng mãi mãi vì không có sức cản không khí hay ma sát để làm chậm nó.',
 'This is why spacecraft travel to distant planets without constantly firing engines — once in motion, they stay in motion due to inertia.',
 'Đây là lý do tàu vũ trụ bay đến hành tinh xa mà không cần liên tục nổ động cơ — một khi đã chuyển động, chúng tiếp tục nhờ quán tính.',
 'outer space', 2),

-- Usage 2: F = ma
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'physics-newtons-laws') AND order_index = 2),
 'Pushing a 10 kg cart with 20 N of force produces acceleration: a = F/m = 20/10 = 2 m/s².',
 'Đẩy xe 10 kg bằng lực 20 N tạo gia tốc: a = F/m = 20/10 = 2 m/s².',
 'If you double the force to 40 N (same mass), acceleration doubles to 4 m/s². If you double the mass (same force), acceleration halves. This explains why heavy trucks accelerate slower than sports cars with equal engine force.',
 'Nếu tăng gấp đôi lực lên 40 N (cùng khối lượng), gia tốc tăng gấp đôi lên 4 m/s². Nếu tăng gấp đôi khối lượng (cùng lực), gia tốc giảm một nửa. Điều này giải thích tại sao xe tải nặng gia tốc chậm hơn xe thể thao với cùng lực động cơ.',
 'a = F/m', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'physics-newtons-laws') AND order_index = 2),
 'On the Moon (g = 1.6 m/s²), a 70 kg person weighs F = ma = 70 × 1.6 = 112 N, versus 686 N on Earth (g = 9.8 m/s²).',
 'Trên Mặt Trăng (g = 1,6 m/s²), người 70 kg nặng F = ma = 70 × 1,6 = 112 N, so với 686 N trên Trái Đất (g = 9,8 m/s²).',
 'Weight is force, not mass. Your mass is 70 kg everywhere. Weight changes with gravitational acceleration. An astronaut on the Moon is 6× lighter but has the same mass — they throw a ball just as hard horizontally.',
 'Trọng lượng là lực, không phải khối lượng. Khối lượng của bạn là 70 kg ở khắp nơi. Trọng lượng thay đổi theo gia tốc trọng trường. Phi hành gia trên Mặt Trăng nhẹ hơn 6 lần nhưng có cùng khối lượng.',
 'weight vs mass', 2),

-- Usage 3: Action-Reaction
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'physics-newtons-laws') AND order_index = 3),
 'When you fire a gun, the bullet flies forward and the gun recoils backward — both forces are equal in magnitude but opposite in direction.',
 'Khi bắn súng, viên đạn bay về phía trước và súng giật về phía sau — cả hai lực bằng nhau về độ lớn nhưng ngược chiều nhau.',
 'Gun and bullet form an action-reaction pair. The gun has much greater mass than the bullet, so by F=ma, the gun accelerates much less (small recoil) while the bullet accelerates dramatically (high speed).',
 'Súng và đạn tạo thành cặp hành động-phản ứng. Súng có khối lượng lớn hơn nhiều nên theo F=ma, súng gia tốc ít hơn (giật nhỏ) trong khi đạn gia tốc mạnh (tốc độ cao).',
 'action-reaction', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'physics-newtons-laws') AND order_index = 3),
 'A rocket engine expels hot gas downward (action), which propels the rocket upward (reaction) — no air is needed to push against in space.',
 'Động cơ tên lửa phụt khí nóng xuống dưới (hành động), đẩy tên lửa lên trên (phản ứng) — không cần không khí để đẩy ngược trong vũ trụ.',
 'Common misconception: rockets don''t "push against air." They work purely by Newton''s Third Law — ejecting mass in one direction gains momentum in the opposite direction. This is why rockets function in the vacuum of space.',
 'Hiểu lầm phổ biến: tên lửa không "đẩy ngược không khí." Chúng hoạt động hoàn toàn theo Định luật 3 Newton — đẩy khối lượng theo một hướng để đạt động lượng theo hướng kia. Đây là lý do tên lửa hoạt động trong chân không vũ trụ.',
 'rocket propulsion', 2);


-- ============================================================================
-- TIPS
-- ============================================================================

INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES

((SELECT id FROM lesson WHERE slug = 'physics-newtons-laws'),
 'Weight vs. Mass: the most common physics mistake', 'Trọng lượng và Khối lượng: sai lầm phổ biến nhất',
 'Mass (kg) measures how much matter an object contains — it never changes. Weight (N) is a force = mass × gravitational acceleration. On Earth: W = m × 9.8. On Moon: W = m × 1.6. An astronaut weighs 6× less on the Moon, but their mass is identical.',
 'Khối lượng (kg) đo lượng vật chất — không bao giờ thay đổi. Trọng lượng (N) là lực = khối lượng × gia tốc trọng trường. Trên Trái Đất: W = m × 9,8. Trên Mặt Trăng: W = m × 1,6. Phi hành gia nhẹ hơn 6 lần trên Mặt Trăng nhưng khối lượng giống hệt.',
 'common_mistake', 'high', 'Warning', 1),

((SELECT id FROM lesson WHERE slug = 'physics-newtons-laws'),
 'Draw free body diagrams before solving', 'Vẽ sơ đồ lực tự do trước khi giải',
 'Before applying F = ma, draw every force acting on the object as an arrow. Label each with direction and magnitude. Then sum forces in x and y directions separately. A 5-second diagram saves 5 minutes of recalculation.',
 'Trước khi áp dụng F = ma, vẽ mỗi lực tác dụng lên vật dưới dạng mũi tên. Ghi nhãn hướng và độ lớn. Sau đó tổng hợp lực theo hướng x và y riêng biệt. Một sơ đồ 5 giây tiết kiệm 5 phút tính lại.',
 'shortcut', 'high', 'Lightbulb', 2),

((SELECT id FROM lesson WHERE slug = 'physics-newtons-laws'),
 'Newton''s Laws are approximations — valid for everyday speeds', 'Định luật Newton là xấp xỉ — đúng cho tốc độ thông thường',
 'Newton''s Laws work perfectly for everyday objects at slow-to-medium speeds. They break down near the speed of light (requiring Einstein''s Special Relativity) and at quantum scale (requiring Quantum Mechanics). For 99.9% of real engineering — cars, bridges, planets — Newton is accurate.',
 'Định luật Newton hoạt động hoàn hảo cho vật thể thông thường ở tốc độ chậm đến trung bình. Chúng không chính xác gần tốc độ ánh sáng (cần Thuyết Tương Đối) và ở thang lượng tử (cần Cơ Học Lượng Tử). Với 99,9% kỹ thuật thực tế — xe hơi, cầu đường, hành tinh — Newton hoàn toàn chính xác.',
 'general', 'medium', 'Info', 3);


-- ============================================================================
-- LESSON SECTIONS (3 sections: markdown + chart + key_points)
-- Demonstrates: chart section (bar chart — F=mg weight on Earth vs Moon)
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

-- Section 1: markdown with KaTeX formulas
((SELECT id FROM lesson WHERE slug = 'physics-newtons-laws'),
 'markdown', 'Newton''s Three Laws Explained', 'Ba Định Luật Newton Giải Thích',
'## Newton''s Laws of Motion

Sir Isaac Newton published his three laws in *Principia Mathematica* (1687). They remain the foundation of **classical mechanics**.

### The Three Laws at a Glance

| Law | Name | Statement |
|-----|------|-----------|
| **1st** | Law of Inertia | Objects remain at rest or in uniform motion unless a net force acts |
| **2nd** | Law of Acceleration | $F = ma$ — force equals mass times acceleration |
| **3rd** | Action-Reaction | Every force has an equal and opposite reaction force |

### Newton''s Second Law: F = ma

$$F = m \times a$$

- $F$ = Force in **Newtons (N)**
- $m$ = Mass in **kilograms (kg)**
- $a$ = Acceleration in **m/s²**

**Rearranging for any variable:**
$$a = \frac{F}{m} \qquad m = \frac{F}{a}$$

### Weight as a Force

Weight is *not* mass — weight is a gravitational force:
$$W = m \times g$$

| Location | $g$ | Weight of 70 kg person |
|----------|-----|----------------------|
| Earth | $9.8 \text{ m/s}^2$ | $686 \text{ N}$ |
| Moon | $1.6 \text{ m/s}^2$ | $112 \text{ N}$ |
| Mars | $3.7 \text{ m/s}^2$ | $259 \text{ N}$ |',

'## Định Luật Newton Về Chuyển Động

Sir Isaac Newton công bố ba định luật trong *Principia Mathematica* (1687). Chúng vẫn là nền tảng của **cơ học cổ điển**.

### Ba Định Luật Tóm Gọn

| Định luật | Tên | Phát biểu |
|-----------|-----|-----------|
| **1** | Định luật Quán tính | Vật đứng yên hoặc chuyển động thẳng đều trừ khi có hợp lực |
| **2** | Định luật Gia tốc | $F = ma$ — lực bằng khối lượng nhân gia tốc |
| **3** | Hành động-Phản ứng | Mỗi lực có lực phản ứng bằng nhau và ngược chiều |

### Định Luật 2: F = ma

$$F = m \times a$$

- $F$ = Lực tính bằng **Newton (N)**
- $m$ = Khối lượng tính bằng **kilôgam (kg)**
- $a$ = Gia tốc tính bằng **m/s²**

**Biến đổi để tìm biến bất kỳ:**
$$a = \frac{F}{m} \qquad m = \frac{F}{a}$$

### Trọng Lượng Là Lực

Trọng lượng *không phải* khối lượng — trọng lượng là lực hấp dẫn:
$$W = m \times g$$

| Vị trí | $g$ | Trọng lượng người 70 kg |
|--------|-----|------------------------|
| Trái Đất | $9,8 \text{ m/s}^2$ | $686 \text{ N}$ |
| Mặt Trăng | $1,6 \text{ m/s}^2$ | $112 \text{ N}$ |
| Sao Hỏa | $3,7 \text{ m/s}^2$ | $259 \text{ N}$ |',
1, '{}'),

-- Section 2: chart (bar chart — weight on Earth vs Moon for same objects)
((SELECT id FROM lesson WHERE slug = 'physics-newtons-laws'),
 'chart', 'Weight on Earth vs. Moon (F = mg)', 'Trọng Lượng Trái Đất và Mặt Trăng (F = mg)',
 'The same object has very different weights on Earth (g = 9.8 m/s²) vs. the Moon (g = 1.6 m/s²) because weight = mass × g. Mass never changes.',
 'Cùng một vật có trọng lượng rất khác nhau trên Trái Đất (g = 9,8 m/s²) và Mặt Trăng (g = 1,6 m/s²) vì trọng lượng = khối lượng × g. Khối lượng không bao giờ thay đổi.',
 2,
 '{"chartType":"bar","xKey":"object","series":[{"dataKey":"earth","name":"Trái Đất (g=9.8)"},{"dataKey":"moon","name":"Mặt Trăng (g=1.6)"}],"data":[{"object":"Người 70kg","earth":686,"moon":112},{"object":"Xe đạp 10kg","earth":98,"moon":16},{"object":"Sách 1kg","earth":9.8,"moon":1.6},{"object":"Bóng 0.5kg","earth":4.9,"moon":0.8}],"colors":["#6366f1","#f59e0b"]}'),

-- Section 3: key_points
((SELECT id FROM lesson WHERE slug = 'physics-newtons-laws'),
 'key_points', 'Key Physics Principles', 'Nguyên Tắc Vật Lý Quan Trọng',
 '- **Newton''s 1st Law (Inertia)** — objects resist changes to their motion; a net force is required to change speed or direction
- **Newton''s 2nd Law (F=ma)** — the most important equation in classical mechanics; larger force → more acceleration; larger mass → less acceleration
- **Newton''s 3rd Law (Action-Reaction)** — forces always come in pairs; action and reaction act on *different* objects
- **Weight ≠ Mass** — mass (kg) is constant everywhere; weight (N) depends on local gravity: $W = mg$
- **SI units** — force in Newtons (N), mass in kg, acceleration in m/s²; 1 N = 1 kg⋅m/s²',
 '- **Định luật 1 Newton (Quán tính)** — vật chống lại thay đổi chuyển động; cần hợp lực để thay đổi tốc độ hoặc hướng
- **Định luật 2 Newton (F=ma)** — phương trình quan trọng nhất trong cơ học cổ điển; lực lớn hơn → gia tốc nhiều hơn; khối lượng lớn hơn → gia tốc ít hơn
- **Định luật 3 Newton (Hành động-Phản ứng)** — lực luôn xuất hiện theo cặp; hành động và phản ứng tác dụng lên *hai vật khác nhau*
- **Trọng lượng ≠ Khối lượng** — khối lượng (kg) không đổi ở khắp nơi; trọng lượng (N) phụ thuộc trọng lực địa phương: $W = mg$
- **Đơn vị SI** — lực tính bằng Newton (N), khối lượng bằng kg, gia tốc bằng m/s²; 1 N = 1 kg⋅m/s²',
 3, '{}');


-- ============================================================================
-- EXERCISES (7 exercises — all types)
-- ============================================================================

-- Exercise 1: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'physics-newtons-laws'),
 'multiple_choice', 'easy',
 'Which formula correctly represents Newton''s Second Law of Motion?',
 'Công thức nào biểu diễn đúng Định luật 2 Newton?',
 'Newton''s Second Law: Force = mass × acceleration (F = ma). Rearranging: a = F/m, so acceleration depends on both force and mass.',
 'Định luật 2 Newton: Lực = khối lượng × gia tốc (F = ma). Biến đổi: a = F/m, nên gia tốc phụ thuộc vào cả lực và khối lượng.',
 1);

WITH mc_ex AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'physics-newtons-laws')
  AND type = 'multiple_choice'
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'F = ma', 'F = ma', TRUE, 1 FROM mc_ex
UNION ALL SELECT id, 'B'::option_label, 'F = mv', 'F = mv', FALSE, 2 FROM mc_ex
UNION ALL SELECT id, 'C'::option_label, 'E = mc²', 'E = mc²', FALSE, 3 FROM mc_ex
UNION ALL SELECT id, 'D'::option_label, 'W = mg (weight only)', 'W = mg (chỉ tính trọng lượng)', FALSE, 4 FROM mc_ex;


-- Exercise 2: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'physics-newtons-laws'),
 'fill_blank', 'easy',
 'A 5 kg object is pushed with a force of 20 N. What is its acceleration (in m/s²)?',
 'Một vật 5 kg bị đẩy bằng lực 20 N. Gia tốc của nó là bao nhiêu (tính bằng m/s²)?',
 '4',
 'Using F = ma, rearrange to find a: a = F/m = 20 N ÷ 5 kg = 4 m/s². Always rearrange the formula before substituting values.',
 'Dùng F = ma, biến đổi để tìm a: a = F/m = 20 N ÷ 5 kg = 4 m/s². Luôn biến đổi công thức trước khi thay số.',
 'Rearrange F = ma to solve for a', 'Biến đổi F = ma để tìm a',
 2);


-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'physics-newtons-laws'),
 'true_false', 'easy',
 'According to Newton''s 3rd Law, when you push a wall, the wall pushes back on you with an equal and opposite force.',
 'Theo Định luật 3 Newton, khi bạn đẩy tường, tường đẩy lại bạn với lực bằng nhau và ngược chiều.',
 'true',
 'This is exactly Newton''s Third Law: for every action there is an equal and opposite reaction. The wall exerts a normal force equal to what you push. This is why pushing hard hurts your hand — the wall pushes back with the same force.',
 'Đây chính xác là Định luật 3 Newton: với mỗi hành động có phản ứng bằng nhau và ngược chiều. Tường tác dụng lực pháp tuyến bằng lực bạn đẩy. Đây là lý do đẩy mạnh đau tay — tường đẩy lại với cùng lực.',
 3);


-- Exercise 4: matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'physics-newtons-laws'),
 'matching', 'medium',
 'Match each Newton''s Law to its real-world example.',
 'Ghép mỗi Định luật Newton với ví dụ thực tế tương ứng.',
 'Law 1 (Inertia): seatbelts needed because passengers keep moving when car stops. Law 2 (F=ma): heavier rockets need more thrust. Law 3 (Action-Reaction): swimmers push water back, water pushes them forward.',
 'Định luật 1 (Quán tính): cần dây an toàn vì hành khách tiếp tục di chuyển khi xe dừng. Định luật 2 (F=ma): tên lửa nặng hơn cần lực đẩy lớn hơn. Định luật 3 (Hành động-Phản ứng): người bơi đẩy nước ra sau, nước đẩy họ về trước.',
 4);

WITH match_ex AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'physics-newtons-laws')
  AND type = 'matching'
)
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index)
SELECT id, 'Newton''s 1st Law', 'Định luật 1 Newton', 'Passengers jerk forward when the car brakes suddenly', 'Hành khách bị đẩy về trước khi xe phanh đột ngột', 1 FROM match_ex
UNION ALL SELECT id, 'Newton''s 2nd Law', 'Định luật 2 Newton', 'Heavier rockets require more thrust to lift off', 'Tên lửa nặng hơn cần lực đẩy lớn hơn để cất cánh', 2 FROM match_ex
UNION ALL SELECT id, 'Newton''s 3rd Law', 'Định luật 3 Newton', 'A swimmer pushes water back to move forward', 'Người bơi đẩy nước ra sau để di chuyển về phía trước', 3 FROM match_ex;


-- Exercise 5: arrange_words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'physics-newtons-laws'),
 'arrange_words', 'medium',
 'Arrange these components to express Newton''s Second Law as a formula.',
 'Sắp xếp các thành phần này để biểu diễn Định luật 2 Newton dưới dạng công thức.',
 'Force (F) = Mass (m) × Acceleration (a)',
 '["Mass (m)", "Acceleration (a)", "=", "Force (F)", "×"]',
 'Newton''s Second Law: Force = Mass × Acceleration (F = ma). The unit of force, the Newton (N), equals 1 kg·m/s², named after Isaac Newton.',
 'Định luật 2 Newton: Lực = Khối lượng × Gia tốc (F = ma). Đơn vị lực, Newton (N), bằng 1 kg·m/s², đặt tên theo Isaac Newton.',
 5);


-- Exercise 6: error_correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'physics-newtons-laws'),
 'error_correction', 'medium',
 'Fix the physics error: "When an astronaut goes to the Moon, their mass decreases to about 1/6 because the Moon has weaker gravity."',
 'Sửa lỗi vật lý: "Khi phi hành gia lên Mặt Trăng, khối lượng giảm xuống còn khoảng 1/6 vì Mặt Trăng có trọng lực yếu hơn."',
 'When an astronaut goes to the Moon, their weight (not mass) decreases to about 1/6. Mass remains constant everywhere in the universe; only weight changes with gravitational acceleration.',
 'Mass (kg) never changes anywhere in the universe. Weight (W = mg) changes with gravitational acceleration g. On Earth g = 9.8 m/s²; on the Moon g = 1.6 m/s² ≈ g_Earth / 6, so weight decreases 6×. Mass stays exactly the same.',
 'Khối lượng không thay đổi ở bất kỳ đâu. Trọng lượng (W = mg) thay đổi theo g. Trên Mặt Trăng: g = 1,6 m/s² ≈ g_Trái_Đất / 6, nên trọng lượng giảm 6 lần. Khối lượng vẫn y hệt.',
 6);


-- Exercise 7: sentence_transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'physics-newtons-laws'),
 'sentence_transform', 'hard',
 'A car engine applies 3000 N of force to a 1500 kg car. Write this as a Newton''s Second Law calculation showing the car''s acceleration.',
 'Động cơ xe tác dụng lực 3000 N lên xe 1500 kg. Viết thành phép tính Định luật 2 Newton cho thấy gia tốc của xe.',
 'Using F = ma: a = F/m = 3000 N ÷ 1500 kg = 2 m/s²',
 'Rearrange F = ma to isolate a: a = F/m. Substituting F = 3000 N and m = 1500 kg gives a = 2 m/s². This is 0.2g — a gentle acceleration typical for a regular car.',
 'Biến đổi F = ma để tách a: a = F/m. Thay F = 3000 N và m = 1500 kg được a = 2 m/s². Đây là 0,2g — gia tốc nhẹ điển hình cho xe thông thường.',
 7);
