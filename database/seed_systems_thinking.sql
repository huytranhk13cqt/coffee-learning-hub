-- ============================================================================
-- SEED DATA: Systems Thinking (Category 20)
-- Lessons: Introduction to Systems Thinking, Feedback Loops in Systems,
--          Mental Models for Problem Solving
-- Compatible with: schema.sql v14
-- Applied AFTER: categories 1-19 must already exist
-- ============================================================================


-- ============================================================================
-- CATEGORY 20: Systems Thinking
-- ============================================================================

INSERT INTO category (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('Systems Thinking', 'Tư Duy Hệ Thống', 'Understand complex systems, feedback loops, and mental models for better problem solving', 'Hiểu hệ thống phức tạp, vòng phản hồi và mô hình tư duy để giải quyết vấn đề tốt hơn', 'AccountTree', '#8b5cf6', 20);


-- ############################################################################
-- LESSON 1: INTRODUCTION TO SYSTEMS THINKING (slug: intro-systems-thinking)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Introduction to Systems Thinking', 'Giới Thiệu Tư Duy Hệ Thống',
  'intro-systems-thinking',
  'Learn to see the big picture: stocks, flows, and feedback loops',
  'Học cách nhìn toàn cảnh: trữ lượng, dòng chảy và vòng phản hồi',
  'beginner', 30, 1
FROM category WHERE name = 'Systems Thinking';


-- ============================================================================
-- USAGES — intro-systems-thinking
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-systems-thinking'),
 'What is a System', 'Hệ Thống Là Gì',
 'A system is a set of interconnected elements organized to achieve a purpose. Systems have three key components: elements (the visible parts), interconnections (the relationships between parts), and a function or goal (the purpose the system serves). The whole has properties that none of its parts have alone — this is called emergence.',
 'Hệ thống là tập hợp các yếu tố liên kết được tổ chức để đạt được mục đích. Hệ thống có ba thành phần chính: yếu tố (các phần có thể thấy được), kết nối (các mối quan hệ giữa các phần) và chức năng hoặc mục tiêu (mục đích hệ thống phục vụ). Toàn thể có các thuộc tính mà không phần nào có riêng lẻ — đây gọi là sự xuất hiện.',
 'AccountTree', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'intro-systems-thinking'),
 'Stocks and Flows', 'Trữ Lượng và Dòng Chảy',
 'Stocks are accumulations that change over time as flows add to or drain from them. Examples: water in a bathtub (stock), water flowing in and draining out (flows); money in a bank account (stock), deposits and withdrawals (flows); population (stock), births and deaths (flows). Stocks give systems memory and inertia.',
 'Trữ lượng là sự tích lũy thay đổi theo thời gian khi dòng chảy vào hoặc ra khỏi chúng. Ví dụ: nước trong bồn tắm (trữ lượng), nước chảy vào và thoát ra (dòng chảy); tiền trong tài khoản ngân hàng (trữ lượng), tiền gửi và rút (dòng chảy); dân số (trữ lượng), sinh và tử (dòng chảy). Trữ lượng cho hệ thống bộ nhớ và quán tính.',
 'Waves', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'intro-systems-thinking'),
 'Emergence', 'Sự Xuất Hiện',
 'Emergence is when a system exhibits properties or behaviors that none of its individual components possess. Traffic jams emerge from individual driving decisions. Consciousness emerges from neurons. Market prices emerge from millions of individual transactions. Emergence explains why you cannot understand a system by studying its parts in isolation.',
 'Sự xuất hiện là khi hệ thống thể hiện các thuộc tính hoặc hành vi mà không thành phần nào sở hữu riêng lẻ. Kẹt xe xuất hiện từ các quyết định lái xe cá nhân. Ý thức xuất hiện từ các tế bào thần kinh. Giá thị trường xuất hiện từ hàng triệu giao dịch cá nhân. Sự xuất hiện giải thích tại sao bạn không thể hiểu hệ thống bằng cách nghiên cứu các phần riêng lẻ.',
 'AutoAwesome', TRUE, 3);


-- ============================================================================
-- SECTIONS — intro-systems-thinking
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

((SELECT id FROM lesson WHERE slug = 'intro-systems-thinking'),
 'markdown', 'Introduction to Systems Thinking', 'Giới Thiệu Tư Duy Hệ Thống',
'## Seeing the World as Systems

Systems thinking is a way of understanding reality that emphasizes the **relationships** between parts rather than the parts themselves.

> Donella Meadows: *"A system is a set of elements interconnected in such a way that they produce their own pattern of behavior over time."*

### The Three Core Components of Any System

| Component | Definition | Example (City) |
|-----------|------------|----------------|
| **Elements** | The visible, tangible parts | Buildings, roads, people |
| **Interconnections** | Relationships and information flows | Traffic signals, laws, economics |
| **Function/Goal** | The purpose the system serves | Provide shelter, commerce, community |

### Stocks and Flows

**Stocks** are anything that accumulates or depletes over time:
- A lake (filled by rain, drained by evaporation and outflow)
- A company''s reputation (built by good performance, eroded by failures)
- Your knowledge (increased by learning, decreased by forgetting)

**Flows** are the rates of change that increase or decrease stocks:
- Inflows add to the stock (rain, births, new hires)
- Outflows remove from the stock (evaporation, deaths, resignations)

```
      [Inflow] ──→ [STOCK] ──→ [Outflow]
```

Stocks give systems **inertia** — they cannot change instantly. This is why turning around a company, reducing pollution, or changing habits all take time.

### Feedback Loops

A **feedback loop** occurs when a change in a stock affects the flows into or out of that same stock.

- **Reinforcing loop (R):** Change amplifies itself in the same direction. Example: more savings → more interest → more savings (compound growth).
- **Balancing loop (B):** Change is counteracted, pushing the stock toward a goal. Example: thermostat — room temperature below target → heater on → temperature rises → heater off.

### Emergence: The Whole is More Than the Sum of Its Parts

Individual ants follow simple rules. Together, they build sophisticated colonies with temperature control, food storage, and waste management. No single ant planned this — it **emerged** from local interactions.

This is why:
- You cannot understand traffic by studying a single car
- You cannot understand a market by studying one buyer
- You cannot understand a company by studying one employee',

'## Nhìn Thế Giới Như Các Hệ Thống

Tư duy hệ thống là cách hiểu thực tế nhấn mạnh vào **các mối quan hệ** giữa các phần hơn là bản thân các phần.

> Donella Meadows: *"Hệ thống là tập hợp các yếu tố liên kết theo cách tạo ra mẫu hành vi riêng của chúng theo thời gian."*

### Ba Thành Phần Cốt Lõi Của Bất Kỳ Hệ Thống Nào

| Thành phần | Định nghĩa | Ví dụ (Thành phố) |
|------------|------------|-------------------|
| **Yếu tố** | Các phần hữu hình, có thể thấy được | Tòa nhà, đường, con người |
| **Kết nối** | Các mối quan hệ và luồng thông tin | Đèn giao thông, luật pháp, kinh tế |
| **Chức năng/Mục tiêu** | Mục đích hệ thống phục vụ | Cung cấp nơi ở, thương mại, cộng đồng |

### Trữ Lượng và Dòng Chảy

**Trữ lượng** là bất cứ thứ gì tích lũy hoặc cạn kiệt theo thời gian:
- Một hồ (được nạp bởi mưa, cạn kiệt bởi bốc hơi và dòng chảy ra)
- Danh tiếng công ty (xây dựng bởi hiệu suất tốt, bị xói mòn bởi thất bại)
- Kiến thức của bạn (tăng bởi học tập, giảm bởi quên)

**Dòng chảy** là tốc độ thay đổi tăng hoặc giảm trữ lượng:
- Dòng vào tăng trữ lượng (mưa, sinh, tuyển dụng mới)
- Dòng ra giảm trữ lượng (bốc hơi, tử, nghỉ việc)

```
      [Dòng vào] ──→ [TRỮ LƯỢNG] ──→ [Dòng ra]
```

Trữ lượng cho hệ thống **quán tính** — chúng không thể thay đổi ngay lập tức. Đây là lý do tại sao vực dậy công ty, giảm ô nhiễm hoặc thay đổi thói quen đều mất thời gian.

### Vòng Phản Hồi

**Vòng phản hồi** xảy ra khi thay đổi trong trữ lượng ảnh hưởng đến các dòng vào hoặc ra khỏi cùng trữ lượng đó.

- **Vòng tăng cường (R):** Thay đổi khuếch đại bản thân theo cùng hướng. Ví dụ: tiết kiệm nhiều hơn → lãi nhiều hơn → tiết kiệm nhiều hơn (tăng trưởng kép).
- **Vòng cân bằng (B):** Thay đổi bị chống lại, đẩy trữ lượng về phía mục tiêu. Ví dụ: bộ điều nhiệt — nhiệt độ phòng dưới mục tiêu → bật sưởi → nhiệt độ tăng → tắt sưởi.

### Sự Xuất Hiện: Toàn Thể Hơn Tổng Các Phần

Kiến riêng lẻ tuân theo các quy tắc đơn giản. Cùng nhau, chúng xây dựng các thuộc địa tinh vi với kiểm soát nhiệt độ, lưu trữ thức ăn và quản lý chất thải. Không con kiến nào lên kế hoạch — nó **xuất hiện** từ các tương tác cục bộ.

Đây là lý do:
- Bạn không thể hiểu giao thông bằng cách nghiên cứu một chiếc xe
- Bạn không thể hiểu thị trường bằng cách nghiên cứu một người mua
- Bạn không thể hiểu công ty bằng cách nghiên cứu một nhân viên',
 1, NULL),

((SELECT id FROM lesson WHERE slug = 'intro-systems-thinking'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["Hệ thống gồm ba thành phần: yếu tố, kết nối và chức năng/mục tiêu", "Trữ lượng là sự tích lũy thay đổi theo thời gian; dòng chảy là tốc độ thay đổi trữ lượng", "Vòng tăng cường khuếch đại thay đổi theo cùng hướng (tăng trưởng kép, hiệu ứng quả cầu tuyết)", "Vòng cân bằng chống lại thay đổi và thúc đẩy ổn định (bộ điều nhiệt, cơ thể điều chỉnh nhiệt độ)", "Sự xuất hiện: toàn thể có thuộc tính mà không phần nào có riêng lẻ — không thể hiểu hệ thống bằng cách tách rời các phần"]'::jsonb),

((SELECT id FROM lesson WHERE slug = 'intro-systems-thinking'),
 'diagram', 'Basic System Structure', 'Cấu Trúc Hệ Thống Cơ Bản',
 NULL, NULL, 3,
 '{"diagram": "graph TD\n  A[Input/Inflow] --> B[Stock]\n  B --> C[Output/Outflow]\n  C --> D{Feedback}\n  D -->|Reinforcing| A\n  D -->|Balancing| B"}'::jsonb);


-- ============================================================================
-- EXERCISES — intro-systems-thinking (7 exercises)
-- ============================================================================

-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-systems-thinking'),
 'fill_blank', 'easy',
 'In systems thinking, a ___ is an accumulation that changes over time as flows add to or drain from it.',
 'Trong tư duy hệ thống, ___ là sự tích lũy thay đổi theo thời gian khi dòng chảy vào hoặc ra khỏi nó.',
 'stock',
 'Stocks are the foundation of any system — they represent quantities that accumulate over time. Examples include water in a bathtub, money in an account, population, and even trust between two people. Stocks change only through flows (inflows add; outflows subtract) and cannot change instantaneously.',
 'Trữ lượng là nền tảng của bất kỳ hệ thống nào — chúng đại diện cho các lượng tích lũy theo thời gian. Ví dụ bao gồm nước trong bồn tắm, tiền trong tài khoản, dân số và thậm chí sự tin tưởng giữa hai người. Trữ lượng chỉ thay đổi thông qua dòng chảy (dòng vào tăng; dòng ra giảm) và không thể thay đổi ngay lập tức.',
 1);

-- Exercise 2: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'intro-systems-thinking'),
    'multiple_choice', 'easy',
    'What is emergence in systems thinking?',
    'Sự xuất hiện trong tư duy hệ thống là gì?',
    'B',
    'Emergence describes properties that arise from the interactions of system components but cannot be found in any single component. Traffic jams, consciousness, and market prices are all emergent phenomena. This is why reducing a system to its parts and studying them in isolation misses what makes the system interesting.',
    'Sự xuất hiện mô tả các thuộc tính phát sinh từ sự tương tác của các thành phần hệ thống nhưng không thể tìm thấy trong bất kỳ thành phần đơn lẻ nào. Kẹt xe, ý thức và giá thị trường đều là các hiện tượng xuất hiện. Đây là lý do tại sao phân rã hệ thống thành các phần và nghiên cứu chúng riêng lẻ bỏ qua điều làm hệ thống thú vị.',
    2
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, 'A failure or breakdown of the system', 'Sự cố hoặc hỏng hóc của hệ thống', FALSE),
((SELECT id FROM ex), 'B'::option_label, 'Properties that arise from component interactions, not individual parts', 'Thuộc tính phát sinh từ tương tác thành phần, không phải các phần riêng lẻ', TRUE),
((SELECT id FROM ex), 'C'::option_label, 'An external input into the system', 'Đầu vào bên ngoài vào hệ thống', FALSE),
((SELECT id FROM ex), 'D'::option_label, 'A type of feedback mechanism', 'Một loại cơ chế phản hồi', FALSE);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-systems-thinking'),
 'true_false', 'easy',
 'A reinforcing feedback loop amplifies changes in the same direction.',
 'Vòng phản hồi tăng cường khuếch đại sự thay đổi theo cùng hướng.',
 'true',
 'Reinforcing loops (also called positive feedback loops) amplify whatever is happening. More of something causes even more of it. Examples: compound interest (more savings → more interest → more savings), viral spread (more infected → more contacts → more infected), and learning (more knowledge → better learning ability → more knowledge).',
 'Vòng tăng cường (còn gọi là vòng phản hồi dương) khuếch đại bất cứ điều gì đang xảy ra. Nhiều hơn của thứ gì đó gây ra nhiều hơn nữa của nó. Ví dụ: lãi kép (tiết kiệm nhiều hơn → lãi nhiều hơn → tiết kiệm nhiều hơn), lây lan virus (nhiều người bệnh hơn → nhiều tiếp xúc hơn → nhiều người bệnh hơn) và học tập (nhiều kiến thức hơn → khả năng học tốt hơn → nhiều kiến thức hơn).',
 3);

-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-systems-thinking'),
 'fill_blank', 'easy',
 'A ___ feedback loop counteracts change and promotes stability in a system.',
 'Vòng phản hồi ___ chống lại sự thay đổi và thúc đẩy sự ổn định trong hệ thống.',
 'balancing',
 'Balancing loops (negative feedback loops) resist change and push the system toward a target or equilibrium. Examples: a thermostat (temperature drifts → correction applied → temperature restored), hunger (blood sugar drops → appetite increases → eat → blood sugar restores), and predator-prey dynamics (more prey → more predators → fewer prey → fewer predators).',
 'Vòng cân bằng (vòng phản hồi âm) chống lại sự thay đổi và đẩy hệ thống về phía mục tiêu hoặc cân bằng. Ví dụ: bộ điều nhiệt (nhiệt độ lệch → áp dụng hiệu chỉnh → nhiệt độ được khôi phục), đói (đường huyết giảm → tăng cảm giác thèm ăn → ăn → đường huyết phục hồi) và động lực săn mồi (con mồi nhiều hơn → động vật ăn thịt nhiều hơn → con mồi ít hơn → động vật ăn thịt ít hơn).',
 4);

-- Exercise 5: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'intro-systems-thinking'),
    'multiple_choice', 'medium',
    'Which of the following is the best example of a system?',
    'Điều nào sau đây là ví dụ tốt nhất về một hệ thống?',
    'C',
    'A city is a classic complex system: it has interconnected elements (people, infrastructure, businesses, government), information flows (laws, prices, communication), and a function (enabling human flourishing and economic activity). Its properties — culture, economy, safety — emerge from the interactions of millions of components.',
    'Một thành phố là hệ thống phức tạp điển hình: nó có các yếu tố liên kết (người, cơ sở hạ tầng, doanh nghiệp, chính phủ), luồng thông tin (luật pháp, giá cả, giao tiếp) và chức năng (tạo điều kiện cho sự phát triển và hoạt động kinh tế của con người). Các thuộc tính của nó — văn hóa, kinh tế, an toàn — xuất hiện từ sự tương tác của hàng triệu thành phần.',
    5
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, 'A single water molecule', 'Một phân tử nước duy nhất', FALSE),
((SELECT id FROM ex), 'B'::option_label, 'A paragraph of text', 'Một đoạn văn bản', FALSE),
((SELECT id FROM ex), 'C'::option_label, 'A city with its infrastructure and inhabitants', 'Một thành phố với cơ sở hạ tầng và người dân', TRUE),
((SELECT id FROM ex), 'D'::option_label, 'A number on a page', 'Một con số trên trang', FALSE);

-- Exercise 6: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-systems-thinking'),
 'true_false', 'easy',
 'Systems thinking focuses only on individual components rather than the relationships between them.',
 'Tư duy hệ thống chỉ tập trung vào các thành phần riêng lẻ hơn là các mối quan hệ giữa chúng.',
 'false',
 'This is the opposite of systems thinking. Reductionism focuses on individual components — systems thinking focuses on the relationships, interconnections, and feedback loops between components. Donella Meadows emphasized that the interconnections of a system are often more important than the elements themselves.',
 'Đây là ngược lại của tư duy hệ thống. Chủ nghĩa khử nguyên tập trung vào các thành phần riêng lẻ — tư duy hệ thống tập trung vào các mối quan hệ, kết nối và vòng phản hồi giữa các thành phần. Donella Meadows nhấn mạnh rằng các kết nối của hệ thống thường quan trọng hơn bản thân các yếu tố.',
 6);

-- Exercise 7: sentence_transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-systems-thinking'),
 'sentence_transform', 'medium',
 'Transform "The city is complex" into a sentence that describes it as a system with interacting subsystems.',
 'Chuyển đổi câu "Thành phố thì phức tạp" thành câu mô tả nó là hệ thống với các hệ thống con tương tác.',
 'The city is a complex system of interacting subsystems including infrastructure, economy, and social networks',
 'This transformation demonstrates the systems thinking vocabulary: identifying the system, naming it explicitly as a system, describing the subsystems (infrastructure, economy, social networks), and emphasizing their interaction. The original sentence describes a property; the transformed sentence describes structure.',
 'Sự chuyển đổi này minh chứng từ vựng tư duy hệ thống: xác định hệ thống, đặt tên rõ ràng là hệ thống, mô tả các hệ thống con (cơ sở hạ tầng, kinh tế, mạng xã hội) và nhấn mạnh sự tương tác của chúng. Câu gốc mô tả một thuộc tính; câu biến đổi mô tả cấu trúc.',
 7);


-- ############################################################################
-- LESSON 2: FEEDBACK LOOPS IN SYSTEMS (slug: feedback-loops)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Feedback Loops in Systems', 'Vòng Phản Hồi Trong Hệ Thống',
  'feedback-loops',
  'Identify reinforcing and balancing loops to understand system behavior',
  'Xác định vòng phản hồi tăng cường và cân bằng để hiểu hành vi hệ thống',
  'intermediate', 35, 2
FROM category WHERE name = 'Systems Thinking';


-- ============================================================================
-- USAGES — feedback-loops
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'feedback-loops'),
 'Reinforcing Loops', 'Vòng Tăng Cường',
 'Reinforcing (positive) feedback loops amplify change — more of something produces even more of it, or less produces even less. They drive exponential growth and collapse. Examples: population growth, viral spread, bank runs, compound interest, and learning momentum. They are neither inherently good nor bad.',
 'Vòng phản hồi tăng cường (dương) khuếch đại sự thay đổi — nhiều hơn của thứ gì đó tạo ra nhiều hơn nữa, hoặc ít hơn tạo ra ít hơn nữa. Chúng thúc đẩy tăng trưởng và sụp đổ theo hàm mũ. Ví dụ: tăng trưởng dân số, lây lan virus, tháo chạy ngân hàng, lãi kép và đà học tập. Chúng không vốn dĩ tốt hay xấu.',
 'TrendingUp', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'feedback-loops'),
 'Balancing Loops', 'Vòng Cân Bằng',
 'Balancing (negative) feedback loops counteract change and push systems toward a goal or equilibrium. They are the basis of all goal-seeking behavior. Examples: thermostats, homeostasis (body temperature), supply and demand equilibrium, and the immune system. They create stability and resilience.',
 'Vòng phản hồi cân bằng (âm) chống lại sự thay đổi và đẩy hệ thống về phía mục tiêu hoặc cân bằng. Chúng là cơ sở của mọi hành vi tìm kiếm mục tiêu. Ví dụ: bộ điều nhiệt, cân bằng nội môi (nhiệt độ cơ thể), cân bằng cung cầu và hệ thống miễn dịch. Chúng tạo ra sự ổn định và khả năng phục hồi.',
 'Balance', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'feedback-loops'),
 'Delays in Systems', 'Độ Trễ Trong Hệ Thống',
 'Delays are gaps between a cause and its effect. They cause systems to overshoot or undershoot their targets. Example: a shower with a delayed hot water response — you turn the knob hotter, wait too long, then burn yourself and overcorrect to cold. Delays make balancing loops oscillate and make policy interventions difficult.',
 'Độ trễ là khoảng cách giữa nguyên nhân và tác động của nó. Chúng khiến hệ thống vượt quá hoặc thiếu hụt mục tiêu. Ví dụ: vòi sen với phản hồi nước nóng chậm — bạn vặn tay cầm nóng hơn, chờ quá lâu, rồi bỏng và sửa quá mức sang lạnh. Độ trễ khiến vòng cân bằng dao động và làm khó các can thiệp chính sách.',
 'Timer', TRUE, 3);


-- ============================================================================
-- SECTIONS — feedback-loops
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

((SELECT id FROM lesson WHERE slug = 'feedback-loops'),
 'markdown', 'Feedback Loops: The Engine of System Behavior', 'Vòng Phản Hồi: Động Cơ Của Hành Vi Hệ Thống',
'## How Feedback Loops Drive System Behavior

Feedback loops are the primary cause of the surprising, counterintuitive behavior of complex systems.

### Reinforcing Loops (R+): The Amplifiers

A reinforcing loop creates *self-perpetuating change* — like a snowball rolling downhill, growing as it goes.

**Real-world examples:**

| Domain | Reinforcing Loop |
|--------|-----------------|
| Finance | More savings → more interest → more savings (compound growth) |
| Biology | More rabbits → more reproduction → more rabbits (population explosion) |
| Social | More users → more value for users → more users (network effects) |
| Learning | More knowledge → faster learning → more knowledge |

> Warning: Reinforcing loops that drive growth eventually encounter limits (resource constraints, competition) and the growth stops or reverses.

### Balancing Loops (B-): The Stabilizers

A balancing loop tries to close the gap between *current state* and *desired state*.

```
Desired state ──→ [Gap] ──→ Corrective action ──→ Current state
      ↑                                                    |
      └────────────────────────────────────────────────────┘
```

**Examples:**
- Thermostat: desired temperature (20°C) vs actual → heater on/off
- Blood sugar: desired level → insulin or glucagon released
- Market pricing: desired profit → price adjusts until equilibrium

### The Problem of Delays

Delays between action and effect cause **oscillation** in balancing loops.

Classic example: the real estate market cycle
1. Housing shortage → prices rise → developers start building (delay: 2-3 years)
2. Many units complete simultaneously → oversupply → prices fall
3. Developers stop building → shortage again (delay: 2-3 years)
4. Cycle repeats

> **Key insight:** When you intervene in a system and see no results, the temptation is to push harder. But if there is a delay, your first intervention is already working — pushing harder leads to overshoot.

### Identifying Feedback Loops in Practice

Ask these questions:
- Does this output eventually circle back to affect its own input? → Feedback loop
- Does the effect amplify the original cause? → Reinforcing (R+)
- Does the effect counteract the original cause? → Balancing (B-)',

'## Vòng Phản Hồi: Động Cơ Của Hành Vi Hệ Thống

Vòng phản hồi là nguyên nhân chính của hành vi bất ngờ, phản trực giác của các hệ thống phức tạp.

### Vòng Tăng Cường (R+): Các Bộ Khuếch Đại

Vòng tăng cường tạo ra *sự thay đổi tự duy trì* — như quả cầu tuyết lăn xuống dốc, lớn dần khi lăn.

**Ví dụ thực tế:**

| Lĩnh vực | Vòng tăng cường |
|---------|----------------|
| Tài chính | Tiết kiệm nhiều hơn → lãi nhiều hơn → tiết kiệm nhiều hơn (tăng trưởng kép) |
| Sinh học | Thỏ nhiều hơn → sinh sản nhiều hơn → thỏ nhiều hơn (bùng nổ dân số) |
| Xã hội | Người dùng nhiều hơn → giá trị hơn cho người dùng → người dùng nhiều hơn (hiệu ứng mạng) |
| Học tập | Kiến thức nhiều hơn → học nhanh hơn → kiến thức nhiều hơn |

> Cảnh báo: Vòng tăng cường thúc đẩy tăng trưởng cuối cùng gặp giới hạn (ràng buộc tài nguyên, cạnh tranh) và tăng trưởng dừng lại hoặc đảo chiều.

### Vòng Cân Bằng (B-): Các Bộ Ổn Định

Vòng cân bằng cố gắng thu hẹp khoảng cách giữa *trạng thái hiện tại* và *trạng thái mong muốn*.

```
Trạng thái mong muốn ──→ [Khoảng cách] ──→ Hành động khắc phục ──→ Trạng thái hiện tại
      ↑                                                                        |
      └────────────────────────────────────────────────────────────────────────┘
```

**Ví dụ:**
- Bộ điều nhiệt: nhiệt độ mong muốn (20°C) so với thực tế → bật/tắt sưởi
- Đường huyết: mức mong muốn → insulin hoặc glucagon được giải phóng
- Định giá thị trường: lợi nhuận mong muốn → giá điều chỉnh cho đến khi cân bằng

### Vấn Đề Của Độ Trễ

Độ trễ giữa hành động và tác động gây ra **dao động** trong vòng cân bằng.

Ví dụ kinh điển: chu kỳ thị trường bất động sản
1. Thiếu nhà ở → giá tăng → nhà phát triển bắt đầu xây (độ trễ: 2-3 năm)
2. Nhiều căn hộ hoàn thành cùng lúc → dư thừa → giá giảm
3. Nhà phát triển ngừng xây → thiếu hụt lại (độ trễ: 2-3 năm)
4. Chu kỳ lặp lại

> **Bài học chính:** Khi bạn can thiệp vào hệ thống và không thấy kết quả, cám dỗ là đẩy mạnh hơn. Nhưng nếu có độ trễ, sự can thiệp đầu tiên của bạn đã có hiệu quả — đẩy mạnh hơn dẫn đến vượt quá mức.',
 1, NULL),

((SELECT id FROM lesson WHERE slug = 'feedback-loops'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["Vòng tăng cường khuếch đại thay đổi theo cùng hướng — thúc đẩy tăng trưởng theo hàm mũ hoặc sụp đổ", "Vòng cân bằng chống lại sự thay đổi và đẩy hệ thống về phía mục tiêu — cơ sở của mọi hành vi tìm kiếm mục tiêu", "Độ trễ giữa nguyên nhân và tác động gây ra dao động và vượt quá mức trong vòng cân bằng", "Lãi kép là ví dụ điển hình của vòng tăng cường: nhiều tiền tạo ra nhiều lãi tạo ra nhiều tiền hơn", "Khi can thiệp và không thấy kết quả, đừng đẩy mạnh hơn — có thể có độ trễ và bạn đang vượt quá mức"]'::jsonb),

((SELECT id FROM lesson WHERE slug = 'feedback-loops'),
 'diagram', 'Reinforcing vs Balancing Loops', 'Vòng Tăng Cường vs Vòng Cân Bằng',
 NULL, NULL, 3,
 '{"diagram": "graph LR\n  A[Population] -->|Births increase population| A\n  A -->|Positive Reinforcing Loop R+| A\n  B[Temperature] --> C[Thermostat]\n  C -->|Heating/Cooling| B\n  B -->|Negative Balancing Loop B-| C"}'::jsonb);


-- ============================================================================
-- EXERCISES — feedback-loops (7 exercises)
-- ============================================================================

-- Exercise 1: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'feedback-loops'),
    'multiple_choice', 'easy',
    'What happens in a reinforcing (positive) feedback loop?',
    'Điều gì xảy ra trong vòng phản hồi tăng cường (dương)?',
    'C',
    'Reinforcing loops amplify change in the same direction — more causes more, or less causes less. They drive exponential growth or exponential decline. The term "positive" does not mean "good" — it means the feedback reinforces the direction of change, whether that direction is beneficial or harmful.',
    'Vòng tăng cường khuếch đại sự thay đổi theo cùng hướng — nhiều hơn gây ra nhiều hơn, hoặc ít hơn gây ra ít hơn. Chúng thúc đẩy tăng trưởng theo hàm mũ hoặc suy giảm theo hàm mũ. Thuật ngữ "dương" không có nghĩa là "tốt" — có nghĩa là phản hồi củng cố hướng thay đổi, dù hướng đó có lợi hay có hại.',
    1
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, 'The system stabilizes around a target', 'Hệ thống ổn định xung quanh mục tiêu', FALSE),
((SELECT id FROM ex), 'B'::option_label, 'Change is dampened and reduced', 'Sự thay đổi bị giảm nhẹ và giảm bớt', FALSE),
((SELECT id FROM ex), 'C'::option_label, 'Change amplifies itself in the same direction', 'Sự thay đổi khuếch đại bản thân theo cùng hướng', TRUE),
((SELECT id FROM ex), 'D'::option_label, 'The system collapses immediately', 'Hệ thống sụp đổ ngay lập tức', FALSE);

-- Exercise 2: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'feedback-loops'),
 'fill_blank', 'easy',
 'A thermostat controlling room temperature is an example of a ___ feedback loop.',
 'Bộ điều nhiệt kiểm soát nhiệt độ phòng là ví dụ về vòng phản hồi ___.',
 'balancing',
 'A thermostat is the textbook example of a balancing (negative) feedback loop. It continuously compares the actual room temperature to the desired temperature (the goal), and activates heating or cooling to close the gap. This goal-seeking behavior defines all balancing loops.',
 'Bộ điều nhiệt là ví dụ giáo khoa về vòng cân bằng (âm). Nó liên tục so sánh nhiệt độ phòng thực tế với nhiệt độ mong muốn (mục tiêu) và kích hoạt sưởi hoặc làm mát để thu hẹp khoảng cách. Hành vi tìm kiếm mục tiêu này định nghĩa tất cả vòng cân bằng.',
 2);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'feedback-loops'),
 'true_false', 'medium',
 'Delays in feedback loops can cause oscillation and overshoot in a system.',
 'Độ trễ trong vòng phản hồi có thể gây ra dao động và vượt quá mức trong hệ thống.',
 'true',
 'Delays are a key source of system dysfunction. When a balancing loop has a significant delay between action and effect, the system tends to overshoot its target (do too much correcting), then undershoot (overcorrect back), creating oscillation. The classic example is a shower where the water temperature response is delayed.',
 'Độ trễ là nguồn gốc chính của rối loạn hệ thống. Khi vòng cân bằng có độ trễ đáng kể giữa hành động và tác động, hệ thống có xu hướng vượt quá mục tiêu (hiệu chỉnh quá nhiều), rồi thiếu hụt (hiệu chỉnh ngược lại), tạo ra dao động. Ví dụ điển hình là vòi sen có phản hồi nhiệt độ nước bị trễ.',
 3);

-- Exercise 4: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'feedback-loops'),
    'multiple_choice', 'medium',
    'Compound interest in investing is an example of which type of feedback loop?',
    'Lãi kép trong đầu tư là ví dụ về loại vòng phản hồi nào?',
    'B',
    'Compound interest is a classic reinforcing loop: the larger your balance (stock), the more interest you earn (inflow), which increases your balance, which earns even more interest. This is why Einstein allegedly called compound interest "the eighth wonder of the world" — the reinforcing loop drives exponential, not linear, growth.',
    'Lãi kép là vòng tăng cường điển hình: số dư của bạn càng lớn (trữ lượng), bạn kiếm được lãi càng nhiều (dòng vào), điều này tăng số dư, điều này kiếm được lãi nhiều hơn nữa. Đây là lý do Einstein được cho là đã gọi lãi kép là "kỳ quan thứ tám của thế giới" — vòng tăng cường thúc đẩy tăng trưởng theo hàm mũ, không tuyến tính.',
    4
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, 'Balancing loop', 'Vòng cân bằng', FALSE),
((SELECT id FROM ex), 'B'::option_label, 'Reinforcing loop', 'Vòng tăng cường', TRUE),
((SELECT id FROM ex), 'C'::option_label, 'Delay loop', 'Vòng độ trễ', FALSE),
((SELECT id FROM ex), 'D'::option_label, 'Linear process with no feedback', 'Quy trình tuyến tính không có phản hồi', FALSE);

-- Exercise 5: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'feedback-loops'),
 'fill_blank', 'easy',
 'When a system''s output becomes its own input, this creates a ___ loop.',
 'Khi đầu ra của hệ thống trở thành đầu vào của chính nó, điều này tạo ra vòng ___.',
 'feedback',
 'A feedback loop is defined by this circular causality: an output of a system flows back to become an input, influencing its own behavior. Without feedback, a system is open-loop (like a toaster that runs for a fixed time regardless of toast color). With feedback, systems can adapt, self-regulate, and pursue goals.',
 'Vòng phản hồi được định nghĩa bởi quan hệ nhân quả vòng tròn này: đầu ra của hệ thống chảy ngược lại để trở thành đầu vào, ảnh hưởng đến hành vi của chính nó. Không có phản hồi, hệ thống là vòng mở (như lò nướng bánh mì chạy trong thời gian cố định bất kể màu bánh). Với phản hồi, hệ thống có thể thích nghi, tự điều chỉnh và theo đuổi mục tiêu.',
 5);

-- Exercise 6: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'feedback-loops'),
 'true_false', 'easy',
 'Balancing loops always lead to system collapse.',
 'Vòng cân bằng luôn dẫn đến sự sụp đổ của hệ thống.',
 'false',
 'The opposite is true: balancing loops promote stability and prevent collapse. They are the source of goal-seeking, self-correcting behavior in systems. Reinforcing loops, if unchecked, can lead to collapse (exponential growth until resources run out, or exponential decline). Balancing loops counteract such tendencies.',
 'Điều ngược lại mới đúng: vòng cân bằng thúc đẩy sự ổn định và ngăn chặn sự sụp đổ. Chúng là nguồn gốc của hành vi tìm kiếm mục tiêu, tự sửa chữa trong hệ thống. Vòng tăng cường, nếu không được kiểm soát, có thể dẫn đến sụp đổ (tăng trưởng theo hàm mũ cho đến khi hết tài nguyên, hoặc suy giảm theo hàm mũ). Vòng cân bằng chống lại những xu hướng như vậy.',
 6);

-- Exercise 7: arrange_words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'feedback-loops'),
 'arrange_words', 'medium',
 'Arrange the words to form a key principle about reinforcing feedback loops.',
 'Sắp xếp các từ để tạo thành nguyên tắc then chốt về vòng phản hồi tăng cường.',
 'Reinforcing loops accelerate growth or decline in the same direction',
 '["Reinforcing", "loops", "accelerate", "growth", "or", "decline", "in", "the", "same", "direction"]',
 'Reinforcing loops drive change in one direction — either accelerating growth (more → even more) or accelerating decline (less → even less). They are the engine behind exponential phenomena: viral epidemics, compound interest, network effects, and cascading failures all involve reinforcing loops.',
 'Vòng tăng cường thúc đẩy thay đổi theo một hướng — hoặc tăng tốc tăng trưởng (nhiều hơn → nhiều hơn nữa) hoặc tăng tốc suy giảm (ít hơn → ít hơn nữa). Chúng là động cơ đằng sau các hiện tượng theo hàm mũ: dịch bệnh virus, lãi kép, hiệu ứng mạng và hỏng hóc dây chuyền đều liên quan đến vòng tăng cường.',
 7);


-- ############################################################################
-- LESSON 3: MENTAL MODELS FOR PROBLEM SOLVING (slug: mental-models)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Mental Models for Problem Solving', 'Mô Hình Tư Duy Để Giải Quyết Vấn Đề',
  'mental-models',
  'Build a toolkit of mental models to think clearly and solve complex problems',
  'Xây dựng bộ công cụ mô hình tư duy để suy nghĩ rõ ràng và giải quyết vấn đề phức tạp',
  'intermediate', 35, 3
FROM category WHERE name = 'Systems Thinking';


-- ============================================================================
-- USAGES — mental-models
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'mental-models'),
 'First Principles Thinking', 'Tư Duy Từ Nguyên Lý Đầu Tiên',
 'First principles thinking means breaking a problem down to its most fundamental, undeniable truths — and then reasoning up from there, rather than reasoning by analogy from convention. It was Aristotle''s method and is used by Elon Musk for SpaceX rocket cost reduction and Feynman for physics understanding.',
 'Tư duy từ nguyên lý đầu tiên có nghĩa là phân rã vấn đề xuống những sự thật cơ bản, không thể phủ nhận nhất — rồi lập luận từ đó lên, thay vì lập luận bằng sự tương đồng từ quy ước. Đây là phương pháp của Aristotle và được Elon Musk dùng để giảm chi phí tên lửa SpaceX và Feynman dùng để hiểu vật lý.',
 'Lightbulb', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'mental-models'),
 'Second-Order Effects', 'Tác Động Bậc Hai',
 'Second-order thinking means asking not just "what happens next?" but "what happens after that?" First-order effects are immediate and obvious. Second-order effects are the consequences of consequences — often larger and opposite in direction. Example: subsidizing an industry (first order: lower prices; second order: reduces incentive to innovate, creates dependency).',
 'Tư duy bậc hai có nghĩa là hỏi không chỉ "điều gì xảy ra tiếp theo?" mà còn "điều gì xảy ra sau đó?" Tác động bậc một là ngay lập tức và rõ ràng. Tác động bậc hai là hậu quả của hậu quả — thường lớn hơn và ngược chiều. Ví dụ: trợ cấp một ngành (bậc một: giá thấp hơn; bậc hai: giảm động lực đổi mới, tạo ra sự phụ thuộc).',
 'Timeline', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'mental-models'),
 'Occam''s Razor', 'Dao Cạo Occam',
 'Occam''s Razor (William of Ockham, 14th century) states: among competing explanations that equally fit the evidence, prefer the simpler one. It does not mean the simplest explanation is always right — it means simplicity is a tiebreaker when evidence is equal. Used in science, medicine (common diseases are common), and engineering.',
 'Dao cạo Occam (William of Ockham, thế kỷ 14) phát biểu: trong số các giải thích cạnh tranh phù hợp bằng nhau với bằng chứng, ưu tiên giải thích đơn giản hơn. Không có nghĩa là giải thích đơn giản nhất luôn đúng — có nghĩa là sự đơn giản là tiêu chí phân định khi bằng chứng ngang nhau. Được dùng trong khoa học, y học (bệnh thông thường là phổ biến) và kỹ thuật.',
 'ContentCut', TRUE, 3);


-- ============================================================================
-- SECTIONS — mental-models
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

((SELECT id FROM lesson WHERE slug = 'mental-models'),
 'markdown', 'Mental Models: A Toolkit for Clear Thinking', 'Mô Hình Tư Duy: Bộ Công Cụ Cho Tư Duy Rõ Ràng',
'## Building Your Mental Model Toolkit

A **mental model** is a simplified representation of how something works. You already use mental models — you just may not know their names. The goal is to accumulate a diverse collection so you can choose the right one for each situation.

### 1. First Principles Thinking

**Method:** Strip away assumptions. Ask "why?" repeatedly until you hit bedrock facts.

> Elon Musk on SpaceX: "Batteries are expensive — why? Because materials are expensive. What are materials? Cobalt, nickel, aluminum. What do they cost on the commodities market? 2% of the battery price. So why are batteries expensive? Because we assumed they had to be."

**Steps:**
1. Identify the problem and your current assumptions
2. Break the problem down to fundamental truths
3. Rebuild your solution from those truths

### 2. Second-Order Thinking

Most decisions trigger chains of effects. First-order thinkers stop at the obvious.

| Decision | First-Order Effect | Second-Order Effect |
|----------|--------------------|---------------------|
| Ban cars in city center | Less traffic | Business revenues fall, people move away |
| Raise minimum wage | Higher pay for workers | Some businesses automate or hire fewer workers |
| Free university tuition | More graduates | Credential inflation, degree value decreases |

**Question to ask:** "And then what?"

### 3. Occam''s Razor

> *"Entities should not be multiplied beyond necessity."* — William of Ockham

When you have two explanations that equally explain the data, prefer the simpler one. More assumptions = more ways to be wrong.

### 4. Inversion

Instead of asking "how do I succeed?", ask "what would guarantee failure?" Then avoid those things.

Charlie Munger: "Invert, always invert." Thinking backwards often reveals solutions invisible to forward thinking.

### 5. The Pareto Principle (80/20 Rule)

Roughly 80% of effects come from 20% of causes:
- 80% of software bugs come from 20% of code
- 80% of revenue from 20% of customers
- 80% of learning from 20% of material

**Application:** Find and focus on the high-leverage 20%.

> Charlie Munger (Berkshire Hathaway): *"I think it''s undeniably true that the human brain must work with models, and it must work with multiple models simultaneously."*',

'## Xây Dựng Bộ Công Cụ Mô Hình Tư Duy

**Mô hình tư duy** là biểu diễn đơn giản hóa về cách hoạt động của thứ gì đó. Bạn đã sử dụng mô hình tư duy — bạn chỉ có thể chưa biết tên của chúng. Mục tiêu là tích lũy một bộ sưu tập đa dạng để bạn có thể chọn đúng mô hình cho từng tình huống.

### 1. Tư Duy Từ Nguyên Lý Đầu Tiên

**Phương pháp:** Loại bỏ các giả định. Hỏi "tại sao?" nhiều lần cho đến khi bạn chạm đến sự thật nền tảng.

> Elon Musk về SpaceX: "Pin đắt tiền — tại sao? Vì vật liệu đắt. Vật liệu là gì? Cobalt, niken, nhôm. Chúng có giá bao nhiêu trên thị trường hàng hóa? 2% giá pin. Vậy tại sao pin đắt? Vì chúng ta giả định chúng phải như vậy."

**Các bước:**
1. Xác định vấn đề và giả định hiện tại
2. Phân rã vấn đề xuống sự thật cơ bản
3. Xây dựng lại giải pháp từ những sự thật đó

### 2. Tư Duy Bậc Hai

Hầu hết quyết định kích hoạt chuỗi tác động. Người tư duy bậc một dừng ở điều hiển nhiên.

| Quyết định | Tác động bậc một | Tác động bậc hai |
|------------|-----------------|-----------------|
| Cấm xe hơi ở trung tâm | Ít giao thông | Doanh thu kinh doanh giảm, người dân chuyển đi |
| Tăng lương tối thiểu | Lương cao hơn cho công nhân | Một số doanh nghiệp tự động hóa hoặc thuê ít hơn |
| Học phí đại học miễn phí | Nhiều sinh viên tốt nghiệp | Lạm phát bằng cấp, giá trị bằng giảm |

**Câu hỏi cần đặt ra:** "Và sau đó thì sao?"

### 3. Dao Cạo Occam

> *"Không nên nhân rộng thực thể vượt quá sự cần thiết."* — William of Ockham

Khi bạn có hai giải thích giải thích dữ liệu ngang nhau, ưu tiên giải thích đơn giản hơn. Nhiều giả định hơn = nhiều cách sai hơn.

### 4. Đảo Ngược

Thay vì hỏi "làm thế nào để thành công?", hãy hỏi "điều gì đảm bảo thất bại?" Rồi tránh những điều đó.

Charlie Munger: "Đảo ngược, luôn luôn đảo ngược." Suy nghĩ ngược thường tiết lộ giải pháp vô hình với suy nghĩ tiến.

### 5. Nguyên Tắc Pareto (Quy tắc 80/20)

Khoảng 80% tác động đến từ 20% nguyên nhân:
- 80% lỗi phần mềm đến từ 20% code
- 80% doanh thu từ 20% khách hàng
- 80% kiến thức từ 20% tài liệu

**Ứng dụng:** Tìm và tập trung vào 20% có đòn bẩy cao.

> Charlie Munger (Berkshire Hathaway): *"Tôi nghĩ không thể phủ nhận rằng não người phải làm việc với các mô hình, và phải làm việc với nhiều mô hình đồng thời."*',
 1, NULL),

((SELECT id FROM lesson WHERE slug = 'mental-models'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["Tư duy từ nguyên lý đầu tiên: phân rã vấn đề xuống sự thật cơ bản rồi lập luận từ đó lên", "Tư duy bậc hai: xem xét hậu quả của hậu quả, không chỉ tác động ngay lập tức và rõ ràng", "Dao cạo Occam: khi bằng chứng ngang nhau, ưu tiên giải thích đơn giản hơn", "Đảo ngược: hỏi điều gì đảm bảo thất bại, rồi tránh những điều đó", "Nguyên tắc Pareto: 80% tác động đến từ 20% nguyên nhân — tìm và tập trung vào đòn bẩy cao"]'::jsonb),

((SELECT id FROM lesson WHERE slug = 'mental-models'),
 'info_box', 'Munger on Mental Models', 'Munger Về Mô Hình Tư Duy',
'**Charlie Munger''s Latticework of Mental Models**

Charlie Munger (Vice Chairman of Berkshire Hathaway) famously advocates building a "latticework" of mental models from multiple disciplines:

- From **physics**: critical mass, equilibrium, inertia
- From **biology**: evolution, natural selection, adaptation
- From **psychology**: cognitive biases, incentives, social proof
- From **economics**: opportunity cost, supply and demand, comparative advantage
- From **mathematics**: compound interest, probability, statistics

> *"You must know the big ideas of all the big disciplines and use them routinely — all of them, not just a few."*

**Why it matters:** A person with only one mental model sees every problem through that lens. A person with 100 models can select the right tool for each situation — dramatically improving the quality and speed of decisions.',

'**Mạng lưới Mô Hình Tư Duy Của Charlie Munger**

Charlie Munger (Phó Chủ tịch Berkshire Hathaway) nổi tiếng với việc ủng hộ xây dựng "mạng lưới" mô hình tư duy từ nhiều ngành học:

- Từ **vật lý**: khối lượng tới hạn, cân bằng, quán tính
- Từ **sinh học**: tiến hóa, chọn lọc tự nhiên, thích nghi
- Từ **tâm lý học**: thiên kiến nhận thức, động cơ, bằng chứng xã hội
- Từ **kinh tế học**: chi phí cơ hội, cung và cầu, lợi thế so sánh
- Từ **toán học**: lãi kép, xác suất, thống kê

> *"Bạn phải biết những ý tưởng lớn của tất cả các ngành lớn và sử dụng chúng thường xuyên — tất cả chúng, không chỉ một vài."*

**Tại sao quan trọng:** Người chỉ có một mô hình tư duy nhìn mọi vấn đề qua lăng kính đó. Người có 100 mô hình có thể chọn đúng công cụ cho từng tình huống — cải thiện đáng kể chất lượng và tốc độ quyết định.',
 3, NULL);


-- ============================================================================
-- EXERCISES — mental-models (7 exercises)
-- ============================================================================

-- Exercise 1: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'mental-models'),
    'multiple_choice', 'medium',
    'First principles thinking involves which of the following?',
    'Tư duy từ nguyên lý đầu tiên liên quan đến điều nào sau đây?',
    'B',
    'First principles thinking means breaking a problem down to its most fundamental, undeniable truths (first principles) and then building up from there. It contrasts with reasoning by analogy — copying what others have done. This approach is how Aristotle defined "first principles" and how modern innovators like Musk have re-examined industries assumed to be fixed.',
    'Tư duy từ nguyên lý đầu tiên có nghĩa là phân rã vấn đề xuống những sự thật cơ bản, không thể phủ nhận nhất (nguyên lý đầu tiên) rồi xây dựng từ đó. Nó trái ngược với lập luận bằng sự tương đồng — sao chép những gì người khác đã làm. Cách tiếp cận này là cách Aristotle định nghĩa "nguyên lý đầu tiên" và cách các nhà đổi mới hiện đại như Musk đã kiểm tra lại các ngành được cho là cố định.',
    1
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, 'Following established best practices in your field', 'Theo dõi các thực hành tốt nhất đã được thiết lập trong lĩnh vực', FALSE),
((SELECT id FROM ex), 'B'::option_label, 'Breaking problems down to fundamental truths and reasoning up from them', 'Phân rã vấn đề xuống sự thật cơ bản và lập luận từ chúng lên', TRUE),
((SELECT id FROM ex), 'C'::option_label, 'Copying successful competitors in your market', 'Sao chép đối thủ thành công trong thị trường', FALSE),
((SELECT id FROM ex), 'D'::option_label, 'Using intuition without structured analysis', 'Sử dụng trực giác mà không có phân tích có cấu trúc', FALSE);

-- Exercise 2: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'mental-models'),
 'fill_blank', 'easy',
 'Occam''s Razor states that the ___ explanation is usually the correct one when evidence is equal.',
 'Dao cạo Occam phát biểu rằng giải thích ___ thường là giải thích đúng khi bằng chứng ngang nhau.',
 'simplest',
 'Occam''s Razor (parsimony principle) is a heuristic: when multiple hypotheses explain the evidence equally well, prefer the one with fewer assumptions. More assumptions create more ways to be wrong. Note: it does not say the simplest explanation is always correct — only that simplicity should break a tie.',
 'Dao cạo Occam (nguyên tắc tiết kiệm) là phép heuristic: khi nhiều giả thuyết giải thích bằng chứng ngang nhau, ưu tiên giả thuyết có ít giả định hơn. Nhiều giả định tạo ra nhiều cách sai hơn. Lưu ý: không nói giải thích đơn giản nhất luôn đúng — chỉ nói sự đơn giản nên phân định khi ngang nhau.',
 2);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'mental-models'),
 'true_false', 'medium',
 'Second-order thinking considers the consequences of consequences.',
 'Tư duy bậc hai xem xét hậu quả của hậu quả.',
 'true',
 'Second-order thinking asks: "And then what?" First-order effects are immediate and direct. Second-order effects are what happens as a result of the first-order effects. Howard Marks (Oaktree Capital) popularized this for investing: most investors think first-order; superior returns come from second-order thinking that is not already priced in.',
 'Tư duy bậc hai hỏi: "Và sau đó thì sao?" Tác động bậc một là ngay lập tức và trực tiếp. Tác động bậc hai là những gì xảy ra do tác động bậc một. Howard Marks (Oaktree Capital) phổ biến điều này cho đầu tư: hầu hết nhà đầu tư tư duy bậc một; lợi nhuận vượt trội đến từ tư duy bậc hai chưa được tính vào giá.',
 3);

-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'mental-models'),
 'fill_blank', 'medium',
 'The mental model of ___ thinking means considering what would need to be true for the opposite conclusion to be correct.',
 'Mô hình tư duy của tư duy ___ có nghĩa là xem xét điều gì cần phải đúng để kết luận ngược lại là đúng.',
 'inversion',
 'Inversion (from mathematician Carl Jacobi''s maxim "Invert, always invert") means approaching problems backward. Instead of asking how to achieve a goal, ask what would prevent achieving it — then eliminate those obstacles. Charlie Munger calls it one of the most useful thinking tools: "Tell me where I''m going to die, that is, so I don''t go there."',
 'Đảo ngược (từ phương châm của nhà toán học Carl Jacobi "Đảo ngược, luôn luôn đảo ngược") có nghĩa là tiếp cận vấn đề ngược lại. Thay vì hỏi cách đạt mục tiêu, hãy hỏi điều gì sẽ ngăn đạt mục tiêu — rồi loại bỏ những rào cản đó. Charlie Munger gọi đây là một trong những công cụ tư duy hữu ích nhất: "Hãy cho tôi biết tôi sắp chết ở đâu, để tôi không đến đó."',
 4);

-- Exercise 5: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'mental-models'),
    'multiple_choice', 'easy',
    'What does the Pareto Principle state?',
    'Nguyên tắc Pareto phát biểu điều gì?',
    'B',
    'The Pareto Principle (80/20 rule), observed by Vilfredo Pareto in 1896, states that roughly 80% of effects come from 20% of causes. It is an empirical observation that appears across many domains. The practical implication: identify and focus on the high-impact 20% instead of spreading effort uniformly across all activities.',
    'Nguyên tắc Pareto (quy tắc 80/20), được Vilfredo Pareto quan sát năm 1896, phát biểu rằng khoảng 80% tác động đến từ 20% nguyên nhân. Đây là quan sát thực nghiệm xuất hiện ở nhiều lĩnh vực. Hàm ý thực tế: xác định và tập trung vào 20% có tác động cao thay vì phân bổ công sức đồng đều cho mọi hoạt động.',
    5
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, '100% of effort yields 100% of results uniformly', '100% công sức tạo ra 100% kết quả đồng đều', FALSE),
((SELECT id FROM ex), 'B'::option_label, '80% of effects come from 20% of causes', '80% tác động đến từ 20% nguyên nhân', TRUE),
((SELECT id FROM ex), 'C'::option_label, 'All problems have equal importance and urgency', 'Mọi vấn đề đều có tầm quan trọng và cấp bách ngang nhau', FALSE),
((SELECT id FROM ex), 'D'::option_label, 'Total costs always exceed total benefits', 'Tổng chi phí luôn vượt tổng lợi ích', FALSE);

-- Exercise 6: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'mental-models'),
 'true_false', 'easy',
 'Mental models are frameworks that simplify complex reality to aid decision-making.',
 'Mô hình tư duy là các khung đơn giản hóa thực tế phức tạp để hỗ trợ việc ra quyết định.',
 'true',
 'A mental model is a representation in your mind of how something works. All models are simplifications — they omit details to highlight what matters for a particular decision. As statistician George Box said: "All models are wrong, but some are useful." The goal is to accumulate a diverse toolkit of models and select the most relevant one for each situation.',
 'Mô hình tư duy là biểu diễn trong tâm trí bạn về cách hoạt động của thứ gì đó. Mọi mô hình đều là sự đơn giản hóa — chúng bỏ qua chi tiết để làm nổi bật những gì quan trọng cho một quyết định cụ thể. Như nhà thống kê George Box nói: "Mọi mô hình đều sai, nhưng một số hữu ích." Mục tiêu là tích lũy bộ công cụ mô hình đa dạng và chọn mô hình phù hợp nhất cho từng tình huống.',
 6);

-- Exercise 7: error_correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'mental-models'),
 'error_correction', 'medium',
 'Fix the errors: "First principle thinking require you breaking down complex problem to its most fundamentally truth"',
 'Sửa các lỗi: "First principle thinking require you breaking down complex problem to its most fundamentally truth"',
 'First principles thinking requires you to break down complex problems to their most fundamental truths',
 'Corrections: (1) "principle" → "principles" (the plural form is standard: "first principles thinking"); (2) "require" → "requires" (subject-verb agreement: "thinking" is singular); (3) "you breaking" → "you to break" (infinitive after "requires you"); (4) "complex problem" → "complex problems" (plural for generality); (5) "fundamentally" → "fundamental" (adjective modifying "truths", not adverb); (6) "truth" → "truths" (plural to match "problems").',
 'Sửa: (1) "principle" → "principles" (dạng số nhiều là chuẩn: "first principles thinking"); (2) "require" → "requires" (hòa hợp chủ ngữ-động từ: "thinking" là số ít); (3) "you breaking" → "you to break" (động từ nguyên mẫu sau "requires you"); (4) "complex problem" → "complex problems" (số nhiều để tổng quát); (5) "fundamentally" → "fundamental" (tính từ bổ nghĩa "truths", không phải trạng từ); (6) "truth" → "truths" (số nhiều để khớp với "problems").',
 7);
