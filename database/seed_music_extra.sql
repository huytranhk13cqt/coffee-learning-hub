-- ============================================================================
-- SEED DATA: Music Theory — Extra Lessons
-- Adds 2 lessons to existing category 'Music Theory' (ID 11)
-- Prerequisite: seed_music.sql must have been applied (lesson 34 exists)
-- lesson order_index continues from 1 (existing) → 3, 4
-- ============================================================================


-- ############################################################################
-- LESSON: HARMONY AND CHORD PROGRESSIONS (slug = harmony-and-chords)
-- order_index = 3
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Harmony and Chord Progressions',
  'Hòa Âm và Chuỗi Hợp Âm',
  'harmony-and-chords',
  'Build chords, understand triads, and create harmonic progressions',
  'Xây dựng hợp âm, hiểu ba âm và tạo chuỗi hòa âm',
  'intermediate',
  35,
  3
FROM category WHERE name = 'Music Theory';

-- Usages
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'harmony-and-chords'),
  'Major and Minor Triads',
  'Ba Âm Trưởng và Thứ',
  'A triad is a three-note chord built by stacking thirds. A major triad has a root, major 3rd (4 half steps), and perfect 5th (7 half steps). A minor triad has a root, minor 3rd (3 half steps), and perfect 5th. Major triads sound bright and stable; minor triads sound darker and more introspective.',
  'Ba âm là hợp âm ba nốt được xây dựng bằng cách xếp chồng các quãng ba. Ba âm trưởng có nốt gốc, quãng 3 trưởng (4 nửa cung) và quãng 5 đúng (7 nửa cung). Ba âm thứ có nốt gốc, quãng 3 thứ (3 nửa cung) và quãng 5 đúng. Ba âm trưởng nghe sáng và ổn định; ba âm thứ nghe tối hơn và nội tâm hơn.',
  'MusicNote',
  TRUE,
  1
),
(
  (SELECT id FROM lesson WHERE slug = 'harmony-and-chords'),
  'Common Chord Progressions',
  'Chuỗi Hợp Âm Phổ Biến',
  'Chord progressions are sequences of chords that create harmonic movement. The I-IV-V-I progression is the foundation of Western music — from classical to blues, rock, and pop. Roman numerals indicate the scale degree on which each chord is built, allowing the same progression to be transposed to any key.',
  'Chuỗi hợp âm là các chuỗi hợp âm tạo ra chuyển động hòa âm. Chuỗi I-IV-V-I là nền tảng của âm nhạc phương Tây — từ cổ điển đến blues, rock và pop. Chữ số La Mã chỉ bậc thang âm trên đó mỗi hợp âm được xây dựng, cho phép cùng một chuỗi được chuyển sang bất kỳ tông nào.',
  'LibraryMusic',
  TRUE,
  2
);

-- Sections
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'harmony-and-chords'),
  'markdown',
  'Understanding Chords and Harmony',
  'Hiểu Hợp Âm và Hòa Âm',
  '## Chords and Harmony

**Harmony** is what happens when multiple notes sound simultaneously. **Chords** are the building blocks of harmony — groups of notes played together.

### Building Triads

A **triad** is the most fundamental chord: three notes built by stacking intervals of a **third**.

| Triad Type | Formula | Half Steps | Example (C root) | Sound |
|------------|---------|------------|------------------|-------|
| **Major** | Root + major 3rd + perfect 5th | 0, 4, 7 | C - E - G | Bright, stable |
| **Minor** | Root + minor 3rd + perfect 5th | 0, 3, 7 | C - E♭ - G | Dark, emotional |
| **Diminished** | Root + minor 3rd + diminished 5th | 0, 3, 6 | C - E♭ - G♭ | Tense, unstable |
| **Augmented** | Root + major 3rd + augmented 5th | 0, 4, 8 | C - E - G♯ | Dreamy, ambiguous |

### Diatonic Chords in a Major Key

In C major, each scale degree produces a chord:

| Degree | Roman Numeral | Chord | Type |
|--------|---------------|-------|------|
| 1st | **I** | C major | Major |
| 2nd | **ii** | D minor | Minor |
| 3rd | **iii** | E minor | Minor |
| 4th | **IV** | F major | Major |
| 5th | **V** | G major | Major |
| 6th | **vi** | A minor | Minor |
| 7th | **vii°** | B diminished | Diminished |

### Famous Chord Progressions

| Progression | Genres | Famous Example |
|-------------|--------|----------------|
| **I-IV-V-I** | Blues, Rock, Classical | "Twist and Shout" (Beatles) |
| **I-V-vi-IV** | Pop | "Let It Be," "Don''t Stop Believin''" |
| **I-vi-IV-V** | Doo-wop, 50s Rock | "Stand By Me" |
| **ii-V-I** | Jazz | Standard jazz cadence |

> **Why does I-IV-V-I work?** The V chord creates **tension** (it contains a tritone — the most dissonant interval) that powerfully resolves to I. The IV chord provides contrast and movement away from I. Together, they create the satisfying arc of tension and resolution that makes music feel complete.',
  '## Hợp Âm và Hòa Âm

**Hòa âm** là những gì xảy ra khi nhiều nốt vang lên đồng thời. **Hợp âm** là các đơn vị cơ bản của hòa âm — các nhóm nốt được chơi cùng nhau.

### Xây Dựng Ba Âm

**Ba âm** là hợp âm cơ bản nhất: ba nốt được xây dựng bằng cách xếp chồng các quãng **ba**.

| Loại ba âm | Công thức | Nửa cung | Ví dụ (gốc C) | Âm thanh |
|------------|----------|----------|----------------|----------|
| **Trưởng** | Gốc + quãng 3 trưởng + quãng 5 đúng | 0, 4, 7 | C - E - G | Sáng, ổn định |
| **Thứ** | Gốc + quãng 3 thứ + quãng 5 đúng | 0, 3, 7 | C - E♭ - G | Tối, xúc cảm |
| **Giảm** | Gốc + quãng 3 thứ + quãng 5 giảm | 0, 3, 6 | C - E♭ - G♭ | Căng thẳng, bất ổn |
| **Tăng** | Gốc + quãng 3 trưởng + quãng 5 tăng | 0, 4, 8 | C - E - G♯ | Mơ màng, mơ hồ |

### Hợp Âm Diatonic Trong Tông Trưởng

Trong tông Đô trưởng, mỗi bậc thang âm tạo ra một hợp âm:

| Bậc | Số La Mã | Hợp âm | Loại |
|-----|---------|---------|------|
| 1 | **I** | Đô trưởng | Trưởng |
| 2 | **ii** | Rê thứ | Thứ |
| 3 | **iii** | Mi thứ | Thứ |
| 4 | **IV** | Fa trưởng | Trưởng |
| 5 | **V** | Sol trưởng | Trưởng |
| 6 | **vi** | La thứ | Thứ |
| 7 | **vii°** | Si giảm | Giảm |

### Chuỗi Hợp Âm Nổi Tiếng

| Chuỗi | Thể loại | Ví dụ nổi tiếng |
|-------|---------|-----------------|
| **I-IV-V-I** | Blues, Rock, Cổ điển | "Twist and Shout" (Beatles) |
| **I-V-vi-IV** | Pop | "Let It Be," "Don''t Stop Believin''" |
| **I-vi-IV-V** | Doo-wop, Rock 50s | "Stand By Me" |
| **ii-V-I** | Jazz | Cadence jazz chuẩn |

> **Tại sao I-IV-V-I hoạt động?** Hợp âm V tạo ra **căng thẳng** (nó chứa tritone — quãng bất hòa nhất) giải quyết mạnh mẽ về I. Hợp âm IV cung cấp độ tương phản và chuyển động ra khỏi I. Cùng nhau, chúng tạo ra vòng cung thỏa mãn của căng thẳng và giải phóng khiến âm nhạc cảm thấy trọn vẹn.',
  1,
  '{}'
),
(
  (SELECT id FROM lesson WHERE slug = 'harmony-and-chords'),
  'key_points',
  'Key Points',
  'Điểm Chính',
  '- A **triad** is a chord made of **three** notes: the root, a third, and a fifth
- **Major chord** = Root + major 3rd (4 half steps) + perfect 5th (7 half steps) — sounds bright
- **Minor chord** = Root + minor 3rd (3 half steps) + perfect 5th (7 half steps) — sounds darker
- The chord built on the **first degree** (scale root) is called the **tonic** chord (I)
- **Roman numerals** (I, ii, iii, IV, V, vi, vii°) identify chord degrees — uppercase = major, lowercase = minor
- The **I-IV-V-I** chord progression is the backbone of blues, rock, and much of Western music
- **V → I** is the strongest resolution in harmony — the V chord contains tension that resolves to the tonic
- **Minor chords** generally sound **darker or sadder** than major chords due to the smaller third interval',
  '- **Ba âm** là hợp âm gồm **ba** nốt: nốt gốc, một quãng ba và một quãng năm
- **Hợp âm trưởng** = Gốc + quãng 3 trưởng (4 nửa cung) + quãng 5 đúng (7 nửa cung) — nghe sáng
- **Hợp âm thứ** = Gốc + quãng 3 thứ (3 nửa cung) + quãng 5 đúng (7 nửa cung) — nghe tối hơn
- Hợp âm được xây dựng trên **bậc đầu tiên** (gốc thang âm) được gọi là hợp âm **tonic** (I)
- **Số La Mã** (I, ii, iii, IV, V, vi, vii°) xác định bậc hợp âm — viết hoa = trưởng, viết thường = thứ
- Chuỗi hợp âm **I-IV-V-I** là xương sống của blues, rock và phần lớn âm nhạc phương Tây
- **V → I** là sự giải quyết mạnh nhất trong hòa âm — hợp âm V chứa căng thẳng giải quyết về tonic
- **Hợp âm thứ** thường nghe **tối hoặc buồn hơn** hợp âm trưởng do quãng ba nhỏ hơn',
  2,
  '{}'
),
(
  (SELECT id FROM lesson WHERE slug = 'harmony-and-chords'),
  'info_box',
  'The I-IV-V-I Progression Everywhere',
  'Chuỗi I-IV-V-I Xuất Hiện Khắp Nơi',
  '**The I-IV-V-I progression is arguably the most important sequence in Western music.** Here''s how ubiquitous it really is:

**In C major:** C major (I) → F major (IV) → G major (V) → C major (I)

**Songs using I-IV-V-I or variants:**
- "Twist and Shout" — The Beatles
- "Johnny B. Goode" — Chuck Berry
- "La Bamba" — Ritchie Valens
- "Wild Thing" — The Troggs
- "Hound Dog" — Elvis Presley
- "Surfin'' USA" — The Beach Boys
- Virtually every 12-bar blues song ever written

**Why it works:** The tonic (I) is home. The subdominant (IV) creates movement away from home. The dominant (V) creates tension that desperately wants to return home. The final I resolution delivers the satisfying payoff.

**Try it yourself:** On any instrument, find three chords in any key following the pattern. You will immediately recognize the sound — it is embedded in the DNA of Western music.',
  '**Chuỗi I-IV-V-I có thể là chuỗi quan trọng nhất trong âm nhạc phương Tây.** Đây là mức độ phổ biến thực sự của nó:

**Trong Đô trưởng:** Đô trưởng (I) → Fa trưởng (IV) → Sol trưởng (V) → Đô trưởng (I)

**Bài hát sử dụng I-IV-V-I hoặc biến thể:**
- "Twist and Shout" — The Beatles
- "Johnny B. Goode" — Chuck Berry
- "La Bamba" — Ritchie Valens
- "Wild Thing" — The Troggs
- "Hound Dog" — Elvis Presley
- "Surfin'' USA" — The Beach Boys
- Hầu hết mọi bài blues 12 nhịp từng được viết

**Tại sao nó hoạt động:** Tonic (I) là nhà. Subdominant (IV) tạo chuyển động rời nhà. Dominant (V) tạo căng thẳng muốn trở về nhà. Phân giải I cuối cùng mang lại sự thỏa mãn.

**Hãy thử:** Trên bất kỳ nhạc cụ nào, tìm ba hợp âm trong bất kỳ tông nào theo công thức. Bạn sẽ ngay lập tức nhận ra âm thanh — nó được nhúng trong DNA của âm nhạc phương Tây.',
  3,
  '{"variant": "tip"}'
);

-- Exercises
-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'harmony-and-chords'),
  'fill_blank',
  'easy',
  'Fill in the number of notes in a triad.',
  'Điền số nốt trong một ba âm.',
  'A triad is a chord made of ___ notes.',
  'Ba âm là hợp âm gồm ___ nốt.',
  'three',
  'A triad (from the Latin "trias," meaning "three") is a chord built from three notes: the root note, a note a third above the root, and a note a fifth above the root. By stacking two intervals of a third, you produce the most fundamental chord structure in Western music. All common guitar and piano chords used in popular music are built on this three-note foundation.',
  'Ba âm (từ tiếng Latin "trias," có nghĩa là "ba") là hợp âm được xây dựng từ ba nốt: nốt gốc, nốt cách một quãng ba trên gốc và nốt cách một quãng năm trên gốc. Bằng cách xếp chồng hai quãng ba, bạn tạo ra cấu trúc hợp âm cơ bản nhất trong âm nhạc phương Tây. Tất cả hợp âm guitar và piano phổ biến trong nhạc đại chúng được xây dựng trên nền tảng ba nốt này.',
  10,
  1
);

-- Exercise 2: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'harmony-and-chords'),
  'multiple_choice',
  'easy',
  'A major chord consists of which interval pattern?',
  'Hợp âm trưởng gồm công thức quãng nào?',
  'Select the correct interval formula for building a major chord from any root note.',
  'Chọn công thức quãng đúng để xây dựng hợp âm trưởng từ bất kỳ nốt gốc nào.',
  'A major chord is built from: Root + major 3rd (4 half steps) + perfect 5th (7 half steps). In C major: C (root) + E (major 3rd, 4 half steps up) + G (perfect 5th, 7 half steps up). The major 3rd is what gives major chords their bright, uplifting sound. Replacing the major 3rd with a minor 3rd (3 half steps) produces the darker-sounding minor chord.',
  'Hợp âm trưởng được xây dựng từ: Gốc + quãng 3 trưởng (4 nửa cung) + quãng 5 đúng (7 nửa cung). Trong Đô trưởng: C (gốc) + E (quãng 3 trưởng, lên 4 nửa cung) + G (quãng 5 đúng, lên 7 nửa cung). Quãng 3 trưởng là thứ mang lại âm thanh sáng, vui vẻ cho hợp âm trưởng. Thay quãng 3 trưởng bằng quãng 3 thứ (3 nửa cung) tạo ra hợp âm thứ nghe tối hơn.',
  10,
  2
);
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, explanation, order_index) VALUES
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'harmony-and-chords') AND order_index = 2),
  'A', 'Root, minor 3rd, 5th', 'Gốc, quãng 3 thứ, quãng 5', FALSE,
  'Root + minor 3rd + perfect 5th is the formula for a minor chord, not major',
  1
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'harmony-and-chords') AND order_index = 2),
  'B', 'Root, major 3rd, perfect 5th', 'Gốc, quãng 3 trưởng, quãng 5 đúng', TRUE,
  'Correct! A major chord = Root + major 3rd (4 half steps) + perfect 5th (7 half steps)',
  2
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'harmony-and-chords') AND order_index = 2),
  'C', 'Root, 4th, 7th', 'Gốc, quãng 4, quãng 7', FALSE,
  'Root + 4th + 7th is not a standard triad formula — triads stack thirds, not fourths',
  3
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'harmony-and-chords') AND order_index = 2),
  'D', 'Root, 2nd, 5th', 'Gốc, quãng 2, quãng 5', FALSE,
  'Root + 2nd + 5th creates a suspended chord (sus2), not a standard major triad',
  4
);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'harmony-and-chords'),
  'true_false',
  'easy',
  'Is this statement about chord progressions correct?',
  'Phát biểu này về chuỗi hợp âm có đúng không?',
  'The I-IV-V-I chord progression is used in blues and rock music.',
  'Chuỗi hợp âm I-IV-V-I được dùng trong nhạc blues và rock.',
  'true',
  'True! The I-IV-V-I progression is the foundational harmonic sequence of the blues and, by extension, rock and roll. The 12-bar blues is built almost entirely on I, IV, and V chords. Chuck Berry, Elvis Presley, Little Richard, and nearly every early rock musician used this progression. It provides the perfect balance of stability (I), movement (IV), tension (V), and resolution (back to I).',
  'Đúng! Chuỗi I-IV-V-I là trình tự hòa âm nền tảng của blues và, theo đó, rock and roll. Blues 12 nhịp được xây dựng gần như hoàn toàn trên hợp âm I, IV và V. Chuck Berry, Elvis Presley, Little Richard và hầu hết mọi nhạc sĩ rock đầu thời đều dùng chuỗi này. Nó cung cấp sự cân bằng hoàn hảo giữa ổn định (I), chuyển động (IV), căng thẳng (V) và giải phóng (về lại I).',
  5,
  3
);

-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'harmony-and-chords'),
  'fill_blank',
  'medium',
  'Fill in the name for the chord built on the first degree of a scale.',
  'Điền tên hợp âm được xây dựng trên bậc đầu tiên của thang âm.',
  'The chord built on the first degree of a scale is called the ___ chord.',
  'Hợp âm được xây dựng trên bậc đầu tiên của thang âm được gọi là hợp âm ___.',
  'tonic',
  'The tonic chord (Roman numeral I) is built on the first scale degree and represents the "home" key of the music. It provides the strongest sense of rest and resolution. Music naturally wants to return to the tonic — this gravitational pull is the engine of harmonic tension and release. In C major, the tonic chord is C major (C-E-G). In A minor, the tonic is A minor (A-C-E).',
  'Hợp âm tonic (số La Mã I) được xây dựng trên bậc thang âm đầu tiên và đại diện cho tông "nhà" của âm nhạc. Nó cung cấp cảm giác nghỉ ngơi và giải phóng mạnh nhất. Âm nhạc tự nhiên muốn trở về tonic — lực hấp dẫn này là động cơ của căng thẳng và giải phóng hòa âm. Trong Đô trưởng, hợp âm tonic là Đô trưởng (C-E-G). Trong La thứ, tonic là La thứ (A-C-E).',
  10,
  4
);

-- Exercise 5: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'harmony-and-chords'),
  'true_false',
  'easy',
  'Is this statement about chord qualities correct?',
  'Phát biểu này về chất lượng hợp âm có đúng không?',
  'Minor chords generally sound darker or sadder than major chords.',
  'Hợp âm thứ thường nghe tối hoặc buồn hơn hợp âm trưởng.',
  'true',
  'True! The difference between major and minor chords comes down to one note: the third. A major chord uses a major 3rd (4 half steps from root), while a minor chord uses a minor 3rd (3 half steps). That single half-step difference dramatically changes the emotional quality. Psychoacoustic research confirms that people across cultures associate major chords with positive emotions and minor chords with sadness or introspection — though cultural conditioning also plays a role.',
  'Đúng! Sự khác biệt giữa hợp âm trưởng và thứ đến từ một nốt: quãng ba. Hợp âm trưởng sử dụng quãng 3 trưởng (4 nửa cung từ gốc), trong khi hợp âm thứ sử dụng quãng 3 thứ (3 nửa cung). Sự khác biệt một nửa cung đó làm thay đổi đáng kể chất lượng cảm xúc. Nghiên cứu tâm lý âm học xác nhận rằng người dân xuyên văn hóa liên kết hợp âm trưởng với cảm xúc tích cực và hợp âm thứ với buồn bã hoặc nội tâm — mặc dù điều kiện văn hóa cũng đóng vai trò.',
  5,
  5
);


-- ############################################################################
-- LESSON: RHYTHM AND METER (slug = rhythm-and-meter)
-- order_index = 4
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Rhythm and Meter',
  'Nhịp Điệu và Phách',
  'rhythm-and-meter',
  'Master time signatures, note values, and rhythmic patterns',
  'Thành thạo ký hiệu nhịp, giá trị nốt và các mẫu nhịp điệu',
  'beginner',
  30,
  4
FROM category WHERE name = 'Music Theory';

-- Usages
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'rhythm-and-meter'),
  'Time Signatures',
  'Ký Hiệu Nhịp',
  'A time signature tells you how many beats are in each measure and what type of note gets one beat. The top number indicates the count of beats per measure; the bottom number indicates the note value that equals one beat (4 = quarter note, 8 = eighth note). 4/4 is the most common time signature in Western popular music.',
  'Ký hiệu nhịp cho bạn biết có bao nhiêu phách trong mỗi nhịp và loại nốt nào được tính một phách. Số trên cho biết số phách mỗi nhịp; số dưới cho biết giá trị nốt bằng một phách (4 = nốt đen, 8 = nốt móc đơn). 4/4 là ký hiệu nhịp phổ biến nhất trong nhạc đại chúng phương Tây.',
  'Timer',
  TRUE,
  1
),
(
  (SELECT id FROM lesson WHERE slug = 'rhythm-and-meter'),
  'Note Values and Rests',
  'Giá Trị Nốt và Dấu Lặng',
  'Every note and rest has a duration value that determines how long it is held. In 4/4 time: a whole note lasts 4 beats, a half note 2 beats, a quarter note 1 beat, an eighth note half a beat. Rests have the same duration values as notes — they indicate silence for that duration.',
  'Mỗi nốt và dấu lặng có giá trị thời lượng xác định độ dài. Trong nhịp 4/4: nốt tròn kéo dài 4 phách, nốt trắng 2 phách, nốt đen 1 phách, nốt móc đơn nửa phách. Dấu lặng có cùng giá trị thời lượng với nốt — chúng chỉ ra sự im lặng trong thời lượng đó.',
  'PauseCircle',
  TRUE,
  2
);

-- Sections
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'rhythm-and-meter'),
  'markdown',
  'Rhythm, Meter, and Note Values',
  'Nhịp Điệu, Phách và Giá Trị Nốt',
  '## Rhythm and Meter

**Rhythm** is the pattern of sounds and silences in music. **Meter** is the recurring framework of beats that organizes rhythm — like a grid the music moves within.

### Reading a Time Signature

```
    4   ← Top number: 4 beats per measure
   ---
    4   ← Bottom number: quarter note (♩) = 1 beat
```

| Time Signature | Beats per Measure | Beat Note | Feel | Common Genre |
|----------------|------------------|-----------|------|--------------|
| **4/4** | 4 | Quarter note | Strong 1 and 3 | Pop, rock, most music |
| **3/4** | 3 | Quarter note | Waltz feel (1-2-3) | Waltzes, folk ballads |
| **2/4** | 2 | Quarter note | March feel | Marches, polkas |
| **6/8** | 6 (or 2 strong) | Eighth note | Compound duple | Jigs, compound feel |

### Note Value Hierarchy (in 4/4 time)

| Note | Symbol | Duration | Subdivisions |
|------|--------|----------|--------------|
| **Whole note** | 𝅝 | 4 beats | = 2 half notes |
| **Half note** | 𝅗𝅥 | 2 beats | = 2 quarter notes |
| **Quarter note** | ♩ | 1 beat | = 2 eighth notes |
| **Eighth note** | ♪ | ½ beat | = 2 sixteenth notes |
| **Sixteenth note** | ♬ | ¼ beat | = 2 thirty-second notes |

### The Dotted Note Rule

A dot after a note **adds half its value**:
- Dotted half note = 2 + 1 = **3 beats**
- Dotted quarter note = 1 + ½ = **1.5 beats**

### Common Rhythm Patterns

| Pattern | Name | Description |
|---------|------|-------------|
| ♩♩♩♩ | Straight quarters | Four equal beats |
| ♩.♪♩.♪ | Dotted rhythm | Long-short-long-short feel |
| ♩_♩_♩_♩ (tied) | Syncopation | Emphasis on off-beats |
| ♪♪♪♪♪♪♪♪ | Eighth note groove | Two per beat |

> **The downbeat vs. upbeat**: Beats 1 and 3 are "downbeats" (strong), beats 2 and 4 are "upbeats" (weak). Rock music places the snare drum on beats 2 and 4, creating the characteristic "backbeat" that drives the groove.',
  '## Nhịp Điệu và Phách

**Nhịp điệu** là mẫu âm thanh và im lặng trong âm nhạc. **Phách** là khuôn khổ phách lặp lại tổ chức nhịp điệu — như lưới mà âm nhạc di chuyển trong đó.

### Đọc Ký Hiệu Nhịp

```
    4   ← Số trên: 4 phách mỗi nhịp
   ---
    4   ← Số dưới: nốt đen (♩) = 1 phách
```

| Ký hiệu nhịp | Phách mỗi nhịp | Nốt phách | Cảm giác | Thể loại phổ biến |
|--------------|----------------|-----------|----------|-------------------|
| **4/4** | 4 | Nốt đen | Mạnh 1 và 3 | Pop, rock, hầu hết nhạc |
| **3/4** | 3 | Nốt đen | Cảm giác valse (1-2-3) | Valse, dân ca ballad |
| **2/4** | 2 | Nốt đen | Cảm giác hành quân | Hành quân, polka |
| **6/8** | 6 (hoặc 2 mạnh) | Nốt móc | Nhịp đôi kép | Jig, cảm giác kép |

### Hệ Thống Phân Cấp Giá Trị Nốt (trong nhịp 4/4)

| Nốt | Ký hiệu | Thời lượng | Phân chia |
|-----|---------|-----------|-----------|
| **Nốt tròn** | 𝅝 | 4 phách | = 2 nốt trắng |
| **Nốt trắng** | 𝅗𝅥 | 2 phách | = 2 nốt đen |
| **Nốt đen** | ♩ | 1 phách | = 2 nốt móc đơn |
| **Nốt móc đơn** | ♪ | ½ phách | = 2 nốt móc kép |
| **Nốt móc kép** | ♬ | ¼ phách | = 2 nốt móc ba |

### Quy Tắc Nốt Chấm

Chấm sau nốt **thêm nửa giá trị của nó**:
- Nốt trắng chấm = 2 + 1 = **3 phách**
- Nốt đen chấm = 1 + ½ = **1.5 phách**

### Các Mẫu Nhịp Phổ Biến

| Mẫu | Tên | Mô tả |
|-----|-----|-------|
| ♩♩♩♩ | Nốt đen thẳng | Bốn phách bằng nhau |
| ♩.♪♩.♪ | Nhịp chấm | Cảm giác dài-ngắn |
| Nốt buộc | Đảo phách | Nhấn mạnh phách yếu |
| ♪♪♪♪♪♪♪♪ | Groove móc đơn | Hai nốt mỗi phách |

> **Phách mạnh và nhẹ**: Phách 1 và 3 là "phách mạnh," phách 2 và 4 là "phách nhẹ." Nhạc rock đặt trống snare ở phách 2 và 4, tạo ra "backbeat" đặc trưng thúc đẩy groove.',
  1,
  '{}'
),
(
  (SELECT id FROM lesson WHERE slug = 'rhythm-and-meter'),
  'key_points',
  'Key Points',
  'Điểm Chính',
  '- In **4/4 time**, there are **4 beats** per measure — the most common time signature in Western music
- The **top number** of a time signature = beats per measure; **bottom number** = which note value gets one beat
- A **quarter note** in 4/4 gets **1 beat**; a half note gets 2; a whole note gets 4; an eighth note gets ½
- A note that lasts twice as long as a quarter note is called a **half** note
- **3/4 time** (waltz) has **three** beats per measure — not four
- A **rest** indicates silence for a specific duration — rests have the same duration values as notes
- A **dotted note** adds half its value to the note (dotted quarter = 1.5 beats)
- **Syncopation** places emphasis on normally weak beats or between beats — it is the rhythmic foundation of jazz, funk, and Latin music',
  '- Trong nhịp **4/4**, có **4 phách** mỗi nhịp — ký hiệu nhịp phổ biến nhất trong âm nhạc phương Tây
- **Số trên** của ký hiệu nhịp = phách mỗi nhịp; **số dưới** = giá trị nốt nào được tính một phách
- **Nốt đen** trong 4/4 được **1 phách**; nốt trắng được 2; nốt tròn được 4; nốt móc đơn được ½
- Nốt kéo dài gấp đôi nốt đen được gọi là nốt **trắng**
- Nhịp **3/4** (valse) có **ba** phách mỗi nhịp — không phải bốn
- **Dấu lặng** chỉ ra sự im lặng trong một thời lượng cụ thể — dấu lặng có cùng giá trị thời lượng với nốt
- **Nốt chấm** thêm nửa giá trị vào nốt (nốt đen chấm = 1.5 phách)
- **Đảo phách** đặt nhấn mạnh vào phách thường yếu hoặc giữa các phách — đây là nền tảng nhịp điệu của jazz, funk và nhạc Latin',
  2,
  '{}'
),
(
  (SELECT id FROM lesson WHERE slug = 'rhythm-and-meter'),
  'info_box',
  '4/4: Common Time',
  '4/4: Nhịp Phổ Biến',
  '**4/4 time is so common it is literally called "common time"** and can be notated with a "C" symbol instead of 4/4.

**Why is 4/4 everywhere?**
- Four beats maps naturally onto the human body: two footsteps per cycle (left-right = 1-2, left-right = 3-4)
- It divides evenly in many ways: 2+2, 1+3, 1+1+2, all 1s — giving composers enormous rhythmic flexibility
- It provides a strong downbeat (beat 1) with a secondary accent (beat 3), creating a satisfying rhythmic tension

**4/4 in different feels:**
- **Rock/Pop**: Snare on beats 2 and 4 creates the backbeat
- **Funk**: Emphasis on the "one" (beat 1) — "On the one!"
- **Gospel/Soul**: Heavy emphasis on beats 2 and 4, often with hand claps
- **Classical**: Even distribution across all four beats

**Contrast with 3/4 (waltz):** The waltz has a distinctly circular, flowing feel because it has an ODD number of beats (1-2-3), creating a continuous forward momentum without the symmetrical "pause" that the 4th beat in 4/4 provides.',
  '**Nhịp 4/4 phổ biến đến mức được gọi là "nhịp thông thường"** và có thể ký hiệu bằng chữ "C" thay vì 4/4.

**Tại sao 4/4 xuất hiện khắp nơi?**
- Bốn phách ánh xạ tự nhiên lên cơ thể con người: hai bước chân mỗi chu kỳ (trái-phải = 1-2, trái-phải = 3-4)
- Nó chia đều theo nhiều cách: 2+2, 1+3, 1+1+2, tất cả 1 — mang lại sự linh hoạt nhịp điệu rất lớn cho nhà soạn nhạc
- Nó cung cấp phách mạnh (phách 1) với nhấn mạnh phụ (phách 3), tạo ra căng thẳng nhịp điệu thỏa mãn

**4/4 trong các cảm giác khác nhau:**
- **Rock/Pop**: Trống snare ở phách 2 và 4 tạo backbeat
- **Funk**: Nhấn mạnh vào "một" (phách 1) — "On the one!"
- **Gospel/Soul**: Nhấn mạnh nặng vào phách 2 và 4, thường với vỗ tay
- **Cổ điển**: Phân phối đều trên cả bốn phách

**Đối chiếu với 3/4 (valse):** Valse có cảm giác tròn, chảy riêng biệt vì nó có số phách LẺ (1-2-3), tạo ra động lực tiến về phía trước liên tục mà không có "dừng" đối xứng mà phách thứ 4 trong 4/4 cung cấp.',
  3,
  '{"variant": "tip"}'
);

-- Exercises
-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'rhythm-and-meter'),
  'fill_blank',
  'easy',
  'Fill in the number of beats per measure in 4/4 time.',
  'Điền số phách mỗi nhịp trong nhịp 4/4.',
  'In 4/4 time, there are ___ beats per measure.',
  'Trong nhịp 4/4, có ___ phách mỗi nhịp.',
  '4',
  'In a time signature, the top number (4) tells you how many beats are in each measure, and the bottom number (4) tells you which note value receives one beat (4 = quarter note). So 4/4 means "four quarter-note beats per measure." This is why 4/4 is called "common time" — it is the most frequently used time signature in Western music, used in the vast majority of pop, rock, classical, and folk songs.',
  'Trong ký hiệu nhịp, số trên (4) cho biết có bao nhiêu phách trong mỗi nhịp, và số dưới (4) cho biết giá trị nốt nào được tính một phách (4 = nốt đen). Vậy 4/4 có nghĩa là "bốn phách nốt đen mỗi nhịp." Đây là lý do 4/4 được gọi là "nhịp thông thường" — đây là ký hiệu nhịp được sử dụng thường xuyên nhất trong âm nhạc phương Tây, dùng trong đại đa số bài pop, rock, cổ điển và dân ca.',
  10,
  1
);

-- Exercise 2: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'rhythm-and-meter'),
  'multiple_choice',
  'easy',
  'A quarter note in 4/4 time gets how many beats?',
  'Nốt đen trong nhịp 4/4 được bao nhiêu phách?',
  'In 4/4 time, the bottom number "4" indicates that the quarter note equals one beat. How many beats does a quarter note receive?',
  'Trong nhịp 4/4, số dưới "4" chỉ ra rằng nốt đen bằng một phách. Nốt đen nhận được bao nhiêu phách?',
  'In 4/4 time, the bottom number 4 means the quarter note (crotchet) receives exactly 1 beat. This means: a whole note = 4 beats, a half note = 2 beats, a quarter note = 1 beat, an eighth note = ½ beat. The quarter note is the basic unit of counting in 4/4 — when you tap your foot to a song, you are typically tapping quarter notes.',
  'Trong nhịp 4/4, số dưới 4 có nghĩa là nốt đen nhận được đúng 1 phách. Điều này có nghĩa: nốt tròn = 4 phách, nốt trắng = 2 phách, nốt đen = 1 phách, nốt móc đơn = ½ phách. Nốt đen là đơn vị đếm cơ bản trong 4/4 — khi bạn gõ chân theo bài hát, bạn thường đang gõ nốt đen.',
  10,
  2
);
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, explanation, order_index) VALUES
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'rhythm-and-meter') AND order_index = 2),
  'A', '4', '4', FALSE,
  'A whole note gets 4 beats in 4/4 — the quarter note gets 1',
  1
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'rhythm-and-meter') AND order_index = 2),
  'B', '2', '2', FALSE,
  'A half note gets 2 beats — the quarter note gets half that',
  2
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'rhythm-and-meter') AND order_index = 2),
  'C', '1', '1', TRUE,
  'Correct! The quarter note (bottom number 4) receives exactly 1 beat in 4/4 time',
  3
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'rhythm-and-meter') AND order_index = 2),
  'D', '0.5', '0.5', FALSE,
  'An eighth note gets ½ beat — the quarter note gets twice that',
  4
);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'rhythm-and-meter'),
  'true_false',
  'easy',
  'Is this statement about rests correct?',
  'Phát biểu này về dấu lặng có đúng không?',
  'A rest in music notation indicates silence for a specific duration.',
  'Dấu lặng trong ký hiệu âm nhạc chỉ ra sự im lặng trong một thời lượng cụ thể.',
  'true',
  'True! Rests are as important as notes in music — silence is a fundamental element of rhythm and expression. Each rest symbol corresponds to a note value: whole rest (4 beats), half rest (2 beats), quarter rest (1 beat), eighth rest (½ beat). In music, a well-placed rest can be more powerful than any note — consider the dramatic silence before the final chord of a symphony, or the "breath" between phrases that gives melodies their shape.',
  'Đúng! Dấu lặng quan trọng như nốt trong âm nhạc — im lặng là yếu tố cơ bản của nhịp điệu và biểu cảm. Mỗi ký hiệu dấu lặng tương ứng với giá trị nốt: dấu lặng tròn (4 phách), dấu lặng trắng (2 phách), dấu lặng đen (1 phách), dấu lặng móc đơn (½ phách). Trong âm nhạc, dấu lặng được đặt đúng chỗ có thể mạnh mẽ hơn bất kỳ nốt nào — hãy nghĩ đến sự im lặng kịch tính trước hợp âm cuối của bản giao hưởng, hay "hơi thở" giữa các câu nhạc tạo hình dạng cho giai điệu.',
  5,
  3
);

-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'rhythm-and-meter'),
  'fill_blank',
  'easy',
  'Fill in the name of the note that lasts twice as long as a quarter note.',
  'Điền tên nốt kéo dài gấp đôi nốt đen.',
  'A note that lasts twice as long as a quarter note is called a ___ note.',
  'Nốt kéo dài gấp đôi nốt đen được gọi là nốt ___.',
  'half',
  'A half note (minim) lasts for 2 beats in 4/4 time — exactly twice the duration of a quarter note (1 beat). The half note gets its name because it is half the duration of a whole note (4 beats). The hierarchy in 4/4: whole note (4) = 2 half notes (2) = 4 quarter notes (1) = 8 eighth notes (½). Each step down halves the duration.',
  'Nốt trắng (half note) kéo dài 2 phách trong nhịp 4/4 — gấp đôi thời lượng của nốt đen (1 phách). Nốt trắng có tên như vậy vì nó là nửa thời lượng của nốt tròn (4 phách). Hệ thống phân cấp trong 4/4: nốt tròn (4) = 2 nốt trắng (2) = 4 nốt đen (1) = 8 nốt móc đơn (½). Mỗi bước xuống giảm nửa thời lượng.',
  10,
  4
);

-- Exercise 5: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'rhythm-and-meter'),
  'true_false',
  'easy',
  'Is this statement about 3/4 time correct?',
  'Phát biểu này về nhịp 3/4 có đúng không?',
  '3/4 time (waltz) has four beats per measure.',
  'Nhịp 3/4 (valse) có bốn phách mỗi nhịp.',
  'false',
  'False! 3/4 time has THREE beats per measure, not four. The top number (3) always tells you the number of beats per measure. The waltz, Viennese waltz, and minuet are all in 3/4, giving them their characteristic lilting, circular feel with a strong downbeat on beat 1 followed by two weaker beats. This is fundamentally different from 4/4 where there are four beats with strong accents on beats 1 and 3.',
  'Sai! Nhịp 3/4 có BA phách mỗi nhịp, không phải bốn. Số trên (3) luôn cho biết số phách mỗi nhịp. Valse, valse Viennese và minuet đều ở nhịp 3/4, mang lại cảm giác đặc trưng nhẹ nhàng, tròn với phách mạnh ở phách 1 theo sau là hai phách yếu hơn. Điều này cơ bản khác với 4/4 nơi có bốn phách với nhấn mạnh mạnh ở phách 1 và 3.',
  5,
  5
);


-- ============================================================================
-- VERIFICATION QUERY
-- ============================================================================

SELECT l.id, l.name, l.slug,
  (SELECT COUNT(*) FROM lesson_usage WHERE lesson_id = l.id) AS usages,
  (SELECT COUNT(*) FROM lesson_section WHERE lesson_id = l.id) AS sections,
  (SELECT COUNT(*) FROM exercise WHERE lesson_id = l.id) AS exercises
FROM lesson l
WHERE l.group_id = (SELECT id FROM category WHERE name = 'Music Theory')
ORDER BY l.order_index;
