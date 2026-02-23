-- ============================================================================
-- SEED DATA: Management (Category 19)
-- Lessons: Leadership vs Management, Decision Making Frameworks, Team Dynamics
-- Compatible with: schema.sql v14
-- Applied AFTER: categories 1-18 must already exist
-- ============================================================================


-- ============================================================================
-- CATEGORY 19: Management
-- ============================================================================

INSERT INTO category (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('Management', 'Quản Lý', 'Develop leadership skills, team management, and decision-making abilities', 'Phát triển kỹ năng lãnh đạo, quản lý nhóm và khả năng ra quyết định', 'Groups', '#f59e0b', 19);


-- ############################################################################
-- LESSON 1: LEADERSHIP VS MANAGEMENT (slug: leadership-vs-management)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Leadership vs Management', 'Lãnh Đạo vs Quản Lý',
  'leadership-vs-management',
  'Understand the key differences and when to lead vs manage',
  'Hiểu sự khác biệt then chốt và khi nào dẫn dắt vs quản lý',
  'beginner', 25, 1
FROM category WHERE name = 'Management';


-- ============================================================================
-- USAGES — leadership-vs-management
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'leadership-vs-management'),
 'Leadership Styles', 'Phong Cách Lãnh Đạo',
 'Leadership styles range from autocratic (leader decides alone) to democratic (team input welcomed) to laissez-faire (team self-directs). Effective leaders adapt their style to the situation and maturity of their team.',
 'Phong cách lãnh đạo từ chuyên quyền (lãnh đạo quyết định một mình) đến dân chủ (lắng nghe ý kiến nhóm) đến tự do (nhóm tự định hướng). Lãnh đạo hiệu quả thích nghi phong cách với tình huống và độ trưởng thành của nhóm.',
 'Groups', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'leadership-vs-management'),
 'Management Functions', 'Chức Năng Quản Lý',
 'Henri Fayol identified four core management functions: planning (setting goals and strategies), organizing (structuring resources), leading (directing and motivating), and controlling (monitoring performance against goals).',
 'Henri Fayol xác định bốn chức năng quản lý cốt lõi: lập kế hoạch (đặt mục tiêu và chiến lược), tổ chức (cơ cấu nguồn lực), lãnh đạo (chỉ đạo và động viên), và kiểm soát (theo dõi hiệu suất so với mục tiêu).',
 'Settings', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'leadership-vs-management'),
 'When to Lead vs Manage', 'Khi Nào Dẫn Dắt vs Quản Lý',
 'Leading is most critical during change, crisis, or when inspiring vision. Managing is most critical when executing processes, meeting deadlines, and ensuring consistency. The best executives know when to shift between both modes.',
 'Dẫn dắt quan trọng nhất trong thay đổi, khủng hoảng, hoặc khi truyền cảm hứng tầm nhìn. Quản lý quan trọng nhất khi thực thi quy trình, đáp ứng thời hạn và đảm bảo nhất quán. Các nhà điều hành giỏi nhất biết khi nào chuyển đổi giữa hai chế độ.',
 'Lightbulb', TRUE, 3);


-- ============================================================================
-- SECTIONS — leadership-vs-management
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

((SELECT id FROM lesson WHERE slug = 'leadership-vs-management'),
 'markdown', 'Overview', 'Tổng Quan',
'## Leadership vs Management: Two Sides of the Same Coin

Organizations need both **leaders** and **managers** — but they serve different purposes.

### The Core Distinction

> Peter Drucker: *"Management is doing things right; leadership is doing the right things."*

| Dimension | Leadership | Management |
|-----------|-----------|------------|
| **Focus** | People and vision | Processes and efficiency |
| **Time horizon** | Long-term | Short-term |
| **Change** | Drives change | Maintains stability |
| **Question** | "What and why?" | "How and when?" |
| **Power source** | Influence and inspiration | Authority and position |

### Leadership Styles (Lewin, 1939)

- **Autocratic** — Leader makes all decisions. Fast but can stifle creativity and morale.
- **Democratic** — Team participates in decisions. Slower but builds buy-in and ownership.
- **Laissez-faire** — Team self-directs. Best for highly skilled, self-motivated individuals.
- **Transformational** — Leader inspires followers to exceed their own interests for the group''s mission.

### The Four Functions of Management (Fayol)

1. **Planning** — Define goals, develop strategies, set timelines
2. **Organizing** — Allocate resources, assign roles, design structure
3. **Leading** — Communicate, motivate, and direct people toward goals
4. **Controlling** — Monitor results, compare to goals, take corrective action

### When Does an Organization Need Leadership vs Management?

Organizations stuck in bureaucracy often over-manage and under-lead. Startups often over-lead and under-manage. The healthiest organizations balance both: a clear vision (leadership) executed through reliable systems (management).',

'## Lãnh Đạo vs Quản Lý: Hai Mặt Của Cùng Một Đồng Xu

Các tổ chức cần cả **lãnh đạo** lẫn **quản lý** — nhưng chúng phục vụ mục đích khác nhau.

### Sự Phân Biệt Cốt Lõi

> Peter Drucker: *"Quản lý là làm đúng việc; lãnh đạo là làm việc đúng."*

| Chiều | Lãnh đạo | Quản lý |
|-------|---------|---------|
| **Tập trung** | Con người và tầm nhìn | Quy trình và hiệu quả |
| **Tầm nhìn thời gian** | Dài hạn | Ngắn hạn |
| **Thay đổi** | Thúc đẩy thay đổi | Duy trì ổn định |
| **Câu hỏi** | "Cái gì và tại sao?" | "Như thế nào và khi nào?" |
| **Nguồn quyền lực** | Ảnh hưởng và truyền cảm hứng | Thẩm quyền và vị trí |

### Phong Cách Lãnh Đạo (Lewin, 1939)

- **Chuyên quyền** — Lãnh đạo tự quyết định. Nhanh nhưng có thể kìm hãm sáng tạo và tinh thần.
- **Dân chủ** — Nhóm tham gia ra quyết định. Chậm hơn nhưng tạo sự ủng hộ và trách nhiệm.
- **Tự do** — Nhóm tự định hướng. Tốt nhất cho những người có kỹ năng cao và tự động lực.
- **Chuyển đổi** — Lãnh đạo truyền cảm hứng cho người theo để vượt qua lợi ích cá nhân vì sứ mệnh nhóm.

### Bốn Chức Năng Quản Lý (Fayol)

1. **Lập kế hoạch** — Xác định mục tiêu, phát triển chiến lược, đặt mốc thời gian
2. **Tổ chức** — Phân bổ nguồn lực, giao vai trò, thiết kế cơ cấu
3. **Lãnh đạo** — Giao tiếp, động viên và chỉ đạo người hướng đến mục tiêu
4. **Kiểm soát** — Theo dõi kết quả, so sánh với mục tiêu, thực hiện hành động khắc phục

### Khi Nào Tổ Chức Cần Lãnh Đạo vs Quản Lý?

Tổ chức mắc kẹt trong quan liêu thường quản lý quá mức và dẫn dắt chưa đủ. Startup thường dẫn dắt quá mức và quản lý chưa đủ. Tổ chức lành mạnh nhất cân bằng cả hai: tầm nhìn rõ ràng (lãnh đạo) được thực thi qua hệ thống đáng tin cậy (quản lý).',
 1, NULL),

((SELECT id FROM lesson WHERE slug = 'leadership-vs-management'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["Lãnh đạo tập trung vào con người và tầm nhìn; quản lý tập trung vào quy trình và hiệu quả", "Drucker: Quản lý là làm đúng việc; lãnh đạo là làm việc đúng", "Bốn chức năng quản lý: lập kế hoạch, tổ chức, lãnh đạo, kiểm soát", "Lãnh đạo chuyển đổi truyền cảm hứng thay đổi; lãnh đạo chuyên quyền ra quyết định một mình", "Lãnh đạo giỏi không nhất thiết là quản lý giỏi — cả hai kỹ năng đều cần phát triển"]'::jsonb),

((SELECT id FROM lesson WHERE slug = 'leadership-vs-management'),
 'diagram', 'Leadership vs Management Map', 'Sơ Đồ Lãnh Đạo vs Quản Lý',
 NULL, NULL, 3,
 '{"diagram": "graph LR\n  A[Leadership] --> B[Sets Vision]\n  A --> C[Inspires People]\n  A --> D[Drives Change]\n  E[Management] --> F[Plans & Organizes]\n  E --> G[Controls Resources]\n  E --> H[Ensures Efficiency]"}'::jsonb);


-- ============================================================================
-- EXERCISES — leadership-vs-management (7 exercises)
-- ============================================================================

-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'leadership-vs-management'),
 'fill_blank', 'easy',
 'Drucker said: "Management is doing things right; leadership is doing the ___ things."',
 'Drucker nói: "Quản lý là làm đúng việc; lãnh đạo là làm ___ việc đúng."',
 'right',
 'This famous Drucker quote captures the core distinction: management is about efficiency (doing things right), while leadership is about effectiveness (choosing the right things to do in the first place).',
 'Câu nói nổi tiếng của Drucker nắm bắt sự phân biệt cốt lõi: quản lý là về hiệu quả (làm đúng việc), còn lãnh đạo là về hiệu lực (chọn đúng việc để làm ngay từ đầu).',
 1);

-- Exercise 2: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'leadership-vs-management'),
    'multiple_choice', 'easy',
    'Which of the following is a characteristic of a leader rather than a manager?',
    'Điều nào sau đây là đặc điểm của một lãnh đạo hơn là một quản lý?',
    'C',
    'Leaders inspire and motivate people toward a shared vision. Managers, by contrast, focus on controlling processes, meeting quarterly targets, and managing budgets — all important, but distinct from inspiring long-term change.',
    'Lãnh đạo truyền cảm hứng và động viên mọi người hướng đến tầm nhìn chung. Ngược lại, quản lý tập trung vào kiểm soát quy trình, đạt mục tiêu quý và quản lý ngân sách — tất cả đều quan trọng, nhưng khác với việc truyền cảm hứng thay đổi dài hạn.',
    2
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, 'Controls processes and systems', 'Kiểm soát quy trình và hệ thống', FALSE),
((SELECT id FROM ex), 'B'::option_label, 'Focuses on quarterly targets', 'Tập trung vào mục tiêu quý', FALSE),
((SELECT id FROM ex), 'C'::option_label, 'Inspires and motivates people toward a vision', 'Truyền cảm hứng và động viên mọi người hướng đến tầm nhìn', TRUE),
((SELECT id FROM ex), 'D'::option_label, 'Manages budgets and resources', 'Quản lý ngân sách và nguồn lực', FALSE);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'leadership-vs-management'),
 'true_false', 'easy',
 'A good manager is always a good leader.',
 'Một quản lý giỏi luôn là một lãnh đạo giỏi.',
 'false',
 'Management and leadership are distinct skill sets. A great manager may excel at organizing resources and hitting targets but struggle to inspire or communicate a compelling vision. Many excellent managers need to deliberately develop leadership skills separately.',
 'Quản lý và lãnh đạo là hai bộ kỹ năng khác nhau. Một quản lý xuất sắc có thể giỏi tổ chức nguồn lực và đạt mục tiêu nhưng gặp khó khăn trong việc truyền cảm hứng hay truyền đạt tầm nhìn hấp dẫn. Nhiều quản lý xuất sắc cần chủ động phát triển kỹ năng lãnh đạo riêng biệt.',
 3);

-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'leadership-vs-management'),
 'fill_blank', 'easy',
 'The four functions of management are planning, organizing, leading, and ___.',
 'Bốn chức năng quản lý là lập kế hoạch, tổ chức, lãnh đạo và ___.',
 'controlling',
 'Fayol''s four management functions (POLC) remain the foundation of modern management theory. Controlling means monitoring actual performance against planned goals and taking corrective action when deviations occur.',
 'Bốn chức năng quản lý của Fayol (POLC) vẫn là nền tảng của lý thuyết quản lý hiện đại. Kiểm soát có nghĩa là theo dõi hiệu suất thực tế so với mục tiêu đã lên kế hoạch và thực hiện hành động khắc phục khi có sai lệch.',
 4);

-- Exercise 5: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'leadership-vs-management'),
    'multiple_choice', 'medium',
    'Which leadership style involves the leader making all decisions alone without team input?',
    'Phong cách lãnh đạo nào liên quan đến lãnh đạo tự ra mọi quyết định một mình mà không có ý kiến nhóm?',
    'C',
    'The autocratic (authoritarian) style gives all decision-making power to the leader. This can be effective in crisis situations requiring fast, clear decisions, but over time it can reduce team morale, creativity, and engagement.',
    'Phong cách chuyên quyền (độc đoán) trao toàn bộ quyền ra quyết định cho lãnh đạo. Điều này có thể hiệu quả trong khủng hoảng cần quyết định nhanh, rõ ràng, nhưng lâu dài có thể giảm tinh thần, sáng tạo và sự gắn kết của nhóm.',
    5
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, 'Democratic', 'Dân chủ', FALSE),
((SELECT id FROM ex), 'B'::option_label, 'Laissez-faire', 'Tự do', FALSE),
((SELECT id FROM ex), 'C'::option_label, 'Autocratic', 'Chuyên quyền', TRUE),
((SELECT id FROM ex), 'D'::option_label, 'Transformational', 'Chuyển đổi', FALSE);

-- Exercise 6: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'leadership-vs-management'),
 'true_false', 'easy',
 'Transformational leadership focuses on inspiring change and growth in followers.',
 'Lãnh đạo chuyển đổi tập trung vào truyền cảm hứng thay đổi và phát triển cho người theo.',
 'true',
 'Transformational leadership (Burns, 1978; Bass, 1985) is defined by its focus on inspiring followers to exceed self-interest for the collective mission, stimulating innovation, and fostering individual development — leading to significant organizational change.',
 'Lãnh đạo chuyển đổi (Burns, 1978; Bass, 1985) được định nghĩa bởi việc truyền cảm hứng để người theo vượt qua lợi ích cá nhân vì sứ mệnh tập thể, kích thích đổi mới và nuôi dưỡng phát triển cá nhân — dẫn đến thay đổi tổ chức đáng kể.',
 6);

-- Exercise 7: sentence_transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'leadership-vs-management'),
 'sentence_transform', 'medium',
 'Transform "Leaders have followers" to contrast with how managers relate to their team.',
 'Chuyển đổi câu "Lãnh đạo có người theo" để đối chiếu với cách quản lý liên quan đến nhóm của họ.',
 'Leaders have followers who are inspired, while managers have subordinates who are directed',
 'This contrast highlights the relational difference: leadership is about voluntary, inspired followership (people choose to follow because they believe in the vision), while management involves directing subordinates within an organizational hierarchy.',
 'Sự tương phản này làm nổi bật sự khác biệt quan hệ: lãnh đạo là về sự theo dõi tự nguyện, đầy cảm hứng (mọi người chọn theo vì tin vào tầm nhìn), trong khi quản lý liên quan đến việc chỉ đạo cấp dưới trong hệ thống phân cấp tổ chức.',
 7);


-- ############################################################################
-- LESSON 2: DECISION MAKING FRAMEWORKS (slug: decision-making-frameworks)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Decision Making Frameworks', 'Khung Ra Quyết Định',
  'decision-making-frameworks',
  'Apply structured frameworks to make better decisions under uncertainty',
  'Áp dụng khung có cấu trúc để ra quyết định tốt hơn trong điều kiện không chắc chắn',
  'intermediate', 35, 2
FROM category WHERE name = 'Management';


-- ============================================================================
-- USAGES — decision-making-frameworks
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'decision-making-frameworks'),
 'SWOT Analysis', 'Phân Tích SWOT',
 'SWOT (Strengths, Weaknesses, Opportunities, Threats) is a strategic framework for evaluating internal capabilities versus external environment. It helps decision-makers understand their competitive position before committing to a course of action.',
 'SWOT (Điểm mạnh, Điểm yếu, Cơ hội, Thách thức) là khung chiến lược để đánh giá năng lực nội bộ so với môi trường bên ngoài. Nó giúp người ra quyết định hiểu vị thế cạnh tranh trước khi cam kết với một hướng đi.',
 'Analytics', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'decision-making-frameworks'),
 'Cost-Benefit Analysis', 'Phân Tích Chi Phí-Lợi Ích',
 'Cost-benefit analysis (CBA) systematically compares the total expected costs of an action against its total expected benefits. By quantifying both in the same unit (usually money), decision-makers can objectively evaluate whether an initiative is worthwhile.',
 'Phân tích chi phí-lợi ích (CBA) so sánh có hệ thống tổng chi phí dự kiến của một hành động với tổng lợi ích dự kiến. Bằng cách lượng hóa cả hai theo cùng đơn vị (thường là tiền), người ra quyết định có thể đánh giá khách quan liệu một sáng kiến có đáng thực hiện không.',
 'Balance', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'decision-making-frameworks'),
 'Cognitive Biases', 'Thiên Kiến Nhận Thức',
 'Cognitive biases are systematic errors in thinking that affect decisions. Common ones include confirmation bias (favoring confirming evidence), sunk cost fallacy (continuing bad investments due to past spending), and anchoring (over-relying on the first piece of information seen).',
 'Thiên kiến nhận thức là các lỗi tư duy có hệ thống ảnh hưởng đến quyết định. Các loại phổ biến bao gồm thiên kiến xác nhận (ưu tiên bằng chứng xác nhận), ngụy biện chi phí chìm (tiếp tục đầu tư xấu vì đã bỏ tiền), và neo đậu (phụ thuộc quá nhiều vào thông tin đầu tiên).',
 'Psychology', TRUE, 3);


-- ============================================================================
-- SECTIONS — decision-making-frameworks
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

((SELECT id FROM lesson WHERE slug = 'decision-making-frameworks'),
 'markdown', 'Decision Making Frameworks Overview', 'Tổng Quan Khung Ra Quyết Định',
'## Making Better Decisions Under Uncertainty

Every manager makes dozens of decisions daily — from resource allocation to personnel choices. Structured frameworks reduce the impact of biases and increase decision quality.

### SWOT Analysis

A foundational strategic planning tool that maps four dimensions:

| Internal | External |
|----------|----------|
| **Strengths** — what you do well | **Opportunities** — external trends to exploit |
| **Weaknesses** — areas to improve | **Threats** — external risks to mitigate |

**How to use it:** Strengths + Opportunities = strategic initiatives. Weaknesses + Threats = defensive priorities.

### Cost-Benefit Analysis (CBA)

> Decision is worth pursuing if: Total Benefits > Total Costs

Steps:
1. List all costs (direct, indirect, opportunity costs)
2. List all benefits (revenue, efficiency gains, risk reduction)
3. Assign monetary values to each
4. Calculate Net Present Value (NPV) if costs/benefits occur over time
5. Decide: proceed if NPV > 0

### Common Cognitive Biases in Decision Making

| Bias | Description | Mitigation |
|------|-------------|------------|
| **Confirmation bias** | Seeking evidence that confirms beliefs | Actively seek disconfirming evidence |
| **Sunk cost fallacy** | Continuing bad investments due to past spending | Ask: "Would I start this today knowing what I know?" |
| **Anchoring** | Over-relying on the first number seen | Use multiple reference points |
| **Availability heuristic** | Overweighting recent or vivid events | Use base rates and data |
| **Analysis paralysis** | Overthinking leading to decision inaction | Set a decision deadline |

### The Brainstorming Principle

Separate *idea generation* from *idea evaluation*. Brainstorming works best when judgment is suspended during generation — quantity over quality first, then filter.',

'## Ra Quyết Định Tốt Hơn Trong Điều Kiện Không Chắc Chắn

Mỗi quản lý ra hàng chục quyết định mỗi ngày — từ phân bổ nguồn lực đến lựa chọn nhân sự. Các khung có cấu trúc giảm tác động của thiên kiến và nâng cao chất lượng quyết định.

### Phân Tích SWOT

Công cụ lập kế hoạch chiến lược nền tảng ánh xạ bốn chiều:

| Nội bộ | Bên ngoài |
|--------|----------|
| **Điểm mạnh** — bạn làm tốt điều gì | **Cơ hội** — xu hướng bên ngoài để khai thác |
| **Điểm yếu** — lĩnh vực cần cải thiện | **Thách thức** — rủi ro bên ngoài cần giảm thiểu |

**Cách sử dụng:** Điểm mạnh + Cơ hội = sáng kiến chiến lược. Điểm yếu + Thách thức = ưu tiên phòng thủ.

### Phân Tích Chi Phí-Lợi Ích (CBA)

> Quyết định đáng theo đuổi nếu: Tổng lợi ích > Tổng chi phí

Các bước:
1. Liệt kê tất cả chi phí (trực tiếp, gián tiếp, chi phí cơ hội)
2. Liệt kê tất cả lợi ích (doanh thu, tiết kiệm hiệu quả, giảm rủi ro)
3. Gán giá trị tiền tệ cho từng mục
4. Tính Giá trị hiện tại ròng (NPV) nếu chi phí/lợi ích xảy ra theo thời gian
5. Quyết định: tiến hành nếu NPV > 0

### Thiên Kiến Nhận Thức Phổ Biến Trong Ra Quyết Định

| Thiên kiến | Mô tả | Giảm thiểu |
|-----------|-------|-----------|
| **Thiên kiến xác nhận** | Tìm bằng chứng xác nhận niềm tin | Chủ động tìm bằng chứng phủ nhận |
| **Ngụy biện chi phí chìm** | Tiếp tục đầu tư xấu do đã bỏ tiền | Hỏi: "Tôi có bắt đầu điều này hôm nay không?" |
| **Neo đậu** | Phụ thuộc quá nhiều vào con số đầu tiên | Dùng nhiều điểm tham chiếu |
| **Heuristic tính sẵn có** | Đánh giá quá cao sự kiện gần đây | Dùng tỷ lệ cơ sở và dữ liệu |
| **Tê liệt phân tích** | Suy nghĩ quá nhiều dẫn đến không hành động | Đặt hạn chót quyết định |

### Nguyên Tắc Brainstorming

Tách *tạo ý tưởng* khỏi *đánh giá ý tưởng*. Brainstorming hiệu quả nhất khi phán xét bị tạm hoãn trong giai đoạn tạo ý tưởng — số lượng trước chất lượng, rồi mới lọc.',
 1, NULL),

((SELECT id FROM lesson WHERE slug = 'decision-making-frameworks'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["SWOT phân tích Điểm mạnh, Điểm yếu, Cơ hội, Thách thức để định hướng chiến lược", "Phân tích chi phí-lợi ích lượng hóa tất cả chi phí và lợi ích dự kiến trước khi quyết định", "Thiên kiến xác nhận khiến chúng ta tìm kiếm thông tin xác nhận niềm tin hiện có", "Ngụy biện chi phí chìm là tiếp tục đầu tư xấu chỉ vì đã bỏ tiền vào đó", "Brainstorming tách biệt giai đoạn tạo ý tưởng và đánh giá ý tưởng để tăng sáng tạo"]'::jsonb),

((SELECT id FROM lesson WHERE slug = 'decision-making-frameworks'),
 'info_box', 'Beware of Cognitive Biases', 'Cảnh Giác Với Thiên Kiến Nhận Thức',
'**Warning:** Even experienced decision-makers fall prey to cognitive biases. Studies show that awareness alone is not enough — structured processes are required to counteract them.

**Practical checklist before any major decision:**
- Have I sought out evidence that contradicts my preferred option?
- Am I continuing this because it is truly good, or because of sunk costs?
- Have I considered at least three alternatives?
- Have I set a clear decision deadline to avoid analysis paralysis?

> Daniel Kahneman (Nobel Prize, 2002): *"We can be blind to the obvious, and we are also blind to our blindness."*',

'**Cảnh báo:** Ngay cả người ra quyết định có kinh nghiệm cũng dễ mắc vào thiên kiến nhận thức. Nghiên cứu cho thấy chỉ nhận thức là chưa đủ — cần quy trình có cấu trúc để chống lại chúng.

**Danh sách kiểm tra thực tế trước mọi quyết định lớn:**
- Tôi đã tìm kiếm bằng chứng mâu thuẫn với lựa chọn ưa thích chưa?
- Tôi có đang tiếp tục điều này vì nó thực sự tốt hay vì chi phí chìm?
- Tôi đã xem xét ít nhất ba lựa chọn thay thế chưa?
- Tôi đã đặt hạn chót quyết định rõ ràng để tránh tê liệt phân tích chưa?

> Daniel Kahneman (Nobel Prize, 2002): *"Chúng ta có thể mù quáng với điều hiển nhiên, và chúng ta cũng mù quáng với sự mù quáng của mình."*',
 3, NULL);


-- ============================================================================
-- EXERCISES — decision-making-frameworks (7 exercises)
-- ============================================================================

-- Exercise 1: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'decision-making-frameworks'),
    'multiple_choice', 'easy',
    'What does SWOT stand for?',
    'SWOT viết tắt của điều gì?',
    'B',
    'SWOT stands for Strengths, Weaknesses, Opportunities, and Threats. Developed in the 1960s at Stanford, it remains one of the most widely used strategic planning frameworks because it systematically maps both internal and external factors.',
    'SWOT viết tắt của Strengths (Điểm mạnh), Weaknesses (Điểm yếu), Opportunities (Cơ hội) và Threats (Thách thức). Được phát triển tại Stanford những năm 1960, nó vẫn là một trong những khung lập kế hoạch chiến lược được sử dụng rộng rãi nhất vì ánh xạ có hệ thống cả yếu tố nội bộ và bên ngoài.',
    1
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, 'Strategy, Workflow, Outcome, Target', 'Chiến lược, Quy trình, Kết quả, Mục tiêu', FALSE),
((SELECT id FROM ex), 'B'::option_label, 'Strengths, Weaknesses, Opportunities, Threats', 'Điểm mạnh, Điểm yếu, Cơ hội, Thách thức', TRUE),
((SELECT id FROM ex), 'C'::option_label, 'Systems, Workload, Operations, Timing', 'Hệ thống, Khối lượng công việc, Vận hành, Thời điểm', FALSE),
((SELECT id FROM ex), 'D'::option_label, 'Skills, Wisdom, Objectives, Tasks', 'Kỹ năng, Trí tuệ, Mục tiêu, Nhiệm vụ', FALSE);

-- Exercise 2: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'decision-making-frameworks'),
 'fill_blank', 'medium',
 'The tendency to favor information that confirms existing beliefs is called ___ bias.',
 'Xu hướng ưa thích thông tin xác nhận niềm tin hiện có được gọi là thiên kiến ___.',
 'confirmation',
 'Confirmation bias (Wason, 1960) is one of the most pervasive cognitive biases. It causes people to seek out, interpret, and remember information in a way that confirms their preexisting beliefs, making objective decision-making much harder.',
 'Thiên kiến xác nhận (Wason, 1960) là một trong những thiên kiến nhận thức phổ biến nhất. Nó khiến người ta tìm kiếm, giải thích và ghi nhớ thông tin theo cách xác nhận niềm tin trước của họ, khiến việc ra quyết định khách quan khó khăn hơn nhiều.',
 2);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'decision-making-frameworks'),
 'true_false', 'easy',
 'A cost-benefit analysis compares the total expected costs and benefits of a decision.',
 'Phân tích chi phí-lợi ích so sánh tổng chi phí và lợi ích dự kiến của một quyết định.',
 'true',
 'Cost-benefit analysis (CBA) is exactly this: a systematic process of quantifying all expected costs and benefits to determine if an action''s total benefits outweigh its total costs. When benefits > costs, the decision is economically justified.',
 'Phân tích chi phí-lợi ích (CBA) chính xác là điều này: quy trình có hệ thống để lượng hóa tất cả chi phí và lợi ích dự kiến nhằm xác định liệu tổng lợi ích của một hành động có vượt tổng chi phí không. Khi lợi ích > chi phí, quyết định được biện minh về mặt kinh tế.',
 3);

-- Exercise 4: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'decision-making-frameworks'),
    'multiple_choice', 'medium',
    'What is analysis paralysis?',
    'Tê liệt phân tích là gì?',
    'B',
    'Analysis paralysis occurs when over-analysis or over-thinking prevents a person or group from making a decision. It is often driven by fear of making the wrong choice and is made worse by perfectionism and cognitive overload.',
    'Tê liệt phân tích xảy ra khi phân tích hoặc suy nghĩ quá mức ngăn cản một người hoặc nhóm ra quyết định. Nó thường bị thúc đẩy bởi nỗi sợ đưa ra lựa chọn sai và trở nên tệ hơn bởi chủ nghĩa hoàn hảo và quá tải nhận thức.',
    4
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, 'A decision made too quickly without data', 'Quyết định đưa ra quá nhanh không có dữ liệu', FALSE),
((SELECT id FROM ex), 'B'::option_label, 'Overthinking a decision to the point of inaction', 'Suy nghĩ quá mức về quyết định đến mức không hành động', TRUE),
((SELECT id FROM ex), 'C'::option_label, 'Making decisions without any analysis', 'Ra quyết định mà không phân tích', FALSE),
((SELECT id FROM ex), 'D'::option_label, 'Group decision making with too many participants', 'Ra quyết định nhóm với quá nhiều người tham gia', FALSE);

-- Exercise 5: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'decision-making-frameworks'),
 'fill_blank', 'easy',
 'The ___ technique involves generating many ideas before evaluating them.',
 'Kỹ thuật ___ liên quan đến việc tạo ra nhiều ý tưởng trước khi đánh giá chúng.',
 'brainstorming',
 'Brainstorming (Osborn, 1953) separates idea generation from evaluation. The key rule is to defer judgment — no criticism during the generation phase. This psychological safety allows wild and creative ideas to surface before filtering begins.',
 'Brainstorming (Osborn, 1953) tách biệt tạo ý tưởng khỏi đánh giá. Quy tắc chính là hoãn phán xét — không phê bình trong giai đoạn tạo ý tưởng. Sự an toàn tâm lý này cho phép những ý tưởng táo bạo và sáng tạo xuất hiện trước khi bắt đầu lọc.',
 5);

-- Exercise 6: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'decision-making-frameworks'),
 'true_false', 'medium',
 'Sunk cost fallacy means continuing a bad investment because of past spending.',
 'Ngụy biện chi phí chìm có nghĩa là tiếp tục một khoản đầu tư xấu vì đã chi tiêu trong quá khứ.',
 'true',
 'The sunk cost fallacy occurs when past, unrecoverable investments (money, time, effort) influence future decisions. Rational decision-making should only consider future costs and benefits — not what has already been spent and cannot be recovered.',
 'Ngụy biện chi phí chìm xảy ra khi các khoản đầu tư trong quá khứ không thể thu hồi (tiền, thời gian, công sức) ảnh hưởng đến quyết định tương lai. Ra quyết định hợp lý chỉ nên xem xét chi phí và lợi ích tương lai — không phải những gì đã chi và không thể thu hồi.',
 6);

-- Exercise 7: arrange_words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'decision-making-frameworks'),
 'arrange_words', 'medium',
 'Arrange the words to form a key principle of good decision making.',
 'Sắp xếp các từ để tạo thành nguyên tắc then chốt của việc ra quyết định tốt.',
 'Effective decision making requires both data analysis and intuition',
 '["Effective", "decision", "making", "requires", "both", "data", "analysis", "and", "intuition"]',
 'Good decision making integrates two modes: analytical thinking (data, frameworks, logic) and intuitive thinking (experience, pattern recognition, gut feeling). Over-relying on only one mode leads to either analysis paralysis or reckless gut-feel decisions.',
 'Ra quyết định tốt tích hợp hai chế độ: tư duy phân tích (dữ liệu, khung, logic) và tư duy trực giác (kinh nghiệm, nhận dạng mẫu, cảm giác ruột). Phụ thuộc quá nhiều vào chỉ một chế độ dẫn đến tê liệt phân tích hoặc quyết định liều lĩnh theo cảm giác.',
 7);


-- ############################################################################
-- LESSON 3: TEAM DYNAMICS (slug: team-dynamics)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Team Dynamics', 'Động Lực Nhóm',
  'team-dynamics',
  'Understand team development stages, motivation, and conflict resolution',
  'Hiểu các giai đoạn phát triển nhóm, động lực và giải quyết xung đột',
  'intermediate', 30, 3
FROM category WHERE name = 'Management';


-- ============================================================================
-- USAGES — team-dynamics
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'team-dynamics'),
 'Tuckman''s Stages', 'Các Giai Đoạn Của Tuckman',
 'Bruce Tuckman (1965) identified four stages all teams move through: Forming (orientation, polite), Storming (conflict, competition), Norming (cohesion, rules established), and Performing (high effectiveness). A fifth stage, Adjourning, was added in 1977.',
 'Bruce Tuckman (1965) xác định bốn giai đoạn mọi nhóm trải qua: Hình thành (định hướng, lịch sự), Bão táp (xung đột, cạnh tranh), Ổn định (gắn kết, quy tắc được thiết lập) và Thực hiện (hiệu quả cao). Giai đoạn thứ năm, Giải tán, được thêm vào năm 1977.',
 'Groups', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'team-dynamics'),
 'Motivation Theories', 'Lý Thuyết Động Lực',
 'Key motivation theories include Maslow''s Hierarchy of Needs (5 levels from survival to self-actualization), Herzberg''s Two-Factor Theory (hygiene factors prevent dissatisfaction; motivators create satisfaction), and McClelland''s Theory of Needs (achievement, affiliation, and power).',
 'Các lý thuyết động lực quan trọng bao gồm Tháp nhu cầu Maslow (5 cấp từ sinh tồn đến tự hiện thực), Lý thuyết Hai yếu tố của Herzberg (yếu tố vệ sinh ngăn bất mãn; yếu tố động lực tạo sự hài lòng) và Lý thuyết Nhu cầu của McClelland (thành tích, liên kết và quyền lực).',
 'Psychology', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'team-dynamics'),
 'Conflict Resolution', 'Giải Quyết Xung Đột',
 'Thomas-Kilmann (1974) identified five conflict resolution styles: Competing (win-lose), Accommodating (lose-win), Avoiding (lose-lose), Compromising (partial win-win), and Collaborating (full win-win). Collaborating takes the most time but produces the most durable outcomes.',
 'Thomas-Kilmann (1974) xác định năm phong cách giải quyết xung đột: Cạnh tranh (thắng-thua), Nhượng bộ (thua-thắng), Né tránh (thua-thua), Thỏa hiệp (thắng một phần-thắng một phần) và Hợp tác (thắng hoàn toàn-thắng hoàn toàn). Hợp tác mất nhiều thời gian nhất nhưng tạo ra kết quả bền vững nhất.',
 'Handshake', TRUE, 3);


-- ============================================================================
-- SECTIONS — team-dynamics
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

((SELECT id FROM lesson WHERE slug = 'team-dynamics'),
 'markdown', 'Understanding Team Dynamics', 'Hiểu Động Lực Nhóm',
'## How Teams Grow and Perform

High-performing teams do not emerge overnight — they evolve through predictable stages, require careful motivation, and must navigate conflict constructively.

### Tuckman''s Five Stages of Team Development

| Stage | Behavior | Leader''s Role |
|-------|----------|----------------|
| **Forming** | Polite, uncertain, dependent on leader | Direct, set clear expectations |
| **Storming** | Conflict, competition, frustration | Coach, facilitate conflict resolution |
| **Norming** | Cohesion, trust, agreed norms | Support, step back |
| **Performing** | High autonomy, interdependence, results | Delegate, remove obstacles |
| **Adjourning** | Closure, reflection, disbanding | Celebrate, capture lessons learned |

> Teams can regress (e.g., from Performing back to Storming) if membership changes or a major challenge disrupts team norms.

### Maslow''s Hierarchy of Needs (1943)

```
        ▲ Self-Actualization (growth, creativity)
       ▲▲▲ Esteem (recognition, achievement)
      ▲▲▲▲▲ Social (belonging, relationships)
     ▲▲▲▲▲▲▲ Safety (security, stability)
    ▲▲▲▲▲▲▲▲▲ Physiological (food, shelter, pay)
```

Lower needs must be satisfied before higher ones become motivating. In a work context: fair pay and safe conditions are prerequisites before recognition or purpose motivate people.

### Conflict Resolution Styles (Thomas-Kilmann)

- **Collaborating** — Both parties work together to find a solution that fully satisfies both needs. Best for complex issues where relationships matter.
- **Compromising** — Both parties give up something. Useful when time is limited.
- **Competing** — One party wins. Appropriate in emergencies or clear ethical violations.
- **Accommodating** — You yield to the other. Good for preserving relationships on low-stakes issues.
- **Avoiding** — Conflict is sidestepped. Appropriate only when the issue is trivial or timing is wrong.

### Psychological Safety (Google''s Project Aristotle, 2016)

The single strongest predictor of team effectiveness is **psychological safety** — the shared belief that the team is safe for interpersonal risk-taking. Teams with high psychological safety speak up, admit errors, and innovate more.',

'## Cách Nhóm Phát Triển và Hoạt Động

Các nhóm hiệu quả cao không xuất hiện qua đêm — chúng phát triển qua các giai đoạn có thể dự đoán, cần động lực cẩn thận và phải điều hướng xung đột mang tính xây dựng.

### Năm Giai Đoạn Phát Triển Nhóm Của Tuckman

| Giai đoạn | Hành vi | Vai trò lãnh đạo |
|-----------|---------|-----------------|
| **Hình thành** | Lịch sự, không chắc chắn, phụ thuộc lãnh đạo | Chỉ đạo, đặt kỳ vọng rõ ràng |
| **Bão táp** | Xung đột, cạnh tranh, thất vọng | Hướng dẫn, tạo điều kiện giải quyết xung đột |
| **Ổn định** | Gắn kết, tin tưởng, chuẩn mực đã thống nhất | Hỗ trợ, lùi lại |
| **Thực hiện** | Tự chủ cao, phụ thuộc lẫn nhau, kết quả | Ủy quyền, loại bỏ rào cản |
| **Giải tán** | Kết thúc, suy ngẫm, giải thể | Ăn mừng, ghi lại bài học |

> Nhóm có thể tụt hậu (ví dụ: từ Thực hiện trở lại Bão táp) nếu thành viên thay đổi hoặc thách thức lớn làm gián đoạn chuẩn mực nhóm.

### Tháp Nhu Cầu Của Maslow (1943)

```
        ▲ Tự hiện thực (phát triển, sáng tạo)
       ▲▲▲ Tự trọng (công nhận, thành tích)
      ▲▲▲▲▲ Xã hội (thuộc về, các mối quan hệ)
     ▲▲▲▲▲▲▲ An toàn (bảo mật, ổn định)
    ▲▲▲▲▲▲▲▲▲ Sinh lý (thức ăn, nơi ở, lương)
```

Nhu cầu thấp hơn phải được thỏa mãn trước khi nhu cầu cao hơn trở thành động lực. Trong bối cảnh công việc: lương công bằng và điều kiện an toàn là điều kiện tiên quyết trước khi sự công nhận hoặc mục đích động lực mọi người.

### Phong Cách Giải Quyết Xung Đột (Thomas-Kilmann)

- **Hợp tác** — Cả hai bên cùng tìm giải pháp thỏa mãn đầy đủ cả hai nhu cầu. Tốt nhất cho vấn đề phức tạp khi mối quan hệ quan trọng.
- **Thỏa hiệp** — Cả hai bên nhường một phần. Hữu ích khi thời gian hạn hẹp.
- **Cạnh tranh** — Một bên thắng. Thích hợp trong khẩn cấp hoặc vi phạm đạo đức rõ ràng.
- **Nhượng bộ** — Bạn nhường cho người kia. Tốt để bảo tồn mối quan hệ trong vấn đề ít quan trọng.
- **Né tránh** — Xung đột bị né tránh. Chỉ thích hợp khi vấn đề tầm thường hoặc thời điểm không đúng.

### An Toàn Tâm Lý (Project Aristotle của Google, 2016)

Yếu tố dự đoán mạnh nhất duy nhất về hiệu quả nhóm là **an toàn tâm lý** — niềm tin chung rằng nhóm an toàn để chấp nhận rủi ro giữa cá nhân. Các nhóm có an toàn tâm lý cao lên tiếng, thừa nhận lỗi và đổi mới nhiều hơn.',
 1, NULL),

((SELECT id FROM lesson WHERE slug = 'team-dynamics'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["Tuckman: nhóm trải qua Hình thành → Bão táp → Ổn định → Thực hiện → Giải tán", "Giai đoạn Bão táp là bình thường — nhóm học cách giải quyết xung đột và xây dựng tin tưởng", "Maslow: 5 cấp nhu cầu từ sinh lý đến tự hiện thực — nhu cầu thấp hơn phải được đáp ứng trước", "McClelland: con người được thúc đẩy bởi ba nhu cầu — thành tích, liên kết và quyền lực", "An toàn tâm lý là yếu tố dự đoán mạnh nhất về hiệu suất nhóm (Project Aristotle, Google)"]'::jsonb),

((SELECT id FROM lesson WHERE slug = 'team-dynamics'),
 'chart', 'Team Performance Over Development Stages', 'Hiệu Suất Nhóm Qua Các Giai Đoạn',
 'Team performance typically dips during Storming before rising sharply in Norming and Performing. Adjourning sees a natural decline as the team disperses.',
 'Hiệu suất nhóm thường giảm trong Bão táp trước khi tăng mạnh ở Ổn định và Thực hiện. Giải tán thấy sự suy giảm tự nhiên khi nhóm giải thể.',
 3,
 '{"type": "line", "title": "Team Performance Over Development Stages", "titleVi": "Hiệu suất nhóm qua các giai đoạn", "xAxisLabel": "Stage", "yAxisLabel": "Performance", "series": [{"name": "Performance", "nameVi": "Hiệu suất", "color": "#f59e0b"}], "data": [{"name": "Forming", "Performance": 30}, {"name": "Storming", "Performance": 20}, {"name": "Norming", "Performance": 50}, {"name": "Performing", "Performance": 90}, {"name": "Adjourning", "Performance": 70}]}'::jsonb);


-- ============================================================================
-- EXERCISES — team-dynamics (7 exercises)
-- ============================================================================

-- Exercise 1: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'team-dynamics'),
    'multiple_choice', 'easy',
    'In which of Tuckman''s stages do team conflicts typically emerge?',
    'Trong giai đoạn nào của Tuckman xung đột nhóm thường xuất hiện?',
    'B',
    'Storming is the stage where personality clashes, competition for roles, and disagreements about direction surface. This is normal and necessary — teams that skip Storming often have unresolved tensions that emerge later. A leader''s job is to facilitate, not suppress, healthy conflict.',
    'Bão táp là giai đoạn mà xung đột tính cách, cạnh tranh vai trò và bất đồng về hướng đi xuất hiện. Điều này bình thường và cần thiết — các nhóm bỏ qua Bão táp thường có căng thẳng chưa giải quyết xuất hiện sau này. Vai trò của lãnh đạo là tạo điều kiện, không kìm nén, xung đột lành mạnh.',
    1
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, 'Forming', 'Hình thành', FALSE),
((SELECT id FROM ex), 'B'::option_label, 'Storming', 'Bão táp', TRUE),
((SELECT id FROM ex), 'C'::option_label, 'Norming', 'Ổn định', FALSE),
((SELECT id FROM ex), 'D'::option_label, 'Performing', 'Thực hiện', FALSE);

-- Exercise 2: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'team-dynamics'),
 'fill_blank', 'easy',
 'Maslow''s hierarchy of needs has ___ levels, from basic survival to self-actualization.',
 'Tháp nhu cầu của Maslow có ___ cấp, từ sinh tồn cơ bản đến tự hiện thực.',
 '5',
 'Maslow''s hierarchy (1943) has 5 levels: (1) Physiological, (2) Safety, (3) Social/Belonging, (4) Esteem, (5) Self-Actualization. In a work context, managers must ensure lower needs (fair pay, job security, belonging) before higher motivators (recognition, growth opportunities) become effective.',
 'Tháp của Maslow (1943) có 5 cấp: (1) Sinh lý, (2) An toàn, (3) Xã hội/Thuộc về, (4) Tự trọng, (5) Tự hiện thực. Trong bối cảnh công việc, quản lý phải đảm bảo nhu cầu thấp hơn (lương công bằng, bảo đảm việc làm, thuộc về) trước khi các yếu tố động lực cao hơn (công nhận, cơ hội phát triển) trở nên hiệu quả.',
 2);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'team-dynamics'),
 'true_false', 'easy',
 'In the Performing stage, the team operates with high efficiency and autonomy.',
 'Trong giai đoạn Thực hiện, nhóm vận hành với hiệu quả và tự chủ cao.',
 'true',
 'The Performing stage is the pinnacle of Tuckman''s model. Team members are highly skilled, trust each other deeply, resolve conflicts constructively, and require minimal supervision. The leader''s role shifts to removing obstacles and strategic thinking rather than day-to-day direction.',
 'Giai đoạn Thực hiện là đỉnh cao của mô hình Tuckman. Các thành viên có kỹ năng cao, tin tưởng lẫn nhau sâu sắc, giải quyết xung đột mang tính xây dựng và cần giám sát tối thiểu. Vai trò của lãnh đạo chuyển sang loại bỏ rào cản và tư duy chiến lược thay vì chỉ đạo hàng ngày.',
 3);

-- Exercise 4: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'team-dynamics'),
    'multiple_choice', 'medium',
    'Which conflict resolution style seeks a win-win outcome for all parties?',
    'Phong cách giải quyết xung đột nào tìm kiếm kết quả thắng-thắng cho tất cả các bên?',
    'C',
    'Collaborating (Thomas-Kilmann) is the only style that attempts to fully satisfy both parties'' needs. It requires open communication, creativity, and trust. While it takes the most time and effort, it produces the most durable agreements and preserves relationships.',
    'Hợp tác (Thomas-Kilmann) là phong cách duy nhất cố gắng thỏa mãn đầy đủ nhu cầu của cả hai bên. Nó đòi hỏi giao tiếp cởi mở, sáng tạo và tin tưởng. Mặc dù tốn nhiều thời gian và công sức nhất, nó tạo ra thỏa thuận bền vững nhất và bảo tồn mối quan hệ.',
    4
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, 'Competing', 'Cạnh tranh', FALSE),
((SELECT id FROM ex), 'B'::option_label, 'Avoiding', 'Né tránh', FALSE),
((SELECT id FROM ex), 'C'::option_label, 'Collaborating', 'Hợp tác', TRUE),
((SELECT id FROM ex), 'D'::option_label, 'Accommodating', 'Nhượng bộ', FALSE);

-- Exercise 5: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'team-dynamics'),
 'fill_blank', 'medium',
 'McClelland''s theory says people are motivated by three needs: achievement, affiliation, and ___.',
 'Lý thuyết của McClelland nói rằng con người được thúc đẩy bởi ba nhu cầu: thành tích, liên kết và ___.',
 'power',
 'McClelland''s Acquired Needs Theory (1961) proposes that the need for Achievement (nAch), Affiliation (nAff), and Power (nPow) are learned through experience. High nAch individuals prefer challenging goals and personal responsibility; high nPow individuals are motivated by influence and leadership roles; high nAff individuals prioritize belonging and harmonious relationships.',
 'Lý thuyết Nhu cầu Học được của McClelland (1961) đề xuất rằng nhu cầu về Thành tích (nAch), Liên kết (nAff) và Quyền lực (nPow) được học qua kinh nghiệm. Cá nhân có nAch cao ưa thích mục tiêu thách thức và trách nhiệm cá nhân; nPow cao được thúc đẩy bởi ảnh hưởng và vai trò lãnh đạo; nAff cao ưu tiên thuộc về và mối quan hệ hài hòa.',
 5);

-- Exercise 6: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'team-dynamics'),
 'true_false', 'medium',
 'Psychological safety means team members feel safe taking risks and speaking up without fear of punishment.',
 'An toàn tâm lý có nghĩa là các thành viên nhóm cảm thấy an toàn khi chấp nhận rủi ro và lên tiếng mà không sợ bị trừng phạt.',
 'true',
 'Amy Edmondson (1999) coined "psychological safety" to describe a team climate where members believe interpersonal risks — admitting mistakes, asking questions, challenging ideas — will not be met with embarrassment, rejection, or punishment. Google''s Project Aristotle (2016) found it is the top predictor of team effectiveness.',
 'Amy Edmondson (1999) đặt ra thuật ngữ "an toàn tâm lý" để mô tả môi trường nhóm nơi các thành viên tin rằng rủi ro giữa cá nhân — thừa nhận lỗi, đặt câu hỏi, thách thức ý tưởng — sẽ không bị đáp lại bằng xấu hổ, từ chối hay trừng phạt. Project Aristotle của Google (2016) phát hiện đây là yếu tố dự đoán hàng đầu về hiệu quả nhóm.',
 6);

-- Exercise 7: error_correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'team-dynamics'),
 'error_correction', 'medium',
 'Fix the grammar and factual errors: "Teams goes through forming, storming, norming and performing stage before achieved their goal"',
 'Sửa lỗi ngữ pháp và thực tế: "Teams goes through forming, storming, norming and performing stage before achieved their goal"',
 'Teams go through forming, storming, norming, and performing stages before achieving their goals',
 'Corrections: (1) "goes" → "go" (subject-verb agreement: "Teams" is plural); (2) "stage" → "stages" (plural for four stages); (3) "before achieved" → "before achieving" (gerund after preposition "before"); (4) "goal" → "goals" (plural to match the plural subject). The Oxford comma before "and" is also added for clarity.',
 'Sửa: (1) "goes" → "go" (sự hòa hợp chủ ngữ-động từ: "Teams" là số nhiều); (2) "stage" → "stages" (số nhiều cho bốn giai đoạn); (3) "before achieved" → "before achieving" (danh động từ sau giới từ "before"); (4) "goal" → "goals" (số nhiều để khớp với chủ ngữ số nhiều). Dấu phẩy Oxford trước "and" cũng được thêm vào để rõ ràng hơn.',
 7);
