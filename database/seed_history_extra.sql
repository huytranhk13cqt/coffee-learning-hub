-- ============================================================================
-- SEED DATA: World History — Extra Lessons
-- Adds 2 lessons to existing category 'World History' (ID 10)
-- Prerequisite: seed_history.sql must have been applied (lesson 33 exists)
-- lesson order_index continues from 1 (existing) → 3, 4
-- ============================================================================


-- ############################################################################
-- LESSON: THE RENAISSANCE (slug = the-renaissance)
-- order_index = 3 (lesson 33 is order_index 1; 2 reserved for next lesson)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'The Renaissance',
  'Thời Kỳ Phục Hưng',
  'the-renaissance',
  'Explore the cultural, artistic, and intellectual revolution of 14th-17th century Europe',
  'Khám phá cuộc cách mạng văn hóa, nghệ thuật và trí tuệ châu Âu thế kỷ 14-17',
  'beginner',
  30,
  3
FROM category WHERE name = 'World History';

-- Usages
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'the-renaissance'),
  'Humanism',
  'Chủ Nghĩa Nhân Văn',
  'Humanism was the defining intellectual movement of the Renaissance, placing human beings — rather than God or nature — at the center of intellectual life. Humanists studied classical Greek and Roman texts, believing that education in the humanities (grammar, rhetoric, poetry, history, and philosophy) could create better citizens and leaders.',
  'Chủ nghĩa nhân văn là phong trào trí tuệ định nghĩa Thời Kỳ Phục Hưng, đặt con người — thay vì Chúa hay thiên nhiên — vào trung tâm của đời sống trí tuệ. Các nhà nhân văn nghiên cứu các văn bản Hy Lạp và La Mã cổ điển, tin rằng giáo dục nhân văn (ngữ pháp, tu từ, thơ, lịch sử và triết học) có thể tạo ra công dân và nhà lãnh đạo tốt hơn.',
  'School',
  TRUE,
  1
),
(
  (SELECT id FROM lesson WHERE slug = 'the-renaissance'),
  'Art and Architecture',
  'Nghệ Thuật và Kiến Trúc',
  'Renaissance artists revolutionized European art by applying mathematical perspective, studying human anatomy, and depicting subjects with unprecedented realism. Architects drew on classical Greek and Roman forms — columns, domes, and symmetry — to design buildings that celebrated human achievement and rational order.',
  'Các nghệ sĩ Phục Hưng đã cách mạng hóa nghệ thuật châu Âu bằng cách áp dụng phối cảnh toán học, nghiên cứu giải phẫu người và mô tả chủ thể với chủ nghĩa hiện thực chưa từng có. Các kiến trúc sư rút ra từ các hình thức Hy Lạp và La Mã cổ điển — cột, mái vòm và đối xứng — để thiết kế các tòa nhà tôn vinh thành tựu của con người và trật tự lý trí.',
  'Palette',
  TRUE,
  2
);

-- Sections
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'the-renaissance'),
  'markdown',
  'The Renaissance: A Rebirth of Knowledge',
  'Thời Kỳ Phục Hưng: Sự Tái Sinh Tri Thức',
  '## The Renaissance (14th–17th Century)

The word *Renaissance* means **"rebirth"** in French. It describes a cultural, artistic, and intellectual movement that began in **Italy** in the 14th century and gradually spread across Europe, lasting until the early 17th century.

### Origins in Florence

Florence, Italy became the cradle of the Renaissance. The city''s wealthy merchant class — especially the **Medici family** — funded artists, architects, and scholars. Their patronage created the conditions for an explosion of creativity.

### Key Figures and Their Contributions

| Figure | Field | Key Work |
|--------|-------|----------|
| **Leonardo da Vinci** | Art, Science | Mona Lisa, The Last Supper, anatomical drawings |
| **Michelangelo** | Sculpture, Painting | David, Sistine Chapel ceiling |
| **Raphael** | Painting | The School of Athens |
| **Sandro Botticelli** | Painting | The Birth of Venus |
| **Filippo Brunelleschi** | Architecture | Florence Cathedral dome |
| **Niccolò Machiavelli** | Political thought | The Prince |
| **Erasmus** | Humanism | In Praise of Folly |

### The Printing Press (1440)

Johannes Gutenberg''s printing press transformed the spread of Renaissance ideas. Before printing, books were hand-copied by monks — expensive and rare. After Gutenberg, ideas could be reproduced at scale, accelerating the Reformation, scientific inquiry, and literacy across Europe.

> *"The first condition of happiness is the knowledge of good art."*
> — **Leonardo da Vinci**',
  '## Thời Kỳ Phục Hưng (Thế kỷ 14–17)

Từ *Renaissance* nghĩa là **"tái sinh"** trong tiếng Pháp. Nó mô tả một phong trào văn hóa, nghệ thuật và trí tuệ bắt đầu ở **Ý** vào thế kỷ 14 và dần dần lan rộng khắp châu Âu, kéo dài đến đầu thế kỷ 17.

### Nguồn Gốc Ở Florence

Florence, Ý trở thành cái nôi của Thời Kỳ Phục Hưng. Tầng lớp thương nhân giàu có của thành phố — đặc biệt là **gia đình Medici** — tài trợ cho các nghệ sĩ, kiến trúc sư và học giả. Sự bảo trợ của họ tạo ra điều kiện cho một vụ nổ sáng tạo.

### Các Nhân Vật Quan Trọng và Đóng Góp

| Nhân vật | Lĩnh vực | Tác phẩm chính |
|---------|---------|----------------|
| **Leonardo da Vinci** | Nghệ thuật, Khoa học | Mona Lisa, Bữa Tối Cuối Cùng, bản vẽ giải phẫu |
| **Michelangelo** | Điêu khắc, Hội họa | David, trần nhà nguyện Sistine |
| **Raphael** | Hội họa | Trường Học Athens |
| **Sandro Botticelli** | Hội họa | Sự Ra Đời Của Venus |
| **Filippo Brunelleschi** | Kiến trúc | Mái vòm Nhà thờ Florence |
| **Niccolò Machiavelli** | Tư tưởng chính trị | Quân Vương |
| **Erasmus** | Chủ nghĩa nhân văn | Ca Ngợi Sự Ngu Ngốc |

### Máy In (1440)

Máy in của Johannes Gutenberg đã biến đổi sự lan truyền các ý tưởng Phục Hưng. Trước khi in ấn, sách được sao chép tay bởi các tu sĩ — đắt đỏ và hiếm có. Sau Gutenberg, các ý tưởng có thể được tái tạo ở quy mô lớn, đẩy nhanh cuộc Cải cách, nghiên cứu khoa học và khả năng đọc viết trên khắp châu Âu.

> *"Điều kiện đầu tiên của hạnh phúc là kiến thức về nghệ thuật tốt."*
> — **Leonardo da Vinci**',
  1,
  '{}'
),
(
  (SELECT id FROM lesson WHERE slug = 'the-renaissance'),
  'key_points',
  'Key Points',
  'Điểm Chính',
  '- The Renaissance began in **Italy** (especially Florence) in the **14th century** and spread across Europe
- **Humanism** placed humans — not God — at the center of intellectual life, reviving interest in classical texts
- The **Medici family** of Florence were the most influential patrons, funding Leonardo, Botticelli, and Michelangelo
- **Leonardo da Vinci** painted the Mona Lisa and The Last Supper — embodying the Renaissance ideal of the "universal man"
- **Michelangelo** sculpted David and painted the Sistine Chapel ceiling — works that remain pinnacles of Western art
- **Linear perspective** (developed by Brunelleschi) gave Renaissance painting its revolutionary sense of depth and realism
- **Gutenberg''s printing press** (c. 1440) accelerated the spread of Renaissance ideas across Europe
- The Renaissance laid the intellectual foundation for the **Scientific Revolution** and the **Protestant Reformation**',
  '- Thời Kỳ Phục Hưng bắt đầu ở **Ý** (đặc biệt là Florence) vào **thế kỷ 14** và lan rộng khắp châu Âu
- **Chủ nghĩa nhân văn** đặt con người — không phải Chúa — vào trung tâm của đời sống trí tuệ, hồi sinh sự quan tâm đến các văn bản cổ điển
- **Gia đình Medici** của Florence là những người bảo trợ có ảnh hưởng nhất, tài trợ cho Leonardo, Botticelli và Michelangelo
- **Leonardo da Vinci** vẽ Mona Lisa và Bữa Tối Cuối Cùng — thể hiện lý tưởng Phục Hưng về "người đa tài"
- **Michelangelo** tạo tượng David và vẽ trần nhà nguyện Sistine — những tác phẩm vẫn là đỉnh cao nghệ thuật phương Tây
- **Phối cảnh tuyến tính** (phát triển bởi Brunelleschi) mang lại cảm giác chiều sâu và chủ nghĩa hiện thực cách mạng cho hội họa Phục Hưng
- **Máy in của Gutenberg** (khoảng 1440) đẩy nhanh sự lan truyền các ý tưởng Phục Hưng khắp châu Âu
- Thời Kỳ Phục Hưng đặt nền tảng trí tuệ cho **Cách Mạng Khoa Học** và **Cuộc Cải Cách Tin Lành**',
  2,
  '{}'
),
(
  (SELECT id FROM lesson WHERE slug = 'the-renaissance'),
  'info_box',
  'Florence: The Birthplace of the Renaissance',
  'Florence: Cái Nôi Của Thời Kỳ Phục Hưng',
  '**Why did the Renaissance begin in Florence?**

Florence in the 14th–15th centuries was uniquely positioned:

- **Wealth from banking and trade**: Florentine banks (especially the Medici bank) financed European monarchs, generating enormous wealth
- **The Medici family**: Cosimo de'' Medici (1389–1464) and his grandson Lorenzo "the Magnificent" (1449–1492) spent lavishly on art, architecture, and scholarship
- **Guild culture**: Florence''s powerful craft guilds commissioned public art, turning the city into an open-air gallery
- **Classical manuscripts**: Italian scholars had greater access to surviving Greek and Roman texts than northern Europeans

The Medici''s patronage was so central that without them, figures like Botticelli, Michelangelo, and Leonardo might never have had the resources to produce their masterpieces. Florence demonstrates how economic prosperity and cultural investment can trigger an artistic golden age.',
  '**Tại sao Thời Kỳ Phục Hưng bắt đầu ở Florence?**

Florence vào thế kỷ 14–15 có vị thế độc nhất:

- **Giàu có từ ngân hàng và thương mại**: Các ngân hàng Florence (đặc biệt là ngân hàng Medici) tài trợ cho các quốc vương châu Âu, tạo ra tài sản khổng lồ
- **Gia đình Medici**: Cosimo de'' Medici (1389–1464) và cháu trai Lorenzo "Vĩ đại" (1449–1492) chi tiêu hào phóng cho nghệ thuật, kiến trúc và học thuật
- **Văn hóa phường hội**: Các phường hội thủ công mạnh mẽ của Florence đặt hàng nghệ thuật công cộng, biến thành phố thành phòng trưng bày ngoài trời
- **Bản thảo cổ điển**: Học giả Ý có quyền truy cập lớn hơn vào các văn bản Hy Lạp và La Mã còn sót lại so với người Bắc Âu

Sự bảo trợ của Medici là trung tâm đến mức nếu không có họ, các nhân vật như Botticelli, Michelangelo và Leonardo có thể không bao giờ có nguồn lực để tạo ra những kiệt tác của họ. Florence chứng minh rằng sự thịnh vượng kinh tế và đầu tư văn hóa có thể kích hoạt một thời đại hoàng kim nghệ thuật.',
  3,
  '{"variant": "tip"}'
);

-- Exercises
-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'the-renaissance'),
  'fill_blank',
  'easy',
  'Fill in the country where the Renaissance began.',
  'Điền tên quốc gia nơi Thời Kỳ Phục Hưng bắt đầu.',
  'The Renaissance began in ___ in the 14th century.',
  'Thời Kỳ Phục Hưng bắt đầu ở ___ vào thế kỷ 14.',
  'Italy',
  'The Renaissance began in the Italian city-states, particularly Florence, in the 14th century. Italy''s position was unique: it had surviving Roman ruins and manuscripts, wealthy city-states with banking dynasties (like the Medici) willing to fund the arts, and close trading connections to the Byzantine Empire and its preserved Greek texts.',
  'Thời Kỳ Phục Hưng bắt đầu ở các thành bang Ý, đặc biệt là Florence, vào thế kỷ 14. Vị thế của Ý là độc nhất: nó có di tích và bản thảo La Mã còn sót lại, các thành bang giàu có với các triều đại ngân hàng (như Medici) sẵn sàng tài trợ cho nghệ thuật, và mối liên hệ thương mại chặt chẽ với Đế chế Byzantine và các văn bản Hy Lạp được bảo tồn của nó.',
  10,
  1
);

-- Exercise 2: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'the-renaissance'),
  'multiple_choice',
  'easy',
  'Who painted the Mona Lisa?',
  'Ai đã vẽ bức tranh Mona Lisa?',
  'The Mona Lisa is one of the most recognized paintings in the world, created during the Italian Renaissance.',
  'Mona Lisa là một trong những bức tranh được nhận biết nhất trên thế giới, được tạo ra trong Thời Kỳ Phục Hưng Ý.',
  'The Mona Lisa was painted by Leonardo da Vinci between approximately 1503 and 1519. It is housed in the Louvre Museum in Paris and is believed to depict Lisa Gherardini, the wife of a Florentine merchant. It is renowned for its subject''s enigmatic expression, innovative use of sfumato (soft shading technique), and Leonardo''s mastery of aerial perspective.',
  'Mona Lisa được vẽ bởi Leonardo da Vinci vào khoảng năm 1503-1519. Nó được lưu trữ tại Bảo tàng Louvre ở Paris và được cho là mô tả Lisa Gherardini, vợ của một thương nhân Florence. Nó nổi tiếng với nụ cười bí ẩn của nhân vật, cách sử dụng sfumato sáng tạo (kỹ thuật tô màu mềm) và sự thành thạo phối cảnh không khí của Leonardo.',
  10,
  2
);
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, explanation, order_index) VALUES
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'the-renaissance') AND order_index = 2),
  'A', 'Michelangelo', 'Michelangelo', FALSE,
  'Michelangelo painted the Sistine Chapel ceiling and sculpted David — not the Mona Lisa',
  1
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'the-renaissance') AND order_index = 2),
  'B', 'Raphael', 'Raphael', FALSE,
  'Raphael painted The School of Athens — a masterpiece, but not the Mona Lisa',
  2
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'the-renaissance') AND order_index = 2),
  'C', 'Leonardo da Vinci', 'Leonardo da Vinci', TRUE,
  'Correct! Leonardo da Vinci painted the Mona Lisa between approximately 1503 and 1519',
  3
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'the-renaissance') AND order_index = 2),
  'D', 'Botticelli', 'Botticelli', FALSE,
  'Botticelli painted The Birth of Venus and Primavera — not the Mona Lisa',
  4
);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'the-renaissance'),
  'true_false',
  'easy',
  'Is this statement about the Renaissance correct?',
  'Phát biểu này về Thời Kỳ Phục Hưng có đúng không?',
  'The Renaissance was a period of renewed interest in classical Greek and Roman culture.',
  'Thời Kỳ Phục Hưng là thời kỳ quan tâm được đổi mới đối với văn hóa Hy Lạp và La Mã cổ điển.',
  'true',
  'True! The word "Renaissance" literally means "rebirth" — referring to the rebirth of classical learning. Renaissance scholars and artists turned to ancient Greek and Roman texts, art, and architecture as models of perfection. They believed the Middle Ages had been a period of cultural decline, and that recovering classical knowledge would restore cultural greatness. This is why Renaissance art often depicts Greek and Roman mythological subjects alongside Christian themes.',
  'Đúng! Từ "Renaissance" theo nghĩa đen có nghĩa là "tái sinh" — đề cập đến sự tái sinh của học thuật cổ điển. Các học giả và nghệ sĩ Phục Hưng quay về các văn bản, nghệ thuật và kiến trúc Hy Lạp và La Mã cổ đại như là mô hình hoàn hảo. Họ tin rằng thời Trung Cổ là thời kỳ suy thoái văn hóa, và rằng khôi phục kiến thức cổ điển sẽ phục hồi sự vĩ đại văn hóa. Đây là lý do tại sao nghệ thuật Phục Hưng thường mô tả chủ đề thần thoại Hy Lạp và La Mã cùng với các chủ đề Kitô giáo.',
  5,
  3
);

-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'the-renaissance'),
  'fill_blank',
  'easy',
  'Fill in the name of the Renaissance philosophical movement.',
  'Điền tên phong trào triết học Phục Hưng.',
  '___ was the philosophical movement that placed humans at the center of intellectual life.',
  '___ là phong trào triết học đặt con người vào trung tâm của đời sống trí tuệ.',
  'Humanism',
  'Humanism (or Renaissance Humanism) was the intellectual movement at the heart of the Renaissance. Humanists believed that the study of classical texts — grammar, rhetoric, poetry, history, and moral philosophy — was the key to producing well-rounded, virtuous citizens. Rather than focusing exclusively on theology (as medieval scholars had), humanists celebrated human potential, achievement, and dignity.',
  'Chủ nghĩa nhân văn (hay Chủ nghĩa nhân văn Phục Hưng) là phong trào trí tuệ cốt lõi của Thời Kỳ Phục Hưng. Các nhà nhân văn tin rằng việc nghiên cứu các văn bản cổ điển — ngữ pháp, tu từ, thơ, lịch sử và triết học đạo đức — là chìa khóa để tạo ra những công dân toàn diện, đức hạnh. Thay vì tập trung độc quyền vào thần học (như các học giả thời Trung Cổ), các nhà nhân văn tôn vinh tiềm năng, thành tựu và phẩm giá của con người.',
  10,
  4
);

-- Exercise 5: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'the-renaissance'),
  'true_false',
  'easy',
  'Is this statement about the printing press correct?',
  'Phát biểu này về máy in có đúng không?',
  'Johannes Gutenberg''s printing press had no significant impact on the spread of Renaissance ideas.',
  'Máy in của Johannes Gutenberg không có tác động đáng kể đến sự lan truyền các ý tưởng Thời Kỳ Phục Hưng.',
  'false',
  'False! Gutenberg''s printing press (c. 1440) had a transformative impact on the spread of Renaissance ideas. Before printing, a single handwritten book could take months to copy and cost as much as a house. After Gutenberg, books became affordable to the middle class. Humanist texts, scientific works, and eventually Martin Luther''s 95 Theses spread across Europe within weeks rather than decades, directly enabling both the Renaissance and the Protestant Reformation.',
  'Sai! Máy in của Gutenberg (khoảng 1440) có tác động biến đổi đến sự lan truyền các ý tưởng Phục Hưng. Trước khi in ấn, một cuốn sách viết tay có thể mất nhiều tháng để sao chép và có giá trị như một ngôi nhà. Sau Gutenberg, sách trở nên vừa túi tiền của tầng lớp trung lưu. Các văn bản nhân văn, công trình khoa học và cuối cùng là 95 Luận đề của Martin Luther lan khắp châu Âu trong vòng vài tuần thay vì vài thập kỷ, trực tiếp cho phép cả Thời Kỳ Phục Hưng lẫn Cuộc Cải Cách Tin Lành.',
  5,
  5
);


-- ############################################################################
-- LESSON: WORLD WAR I: CAUSES AND CONSEQUENCES
-- slug = world-war-one, order_index = 4
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'World War I: Causes and Consequences',
  'Thế Chiến I: Nguyên Nhân và Hệ Quả',
  'world-war-one',
  'Understand the MAIN causes, key battles, and lasting impact of the Great War',
  'Hiểu nguyên nhân MAIN, các trận đánh then chốt và tác động lâu dài của Thế Chiến I',
  'intermediate',
  40,
  4
FROM category WHERE name = 'World History';

-- Usages
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'world-war-one'),
  'MAIN Causes: Militarism, Alliances, Imperialism, Nationalism',
  'Nguyên Nhân MAIN: Chủ Nghĩa Quân Phiệt, Liên Minh, Chủ Nghĩa Đế Quốc, Chủ Nghĩa Dân Tộc',
  'The acronym MAIN summarizes the four long-term causes that created the conditions for World War I. Militarism drove an arms race between European powers. The Alliance System meant a local conflict could drag in all of Europe. Imperialism created competition for colonies. Nationalism inflamed ethnic tensions, especially in the multi-ethnic Austro-Hungarian and Ottoman Empires.',
  'Từ viết tắt MAIN tóm tắt bốn nguyên nhân dài hạn tạo ra điều kiện cho Thế Chiến I. Chủ nghĩa quân phiệt thúc đẩy cuộc chạy đua vũ trang giữa các cường quốc châu Âu. Hệ thống liên minh có nghĩa là một xung đột địa phương có thể kéo vào toàn bộ châu Âu. Chủ nghĩa đế quốc tạo ra sự cạnh tranh cho các thuộc địa. Chủ nghĩa dân tộc đốt nóng căng thẳng sắc tộc, đặc biệt ở Đế chế Áo-Hung và Ottoman đa sắc tộc.',
  'Groups',
  TRUE,
  1
),
(
  (SELECT id FROM lesson WHERE slug = 'world-war-one'),
  'Treaty of Versailles',
  'Hiệp Ước Versailles',
  'The Treaty of Versailles (1919) ended World War I but planted the seeds of World War II. Germany was forced to accept sole responsibility for the war (the "war guilt" clause), pay massive reparations, surrender territory, and drastically reduce its military. The treaty''s harsh terms created deep resentment in Germany — conditions that would later be exploited by Adolf Hitler.',
  'Hiệp Ước Versailles (1919) kết thúc Thế Chiến I nhưng gieo mầm cho Thế Chiến II. Đức bị buộc phải chấp nhận trách nhiệm độc quyền cho cuộc chiến (điều khoản "tội lỗi chiến tranh"), trả bồi thường khổng lồ, nhượng lãnh thổ và cắt giảm đáng kể quân sự. Các điều khoản khắc nghiệt của hiệp ước tạo ra sự phẫn nộ sâu sắc ở Đức — điều kiện mà sau này sẽ bị Adolf Hitler khai thác.',
  'Gavel',
  TRUE,
  2
);

-- Sections
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'world-war-one'),
  'markdown',
  'World War I: The War That Changed Everything',
  'Thế Chiến I: Cuộc Chiến Thay Đổi Mọi Thứ',
  '## World War I (1914–1918)

World War I — called "The Great War" at the time — was the first truly global conflict. It killed approximately **20 million people** (soldiers and civilians) and reshaped the political map of the world.

### The Spark: Assassination in Sarajevo

On June 28, 1914, **Archduke Franz Ferdinand** of Austria-Hungary was assassinated in **Sarajevo** by Gavrilo Princip, a Bosnian-Serb nationalist. This single event triggered a chain reaction:

1. Austria-Hungary blamed Serbia and issued an ultimatum
2. Serbia rejected key terms → Austria-Hungary declared war
3. The Alliance System pulled in Russia, Germany, France, and Britain within weeks

### The Two Sides

| **Triple Entente (Allies)** | **Triple Alliance (Central Powers)** |
|---|---|
| France | Germany |
| Russia | Austria-Hungary |
| Britain | Ottoman Empire |
| (Later: USA, Italy) | Bulgaria |

### Key Events

| Year | Event |
|------|-------|
| 1914 | Assassination of Franz Ferdinand; war begins |
| 1915 | Gallipoli Campaign; Italy joins Allies |
| 1916 | Battle of the Somme (1 million casualties); Battle of Verdun |
| 1917 | USA enters the war; Russian Revolution; unrestricted submarine warfare |
| 1918 | Armistice on November 11 ("the eleventh hour") |
| 1919 | Treaty of Versailles signed |

### Trench Warfare

The Western Front became defined by trench warfare — a brutal stalemate where millions died for yards of territory. Trenches stretched 700 km from Belgium to Switzerland, creating conditions of mud, disease, and constant artillery bombardment that traumatized a generation.',
  '## Thế Chiến I (1914–1918)

Thế Chiến I — được gọi là "Cuộc Chiến Vĩ Đại" vào thời điểm đó — là xung đột toàn cầu thực sự đầu tiên. Nó giết khoảng **20 triệu người** (binh sĩ và dân thường) và tái định hình bản đồ chính trị của thế giới.

### Tia Lửa: Vụ Ám Sát ở Sarajevo

Ngày 28 tháng 6 năm 1914, **Thái tử Franz Ferdinand** của Áo-Hung bị ám sát ở **Sarajevo** bởi Gavrilo Princip, một người theo chủ nghĩa dân tộc Bosnian-Serb. Sự kiện đơn lẻ này đã kích hoạt phản ứng dây chuyền:

1. Áo-Hung đổ lỗi cho Serbia và đưa ra tối hậu thư
2. Serbia từ chối các điều khoản chính → Áo-Hung tuyên chiến
3. Hệ thống liên minh kéo vào Nga, Đức, Pháp và Anh trong vòng vài tuần

### Hai Bên Chiến Tuyến

| **Hiệp Ước Ba Bên (Đồng Minh)** | **Liên Minh Ba Bên (Trung Tâm)** |
|---|---|
| Pháp | Đức |
| Nga | Áo-Hung |
| Anh | Đế chế Ottoman |
| (Sau: Mỹ, Ý) | Bulgaria |

### Các Sự Kiện Chính

| Năm | Sự kiện |
|-----|---------|
| 1914 | Ám sát Franz Ferdinand; chiến tranh bắt đầu |
| 1915 | Chiến dịch Gallipoli; Ý gia nhập Đồng Minh |
| 1916 | Trận Somme (1 triệu thương vong); Trận Verdun |
| 1917 | Mỹ tham chiến; Cách Mạng Nga; chiến tranh tàu ngầm không hạn chế |
| 1918 | Đình chiến ngày 11 tháng 11 ("giờ thứ mười một") |
| 1919 | Hiệp Ước Versailles được ký |

### Chiến Tranh Hào

Mặt trận Phía Tây được định nghĩa bởi chiến tranh hào — bế tắc tàn bạo nơi hàng triệu người chết vì vài mét đất. Các chiến hào kéo dài 700 km từ Bỉ đến Thụy Sĩ, tạo ra điều kiện bùn lầy, bệnh tật và pháo kích liên tục gây sang chấn tâm lý cho một thế hệ.',
  1,
  '{}'
),
(
  (SELECT id FROM lesson WHERE slug = 'world-war-one'),
  'key_points',
  'Key Points',
  'Điểm Chính',
  '- **MAIN** = Militarism, Alliances, Imperialism, Nationalism — the four long-term causes of WWI
- The **assassination of Archduke Franz Ferdinand** in **Sarajevo** (June 28, 1914) was the immediate trigger
- The **Alliance System** turned a regional dispute into a world war within weeks
- **Trench warfare** on the Western Front created a brutal stalemate — millions died for yards of ground
- The **Battle of the Somme** (1916) was one of the bloodiest battles in history — 57,000 British casualties on day one
- **The USA entered in 1917** after Germany''s unrestricted submarine warfare sank American ships
- The **Treaty of Versailles (1919)** ended WWI, imposed massive reparations on Germany, and created the conditions for WWII
- WWI ended four empires: the German, Austro-Hungarian, Russian, and Ottoman empires',
  '- **MAIN** = Chủ nghĩa quân phiệt, Liên minh, Chủ nghĩa đế quốc, Chủ nghĩa dân tộc — bốn nguyên nhân dài hạn của Thế Chiến I
- **Vụ ám sát Thái tử Franz Ferdinand** ở **Sarajevo** (28 tháng 6 năm 1914) là yếu tố kích hoạt trực tiếp
- **Hệ thống liên minh** biến tranh chấp khu vực thành chiến tranh thế giới trong vòng vài tuần
- **Chiến tranh hào** ở Mặt trận Phía Tây tạo ra bế tắc tàn bạo — hàng triệu người chết vì vài mét đất
- **Trận Somme** (1916) là một trong những trận đẫm máu nhất trong lịch sử — 57.000 thương vong Anh chỉ trong ngày đầu tiên
- **Mỹ tham chiến năm 1917** sau khi chiến tranh tàu ngầm không hạn chế của Đức đánh chìm tàu Mỹ
- **Hiệp Ước Versailles (1919)** kết thúc Thế Chiến I, áp đặt bồi thường khổng lồ lên Đức và tạo ra điều kiện cho Thế Chiến II
- Thế Chiến I kết thúc bốn đế chế: Đức, Áo-Hung, Nga và Ottoman',
  2,
  '{}'
),
(
  (SELECT id FROM lesson WHERE slug = 'world-war-one'),
  'diagram',
  'Causes and Consequences of WWI',
  'Nguyên Nhân và Hệ Quả Thế Chiến I',
  'This diagram illustrates how the four MAIN causes converged with the assassination of Archduke Franz Ferdinand to trigger WWI, and how the Treaty of Versailles sowed the seeds of World War II.',
  'Sơ đồ này minh họa cách bốn nguyên nhân MAIN hội tụ với vụ ám sát Thái tử Franz Ferdinand để kích hoạt Thế Chiến I, và cách Hiệp Ước Versailles gieo mầm cho Thế Chiến II.',
  3,
  '{"code": "graph TD\n    A[Nationalism] --> E[WW1 1914-1918]\n    B[Militarism] --> E\n    C[Alliance System] --> E\n    D[Imperialism] --> E\n    F[Assassination of Archduke Franz Ferdinand] --> E\n    E --> G[Treaty of Versailles 1919]\n    G --> H[Seeds of WW2]"}'
);

-- Exercises
-- Exercise 1: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'world-war-one'),
  'multiple_choice',
  'easy',
  'What does MAIN stand for in the causes of WWI?',
  'MAIN viết tắt của gì trong nguyên nhân Thế Chiến I?',
  'Historians use the acronym MAIN to summarize the four long-term causes that made Europe a powder keg before 1914.',
  'Các nhà sử học dùng từ viết tắt MAIN để tóm tắt bốn nguyên nhân dài hạn khiến châu Âu như thùng thuốc súng trước năm 1914.',
  'MAIN stands for Militarism, Alliances, Imperialism, and Nationalism. These four forces created the conditions for WWI: military build-up (especially Germany vs. Britain in a naval arms race), a web of alliances that meant any conflict would become regional, competition for colonies, and rising ethnic nationalism (particularly dangerous in multi-ethnic empires like Austria-Hungary).',
  'MAIN viết tắt của Militarism (chủ nghĩa quân phiệt), Alliances (liên minh), Imperialism (chủ nghĩa đế quốc) và Nationalism (chủ nghĩa dân tộc). Bốn lực lượng này tạo ra điều kiện cho Thế Chiến I: xây dựng quân sự (đặc biệt là Đức vs. Anh trong cuộc chạy đua vũ trang hải quân), mạng lưới liên minh khiến bất kỳ xung đột nào cũng trở thành khu vực, cạnh tranh cho thuộc địa và chủ nghĩa dân tộc sắc tộc đang nổi lên (đặc biệt nguy hiểm trong các đế chế đa sắc tộc như Áo-Hung).',
  10,
  1
);
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, explanation, order_index) VALUES
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'world-war-one') AND order_index = 1),
  'A', 'Military, Alliance, Industry, Nations', 'Quân sự, Liên minh, Công nghiệp, Quốc gia', FALSE,
  'Industry is not part of the MAIN acronym — the correct term is Imperialism',
  1
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'world-war-one') AND order_index = 1),
  'B', 'Militarism, Alliances, Imperialism, Nationalism', 'Chủ nghĩa quân phiệt, Liên minh, Chủ nghĩa đế quốc, Chủ nghĩa dân tộc', TRUE,
  'Correct! MAIN = Militarism, Alliances, Imperialism, Nationalism — the four long-term causes of WWI',
  2
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'world-war-one') AND order_index = 1),
  'C', 'Maps, Artillery, Infantry, Navy', 'Bản đồ, Pháo binh, Bộ binh, Hải quân', FALSE,
  'These are military components, not the historical causes acronym',
  3
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'world-war-one') AND order_index = 1),
  'D', 'Money, Arms, Influence, Nationalism', 'Tiền, Vũ khí, Ảnh hưởng, Chủ nghĩa dân tộc', FALSE,
  'Money and Arms are not the standard terms — the correct acronym uses Militarism, Alliances, Imperialism',
  4
);

-- Exercise 2: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'world-war-one'),
  'fill_blank',
  'easy',
  'Fill in the city where the assassination that triggered WWI took place.',
  'Điền tên thành phố nơi vụ ám sát kích hoạt Thế Chiến I diễn ra.',
  'The assassination of Archduke Franz Ferdinand in ___ triggered the chain of events leading to WWI.',
  'Vụ ám sát Thái tử Franz Ferdinand ở ___ đã kích hoạt chuỗi sự kiện dẫn đến Thế Chiến I.',
  'Sarajevo',
  'On June 28, 1914, Archduke Franz Ferdinand and his wife Sophie were assassinated in Sarajevo (the capital of Bosnia-Herzegovina, which Austria-Hungary had annexed in 1908) by Gavrilo Princip. Princip was a member of the "Black Hand," a Serbian nationalist secret society. Austria-Hungary blamed the Serbian government, setting off the alliance system that drew all the major European powers into war within six weeks.',
  'Ngày 28 tháng 6 năm 1914, Thái tử Franz Ferdinand và vợ Sophie bị ám sát ở Sarajevo (thủ đô của Bosnia-Herzegovina, được Áo-Hung sáp nhập năm 1908) bởi Gavrilo Princip. Princip là thành viên của "Bàn tay Đen," một tổ chức bí mật theo chủ nghĩa dân tộc Serbia. Áo-Hung đổ lỗi cho chính phủ Serbia, kích hoạt hệ thống liên minh kéo tất cả các cường quốc châu Âu vào chiến tranh trong sáu tuần.',
  10,
  2
);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'world-war-one'),
  'true_false',
  'easy',
  'Is this statement about the Treaty of Versailles correct?',
  'Phát biểu này về Hiệp Ước Versailles có đúng không?',
  'The Treaty of Versailles ended WWI and placed full blame on Germany.',
  'Hiệp Ước Versailles kết thúc Thế Chiến I và đổ toàn bộ trách nhiệm lên Đức.',
  'true',
  'True! The Treaty of Versailles (1919) ended WWI and included the infamous "war guilt clause" (Article 231), which forced Germany to accept sole responsibility for starting the war. This clause justified the massive reparations imposed on Germany (132 billion gold marks). Historians debate whether Germany was truly solely responsible, but the clause deeply humiliated the German people and created conditions that contributed to the rise of Nazism.',
  'Đúng! Hiệp Ước Versailles (1919) kết thúc Thế Chiến I và bao gồm điều khoản "tội lỗi chiến tranh" khét tiếng (Điều 231), buộc Đức chấp nhận trách nhiệm độc quyền về việc bắt đầu chiến tranh. Điều khoản này biện minh cho bồi thường khổng lồ áp đặt lên Đức (132 tỷ mark vàng). Các nhà sử học tranh luận liệu Đức có thực sự chịu trách nhiệm độc quyền hay không, nhưng điều khoản đã sỉ nhục sâu sắc người Đức và tạo ra điều kiện góp phần vào sự trỗi dậy của chủ nghĩa phát xít.',
  5,
  3
);

-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'world-war-one'),
  'fill_blank',
  'easy',
  'Fill in the name of the system that meant an attack on one nation could drag all allies into war.',
  'Điền tên hệ thống có nghĩa là cuộc tấn công vào một quốc gia có thể kéo tất cả đồng minh vào chiến tranh.',
  'The ___ system meant that an attack on one nation could drag all allies into war.',
  'Hệ thống ___ có nghĩa là cuộc tấn công vào một quốc gia có thể kéo tất cả đồng minh vào chiến tranh.',
  'alliance',
  'The Alliance System was the network of mutual defense treaties between European powers before WWI. The Triple Entente (France, Russia, Britain) and the Triple Alliance (Germany, Austria-Hungary, Italy) meant that when Austria-Hungary declared war on Serbia, Russia mobilized to defend Serbia, Germany supported Austria-Hungary, France supported Russia, and Britain entered when Germany invaded Belgium. A local dispute escalated to world war in weeks.',
  'Hệ thống liên minh là mạng lưới các hiệp ước phòng thủ chung giữa các cường quốc châu Âu trước Thế Chiến I. Hiệp Ước Ba Bên (Pháp, Nga, Anh) và Liên Minh Ba Bên (Đức, Áo-Hung, Ý) có nghĩa là khi Áo-Hung tuyên chiến với Serbia, Nga huy động lực lượng để bảo vệ Serbia, Đức ủng hộ Áo-Hung, Pháp ủng hộ Nga, và Anh tham gia khi Đức xâm lược Bỉ. Tranh chấp địa phương leo thang thành chiến tranh thế giới trong vài tuần.',
  10,
  4
);

-- Exercise 5: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'world-war-one'),
  'true_false',
  'easy',
  'Is this statement about WWI and WWII correct?',
  'Phát biểu này về Thế Chiến I và II có đúng không?',
  'The harsh terms of the Treaty of Versailles contributed to conditions that led to World War II.',
  'Các điều khoản khắc nghiệt của Hiệp Ước Versailles đã góp phần vào điều kiện dẫn đến Thế Chiến II.',
  'true',
  'True! Historians widely agree that the Treaty of Versailles created the conditions for WWII. The "war guilt" clause and massive reparations humiliated Germany and caused economic hardship. The Great Depression (1929) worsened Germany''s economic crisis. Adolf Hitler exploited this resentment, promising to restore German greatness and overturn Versailles. British economist John Maynard Keynes warned in 1919 that the treaty''s terms were dangerously punitive — his prediction proved accurate.',
  'Đúng! Các nhà sử học đồng ý rộng rãi rằng Hiệp Ước Versailles tạo ra điều kiện cho Thế Chiến II. Điều khoản "tội lỗi chiến tranh" và bồi thường khổng lồ đã sỉ nhục Đức và gây khó khăn kinh tế. Đại Khủng Hoảng (1929) làm trầm trọng thêm cuộc khủng hoảng kinh tế của Đức. Adolf Hitler khai thác sự phẫn nộ này, hứa khôi phục sự vĩ đại của Đức và lật ngược Versailles. Nhà kinh tế học người Anh John Maynard Keynes đã cảnh báo năm 1919 rằng các điều khoản của hiệp ước có tính trừng phạt nguy hiểm — dự đoán của ông đã được chứng minh là chính xác.',
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
WHERE l.group_id = (SELECT id FROM category WHERE name = 'World History')
ORDER BY l.order_index;
