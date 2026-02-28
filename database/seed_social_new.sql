-- ============================================================
-- Seed: Social Sciences New Content
-- Categories: Sociology & Anthropology, Gender Studies & Family,
--             Criminology & Forensics, Pedagogy
-- Lessons: 8 total (2 per category)
-- Schema: group_id, name/name_vi, lesson_usage(title/description),
--         exercise_difficulty (easy/medium/hard),
--         exercise_option (content/content_vi)
-- ============================================================

-- === CATEGORY: Sociology & Anthropology ===

-- Lesson 1: Introduction to Sociology
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Introduction to Sociology', 'Nhập Môn Xã Hội Học',
  'intro-sociology',
  'Explore how social structures, institutions, and forces shape human behavior.',
  'Khám phá cách cấu trúc xã hội, thể chế và lực lượng định hình hành vi con người.',
  'beginner', 45, 1
FROM category WHERE name = 'Sociology & Anthropology';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'intro-sociology'),
   'Understand social structures', 'Hiểu cấu trúc xã hội',
   'Analyze how family, education, and government shape individual behavior.',
   'Phân tích cách gia đình, giáo dục và chính phủ định hình hành vi cá nhân.', 1),
  ((SELECT id FROM lesson WHERE slug = 'intro-sociology'),
   'Apply sociological theories', 'Áp dụng lý thuyết xã hội học',
   'Use conflict theory to analyze income inequality in modern societies.',
   'Sử dụng lý thuyết xung đột để phân tích bất bình đẳng thu nhập trong xã hội hiện đại.', 2),
  ((SELECT id FROM lesson WHERE slug = 'intro-sociology'),
   'Develop sociological imagination', 'Phát triển trí tưởng tượng xã hội học',
   'Connect rising depression rates to social isolation caused by digital technology.',
   'Kết nối tỷ lệ trầm cảm tăng với sự cô lập xã hội do công nghệ số gây ra.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'intro-sociology'),
   'markdown', 'The Science of Society', 'Khoa Học Về Xã Hội',
   E'## What Is Sociology?\n\nSociology is the systematic study of human society, social relationships, and social institutions. It examines how social forces shape individual behavior and collective life.\n\n### Founding Thinkers\n\n**Auguste Comte** coined "sociology" and applied scientific methods to society — calling this **positivism**.\n\n**Emile Durkheim** established sociology as a distinct discipline. His **social facts** — norms, values, and institutions that exist independently and constrain individuals. His concept of **anomie** describes normlessness during rapid social change.\n\n**Max Weber** introduced **Verstehen** (empathetic understanding of social action from the actor''s perspective) and analyzed how **rationalization** — replacing tradition with logical efficiency — defines modernity.\n\n**Karl Marx** saw **class conflict** between the bourgeoisie (who own production) and proletariat (who sell labor) as the engine of history.\n\n### Three Core Perspectives\n\n| Perspective | Core Idea | Key Question |\n|---|---|---|\n| **Functionalism** | Society is an organism; each part serves a function | How does this maintain social stability? |\n| **Conflict Theory** | Society is defined by power and resource competition | Who benefits? Who is disadvantaged? |\n| **Symbolic Interactionism** | Meaning emerges through symbols and social interaction | How do people interpret social symbols? |\n\n### Sociological Imagination\n\nC. Wright Mills'' **sociological imagination** is the capacity to see how personal troubles connect to broader public issues — unemployment is not just personal failure but reflects economic structures.',
   E'## Xã Hội Học Là Gì?\n\nXã hội học là nghiên cứu có hệ thống về xã hội loài người, các mối quan hệ và thể chế xã hội.\n\n### Các Nhà Tư Tưởng Sáng Lập\n\n**Auguste Comte**: Chủ nghĩa thực chứng — áp dụng khoa học vào xã hội.\n\n**Emile Durkheim**: Sự kiện xã hội tồn tại độc lập với cá nhân. Anomie = vô chuẩn trong thay đổi nhanh.\n\n**Max Weber**: Verstehen (hiểu đồng cảm hành động xã hội). Hợp lý hóa định nghĩa tính hiện đại.\n\n**Karl Marx**: Xung đột giai cấp (tư sản vs vô sản) là động cơ lịch sử.\n\n### Ba Quan Điểm Cốt Lõi\n\n- **Chủ nghĩa chức năng**: Mỗi thể chế phục vụ chức năng duy trì ổn định xã hội\n- **Lý thuyết xung đột**: Xã hội là cuộc cạnh tranh quyền lực và tài nguyên\n- **Tương tác biểu tượng**: Ý nghĩa nảy sinh qua tương tác và biểu tượng xã hội\n\n### Trí Tưởng Tượng Xã Hội Học\n\nC. Wright Mills: Nhìn thấy mối liên hệ giữa vấn đề cá nhân và các lực lượng xã hội rộng hơn.',
   '{}', 1),

  ((SELECT id FROM lesson WHERE slug = 'intro-sociology'),
   'key_points', 'Core Concepts', 'Khái Niệm Cốt Lõi',
   E'- **Durkheim**: social facts exist independently of individuals; anomie = normlessness during rapid change\n- **Weber**: Verstehen (empathetic understanding) + rationalization transforms modern society\n- **Marx**: class conflict (bourgeoisie vs proletariat) drives historical change\n- **Three perspectives**: Functionalism (stability), Conflict Theory (power), Symbolic Interactionism (meaning)\n- **Sociological imagination** (Mills): personal troubles reflect broader social/historical forces',
   E'- **Durkheim**: Sự kiện xã hội tồn tại độc lập; anomie = vô chuẩn trong thay đổi nhanh\n- **Weber**: Verstehen (hiểu đồng cảm) + hợp lý hóa định hình xã hội hiện đại\n- **Marx**: Xung đột giai cấp (tư sản vs vô sản) thúc đẩy thay đổi lịch sử\n- **Ba quan điểm**: Chức năng (ổn định), Xung đột (quyền lực), Tương tác (ý nghĩa)\n- **Trí tưởng tượng xã hội học** (Mills): Vấn đề cá nhân phản ánh lực lượng xã hội rộng hơn',
   '{}', 2),

  ((SELECT id FROM lesson WHERE slug = 'intro-sociology'),
   'info_box', 'Sociology in Action', 'Xã Hội Học Trong Thực Tế',
   'Durkheim''s 1897 study of suicide showed it is not purely individual — Catholic countries had lower rates than Protestant ones, because stronger social integration protects against suicide. He proved that even the most private act has social causes, establishing sociology''s scientific legitimacy.',
   'Nghiên cứu tự tử năm 1897 của Durkheim: các nước Công giáo có tỷ lệ thấp hơn Tin lành vì hội nhập xã hội mạnh hơn. Ông chứng minh ngay cả hành động riêng tư nhất cũng có nguyên nhân xã hội.',
   '{"variant": "tip"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'intro-sociology'),
   'multiple_choice', 'easy',
   'Which sociological perspective views society as a system where each part works together to maintain stability?',
   'Quan điểm xã hội học nào coi xã hội là hệ thống mà mỗi bộ phận phối hợp để duy trì ổn định?',
   'B',
   'Functionalism views society like an organism where each institution (family, education, government) serves a function contributing to social stability. Talcott Parsons and Robert Merton developed this perspective.',
   'Chủ nghĩa chức năng coi xã hội như sinh vật trong đó mỗi thể chế phục vụ một chức năng đóng góp vào sự ổn định xã hội.',
   1),
  ((SELECT id FROM lesson WHERE slug = 'intro-sociology'),
   'true_false', 'easy',
   'According to Durkheim, social facts are norms and institutions that depend entirely on individual consciousness.',
   'Theo Durkheim, sự kiện xã hội là chuẩn mực và thể chế hoàn toàn phụ thuộc vào ý thức cá nhân.',
   'false',
   'Durkheim defined social facts as existing independently of individuals, constraining behavior from outside. Language, laws, and customs existed before you and will exist after you.',
   'Durkheim định nghĩa sự kiện xã hội tồn tại độc lập với cá nhân. Ngôn ngữ, luật pháp, phong tục tồn tại trước và sẽ tồn tại sau bạn.',
   2),
  ((SELECT id FROM lesson WHERE slug = 'intro-sociology'),
   'fill_blank', 'easy',
   'C. Wright Mills'' concept of the _____ describes the ability to see connections between personal troubles and public social issues.',
   'Khái niệm _____ của C. Wright Mills mô tả khả năng nhìn thấy kết nối giữa vấn đề cá nhân và vấn đề xã hội.',
   'sociological imagination',
   'The sociological imagination helps understand that individual problems (unemployment, addiction) are often rooted in social structures and historical changes, not purely personal failures.',
   'Trí tưởng tượng xã hội học giúp hiểu rằng vấn đề cá nhân (thất nghiệp, nghiện) thường bắt nguồn từ cấu trúc xã hội và thay đổi lịch sử.',
   3),
  ((SELECT id FROM lesson WHERE slug = 'intro-sociology'),
   'multiple_choice', 'medium',
   'Max Weber''s concept of "Verstehen" refers to:',
   'Khái niệm "Verstehen" của Max Weber đề cập đến:',
   'C',
   'Verstehen means empathetically understanding social action from the actor''s perspective — grasping the subjective meaning behind behavior, not just observing external facts.',
   'Verstehen có nghĩa là hiểu đồng cảm hành động xã hội từ góc nhìn của người hành động — nắm bắt ý nghĩa chủ quan đằng sau hành vi.',
   4),
  ((SELECT id FROM lesson WHERE slug = 'intro-sociology'),
   'error_correction', 'medium',
   'Correct this statement: "According to conflict theory, society functions harmoniously because each institution fulfills a necessary social function."',
   'Sửa câu này: "Theo lý thuyết xung đột, xã hội vận hành hài hòa vì mỗi thể chế thực hiện chức năng xã hội cần thiết."',
   'According to conflict theory, society is characterized by inequality and power struggles, as dominant groups use social institutions to maintain their advantages.',
   'This describes functionalism. Conflict theory argues society is held together by power and coercion, not consensus.',
   'Đây là mô tả của chủ nghĩa chức năng. Lý thuyết xung đột lập luận xã hội gắn kết bởi quyền lực và cưỡng bức, không phải đồng thuận.',
   5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-sociology') AND order_index = 1),
   'A', 'Conflict Theory', 'Lý Thuyết Xung Đột'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-sociology') AND order_index = 1),
   'B', 'Functionalism', 'Chủ Nghĩa Chức Năng'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-sociology') AND order_index = 1),
   'C', 'Symbolic Interactionism', 'Tương Tác Biểu Tượng'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-sociology') AND order_index = 1),
   'D', 'Positivism', 'Chủ Nghĩa Thực Chứng');

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-sociology') AND order_index = 4),
   'A', 'A statistical method for measuring social facts', 'Phương pháp thống kê để đo lường sự kiện xã hội'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-sociology') AND order_index = 4),
   'B', 'The rationalization of society through bureaucracy', 'Hợp lý hóa xã hội thông qua quan liêu'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-sociology') AND order_index = 4),
   'C', 'Empathetic understanding of social action from the actor''s perspective', 'Hiểu đồng cảm hành động xã hội từ góc nhìn của người hành động'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'intro-sociology') AND order_index = 4),
   'D', 'The study of social facts that exist independently of individuals', 'Nghiên cứu sự kiện xã hội tồn tại độc lập với cá nhân');


-- ============================================================
-- LESSON 2: Culture and Social Norms (Sociology & Anthropology)
-- ============================================================
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Culture and Social Norms', 'Văn Hóa và Chuẩn Mực Xã Hội',
  'culture-society-norms',
  'Explore how culture shapes behavior through symbols, values, norms, and socialization processes.',
  'Khám phá cách văn hóa định hình hành vi qua biểu tượng, giá trị, chuẩn mực và quá trình xã hội hóa.',
  'beginner', 40, 2
FROM category WHERE name = 'Sociology & Anthropology';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'culture-society-norms'),
   'Analyze cultural components', 'Phân tích thành phần văn hóa',
   'Distinguish material and non-material culture including symbols, values, norms, and folkways.',
   'Phân biệt văn hóa vật thể và phi vật thể bao gồm biểu tượng, giá trị, chuẩn mực và phong tục.', 1),
  ((SELECT id FROM lesson WHERE slug = 'culture-society-norms'),
   'Apply cultural relativism', 'Áp dụng thuyết tương đối văn hóa',
   'Evaluate social practices without imposing judgments from your own cultural background.',
   'Đánh giá thực hành xã hội mà không áp đặt phán xét từ nền tảng văn hóa của bạn.', 2),
  ((SELECT id FROM lesson WHERE slug = 'culture-society-norms'),
   'Identify socialization agents', 'Nhận diện tác nhân xã hội hóa',
   'Recognize how family, peers, media, and school transmit cultural norms and values.',
   'Nhận ra cách gia đình, bạn bè, truyền thông và trường học truyền đạt chuẩn mực và giá trị văn hóa.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'culture-society-norms'),
   'markdown', 'Understanding Culture and Norms', 'Hiểu Về Văn Hóa và Chuẩn Mực',
   E'## What Is Culture?\n\nCulture is the shared set of **symbols, beliefs, values, norms, and practices** that members of a society use to interpret the world. Culture is **learned** (not innate), **shared**, and **dynamic**.\n\n### Material vs. Non-Material Culture\n\n| Type | Definition | Examples |\n|---|---|---|\n| **Material** | Physical artifacts | Buildings, tools, clothing |\n| **Non-material** | Ideas and abstractions | Values, norms, language |\n\n### Types of Norms\n\n| Norm | Strength | Violation Consequence |\n|---|---|---|\n| **Folkways** | Weak — minor customs | Mild disapproval |\n| **Mores** | Strong — core moral rules | Strong condemnation |\n| **Taboos** | Absolute prohibitions | Severe social rejection |\n| **Laws** | Formal, codified | Legal punishment |\n\n### Cultural Relativism vs. Ethnocentrism\n\n**Cultural relativism** — understanding practices within their own cultural context before judging.\n\n**Ethnocentrism** — judging other cultures by the standards of one''s own culture.\n\n### Socialization\n\nThe lifelong process by which individuals learn cultural norms, values, and roles.\n\n- **Primary socialization**: Family teaches basic norms in early childhood\n- **Secondary socialization**: Peers, school, and media expand cultural knowledge\n\n### Sapir-Whorf Hypothesis\n\nLanguage shapes how we perceive and think about reality. Speakers of different languages may categorize experience differently (linguistic relativity).',
   E'## Văn Hóa Là Gì?\n\nVăn hóa là tập hợp các biểu tượng, niềm tin, giá trị, chuẩn mực và thực hành mà thành viên xã hội dùng để định hướng hành vi. Văn hóa là **được học**, **được chia sẻ**, và **năng động**.\n\n### Phân Loại Chuẩn Mực\n\n- **Folkways**: Quy ước nhỏ, vi phạm gây bất tiện nhỏ\n- **Mores**: Chuẩn mực đạo đức cốt lõi, vi phạm bị lên án mạnh\n- **Điều cấm kỵ**: Lệnh cấm tuyệt đối, vi phạm bị ruồng bỏ\n- **Luật pháp**: Chuẩn mực chính thức hóa, vi phạm bị xử lý pháp lý\n\n### Tương Đối Văn Hóa vs. Tự Tôn Văn Hóa\n\n**Tương đối văn hóa**: Đánh giá thực hành trong bối cảnh của nó.\n**Tự tôn văn hóa**: Phán xét theo tiêu chuẩn văn hóa của mình.\n\n### Xã Hội Hóa\n\n- **Sơ cấp**: Gia đình dạy chuẩn mực cơ bản\n- **Thứ cấp**: Bạn bè, trường học, truyền thông mở rộng văn hóa\n\n### Giả Thuyết Sapir-Whorf\n\nNgôn ngữ định hình cách chúng ta nhận thức thực tại.',
   '{}', 1),
  ((SELECT id FROM lesson WHERE slug = 'culture-society-norms'),
   'key_points', 'Core Concepts', 'Khái Niệm Cốt Lõi',
   E'- **Folkways vs Mores**: folkways = minor conventions (table manners); mores = core moral norms with strong sanctions\n- **Cultural relativism**: evaluate practices within their own context — methodological stance, not moral approval of everything\n- **Ethnocentrism**: judging other cultures by your own standards — leads to cultural bias and misunderstanding\n- **Socialization**: primary (family) teaches basic norms; secondary (peers/school/media) reinforces and expands cultural knowledge\n- **Sapir-Whorf hypothesis**: language influences perception — speakers of different languages may categorize reality differently',
   E'- **Folkways vs Mores**: folkways = quy ước nhỏ; mores = chuẩn mực đạo đức cốt lõi với chế tài mạnh\n- **Tương đối văn hóa**: đánh giá thực hành trong bối cảnh riêng — lập trường phương pháp luận, không phải chấp nhận đạo đức tất cả\n- **Tự tôn văn hóa**: phán xét theo tiêu chuẩn của mình — dẫn đến thành kiến và hiểu nhầm văn hóa\n- **Xã hội hóa**: sơ cấp (gia đình) dạy chuẩn mực cơ bản; thứ cấp (bạn/trường/truyền thông) củng cố và mở rộng\n- **Sapir-Whorf**: ngôn ngữ ảnh hưởng nhận thức — người nói ngôn ngữ khác có thể phân loại thực tại khác nhau',
   '{}', 2),
  ((SELECT id FROM lesson WHERE slug = 'culture-society-norms'),
   'info_box', 'Language and Thought', 'Ngôn Ngữ và Tư Duy',
   'The Hopi language reportedly has no noun for "time" — linguist Benjamin Whorf argued this shapes how Hopi speakers perceive time. Though later contested, this sparked decades of research into how language influences cognition (the Sapir-Whorf hypothesis).',
   'Ngôn ngữ Hopi được cho là không có danh từ cho "thời gian" — Whorf lập luận điều này định hình nhận thức thời gian của người Hopi. Dù bị tranh cãi, điều này thúc đẩy nghiên cứu về cách ngôn ngữ ảnh hưởng nhận thức (giả thuyết Sapir-Whorf).',
   '{"variant": "tip"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'culture-society-norms'),
   'multiple_choice', 'easy',
   'Which term describes the tendency to judge other cultures by the standards of one''s own culture?',
   'Thuật ngữ nào mô tả xu hướng phán xét các nền văn hóa khác theo tiêu chuẩn của nền văn hóa mình?',
   'B',
   'Ethnocentrism is viewing one''s own culture as superior and using it as the standard to judge others. Cultural relativism is the opposite — it calls for evaluating cultures within their own context.',
   'Tự tôn văn hóa là coi văn hóa của mình là tiêu chuẩn để đánh giá các văn hóa khác. Tương đối văn hóa ngược lại — đánh giá văn hóa trong bối cảnh riêng của nó.', 1),
  ((SELECT id FROM lesson WHERE slug = 'culture-society-norms'),
   'true_false', 'easy',
   'Mores are minor social conventions whose violation causes only mild embarrassment, while folkways are the core moral norms with serious social consequences.',
   'Mores là những quy ước xã hội nhỏ mà vi phạm chỉ gây bối rối nhẹ, còn folkways là chuẩn mực đạo đức cốt lõi với hậu quả xã hội nghiêm trọng.',
   'false',
   'This is reversed. Mores are the strong moral norms — violating them brings serious condemnation. Folkways are minor conventions (e.g., table manners) whose violation causes only mild disapproval.',
   'Điều này bị đảo ngược. Mores là chuẩn mực đạo đức mạnh — vi phạm mang lại sự lên án nghiêm trọng. Folkways là quy ước nhỏ mà vi phạm chỉ gây bất tiện nhẹ.', 2),
  ((SELECT id FROM lesson WHERE slug = 'culture-society-norms'),
   'fill_blank', 'easy',
   'The lifelong process through which individuals learn the norms, values, and roles of their society is called _____.',
   'Quá trình suốt đời mà qua đó cá nhân học các chuẩn mực, giá trị và vai trò xã hội được gọi là _____.',
   'socialization',
   'Socialization is the process of internalizing cultural norms and values. Primary socialization occurs in the family; secondary socialization continues through peers, school, and media.',
   'Xã hội hóa là quá trình tiếp thu các chuẩn mực và giá trị văn hóa. Sơ cấp xảy ra trong gia đình; thứ cấp tiếp tục qua bạn bè, trường học và truyền thông.', 3),
  ((SELECT id FROM lesson WHERE slug = 'culture-society-norms'),
   'multiple_choice', 'medium',
   'The Sapir-Whorf hypothesis (linguistic relativity) proposes that:',
   'Giả thuyết Sapir-Whorf (tương đối ngôn ngữ) đề xuất rằng:',
   'B',
   'The Sapir-Whorf hypothesis argues that the language we speak shapes how we perceive and think about reality. The "weak" version argues language influences thought; the "strong" version argues it determines thought.',
   'Giả thuyết Sapir-Whorf lập luận ngôn ngữ chúng ta nói định hình cách nhận thức thực tại. Phiên bản "yếu": ngôn ngữ ảnh hưởng tư duy; phiên bản "mạnh": ngôn ngữ quyết định tư duy.', 4),
  ((SELECT id FROM lesson WHERE slug = 'culture-society-norms'),
   'error_correction', 'medium',
   'Correct this statement: "Cultural relativism means accepting all cultural practices as morally equal and refusing to criticize any aspect of another culture."',
   'Sửa câu này: "Tương đối văn hóa có nghĩa là chấp nhận mọi thực hành văn hóa là bình đẳng về đạo đức và từ chối phê bình bất kỳ khía cạnh nào của văn hóa khác."',
   'Cultural relativism means understanding and evaluating practices within their own cultural context, not judging by external standards — it does not require moral acceptance of all practices.',
   'The statement overstates cultural relativism — it is a methodological tool for understanding cultures in context, not a moral obligation to approve all practices as equally valid.',
   'Câu này phóng đại tương đối văn hóa. Đây là cách tiếp cận phương pháp luận để hiểu, không phải yêu cầu đạo đức phê duyệt mọi thứ. Các học giả có thể dùng nó như công cụ phân tích mà vẫn đánh giá đạo đức các thực hành.', 5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'culture-society-norms') AND order_index = 1),
   'A', 'Cultural relativism', 'Tương đối văn hóa'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'culture-society-norms') AND order_index = 1),
   'B', 'Ethnocentrism', 'Tự tôn văn hóa'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'culture-society-norms') AND order_index = 1),
   'C', 'Cultural diffusion', 'Lan truyền văn hóa'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'culture-society-norms') AND order_index = 1),
   'D', 'Xenocentrism', 'Sùng bái văn hóa ngoại'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'culture-society-norms') AND order_index = 4),
   'A', 'All languages express ideas in fundamentally equivalent ways', 'Mọi ngôn ngữ đều thể hiện ý tưởng theo cách tương đương nhau về cơ bản'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'culture-society-norms') AND order_index = 4),
   'B', 'The language we speak influences how we perceive and think about reality', 'Ngôn ngữ chúng ta nói ảnh hưởng đến cách chúng ta nhận thức và suy nghĩ về thực tại'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'culture-society-norms') AND order_index = 4),
   'C', 'Thought is completely independent of the language we speak', 'Tư duy hoàn toàn độc lập với ngôn ngữ chúng ta nói'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'culture-society-norms') AND order_index = 4),
   'D', 'Cultural change always precedes and drives linguistic change', 'Thay đổi văn hóa luôn đi trước và thúc đẩy thay đổi ngôn ngữ');

-- ============================================================
-- LESSON 3: Gender Studies Basics (Gender Studies & Family)
-- ============================================================
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Gender Studies Basics', 'Nhập Môn Nghiên Cứu Giới',
  'gender-studies-basics',
  'Understand the distinction between sex and gender, gender socialization, and how intersectionality shapes identity.',
  'Hiểu sự khác biệt giữa giới tính sinh học và giới tính xã hội, xã hội hóa giới và cách giao thoa định danh định hình bản sắc.',
  'beginner', 45, 1
FROM category WHERE name = 'Gender Studies & Family';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'gender-studies-basics'),
   'Distinguish sex from gender', 'Phân biệt giới tính sinh học và giới tính xã hội',
   'Explain how biological sex and socially constructed gender are different concepts.',
   'Giải thích cách giới tính sinh học và giới tính được kiến tạo xã hội là hai khái niệm khác nhau.', 1),
  ((SELECT id FROM lesson WHERE slug = 'gender-studies-basics'),
   'Analyze gender socialization', 'Phân tích xã hội hóa giới',
   'Identify how family, media, and institutions teach gender roles and expectations.',
   'Xác định cách gia đình, truyền thông và các tổ chức dạy các vai trò và kỳ vọng giới tính.', 2),
  ((SELECT id FROM lesson WHERE slug = 'gender-studies-basics'),
   'Apply intersectionality', 'Áp dụng lý thuyết giao thoa định danh',
   'Analyze how race, gender, class, and other identities overlap to create unique experiences of privilege and oppression.',
   'Phân tích cách chủng tộc, giới, giai cấp và các bản sắc khác giao nhau tạo ra trải nghiệm đặc quyền và áp bức độc đáo.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'gender-studies-basics'),
   'markdown', 'Sex, Gender, and Identity', 'Giới Tính Sinh Học, Giới Tính Xã Hội và Bản Sắc',
   E'## Sex vs. Gender\n\n| Concept | Definition | Examples |\n|---|---|---|\n| **Sex** | Biological characteristics (chromosomes, hormones, anatomy) | Male, female, intersex |\n| **Gender** | Socially constructed roles, behaviors, and expressions | Man, woman, non-binary |\n\nGender is not fixed — it varies across cultures and history. Many cultures recognize more than two genders.\n\n## Gender Roles and Socialization\n\n**Gender roles** are the social expectations about how men and women should behave. They are taught through:\n\n- **Family**: toy choices, clothing, language\n- **School**: different treatment of boys and girls\n- **Media**: gendered representations and stereotypes\n- **Peer groups**: policing of gender conformity\n\n## Waves of Feminism\n\n| Wave | Period | Focus |\n|---|---|---|\n| **First wave** | Late 1800s–1920s | Suffrage, legal equality |\n| **Second wave** | 1960s–1980s | Workplace equality, reproductive rights, patriarchy |\n| **Third wave** | 1990s–2000s | Intersectionality, individual expression, postmodern critique |\n| **Fourth wave** | 2010s–present | Online activism, #MeToo, sexual harassment |\n\n## Intersectionality\n\nCoined by legal scholar **Kimberlé Crenshaw (1989)**, intersectionality describes how race, gender, class, sexuality, and other social categories **overlap** to create unique experiences of discrimination or privilege. A Black woman''s experience cannot be understood by analyzing race and gender separately.',
   E'## Giới Tính Sinh Học vs. Giới Tính Xã Hội\n\n| Khái niệm | Định nghĩa | Ví dụ |\n|---|---|---|\n| **Giới tính sinh học (Sex)** | Đặc điểm sinh học (nhiễm sắc thể, hormone, giải phẫu) | Nam, nữ, lưỡng tính |\n| **Giới tính xã hội (Gender)** | Vai trò và biểu hiện được kiến tạo xã hội | Nam giới, nữ giới, phi nhị nguyên |\n\nGiới tính xã hội không cố định — nó thay đổi theo văn hóa và lịch sử.\n\n## Xã Hội Hóa Giới\n\n**Vai trò giới** là kỳ vọng xã hội về cách nam và nữ nên hành xử. Chúng được dạy qua:\n- **Gia đình**: lựa chọn đồ chơi, quần áo, ngôn ngữ\n- **Trường học**: đối xử khác nhau với trẻ nam và nữ\n- **Truyền thông**: hình ảnh và định kiến giới\n- **Nhóm bạn**: kiểm soát sự tuân thủ giới\n\n## Các Làn Sóng Nữ Quyền\n\n- **Làn sóng 1** (cuối 1800s–1920s): Quyền bầu cử, bình đẳng pháp lý\n- **Làn sóng 2** (1960s–1980s): Bình đẳng việc làm, quyền sinh sản\n- **Làn sóng 3** (1990s–2000s): Giao thoa định danh, biểu đạt cá nhân\n- **Làn sóng 4** (2010s–nay): #MeToo, hoạt động trực tuyến\n\n## Giao Thoa Định Danh\n\nDo học giả pháp lý **Kimberlé Crenshaw (1989)** đặt ra, giao thoa định danh mô tả cách chủng tộc, giới, giai cấp và các danh mục xã hội khác **chồng chéo** tạo ra trải nghiệm phân biệt đối xử hoặc đặc quyền độc đáo.',
   '{}', 1),
  ((SELECT id FROM lesson WHERE slug = 'gender-studies-basics'),
   'key_points', 'Core Concepts', 'Khái Niệm Cốt Lõi',
   E'- **Sex vs Gender**: sex = biological (chromosomes, hormones); gender = socially constructed roles and expressions that vary across cultures\n- **Gender socialization**: family, school, media, and peers teach gender norms — this is learned, not innate\n- **Patriarchy**: a social system where men hold primary power in political, social, and economic institutions\n- **Intersectionality** (Kimberlé Crenshaw, 1989): overlapping identities (race + gender + class) create unique experiences — analyze together, not separately\n- **Feminist waves**: 1st = suffrage; 2nd = workplace/reproductive rights; 3rd = intersectionality; 4th = #MeToo/online activism',
   E'- **Giới tính sinh học vs xã hội**: sinh học = nhiễm sắc thể, hormone; xã hội = vai trò và biểu hiện được kiến tạo, thay đổi theo văn hóa\n- **Xã hội hóa giới**: gia đình, trường, truyền thông, bạn bè dạy chuẩn mực giới — được học, không phải bẩm sinh\n- **Chế độ phụ quyền**: hệ thống xã hội nơi nam giới nắm quyền lực chính trong các tổ chức chính trị, xã hội, kinh tế\n- **Giao thoa định danh** (Kimberlé Crenshaw, 1989): các bản sắc chồng chéo tạo ra trải nghiệm độc đáo — phân tích cùng nhau, không riêng lẻ\n- **Các làn sóng nữ quyền**: 1 = bầu cử; 2 = việc làm/sinh sản; 3 = giao thoa định danh; 4 = #MeToo',
   '{}', 2),
  ((SELECT id FROM lesson WHERE slug = 'gender-studies-basics'),
   'info_box', 'Kimberlé Crenshaw and Intersectionality', 'Kimberlé Crenshaw và Giao Thoa Định Danh',
   'Crenshaw developed intersectionality by analyzing court cases where Black women''s discrimination claims were dismissed because the courts treated race and gender as separate categories. Her 1989 paper "Demarginalizing the Intersection of Race and Sex" became foundational to feminist theory.',
   'Crenshaw phát triển lý thuyết giao thoa định danh khi phân tích các vụ kiện mà khiếu nại phân biệt đối xử của phụ nữ da đen bị bác vì tòa án coi chủng tộc và giới là các danh mục riêng biệt. Bài báo 1989 của bà là nền tảng của lý thuyết nữ quyền.',
   '{"variant": "tip"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'gender-studies-basics'),
   'multiple_choice', 'easy',
   'In social science, "sex" refers to:',
   'Trong khoa học xã hội, "giới tính sinh học (sex)" đề cập đến:',
   'B',
   'Sex refers to biological characteristics — chromosomes, hormones, and anatomy. Gender refers to the socially constructed roles, behaviors, and expressions associated with being a man or woman (or other gender identities).',
   'Giới tính sinh học đề cập đến các đặc điểm sinh học — nhiễm sắc thể, hormone và giải phẫu. Giới tính xã hội đề cập đến các vai trò, hành vi và biểu hiện được kiến tạo xã hội.', 1),
  ((SELECT id FROM lesson WHERE slug = 'gender-studies-basics'),
   'true_false', 'easy',
   'Gender roles are primarily determined by biological differences between males and females, making them universal and consistent across all cultures.',
   'Vai trò giới chủ yếu được xác định bởi sự khác biệt sinh học giữa nam và nữ, làm cho chúng mang tính phổ quát và nhất quán trong mọi nền văn hóa.',
   'false',
   'Gender roles vary significantly across cultures and historical periods, showing they are socially constructed rather than biologically determined. For example, many cultures historically accepted gender roles very different from contemporary Western norms.',
   'Vai trò giới thay đổi đáng kể giữa các nền văn hóa và giai đoạn lịch sử, cho thấy chúng được kiến tạo xã hội chứ không được xác định sinh học.', 2),
  ((SELECT id FROM lesson WHERE slug = 'gender-studies-basics'),
   'fill_blank', 'easy',
   'Legal scholar Kimberlé Crenshaw coined the term _____ to describe how overlapping social identities create unique experiences of discrimination.',
   'Học giả pháp lý Kimberlé Crenshaw đặt ra thuật ngữ _____ để mô tả cách các bản sắc xã hội chồng chéo tạo ra trải nghiệm phân biệt đối xử độc đáo.',
   'intersectionality',
   'Intersectionality (1989) describes how race, gender, class, sexuality, and other categories overlap to produce unique experiences. A Black woman''s experience differs from that of a white woman and a Black man — it cannot be reduced to either category alone.',
   'Giao thoa định danh (1989) mô tả cách chủng tộc, giới, giai cấp, tính dục và các danh mục khác chồng chéo tạo ra trải nghiệm độc đáo không thể quy về bất kỳ danh mục đơn lẻ nào.', 3),
  ((SELECT id FROM lesson WHERE slug = 'gender-studies-basics'),
   'multiple_choice', 'medium',
   'The second wave of feminism (1960s–1980s) primarily focused on:',
   'Làn sóng nữ quyền thứ hai (1960s–1980s) chủ yếu tập trung vào:',
   'B',
   'Second-wave feminism expanded beyond suffrage to tackle workplace discrimination, reproductive rights, domestic violence, and structural patriarchy. Key texts include Betty Friedan''s "The Feminine Mystique" (1963) and movements like NOW (National Organization for Women).',
   'Nữ quyền làn sóng hai mở rộng ra ngoài quyền bầu cử để giải quyết phân biệt đối xử tại nơi làm việc, quyền sinh sản, bạo lực gia đình và chế độ phụ quyền cấu trúc.', 4),
  ((SELECT id FROM lesson WHERE slug = 'gender-studies-basics'),
   'error_correction', 'medium',
   'Correct this statement: "Patriarchy refers to a social system where women hold primary power in political, social, and economic institutions."',
   'Sửa câu này: "Chế độ phụ quyền đề cập đến một hệ thống xã hội nơi phụ nữ nắm quyền lực chính trong các tổ chức chính trị, xã hội và kinh tế."',
   'Patriarchy refers to a social system where men hold primary power in political, social, and economic institutions.',
   'The definition is reversed. Patriarchy (from Greek "pater" = father) describes male dominance in social structures. The described system (female dominance) would be called a matriarchy.',
   'Định nghĩa bị đảo ngược. Chế độ phụ quyền (từ tiếng Hy Lạp "pater" = cha) mô tả sự thống trị của nam giới. Hệ thống được mô tả (thống trị của nữ giới) sẽ được gọi là chế độ mẫu quyền.', 5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'gender-studies-basics') AND order_index = 1),
   'A', 'The socially constructed roles and behaviors expected of men and women', 'Các vai trò và hành vi được kiến tạo xã hội kỳ vọng ở nam và nữ'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'gender-studies-basics') AND order_index = 1),
   'B', 'Biological characteristics including chromosomes, hormones, and anatomy', 'Các đặc điểm sinh học bao gồm nhiễm sắc thể, hormone và giải phẫu'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'gender-studies-basics') AND order_index = 1),
   'C', 'Sexual orientation and attraction patterns', 'Khuynh hướng tình dục và mô hình hấp dẫn'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'gender-studies-basics') AND order_index = 1),
   'D', 'Personal identity and psychological sense of self', 'Bản sắc cá nhân và cảm giác tâm lý về bản thân'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'gender-studies-basics') AND order_index = 4),
   'A', 'Women''s suffrage and the right to vote in political elections', 'Quyền bầu cử của phụ nữ trong các cuộc bầu cử chính trị'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'gender-studies-basics') AND order_index = 4),
   'B', 'Workplace equality, reproductive rights, and challenging structural patriarchy', 'Bình đẳng tại nơi làm việc, quyền sinh sản và thách thức chế độ phụ quyền cấu trúc'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'gender-studies-basics') AND order_index = 4),
   'C', 'Online activism, #MeToo movement, and transgender rights', 'Hoạt động trực tuyến, phong trào #MeToo và quyền người chuyển giới'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'gender-studies-basics') AND order_index = 4),
   'D', 'Intersectionality of race, class, and sexual orientation', 'Giao thoa của chủng tộc, giai cấp và khuynh hướng tình dục');

-- ============================================================
-- LESSON 4: Family Dynamics and Psychology (Gender Studies & Family)
-- ============================================================
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Family Dynamics and Psychology', 'Tâm Lý và Động Học Gia Đình',
  'family-dynamics-psychology',
  'Explore attachment theory, parenting styles, and how family systems shape psychological development.',
  'Khám phá lý thuyết gắn bó, phong cách nuôi dạy con và cách hệ thống gia đình định hình sự phát triển tâm lý.',
  'beginner', 40, 2
FROM category WHERE name = 'Gender Studies & Family';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'family-dynamics-psychology'),
   'Apply attachment theory', 'Áp dụng lý thuyết gắn bó',
   'Explain how early caregiver bonds shape emotional regulation and future relationship patterns.',
   'Giải thích cách các mối liên kết sớm với người chăm sóc định hình điều hòa cảm xúc và mô hình quan hệ tương lai.', 1),
  ((SELECT id FROM lesson WHERE slug = 'family-dynamics-psychology'),
   'Identify parenting styles', 'Nhận diện phong cách nuôi dạy con',
   'Apply Baumrind''s four parenting styles and predict their developmental outcomes.',
   'Áp dụng bốn phong cách nuôi dạy con của Baumrind và dự đoán kết quả phát triển của chúng.', 2),
  ((SELECT id FROM lesson WHERE slug = 'family-dynamics-psychology'),
   'Analyze family systems', 'Phân tích hệ thống gia đình',
   'Recognize how family roles, rules, and communication patterns affect individual wellbeing.',
   'Nhận ra cách các vai trò gia đình, quy tắc và mô hình giao tiếp ảnh hưởng đến sức khỏe cá nhân.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'family-dynamics-psychology'),
   'markdown', 'Attachment Theory and Family Systems', 'Lý Thuyết Gắn Bó và Hệ Thống Gia Đình',
   E'## Family Types\n\n- **Nuclear family**: two parents + children\n- **Extended family**: nuclear + grandparents, aunts, uncles\n- **Single-parent family**: one parent + children\n- **Blended family**: step-parents and step-siblings\n- **Chosen family**: close non-biological relationships\n\n## Bowlby''s Attachment Theory\n\nJohn Bowlby (1969) proposed that infants have an innate need to form a close emotional bond with a primary caregiver. This **attachment bond** creates an **internal working model** — a mental template for all future relationships.\n\n**Mary Ainsworth''s Strange Situation** (1970s) observed infants separated briefly from their caregiver, identifying attachment styles:\n\n| Style | Characteristics |\n|---|---|\n| **Secure** | Distressed when separated; comforted upon return; trusting |\n| **Anxious-Ambivalent** | Highly distressed; not easily comforted; clingy |\n| **Avoidant** | Little distress; ignores caregiver on return; independent |\n| **Disorganized** | Confused, contradictory behavior; often linked to trauma |\n\n## Baumrind''s Parenting Styles\n\n| Style | Warmth | Control | Outcome |\n|---|---|---|---|\n| **Authoritative** | High | High | Best outcomes: confident, self-regulated |\n| **Authoritarian** | Low | High | Lower self-esteem, higher obedience |\n| **Permissive** | High | Low | Lower self-regulation, impulsive |\n| **Uninvolved** | Low | Low | Poorest outcomes: neglect effects |\n\n## Family Systems Theory\n\nMurray Bowen''s theory views the family as an **emotional unit** where individual behavior cannot be understood in isolation. Key concepts:\n- **Triangles**: Three-person relationship dynamics\n- **Differentiation of self**: Ability to maintain identity within the family system',
   E'## Các Loại Gia Đình\n\n- **Gia đình hạt nhân**: hai cha mẹ + con cái\n- **Gia đình mở rộng**: hạt nhân + ông bà, cô chú\n- **Gia đình đơn thân**: một cha hoặc mẹ + con cái\n- **Gia đình hỗn hợp**: cha mẹ kế và anh chị em kế\n\n## Lý Thuyết Gắn Bó của Bowlby\n\nJohn Bowlby (1969) đề xuất trẻ sơ sinh có nhu cầu bẩm sinh hình thành mối liên kết cảm xúc chặt chẽ với người chăm sóc chính. Mối liên kết này tạo ra **mô hình nội tâm** — khuôn mẫu cho tất cả các mối quan hệ tương lai.\n\n**Thí nghiệm Tình huống Lạ của Ainsworth** xác định các phong cách gắn bó:\n- **An toàn**: buồn khi xa cách; được an ủi khi trở lại; tin tưởng\n- **Lo lắng-mâu thuẫn**: rất đau khổ; khó được an ủi; bám víu\n- **Tránh né**: ít đau khổ; phớt lờ người chăm sóc khi trở lại\n- **Rối loạn**: hành vi mâu thuẫn; thường liên quan đến chấn thương\n\n## Phong Cách Nuôi Dạy Con của Baumrind\n\n- **Uy quyền (Authoritative)**: Ấm áp cao + Kiểm soát cao → kết quả tốt nhất\n- **Độc đoán (Authoritarian)**: Ấm áp thấp + Kiểm soát cao → tự trọng thấp hơn\n- **Nuông chiều (Permissive)**: Ấm áp cao + Kiểm soát thấp → tự điều chỉnh kém\n- **Bỏ bê (Uninvolved)**: Ấm áp thấp + Kiểm soát thấp → kết quả tệ nhất',
   '{}', 1),
  ((SELECT id FROM lesson WHERE slug = 'family-dynamics-psychology'),
   'key_points', 'Core Concepts', 'Khái Niệm Cốt Lõi',
   E'- **Bowlby''s attachment**: innate need for caregiver bond creates internal working model for all future relationships\n- **Ainsworth''s Strange Situation**: identified 4 attachment styles — secure, anxious-ambivalent, avoidant, disorganized\n- **Authoritative parenting** (high warmth + high control): consistently associated with best developmental outcomes\n- **Authoritarian** ≠ Authoritative: authoritarian = strict, low warmth → lower self-esteem; authoritative = warm + structured → confidence\n- **Family systems theory**: family is an emotional unit — individual behavior cannot be understood in isolation from family dynamics',
   E'- **Gắn bó của Bowlby**: nhu cầu bẩm sinh về mối liên kết với người chăm sóc tạo ra mô hình nội tâm cho tất cả các mối quan hệ tương lai\n- **Tình huống Lạ của Ainsworth**: xác định 4 phong cách gắn bó — an toàn, lo lắng-mâu thuẫn, tránh né, rối loạn\n- **Nuôi dạy uy quyền** (ấm áp cao + kiểm soát cao): nhất quán liên quan đến kết quả phát triển tốt nhất\n- **Độc đoán ≠ Uy quyền**: độc đoán = nghiêm khắc, ấm áp thấp → tự trọng thấp; uy quyền = ấm áp + có cấu trúc → tự tin\n- **Lý thuyết hệ thống gia đình**: gia đình là đơn vị cảm xúc — hành vi cá nhân không thể hiểu tách biệt khỏi động học gia đình',
   '{}', 2),
  ((SELECT id FROM lesson WHERE slug = 'family-dynamics-psychology'),
   'info_box', 'Romanian Orphanage Studies', 'Nghiên Cứu Trại Trẻ Mồ Côi Romania',
   'Studies of children raised in Romanian orphanages (1990s) provided stark evidence for attachment theory. Children with minimal caregiver interaction showed severe developmental delays, lower IQ, and difficulties forming relationships — demonstrating that early attachment is critical for healthy brain development.',
   'Nghiên cứu về trẻ em lớn lên trong trại trẻ mồ côi Romania (thập niên 1990) cung cấp bằng chứng rõ ràng cho lý thuyết gắn bó. Trẻ có tương tác tối thiểu với người chăm sóc cho thấy chậm phát triển nghiêm trọng và khó khăn trong việc hình thành các mối quan hệ.',
   '{"variant": "tip"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'family-dynamics-psychology'),
   'multiple_choice', 'easy',
   'Which parenting style combines high warmth and responsiveness with high demands and consistent structure?',
   'Phong cách nuôi dạy con nào kết hợp sự ấm áp và đáp ứng cao với yêu cầu cao và cấu trúc nhất quán?',
   'B',
   'Authoritative parenting (high warmth + high control) is consistently linked to the best developmental outcomes: children tend to be more confident, self-regulated, and socially competent. Do not confuse with authoritarian (high control but low warmth).',
   'Nuôi dạy uy quyền (ấm áp cao + kiểm soát cao) nhất quán liên quan đến kết quả phát triển tốt nhất: trẻ em có xu hướng tự tin hơn, tự điều chỉnh và có năng lực xã hội. Đừng nhầm với độc đoán (kiểm soát cao nhưng ấm áp thấp).', 1),
  ((SELECT id FROM lesson WHERE slug = 'family-dynamics-psychology'),
   'true_false', 'easy',
   'According to John Bowlby, the early attachment bond formed between infant and caregiver creates an internal working model that influences all future relationships.',
   'Theo John Bowlby, mối liên kết gắn bó sớm được hình thành giữa trẻ sơ sinh và người chăm sóc tạo ra một mô hình nội tâm ảnh hưởng đến tất cả các mối quan hệ tương lai.',
   'true',
   'Bowlby argued that early attachment experiences create mental templates (internal working models) for expectations about self, others, and relationships — and these models persist into adulthood, influencing romantic relationships, parenting, and social bonds.',
   'Bowlby lập luận rằng trải nghiệm gắn bó sớm tạo ra các khuôn mẫu tinh thần cho kỳ vọng về bản thân, người khác và các mối quan hệ — và các mô hình này tồn tại đến tuổi trưởng thành.', 2),
  ((SELECT id FROM lesson WHERE slug = 'family-dynamics-psychology'),
   'fill_blank', 'easy',
   'Mary Ainsworth''s _____ experiment observed infants'' reactions to brief separation from their caregiver, identifying distinct attachment styles.',
   'Thí nghiệm _____ của Mary Ainsworth quan sát phản ứng của trẻ sơ sinh với việc tách biệt ngắn ngủi khỏi người chăm sóc, xác định các phong cách gắn bó riêng biệt.',
   'Strange Situation',
   'The Strange Situation (1970s) involved eight standardized episodes where the infant was left with a stranger and then reunited with the caregiver. Ainsworth originally identified three attachment styles; a fourth (disorganized) was added by Main and Solomon.',
   'Tình huống Lạ (thập niên 1970) bao gồm tám giai đoạn chuẩn hóa nơi trẻ sơ sinh được để lại với người lạ và sau đó đoàn tụ với người chăm sóc. Ainsworth ban đầu xác định ba phong cách gắn bó; phong cách thứ tư (rối loạn) được thêm vào sau.', 3),
  ((SELECT id FROM lesson WHERE slug = 'family-dynamics-psychology'),
   'multiple_choice', 'medium',
   'Diana Baumrind''s "permissive" parenting style is characterized by:',
   'Phong cách nuôi dạy con "nuông chiều" của Diana Baumrind được đặc trưng bởi:',
   'A',
   'Permissive parenting features high warmth and responsiveness but few demands or structure. Parents are nurturing and communicative but avoid setting limits. Children tend to have lower self-regulation and higher impulsivity. Not to be confused with uninvolved (low warmth + low demands).',
   'Nuôi dạy nuông chiều có đặc điểm ấm áp và đáp ứng cao nhưng ít yêu cầu hoặc cấu trúc. Cha mẹ nuôi dưỡng và giao tiếp nhưng tránh đặt ra giới hạn. Trẻ em có xu hướng tự điều chỉnh thấp hơn và bốc đồng hơn.', 4),
  ((SELECT id FROM lesson WHERE slug = 'family-dynamics-psychology'),
   'error_correction', 'medium',
   'Correct this statement: "Authoritarian parenting produces the best developmental outcomes because strict rules and high expectations build character and discipline."',
   'Sửa câu này: "Nuôi dạy con độc đoán tạo ra kết quả phát triển tốt nhất vì các quy tắc nghiêm khắc và kỳ vọng cao xây dựng tính cách và kỷ luật."',
   'Authoritative parenting (not authoritarian) produces the best outcomes. Authoritarian parenting (high control + low warmth) is linked to lower self-esteem and higher anxiety in children.',
   'Research consistently shows authoritative parenting (warm + structured, explains reasons for rules) — not authoritarian — produces the best outcomes. Authoritarian parenting, characterized by strict obedience demands without warmth, tends to reduce autonomy and self-esteem.',
   'Nghiên cứu nhất quán cho thấy nuôi dạy uy quyền (ấm áp + có cấu trúc) — không phải độc đoán — tạo ra kết quả tốt nhất. Nuôi dạy độc đoán, đặc trưng bởi yêu cầu phục tùng nghiêm ngặt không có sự ấm áp, có xu hướng giảm tính tự chủ và tự trọng.', 5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'family-dynamics-psychology') AND order_index = 1),
   'A', 'Permissive — high warmth, few demands or rules', 'Nuông chiều — ấm áp cao, ít yêu cầu hoặc quy tắc'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'family-dynamics-psychology') AND order_index = 1),
   'B', 'Authoritative — high warmth, high demands with consistent structure', 'Uy quyền — ấm áp cao, yêu cầu cao với cấu trúc nhất quán'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'family-dynamics-psychology') AND order_index = 1),
   'C', 'Authoritarian — high demands, strict discipline, low warmth', 'Độc đoán — yêu cầu cao, kỷ luật nghiêm khắc, ấm áp thấp'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'family-dynamics-psychology') AND order_index = 1),
   'D', 'Uninvolved — low warmth, minimal demands or engagement', 'Bỏ bê — ấm áp thấp, yêu cầu hoặc tương tác tối thiểu'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'family-dynamics-psychology') AND order_index = 4),
   'A', 'High warmth and responsiveness combined with low demands and minimal structure', 'Ấm áp và đáp ứng cao kết hợp với yêu cầu thấp và cấu trúc tối thiểu'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'family-dynamics-psychology') AND order_index = 4),
   'B', 'High warmth with consistent rules, expectations, and explanations for limits', 'Ấm áp cao với các quy tắc nhất quán, kỳ vọng và giải thích cho các giới hạn'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'family-dynamics-psychology') AND order_index = 4),
   'C', 'Low warmth with high demands, strict discipline, and unquestioned authority', 'Ấm áp thấp với yêu cầu cao, kỷ luật nghiêm khắc và quyền lực không bị nghi ngờ'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'family-dynamics-psychology') AND order_index = 4),
   'D', 'Low warmth and low demands with minimal parental involvement', 'Ấm áp thấp và yêu cầu thấp với sự tham gia tối thiểu của cha mẹ');


-- ============================================================
-- LESSON 5: Criminology Basics (Criminology & Forensics)
-- ============================================================
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Criminology Basics', 'Nhập Môn Tội Phạm Học',
  'criminology-basics',
  'Explore major theories of crime causation, from rational choice to strain theory and labeling theory.',
  'Khám phá các lý thuyết chính về nguyên nhân tội phạm, từ lý thuyết lựa chọn hợp lý đến lý thuyết căng thẳng và gán nhãn.',
  'beginner', 45, 1
FROM category WHERE name = 'Criminology & Forensics';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'criminology-basics'),
   'Compare criminological theories', 'So sánh các lý thuyết tội phạm học',
   'Distinguish classical, positivist, and sociological explanations of criminal behavior.',
   'Phân biệt các giải thích cổ điển, thực chứng và xã hội học về hành vi tội phạm.', 1),
  ((SELECT id FROM lesson WHERE slug = 'criminology-basics'),
   'Apply Merton''s strain theory', 'Áp dụng lý thuyết căng thẳng của Merton',
   'Analyze how the gap between cultural goals and legitimate means produces deviance.',
   'Phân tích cách khoảng cách giữa mục tiêu văn hóa và phương tiện hợp pháp tạo ra hành vi lệch lạc.', 2),
  ((SELECT id FROM lesson WHERE slug = 'criminology-basics'),
   'Understand labeling theory', 'Hiểu lý thuyết gán nhãn',
   'Explain how social labels shape criminal identity and secondary deviance.',
   'Giải thích cách nhãn xã hội định hình bản sắc tội phạm và sự lệch lạc thứ cấp.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'criminology-basics'),
   'markdown', 'Theories of Crime Causation', 'Các Lý Thuyết Về Nguyên Nhân Tội Phạm',
   E'## Classical Criminology\n\nDeveloped by **Cesare Beccaria** (1764) and **Jeremy Bentham**: crime results from **rational choice** — offenders weigh costs (punishment) against benefits (gain). Deterrence works through:\n- **Certainty**: likelihood of being caught\n- **Swiftness**: speed of punishment\n- **Severity**: harshness of punishment\n\n## Positivist Criminology\n\n**Cesare Lombroso** (1876) argued criminals were biologically distinct — "born criminals" with atavistic features. Modern positivism looks at biological, psychological, and social determinants (not free choice).\n\n## Merton''s Strain Theory (1938)\n\nRobert Merton argued crime results from the gap between culturally valued goals (e.g., wealth) and the legitimate means available to achieve them.\n\n**Five adaptations to strain:**\n\n| Adaptation | Goals | Means | Example |\n|---|---|---|---|\n| **Conformity** | Accept | Accept | Regular employee |\n| **Innovation** | Accept | Reject | Drug dealer |\n| **Ritualism** | Reject | Accept | Bureaucrat |\n| **Retreatism** | Reject | Reject | Homeless dropout |\n| **Rebellion** | Replace | Replace | Revolutionary |\n\n## Labeling Theory (Howard Becker, 1963)\n\nDeviance is **not** a quality of the act itself but a consequence of **social rules and sanctions** applied by others.\n\n- **Primary deviance**: initial rule violation\n- **Secondary deviance**: when the person internalizes the deviant label and reorganizes identity around it\n- **Stigma** (Goffman): spoiled social identity that limits opportunities',
   E'## Tội Phạm Học Cổ Điển\n\nDo **Cesare Beccaria** (1764) và **Jeremy Bentham** phát triển: tội phạm là kết quả của **lựa chọn hợp lý** — người phạm tội cân nhắc chi phí (trừng phạt) so với lợi ích (thu được). Răn đe hoạt động qua tính chắc chắn, tốc độ và mức độ nghiêm khắc của hình phạt.\n\n## Tội Phạm Học Thực Chứng\n\n**Cesare Lombroso** (1876) lập luận tội phạm khác biệt về mặt sinh học. Thực chứng hiện đại xem xét các yếu tố quyết định sinh học, tâm lý và xã hội.\n\n## Lý Thuyết Căng Thẳng của Merton (1938)\n\nMerton lập luận tội phạm là kết quả của khoảng cách giữa các mục tiêu văn hóa có giá trị (ví dụ: sự giàu có) và các phương tiện hợp pháp có sẵn để đạt được chúng.\n\n**Năm cách thích nghi với căng thẳng:**\n- **Conformity (Tuân thủ)**: chấp nhận mục tiêu và phương tiện\n- **Innovation (Đổi mới)**: chấp nhận mục tiêu, từ chối phương tiện (dealer)\n- **Ritualism (Nghi lễ)**: từ chối mục tiêu, chấp nhận phương tiện\n- **Retreatism (Rút lui)**: từ chối cả mục tiêu và phương tiện\n- **Rebellion (Nổi loạn)**: thay thế cả mục tiêu và phương tiện\n\n## Lý Thuyết Gán Nhãn (Howard Becker, 1963)\n\nSự lệch lạc không phải là phẩm chất của hành động mà là hệ quả của các quy tắc và chế tài xã hội được áp dụng bởi người khác.\n- **Lệch lạc sơ cấp**: vi phạm quy tắc ban đầu\n- **Lệch lạc thứ cấp**: khi người đó nội tâm hóa nhãn lệch lạc',
   '{}', 1),
  ((SELECT id FROM lesson WHERE slug = 'criminology-basics'),
   'key_points', 'Core Concepts', 'Khái Niệm Cốt Lõi',
   E'- **Classical criminology** (Beccaria): crime = rational choice; deterrence through certainty, swiftness, and severity of punishment\n- **Positivist criminology** (Lombroso): criminal behavior is determined (biology/psychology/environment), not freely chosen\n- **Merton''s strain theory**: crime results from gap between cultural goals (wealth) and available legitimate means; five adaptations (conformity, innovation, ritualism, retreatism, rebellion)\n- **Labeling theory** (Becker): deviance is socially constructed — labels create secondary deviance when internalized\n- **Primary vs secondary deviance**: primary = initial act; secondary = when person adopts deviant identity after being labeled',
   E'- **Tội phạm học cổ điển** (Beccaria): tội phạm = lựa chọn hợp lý; răn đe qua tính chắc chắn, tốc độ và mức độ nghiêm khắc\n- **Tội phạm học thực chứng** (Lombroso): hành vi tội phạm được xác định (sinh học/tâm lý/môi trường), không phải lựa chọn tự do\n- **Lý thuyết căng thẳng của Merton**: tội phạm là kết quả của khoảng cách giữa mục tiêu văn hóa và phương tiện hợp pháp; năm cách thích nghi\n- **Lý thuyết gán nhãn** (Becker): sự lệch lạc được kiến tạo xã hội — nhãn tạo ra lệch lạc thứ cấp khi được nội tâm hóa\n- **Lệch lạc sơ cấp vs thứ cấp**: sơ cấp = hành động ban đầu; thứ cấp = khi người đó áp dụng bản sắc lệch lạc sau khi bị gán nhãn',
   '{}', 2),
  ((SELECT id FROM lesson WHERE slug = 'criminology-basics'),
   'info_box', 'From "Nothing Works" to "What Works"', 'Từ "Không Gì Hiệu Quả" đến "Điều Gì Hiệu Quả"',
   'In 1974, Robert Martinson reviewed rehabilitation programs and concluded "nothing works" — sparking a punitive shift in criminal justice. However, later research (Andrews & Bonta) demonstrated that structured programs targeting criminogenic needs (risk-need-responsivity model) significantly reduce recidivism.',
   'Năm 1974, Robert Martinson xem xét các chương trình phục hồi và kết luận "không gì hiệu quả" — thúc đẩy sự chuyển đổi trừng phạt trong tư pháp hình sự. Tuy nhiên, nghiên cứu sau đó chứng minh rằng các chương trình có cấu trúc giảm đáng kể tái phạm.',
   '{"variant": "tip"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'criminology-basics'),
   'multiple_choice', 'easy',
   'Classical criminology argues that criminal behavior is best explained by:',
   'Tội phạm học cổ điển lập luận rằng hành vi tội phạm được giải thích tốt nhất bởi:',
   'B',
   'Classical criminology (Beccaria, Bentham) argues that people are rational actors who weigh the costs and benefits of their actions. Crime occurs when anticipated benefits exceed expected costs (punishment). Deterrence reduces crime by increasing perceived costs.',
   'Tội phạm học cổ điển (Beccaria, Bentham) lập luận rằng mọi người là những tác nhân hợp lý cân nhắc chi phí và lợi ích của hành động. Tội phạm xảy ra khi lợi ích dự kiến vượt quá chi phí (hình phạt).', 1),
  ((SELECT id FROM lesson WHERE slug = 'criminology-basics'),
   'true_false', 'easy',
   'According to Merton''s strain theory, crime rates tend to be highest among those who lack access to legitimate means to achieve socially valued goals.',
   'Theo lý thuyết căng thẳng của Merton, tỷ lệ tội phạm có xu hướng cao nhất ở những người thiếu khả năng tiếp cận các phương tiện hợp pháp để đạt được các mục tiêu có giá trị xã hội.',
   'true',
   'Merton argued that lower-class individuals face the greatest strain because they share cultural goals (e.g., the American Dream) but have less access to legitimate means (education, employment). "Innovation" — using illegal means to achieve legitimate goals — is one adaptation.',
   'Merton lập luận rằng tầng lớp thấp hơn đối mặt với căng thẳng lớn nhất vì họ chia sẻ các mục tiêu văn hóa nhưng có ít khả năng tiếp cận các phương tiện hợp pháp hơn (giáo dục, việc làm).', 2),
  ((SELECT id FROM lesson WHERE slug = 'criminology-basics'),
   'fill_blank', 'easy',
   'Howard Becker''s _____ theory argues that deviance is not a quality of the act itself, but a consequence of the social rules and sanctions applied by others.',
   'Lý thuyết _____ của Howard Becker lập luận rằng sự lệch lạc không phải là phẩm chất của hành động mà là hệ quả của các quy tắc và chế tài xã hội được áp dụng bởi người khác.',
   'labeling',
   'Labeling theory (Becker, 1963) argues that "deviant" is not an inherent property of behavior but a label applied by those with power to define rules. Once labeled, individuals may adopt a deviant identity (secondary deviance) and face stigma.',
   'Lý thuyết gán nhãn (Becker, 1963) lập luận rằng "lệch lạc" không phải là thuộc tính cố hữu của hành vi mà là nhãn được áp dụng bởi những người có quyền lực để định nghĩa các quy tắc.', 3),
  ((SELECT id FROM lesson WHERE slug = 'criminology-basics'),
   'multiple_choice', 'medium',
   'In Merton''s typology of adaptation, an "innovator" is someone who:',
   'Trong phân loại cách thích nghi của Merton, một "người đổi mới" là người:',
   'B',
   'Merton''s "innovator" accepts the cultural goal (e.g., financial success) but rejects legitimate means and adopts illegitimate ones (e.g., theft, drug dealing). This is the adaptation most associated with conventional crime.',
   '"Người đổi mới" của Merton chấp nhận mục tiêu văn hóa (ví dụ: thành công tài chính) nhưng từ chối các phương tiện hợp pháp và áp dụng các phương tiện bất hợp pháp (ví dụ: trộm cắp, buôn bán ma túy).', 4),
  ((SELECT id FROM lesson WHERE slug = 'criminology-basics'),
   'error_correction', 'medium',
   'Correct this statement: "Positivist criminology argues that criminals freely choose to commit crimes based on rational calculation of benefits versus risks."',
   'Sửa câu này: "Tội phạm học thực chứng lập luận rằng tội phạm tự do lựa chọn phạm tội dựa trên tính toán hợp lý về lợi ích so với rủi ro."',
   'This describes classical criminology. Positivist criminology argues that criminal behavior is determined by factors beyond individual free choice — including biological, psychological, and social/environmental factors.',
   'The statement describes classical (rational choice) criminology, not positivism. Positivist criminology searches for deterministic causes — Lombroso looked at biological factors; later positivists examined social environment and psychological conditions.',
   'Điều này mô tả tội phạm học cổ điển. Tội phạm học thực chứng lập luận rằng hành vi tội phạm được xác định bởi các yếu tố ngoài sự lựa chọn tự do — bao gồm các yếu tố sinh học, tâm lý và xã hội/môi trường.', 5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'criminology-basics') AND order_index = 1),
   'A', 'Biological defects that predispose certain individuals to criminal behavior', 'Khiếm khuyết sinh học khiến một số cá nhân dễ có hành vi tội phạm'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'criminology-basics') AND order_index = 1),
   'B', 'Rational choice — offenders weigh costs and benefits before acting', 'Lựa chọn hợp lý — người phạm tội cân nhắc chi phí và lợi ích trước khi hành động'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'criminology-basics') AND order_index = 1),
   'C', 'Social inequality and lack of access to legitimate opportunities', 'Bất bình đẳng xã hội và thiếu khả năng tiếp cận các cơ hội hợp pháp'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'criminology-basics') AND order_index = 1),
   'D', 'Childhood trauma and early adverse experiences', 'Chấn thương thời thơ ấu và những trải nghiệm bất lợi sớm'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'criminology-basics') AND order_index = 4),
   'A', 'Accepts both the cultural goals and the legitimate means to achieve them', 'Chấp nhận cả mục tiêu văn hóa và các phương tiện hợp pháp để đạt được chúng'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'criminology-basics') AND order_index = 4),
   'B', 'Accepts cultural goals but rejects legitimate means, using illegitimate methods instead', 'Chấp nhận mục tiêu văn hóa nhưng từ chối phương tiện hợp pháp, thay vào đó sử dụng phương pháp bất hợp pháp'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'criminology-basics') AND order_index = 4),
   'C', 'Rejects cultural goals but follows conventional behavior through legitimate means', 'Từ chối mục tiêu văn hóa nhưng theo đuổi hành vi thông thường qua các phương tiện hợp pháp'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'criminology-basics') AND order_index = 4),
   'D', 'Rejects both cultural goals and legitimate means, withdrawing from society', 'Từ chối cả mục tiêu văn hóa và phương tiện hợp pháp, rút khỏi xã hội');


-- ============================================================
-- LESSON 6: Forensic Science Intro (Criminology & Forensics)
-- ============================================================
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Introduction to Forensic Science', 'Nhập Môn Khoa Học Pháp Y',
  'forensic-science-intro',
  'Discover how forensic science uses physical, biological, and digital evidence to reconstruct crimes.',
  'Khám phá cách khoa học pháp y sử dụng bằng chứng vật lý, sinh học và kỹ thuật số để tái hiện tội phạm.',
  'beginner', 40, 2
FROM category WHERE name = 'Criminology & Forensics';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'forensic-science-intro'),
   'Apply Locard''s Exchange Principle', 'Áp dụng Nguyên Lý Trao Đổi Locard',
   'Explain why every crime scene contact leaves trace evidence on both parties.',
   'Giải thích tại sao mọi sự tiếp xúc tại hiện trường đều để lại bằng chứng dấu vết trên cả hai bên.', 1),
  ((SELECT id FROM lesson WHERE slug = 'forensic-science-intro'),
   'Classify forensic evidence types', 'Phân loại các loại bằng chứng pháp y',
   'Distinguish physical, biological, and digital evidence and explain their collection procedures.',
   'Phân biệt bằng chứng vật lý, sinh học và kỹ thuật số và giải thích các thủ tục thu thập của chúng.', 2),
  ((SELECT id FROM lesson WHERE slug = 'forensic-science-intro'),
   'Maintain chain of custody', 'Duy trì chuỗi giám sát bằng chứng',
   'Explain why documented chain of custody is essential for evidence admissibility in court.',
   'Giải thích tại sao chuỗi giám sát được ghi chép là điều cần thiết để bằng chứng được chấp nhận tại tòa án.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'forensic-science-intro'),
   'markdown', 'Forensic Science Fundamentals', 'Các Nền Tảng Khoa Học Pháp Y',
   E'## Locard''s Exchange Principle\n\nEdmond Locard (1910): **"Every contact leaves a trace."** Whenever two objects come into contact, material is transferred between them. This is the foundational principle of trace evidence.\n\n- Perpetrators leave traces at the scene (hair, fibers, fingerprints, DNA)\n- Perpetrators take traces from the scene (soil, pollen, glass fragments)\n\n## Types of Forensic Evidence\n\n| Type | Examples | Analysis Method |\n|---|---|---|\n| **Physical** | Fingerprints, footwear impressions, tool marks | Pattern comparison |\n| **Biological** | Blood, saliva, hair (with root), semen | DNA profiling |\n| **Trace** | Fibers, glass, gunshot residue, soil | Microscopy, spectroscopy |\n| **Digital** | Metadata, logs, encrypted files | Digital forensics |\n| **Document** | Handwriting, altered documents | Questioned document examination |\n\n## Fingerprint Classification\n\nFrancis Galton''s system (1892) classifies fingerprints into three pattern types:\n- **Loops** (~65% of people) — ridges enter and exit from the same side\n- **Whorls** (~30%) — circular or spiral ridges\n- **Arches** (~5%) — ridges enter one side and exit the other\n\n## DNA Profiling\n\nDNA profiling compares **Short Tandem Repeats (STRs)** — specific repetitive sequences at known genomic loci. The probability of two unrelated individuals sharing the same STR profile is astronomically small (1 in quadrillions).\n\n## Chain of Custody\n\nThe **chain of custody** is the documented, unbroken chronological record of:\n- Who collected the evidence\n- How it was stored and transferred\n- Who had access at each stage\n\nBreaks in chain of custody can render evidence inadmissible in court.',
   E'## Nguyên Lý Trao Đổi Locard\n\nEdmond Locard (1910): **"Mọi sự tiếp xúc đều để lại dấu vết."** Khi hai vật thể tiếp xúc, vật liệu được chuyển giao giữa chúng. Đây là nguyên lý nền tảng của bằng chứng dấu vết.\n\n- Thủ phạm để lại dấu vết tại hiện trường (tóc, sợi, dấu vân tay, DNA)\n- Thủ phạm mang dấu vết từ hiện trường (đất, phấn hoa, mảnh kính)\n\n## Các Loại Bằng Chứng Pháp Y\n\n- **Vật lý**: Dấu vân tay, dấu giày, vết dụng cụ — so sánh mẫu\n- **Sinh học**: Máu, nước bọt, tóc (có gốc), tinh dịch — phân tích DNA\n- **Dấu vết**: Sợi vải, kính, cặn súng, đất — kính hiển vi, quang phổ\n- **Kỹ thuật số**: Metadata, nhật ký, file mã hóa — pháp y kỹ thuật số\n\n## Phân Loại Dấu Vân Tay\n\nHệ thống Galton (1892) phân loại dấu vân tay thành ba loại:\n- **Vòng lặp (Loops)**: ~65% người\n- **Xoáy (Whorls)**: ~30%\n- **Vòm (Arches)**: ~5%\n\n## Phân Tích DNA\n\nSo sánh **Short Tandem Repeats (STRs)** — các chuỗi lặp ngắn tại các locus bộ gen đã biết. Xác suất hai cá nhân không liên quan có cùng hồ sơ STR là cực kỳ nhỏ.\n\n## Chuỗi Giám Sát Bằng Chứng\n\nHồ sơ thời gian học liên tục về ai thu thập, cách lưu trữ và chuyển giao, ai có quyền truy cập. Gián đoạn chuỗi có thể khiến bằng chứng không được chấp nhận tại tòa án.',
   '{}', 1),
  ((SELECT id FROM lesson WHERE slug = 'forensic-science-intro'),
   'key_points', 'Core Concepts', 'Khái Niệm Cốt Lõi',
   E'- **Locard''s Exchange Principle**: every contact leaves a trace — perpetrators both deposit and remove material from crime scenes\n- **Fingerprint patterns**: three types — loops (~65%), whorls (~30%), arches (~5%); no two fingerprints are identical\n- **DNA profiling**: compares STR (Short Tandem Repeat) profiles at specific genomic loci; extremely discriminating\n- **Chain of custody**: documented record of evidence collection, storage, and transfer — breaks render evidence inadmissible\n- **Forensic evidence types**: physical, biological, trace, digital, document — each requires specific collection and analysis protocols',
   E'- **Nguyên lý trao đổi Locard**: mọi sự tiếp xúc đều để lại dấu vết — thủ phạm cả gửi và lấy vật liệu từ hiện trường tội phạm\n- **Mẫu vân tay**: ba loại — vòng lặp (~65%), xoáy (~30%), vòm (~5%); không có hai dấu vân tay nào giống hệt nhau\n- **Phân tích DNA**: so sánh hồ sơ STR tại các locus bộ gen cụ thể; cực kỳ phân biệt\n- **Chuỗi giám sát**: hồ sơ thu thập, lưu trữ và chuyển giao bằng chứng — gián đoạn khiến bằng chứng không được chấp nhận\n- **Các loại bằng chứng pháp y**: vật lý, sinh học, dấu vết, kỹ thuật số, tài liệu — mỗi loại yêu cầu các quy trình thu thập và phân tích cụ thể',
   '{}', 2),
  ((SELECT id FROM lesson WHERE slug = 'forensic-science-intro'),
   'info_box', 'The Innocence Project', 'Dự Án Innocence',
   'Founded in 1992, the Innocence Project uses DNA evidence to exonerate wrongfully convicted individuals. As of 2024, DNA has exonerated over 375 people in the US, including 21 who served time on death row — demonstrating both the power and limitations of forensic evidence.',
   'Thành lập năm 1992, Dự án Innocence sử dụng bằng chứng DNA để minh oan cho những người bị kết án oan. Tính đến năm 2024, DNA đã minh oan cho hơn 375 người ở Mỹ, trong đó có 21 người đã chờ tử hình.',
   '{"variant": "tip"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'forensic-science-intro'),
   'multiple_choice', 'easy',
   'Locard''s Exchange Principle states that:',
   'Nguyên lý trao đổi Locard phát biểu rằng:',
   'B',
   'Locard''s principle holds that every contact between two surfaces results in a mutual transfer of material — the perpetrator leaves traces at the scene and takes traces away. This underlies all trace evidence analysis in forensic science.',
   'Nguyên lý Locard cho rằng mọi sự tiếp xúc giữa hai bề mặt đều dẫn đến sự chuyển giao vật liệu lẫn nhau — thủ phạm để lại dấu vết tại hiện trường và mang dấu vết đi. Đây là cơ sở của tất cả phân tích bằng chứng dấu vết.', 1),
  ((SELECT id FROM lesson WHERE slug = 'forensic-science-intro'),
   'true_false', 'easy',
   'Fingerprints are classified into three main pattern types: loops, whorls, and arches.',
   'Dấu vân tay được phân loại thành ba loại mẫu chính: vòng lặp, xoáy và vòm.',
   'true',
   'Francis Galton''s classification system (1892) identifies three fundamental fingerprint patterns: loops (~65% of the population), whorls (~30%), and arches (~5%). Every fingerprint is unique, and no two individuals share the same print.',
   'Hệ thống phân loại của Galton (1892) xác định ba mẫu dấu vân tay cơ bản: vòng lặp (~65%), xoáy (~30%) và vòm (~5%). Mỗi dấu vân tay là duy nhất.', 2),
  ((SELECT id FROM lesson WHERE slug = 'forensic-science-intro'),
   'fill_blank', 'easy',
   'The documented chronological record that tracks evidence from crime scene collection through laboratory analysis and court presentation is called _____ of custody.',
   'Hồ sơ thời gian học liên tục ghi chép bằng chứng từ thu thập tại hiện trường qua phân tích phòng thí nghiệm đến trình bày tại tòa án được gọi là _____ giám sát bằng chứng.',
   'chain',
   'The chain of custody documents every person who has handled the evidence, when, and why. Gaps or breaks in this chain can cause evidence to be ruled inadmissible, as there is no way to verify the evidence has not been tampered with.',
   'Chuỗi giám sát ghi lại mọi người đã xử lý bằng chứng, khi nào và tại sao. Sự gián đoạn trong chuỗi này có thể khiến bằng chứng bị bác bỏ vì không thể xác minh bằng chứng chưa bị can thiệp.', 3),
  ((SELECT id FROM lesson WHERE slug = 'forensic-science-intro'),
   'multiple_choice', 'medium',
   'DNA profiling for forensic identification uses which type of genetic sequences?',
   'Phân tích DNA để nhận dạng pháp y sử dụng loại trình tự di truyền nào?',
   'C',
   'Forensic DNA profiling compares Short Tandem Repeats (STRs) — short repetitive sequences at specific locations in the genome. STR profiles are highly variable between individuals (except identical twins), making them excellent identifiers.',
   'Phân tích DNA pháp y so sánh Short Tandem Repeats (STRs) — các chuỗi lặp ngắn tại các vị trí cụ thể trong bộ gen. Hồ sơ STR rất biến đổi giữa các cá nhân, làm cho chúng trở thành công cụ nhận dạng xuất sắc.', 4),
  ((SELECT id FROM lesson WHERE slug = 'forensic-science-intro'),
   'error_correction', 'medium',
   'Correct this statement: "Forensic DNA evidence can always definitively prove a suspect was the perpetrator of a crime."',
   'Sửa câu này: "Bằng chứng DNA pháp y luôn có thể chứng minh dứt khoát rằng nghi phạm là thủ phạm của một tội phạm."',
   'DNA evidence establishes that biological material from a person was present at a scene, not that they committed a crime. Contamination, secondary transfer, and mixed samples can complicate interpretation.',
   'DNA evidence has limitations: it proves presence of biological material, not criminal act. Contamination (lab or scene), secondary transfer (innocent contact), and mixed DNA profiles can create false impressions. Statistical probability must be carefully communicated to juries.',
   'Bằng chứng DNA có giới hạn: nó chứng minh sự hiện diện của vật liệu sinh học, không phải hành vi phạm tội. Ô nhiễm, chuyển giao thứ cấp và hồ sơ DNA hỗn hợp có thể tạo ra ấn tượng sai lầm.', 5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'forensic-science-intro') AND order_index = 1),
   'A', 'Criminals always leave visible evidence at crime scenes that can be photographed', 'Tội phạm luôn để lại bằng chứng hiển thị tại hiện trường có thể chụp ảnh'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'forensic-science-intro') AND order_index = 1),
   'B', 'Every contact between two objects leaves a trace on both', 'Mọi sự tiếp xúc giữa hai vật thể đều để lại dấu vết trên cả hai'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'forensic-science-intro') AND order_index = 1),
   'C', 'Physical evidence is always more reliable than eyewitness testimony', 'Bằng chứng vật lý luôn đáng tin cậy hơn lời khai nhân chứng'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'forensic-science-intro') AND order_index = 1),
   'D', 'DNA evidence is sufficient on its own to secure a criminal conviction', 'Bằng chứng DNA đủ để tự mình bảo đảm kết án hình sự'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'forensic-science-intro') AND order_index = 4),
   'A', 'Full genome sequencing comparing entire DNA sequences', 'Giải trình tự toàn bộ bộ gen so sánh toàn bộ chuỗi DNA'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'forensic-science-intro') AND order_index = 4),
   'B', 'Mitochondrial DNA sequences inherited from the mother only', 'Chuỗi DNA ty thể được thừa hưởng chỉ từ mẹ'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'forensic-science-intro') AND order_index = 4),
   'C', 'Short Tandem Repeats (STRs) at specific genomic loci', 'Short Tandem Repeats (STRs) tại các locus bộ gen cụ thể'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'forensic-science-intro') AND order_index = 4),
   'D', 'Single nucleotide polymorphisms (SNPs) across the genome', 'Đa hình nucleotide đơn (SNPs) trên toàn bộ bộ gen');


-- ============================================================
-- LESSON 7: Learning Theories (Pedagogy)
-- ============================================================
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Learning Theories', 'Các Lý Thuyết Học Tập',
  'learning-theories',
  'Compare behaviorism, cognitivism, and constructivism — the three major frameworks that explain how humans learn.',
  'So sánh thuyết hành vi, thuyết nhận thức và thuyết kiến tạo — ba khung lý thuyết chính giải thích cách con người học.',
  'beginner', 50, 1
FROM category WHERE name = 'Pedagogy';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'learning-theories'),
   'Compare major learning theories', 'So sánh các lý thuyết học tập chính',
   'Distinguish behaviorism, cognitivism, constructivism, and social learning theory by their assumptions and methods.',
   'Phân biệt thuyết hành vi, nhận thức, kiến tạo và học tập xã hội qua các giả định và phương pháp của chúng.', 1),
  ((SELECT id FROM lesson WHERE slug = 'learning-theories'),
   'Apply Vygotsky''s ZPD', 'Áp dụng Vùng Phát Triển Gần Nhất của Vygotsky',
   'Design learning activities that operate within the Zone of Proximal Development.',
   'Thiết kế các hoạt động học tập trong Vùng Phát Triển Gần Nhất.', 2),
  ((SELECT id FROM lesson WHERE slug = 'learning-theories'),
   'Apply Bloom''s Taxonomy', 'Áp dụng Thang Đo Bloom',
   'Write learning objectives at different cognitive levels from remembering to creating.',
   'Viết mục tiêu học tập ở các cấp độ nhận thức khác nhau từ ghi nhớ đến sáng tạo.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'learning-theories'),
   'markdown', 'How Humans Learn: Major Theories', 'Con Người Học Như Thế Nào: Các Lý Thuyết Chính',
   E'## Behaviorism\n\nFocuses exclusively on **observable behavior** — rejects internal mental states as unmeasurable.\n\n**Classical conditioning** (Ivan Pavlov, 1890s): Neutral stimulus becomes associated with unconditioned stimulus to produce a learned response. (Dog salivates at bell sound.)\n\n**Operant conditioning** (B.F. Skinner, 1938): Behavior is shaped by its **consequences**.\n- **Positive reinforcement**: add reward → behavior increases\n- **Negative reinforcement**: remove aversive stimulus → behavior increases\n- **Punishment**: add aversive or remove reward → behavior decreases\n\n## Cognitivism\n\nFocuses on **internal mental processes** — memory, attention, thinking, and problem-solving.\n\n**Piaget''s stages of cognitive development:**\n\n| Stage | Age | Characteristic |\n|---|---|---|\n| Sensorimotor | 0–2 | Object permanence |\n| Preoperational | 2–7 | Symbolic thinking, egocentric |\n| Concrete operational | 7–11 | Logical thinking about concrete objects |\n| Formal operational | 12+ | Abstract reasoning, hypothetical thinking |\n\n## Constructivism (Vygotsky)\n\nLearners **actively construct** knowledge through experience and social interaction.\n\n**Zone of Proximal Development (ZPD)**: The gap between what a learner can do independently and what they can do with guidance from a more capable peer or teacher.\n\n**Scaffolding**: Temporary support that helps learners operate within the ZPD, gradually removed as competence grows.\n\n## Social Learning Theory (Bandura)\n\n**Albert Bandura** (1977): Learning occurs through **observation, imitation, and modeling**. Four processes:\n1. **Attention**: notice the model\n2. **Retention**: remember the behavior\n3. **Reproduction**: physically reproduce the behavior\n4. **Motivation**: have incentive to repeat it\n\n## Bloom''s Taxonomy (Revised)\n\nCognitive learning objectives, from lower to higher order:\n**Remember → Understand → Apply → Analyze → Evaluate → Create**',
   E'## Thuyết Hành Vi (Behaviorism)\n\nTập trung vào **hành vi có thể quan sát** — từ chối các trạng thái tinh thần bên trong là không thể đo lường.\n\n**Điều kiện hóa cổ điển** (Pavlov): Kích thích trung tính trở nên liên kết với kích thích không điều kiện để tạo ra phản ứng học được.\n\n**Điều kiện hóa hành động** (Skinner): Hành vi được định hình bởi **hậu quả**.\n- **Củng cố tích cực**: thêm phần thưởng → hành vi tăng\n- **Củng cố tiêu cực**: loại bỏ kích thích ác → hành vi tăng\n- **Hình phạt**: thêm ác hoặc loại bỏ phần thưởng → hành vi giảm\n\n## Thuyết Nhận Thức (Cognitivism)\n\nTập trung vào **các quá trình tinh thần bên trong** — bộ nhớ, sự chú ý, suy nghĩ.\n\n**Các giai đoạn phát triển nhận thức của Piaget:**\n- Cảm giác-vận động (0–2): vật thể vẫn tồn tại khi khuất tầm mắt\n- Tiền thao tác (2–7): tư duy biểu tượng, tự trung tâm\n- Thao tác cụ thể (7–11): tư duy logic về vật cụ thể\n- Thao tác hình thức (12+): lý luận trừu tượng\n\n## Thuyết Kiến Tạo (Vygotsky)\n\n**Vùng Phát Triển Gần Nhất (ZPD)**: Khoảng cách giữa những gì học sinh có thể làm độc lập và những gì họ có thể làm với sự hướng dẫn.\n\n**Scaffolding**: Hỗ trợ tạm thời giúp học sinh hoạt động trong ZPD.\n\n## Lý Thuyết Học Xã Hội (Bandura)\n\nHọc thông qua **quan sát, bắt chước và làm gương**.\n\n## Thang Đo Bloom (Revised)\n\n**Ghi nhớ → Hiểu → Áp dụng → Phân tích → Đánh giá → Sáng tạo**',
   '{}', 1),
  ((SELECT id FROM lesson WHERE slug = 'learning-theories'),
   'key_points', 'Core Concepts', 'Khái Niệm Cốt Lõi',
   E'- **Behaviorism** (Pavlov, Skinner): focuses on observable behavior shaped by consequences; rejects internal mental states; used in behavior modification, token economies\n- **Cognitivism** (Piaget): learning involves internal mental processes; four developmental stages; learning must match cognitive readiness\n- **Constructivism** (Vygotsky): learners actively build knowledge; ZPD = gap between independent and guided performance; scaffolding provides temporary support\n- **Social learning** (Bandura): observational learning through attention, retention, reproduction, motivation; self-efficacy beliefs predict achievement\n- **Bloom''s Taxonomy**: six hierarchical cognitive levels — Remember, Understand, Apply, Analyze, Evaluate, Create; informs lesson objective writing',
   E'- **Thuyết hành vi** (Pavlov, Skinner): tập trung vào hành vi có thể quan sát được định hình bởi hậu quả; từ chối trạng thái tinh thần bên trong\n- **Thuyết nhận thức** (Piaget): học tập liên quan đến các quá trình tinh thần bên trong; bốn giai đoạn phát triển; học tập phải phù hợp với sự sẵn sàng nhận thức\n- **Thuyết kiến tạo** (Vygotsky): người học tích cực xây dựng kiến thức; ZPD = khoảng cách giữa hiệu suất độc lập và có hướng dẫn\n- **Học tập xã hội** (Bandura): học quan sát qua chú ý, lưu giữ, tái tạo, động lực; niềm tin tự hiệu quả dự đoán thành tích\n- **Thang đo Bloom**: sáu cấp độ nhận thức — Ghi nhớ, Hiểu, Áp dụng, Phân tích, Đánh giá, Sáng tạo',
   '{}', 2),
  ((SELECT id FROM lesson WHERE slug = 'learning-theories'),
   'info_box', 'Bloom''s Taxonomy in Practice', 'Thang Đo Bloom trong Thực Tiễn',
   'Bloom''s Taxonomy (1956, revised 2001) guides lesson design. Lower-order objectives (Remember, Understand) build foundations; higher-order (Analyze, Evaluate, Create) develop critical thinking. A well-designed lesson progresses through levels — e.g., memorize a formula (Remember) → solve problems (Apply) → design a solution (Create).',
   'Thang đo Bloom (1956, sửa đổi 2001) hướng dẫn thiết kế bài học. Mục tiêu bậc thấp (Ghi nhớ, Hiểu) xây dựng nền tảng; bậc cao (Phân tích, Đánh giá, Sáng tạo) phát triển tư duy phê phán.',
   '{"variant": "tip"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'learning-theories'),
   'multiple_choice', 'easy',
   'B.F. Skinner''s operant conditioning theory is based on:',
   'Lý thuyết điều kiện hóa hành động của B.F. Skinner dựa trên:',
   'B',
   'Operant conditioning holds that behavior is shaped by its consequences — reinforcement increases behavior and punishment decreases it. Skinner''s "Skinner box" experiments demonstrated that animals could be trained to perform complex behaviors through systematic reinforcement schedules.',
   'Điều kiện hóa hành động cho rằng hành vi được định hình bởi hậu quả — củng cố tăng hành vi và hình phạt giảm hành vi. Các thí nghiệm "hộp Skinner" chứng minh động vật có thể được huấn luyện thực hiện các hành vi phức tạp.', 1),
  ((SELECT id FROM lesson WHERE slug = 'learning-theories'),
   'true_false', 'easy',
   'Vygotsky''s Zone of Proximal Development (ZPD) refers to tasks that a learner can complete entirely independently without any assistance.',
   'Vùng Phát Triển Gần Nhất (ZPD) của Vygotsky đề cập đến các nhiệm vụ mà người học có thể hoàn thành hoàn toàn độc lập mà không cần bất kỳ sự hỗ trợ nào.',
   'false',
   'The ZPD is the gap between what a learner can do independently and what they can accomplish with guidance from a more capable person. Tasks within the ZPD are achievable with support but not yet mastered independently — that is where learning and growth occur.',
   'ZPD là khoảng cách giữa những gì học sinh có thể làm độc lập và những gì họ có thể hoàn thành với sự hướng dẫn. Các nhiệm vụ trong ZPD có thể đạt được với sự hỗ trợ nhưng chưa thành thạo độc lập — đó là nơi học tập và tăng trưởng xảy ra.', 2),
  ((SELECT id FROM lesson WHERE slug = 'learning-theories'),
   'fill_blank', 'easy',
   'Piaget identified four stages of cognitive development: sensorimotor, preoperational, concrete operational, and _____ operational.',
   'Piaget xác định bốn giai đoạn phát triển nhận thức: cảm giác-vận động, tiền thao tác, thao tác cụ thể và thao tác _____.',
   'formal',
   'The formal operational stage (age 12+) is when adolescents develop the ability to think abstractly, reason hypothetically, and use systematic logic. This includes scientific reasoning, philosophical thinking, and the ability to consider hypothetical scenarios.',
   'Giai đoạn thao tác hình thức (12+) là khi thanh thiếu niên phát triển khả năng tư duy trừu tượng, lý luận giả thuyết và sử dụng logic hệ thống.', 3),
  ((SELECT id FROM lesson WHERE slug = 'learning-theories'),
   'multiple_choice', 'medium',
   'Albert Bandura''s social learning theory emphasizes that learning occurs through:',
   'Lý thuyết học tập xã hội của Albert Bandura nhấn mạnh rằng học tập xảy ra qua:',
   'B',
   'Bandura argued that much learning happens through observing others (models). His Bobo doll experiments (1961) showed children imitated aggressive behavior they observed in adults — even without direct reinforcement. Key addition: self-efficacy (belief in one''s ability) strongly predicts achievement.',
   'Bandura lập luận rằng nhiều học tập xảy ra qua quan sát người khác (người mẫu). Các thí nghiệm búp bê Bobo (1961) cho thấy trẻ em bắt chước hành vi hung hăng họ quan sát ở người lớn.', 4),
  ((SELECT id FROM lesson WHERE slug = 'learning-theories'),
   'error_correction', 'medium',
   'Correct this statement: "Behaviorism focuses on internal mental processes, cognitive structures, and how learners mentally organize information."',
   'Sửa câu này: "Thuyết hành vi tập trung vào các quá trình tinh thần bên trong, cấu trúc nhận thức và cách người học tổ chức thông tin về mặt tinh thần."',
   'This describes cognitivism. Behaviorism focuses exclusively on observable behavior and the role of environmental stimuli and consequences — it explicitly rejects internal mental states as unmeasurable.',
   'The statement describes cognitivism (Piaget, schema theory, information processing). Behaviorism (Watson, Skinner) explicitly rejected internal mental processes as unscientific — only observable stimulus-response connections matter.',
   'Điều này mô tả thuyết nhận thức. Thuyết hành vi tập trung hoàn toàn vào hành vi có thể quan sát và vai trò của các kích thích môi trường và hậu quả — nó từ chối các trạng thái tinh thần bên trong là không thể đo lường.', 5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'learning-theories') AND order_index = 1),
   'A', 'Classical conditioning — associating a neutral stimulus with an unconditioned response', 'Điều kiện hóa cổ điển — liên kết kích thích trung tính với phản ứng không điều kiện'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'learning-theories') AND order_index = 1),
   'B', 'The role of consequences — reinforcement increases behavior, punishment decreases it', 'Vai trò của hậu quả — củng cố tăng hành vi, hình phạt giảm hành vi'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'learning-theories') AND order_index = 1),
   'C', 'Observational learning and imitation of models in social contexts', 'Học quan sát và bắt chước người mẫu trong bối cảnh xã hội'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'learning-theories') AND order_index = 1),
   'D', 'Internal cognitive schemas that organize and interpret new information', 'Các sơ đồ nhận thức bên trong tổ chức và giải thích thông tin mới'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'learning-theories') AND order_index = 4),
   'A', 'Unconscious drives and unresolved psychosexual conflicts', 'Các động lực vô thức và xung đột tâm dục chưa được giải quyết'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'learning-theories') AND order_index = 4),
   'B', 'Observation and imitation of models, requiring attention, retention, reproduction, and motivation', 'Quan sát và bắt chước người mẫu, đòi hỏi sự chú ý, lưu giữ, tái tạo và động lực'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'learning-theories') AND order_index = 4),
   'C', 'Fixed developmental stages that unfold as children mature biologically', 'Các giai đoạn phát triển cố định xuất hiện khi trẻ em trưởng thành về mặt sinh học'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'learning-theories') AND order_index = 4),
   'D', 'Direct reinforcement schedules applied systematically to modify behavior', 'Lịch trình củng cố trực tiếp được áp dụng có hệ thống để thay đổi hành vi');


-- ============================================================
-- LESSON 8: Effective Teaching Methods (Pedagogy)
-- ============================================================
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Effective Teaching Methods', 'Các Phương Pháp Dạy Học Hiệu Quả',
  'effective-teaching-methods',
  'Master research-backed teaching strategies including direct instruction, inquiry-based learning, and formative assessment.',
  'Thành thạo các chiến lược dạy học được nghiên cứu hỗ trợ bao gồm dạy học trực tiếp, học tập dựa trên tìm hiểu và đánh giá hình thành.',
  'intermediate', 45, 2
FROM category WHERE name = 'Pedagogy';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'effective-teaching-methods'),
   'Apply direct instruction', 'Áp dụng dạy học trực tiếp',
   'Structure explicit teaching using the I Do / We Do / You Do gradual release model.',
   'Cấu trúc dạy học tường minh sử dụng mô hình chuyển giao dần dần Tôi Làm / Chúng Ta Làm / Bạn Làm.', 1),
  ((SELECT id FROM lesson WHERE slug = 'effective-teaching-methods'),
   'Design formative assessments', 'Thiết kế đánh giá hình thành',
   'Use ongoing checks for understanding to adjust instruction and guide learning.',
   'Sử dụng kiểm tra hiểu biết liên tục để điều chỉnh giảng dạy và hướng dẫn học tập.', 2),
  ((SELECT id FROM lesson WHERE slug = 'effective-teaching-methods'),
   'Implement cooperative learning', 'Thực hiện học tập hợp tác',
   'Structure group work using the five elements of cooperative learning for genuine interdependence.',
   'Cấu trúc làm việc nhóm sử dụng năm yếu tố học tập hợp tác cho sự phụ thuộc lẫn nhau thực sự.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'effective-teaching-methods'),
   'markdown', 'Research-Based Teaching Strategies', 'Các Chiến Lược Dạy Học Dựa Trên Nghiên Cứu',
   E'## Direct Instruction\n\n**Explicit teaching** with clear modeling and guided practice. The **Gradual Release of Responsibility (GRR)** model:\n\n| Phase | Description |\n|---|---|\n| **I Do** (Modeling) | Teacher demonstrates with think-aloud |\n| **We Do** (Guided Practice) | Teacher + students work together |\n| **You Do** (Independent Practice) | Students apply independently |\n\nResearch (Rosenshine, 2012) shows direct instruction is highly effective for teaching procedural knowledge and foundational skills.\n\n## Inquiry-Based Learning\n\nStudents **investigate questions**, problems, or scenarios. Teacher guides rather than tells. Models:\n- **Structured**: teacher provides question and procedure\n- **Guided**: teacher provides question; students design procedure\n- **Open**: students generate question and procedure\n\n## Cooperative Learning (Johnson & Johnson)\n\nFive essential elements:\n1. **Positive interdependence** — group sinks or swims together\n2. **Individual accountability** — each member responsible for their contribution\n3. **Promotive interaction** — members actively help each other\n4. **Social skills** — taught and practiced explicitly\n5. **Group processing** — reflect on team effectiveness\n\n## Differentiated Instruction\n\nAdjusting **content, process, product, and environment** based on student readiness, interest, and learning profile (Tomlinson, 1999).\n\n## Formative vs. Summative Assessment\n\n| Type | When | Purpose | Example |\n|---|---|---|---|\n| **Formative** | During instruction | Monitor and adjust | Exit tickets, quick polls |\n| **Summative** | End of unit/course | Measure achievement | Final exam, portfolio |\n\n**Dylan Wiliam**: "Formative assessment is the bridge between teaching and learning." Effective formative assessment closes the gap between where students are and where they need to be.',
   E'## Dạy Học Trực Tiếp\n\n**Dạy học tường minh** với mô hình rõ ràng và thực hành có hướng dẫn. Mô hình **Chuyển Giao Trách Nhiệm Dần Dần (GRR)**:\n\n- **Tôi Làm (Modeling)**: Giáo viên trình diễn với tư duy lớn tiếng\n- **Chúng Ta Làm (Guided Practice)**: Giáo viên + học sinh cùng làm việc\n- **Bạn Làm (Independent Practice)**: Học sinh áp dụng độc lập\n\nNghiên cứu (Rosenshine, 2012) cho thấy dạy học trực tiếp rất hiệu quả để dạy kiến thức thủ tục và kỹ năng nền tảng.\n\n## Học Tập Dựa Trên Tìm Hiểu\n\nHọc sinh **điều tra câu hỏi**, vấn đề hoặc tình huống. Giáo viên hướng dẫn thay vì kể.\n\n## Học Tập Hợp Tác (Johnson & Johnson)\n\nNăm yếu tố thiết yếu:\n1. **Phụ thuộc tích cực**: nhóm cùng chìm hoặc nổi\n2. **Trách nhiệm cá nhân**: mỗi thành viên chịu trách nhiệm về đóng góp của mình\n3. **Tương tác thúc đẩy**: thành viên tích cực giúp đỡ nhau\n4. **Kỹ năng xã hội**: được dạy và thực hành rõ ràng\n5. **Xử lý nhóm**: phản ánh về hiệu quả nhóm\n\n## Dạy Học Phân Hóa\n\nĐiều chỉnh **nội dung, quy trình, sản phẩm và môi trường** dựa trên sự sẵn sàng, sở thích và hồ sơ học tập của học sinh.\n\n## Đánh Giá Hình Thành vs. Tổng Kết\n\n- **Hình thành**: trong khi giảng dạy, giám sát và điều chỉnh\n- **Tổng kết**: cuối đơn vị/khóa học, đo lường thành tích',
   '{}', 1),
  ((SELECT id FROM lesson WHERE slug = 'effective-teaching-methods'),
   'key_points', 'Core Concepts', 'Khái Niệm Cốt Lõi',
   E'- **Direct instruction** (I Do / We Do / You Do): evidence-based for foundational skills; gradually transfers responsibility from teacher to student\n- **Formative assessment**: ongoing checks during instruction to adjust teaching — exit tickets, think-pair-share, mini whiteboards\n- **Summative assessment**: end-point measurement of achievement — exams, portfolios, projects\n- **Cooperative learning** (Johnson & Johnson): requires 5 elements — positive interdependence, individual accountability, promotive interaction, social skills, group processing\n- **Differentiated instruction** (Tomlinson): adjusting content, process, product, and environment — not just giving advanced students more work',
   E'- **Dạy học trực tiếp** (Tôi/Chúng Ta/Bạn Làm): dựa trên bằng chứng cho kỹ năng nền tảng; dần dần chuyển trách nhiệm từ giáo viên sang học sinh\n- **Đánh giá hình thành**: kiểm tra liên tục trong khi giảng dạy để điều chỉnh — phiếu thoát, chia sẻ theo cặp, bảng trắng nhỏ\n- **Đánh giá tổng kết**: đo lường thành tích cuối điểm — kỳ thi, portfolio, dự án\n- **Học tập hợp tác** (Johnson & Johnson): cần 5 yếu tố — phụ thuộc tích cực, trách nhiệm cá nhân, tương tác thúc đẩy, kỹ năng xã hội, xử lý nhóm\n- **Dạy học phân hóa** (Tomlinson): điều chỉnh nội dung, quy trình, sản phẩm, môi trường — không chỉ giao thêm bài cho học sinh giỏi',
   '{}', 2),
  ((SELECT id FROM lesson WHERE slug = 'effective-teaching-methods'),
   'info_box', 'Hattie''s Visible Learning Meta-Analysis', 'Phân Tích Meta Visible Learning của Hattie',
   'John Hattie synthesized 800+ meta-analyses covering 250 million students to rank educational interventions by effect size. Top effects: feedback (d=0.73), formative assessment, peer tutoring, and direct instruction. Lowest effects: learning styles matching, retention (holding students back), and purely discovery learning.',
   'John Hattie tổng hợp 800+ phân tích meta bao gồm 250 triệu học sinh để xếp hạng các can thiệp giáo dục theo kích thước hiệu ứng. Hiệu ứng cao nhất: phản hồi, đánh giá hình thành, hướng dẫn đồng đẳng và dạy học trực tiếp.',
   '{"variant": "tip"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
  ((SELECT id FROM lesson WHERE slug = 'effective-teaching-methods'),
   'multiple_choice', 'easy',
   'Formative assessment is best described as:',
   'Đánh giá hình thành được mô tả tốt nhất là:',
   'B',
   'Formative assessment is ongoing assessment conducted during the learning process — not at the end — to monitor student progress and adjust instruction accordingly. Examples include exit tickets, think-pair-share, and quick polls. It is distinct from summative assessment, which measures achievement after learning.',
   'Đánh giá hình thành là đánh giá liên tục trong quá trình học tập để theo dõi tiến độ học sinh và điều chỉnh giảng dạy. Ví dụ: phiếu thoát, chia sẻ theo cặp, thăm dò nhanh. Nó khác biệt với đánh giá tổng kết đo lường thành tích sau khi học.', 1),
  ((SELECT id FROM lesson WHERE slug = 'effective-teaching-methods'),
   'true_false', 'easy',
   'In cooperative learning, individual accountability is not important because only the group outcome matters — as long as the group produces a good result, all members benefit equally.',
   'Trong học tập hợp tác, trách nhiệm cá nhân không quan trọng vì chỉ kết quả nhóm mới quan trọng — miễn là nhóm đạt kết quả tốt, tất cả thành viên đều được hưởng lợi bình đẳng.',
   'false',
   'Individual accountability is one of Johnson & Johnson''s five essential elements. Without it, "social loafing" occurs — some members contribute little while benefiting from others'' work. True cooperative learning requires each member to be responsible for their individual contribution AND the group outcome.',
   'Trách nhiệm cá nhân là một trong năm yếu tố thiết yếu của Johnson & Johnson. Không có nó, "lười nhác xã hội" xảy ra — một số thành viên đóng góp ít trong khi hưởng lợi từ công việc của người khác.', 2),
  ((SELECT id FROM lesson WHERE slug = 'effective-teaching-methods'),
   'fill_blank', 'easy',
   'Benjamin Bloom''s _____, revised in 2001, classifies cognitive learning objectives from lower-order (remember, understand) to higher-order (analyze, evaluate, create).',
   'Bảng phân loại _____ của Benjamin Bloom, được sửa đổi năm 2001, phân loại mục tiêu học tập nhận thức từ bậc thấp (ghi nhớ, hiểu) đến bậc cao (phân tích, đánh giá, sáng tạo).',
   'Taxonomy',
   'Bloom''s Taxonomy provides a hierarchical framework for writing learning objectives. The revised version (2001) changed the sixth level from "Synthesis" to "Create" and converted noun labels to verbs. It guides teachers to design assessments and activities across all cognitive levels.',
   'Thang đo Bloom cung cấp khung phân cấp để viết mục tiêu học tập. Phiên bản sửa đổi (2001) chuyển đổi nhãn danh từ thành động từ. Nó hướng dẫn giáo viên thiết kế đánh giá và hoạt động ở tất cả các cấp độ nhận thức.', 3),
  ((SELECT id FROM lesson WHERE slug = 'effective-teaching-methods'),
   'multiple_choice', 'medium',
   'Differentiated instruction involves:',
   'Dạy học phân hóa bao gồm:',
   'B',
   'Differentiated instruction (Tomlinson) means adjusting content (what students learn), process (how they learn), product (how they demonstrate learning), and environment (the physical/emotional setting) based on students'' readiness, interests, and learning profiles — not just assigning more work to advanced learners.',
   'Dạy học phân hóa (Tomlinson) có nghĩa là điều chỉnh nội dung, quy trình, sản phẩm và môi trường dựa trên sự sẵn sàng, sở thích và hồ sơ học tập của học sinh — không chỉ giao thêm bài cho học sinh giỏi.', 4),
  ((SELECT id FROM lesson WHERE slug = 'effective-teaching-methods'),
   'error_correction', 'medium',
   'Correct this statement: "Direct instruction is ineffective for teaching foundational skills because it is teacher-centered and prevents student discovery and deep understanding."',
   'Sửa câu này: "Dạy học trực tiếp không hiệu quả để dạy các kỹ năng nền tảng vì nó tập trung vào giáo viên và ngăn chặn sự khám phá và hiểu sâu của học sinh."',
   'Research consistently shows direct instruction is highly effective for teaching explicit skills and foundational knowledge. The I Do / We Do / You Do model systematically transfers responsibility and supports both skill acquisition and deep understanding.',
   'Rosenshine''s Principles and Hattie''s meta-analyses both confirm direct instruction has large effect sizes. The I Do/We Do/You Do gradual release model is teacher-centered only initially — it systematically transfers ownership to students.',
   'Nghiên cứu nhất quán cho thấy dạy học trực tiếp rất hiệu quả để dạy kỹ năng tường minh và kiến thức nền tảng. Mô hình Tôi/Chúng Ta/Bạn Làm chuyển trách nhiệm một cách có hệ thống và hỗ trợ cả việc tiếp thu kỹ năng lẫn hiểu sâu.', 5);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'effective-teaching-methods') AND order_index = 1),
   'A', 'A final exam that measures cumulative learning at the end of a course', 'Kỳ thi cuối khóa đo lường kiến thức tích lũy ở cuối khóa học'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'effective-teaching-methods') AND order_index = 1),
   'B', 'Ongoing assessment during instruction to monitor progress and guide teaching decisions', 'Đánh giá liên tục trong khi giảng dạy để theo dõi tiến độ và hướng dẫn quyết định dạy học'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'effective-teaching-methods') AND order_index = 1),
   'C', 'Standardized testing that allows comparison of student performance across schools', 'Kiểm tra chuẩn hóa cho phép so sánh kết quả học sinh giữa các trường'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'effective-teaching-methods') AND order_index = 1),
   'D', 'Peer assessment where students evaluate each other''s work using rubrics', 'Đánh giá đồng đẳng nơi học sinh đánh giá công việc của nhau bằng rubric'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'effective-teaching-methods') AND order_index = 4),
   'A', 'Teaching all students the same content at the same pace using identical methods', 'Dạy tất cả học sinh cùng nội dung với cùng tốc độ sử dụng phương pháp giống nhau'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'effective-teaching-methods') AND order_index = 4),
   'B', 'Adjusting content, process, product, and environment based on student readiness, interests, and learning profiles', 'Điều chỉnh nội dung, quy trình, sản phẩm và môi trường dựa trên sự sẵn sàng, sở thích và hồ sơ học tập của học sinh'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'effective-teaching-methods') AND order_index = 4),
   'C', 'Permanently grouping students by ability level to allow targeted instruction', 'Phân nhóm học sinh vĩnh viễn theo trình độ để cho phép dạy học có mục tiêu'),
  ((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'effective-teaching-methods') AND order_index = 4),
   'D', 'Using technology platforms to deliver personalized adaptive learning for each student', 'Sử dụng nền tảng công nghệ để cung cấp học tập thích nghi cá nhân hóa cho mỗi học sinh');

