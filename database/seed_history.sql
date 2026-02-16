-- ============================================================================
-- SEED DATA: World History (1 lesson)
-- Category: World History (ID 10)
-- Lessons: ID 33
-- Compatible with: schema.sql v7
-- Applied AFTER: seed_data, seed_python, seed_math, seed_cybersecurity,
--                seed_psychology, and the design seed (categories 1-9)
-- ============================================================================


-- ============================================================================
-- CATEGORY 10: World History
-- ============================================================================

INSERT INTO category (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('World History', 'Lịch Sử Thế Giới', 'Journey through pivotal moments in human history: revolutions, empires, inventions, and the forces that shaped our world', 'Hành trình qua những thời khắc then chốt trong lịch sử nhân loại: cách mạng, đế chế, phát minh và các lực lượng định hình thế giới', 'HistoryEdu', '#d97706', 10);


-- ############################################################################
-- LESSON 33: THE INDUSTRIAL REVOLUTION (lesson_id = 33)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(10, 'The Industrial Revolution', 'Cách Mạng Công Nghiệp', 'history-industrial-revolution', 'Explore the transformation that changed human civilization: origins, key inventions, and social impact (1760-1840)', 'Khám phá cuộc biến đổi đã thay đổi nền văn minh nhân loại: nguồn gốc, phát minh quan trọng và tác động xã hội (1760-1840)', 'intermediate', 35, 1);

-- Usages (IDs 99-101)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(33, 'Origins and causes', 'Nguồn gốc và nguyên nhân', 'The Industrial Revolution did not happen overnight. It was driven by the Agricultural Revolution, population growth, abundant natural resources in Britain, and a culture of scientific inquiry that created the perfect conditions for transformation.', 'Cách Mạng Công Nghiệp không xảy ra trong một sớm một chiều. Nó được thúc đẩy bởi Cách Mạng Nông Nghiệp, tăng trưởng dân số, nguồn tài nguyên thiên nhiên dồi dào ở Anh và văn hóa tìm tòi khoa học tạo điều kiện hoàn hảo cho sự biến đổi.', 'Landscape', TRUE, 1),
(33, 'Key inventions and innovations', 'Các phát minh và đổi mới quan trọng', 'Revolutionary machines like the spinning jenny (1764), the water frame (1769), and James Watt''s improved steam engine (1776) transformed production from hand labor to mechanized industry at an unprecedented scale.', 'Các máy móc cách mạng như máy kéo sợi jenny (1764), khung nước (1769) và động cơ hơi nước cải tiến của James Watt (1776) đã biến đổi sản xuất từ lao động tay chân sang công nghiệp cơ giới hóa ở quy mô chưa từng có.', 'Precision Manufacturing', TRUE, 2),
(33, 'Social impact and urbanization', 'Tác động xã hội và đô thị hóa', 'The factory system drew millions from rural villages into rapidly growing cities. While it created new wealth and a middle class, it also brought harsh working conditions, child labor, and a dramatic reshaping of family life and social structures.', 'Hệ thống nhà máy kéo hàng triệu người từ làng quê vào các thành phố phát triển nhanh chóng. Dù tạo ra tài sản mới và tầng lớp trung lưu, nó cũng mang lại điều kiện làm việc khắc nghiệt, lao động trẻ em và sự tái định hình mạnh mẽ đời sống gia đình và cấu trúc xã hội.', 'Groups', TRUE, 3);

-- Examples for usage 99 (IDs 193-194)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(99, 'The Agricultural Revolution of the 18th century introduced crop rotation and selective breeding, dramatically increasing food production and freeing workers for factory labor.', 'Cách Mạng Nông Nghiệp thế kỷ 18 đã đưa vào luân canh và chọn giống, tăng đáng kể sản xuất lương thực và giải phóng lao động cho nhà máy.', 'Jethro Tull''s seed drill (1701) and Charles "Turnip" Townshend''s four-field crop rotation system were key innovations that boosted agricultural productivity by up to 300%.', 'Máy gieo hạt của Jethro Tull (1701) và hệ thống luân canh bốn cánh đồng của Charles "Turnip" Townshend là những đổi mới quan trọng giúp tăng năng suất nông nghiệp lên tới 300%.', 'Agricultural Revolution', 1),
(99, 'Britain''s population nearly doubled from 6.5 million in 1750 to 10.8 million by 1801, creating both a larger workforce and greater demand for manufactured goods.', 'Dân số Anh gần gấp đôi từ 6,5 triệu năm 1750 lên 10,8 triệu năm 1801, tạo ra cả lực lượng lao động lớn hơn và nhu cầu hàng hóa sản xuất cao hơn.', 'Better nutrition from the Agricultural Revolution reduced death rates, while birth rates remained high — this population boom provided the labor force that powered industrialization.', 'Dinh dưỡng tốt hơn từ Cách Mạng Nông Nghiệp giảm tỷ lệ tử vong, trong khi tỷ lệ sinh vẫn cao — bùng nổ dân số này cung cấp lực lượng lao động thúc đẩy công nghiệp hóa.', 'population', 2);

-- Examples for usage 100 (IDs 195-196)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(100, 'James Watt''s improved steam engine (1776) was not an invention from scratch — he refined Thomas Newcomen''s 1712 design by adding a separate condenser, making it 75% more fuel efficient.', 'Động cơ hơi nước cải tiến của James Watt (1776) không phải phát minh từ đầu — ông tinh chỉnh thiết kế năm 1712 của Thomas Newcomen bằng cách thêm bình ngưng riêng, giúp tiết kiệm 75% nhiên liệu.', 'Watt''s partnership with manufacturer Matthew Boulton turned a laboratory improvement into a commercial product that powered factories, mines, and eventually railways across Britain.', 'Sự hợp tác của Watt với nhà sản xuất Matthew Boulton biến cải tiến phòng thí nghiệm thành sản phẩm thương mại cung cấp năng lượng cho nhà máy, hầm mỏ và cuối cùng là đường sắt khắp nước Anh.', 'steam engine', 1),
(100, 'Richard Arkwright''s water frame (1769) could spin 96 spindles simultaneously, producing cotton thread far stronger and faster than any human hand spinner.', 'Khung nước của Richard Arkwright (1769) có thể kéo 96 cọc sợi đồng thời, sản xuất sợi bông mạnh hơn và nhanh hơn nhiều so với bất kỳ người kéo sợi tay nào.', 'Arkwright is often called the "father of the factory system" — his machines were too large for homes, so he built the first water-powered cotton mill at Cromford in 1771, employing hundreds of workers under one roof.', 'Arkwright thường được gọi là "cha đẻ của hệ thống nhà máy" — máy của ông quá lớn cho nhà ở, nên ông xây nhà máy dệt bông chạy bằng nước đầu tiên tại Cromford năm 1771, thuê hàng trăm công nhân dưới một mái nhà.', 'water frame', 2);

-- Examples for usage 101 (IDs 197-198)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(101, 'Manchester''s population exploded from 25,000 in 1772 to over 300,000 by 1850, transforming a quiet market town into the world''s first industrial city.', 'Dân số Manchester bùng nổ từ 25.000 năm 1772 lên hơn 300.000 năm 1850, biến một thị trấn chợ yên tĩnh thành thành phố công nghiệp đầu tiên trên thế giới.', 'Friedrich Engels documented the appalling conditions in Manchester in "The Condition of the Working Class in England" (1845), describing overcrowded slums, polluted rivers, and a life expectancy of just 17 years for laborers.', 'Friedrich Engels ghi lại điều kiện kinh hoàng ở Manchester trong "Tình cảnh Giai cấp Công nhân Anh" (1845), mô tả khu ổ chuột chật chội, sông ô nhiễm và tuổi thọ trung bình chỉ 17 năm cho công nhân.', 'urbanization', 1),
(101, 'Children as young as five worked 12-16 hour days in textile mills and coal mines, until the Factory Act of 1833 began to regulate child labor in Britain.', 'Trẻ em nhỏ nhất 5 tuổi làm việc 12-16 giờ mỗi ngày trong nhà máy dệt và hầm mỏ, cho đến khi Đạo luật Nhà máy 1833 bắt đầu quản lý lao động trẻ em ở Anh.', 'The 1833 Factory Act prohibited children under 9 from working in textile factories and limited children aged 9-13 to 8 hours per day. It was the first effective labor law, though enforcement was initially weak.', 'Đạo luật Nhà máy 1833 cấm trẻ em dưới 9 tuổi làm việc trong nhà máy dệt và giới hạn trẻ 9-13 tuổi làm 8 giờ mỗi ngày. Đây là luật lao động hiệu quả đầu tiên, dù ban đầu việc thực thi còn yếu.', 'child labor', 2);

-- Tips (IDs 98-100)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(33, 'Look for multiple causes, not a single trigger', 'Tìm nhiều nguyên nhân, không phải một yếu tố duy nhất', 'Students often oversimplify history by pointing to one cause — "the steam engine caused the Industrial Revolution." In reality, it required a convergence of factors: agricultural surplus, population growth, capital accumulation, natural resources (coal and iron), navigable waterways, a stable government, and a patent system that rewarded innovation. Thinking in terms of necessary vs sufficient conditions makes your historical analysis much stronger.', 'Học sinh thường đơn giản hóa lịch sử bằng cách chỉ ra một nguyên nhân — "động cơ hơi nước gây ra Cách Mạng Công Nghiệp." Thực tế, nó đòi hỏi sự hội tụ của nhiều yếu tố: thặng dư nông nghiệp, tăng trưởng dân số, tích lũy vốn, tài nguyên thiên nhiên (than và sắt), đường thủy có thể đi lại, chính phủ ổn định và hệ thống bằng sáng chế thưởng cho đổi mới. Suy nghĩ theo điều kiện cần và đủ giúp phân tích lịch sử mạnh mẽ hơn nhiều.', 'general', 'high', 'Lightbulb', 1),
(33, 'Consider different perspectives', 'Xem xét các góc nhìn khác nhau', 'The Industrial Revolution looks very different depending on whose story you tell. Factory owners saw progress and profit. Workers experienced dangerous conditions and lost traditional skills. Women gained wage-earning opportunities but faced exploitation. Children were robbed of childhood. Always ask: "Who benefits? Who suffers? Whose voice is missing from this account?" Good historians examine events from multiple social positions.', 'Cách Mạng Công Nghiệp trông rất khác tùy thuộc vào câu chuyện của ai bạn kể. Chủ nhà máy thấy tiến bộ và lợi nhuận. Công nhân trải qua điều kiện nguy hiểm và mất kỹ năng truyền thống. Phụ nữ có cơ hội kiếm lương nhưng bị bóc lột. Trẻ em bị cướp mất tuổi thơ. Luôn hỏi: "Ai hưởng lợi? Ai chịu thiệt? Tiếng nói của ai thiếu trong tường thuật này?" Nhà sử học giỏi xem xét sự kiện từ nhiều vị trí xã hội.', 'common_mistake', 'high', 'Warning', 2),
(33, 'Connect historical events to modern parallels', 'Kết nối sự kiện lịch sử với những tương đồng hiện đại', 'The Industrial Revolution shares striking parallels with today''s digital revolution: displacement of traditional jobs by new technology, rapid urbanization, growing inequality, debates over regulation, and anxiety about the pace of change. Identifying these patterns helps you understand both eras better. For example, the Luddites who smashed machines in the 1810s echo modern concerns about AI replacing human workers.', 'Cách Mạng Công Nghiệp có những tương đồng nổi bật với cuộc cách mạng số ngày nay: thay thế công việc truyền thống bằng công nghệ mới, đô thị hóa nhanh, bất bình đẳng gia tăng, tranh luận về quy định và lo lắng về tốc độ thay đổi. Nhận ra các mô hình này giúp bạn hiểu cả hai thời đại tốt hơn. Ví dụ, những người Luddite đập phá máy móc những năm 1810 phản ánh mối lo hiện đại về AI thay thế lao động con người.', 'shortcut', 'medium', 'Info', 3);

-- Sections (IDs 61-63)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(33, 'markdown', 'A Timeline of Transformation', 'Dòng Thời Gian Biến Đổi',
'## The Industrial Revolution (1760-1840)

The Industrial Revolution was the most profound transformation of human life since the invention of agriculture. In barely three generations, Britain went from a nation of farmers and craftsmen to the **world''s first industrial superpower**.

### Timeline of Key Events

| Year | Event | Significance |
|------|-------|-------------|
| 1701 | Jethro Tull invents the seed drill | Mechanized planting boosts agricultural output |
| 1712 | Thomas Newcomen builds first steam engine | Used to pump water from coal mines |
| 1733 | John Kay invents the flying shuttle | Doubles the speed of weaving |
| 1764 | James Hargreaves invents the spinning jenny | One worker can spin 8 threads at once |
| 1769 | Richard Arkwright patents the water frame | Too large for homes — creates the factory system |
| 1776 | James Watt perfects the steam engine | Powers factories independently of rivers |
| 1779 | Samuel Crompton invents the spinning mule | Combines jenny and water frame — fine, strong thread |
| 1785 | Edmund Cartwright invents the power loom | Mechanizes weaving to match spinning speed |
| 1804 | Richard Trevithick builds first steam locomotive | Begins the railway age |
| 1833 | Factory Act passed | First effective child labor regulation |

### Why Britain First?

Britain had a unique combination of advantages:

- **Coal and iron** deposits close to navigable waterways
- **Agricultural surplus** that freed workers from farming
- A **stable government** and strong property rights
- A **patent system** that rewarded inventors financially
- An **empire** that provided raw materials and markets
- A **culture of tinkering** — practical experimentation valued over pure theory

> *"What all the violence of the feudal institutions could never have effected, the silent and insensible operation of foreign commerce and manufactures gradually brought about."*
> — **Adam Smith**, *The Wealth of Nations* (1776)',
'## Cách Mạng Công Nghiệp (1760-1840)

Cách Mạng Công Nghiệp là cuộc biến đổi sâu sắc nhất của đời sống con người kể từ phát minh nông nghiệp. Chỉ trong ba thế hệ, nước Anh từ quốc gia nông dân và thợ thủ công trở thành **siêu cường công nghiệp đầu tiên thế giới**.

### Dòng Thời Gian Các Sự Kiện Chính

| Năm | Sự kiện | Ý nghĩa |
|-----|---------|---------|
| 1701 | Jethro Tull phát minh máy gieo hạt | Cơ giới hóa gieo trồng tăng sản lượng nông nghiệp |
| 1712 | Thomas Newcomen chế tạo động cơ hơi nước đầu tiên | Dùng bơm nước khỏi hầm mỏ than |
| 1733 | John Kay phát minh thoi bay | Tăng gấp đôi tốc độ dệt |
| 1764 | James Hargreaves phát minh máy kéo sợi jenny | Một công nhân kéo 8 sợi cùng lúc |
| 1769 | Richard Arkwright cấp bằng sáng chế khung nước | Quá lớn cho nhà ở — tạo ra hệ thống nhà máy |
| 1776 | James Watt hoàn thiện động cơ hơi nước | Cung cấp năng lượng nhà máy không phụ thuộc sông |
| 1779 | Samuel Crompton phát minh máy kéo sợi mule | Kết hợp jenny và khung nước — sợi mịn, chắc |
| 1785 | Edmund Cartwright phát minh khung dệt cơ khí | Cơ giới hóa dệt để theo kịp tốc độ kéo sợi |
| 1804 | Richard Trevithick chế tạo đầu máy hơi nước đầu tiên | Bắt đầu kỷ nguyên đường sắt |
| 1833 | Đạo luật Nhà máy được thông qua | Quy định lao động trẻ em hiệu quả đầu tiên |

### Tại Sao Nước Anh Đầu Tiên?

Nước Anh có sự kết hợp lợi thế độc đáo:

- Mỏ **than và sắt** gần đường thủy có thể đi lại
- **Thặng dư nông nghiệp** giải phóng lao động khỏi nông nghiệp
- **Chính phủ ổn định** và quyền sở hữu tài sản mạnh
- **Hệ thống bằng sáng chế** thưởng tài chính cho nhà phát minh
- Một **đế chế** cung cấp nguyên liệu thô và thị trường
- **Văn hóa mày mò** — thực nghiệm thực tế được đánh giá cao hơn lý thuyết thuần túy

> *"Điều mà tất cả bạo lực của các thể chế phong kiến không bao giờ có thể đạt được, hoạt động thầm lặng và vô hình của thương mại và sản xuất nước ngoài dần dần mang lại."*
> — **Adam Smith**, *Của Cải Các Dân Tộc* (1776)', 1, '{}'),

(33, 'key_points', 'Key Points', 'Điểm Chính',
'- The Industrial Revolution (1760-1840) transformed Britain from an agricultural society to the world''s first industrial nation
- **Multiple causes converged**: Agricultural Revolution, population growth, coal/iron resources, stable government, patent system
- **James Watt** improved the steam engine (1776), making it 75% more fuel efficient — powering factories, mines, and railways
- **Richard Arkwright** created the factory system (1771) — workers left homes to operate machines in centralized mills
- **Urbanization** exploded: Manchester grew from 25,000 (1772) to 300,000+ (1850)
- **Social costs** were severe: child labor, 12-16 hour workdays, dangerous conditions, overcrowded slums
- The **Factory Act of 1833** was the first effective child labor regulation in Britain
- The Industrial Revolution''s patterns — job displacement, inequality, regulation debates — mirror today''s digital revolution',
'- Cách Mạng Công Nghiệp (1760-1840) biến nước Anh từ xã hội nông nghiệp thành quốc gia công nghiệp đầu tiên thế giới
- **Nhiều nguyên nhân hội tụ**: Cách Mạng Nông Nghiệp, tăng dân số, tài nguyên than/sắt, chính phủ ổn định, hệ thống bằng sáng chế
- **James Watt** cải tiến động cơ hơi nước (1776), tiết kiệm 75% nhiên liệu — cung cấp năng lượng cho nhà máy, hầm mỏ và đường sắt
- **Richard Arkwright** tạo ra hệ thống nhà máy (1771) — công nhân rời nhà để vận hành máy trong nhà máy tập trung
- **Đô thị hóa** bùng nổ: Manchester tăng từ 25.000 (1772) lên 300.000+ (1850)
- **Chi phí xã hội** nghiêm trọng: lao động trẻ em, ngày làm 12-16 giờ, điều kiện nguy hiểm, khu ổ chuột chật chội
- **Đạo luật Nhà máy 1833** là quy định lao động trẻ em hiệu quả đầu tiên ở Anh
- Các mô hình của Cách Mạng Công Nghiệp — thay thế việc làm, bất bình đẳng, tranh luận quy định — phản chiếu cuộc cách mạng số ngày nay', 2, '{}'),

(33, 'info_box', 'Voices from the Factory Floor', 'Tiếng Nói Từ Sàn Nhà Máy',
'**A primary source from the era:** In 1832, Elizabeth Bentley, aged 23, testified before a British parliamentary committee about her childhood in a flax mill:

> *"I was about 6 years old when I first went to work at Mr. Busk''s flax mill. We worked from five in the morning till nine at night. I was beaten by the overlooker with a strap when I was drowsy... When I had worked about half a year, I could not stand the work any longer, and was frequently badly beaten."*
> — **Elizabeth Bentley**, testimony to the Sadler Committee (1832)

**Why this matters:** Testimonies like Bentley''s shocked the British public and directly led to the Factory Act of 1833. They remind us that behind every statistic about industrial output was a human being. Primary sources let us hear history''s voices directly, rather than through the filter of later interpretation.

**Historical thinking skill:** When reading a primary source, always ask: *Who is speaking? What is their purpose? What might they leave out?*',
'**Nguồn tư liệu gốc từ thời kỳ đó:** Năm 1832, Elizabeth Bentley, 23 tuổi, làm chứng trước ủy ban nghị viện Anh về tuổi thơ trong nhà máy lanh:

> *"Tôi khoảng 6 tuổi khi lần đầu đi làm tại nhà máy lanh của ông Busk. Chúng tôi làm từ 5 giờ sáng đến 9 giờ tối. Tôi bị quản đốc đánh bằng dây da khi tôi buồn ngủ... Khi tôi làm được khoảng nửa năm, tôi không chịu nổi công việc nữa và thường xuyên bị đánh tệ."*
> — **Elizabeth Bentley**, lời khai trước Ủy ban Sadler (1832)

**Tại sao điều này quan trọng:** Những lời khai như của Bentley gây sốc cho công chúng Anh và trực tiếp dẫn đến Đạo luật Nhà máy 1833. Chúng nhắc nhở chúng ta rằng đằng sau mỗi thống kê về sản lượng công nghiệp là một con người. Tư liệu gốc cho phép chúng ta nghe trực tiếp tiếng nói của lịch sử, thay vì qua bộ lọc diễn giải sau này.

**Kỹ năng tư duy lịch sử:** Khi đọc tư liệu gốc, luôn hỏi: *Ai đang nói? Mục đích của họ là gì? Họ có thể bỏ qua điều gì?*', 3, '{"variant": "tip"}');


-- ############################################################################
-- EXERCISES FOR LESSON 33 (exercise IDs 225-231)
-- ############################################################################

-- Chart section: Britain population growth (order_index 4)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(33, 'chart', 'Population Explosion', 'Bùng nổ dân số',
'Britain''s population nearly **tripled** during the Industrial Revolution (1750-1850). Urbanization, improved agriculture, and factory jobs fueled this growth — but also created overcrowded cities with poor sanitation.',
'Dân số Anh gần **gấp ba** trong Cách Mạng Công Nghiệp (1750-1850). Đô thị hóa, cải tiến nông nghiệp và việc làm nhà máy thúc đẩy tăng trưởng — nhưng cũng tạo ra các thành phố chật chội với vệ sinh kém.', 4,
'{"chartType": "area", "xKey": "year", "dataKey": "population", "data": [{"year": "1750", "population": 5.7}, {"year": "1770", "population": 6.4}, {"year": "1790", "population": 7.7}, {"year": "1800", "population": 8.9}, {"year": "1820", "population": 12.0}, {"year": "1840", "population": 14.8}, {"year": "1850", "population": 16.6}]}');

-- Exercise 225: Multiple Choice (11 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(33, 'multiple_choice', 'easy', 'Which invention is Richard Arkwright most famous for?', 'Phát minh nào khiến Richard Arkwright nổi tiếng nhất?', 'Richard Arkwright (1732-1792) is often called the "father of the factory system." Select the invention he patented in 1769:', 'Richard Arkwright (1732-1792) thường được gọi là "cha đẻ của hệ thống nhà máy." Chọn phát minh ông cấp bằng sáng chế năm 1769:', 'Arkwright patented the water frame in 1769 — a spinning machine powered by water that produced strong cotton thread. Because the machine was too large for workers'' homes, Arkwright built centralized mills, creating the factory system that defined the Industrial Revolution.', 'Arkwright cấp bằng sáng chế khung nước năm 1769 — máy kéo sợi chạy bằng nước sản xuất sợi bông chắc. Vì máy quá lớn cho nhà công nhân, Arkwright xây nhà máy tập trung, tạo ra hệ thống nhà máy định hình Cách Mạng Công Nghiệp.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(225, 'A', 'The spinning jenny', FALSE, 'The spinning jenny was invented by James Hargreaves in 1764, not Arkwright', 1),
(225, 'B', 'The water frame', TRUE, 'Correct! Arkwright patented the water frame in 1769 and built the first water-powered cotton mill at Cromford in 1771', 2),
(225, 'C', 'The steam engine', FALSE, 'The steam engine was improved by James Watt — Arkwright focused on textile machinery', 3),
(225, 'D', 'The power loom', FALSE, 'The power loom was invented by Edmund Cartwright in 1785', 4);

-- Exercise 226: Fill Blank (12 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(33, 'fill_blank', 'easy', 'Fill in the name of the revolution that preceded and enabled the Industrial Revolution.', 'Điền tên cuộc cách mạng đã đi trước và tạo điều kiện cho Cách Mạng Công Nghiệp.', 'The ___ Revolution introduced innovations like crop rotation and the seed drill, increasing food production and freeing workers to move into factory jobs.', 'Cách Mạng ___ đã đưa vào các đổi mới như luân canh và máy gieo hạt, tăng sản xuất lương thực và giải phóng lao động để chuyển sang công việc nhà máy.', 'Agricultural', 'The Agricultural Revolution (roughly 1700-1850) transformed farming practices in Britain. Innovations like Jethro Tull''s seed drill and the four-field crop rotation system dramatically increased yields, producing surplus food that supported a growing urban population.', 'Cách Mạng Nông Nghiệp (khoảng 1700-1850) biến đổi thực hành nông nghiệp ở Anh. Các đổi mới như máy gieo hạt của Jethro Tull và hệ thống luân canh bốn cánh đồng tăng đáng kể năng suất, sản xuất thặng dư lương thực nuôi dân số thành thị đang tăng.', 10, 2);

-- Exercise 227: Error Correction (14 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(33, 'error_correction', 'medium', 'Fix the historical error in this statement about James Watt.', 'Sửa lỗi lịch sử trong phát biểu này về James Watt.', 'James Watt invented the steam engine from scratch in 1776, which became the primary power source for factories during the Industrial Revolution.', 'James Watt đã phát minh động cơ hơi nước từ đầu năm 1776, trở thành nguồn năng lượng chính cho các nhà máy trong Cách Mạng Công Nghiệp.', 'James Watt improved the existing steam engine design in 1776, which became the primary power source for factories during the Industrial Revolution.', 'Watt did not invent the steam engine — Thomas Newcomen built the first practical steam engine in 1712. Watt''s crucial contribution was adding a separate condenser to Newcomen''s design, making it 75% more fuel efficient. This distinction between invention and improvement matters in historical accuracy.', 'Watt không phát minh động cơ hơi nước — Thomas Newcomen chế tạo động cơ hơi nước thực tế đầu tiên năm 1712. Đóng góp quan trọng của Watt là thêm bình ngưng riêng vào thiết kế của Newcomen, giúp tiết kiệm 75% nhiên liệu. Sự phân biệt giữa phát minh và cải tiến quan trọng trong tính chính xác lịch sử.', 'Did Watt truly create the steam engine, or did he build upon someone else''s work?', 'Watt thực sự tạo ra động cơ hơi nước, hay ông xây dựng trên công trình của người khác?', 15, 3);

-- Exercise 228: Sentence Transform (12 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(33, 'sentence_transform', 'medium', 'Rewrite this statement from the perspective of a factory worker rather than a factory owner.', 'Viết lại phát biểu này từ góc nhìn công nhân nhà máy thay vì chủ nhà máy.', 'The factory system was a great success that increased production and created wealth.', 'Hệ thống nhà máy là một thành công lớn đã tăng sản xuất và tạo ra của cải.', 'The factory system forced us to work long hours in dangerous conditions for low wages.', 'Historical perspective matters. Factory owners celebrated increased production and profits, while workers experienced harsh 12-16 hour days, dangerous machinery, and subsistence wages. The same event looks entirely different depending on the observer''s position. This exercise develops the critical skill of multiperspectivity in historical analysis.', 'Góc nhìn lịch sử rất quan trọng. Chủ nhà máy tôn vinh sản xuất và lợi nhuận tăng, trong khi công nhân trải qua ngày làm việc 12-16 giờ khắc nghiệt, máy móc nguy hiểm và lương đủ sống. Cùng một sự kiện trông hoàn toàn khác tùy vị trí quan sát. Bài tập này phát triển kỹ năng đa góc nhìn trong phân tích lịch sử.', 15, 4);

-- Exercise 229: Arrange Words (11 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(33, 'arrange_words', 'easy', 'Arrange these Industrial Revolution inventions in chronological order (earliest to latest).', 'Sắp xếp các phát minh Cách Mạng Công Nghiệp theo thứ tự thời gian (sớm nhất đến muộn nhất).', '["Power loom (1785)", "Water frame (1769)", "Spinning jenny (1764)", "Steam locomotive (1804)"]', 'Spinning jenny (1764), Water frame (1769), Power loom (1785), Steam locomotive (1804)', 'The textile industry drove the early Industrial Revolution: the spinning jenny (Hargreaves, 1764) came first, followed by the water frame (Arkwright, 1769), then the power loom (Cartwright, 1785). The steam locomotive (Trevithick, 1804) came later, marking the beginning of the railway age.', 'Ngành dệt thúc đẩy giai đoạn đầu Cách Mạng Công Nghiệp: máy kéo sợi jenny (Hargreaves, 1764) xuất hiện trước, tiếp theo là khung nước (Arkwright, 1769), rồi khung dệt cơ khí (Cartwright, 1785). Đầu máy hơi nước (Trevithick, 1804) đến sau, đánh dấu khởi đầu kỷ nguyên đường sắt.', 10, 5);

-- Exercise 230: Matching (9 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(33, 'matching', 'easy', 'Match each historical figure to their contribution to the Industrial Revolution.', 'Nối mỗi nhân vật lịch sử với đóng góp của họ cho Cách Mạng Công Nghiệp.', 'These four figures represent different aspects of the Industrial Revolution: agricultural innovation (Tull), steam power (Watt), the factory system (Arkwright), and mechanized weaving (Cartwright). Together, they transformed Britain from a farming society to an industrial powerhouse.', 'Bốn nhân vật này đại diện cho các khía cạnh khác nhau của Cách Mạng Công Nghiệp: đổi mới nông nghiệp (Tull), năng lượng hơi nước (Watt), hệ thống nhà máy (Arkwright) và dệt cơ giới (Cartwright). Cùng nhau, họ biến nước Anh từ xã hội nông nghiệp thành cường quốc công nghiệp.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(230, 'Jethro Tull', 'Jethro Tull', 'Invented the seed drill (1701)', 'Phát minh máy gieo hạt (1701)', 1),
(230, 'James Watt', 'James Watt', 'Improved the steam engine (1776)', 'Cải tiến động cơ hơi nước (1776)', 2),
(230, 'Richard Arkwright', 'Richard Arkwright', 'Patented the water frame (1769)', 'Cấp bằng sáng chế khung nước (1769)', 3),
(230, 'Edmund Cartwright', 'Edmund Cartwright', 'Invented the power loom (1785)', 'Phát minh khung dệt cơ khí (1785)', 4);

-- Exercise 231: True/False (12 values)
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(33, 'true_false', 'easy', 'Is this statement about the Industrial Revolution correct?', 'Phát biểu này về Cách Mạng Công Nghiệp có đúng không?', 'The Industrial Revolution began in France because it had the largest population in Europe.', 'Cách Mạng Công Nghiệp bắt đầu ở Pháp vì đây là nước có dân số lớn nhất châu Âu.', 'false', 'False! The Industrial Revolution began in Britain, not France. While France did have a larger population, Britain had a unique combination of advantages: abundant coal and iron, navigable waterways, a stable government with strong property rights, the Agricultural Revolution, a patent system rewarding innovation, and an empire providing raw materials and markets. Population alone was not sufficient — the convergence of multiple factors was required.', 'Sai! Cách Mạng Công Nghiệp bắt đầu ở Anh, không phải Pháp. Dù Pháp có dân số lớn hơn, nước Anh có sự kết hợp lợi thế độc đáo: than và sắt dồi dào, đường thủy có thể đi lại, chính phủ ổn định với quyền sở hữu tài sản mạnh, Cách Mạng Nông Nghiệp, hệ thống bằng sáng chế thưởng đổi mới và đế chế cung cấp nguyên liệu thô và thị trường. Dân số đông không đủ — cần sự hội tụ của nhiều yếu tố.', 5, 7);


-- ============================================================================
-- VERIFICATION QUERY
-- ============================================================================

SELECT l.id, l.name, l.slug,
  (SELECT COUNT(*) FROM lesson_usage WHERE lesson_id = l.id) AS usages,
  (SELECT COUNT(*) FROM tip WHERE lesson_id = l.id) AS tips,
  (SELECT COUNT(*) FROM lesson_section WHERE lesson_id = l.id) AS sections,
  (SELECT COUNT(*) FROM exercise WHERE lesson_id = l.id) AS exercises
FROM lesson l WHERE l.group_id = 10 ORDER BY l.order_index;
