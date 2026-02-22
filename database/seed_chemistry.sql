-- ============================================================================
-- SEED DATA: Chemistry Basics (1 lesson)
-- Category: Chemistry Basics (ID 15)
-- Lesson: Atomic Structure
-- Compatible with: schema.sql v7+
-- Applied AFTER: seed_economics (category 14)
-- Demonstrates: diagram section (Mermaid — atomic structure visual)
--               code_output exercise (Python + chemistry cross-domain)
-- ============================================================================

-- ============================================================================
-- CATEGORY 15: Chemistry Basics
-- ============================================================================

INSERT INTO category (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('Chemistry Basics', 'Hóa Học Cơ Bản',
 'Explore the building blocks of matter: atoms, elements, the periodic table, and chemical reactions',
 'Khám phá các khối xây dựng của vật chất: nguyên tử, nguyên tố, bảng tuần hoàn và phản ứng hóa học',
 'Biotech', '#14b8a6', 15);


-- ############################################################################
-- LESSON: ATOMIC STRUCTURE (slug: chemistry-atomic-structure)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Atomic Structure', 'Cấu Trúc Nguyên Tử',
  'chemistry-atomic-structure',
  'Understand the atom: protons, neutrons, electrons, atomic number, and atomic mass',
  'Hiểu về nguyên tử: proton, neutron, electron, số nguyên tử và khối lượng nguyên tử',
  'beginner', 25, 1
FROM category WHERE name = 'Chemistry Basics';


-- ============================================================================
-- LESSON USAGES
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure'),
 'Subatomic Particles', 'Các Hạt Hạ Nguyên Tử',
 'Every atom is made of three fundamental particles: protons (positive charge, in nucleus), neutrons (no charge, in nucleus), and electrons (negative charge, orbit the nucleus). The number of each determines the element''s identity and behavior.',
 'Mỗi nguyên tử gồm ba hạt cơ bản: proton (điện tích dương, trong hạt nhân), neutron (không mang điện, trong hạt nhân) và electron (điện tích âm, quay quanh hạt nhân). Số lượng của mỗi hạt xác định danh tính và tính chất của nguyên tố.',
 'Hexagon', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure'),
 'Atomic Number and Atomic Mass', 'Số Nguyên Tử và Khối Lượng Nguyên Tử',
 'The atomic number (Z) equals the number of protons — it uniquely identifies each element. The atomic mass (A) approximately equals protons + neutrons. Electrons have negligible mass. For a neutral atom, protons = electrons.',
 'Số nguyên tử (Z) bằng số proton — nó xác định duy nhất từng nguyên tố. Khối lượng nguyên tử (A) xấp xỉ bằng proton + neutron. Electron có khối lượng không đáng kể. Với nguyên tử trung hòa, số proton = số electron.',
 'Tag', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure'),
 'Electron Shells and the Periodic Table', 'Lớp Vỏ Electron và Bảng Tuần Hoàn',
 'Electrons occupy energy levels (shells) around the nucleus. The first shell holds 2 electrons; the second and third hold up to 8 each. The number of electrons in the outermost shell (valence electrons) determines how an element bonds with others.',
 'Electron chiếm các mức năng lượng (lớp vỏ) quanh hạt nhân. Lớp 1 chứa 2 electron; lớp 2 và 3 chứa tối đa 8 mỗi lớp. Số electron ở lớp ngoài cùng (electron hóa trị) xác định cách nguyên tố liên kết với các nguyên tố khác.',
 'Layers', TRUE, 3);


-- ============================================================================
-- EXAMPLES (2 per usage)
-- ============================================================================

INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES

-- Usage 1: Subatomic Particles
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure') AND order_index = 1),
 'A carbon atom has 6 protons, 6 neutrons, and 6 electrons — making it electrically neutral because positive and negative charges are equal.',
 'Nguyên tử carbon có 6 proton, 6 neutron và 6 electron — làm cho nó trung hòa điện vì điện tích dương và âm bằng nhau.',
 'Atoms are normally neutral because they have equal numbers of protons (+) and electrons (−). When atoms gain or lose electrons, they become ions (charged atoms). Carbon losing 4 electrons becomes C⁴⁺; gaining 4 becomes C⁴⁻.',
 'Nguyên tử thường trung hòa vì có số proton (+) và electron (−) bằng nhau. Khi nguyên tử nhận hoặc mất electron, chúng trở thành ion (nguyên tử mang điện). Carbon mất 4 electron thành C⁴⁺; nhận 4 thành C⁴⁻.',
 'electrically neutral', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure') AND order_index = 1),
 'Protons and neutrons are made of even smaller particles called quarks — but for chemistry, treating them as fundamental particles is sufficient.',
 'Proton và neutron được tạo thành từ các hạt nhỏ hơn gọi là quark — nhưng với hóa học, coi chúng là hạt cơ bản là đủ.',
 'Physics goes deeper (quarks, gluons), but chemistry only needs the three-particle model. This is the principle of abstraction — use the simplest model that explains the phenomena you are studying.',
 'Vật lý đi sâu hơn (quark, gluon), nhưng hóa học chỉ cần mô hình ba hạt. Đây là nguyên tắc trừu tượng hóa — dùng mô hình đơn giản nhất giải thích các hiện tượng đang nghiên cứu.',
 'quarks', 2),

-- Usage 2: Atomic Number and Mass
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure') AND order_index = 2),
 'Hydrogen (H) has atomic number 1 — exactly 1 proton. Helium (He) has 2 protons, Carbon (C) has 6, Oxygen (O) has 8. The atomic number is the element''s "fingerprint."',
 'Hydro (H) có số nguyên tử 1 — chính xác 1 proton. Helium (He) có 2 proton, Carbon (C) có 6, Oxy (O) có 8. Số nguyên tử là "dấu vân tay" của nguyên tố.',
 'If you change the number of protons, you change the element entirely. Adding one proton to carbon (6) gives you nitrogen (7). Removing one gives you boron (5). Nuclear reactions — like in stars — actually do this, transmuting one element into another.',
 'Nếu bạn thay đổi số proton, bạn thay đổi hoàn toàn nguyên tố. Thêm một proton vào carbon (6) cho bạn nitơ (7). Bớt một proton cho bạn boron (5). Phản ứng hạt nhân — như trong các ngôi sao — thực sự làm điều này, biến đổi nguyên tố này thành nguyên tố khác.',
 'atomic number', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure') AND order_index = 2),
 'Carbon-12 (most common) has 6 protons + 6 neutrons = mass 12. Carbon-14 (radioactive) has 6 protons + 8 neutrons = mass 14. Same element, different isotopes.',
 'Carbon-12 (phổ biến nhất) có 6 proton + 6 neutron = khối lượng 12. Carbon-14 (phóng xạ) có 6 proton + 8 neutron = khối lượng 14. Cùng nguyên tố, đồng vị khác nhau.',
 'Isotopes are atoms of the same element with different numbers of neutrons. Carbon-14 is used in radiocarbon dating — it decays at a known rate, allowing scientists to determine the age of ancient organic materials.',
 'Đồng vị là các nguyên tử của cùng một nguyên tố với số neutron khác nhau. Carbon-14 được dùng trong định tuổi bằng carbon phóng xạ — nó phân rã với tốc độ đã biết, cho phép các nhà khoa học xác định tuổi của vật liệu hữu cơ cổ đại.',
 'isotopes', 2),

-- Usage 3: Electron Shells
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure') AND order_index = 3),
 'Sodium (Na, 11 electrons) fills shells as 2, 8, 1 — one lonely electron in its outer shell, which it easily gives away in chemical reactions.',
 'Natri (Na, 11 electron) lấp đầy lớp vỏ theo thứ tự 2, 8, 1 — một electron cô đơn ở lớp ngoài, dễ dàng nhường trong phản ứng hóa học.',
 'Elements with 1 or 2 valence electrons (like sodium, potassium) are highly reactive metals — they want to give away electrons. Elements with 7 valence electrons (like chlorine, fluorine) are highly reactive non-metals — they want to gain one electron. Noble gases (8 valence electrons) are stable and don''t react.',
 'Các nguyên tố có 1 hoặc 2 electron hóa trị (như natri, kali) là kim loại có tính phản ứng cao — chúng muốn nhường electron. Các nguyên tố có 7 electron hóa trị (như clo, flo) là phi kim có tính phản ứng cao — chúng muốn nhận thêm một electron. Khí hiếm (8 electron hóa trị) ổn định và không phản ứng.',
 'valence electrons', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure') AND order_index = 3),
 'When sodium (1 valence electron) meets chlorine (7 valence electrons), sodium gives its electron to chlorine — forming Na⁺ and Cl⁻ ions that attract each other as table salt (NaCl).',
 'Khi natri (1 electron hóa trị) gặp clo (7 electron hóa trị), natri nhường electron cho clo — tạo ra ion Na⁺ và Cl⁻ hút nhau thành muối ăn (NaCl).',
 'This ionic bond forms because both atoms achieve a stable 8-electron outer shell. Chemistry at its heart is about atoms seeking stability by sharing or transferring electrons to complete their outer shells.',
 'Liên kết ion hình thành vì cả hai nguyên tử đạt lớp vỏ ngoài ổn định 8 electron. Bản chất hóa học là các nguyên tử tìm kiếm sự ổn định bằng cách chia sẻ hoặc chuyển electron để hoàn thiện lớp vỏ ngoài.',
 'ionic bond', 2);


-- ============================================================================
-- TIPS
-- ============================================================================

INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES

((SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure'),
 'Atomic number never changes; neutrons can vary', 'Số nguyên tử không bao giờ thay đổi; neutron có thể biến đổi',
 'The atomic number (proton count) defines which element an atom is — change it and you have a different element. But atoms of the same element can have different neutron counts: these are isotopes. Carbon always has 6 protons, but can have 6, 7, or 8 neutrons (Carbon-12, -13, -14). Only Carbon-14 is radioactive.',
 'Số nguyên tử (số proton) xác định nguyên tố — thay đổi nó và bạn có nguyên tố khác. Nhưng nguyên tử cùng nguyên tố có thể có số neutron khác nhau: đây là đồng vị. Carbon luôn có 6 proton, nhưng có thể có 6, 7 hoặc 8 neutron (Carbon-12, -13, -14). Chỉ Carbon-14 mới phóng xạ.',
 'common_mistake', 'high', 'Warning', 1),

((SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure'),
 'Use the periodic table: it already has all the answers', 'Dùng bảng tuần hoàn: nó đã có tất cả đáp án',
 'Every element box in the periodic table shows: symbol, atomic number (top), and atomic mass (bottom). From these two numbers you can derive: protons = atomic number, neutrons ≈ atomic mass − atomic number, electrons = protons (for neutral atoms). You don''t memorize these — you read them from the table.',
 'Mỗi ô nguyên tố trong bảng tuần hoàn hiển thị: ký hiệu, số nguyên tử (trên) và khối lượng nguyên tử (dưới). Từ hai số này bạn có thể suy ra: proton = số nguyên tử, neutron ≈ khối lượng nguyên tử − số nguyên tử, electron = proton (với nguyên tử trung hòa). Bạn không cần nhớ — đọc từ bảng.',
 'shortcut', 'high', 'Lightbulb', 2),

((SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure'),
 'Atoms are mostly empty space', 'Nguyên tử chủ yếu là không gian trống',
 'If the nucleus of an atom were the size of a marble (1 cm), the electrons would orbit at roughly 1 km away. Everything in between is empty space. This is why matter seems solid — it''s the electromagnetic forces between electrons that resist compression, not the actual volume of particles.',
 'Nếu hạt nhân nguyên tử có kích thước bằng viên bi (1 cm), electron sẽ quay ở khoảng cách khoảng 1 km. Tất cả ở giữa là không gian trống. Đây là lý do vật chất có vẻ rắn — chính lực điện từ giữa các electron chống nén, không phải thể tích thực của hạt.',
 'general', 'medium', 'Info', 3);


-- ============================================================================
-- LESSON SECTIONS (3 sections: markdown + diagram + key_points)
-- Demonstrates: diagram section (Mermaid — atomic structure with particle properties)
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

-- Section 1: markdown
((SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure'),
 'markdown', 'Inside the Atom', 'Bên Trong Nguyên Tử',
'## Atomic Structure

Every element is made of atoms — the smallest unit that retains the chemical properties of that element.

### The Three Subatomic Particles

| Particle | Symbol | Charge | Mass | Location |
|----------|--------|--------|------|----------|
| **Proton** | p⁺ | +1 | 1 u | Nucleus |
| **Neutron** | n⁰ | 0 | 1 u | Nucleus |
| **Electron** | e⁻ | −1 | ~0 | Electron shells |

> **1 u (atomic mass unit)** = 1.66 × 10⁻²⁷ kg

### Key Numbers

**Atomic Number (Z)** = number of protons
$$Z = \text{number of protons}$$

**Atomic Mass (A)** ≈ protons + neutrons
$$A \approx p^+ + n^0$$

**For a neutral atom:**
$$\text{electrons} = \text{protons} = Z$$

### Reading the Periodic Table: Carbon Example

```
    6
    C        ← Symbol
  12.011     ← Atomic Mass
```

- Protons = **6** (atomic number)
- Neutrons ≈ **12 − 6 = 6**
- Electrons = **6** (neutral atom)

### Electron Shell Capacity

| Shell | Max Electrons | Elements filling this shell |
|-------|--------------|----------------------------|
| 1st (K) | 2 | H, He |
| 2nd (L) | 8 | Li → Ne |
| 3rd (M) | 8 | Na → Ar |',

'## Cấu Trúc Nguyên Tử

Mọi nguyên tố đều tạo thành từ nguyên tử — đơn vị nhỏ nhất giữ nguyên các tính chất hóa học của nguyên tố đó.

### Ba Hạt Hạ Nguyên Tử

| Hạt | Ký hiệu | Điện tích | Khối lượng | Vị trí |
|-----|---------|----------|-----------|--------|
| **Proton** | p⁺ | +1 | 1 u | Hạt nhân |
| **Neutron** | n⁰ | 0 | 1 u | Hạt nhân |
| **Electron** | e⁻ | −1 | ~0 | Lớp vỏ electron |

> **1 u (đơn vị khối lượng nguyên tử)** = 1,66 × 10⁻²⁷ kg

### Các Con Số Quan Trọng

**Số nguyên tử (Z)** = số proton
$$Z = \text{số proton}$$

**Khối lượng nguyên tử (A)** ≈ proton + neutron
$$A \approx p^+ + n^0$$

**Với nguyên tử trung hòa:**
$$\text{electron} = \text{proton} = Z$$

### Đọc Bảng Tuần Hoàn: Ví Dụ Carbon

```
    6
    C        ← Ký hiệu
  12.011     ← Khối lượng nguyên tử
```

- Proton = **6** (số nguyên tử)
- Neutron ≈ **12 − 6 = 6**
- Electron = **6** (nguyên tử trung hòa)

### Sức Chứa Lớp Vỏ Electron

| Lớp vỏ | Electron tối đa | Nguyên tố lấp đầy lớp này |
|--------|----------------|--------------------------|
| 1 (K) | 2 | H, He |
| 2 (L) | 8 | Li → Ne |
| 3 (M) | 8 | Na → Ar |',
 1, '{}'),

-- Section 2: diagram (Mermaid — atomic structure)
((SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure'),
 'diagram', 'Atomic Structure Diagram', 'Sơ Đồ Cấu Trúc Nguyên Tử',
 'Visual map of atomic structure: the nucleus contains protons and neutrons; electrons occupy shells outside the nucleus.',
 'Sơ đồ trực quan cấu trúc nguyên tử: hạt nhân chứa proton và neutron; electron chiếm các lớp vỏ bên ngoài hạt nhân.',
 2,
 '{"code":"graph TD\n    A[\"⚛️ Nguyên Tử — Atom\"] --> B[\"🔴 Hạt Nhân — Nucleus\"]\n    A --> C[\"🔵 Lớp Vỏ Electron — Electron Shells\"]\n    B --> D[\"Proton p⁺\\nĐiện tích: +1\\nKhối lượng: 1 u\"]\n    B --> E[\"Neutron n⁰\\nĐiện tích: 0\\nKhối lượng: 1 u\"]\n    C --> F[\"Electron e⁻\\nĐiện tích: −1\\nKhối lượng: ~0\"]\n    C --> G[\"Lớp 1: tối đa 2e⁻\\nLớp 2: tối đa 8e⁻\\nLớp 3: tối đa 8e⁻\"]\n    D --> H[\"Xác định NGUYÊN TỐ\\n(atomic number Z)\"]\n    E --> I[\"Tạo ĐỒNG VỊ\\n(isotopes)\"]\n    F --> J[\"Xác định LIÊN KẾT HÓA HỌC\\n(valence electrons)\"]"}'),

-- Section 3: key_points
((SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure'),
 'key_points', 'Key Chemistry Principles', 'Nguyên Tắc Hóa Học Quan Trọng',
 '- **Atomic number (Z)** = number of protons = element identity; change protons → different element
- **Atomic mass (A)** ≈ protons + neutrons; electrons have negligible mass (~1/1836 of a proton)
- **Neutral atom** → protons = electrons; ion → protons ≠ electrons (+ or − charge)
- **Isotopes** — same element (same protons), different neutron count; same chemistry, different stability
- **Valence electrons** — electrons in outermost shell; determine bonding behavior and reactivity
- **Electron shells** — fill from inside out: shell 1 (max 2), shell 2 (max 8), shell 3 (max 8)',
 '- **Số nguyên tử (Z)** = số proton = danh tính nguyên tố; thay đổi proton → nguyên tố khác
- **Khối lượng nguyên tử (A)** ≈ proton + neutron; electron có khối lượng không đáng kể (~1/1836 proton)
- **Nguyên tử trung hòa** → proton = electron; ion → proton ≠ electron (điện tích + hoặc −)
- **Đồng vị** — cùng nguyên tố (cùng proton), số neutron khác; cùng tính chất hóa học, độ bền khác
- **Electron hóa trị** — electron ở lớp vỏ ngoài cùng; xác định hành vi liên kết và tính phản ứng
- **Lớp vỏ electron** — lấp đầy từ trong ra ngoài: lớp 1 (tối đa 2), lớp 2 (tối đa 8), lớp 3 (tối đa 8)',
 3, '{}');


-- ============================================================================
-- EXERCISES (7 exercises — includes code_output cross-domain exercise)
-- ============================================================================

-- Exercise 1: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure'),
 'multiple_choice', 'easy',
 'How many protons does a carbon (C) atom have?',
 'Nguyên tử carbon (C) có bao nhiêu proton?',
 'Carbon has atomic number 6, which means it has exactly 6 protons. This is what makes it carbon — change the proton count and you have a different element entirely.',
 'Carbon có số nguyên tử 6, nghĩa là có chính xác 6 proton. Đây là điều làm nó trở thành carbon — thay đổi số proton và bạn có nguyên tố hoàn toàn khác.',
 1);

WITH mc_ex AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure')
  AND type = 'multiple_choice'
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, '6', '6', TRUE, 1 FROM mc_ex
UNION ALL SELECT id, 'B'::option_label, '12', '12', FALSE, 2 FROM mc_ex
UNION ALL SELECT id, 'C'::option_label, '8', '8', FALSE, 3 FROM mc_ex
UNION ALL SELECT id, 'D'::option_label, '14', '14', FALSE, 4 FROM mc_ex;


-- Exercise 2: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure'),
 'fill_blank', 'easy',
 'The atomic number of an element equals the number of _____ in its nucleus.',
 'Số nguyên tử của một nguyên tố bằng số _____ trong hạt nhân của nó.',
 'protons',
 'The atomic number (Z) is defined as the number of protons. It uniquely identifies each element. Carbon always has Z = 6 protons, Oxygen always has Z = 8 protons, regardless of isotope or charge state.',
 'Số nguyên tử (Z) được định nghĩa là số proton. Nó xác định duy nhất từng nguyên tố. Carbon luôn có Z = 6 proton, Oxy luôn có Z = 8 proton, bất kể đồng vị hay trạng thái điện tích.',
 'This number uniquely identifies the element', 'Con số này xác định duy nhất nguyên tố',
 2);


-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure'),
 'true_false', 'easy',
 'Neutrons carry a negative electric charge and are found in the electron shells around the nucleus.',
 'Neutron mang điện tích âm và được tìm thấy ở các lớp vỏ electron quanh hạt nhân.',
 'false',
 'Both parts are wrong: (1) Neutrons have NO electric charge — they are electrically neutral. (2) Neutrons are in the nucleus, not the electron shells. Only electrons are found in the shells, and they carry negative charge.',
 'Cả hai phần đều sai: (1) Neutron KHÔNG mang điện tích — chúng trung hòa điện. (2) Neutron ở trong hạt nhân, không phải lớp vỏ electron. Chỉ electron mới ở trong các lớp vỏ, và chúng mang điện tích âm.',
 3);


-- Exercise 4: matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure'),
 'matching', 'medium',
 'Match each subatomic particle to its correct properties.',
 'Ghép mỗi hạt hạ nguyên tử với tính chất đúng của nó.',
 'Proton: positive charge, mass 1u, in nucleus. Neutron: no charge, mass 1u, in nucleus. Electron: negative charge, ~0 mass, in shells. Remember: the nucleus (protons + neutrons) contains almost all the atom''s mass.',
 'Proton: điện tích dương, khối lượng 1u, trong hạt nhân. Neutron: không mang điện, khối lượng 1u, trong hạt nhân. Electron: điện tích âm, khối lượng ~0, trong lớp vỏ. Nhớ: hạt nhân (proton + neutron) chứa gần như toàn bộ khối lượng nguyên tử.',
 4);

WITH match_ex AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure')
  AND type = 'matching'
)
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index)
SELECT id, 'Proton', 'Proton', 'Positive charge (+1), mass 1u, located in nucleus', 'Điện tích dương (+1), khối lượng 1u, trong hạt nhân', 1 FROM match_ex
UNION ALL SELECT id, 'Neutron', 'Neutron', 'No charge (0), mass 1u, located in nucleus', 'Không mang điện (0), khối lượng 1u, trong hạt nhân', 2 FROM match_ex
UNION ALL SELECT id, 'Electron', 'Electron', 'Negative charge (-1), negligible mass, in shells', 'Điện tích âm (-1), khối lượng không đáng kể, trong lớp vỏ', 3 FROM match_ex
UNION ALL SELECT id, 'Atomic Number', 'Số nguyên tử', 'Equals the number of protons in the nucleus', 'Bằng số proton trong hạt nhân', 4 FROM match_ex;


-- Exercise 5: arrange_words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure'),
 'arrange_words', 'medium',
 'Arrange the subatomic particles from lightest to heaviest by mass.',
 'Sắp xếp các hạt hạ nguyên tử từ nhẹ nhất đến nặng nhất theo khối lượng.',
 'Electron, Proton, Neutron',
 '["Neutron", "Proton", "Electron"]',
 'Electron mass ≈ 0.00055 u (nearly zero). Proton mass = 1.0073 u. Neutron mass = 1.0087 u (slightly heavier than proton). So: Electron (lightest) < Proton < Neutron (heaviest). Electrons are ~1836× lighter than protons.',
 'Khối lượng electron ≈ 0,00055 u (gần như bằng không). Khối lượng proton = 1,0073 u. Khối lượng neutron = 1,0087 u (nặng hơn proton một chút). Do đó: Electron (nhẹ nhất) < Proton < Neutron (nặng nhất). Electron nhẹ hơn proton khoảng 1836 lần.',
 5);


-- Exercise 6: error_correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure'),
 'error_correction', 'medium',
 'Fix the chemistry error: "The atomic mass of carbon equals its number of electrons, which is 6."',
 'Sửa lỗi hóa học: "Khối lượng nguyên tử của carbon bằng số electron của nó, là 6."',
 'The atomic mass of carbon (≈12) equals its number of protons (6) plus neutrons (6), not electrons. Electrons have negligible mass. The atomic number (6) equals the electron count for a neutral atom.',
 'Atomic mass ≈ protons + neutrons (both in nucleus, each ≈1u). Electrons contribute ~0.0005u each — negligible. Carbon-12 has 6p + 6n = 12u. Atomic number = proton count, not mass.',
 'Khối lượng nguyên tử carbon (≈12) bằng số proton (6) cộng neutron (6), không phải electron. Electron có khối lượng không đáng kể. Số nguyên tử (6) bằng số electron với nguyên tử trung hòa.',
 6);


-- Exercise 7: code_output (cross-domain: Python + Chemistry)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, context, context_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'chemistry-atomic-structure'),
 'code_output', 'medium',
 'What will this Python code output? (It calculates the atomic mass of the most common carbon isotope)',
 'Code Python này sẽ in ra gì? (Nó tính khối lượng nguyên tử của đồng vị carbon phổ biến nhất)',
 'protons = 6
neutrons = 6
atomic_mass = protons + neutrons
print(atomic_mass)',
 'protons = 6
neutrons = 6
atomic_mass = protons + neutrons
print(atomic_mass)',
 '12',
 'Carbon-12 has 6 protons and 6 neutrons, so atomic_mass = 6 + 6 = 12. Python prints the integer 12. This is the most abundant carbon isotope (98.9% of all carbon) and is the reference standard for atomic mass units.',
 'Carbon-12 có 6 proton và 6 neutron, nên atomic_mass = 6 + 6 = 12. Python in ra số nguyên 12. Đây là đồng vị carbon phổ biến nhất (98,9% tất cả carbon) và là tiêu chuẩn tham chiếu cho đơn vị khối lượng nguyên tử.',
 7);
