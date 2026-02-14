-- ============================================================================
-- SEED DATA: Music Theory (1 lesson)
-- Category: Music Theory (ID 11)
-- Lessons: ID 34
-- Compatible with: schema.sql v7
-- ============================================================================


-- ============================================================================
-- PRE-REQUISITE: Expand category order_index constraint (was 0-10, now 0-20)
-- ============================================================================

ALTER TABLE category DROP CONSTRAINT chk_category_order;
ALTER TABLE category ADD CONSTRAINT chk_category_order CHECK (order_index >= 0 AND order_index <= 20);


-- ============================================================================
-- CATEGORY 11: Music Theory
-- ============================================================================

INSERT INTO category (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('Music Theory', 'Lý Thuyết Âm Nhạc', 'Learn the foundations of music: scales, intervals, rhythm, and harmony', 'Học nền tảng âm nhạc: âm giai, quãng, nhịp điệu và hòa âm', 'MusicNote', '#e11d48', 11);


-- ############################################################################
-- LESSON 34: MAJOR SCALES & INTERVALS (lesson_id = 34)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(11, 'Major Scales & Intervals', 'Âm Giai Trưởng & Quãng', 'music-major-scales', 'Understand the W-W-H-W-W-W-H pattern, build major scales, and name intervals', 'Hiểu công thức W-W-H-W-W-W-H, xây dựng âm giai trưởng và gọi tên các quãng', 'beginner', 30, 1);

-- Usages (IDs 102-104)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(34, 'Building a major scale with W-W-H-W-W-W-H', 'Xây dựng âm giai trưởng với W-W-H-W-W-W-H', 'A major scale follows a fixed pattern of whole steps (W) and half steps (H): W-W-H-W-W-W-H. Starting from any note and applying this pattern produces a major scale. On a piano, a half step is the very next key (including black keys), and a whole step skips one key.', 'Âm giai trưởng tuân theo một công thức cố định gồm cung (W) và nửa cung (H): W-W-H-W-W-W-H. Bắt đầu từ bất kỳ nốt nào và áp dụng công thức này sẽ tạo ra âm giai trưởng. Trên piano, nửa cung là phím kế tiếp (kể cả phím đen), và một cung nhảy qua một phím.', 'MusicNote', TRUE, 1),
(34, 'Whole steps and half steps on the keyboard', 'Cung và nửa cung trên bàn phím', 'The half step (semitone) is the smallest interval in Western music — the distance between any two adjacent keys on a piano. A whole step (whole tone) equals two half steps. Understanding these building blocks is essential for constructing scales and chords.', 'Nửa cung (semitone) là quãng nhỏ nhất trong âm nhạc phương Tây — khoảng cách giữa hai phím liền kề trên piano. Một cung (whole tone) bằng hai nửa cung. Hiểu các đơn vị cơ bản này rất quan trọng để xây dựng âm giai và hợp âm.', 'Piano', TRUE, 2),
(34, 'Recognizing and naming intervals', 'Nhận biết và gọi tên các quãng', 'An interval is the distance between two notes, measured by counting letter names. Intervals have a number (2nd, 3rd, 4th, etc.) and a quality (major, minor, perfect). In a major scale, intervals from the root are: perfect unison, major 2nd, major 3rd, perfect 4th, perfect 5th, major 6th, major 7th, and perfect octave.', 'Quãng là khoảng cách giữa hai nốt nhạc, đo bằng cách đếm tên nốt. Quãng có số thứ tự (quãng 2, quãng 3, quãng 4, v.v.) và chất lượng (trưởng, thứ, đúng). Trong âm giai trưởng, các quãng từ nốt gốc là: quãng 1 đúng, quãng 2 trưởng, quãng 3 trưởng, quãng 4 đúng, quãng 5 đúng, quãng 6 trưởng, quãng 7 trưởng và quãng 8 đúng.', 'QueueMusic', TRUE, 3);

-- Examples for usage 102 (IDs 199-200)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(102, 'The C major scale is C-D-E-F-G-A-B-C, built entirely on the white keys of the piano.', 'Âm giai Đô trưởng là C-D-E-F-G-A-B-C, được xây dựng hoàn toàn trên các phím trắng của piano.', 'C major is the simplest major scale because it uses no sharps (♯) or flats (♭). The pattern W-W-H-W-W-W-H maps perfectly onto the white keys: C to D (W), D to E (W), E to F (H), F to G (W), G to A (W), A to B (W), B to C (H).', 'Âm giai Đô trưởng là âm giai trưởng đơn giản nhất vì không dùng thăng (♯) hoặc giáng (♭). Công thức W-W-H-W-W-W-H ánh xạ hoàn hảo lên các phím trắng: C đến D (W), D đến E (W), E đến F (H), F đến G (W), G đến A (W), A đến B (W), B đến C (H).', 'W-W-H-W-W-W-H', 1),
(102, 'To build a G major scale, start on G and apply W-W-H-W-W-W-H: G-A-B-C-D-E-F♯-G.', 'Để xây dựng âm giai Sol trưởng, bắt đầu từ G và áp dụng W-W-H-W-W-W-H: G-A-B-C-D-E-F♯-G.', 'The F♯ appears because following the whole-step pattern from E requires skipping F (a half step) and landing on F♯. This is why G major has one sharp in its key signature.', 'F♯ xuất hiện vì theo công thức cung từ E cần nhảy qua F (nửa cung) và rơi vào F♯. Đây là lý do âm giai Sol trưởng có một dấu thăng trong hóa biểu.', 'F♯', 2);

-- Examples for usage 103 (IDs 201-202)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(103, 'On a piano, E to F is a half step because there is no black key between them — they are adjacent keys.', 'Trên piano, E đến F là nửa cung vì không có phím đen giữa chúng — chúng là các phím liền kề nhau.', 'The piano keyboard makes intervals visual: E-F and B-C are the only pairs of white keys with no black key between them, making them natural half steps. All other adjacent white keys have a black key between them, forming whole steps.', 'Bàn phím piano làm cho các quãng trở nên trực quan: E-F và B-C là hai cặp phím trắng duy nhất không có phím đen ở giữa, tạo thành nửa cung tự nhiên. Tất cả các cặp phím trắng liền kề khác có phím đen ở giữa, tạo thành cung.', 'half step', 1),
(103, 'C to D is a whole step because there is one key (C♯/D♭) between them that we skip over.', 'C đến D là một cung vì có một phím (C♯/D♭) ở giữa mà ta nhảy qua.', 'A whole step always spans two half steps. On the keyboard, this means skipping exactly one key (black or white). The black key between C and D can be called C♯ (C sharp) or D♭ (D flat) — they are the same pitch, called enharmonic equivalents.', 'Một cung luôn trải dài hai nửa cung. Trên bàn phím, điều này có nghĩa là nhảy qua đúng một phím (đen hoặc trắng). Phím đen giữa C và D có thể gọi là C♯ (Đô thăng) hoặc D♭ (Rê giáng) — chúng cùng cao độ, gọi là dạng dị hòa.', 'whole step', 2);

-- Examples for usage 104 (IDs 203-204)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(104, 'The interval from C to E is a major 3rd — it spans 4 half steps (C-C♯-D-D♯-E).', 'Quãng từ C đến E là quãng 3 trưởng — nó trải dài 4 nửa cung (C-C♯-D-D♯-E).', 'To identify an interval, count the letter names (C-D-E = 3rd) and then determine the quality by counting half steps. A major 3rd has 4 half steps, while a minor 3rd has only 3 half steps.', 'Để xác định một quãng, đếm tên nốt (C-D-E = quãng 3) rồi xác định chất lượng bằng cách đếm nửa cung. Quãng 3 trưởng có 4 nửa cung, trong khi quãng 3 thứ chỉ có 3 nửa cung.', 'major 3rd', 1),
(104, 'The interval from C to G is a perfect 5th — one of the most consonant intervals in music, used in power chords.', 'Quãng từ C đến G là quãng 5 đúng — một trong những quãng hòa hợp nhất trong âm nhạc, được dùng trong hợp âm power.', 'Perfect intervals (unison, 4th, 5th, octave) are called "perfect" because they sound stable and consonant. The perfect 5th (7 half steps) is found in virtually every musical tradition worldwide and forms the basis of the circle of fifths.', 'Các quãng đúng (quãng 1, quãng 4, quãng 5, quãng 8) được gọi là "đúng" vì chúng nghe ổn định và hòa hợp. Quãng 5 đúng (7 nửa cung) xuất hiện trong hầu hết mọi truyền thống âm nhạc trên thế giới và là nền tảng của vòng quãng 5.', 'perfect 5th', 2);

-- Tips (IDs 101-103)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(34, 'Visualize the piano keyboard', 'Hình dung bàn phím piano', 'Think of whole steps and half steps on a piano: a half step (H) means move to the very next key (including black keys), a whole step (W) means skip one key. The pattern E-F and B-C are natural half steps (no black key between them). Remembering this visual layout makes building any major scale intuitive — just walk up the keys following W-W-H-W-W-W-H.', 'Hãy hình dung cung và nửa cung trên piano: nửa cung (H) là di chuyển đến phím kế tiếp (kể cả phím đen), một cung (W) là nhảy qua một phím. Cặp E-F và B-C là nửa cung tự nhiên (không có phím đen ở giữa). Nhớ cách bố trí trực quan này giúp xây dựng bất kỳ âm giai trưởng nào dễ dàng — chỉ cần đi lên các phím theo W-W-H-W-W-W-H.', 'memory', 'high', 'Lightbulb', 1),
(34, 'Do not confuse interval number with half steps', 'Đừng nhầm lẫn số thứ tự quãng với số nửa cung', 'A common mistake is thinking a "3rd" means 3 half steps. The interval number counts letter names (C-D-E = 3 letters = a 3rd), but the quality (major or minor) depends on the exact number of half steps. A major 3rd has 4 half steps, a minor 3rd has 3. Always count letter names first, then count half steps to determine quality.', 'Một lỗi thường gặp là nghĩ rằng "quãng 3" có nghĩa là 3 nửa cung. Số thứ tự quãng đếm tên nốt (C-D-E = 3 nốt = quãng 3), nhưng chất lượng (trưởng hoặc thứ) phụ thuộc vào số nửa cung chính xác. Quãng 3 trưởng có 4 nửa cung, quãng 3 thứ có 3. Luôn đếm tên nốt trước, rồi đếm nửa cung để xác định chất lượng.', 'common_mistake', 'high', 'Warning', 2),
(34, 'Use reference songs to remember intervals', 'Dùng bài hát tham chiếu để nhớ các quãng', 'Train your ear by associating each interval with a famous song. Major 2nd: "Happy Birthday" (Hap-py). Major 3rd: "When the Saints Go Marching In." Perfect 4th: "Here Comes the Bride." Perfect 5th: "Star Wars" main theme (first two notes). This technique turns abstract distances into sounds you already know.', 'Luyện tai bằng cách liên kết mỗi quãng với một bài hát nổi tiếng. Quãng 2 trưởng: "Happy Birthday" (Hap-py). Quãng 3 trưởng: "When the Saints Go Marching In." Quãng 4 đúng: "Here Comes the Bride." Quãng 5 đúng: "Star Wars" chủ đề chính (hai nốt đầu tiên). Kỹ thuật này biến khoảng cách trừu tượng thành âm thanh bạn đã biết.', 'shortcut', 'medium', 'Info', 3);

-- Sections (IDs 64-66)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(34, 'markdown', 'The Major Scale Formula', 'Công Thức Âm Giai Trưởng',
'## Building Major Scales

The major scale is the **foundation of Western music**. Every major scale follows the same pattern of **whole steps (W)** and **half steps (H)**:

### The Formula: W - W - H - W - W - W - H

A **half step** (semitone) is the smallest distance between two notes — the very next key on a piano (including black keys). A **whole step** (whole tone) equals two half steps.

### C Major Scale (no sharps or flats)

| Step | From | To | Interval |
|------|------|----|----------|
| 1 | C | D | Whole step (W) |
| 2 | D | E | Whole step (W) |
| 3 | E | F | Half step (H) |
| 4 | F | G | Whole step (W) |
| 5 | G | A | Whole step (W) |
| 6 | A | B | Whole step (W) |
| 7 | B | C | Half step (H) |

**Result:** C - D - E - F - G - A - B - C

### Naming Intervals from the Root

| Interval | Notes (from C) | Half Steps | Quality |
|----------|----------------|------------|---------|
| Unison | C → C | 0 | Perfect |
| 2nd | C → D | 2 | Major |
| 3rd | C → E | 4 | Major |
| 4th | C → F | 5 | Perfect |
| 5th | C → G | 7 | Perfect |
| 6th | C → A | 9 | Major |
| 7th | C → B | 11 | Major |
| Octave | C → C | 12 | Perfect |

> **Key insight:** Intervals of unison, 4th, 5th, and octave are called **perfect**. Intervals of 2nd, 3rd, 6th, and 7th are called **major** (in a major scale). Lowering a major interval by one half step makes it **minor**.',
'## Xây Dựng Âm Giai Trưởng

Âm giai trưởng là **nền tảng của âm nhạc phương Tây**. Mỗi âm giai trưởng tuân theo cùng công thức **cung (W)** và **nửa cung (H)**:

### Công Thức: W - W - H - W - W - W - H

**Nửa cung** (semitone) là khoảng cách nhỏ nhất giữa hai nốt — phím kế tiếp trên piano (kể cả phím đen). **Một cung** (whole tone) bằng hai nửa cung.

### Âm Giai Đô Trưởng (không có thăng hoặc giáng)

| Bước | Từ | Đến | Quãng |
|------|-----|-----|-------|
| 1 | C | D | Cung (W) |
| 2 | D | E | Cung (W) |
| 3 | E | F | Nửa cung (H) |
| 4 | F | G | Cung (W) |
| 5 | G | A | Cung (W) |
| 6 | A | B | Cung (W) |
| 7 | B | C | Nửa cung (H) |

**Kết quả:** C - D - E - F - G - A - B - C

### Gọi Tên Các Quãng Từ Nốt Gốc

| Quãng | Các nốt (từ C) | Số nửa cung | Chất lượng |
|-------|----------------|-------------|------------|
| Quãng 1 | C → C | 0 | Đúng |
| Quãng 2 | C → D | 2 | Trưởng |
| Quãng 3 | C → E | 4 | Trưởng |
| Quãng 4 | C → F | 5 | Đúng |
| Quãng 5 | C → G | 7 | Đúng |
| Quãng 6 | C → A | 9 | Trưởng |
| Quãng 7 | C → B | 11 | Trưởng |
| Quãng 8 | C → C | 12 | Đúng |

> **Nhận định chính:** Quãng 1, quãng 4, quãng 5 và quãng 8 được gọi là **đúng**. Quãng 2, quãng 3, quãng 6 và quãng 7 được gọi là **trưởng** (trong âm giai trưởng). Hạ một quãng trưởng xuống một nửa cung sẽ trở thành **thứ**.', 1, '{}'),

(34, 'key_points', 'Key Points', 'Điểm Chính',
'- The **major scale formula** is **W-W-H-W-W-W-H** (whole-whole-half-whole-whole-whole-half)
- A **half step** (semitone) = the very next key on the piano; a **whole step** = skip one key
- **E to F** and **B to C** are the only natural half steps between white keys
- The **C major scale** (C-D-E-F-G-A-B-C) uses only white keys — no sharps (♯) or flats (♭)
- **Interval number** = count of letter names (C to E = 3rd); **interval quality** = number of half steps
- **Perfect intervals**: unison (0), 4th (5), 5th (7), octave (12 half steps)
- **Major intervals**: 2nd (2), 3rd (4), 6th (9), 7th (11 half steps)
- Lowering a major interval by one half step creates a **minor interval**',
'- **Công thức âm giai trưởng** là **W-W-H-W-W-W-H** (cung-cung-nửa-cung-cung-cung-nửa)
- **Nửa cung** (semitone) = phím kế tiếp trên piano; **một cung** = nhảy qua một phím
- **E đến F** và **B đến C** là hai nửa cung tự nhiên duy nhất giữa các phím trắng
- **Âm giai Đô trưởng** (C-D-E-F-G-A-B-C) chỉ dùng phím trắng — không có thăng (♯) hoặc giáng (♭)
- **Số thứ tự quãng** = đếm tên nốt (C đến E = quãng 3); **chất lượng quãng** = số nửa cung
- **Quãng đúng**: quãng 1 (0), quãng 4 (5), quãng 5 (7), quãng 8 (12 nửa cung)
- **Quãng trưởng**: quãng 2 (2), quãng 3 (4), quãng 6 (9), quãng 7 (11 nửa cung)
- Hạ một quãng trưởng xuống một nửa cung tạo ra **quãng thứ**', 2, '{}'),

(34, 'info_box', 'Train Your Ear', 'Luyện Tai Nghe',
'**Knowing scales and intervals is only half the journey** — you also need to *hear* them. Ear training turns theoretical knowledge into musical intuition.

**How to start:**
- Play a C major scale slowly on any instrument or a virtual piano, listening to each step
- Sing along as you play — connecting your voice to the notes builds stronger pitch memory
- Practice identifying intervals by their "color": a perfect 5th sounds open and stable, a major 3rd sounds bright and happy, a minor 3rd sounds darker and more emotional

**Reference songs for common intervals:**
- **Major 2nd:** "Happy Birthday" (first two notes)
- **Major 3rd:** "Oh! When the Saints"
- **Perfect 4th:** "Here Comes the Bride"
- **Perfect 5th:** "Star Wars" (main theme, first leap)

**Daily habit:** Spend 5 minutes a day playing random intervals and trying to name them before checking. Within weeks, your ear will recognize them instantly.',
'**Biết âm giai và quãng chỉ là một nửa hành trình** — bạn cũng cần *nghe* được chúng. Luyện tai biến kiến thức lý thuyết thành trực giác âm nhạc.

**Cách bắt đầu:**
- Chơi âm giai Đô trưởng chậm trên bất kỳ nhạc cụ nào hoặc piano ảo, lắng nghe từng bước
- Hát theo khi chơi — kết nối giọng hát với các nốt xây dựng trí nhớ cao độ mạnh hơn
- Thực hành nhận biết quãng bằng "màu sắc" của chúng: quãng 5 đúng nghe mở và ổn định, quãng 3 trưởng nghe sáng và vui, quãng 3 thứ nghe tối hơn và đầy cảm xúc

**Bài hát tham chiếu cho các quãng phổ biến:**
- **Quãng 2 trưởng:** "Happy Birthday" (hai nốt đầu)
- **Quãng 3 trưởng:** "Oh! When the Saints"
- **Quãng 4 đúng:** "Here Comes the Bride"
- **Quãng 5 đúng:** "Star Wars" (chủ đề chính, bước nhảy đầu tiên)

**Thói quen hàng ngày:** Dành 5 phút mỗi ngày chơi các quãng ngẫu nhiên và thử gọi tên trước khi kiểm tra. Trong vài tuần, tai bạn sẽ nhận ra chúng ngay lập tức.', 3, '{"variant": "tip"}');

-- Exercise 232: Multiple Choice (11 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(34, 'multiple_choice', 'easy', 'What is the correct step pattern for building a major scale?', 'Công thức bước đúng để xây dựng âm giai trưởng là gì?', 'Select the pattern of whole steps (W) and half steps (H) that defines every major scale:', 'Chọn công thức cung (W) và nửa cung (H) định nghĩa mọi âm giai trưởng:', 'The major scale always follows the pattern W-W-H-W-W-W-H. This pattern is universal — it works starting from any note and is the foundation for understanding keys, chords, and harmony in Western music.', 'Âm giai trưởng luôn tuân theo công thức W-W-H-W-W-W-H. Công thức này là phổ quát — nó hoạt động bắt đầu từ bất kỳ nốt nào và là nền tảng để hiểu tonal, hợp âm và hòa âm trong âm nhạc phương Tây.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(232, 'A', 'W-W-W-H-W-W-H', FALSE, 'This pattern has three whole steps in a row at the start, which is incorrect for a major scale', 1),
(232, 'B', 'W-W-H-W-W-W-H', TRUE, 'Correct! The major scale formula is Whole-Whole-Half-Whole-Whole-Whole-Half', 2),
(232, 'C', 'W-H-W-W-H-W-W', FALSE, 'This is the pattern for the Dorian mode, not the major (Ionian) scale', 3),
(232, 'D', 'H-W-W-W-H-W-W', FALSE, 'Starting with a half step would produce a different mode, not a major scale', 4);

-- Exercise 233: Fill Blank (12 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(34, 'fill_blank', 'easy', 'Fill in the missing note in this G major scale.', 'Điền nốt còn thiếu trong âm giai Sol trưởng này.', 'G - A - B - C - D - E - ___ - G', 'G - A - B - C - D - E - ___ - G', 'F#', 'In the G major scale, the 7th note must be F♯ (not F♮). Following the W-W-H-W-W-W-H pattern from G: G(W)A(W)B(H)C(W)D(W)E(W)F♯(H)G. The step from E to F♯ is a whole step, and F♯ to G is a half step, completing the pattern correctly.', 'Trong âm giai Sol trưởng, nốt thứ 7 phải là F♯ (không phải F♮). Theo công thức W-W-H-W-W-W-H từ G: G(W)A(W)B(H)C(W)D(W)E(W)F♯(H)G. Bước từ E đến F♯ là một cung, và F♯ đến G là nửa cung, hoàn thành công thức đúng.', 10, 2);

-- Exercise 234: Error Correction (14 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(34, 'error_correction', 'medium', 'Fix the incorrect statement about intervals.', 'Sửa phát biểu sai về quãng.', 'The interval from C to E is a minor 3rd because you count three letter names: C, D, E.', 'Quãng từ C đến E là quãng 3 thứ vì bạn đếm ba tên nốt: C, D, E.', 'The interval from C to E is a major 3rd because it spans 4 half steps: C, C#, D, D#, E.', 'While the interval number (3rd) is correct because we count three letter names (C-D-E), the quality is wrong. C to E spans 4 half steps (C-C♯-D-D♯-E), which makes it a major 3rd. A minor 3rd would only span 3 half steps (for example, C to E♭). The interval number and quality are two separate measurements.', 'Mặc dù số thứ tự quãng (quãng 3) là đúng vì đếm ba tên nốt (C-D-E), chất lượng sai. C đến E trải dài 4 nửa cung (C-C♯-D-D♯-E), làm nó thành quãng 3 trưởng. Quãng 3 thứ chỉ trải dài 3 nửa cung (ví dụ, C đến E♭). Số thứ tự quãng và chất lượng là hai phép đo riêng biệt.', 'Count the half steps between C and E on the keyboard.', 'Đếm số nửa cung giữa C và E trên bàn phím.', 15, 3);

-- Exercise 235: Sentence Transform (12 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(34, 'sentence_transform', 'medium', 'Rewrite this description using the correct musical terminology.', 'Viết lại mô tả này sử dụng thuật ngữ âm nhạc đúng.', 'In C major, the distance from C to the 5th white key up is 7 small steps.', 'Trong Đô trưởng, khoảng cách từ C đến phím trắng thứ 5 trên là 7 bước nhỏ.', 'In C major, the interval from C to G is a perfect 5th spanning 7 half steps.', 'The proper musical terminology replaces "distance" with "interval," identifies the notes by name (C to G), uses the interval name "perfect 5th," and replaces "small steps" with the correct term "half steps" (semitones). Precise terminology is essential for communicating musical ideas clearly.', 'Thuật ngữ âm nhạc chính xác thay "khoảng cách" bằng "quãng," xác định các nốt theo tên (C đến G), sử dụng tên quãng "quãng 5 đúng," và thay "bước nhỏ" bằng thuật ngữ đúng "nửa cung" (semitone). Thuật ngữ chính xác là thiết yếu để truyền đạt ý tưởng âm nhạc rõ ràng.', 15, 4);

-- Exercise 236: Arrange Words (11 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(34, 'arrange_words', 'easy', 'Arrange the notes of the C major scale in ascending order.', 'Sắp xếp các nốt của âm giai Đô trưởng theo thứ tự tăng dần.', '["G", "B", "E", "C", "A", "F", "D"]', 'C, D, E, F, G, A, B', 'The C major scale ascends through the musical alphabet starting from C: C-D-E-F-G-A-B. This is the only major scale that uses no sharps or flats, making it the standard reference for learning intervals and scale construction.', 'Âm giai Đô trưởng đi lên theo bảng chữ cái âm nhạc bắt đầu từ C: C-D-E-F-G-A-B. Đây là âm giai trưởng duy nhất không dùng thăng hoặc giáng, làm nó thành tham chiếu tiêu chuẩn để học quãng và xây dựng âm giai.', 10, 5);

-- Exercise 237: Matching (9 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(34, 'matching', 'easy', 'Match each interval to the correct number of half steps.', 'Nối mỗi quãng với số nửa cung đúng.', 'These intervals are measured from C in the C major scale. Memorizing the half-step count for each interval is fundamental for transposing music, building chords, and ear training.', 'Các quãng này được đo từ C trong âm giai Đô trưởng. Ghi nhớ số nửa cung cho mỗi quãng là cơ bản để chuyển giọng nhạc, xây dựng hợp âm và luyện tai.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(237, 'Major 2nd (C to D)', 'Quãng 2 trưởng (C đến D)', '2 half steps', '2 nửa cung', 1),
(237, 'Major 3rd (C to E)', 'Quãng 3 trưởng (C đến E)', '4 half steps', '4 nửa cung', 2),
(237, 'Perfect 4th (C to F)', 'Quãng 4 đúng (C đến F)', '5 half steps', '5 nửa cung', 3),
(237, 'Perfect 5th (C to G)', 'Quãng 5 đúng (C đến G)', '7 half steps', '7 nửa cung', 4);

-- Exercise 238: True/False (12 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(34, 'true_false', 'easy', 'Is this statement about the major scale correct?', 'Phát biểu này về âm giai trưởng có đúng không?', 'The notes E to F and B to C are both half steps because there is no black key between them on the piano keyboard.', 'Các nốt E đến F và B đến C đều là nửa cung vì không có phím đen giữa chúng trên bàn phím piano.', 'true', 'True! On a standard piano keyboard, E-F and B-C are the only pairs of adjacent white keys with no black key between them. These are natural half steps (semitones). All other pairs of adjacent white keys (C-D, D-E, F-G, G-A, A-B) have a black key between them, making them whole steps. This is why the piano keyboard pattern repeats with groups of 2 and 3 black keys.', 'Đúng! Trên bàn phím piano tiêu chuẩn, E-F và B-C là hai cặp phím trắng liền kề duy nhất không có phím đen ở giữa. Đây là các nửa cung tự nhiên (semitone). Tất cả các cặp phím trắng liền kề khác (C-D, D-E, F-G, G-A, A-B) có phím đen ở giữa, làm chúng thành cung. Đây là lý do tại sao mẫu bàn phím piano lặp lại với nhóm 2 và 3 phím đen.', 5, 7);


-- ============================================================================
-- VERIFICATION QUERY
-- ============================================================================

SELECT l.id, l.name, l.slug,
  (SELECT COUNT(*) FROM lesson_usage WHERE lesson_id = l.id) AS usages,
  (SELECT COUNT(*) FROM tip WHERE lesson_id = l.id) AS tips,
  (SELECT COUNT(*) FROM lesson_section WHERE lesson_id = l.id) AS sections,
  (SELECT COUNT(*) FROM exercise WHERE lesson_id = l.id) AS exercises
FROM lesson l WHERE l.group_id = 11 ORDER BY l.order_index;
