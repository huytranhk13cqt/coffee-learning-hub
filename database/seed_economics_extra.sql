-- ============================================================================
-- SEED DATA: Economics 101 — Extra Lessons
-- Adds 2 lessons to existing category 'Economics 101'
-- Applied AFTER: seed_economics.sql
-- Do NOT re-insert the category.
-- ============================================================================


-- ############################################################################
-- LESSON 2: GAME THEORY BASICS (slug: game-theory-basics)
-- order_index: 2  (Supply and Demand is order_index 1)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Game Theory Basics', 'Cơ Bản Lý Thuyết Trò Chơi',
  'game-theory-basics',
  'Understand strategic decision-making: Prisoner''s Dilemma and Nash Equilibrium',
  'Hiểu ra quyết định chiến lược: Bài Toán Tù Nhân và Cân Bằng Nash',
  'intermediate', 35, 2
FROM category WHERE name = 'Economics 101';


-- ============================================================================
-- LESSON USAGES
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'game-theory-basics'),
 'The Prisoner''s Dilemma', 'Bài Toán Tù Nhân',
 'Two suspects are arrested and interrogated separately. If both stay silent, each gets 1 year. If one betrays the other, the betrayer goes free while the silent partner gets 10 years. If both betray each other, both get 5 years. Rational self-interest pushes both to betray, even though mutual silence would yield the best collective outcome.',
 'Hai nghi phạm bị bắt và thẩm vấn riêng biệt. Nếu cả hai im lặng, mỗi người lĩnh 1 năm tù. Nếu một người tố giác, người tố giác được thả còn đối tác im lặng lĩnh 10 năm. Nếu cả hai tố giác nhau, mỗi người lĩnh 5 năm. Lợi ích cá nhân thuần túy đẩy cả hai đến phản bội, dù im lặng cùng nhau mang lại kết quả tập thể tốt nhất.',
 'Gavel', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'game-theory-basics'),
 'Nash Equilibrium', 'Cân Bằng Nash',
 'A Nash Equilibrium is a stable state in a strategic game where no player can improve their outcome by unilaterally changing their own strategy, assuming all other players keep their strategies fixed. It is named after mathematician John Nash, who proved that every finite game has at least one equilibrium.',
 'Cân bằng Nash là trạng thái ổn định trong trò chơi chiến lược mà không người chơi nào có thể cải thiện kết quả bằng cách đơn phương thay đổi chiến lược của mình, với giả định tất cả người chơi khác giữ nguyên chiến lược. Được đặt tên theo nhà toán học John Nash, người đã chứng minh mọi trò chơi hữu hạn đều có ít nhất một cân bằng.',
 'Balance', TRUE, 2);


-- ============================================================================
-- EXAMPLES (2 per usage)
-- ============================================================================

INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES

-- Usage 1: Prisoner's Dilemma
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'game-theory-basics') AND order_index = 1),
 'OPEC oil-producing nations face a Prisoner''s Dilemma: if all comply with production quotas, prices stay high and everyone profits; but each country has an individual incentive to cheat by producing more, which can crash the price for everyone.',
 'Các quốc gia sản xuất dầu OPEC đối mặt với Bài Toán Tù Nhân: nếu tất cả tuân thủ hạn ngạch sản xuất, giá cao và mọi người có lợi; nhưng mỗi quốc gia có động cơ cá nhân là gian lận bằng cách sản xuất nhiều hơn, điều này có thể làm sụp đổ giá cho tất cả mọi người.',
 'The Prisoner''s Dilemma explains why cartels are inherently unstable. The dominant strategy for each individual member is to defect, even though collective cooperation would make everyone better off. Repeated interactions and enforcement mechanisms (like OPEC monitoring) can shift outcomes toward cooperation.',
 'Bài Toán Tù Nhân giải thích tại sao cartel vốn dĩ không ổn định. Chiến lược trội cho mỗi thành viên cá nhân là phản bội, dù hợp tác tập thể sẽ làm mọi người khá hơn. Tương tác lặp lại và cơ chế thực thi (như giám sát OPEC) có thể chuyển kết quả về phía hợp tác.',
 'Prisoner''s Dilemma', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'game-theory-basics') AND order_index = 1),
 'Two competing supermarkets both consider launching a price war. If neither does, both earn moderate profits. If only one does, it captures market share. If both do, they destroy each other''s margins — a classic Prisoner''s Dilemma outcome.',
 'Hai siêu thị cạnh tranh đều cân nhắc khởi động cuộc chiến giá. Nếu không ai làm, cả hai kiếm lợi nhuận vừa phải. Nếu chỉ một bên làm, bên đó chiếm thị phần. Nếu cả hai làm, họ phá hủy biên lợi nhuận của nhau — kết quả kinh điển của Bài Toán Tù Nhân.',
 'This scenario appears everywhere in business: advertising spend, R&D investment, and undercutting pricing. When both firms escalate, they often end up worse off than if neither had started — yet rational individual incentives still push each toward escalation.',
 'Kịch bản này xuất hiện ở khắp nơi trong kinh doanh: chi phí quảng cáo, đầu tư R&D và cắt giảm giá. Khi cả hai công ty leo thang, họ thường rơi vào tình trạng tệ hơn so với khi không ai bắt đầu — nhưng động cơ cá nhân hợp lý vẫn đẩy mỗi bên leo thang.',
 'price war', 2),

-- Usage 2: Nash Equilibrium
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'game-theory-basics') AND order_index = 2),
 'In the Prisoner''s Dilemma, "both defect" is the Nash Equilibrium — no prisoner can improve their outcome by switching to silence if the other is defecting. Yet this equilibrium is worse for both than the non-equilibrium outcome of "both cooperate."',
 'Trong Bài Toán Tù Nhân, "cả hai phản bội" là Cân Bằng Nash — không tù nhân nào có thể cải thiện kết quả bằng cách chuyển sang im lặng nếu người kia đang phản bội. Tuy nhiên, cân bằng này tệ hơn cho cả hai so với kết quả không cân bằng là "cả hai hợp tác."',
 'This illustrates a key insight of game theory: Nash Equilibria are stable, but not necessarily efficient or good for everyone. The concept overturned the classical economic assumption that rational self-interest always produces the best collective outcome.',
 'Điều này minh họa một nhận thức chính của lý thuyết trò chơi: Cân Bằng Nash là ổn định nhưng không nhất thiết hiệu quả hoặc tốt cho tất cả. Khái niệm này lật đổ giả định kinh tế cổ điển rằng lợi ích cá nhân hợp lý luôn tạo ra kết quả tập thể tốt nhất.',
 'Nash Equilibrium', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'game-theory-basics') AND order_index = 2),
 'Traffic routing reaches a Nash Equilibrium when no driver can shorten their commute by changing routes unilaterally. Adding a new road can paradoxically make everyone''s commute longer — known as Braess''s Paradox.',
 'Định tuyến giao thông đạt Cân Bằng Nash khi không tài xế nào có thể rút ngắn thời gian đi lại bằng cách đơn phương thay đổi tuyến đường. Thêm một con đường mới có thể làm thời gian đi lại của mọi người dài hơn một cách nghịch lý — gọi là Nghịch Lý Braess.',
 'Nash Equilibrium applies far beyond economics: to military strategy (arms races), biology (evolutionary stable strategies), and network design. It shows that individual optimization can lead to collectively suboptimal outcomes — a cornerstone insight of modern economics.',
 'Cân Bằng Nash áp dụng rộng hơn nhiều so với kinh tế: cho chiến lược quân sự (chạy đua vũ trang), sinh học (chiến lược ổn định tiến hóa) và thiết kế mạng. Nó cho thấy tối ưu hóa cá nhân có thể dẫn đến kết quả tập thể không tối ưu — một nhận thức nền tảng của kinh tế học hiện đại.',
 'Braess''s Paradox', 2);


-- ============================================================================
-- TIPS
-- ============================================================================

INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES

((SELECT id FROM lesson WHERE slug = 'game-theory-basics'),
 'Dominant strategy vs. Nash Equilibrium', 'Chiến lược trội và Cân Bằng Nash',
 'A dominant strategy is the best choice regardless of what others do. When all players have dominant strategies, the outcome is always a Nash Equilibrium — but not all Nash Equilibria come from dominant strategies. In the Prisoner''s Dilemma, "defect" is a dominant strategy for both players, making "both defect" a dominant-strategy equilibrium.',
 'Chiến lược trội là lựa chọn tốt nhất bất kể người khác làm gì. Khi tất cả người chơi có chiến lược trội, kết quả luôn là Cân Bằng Nash — nhưng không phải tất cả Cân Bằng Nash đều đến từ chiến lược trội. Trong Bài Toán Tù Nhân, "phản bội" là chiến lược trội cho cả hai người chơi, làm "cả hai phản bội" trở thành cân bằng chiến lược trội.',
 'common_mistake', 'high', 'Warning', 1),

((SELECT id FROM lesson WHERE slug = 'game-theory-basics'),
 'Repeated games change behavior', 'Trò chơi lặp lại thay đổi hành vi',
 'In a one-shot Prisoner''s Dilemma, rational players always defect. But in repeated games (infinite or unknown horizon), cooperation can emerge as a stable strategy through "tit-for-tat": cooperate first, then mirror the opponent''s last move. This explains why long-term business relationships foster trust and cooperation.',
 'Trong Bài Toán Tù Nhân một lần, người chơi hợp lý luôn phản bội. Nhưng trong trò chơi lặp lại (vô hạn hoặc không biết trước kết thúc), hợp tác có thể xuất hiện như chiến lược ổn định thông qua "ăn miếng trả miếng": hợp tác trước, sau đó phản chiếu nước đi cuối cùng của đối thủ. Điều này giải thích tại sao quan hệ kinh doanh lâu dài nuôi dưỡng sự tin tưởng và hợp tác.',
 'general', 'high', 'Lightbulb', 2),

((SELECT id FROM lesson WHERE slug = 'game-theory-basics'),
 'Zero-sum vs. non-zero-sum games', 'Trò chơi tổng bằng không và tổng khác không',
 'In a zero-sum game, one player''s gain exactly equals another''s loss (total payoff is always zero). Chess, poker, and military conflicts are approximately zero-sum. Most economic interactions are non-zero-sum — trade, cooperation, and innovation can make all parties better off. Game theory covers both, but the most interesting real-world applications are non-zero-sum.',
 'Trong trò chơi tổng bằng không, lợi ích của một người chơi chính xác bằng thua lỗ của người kia (tổng tiền thưởng luôn bằng không). Cờ vua, poker và xung đột quân sự gần như là tổng bằng không. Hầu hết tương tác kinh tế là tổng khác không — thương mại, hợp tác và đổi mới có thể làm tất cả các bên tốt hơn. Lý thuyết trò chơi bao gồm cả hai, nhưng ứng dụng thực tế thú vị nhất là tổng khác không.',
 'general', 'medium', 'Info', 3);


-- ============================================================================
-- LESSON SECTIONS (3 sections: markdown + key_points + diagram)
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

-- Section 1: markdown
((SELECT id FROM lesson WHERE slug = 'game-theory-basics'),
 'markdown', 'Strategic Thinking: Game Theory', 'Tư Duy Chiến Lược: Lý Thuyết Trò Chơi',
'## Game Theory: The Mathematics of Strategy

Game theory studies how rational agents make decisions when their outcomes depend on the choices of others. Developed by John von Neumann and Oskar Morgenstern (1944) and extended by John Nash (1950s), it is now essential to economics, political science, and biology.

### The Prisoner''s Dilemma: The Classic Setup

Two criminals are held separately. They cannot communicate. The payoff matrix:

|  | **Partner: Cooperate** | **Partner: Defect** |
|---|---|---|
| **You: Cooperate** | Both get 1 year | You get 10 years, partner goes free |
| **You: Defect** | You go free, partner gets 10 years | Both get 5 years |

**Dominant Strategy**: No matter what your partner does, defecting gives you a better personal outcome. Both prisoners reason this way → both defect → both get 5 years, even though mutual silence (1 year each) would be better for both.

### Key Vocabulary

| Term | Definition |
|------|------------|
| **Strategy** | A complete plan of action for every possible situation |
| **Payoff** | The outcome (reward or penalty) received |
| **Dominant strategy** | Best choice regardless of others'' choices |
| **Nash Equilibrium** | State where no player benefits from changing strategy unilaterally |

### Why It Matters

Game theory reveals that **individually rational behavior can produce collectively irrational outcomes**. This insight drives policy on climate agreements, antitrust law, auction design, and even nuclear deterrence.',

'## Lý Thuyết Trò Chơi: Toán Học Của Chiến Lược

Lý thuyết trò chơi nghiên cứu cách các tác nhân hợp lý đưa ra quyết định khi kết quả của họ phụ thuộc vào lựa chọn của người khác. Được phát triển bởi John von Neumann và Oskar Morgenstern (1944) và mở rộng bởi John Nash (thập niên 1950), nó nay là thiết yếu cho kinh tế học, khoa học chính trị và sinh học.

### Bài Toán Tù Nhân: Thiết Lập Cổ Điển

Hai tội phạm bị giam riêng biệt. Họ không thể giao tiếp. Ma trận kết quả:

|  | **Đối tác: Hợp tác** | **Đối tác: Phản bội** |
|---|---|---|
| **Bạn: Hợp tác** | Cả hai lĩnh 1 năm | Bạn lĩnh 10 năm, đối tác được thả |
| **Bạn: Phản bội** | Bạn được thả, đối tác lĩnh 10 năm | Cả hai lĩnh 5 năm |

**Chiến lược trội**: Bất kể đối tác làm gì, phản bội cho bạn kết quả cá nhân tốt hơn. Cả hai tù nhân suy nghĩ như vậy → cả hai phản bội → cả hai lĩnh 5 năm, dù im lặng cùng nhau (1 năm mỗi người) sẽ tốt hơn cho cả hai.

### Từ Vựng Chính

| Thuật ngữ | Định nghĩa |
|-----------|-----------|
| **Chiến lược** | Kế hoạch hành động đầy đủ cho mọi tình huống có thể xảy ra |
| **Kết quả (Payoff)** | Kết quả (phần thưởng hoặc hình phạt) nhận được |
| **Chiến lược trội** | Lựa chọn tốt nhất bất kể lựa chọn của người khác |
| **Cân Bằng Nash** | Trạng thái không người chơi nào được lợi khi đơn phương thay đổi chiến lược |

### Tại Sao Quan Trọng

Lý thuyết trò chơi cho thấy **hành vi hợp lý cá nhân có thể tạo ra kết quả tập thể phi lý**. Nhận thức này thúc đẩy chính sách về hiệp định khí hậu, luật chống độc quyền, thiết kế đấu giá và cả răn đe hạt nhân.',
 1, '{}'),

-- Section 2: key_points
((SELECT id FROM lesson WHERE slug = 'game-theory-basics'),
 'key_points', 'Core Game Theory Concepts', 'Các Khái Niệm Cốt Lõi Lý Thuyết Trò Chơi',
 NULL, NULL,
 2,
 '["Game theory studies strategic interactions where each player''s outcome depends on others'' choices", "The Prisoner''s Dilemma shows that rational individual choices can produce collectively worse outcomes", "A dominant strategy is the best choice regardless of what opponents do", "A Nash Equilibrium is a state where no player can benefit by unilaterally changing their strategy", "Zero-sum games: one player''s gain = another''s loss; non-zero-sum: all can benefit simultaneously"]'::jsonb),

-- Section 3: diagram
((SELECT id FROM lesson WHERE slug = 'game-theory-basics'),
 'diagram', 'Game Theory Decision Flow', 'Luồng Ra Quyết Định Lý Thuyết Trò Chơi',
 'How a strategic situation progresses from players making choices to reaching a Nash Equilibrium.',
 'Cách một tình huống chiến lược tiến triển từ người chơi đưa ra lựa chọn đến đạt Cân Bằng Nash.',
 3,
 '{"diagram": "graph LR\n  A[Strategic Situation] --> B[Players Make Choices]\n  B --> C[Payoff Matrix]\n  C --> D[Nash Equilibrium]\n  D --> E[No player can benefit by unilaterally changing strategy]"}'::jsonb);


-- ============================================================================
-- EXERCISES (5 exercises)
-- ============================================================================

-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'game-theory-basics'),
 'fill_blank', 'easy',
 'In the Prisoner''s Dilemma, if both players defect, they both receive a ___ outcome than if they had both cooperated.',
 'Trong Bài Toán Tù Nhân, nếu cả hai người chơi phản bội, cả hai đều nhận kết quả ___ hơn so với nếu cả hai hợp tác.',
 'worse',
 'When both players defect in the Prisoner''s Dilemma, both receive 5 years in prison. If both had cooperated (stayed silent), both would only receive 1 year. So defection leads to a collectively worse outcome — the core tragedy of the dilemma.',
 'Khi cả hai người chơi phản bội trong Bài Toán Tù Nhân, cả hai nhận 5 năm tù. Nếu cả hai hợp tác (im lặng), cả hai chỉ nhận 1 năm. Vì vậy, phản bội dẫn đến kết quả tập thể tệ hơn — bi kịch cốt lõi của bài toán này.',
 'Compare: both cooperate (1 year each) vs. both defect (5 years each)', 'So sánh: cả hai hợp tác (1 năm mỗi người) với cả hai phản bội (5 năm mỗi người)',
 1);


-- Exercise 2: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'game-theory-basics'),
 'multiple_choice', 'easy',
 'What is a Nash Equilibrium?',
 'Cân Bằng Nash là gì?',
 'A Nash Equilibrium is a stable state where no player can improve their outcome by changing only their own strategy, while all other players keep theirs fixed. It was formalized by mathematician John Nash and is foundational to modern economics.',
 'Cân Bằng Nash là trạng thái ổn định mà không người chơi nào có thể cải thiện kết quả bằng cách chỉ thay đổi chiến lược của mình, trong khi tất cả người chơi khác giữ nguyên chiến lược của họ. Nó được hình thức hóa bởi nhà toán học John Nash và là nền tảng của kinh tế học hiện đại.',
 2);

WITH mc_ex AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'game-theory-basics')
  AND type = 'multiple_choice'
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'When all players cooperate with each other', 'Khi tất cả người chơi hợp tác với nhau', FALSE, 1 FROM mc_ex
UNION ALL SELECT id, 'B'::option_label, 'When no player benefits from unilaterally changing their strategy', 'Khi không người chơi nào được lợi từ việc đơn phương thay đổi chiến lược của mình', TRUE, 2 FROM mc_ex
UNION ALL SELECT id, 'C'::option_label, 'When one player wins everything and others get nothing', 'Khi một người chơi thắng tất cả và người khác không có gì', FALSE, 3 FROM mc_ex
UNION ALL SELECT id, 'D'::option_label, 'When the game has no possible solution', 'Khi trò chơi không có giải pháp khả dĩ', FALSE, 4 FROM mc_ex;


-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'game-theory-basics'),
 'true_false', 'easy',
 'The Prisoner''s Dilemma shows that rational individual choices can lead to collectively worse outcomes.',
 'Bài Toán Tù Nhân cho thấy những lựa chọn cá nhân hợp lý có thể dẫn đến kết quả tập thể tệ hơn.',
 'true',
 'This is the central insight of the Prisoner''s Dilemma. Each prisoner acts rationally in their own self-interest by choosing to defect, yet the collective result (both get 5 years) is worse than if both had cooperated (both get 1 year). Individual rationality does not guarantee collective optimality.',
 'Đây là nhận thức trung tâm của Bài Toán Tù Nhân. Mỗi tù nhân hành động hợp lý theo lợi ích bản thân bằng cách chọn phản bội, tuy nhiên kết quả tập thể (cả hai lĩnh 5 năm) tệ hơn nếu cả hai hợp tác (cả hai lĩnh 1 năm). Tính hợp lý cá nhân không đảm bảo tính tối ưu tập thể.',
 3);


-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'game-theory-basics'),
 'fill_blank', 'medium',
 'Game theory is used in economics, politics, and ___ to analyze strategic interactions between rational agents.',
 'Lý thuyết trò chơi được sử dụng trong kinh tế, chính trị và ___ để phân tích các tương tác chiến lược giữa các tác nhân hợp lý.',
 'biology',
 'Game theory extends far beyond economics and politics into biology, where it explains evolutionary strategies. The concept of "evolutionarily stable strategies" (ESS), developed by John Maynard Smith, applies Nash Equilibrium thinking to explain animal behavior and the evolution of cooperation versus competition.',
 'Lý thuyết trò chơi mở rộng xa hơn kinh tế và chính trị sang sinh học, nơi nó giải thích các chiến lược tiến hóa. Khái niệm "chiến lược ổn định tiến hóa" (ESS), được phát triển bởi John Maynard Smith, áp dụng tư duy Cân Bằng Nash để giải thích hành vi động vật và sự tiến hóa của hợp tác so với cạnh tranh.',
 'Think of animal competition and evolutionary strategies', 'Nghĩ đến cạnh tranh động vật và chiến lược tiến hóa',
 4);


-- Exercise 5: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'game-theory-basics'),
 'true_false', 'easy',
 'In a zero-sum game, one player''s gain exactly equals another player''s loss.',
 'Trong trò chơi tổng bằng không, lợi ích của một người chơi chính xác bằng thua lỗ của người chơi khác.',
 'true',
 'In a zero-sum game, the total payoff is always constant — wealth is only transferred, never created or destroyed. If you win $10 in poker, someone else loses exactly $10. This contrasts with non-zero-sum (positive-sum) games like trade, where both parties can gain simultaneously.',
 'Trong trò chơi tổng bằng không, tổng kết quả luôn không đổi — của cải chỉ được chuyển giao, không bao giờ được tạo ra hay phá hủy. Nếu bạn thắng $10 trong poker, người khác thua chính xác $10. Điều này tương phản với trò chơi tổng khác không (tổng dương) như thương mại, nơi cả hai bên có thể đồng thời được lợi.',
 5);


-- ############################################################################
-- LESSON 3: INTERNATIONAL TRADE AND COMPARATIVE ADVANTAGE
-- slug: international-trade-basics
-- order_index: 3
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'International Trade and Comparative Advantage', 'Thương Mại Quốc Tế và Lợi Thế So Sánh',
  'international-trade-basics',
  'Understand why countries trade and the theory of comparative advantage',
  'Hiểu tại sao các quốc gia giao thương và lý thuyết lợi thế so sánh',
  'intermediate', 30, 3
FROM category WHERE name = 'Economics 101';


-- ============================================================================
-- LESSON USAGES
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'international-trade-basics'),
 'Comparative Advantage', 'Lợi Thế So Sánh',
 'A country has a comparative advantage in producing a good when it can produce it at a lower opportunity cost than another country. Even if one country is absolutely better at producing everything, both countries gain by specializing in their comparative advantage and trading. This principle, developed by David Ricardo (1817), remains the cornerstone of international trade theory.',
 'Một quốc gia có lợi thế so sánh trong sản xuất hàng hóa khi có thể sản xuất nó với chi phí cơ hội thấp hơn quốc gia khác. Ngay cả khi một quốc gia giỏi hơn tuyệt đối trong sản xuất mọi thứ, cả hai quốc gia đều được lợi bằng cách chuyên môn hóa vào lợi thế so sánh của mình và giao thương. Nguyên lý này, được David Ricardo phát triển (1817), vẫn là nền tảng của lý thuyết thương mại quốc tế.',
 'CompareArrows', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'international-trade-basics'),
 'Trade Barriers', 'Rào Cản Thương Mại',
 'Governments sometimes restrict trade through tariffs (taxes on imports), quotas (quantity limits), subsidies (support for domestic producers), and non-tariff barriers (regulations, standards). While these measures protect domestic industries in the short term, they typically reduce overall economic efficiency, raise prices for consumers, and can trigger retaliatory measures from trading partners.',
 'Chính phủ đôi khi hạn chế thương mại thông qua thuế quan (thuế đánh vào hàng nhập khẩu), hạn ngạch (giới hạn số lượng), trợ cấp (hỗ trợ nhà sản xuất trong nước) và rào cản phi thuế quan (quy định, tiêu chuẩn). Mặc dù các biện pháp này bảo vệ ngành công nghiệp trong nước ngắn hạn, chúng thường giảm hiệu quả kinh tế tổng thể, tăng giá cho người tiêu dùng và có thể gây ra các biện pháp trả đũa từ đối tác thương mại.',
 'Block', TRUE, 2);


-- ============================================================================
-- EXAMPLES (2 per usage)
-- ============================================================================

INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES

-- Usage 1: Comparative Advantage
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'international-trade-basics') AND order_index = 1),
 'Portugal can produce wine more efficiently than cloth, while England is relatively better at producing cloth. Even if England is moderately better at both, both nations gain by Portugal specializing in wine and England in cloth, then trading.',
 'Bồ Đào Nha có thể sản xuất rượu vang hiệu quả hơn vải, trong khi Anh tương đối giỏi hơn trong sản xuất vải. Ngay cả khi Anh giỏi hơn vừa phải trong cả hai, cả hai quốc gia đều được lợi khi Bồ Đào Nha chuyên môn hóa rượu vang và Anh chuyên môn hóa vải, sau đó giao thương.',
 'Ricardo''s classic example demonstrates that trade is beneficial even when one country has an absolute advantage in all goods. The key is opportunity cost: what must be given up to produce one more unit. Specialization maximizes total output across both countries.',
 'Ví dụ kinh điển của Ricardo chứng minh thương mại có lợi ngay cả khi một quốc gia có lợi thế tuyệt đối trong tất cả hàng hóa. Chìa khóa là chi phí cơ hội: phải từ bỏ gì để sản xuất thêm một đơn vị. Chuyên môn hóa tối đa hóa tổng sản lượng giữa hai quốc gia.',
 'comparative advantage', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'international-trade-basics') AND order_index = 1),
 'Bangladesh specializes in garment manufacturing despite having lower absolute productivity than Germany, because the opportunity cost of textiles relative to high-tech manufacturing is much lower in Bangladesh.',
 'Bangladesh chuyên môn hóa sản xuất hàng may mặc mặc dù có năng suất tuyệt đối thấp hơn Đức, bởi vì chi phí cơ hội của dệt may so với sản xuất công nghệ cao thấp hơn nhiều ở Bangladesh.',
 'Modern comparative advantage accounts for more than just labor. Capital availability, technology, natural resources, and institutional quality all shape a country''s opportunity costs. As countries develop, their comparative advantages shift — many Asian nations have moved from textiles to electronics to software.',
 'Lợi thế so sánh hiện đại tính đến nhiều hơn chỉ lao động. Khả năng tiếp cận vốn, công nghệ, tài nguyên thiên nhiên và chất lượng thể chế đều định hình chi phí cơ hội của một quốc gia. Khi các quốc gia phát triển, lợi thế so sánh của họ thay đổi — nhiều quốc gia châu Á đã chuyển từ dệt may sang điện tử sang phần mềm.',
 'opportunity cost', 2),

-- Usage 2: Trade Barriers
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'international-trade-basics') AND order_index = 2),
 'The US imposes steel tariffs to protect domestic steel producers. While this saves jobs in the steel industry, it raises costs for car manufacturers, construction firms, and appliance makers — industries that use steel as an input.',
 'Mỹ áp dụng thuế quan thép để bảo vệ nhà sản xuất thép trong nước. Mặc dù điều này bảo vệ việc làm trong ngành thép, nó tăng chi phí cho nhà sản xuất xe hơi, công ty xây dựng và nhà sản xuất thiết bị — các ngành sử dụng thép như đầu vào.',
 'Tariffs create "winners" (protected domestic producers) and "losers" (consumers and downstream industries). Economists generally find that the losses outweigh the gains — tariffs redistribute income rather than creating net wealth. They may be justified for strategic industries, infant industries, or national security reasons, but the economic costs are real.',
 'Thuế quan tạo ra "người thắng" (nhà sản xuất trong nước được bảo hộ) và "người thua" (người tiêu dùng và ngành hạ nguồn). Các nhà kinh tế thường thấy rằng tổn thất vượt trội lợi ích — thuế quan tái phân phối thu nhập hơn là tạo ra của cải ròng. Chúng có thể được biện minh cho các ngành chiến lược, ngành non trẻ hoặc lý do an ninh quốc gia, nhưng chi phí kinh tế là có thật.',
 'tariffs', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'international-trade-basics') AND order_index = 2),
 'When the US imposed tariffs on Chinese goods in 2018, China retaliated with tariffs on US soybeans, directly harming American farmers who had built export markets in China.',
 'Khi Mỹ áp dụng thuế quan lên hàng hóa Trung Quốc năm 2018, Trung Quốc trả đũa bằng thuế quan lên đậu nành Mỹ, gây thiệt hại trực tiếp cho nông dân Mỹ đã xây dựng thị trường xuất khẩu tại Trung Quốc.',
 'Trade wars illustrate how tit-for-tat retaliation can escalate and harm multiple sectors in both countries. The interconnected nature of global supply chains means that tariffs on one product ripple through many industries. This is why most economists prefer negotiated trade agreements over unilateral tariffs.',
 'Chiến tranh thương mại minh họa cách trả đũa ăn miếng trả miếng có thể leo thang và gây tổn hại cho nhiều lĩnh vực ở cả hai quốc gia. Tính chất liên kết của chuỗi cung ứng toàn cầu có nghĩa là thuế quan đối với một sản phẩm lan rộng qua nhiều ngành. Đây là lý do hầu hết các nhà kinh tế thích các thỏa thuận thương mại được đàm phán hơn thuế quan đơn phương.',
 'trade wars', 2);


-- ============================================================================
-- TIPS
-- ============================================================================

INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES

((SELECT id FROM lesson WHERE slug = 'international-trade-basics'),
 'Comparative ≠ Absolute advantage', 'Lợi thế so sánh ≠ lợi thế tuyệt đối',
 'Absolute advantage means producing more output with the same inputs. Comparative advantage means producing at a lower opportunity cost. A country should export goods in which it has a comparative advantage — not necessarily absolute advantage. Even the most productive country cannot have a comparative advantage in everything, because opportunity costs are relative.',
 'Lợi thế tuyệt đối nghĩa là sản xuất nhiều sản lượng hơn với cùng đầu vào. Lợi thế so sánh nghĩa là sản xuất với chi phí cơ hội thấp hơn. Một quốc gia nên xuất khẩu hàng hóa mà mình có lợi thế so sánh — không nhất thiết là lợi thế tuyệt đối. Ngay cả quốc gia năng suất nhất cũng không thể có lợi thế so sánh trong mọi thứ, vì chi phí cơ hội mang tính tương đối.',
 'common_mistake', 'high', 'Warning', 1),

((SELECT id FROM lesson WHERE slug = 'international-trade-basics'),
 'Free trade benefits consumers but disrupts workers', 'Thương mại tự do có lợi cho người tiêu dùng nhưng làm gián đoạn người lao động',
 'Free trade lowers prices and increases product variety for all consumers. However, it concentrates job losses in specific industries and regions — steel workers in Ohio, textile workers in the Carolinas. The gains from trade are diffuse (a little cheaper for everyone), while the losses are concentrated (devastating for affected workers). This political economy explains why trade protection persists despite economists'' near-universal support for free trade.',
 'Thương mại tự do hạ giá và tăng sự đa dạng sản phẩm cho tất cả người tiêu dùng. Tuy nhiên, nó tập trung mất việc làm ở các ngành và vùng cụ thể — công nhân thép ở Ohio, công nhân dệt may ở Carolinas. Lợi ích từ thương mại phân tán (rẻ hơn một chút cho mọi người), trong khi tổn thất tập trung (tàn phá cho công nhân bị ảnh hưởng). Kinh tế chính trị này giải thích tại sao bảo hộ thương mại tồn tại bất chấp sự ủng hộ gần như đồng thuận của các nhà kinh tế đối với thương mại tự do.',
 'general', 'high', 'Lightbulb', 2),

((SELECT id FROM lesson WHERE slug = 'international-trade-basics'),
 'WTO: referee of global trade rules', 'WTO: trọng tài của quy tắc thương mại toàn cầu',
 'The World Trade Organization (WTO), established 1995, provides the legal framework for international trade. It sets rules, resolves disputes, and pushes for tariff reductions through negotiating rounds. Over 160 member nations have bound tariff rates and commit to non-discrimination (Most-Favored-Nation principle). The WTO does not eliminate trade barriers but provides a rules-based system to manage them.',
 'Tổ chức Thương mại Thế giới (WTO), thành lập năm 1995, cung cấp khung pháp lý cho thương mại quốc tế. Nó đặt ra quy tắc, giải quyết tranh chấp và thúc đẩy giảm thuế quan thông qua các vòng đàm phán. Hơn 160 quốc gia thành viên có thuế quan ràng buộc và cam kết không phân biệt đối xử (nguyên tắc Tối Huệ Quốc). WTO không loại bỏ rào cản thương mại nhưng cung cấp hệ thống dựa trên quy tắc để quản lý chúng.',
 'general', 'medium', 'Info', 3);


-- ============================================================================
-- LESSON SECTIONS (3 sections: markdown + key_points + info_box)
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

-- Section 1: markdown
((SELECT id FROM lesson WHERE slug = 'international-trade-basics'),
 'markdown', 'Why Nations Trade: Comparative Advantage', 'Tại Sao Các Quốc Gia Giao Thương: Lợi Thế So Sánh',
'## International Trade: The Economics of Specialization

### Why Trade?

Countries trade because **specialization increases total output**. Instead of each country trying to produce everything, each focuses on goods it produces most efficiently.

### Absolute vs. Comparative Advantage

| Concept | Definition | Example |
|---------|-----------|---------|
| **Absolute Advantage** | Produce more output per unit of input | USA produces more wheat per acre than Mexico |
| **Comparative Advantage** | Produce at lower opportunity cost | Mexico''s opportunity cost of growing tomatoes is lower than USA''s |

> Key insight (Ricardo, 1817): **Trade benefits both parties even if one is absolutely better at producing everything.**

### Opportunity Cost: The Real Driver

If France can produce 2 units of wine OR 1 unit of cheese per hour, its opportunity cost of cheese is 2 wines. If Germany can produce 1 unit of wine OR 2 units of cheese per hour, its opportunity cost of cheese is 0.5 wines.

**Germany has comparative advantage in cheese; France in wine.** Both gain by specializing and trading.

### Trade Barriers: Types and Effects

| Type | Definition | Effect |
|------|-----------|--------|
| **Tariff** | Tax on imports | Raises price for consumers, protects domestic producers |
| **Quota** | Quantity limit on imports | Creates scarcity and higher prices |
| **Subsidy** | Government payment to domestic producer | Artificially lowers costs, distorts competition |
| **Non-tariff barrier** | Regulations, standards, red tape | Restricts trade through administrative burden |',

'## Thương Mại Quốc Tế: Kinh Tế Học Của Chuyên Môn Hóa

### Tại Sao Giao Thương?

Các quốc gia giao thương vì **chuyên môn hóa tăng tổng sản lượng**. Thay vì mỗi quốc gia cố gắng sản xuất mọi thứ, mỗi nước tập trung vào hàng hóa sản xuất hiệu quả nhất.

### Lợi Thế Tuyệt Đối và Lợi Thế So Sánh

| Khái niệm | Định nghĩa | Ví dụ |
|-----------|-----------|------|
| **Lợi thế tuyệt đối** | Sản xuất nhiều sản lượng hơn trên mỗi đơn vị đầu vào | Mỹ sản xuất nhiều lúa mì hơn Mexico trên mỗi mẫu |
| **Lợi thế so sánh** | Sản xuất với chi phí cơ hội thấp hơn | Chi phí cơ hội trồng cà chua của Mexico thấp hơn Mỹ |

> Nhận thức chính (Ricardo, 1817): **Thương mại có lợi cho cả hai bên ngay cả khi một bên giỏi hơn tuyệt đối trong mọi thứ.**

### Chi Phí Cơ Hội: Động Lực Thực Sự

Nếu Pháp có thể sản xuất 2 đơn vị rượu vang HOẶC 1 đơn vị phô mai mỗi giờ, chi phí cơ hội của phô mai là 2 rượu vang. Nếu Đức có thể sản xuất 1 đơn vị rượu vang HOẶC 2 đơn vị phô mai mỗi giờ, chi phí cơ hội của phô mai là 0,5 rượu vang.

**Đức có lợi thế so sánh trong phô mai; Pháp trong rượu vang.** Cả hai đều được lợi khi chuyên môn hóa và giao thương.

### Rào Cản Thương Mại: Loại và Tác Động

| Loại | Định nghĩa | Tác động |
|------|-----------|---------|
| **Thuế quan** | Thuế đánh vào hàng nhập khẩu | Tăng giá cho người tiêu dùng, bảo vệ nhà sản xuất trong nước |
| **Hạn ngạch** | Giới hạn số lượng nhập khẩu | Tạo ra khan hiếm và giá cao hơn |
| **Trợ cấp** | Khoản thanh toán của chính phủ cho nhà sản xuất trong nước | Hạ chi phí nhân tạo, bóp méo cạnh tranh |
| **Rào cản phi thuế quan** | Quy định, tiêu chuẩn, thủ tục hành chính | Hạn chế thương mại qua gánh nặng hành chính |',
 1, '{}'),

-- Section 2: key_points
((SELECT id FROM lesson WHERE slug = 'international-trade-basics'),
 'key_points', 'Core International Trade Principles', 'Nguyên Tắc Thương Mại Quốc Tế Cốt Lõi',
 NULL, NULL,
 2,
 '["Comparative advantage: a country should specialize in goods it can produce at the lowest opportunity cost", "Even if one country has absolute advantage in everything, both countries gain from trade through specialization", "Tariffs protect domestic industries but raise consumer prices and reduce overall economic efficiency", "Free trade increases total output and lowers prices but can concentrate job losses in specific sectors", "The WTO provides the multilateral rules-based framework governing international trade between member nations"]'::jsonb),

-- Section 3: info_box (Ricardo's comparative advantage)
((SELECT id FROM lesson WHERE slug = 'international-trade-basics'),
 'info_box', 'Ricardo''s Comparative Advantage (1817)', 'Lợi Thế So Sánh của Ricardo (1817)',
 'David Ricardo''s principle of comparative advantage, published in "On the Principles of Political Economy and Taxation" (1817), is one of the most powerful and counterintuitive insights in economics. Ricardo showed mathematically that even if England was more productive than Portugal in producing both cloth and wine, both countries would gain by specializing: England in cloth (where its relative advantage was largest) and Portugal in wine (where England''s relative advantage was smallest). Trade allows global output to exceed what either country could produce alone. This principle remains the strongest theoretical argument for free trade and explains why even low-wage developing countries find willing trading partners among wealthy nations.',
 'Nguyên lý lợi thế so sánh của David Ricardo, được công bố trong "Về Các Nguyên Tắc Kinh Tế Chính Trị và Thuế" (1817), là một trong những nhận thức mạnh mẽ và phản trực giác nhất trong kinh tế học. Ricardo chứng minh bằng toán học rằng ngay cả khi Anh có năng suất cao hơn Bồ Đào Nha trong sản xuất cả vải và rượu vang, cả hai quốc gia đều được lợi khi chuyên môn hóa: Anh trong vải (nơi lợi thế tương đối lớn nhất) và Bồ Đào Nha trong rượu vang (nơi lợi thế tương đối của Anh nhỏ nhất). Thương mại cho phép sản lượng toàn cầu vượt quá những gì bất kỳ quốc gia nào có thể sản xuất một mình. Nguyên lý này vẫn là lập luận lý thuyết mạnh nhất cho thương mại tự do và giải thích tại sao ngay cả các nước đang phát triển có mức lương thấp cũng tìm được đối tác thương mại sẵn sàng trong số các quốc gia giàu có.',
 3, '{"variant": "info"}'::jsonb);


-- ============================================================================
-- EXERCISES (5 exercises)
-- ============================================================================

-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'international-trade-basics'),
 'fill_blank', 'easy',
 'A country has a ___ advantage when it can produce a good at a lower opportunity cost than other countries.',
 'Một quốc gia có lợi thế ___ khi có thể sản xuất một hàng hóa với chi phí cơ hội thấp hơn các quốc gia khác.',
 'comparative',
 'Comparative advantage is defined by opportunity cost, not absolute productivity. A country has a comparative advantage in a good when the opportunity cost of producing that good — what must be given up to produce it — is lower than in other countries. This is the key driver of beneficial trade patterns.',
 'Lợi thế so sánh được xác định bởi chi phí cơ hội, không phải năng suất tuyệt đối. Một quốc gia có lợi thế so sánh trong một hàng hóa khi chi phí cơ hội sản xuất hàng hóa đó — những gì phải từ bỏ để sản xuất nó — thấp hơn so với các quốc gia khác. Đây là động lực chính của các mô hình thương mại có lợi.',
 'Think: lower opportunity cost, not necessarily higher productivity', 'Nghĩ: chi phí cơ hội thấp hơn, không nhất thiết là năng suất cao hơn',
 1);


-- Exercise 2: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'international-trade-basics'),
 'multiple_choice', 'easy',
 'What is a tariff?',
 'Thuế quan là gì?',
 'A tariff is a tax levied on imported goods. It raises the price of imports, making them more expensive relative to domestically produced goods. This protects domestic producers from foreign competition but raises prices for domestic consumers and can provoke retaliatory tariffs from trading partners.',
 'Thuế quan là khoản thuế đánh vào hàng hóa nhập khẩu. Nó tăng giá hàng nhập khẩu, khiến chúng đắt hơn so với hàng hóa sản xuất trong nước. Điều này bảo vệ nhà sản xuất trong nước khỏi cạnh tranh nước ngoài nhưng tăng giá cho người tiêu dùng trong nước và có thể gây ra thuế quan trả đũa từ đối tác thương mại.',
 2);

WITH mc_ex AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'international-trade-basics')
  AND type = 'multiple_choice'
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'An international trade agreement between two countries', 'Một hiệp định thương mại quốc tế giữa hai quốc gia', FALSE, 1 FROM mc_ex
UNION ALL SELECT id, 'B'::option_label, 'A tax on imported goods', 'Thuế đánh vào hàng hóa nhập khẩu', TRUE, 2 FROM mc_ex
UNION ALL SELECT id, 'C'::option_label, 'A currency exchange rate mechanism', 'Cơ chế tỷ giá hối đoái', FALSE, 3 FROM mc_ex
UNION ALL SELECT id, 'D'::option_label, 'A government export subsidy', 'Trợ cấp xuất khẩu của chính phủ', FALSE, 4 FROM mc_ex;


-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'international-trade-basics'),
 'true_false', 'medium',
 'Free trade always benefits all parties equally in the short term.',
 'Thương mại tự do luôn mang lại lợi ích bình đẳng cho tất cả các bên trong ngắn hạn.',
 'false',
 'Free trade generally increases total welfare and benefits consumers through lower prices and more variety. However, in the short term, it creates clear winners (consumers, export industries, firms with comparative advantage) and losers (import-competing industries and their workers). The gains are broadly distributed while the losses are concentrated — free trade is not Pareto-improving for everyone in the short run.',
 'Thương mại tự do thường tăng tổng phúc lợi và có lợi cho người tiêu dùng thông qua giá thấp hơn và đa dạng hơn. Tuy nhiên, trong ngắn hạn, nó tạo ra người thắng rõ ràng (người tiêu dùng, ngành xuất khẩu, công ty có lợi thế so sánh) và người thua (ngành cạnh tranh nhập khẩu và công nhân của họ). Lợi ích phân tán rộng trong khi tổn thất tập trung — thương mại tự do không cải thiện Pareto cho mọi người trong ngắn hạn.',
 3);


-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'international-trade-basics'),
 'fill_blank', 'medium',
 'The ___ is the international organization established in 1995 to set rules for global trade and resolve trade disputes between member nations.',
 '___ là tổ chức quốc tế được thành lập năm 1995 để đặt ra quy tắc cho thương mại toàn cầu và giải quyết tranh chấp thương mại giữa các quốc gia thành viên.',
 'WTO',
 'The World Trade Organization (WTO), headquartered in Geneva, Switzerland, replaced the General Agreement on Tariffs and Trade (GATT) in 1995. With over 160 member nations, it administers trade agreements, provides a dispute settlement system, and monitors national trade policies. It operates on principles of non-discrimination (Most-Favored-Nation), transparency, and reciprocity.',
 'Tổ chức Thương mại Thế giới (WTO), có trụ sở tại Geneva, Thụy Sĩ, thay thế Hiệp định Chung về Thuế quan và Thương mại (GATT) năm 1995. Với hơn 160 quốc gia thành viên, nó quản lý các hiệp định thương mại, cung cấp hệ thống giải quyết tranh chấp và giám sát chính sách thương mại quốc gia. Nó hoạt động theo nguyên tắc không phân biệt đối xử (Tối Huệ Quốc), minh bạch và có đi có lại.',
 'Think of the global body that referees trade disputes', 'Nghĩ đến tổ chức toàn cầu làm trọng tài tranh chấp thương mại',
 4);


-- Exercise 5: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'international-trade-basics'),
 'true_false', 'easy',
 'Comparative advantage means a country should specialize in goods it can produce at the lowest opportunity cost.',
 'Lợi thế so sánh có nghĩa là một quốc gia nên chuyên môn hóa vào hàng hóa có thể sản xuất với chi phí cơ hội thấp nhất.',
 'true',
 'This is precisely the definition of comparative advantage. A country should specialize in and export goods where its opportunity cost is lowest relative to trading partners. It should import goods where its opportunity cost is highest. Following comparative advantage maximizes global production efficiency and makes all trading parties better off than self-sufficiency.',
 'Đây chính xác là định nghĩa của lợi thế so sánh. Một quốc gia nên chuyên môn hóa và xuất khẩu hàng hóa nơi chi phí cơ hội của mình thấp nhất so với các đối tác thương mại. Nên nhập khẩu hàng hóa nơi chi phí cơ hội cao nhất. Tuân theo lợi thế so sánh tối đa hóa hiệu quả sản xuất toàn cầu và làm tất cả các bên giao thương tốt hơn so với tự cung tự cấp.',
 5);
