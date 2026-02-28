-- ============================================================================
-- SEED DATA: Business & Strategy (New Categories)
-- Categories: Marketing & Media, Negotiation & Persuasion,
--             Supply Chain & Logistics, Game Theory, Military Strategy
-- Lessons: 10 total (2 per category)
-- Run AFTER: seed_topics.sql (categories must exist)
-- ============================================================================


-- ############################################################################
-- CATEGORY 1: MARKETING & MEDIA
-- ############################################################################


-- ############################################################################
-- LESSON 1: MARKETING FUNDAMENTALS (slug: marketing-fundamentals)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Marketing Fundamentals', 'Nền Tảng Marketing',
  'marketing-fundamentals',
  'Learn the core principles of marketing: the 4Ps, segmentation, and value creation',
  'Tìm hiểu nguyên tắc cốt lõi của marketing: 4P, phân khúc và tạo giá trị',
  'beginner', 25, 1
FROM category WHERE name = 'Marketing & Media';


-- ============================================================================
-- USAGES — marketing-fundamentals
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'marketing-fundamentals'),
 'The Marketing Mix (4Ps)', 'Marketing Hỗn Hợp (4P)',
 'The 4Ps — Product, Price, Place, Promotion — form the foundation of every marketing strategy. Marketers adjust these four levers to position offerings and reach target audiences effectively.',
 '4P — Sản phẩm, Giá cả, Phân phối, Xúc tiến — tạo nền tảng cho mọi chiến lược marketing. Nhà tiếp thị điều chỉnh bốn đòn bẩy này để định vị sản phẩm và tiếp cận khách hàng mục tiêu hiệu quả.',
 'Campaign', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'marketing-fundamentals'),
 'Market Segmentation', 'Phân Khúc Thị Trường',
 'Segmentation divides a broad market into smaller subgroups based on demographics, psychographics, geography, or behavior. This allows marketers to tailor messages and products to specific customer needs rather than one-size-fits-all.',
 'Phân khúc chia thị trường rộng thành các nhóm nhỏ dựa trên nhân khẩu học, tâm lý, địa lý hoặc hành vi. Điều này cho phép nhà tiếp thị tùy chỉnh thông điệp và sản phẩm cho nhu cầu cụ thể thay vì cách tiếp cận chung chung.',
 'PieChart', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'marketing-fundamentals'),
 'Value Proposition', 'Đề Xuất Giá Trị',
 'A value proposition clearly states why a customer should choose your product over competitors. It communicates the unique benefits and solves a specific problem. Strong value propositions are concise, customer-focused, and differentiated.',
 'Đề xuất giá trị nêu rõ tại sao khách hàng nên chọn sản phẩm của bạn thay vì đối thủ. Nó truyền đạt lợi ích độc đáo và giải quyết vấn đề cụ thể. Đề xuất giá trị mạnh mẽ cần ngắn gọn, tập trung vào khách hàng và khác biệt hóa.',
 'Lightbulb', TRUE, 3);


-- ============================================================================
-- SECTIONS — marketing-fundamentals
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

((SELECT id FROM lesson WHERE slug = 'marketing-fundamentals'),
 'markdown', 'Overview', 'Tổng Quan',
'## Marketing Fundamentals: Creating and Delivering Value

Marketing is the process of **creating, communicating, and delivering value** to customers. It goes far beyond advertising — it encompasses understanding customer needs, designing products, setting prices, and building relationships.

### The Marketing Mix — 4Ps (McCarthy, 1960)

| P | Element | Key Question |
|---|---------|-------------|
| **Product** | What you sell | Does it solve a real customer problem? |
| **Price** | What you charge | Does the price reflect perceived value? |
| **Place** | Where you sell | Is the product available where customers shop? |
| **Promotion** | How you communicate | Are you reaching the right audience with the right message? |

### Market Segmentation

Not all customers are the same. Segmentation divides the market into groups:

- **Demographic** — age, gender, income, education
- **Psychographic** — values, lifestyle, personality
- **Geographic** — country, city, climate, urban vs rural
- **Behavioral** — purchase frequency, brand loyalty, usage occasion

### The STP Framework

1. **Segment** the market into meaningful groups
2. **Target** the most attractive segments
3. **Position** your brand uniquely in customers'' minds

### Value Proposition Canvas

A strong value proposition answers three questions:
- **What problem** does the customer have?
- **What solution** does your product offer?
- **Why is your solution better** than alternatives?

> Philip Kotler: *"Marketing is not the art of finding clever ways to dispose of what you make. It is the art of creating genuine customer value."*',

'## Nền Tảng Marketing: Tạo và Cung Cấp Giá Trị

Marketing là quá trình **tạo ra, truyền thông và cung cấp giá trị** cho khách hàng. Nó vượt xa quảng cáo — bao gồm hiểu nhu cầu khách hàng, thiết kế sản phẩm, định giá và xây dựng mối quan hệ.

### Marketing Hỗn Hợp — 4P (McCarthy, 1960)

| P | Yếu Tố | Câu Hỏi Then Chốt |
|---|---------|-------------------|
| **Product** | Bạn bán gì | Sản phẩm giải quyết vấn đề thực sự của khách hàng? |
| **Price** | Bạn tính giá bao nhiêu | Giá có phản ánh giá trị cảm nhận? |
| **Place** | Bạn bán ở đâu | Sản phẩm có sẵn nơi khách hàng mua sắm? |
| **Promotion** | Bạn truyền thông thế nào | Bạn có tiếp cận đúng đối tượng với thông điệp phù hợp? |

### Phân Khúc Thị Trường

Không phải tất cả khách hàng đều giống nhau. Phân khúc chia thị trường thành các nhóm:

- **Nhân khẩu học** — tuổi, giới tính, thu nhập, học vấn
- **Tâm lý** — giá trị, lối sống, tính cách
- **Địa lý** — quốc gia, thành phố, khí hậu, đô thị vs nông thôn
- **Hành vi** — tần suất mua, trung thành thương hiệu, dịp sử dụng

### Khung STP

1. **Phân khúc** thị trường thành các nhóm có ý nghĩa
2. **Nhắm mục tiêu** các phân khúc hấp dẫn nhất
3. **Định vị** thương hiệu một cách độc đáo trong tâm trí khách hàng

### Canvas Đề Xuất Giá Trị

Đề xuất giá trị mạnh trả lời ba câu hỏi:
- **Vấn đề gì** khách hàng gặp phải?
- **Giải pháp gì** sản phẩm bạn cung cấp?
- **Tại sao giải pháp của bạn tốt hơn** các lựa chọn thay thế?

> Philip Kotler: *"Marketing không phải nghệ thuật tìm cách thông minh để xử lý những gì bạn sản xuất. Đó là nghệ thuật tạo ra giá trị thực sự cho khách hàng."*',
 1, '{}'::jsonb),

((SELECT id FROM lesson WHERE slug = 'marketing-fundamentals'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["4P gồm Product (sản phẩm), Price (giá), Place (phân phối), Promotion (xúc tiến)", "Phân khúc thị trường chia khách hàng thành nhóm theo nhân khẩu, tâm lý, địa lý, hành vi", "STP: Phân khúc → Nhắm mục tiêu → Định vị là quy trình chiến lược marketing cốt lõi", "Đề xuất giá trị phải nêu rõ vấn đề, giải pháp và lý do tốt hơn đối thủ", "Marketing tạo giá trị thực cho khách hàng, không chỉ là quảng cáo sản phẩm"]'::jsonb),

((SELECT id FROM lesson WHERE slug = 'marketing-fundamentals'),
 'info_box', 'Real-World Example', 'Ví Dụ Thực Tế',
'**Case Study: Apple iPhone Launch (2007)**

Apple''s marketing for the original iPhone is a masterclass in the 4Ps:
- **Product**: A phone that combined an iPod, a phone, and an internet device — solving three problems at once
- **Price**: Premium pricing ($499) signaling quality and exclusivity
- **Place**: Apple Stores + AT&T exclusive — controlled distribution created scarcity
- **Promotion**: Steve Jobs'' legendary keynote generated massive word-of-mouth before any ad was run

The result? 6.1 million units sold in the first year — without discounts or mass-market distribution.',

'**Nghiên Cứu Điển Hình: Ra Mắt iPhone của Apple (2007)**

Marketing của Apple cho iPhone đầu tiên là bài học mẫu mực về 4P:
- **Sản phẩm**: Điện thoại kết hợp iPod, điện thoại và thiết bị internet — giải quyết ba vấn đề cùng lúc
- **Giá**: Định giá cao cấp ($499) thể hiện chất lượng và sự độc quyền
- **Phân phối**: Apple Store + độc quyền AT&T — phân phối có kiểm soát tạo ra sự khan hiếm
- **Xúc tiến**: Bài thuyết trình huyền thoại của Steve Jobs tạo ra hiệu ứng truyền miệng khổng lồ trước khi chạy bất kỳ quảng cáo nào

Kết quả? 6,1 triệu máy bán trong năm đầu tiên — không giảm giá, không phân phối đại trà.',
 3, '{"type": "info"}'::jsonb);


-- ============================================================================
-- EXERCISES — marketing-fundamentals (5 exercises)
-- ============================================================================

-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'marketing-fundamentals'),
 'fill_blank', 'easy',
 'The 4Ps of marketing are Product, Price, Place, and ___.',
 '4P của marketing gồm Product, Price, Place và ___.',
 'Promotion',
 'The Marketing Mix (4Ps) was introduced by E. Jerome McCarthy in 1960. Promotion includes all communication activities: advertising, public relations, sales promotions, and personal selling. It is how a company tells customers about its product and persuades them to buy.',
 'Marketing hỗn hợp (4P) được E. Jerome McCarthy giới thiệu năm 1960. Promotion (xúc tiến) bao gồm mọi hoạt động truyền thông: quảng cáo, quan hệ công chúng, khuyến mãi và bán hàng cá nhân. Đây là cách công ty thông báo cho khách hàng về sản phẩm và thuyết phục họ mua.',
 1);

-- Exercise 2: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'marketing-fundamentals'),
    'multiple_choice', 'easy',
    'Which type of market segmentation groups customers by their values, lifestyle, and personality?',
    'Loại phân khúc thị trường nào phân nhóm khách hàng theo giá trị, lối sống và tính cách?',
    'B',
    'Psychographic segmentation divides the market based on psychological traits such as values, attitudes, interests, and lifestyles. Unlike demographics (age, income), psychographics explain WHY customers buy. Two people of the same age and income may have vastly different purchasing motivations.',
    'Phân khúc tâm lý chia thị trường dựa trên đặc điểm tâm lý như giá trị, thái độ, sở thích và lối sống. Khác với nhân khẩu học (tuổi, thu nhập), tâm lý học giải thích TẠI SAO khách hàng mua. Hai người cùng tuổi và thu nhập có thể có động lực mua hàng rất khác nhau.',
    2
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, 'Demographic segmentation', 'Phân khúc nhân khẩu học', FALSE),
((SELECT id FROM ex), 'B'::option_label, 'Psychographic segmentation', 'Phân khúc tâm lý', TRUE),
((SELECT id FROM ex), 'C'::option_label, 'Geographic segmentation', 'Phân khúc địa lý', FALSE),
((SELECT id FROM ex), 'D'::option_label, 'Behavioral segmentation', 'Phân khúc hành vi', FALSE);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'marketing-fundamentals'),
 'true_false', 'easy',
 'A value proposition should focus on the product''s technical features rather than the customer''s problem.',
 'Đề xuất giá trị nên tập trung vào tính năng kỹ thuật của sản phẩm thay vì vấn đề của khách hàng.',
 'false',
 'A strong value proposition is always customer-centric, not product-centric. It starts with the customer''s pain point and explains how the product solves it better than alternatives. Features are supporting evidence, not the main message. Customers buy solutions to their problems, not lists of features.',
 'Đề xuất giá trị mạnh luôn lấy khách hàng làm trung tâm, không phải sản phẩm. Nó bắt đầu từ điểm đau của khách hàng và giải thích sản phẩm giải quyết nó tốt hơn các lựa chọn thay thế ra sao. Tính năng là bằng chứng hỗ trợ, không phải thông điệp chính. Khách hàng mua giải pháp cho vấn đề của họ, không phải danh sách tính năng.',
 3);

-- Exercise 4: error_correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'marketing-fundamentals'),
 'error_correction', 'medium',
 'Fix the errors: "The STP framework stands for Segmentation, Targeting, and Positioning. First you position, then you segment, then you target."',
 'Sửa lỗi: "Khung STP là Segmentation, Targeting, và Positioning. Đầu tiên bạn định vị, rồi phân khúc, rồi nhắm mục tiêu."',
 'The STP framework stands for Segmentation, Targeting, and Positioning. First you segment, then you target, then you position.',
 'The STP process must follow a strict logical order: (1) Segment the market into groups, (2) Target the most attractive segments, (3) Position your brand for those segments. You cannot position before you know who you are targeting, and you cannot target before you understand the segments.',
 'Quy trình STP phải tuân theo thứ tự logic nghiêm ngặt: (1) Phân khúc thị trường thành các nhóm, (2) Nhắm mục tiêu các phân khúc hấp dẫn nhất, (3) Định vị thương hiệu cho các phân khúc đó. Bạn không thể định vị trước khi biết mình nhắm mục tiêu ai, và không thể nhắm mục tiêu trước khi hiểu các phân khúc.',
 4);

-- Exercise 5: arrange_words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'marketing-fundamentals'),
 'arrange_words', 'medium',
 'Arrange the words to form a key marketing principle.',
 'Sắp xếp các từ để tạo thành nguyên tắc marketing then chốt.',
 'Marketing creates value by solving real customer problems',
 '["customer", "Marketing", "by", "creates", "real", "solving", "problems", "value"]',
 'This principle captures the essence of modern marketing philosophy. Marketing is not about pushing products — it is about understanding customer needs and creating solutions that deliver genuine value. Companies that focus on solving real problems build lasting customer relationships and sustainable competitive advantages.',
 'Nguyên tắc này nắm bắt bản chất của triết lý marketing hiện đại. Marketing không phải đẩy sản phẩm — mà là hiểu nhu cầu khách hàng và tạo giải pháp mang lại giá trị thực. Công ty tập trung giải quyết vấn đề thực sự xây dựng được mối quan hệ khách hàng bền vững và lợi thế cạnh tranh lâu dài.',
 5);


-- ############################################################################
-- LESSON 2: DIGITAL MARKETING STRATEGY (slug: digital-marketing-strategy)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Digital Marketing Strategy', 'Chiến Lược Marketing Kỹ Thuật Số',
  'digital-marketing-strategy',
  'Master SEO, content marketing, social media, and paid advertising fundamentals',
  'Nắm vững SEO, content marketing, mạng xã hội và nền tảng quảng cáo trả phí',
  'intermediate', 30, 2
FROM category WHERE name = 'Marketing & Media';


-- ============================================================================
-- USAGES — digital-marketing-strategy
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'digital-marketing-strategy'),
 'Search Engine Optimization', 'Tối Ưu Hóa Công Cụ Tìm Kiếm',
 'SEO improves website visibility in organic (non-paid) search results. It involves optimizing content, site structure, and backlinks so search engines rank pages higher for relevant queries. SEO is a long-term strategy that compounds over time.',
 'SEO cải thiện khả năng hiển thị website trong kết quả tìm kiếm tự nhiên (không trả phí). Nó bao gồm tối ưu hóa nội dung, cấu trúc trang và backlink để công cụ tìm kiếm xếp hạng trang cao hơn cho các truy vấn liên quan. SEO là chiến lược dài hạn tích lũy theo thời gian.',
 'Search', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'digital-marketing-strategy'),
 'Content Marketing', 'Marketing Nội Dung',
 'Content marketing attracts and retains audiences by creating valuable, relevant content — blogs, videos, infographics, podcasts. Instead of interrupting consumers with ads, it earns attention by providing information they actually want.',
 'Content marketing thu hút và giữ chân khán giả bằng cách tạo nội dung có giá trị, phù hợp — blog, video, infographic, podcast. Thay vì chen ngang người tiêu dùng bằng quảng cáo, nó giành được sự chú ý bằng cách cung cấp thông tin họ thực sự muốn.',
 'Article', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'digital-marketing-strategy'),
 'Paid Advertising (PPC)', 'Quảng Cáo Trả Phí (PPC)',
 'Pay-per-click advertising places ads on search engines and social platforms. Advertisers bid on keywords and pay only when someone clicks. Google Ads and Meta Ads are the two largest PPC platforms, together controlling over 50% of global digital ad spend.',
 'Quảng cáo trả phí theo click đặt quảng cáo trên công cụ tìm kiếm và nền tảng xã hội. Nhà quảng cáo đấu giá từ khóa và chỉ trả tiền khi có người nhấp. Google Ads và Meta Ads là hai nền tảng PPC lớn nhất, kiểm soát hơn 50% chi tiêu quảng cáo kỹ thuật số toàn cầu.',
 'Payments', TRUE, 3);


-- ============================================================================
-- SECTIONS — digital-marketing-strategy
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

((SELECT id FROM lesson WHERE slug = 'digital-marketing-strategy'),
 'markdown', 'Overview', 'Tổng Quan',
'## Digital Marketing Strategy: Reaching Customers Online

Digital marketing uses online channels to promote products and build brand awareness. Unlike traditional marketing (TV, print, radio), digital marketing is **measurable, targetable, and interactive**.

### Key Digital Marketing Channels

| Channel | Type | Strength | Metric |
|---------|------|----------|--------|
| **SEO** | Organic | Long-term traffic | Organic ranking, click-through rate |
| **Content Marketing** | Organic | Trust and authority | Engagement, time on page |
| **Social Media** | Organic + Paid | Community, brand awareness | Followers, shares, reach |
| **PPC (Google/Meta Ads)** | Paid | Immediate traffic | CPC, ROAS, conversion rate |
| **Email Marketing** | Owned | Retention, repeat purchase | Open rate, click rate, revenue |

### SEO: The Three Pillars

1. **On-page SEO** — keyword research, title tags, meta descriptions, content quality
2. **Technical SEO** — site speed, mobile-friendliness, crawlability, structured data
3. **Off-page SEO** — backlinks from reputable sites, social signals, brand mentions

### The Content Marketing Funnel

- **Top of Funnel (TOFU)** — Blog posts, social content (awareness)
- **Middle of Funnel (MOFU)** — Case studies, webinars, whitepapers (consideration)
- **Bottom of Funnel (BOFU)** — Free trials, demos, testimonials (decision)

### Key Metrics Every Digital Marketer Must Know

- **CPC** (Cost Per Click) — How much you pay per ad click
- **CTR** (Click-Through Rate) — Percentage of impressions that result in clicks
- **ROAS** (Return on Ad Spend) — Revenue generated per dollar spent on ads
- **CAC** (Customer Acquisition Cost) — Total cost to acquire one new customer
- **LTV** (Lifetime Value) — Total revenue a customer generates over their relationship

> *"Content is king, but distribution is queen — and she wears the pants."* — Jonathan Perelman, BuzzFeed',

'## Chiến Lược Marketing Kỹ Thuật Số: Tiếp Cận Khách Hàng Trực Tuyến

Marketing kỹ thuật số sử dụng kênh trực tuyến để quảng bá sản phẩm và xây dựng nhận diện thương hiệu. Khác với marketing truyền thống (TV, báo in, radio), marketing kỹ thuật số **đo lường được, nhắm mục tiêu được và tương tác được**.

### Các Kênh Marketing Kỹ Thuật Số Chính

| Kênh | Loại | Thế Mạnh | Chỉ Số |
|------|------|----------|--------|
| **SEO** | Tự nhiên | Lưu lượng dài hạn | Thứ hạng tự nhiên, tỷ lệ nhấp |
| **Content Marketing** | Tự nhiên | Uy tín và thẩm quyền | Tương tác, thời gian trên trang |
| **Mạng Xã Hội** | Tự nhiên + Trả phí | Cộng đồng, nhận diện thương hiệu | Người theo dõi, chia sẻ, tiếp cận |
| **PPC (Google/Meta Ads)** | Trả phí | Lưu lượng tức thì | CPC, ROAS, tỷ lệ chuyển đổi |
| **Email Marketing** | Sở hữu | Giữ chân, mua lại | Tỷ lệ mở, tỷ lệ nhấp, doanh thu |

### SEO: Ba Trụ Cột

1. **On-page SEO** — nghiên cứu từ khóa, thẻ tiêu đề, mô tả meta, chất lượng nội dung
2. **Technical SEO** — tốc độ trang, thân thiện di động, khả năng thu thập, dữ liệu có cấu trúc
3. **Off-page SEO** — backlink từ trang uy tín, tín hiệu xã hội, đề cập thương hiệu

### Phễu Content Marketing

- **Đầu phễu (TOFU)** — Bài blog, nội dung mạng xã hội (nhận biết)
- **Giữa phễu (MOFU)** — Case study, webinar, whitepaper (cân nhắc)
- **Cuối phễu (BOFU)** — Dùng thử miễn phí, demo, lời chứng thực (quyết định)

### Chỉ Số Quan Trọng Mỗi Marketer Kỹ Thuật Số Phải Biết

- **CPC** (Chi Phí Mỗi Nhấp) — Bạn trả bao nhiêu cho mỗi nhấp quảng cáo
- **CTR** (Tỷ Lệ Nhấp) — Phần trăm hiển thị dẫn đến nhấp chuột
- **ROAS** (Lợi Nhuận Trên Chi Phí Quảng Cáo) — Doanh thu trên mỗi đô la quảng cáo
- **CAC** (Chi Phí Thu Hút Khách Hàng) — Tổng chi phí để có một khách hàng mới
- **LTV** (Giá Trị Trọn Đời) — Tổng doanh thu khách hàng tạo ra trong suốt mối quan hệ

> *"Nội dung là vua, nhưng phân phối là hoàng hậu — và bà ấy nắm quyền."* — Jonathan Perelman, BuzzFeed',
 1, '{}'::jsonb),

((SELECT id FROM lesson WHERE slug = 'digital-marketing-strategy'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["SEO gồm ba trụ cột: on-page, technical và off-page — chiến lược dài hạn tích lũy theo thời gian", "Content marketing thu hút khán giả bằng giá trị thay vì chen ngang bằng quảng cáo", "PPC (Pay-Per-Click) cho lưu lượng tức thì nhưng cần tối ưu CPC và ROAS liên tục", "Phễu content: TOFU (nhận biết) → MOFU (cân nhắc) → BOFU (quyết định)", "Chỉ số quan trọng: CPC, CTR, ROAS, CAC, LTV — đo lường mọi thứ trong digital marketing"]'::jsonb),

((SELECT id FROM lesson WHERE slug = 'digital-marketing-strategy'),
 'info_box', 'SEO vs PPC: When to Use Which?', 'SEO vs PPC: Khi Nào Dùng Cái Nào?',
'**SEO** is best when you have time and want sustainable, compounding traffic. It typically takes 3-6 months to see results, but once pages rank, traffic is essentially free.

**PPC** is best when you need immediate results — launching a new product, running a promotion, or testing a new market. Results are instant but stop the moment you stop paying.

**The ideal strategy combines both:** Use PPC for immediate visibility while building SEO for long-term organic growth. Many companies allocate 60-70% of budget to SEO/content and 30-40% to paid advertising.',

'**SEO** phù hợp nhất khi bạn có thời gian và muốn lưu lượng bền vững, tích lũy. Thường mất 3-6 tháng để thấy kết quả, nhưng khi trang đã xếp hạng, lưu lượng gần như miễn phí.

**PPC** phù hợp nhất khi bạn cần kết quả ngay lập tức — ra mắt sản phẩm mới, chạy khuyến mãi hoặc thử nghiệm thị trường mới. Kết quả tức thì nhưng dừng ngay khi ngừng trả tiền.

**Chiến lược lý tưởng kết hợp cả hai:** Dùng PPC cho khả năng hiển thị tức thì trong khi xây dựng SEO cho tăng trưởng tự nhiên dài hạn. Nhiều công ty phân bổ 60-70% ngân sách cho SEO/nội dung và 30-40% cho quảng cáo trả phí.',
 3, '{"type": "info"}'::jsonb);


-- ============================================================================
-- EXERCISES — digital-marketing-strategy (5 exercises)
-- ============================================================================

-- Exercise 1: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'digital-marketing-strategy'),
    'multiple_choice', 'easy',
    'Which of the following is NOT one of the three pillars of SEO?',
    'Điều nào sau đây KHÔNG phải là một trong ba trụ cột của SEO?',
    'D',
    'The three pillars of SEO are on-page (content optimization), technical (site performance and crawlability), and off-page (backlinks and authority). Social media marketing is a separate digital marketing channel, not a pillar of SEO — though social signals can indirectly support SEO efforts.',
    'Ba trụ cột của SEO là on-page (tối ưu nội dung), technical (hiệu suất trang và khả năng thu thập), và off-page (backlink và uy tín). Marketing mạng xã hội là kênh marketing kỹ thuật số riêng biệt, không phải trụ cột của SEO — dù tín hiệu xã hội có thể gián tiếp hỗ trợ nỗ lực SEO.',
    1
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, 'On-page SEO', 'SEO on-page', FALSE),
((SELECT id FROM ex), 'B'::option_label, 'Technical SEO', 'SEO kỹ thuật', FALSE),
((SELECT id FROM ex), 'C'::option_label, 'Off-page SEO', 'SEO off-page', FALSE),
((SELECT id FROM ex), 'D'::option_label, 'Social media SEO', 'SEO mạng xã hội', TRUE);

-- Exercise 2: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'digital-marketing-strategy'),
 'fill_blank', 'easy',
 'ROAS stands for Return on Ad ___.',
 'ROAS là viết tắt của Return on Ad ___.',
 'Spend',
 'ROAS (Return on Ad Spend) measures the revenue generated for every dollar spent on advertising. For example, a ROAS of 4:1 means $4 revenue for every $1 spent. It is the most important metric for evaluating paid advertising effectiveness.',
 'ROAS (Lợi Nhuận Trên Chi Phí Quảng Cáo) đo lường doanh thu tạo ra cho mỗi đô la chi cho quảng cáo. Ví dụ, ROAS 4:1 nghĩa là $4 doanh thu cho mỗi $1 chi tiêu. Đây là chỉ số quan trọng nhất để đánh giá hiệu quả quảng cáo trả phí.',
 2);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'digital-marketing-strategy'),
 'true_false', 'medium',
 'Content at the top of the marketing funnel (TOFU) should focus on product demos and free trials.',
 'Nội dung ở đầu phễu marketing (TOFU) nên tập trung vào demo sản phẩm và dùng thử miễn phí.',
 'false',
 'TOFU content targets awareness — people who may not even know they have a problem yet. Blog posts, educational videos, and social media content work best here. Product demos and free trials are BOFU (bottom of funnel) content for people already considering a purchase. Pushing sales content too early drives potential customers away.',
 'Nội dung TOFU nhắm đến nhận biết — những người có thể chưa biết họ có vấn đề. Bài blog, video giáo dục và nội dung mạng xã hội hoạt động tốt nhất ở đây. Demo sản phẩm và dùng thử miễn phí là nội dung BOFU (cuối phễu) cho người đã cân nhắc mua hàng. Đẩy nội dung bán hàng quá sớm sẽ đẩy khách hàng tiềm năng đi.',
 3);

-- Exercise 4: sentence_transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'digital-marketing-strategy'),
 'sentence_transform', 'medium',
 'Rewrite this statement to be more accurate: "PPC advertising provides free, long-term website traffic."',
 'Viết lại câu này cho chính xác hơn: "Quảng cáo PPC cung cấp lưu lượng website miễn phí, dài hạn."',
 'PPC advertising provides immediate, paid website traffic that stops when the budget runs out',
 'PPC (Pay-Per-Click) is the opposite of free and long-term. You pay for every click, and traffic stops immediately when you stop paying. SEO, by contrast, provides free (organic) traffic that compounds over time. Understanding this distinction is crucial for budget allocation.',
 'PPC (Pay-Per-Click) ngược lại với miễn phí và dài hạn. Bạn trả tiền cho mỗi nhấp, và lưu lượng dừng ngay khi ngừng trả tiền. Ngược lại, SEO cung cấp lưu lượng miễn phí (tự nhiên) tích lũy theo thời gian. Hiểu sự khác biệt này rất quan trọng cho phân bổ ngân sách.',
 4);

-- Exercise 5: arrange_words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'digital-marketing-strategy'),
 'arrange_words', 'medium',
 'Arrange the content funnel stages in the correct order from top to bottom.',
 'Sắp xếp các giai đoạn phễu nội dung theo đúng thứ tự từ trên xuống dưới.',
 'Awareness, Consideration, Decision',
 '["Decision", "Awareness", "Consideration"]',
 'The marketing funnel moves from broad to narrow: Awareness (TOFU) captures attention, Consideration (MOFU) nurtures interest with deeper content, and Decision (BOFU) converts with product-specific offers. Each stage requires different content types and messaging strategies.',
 'Phễu marketing di chuyển từ rộng đến hẹp: Nhận biết (TOFU) thu hút sự chú ý, Cân nhắc (MOFU) nuôi dưỡng sự quan tâm với nội dung sâu hơn, và Quyết định (BOFU) chuyển đổi với ưu đãi sản phẩm cụ thể. Mỗi giai đoạn cần loại nội dung và chiến lược thông điệp khác nhau.',
 5);


-- ############################################################################
-- CATEGORY 2: NEGOTIATION & PERSUASION
-- ############################################################################


-- ############################################################################
-- LESSON 3: PRINCIPLES OF NEGOTIATION (slug: principles-of-negotiation)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Principles of Negotiation', 'Nguyên Tắc Đàm Phán',
  'principles-of-negotiation',
  'Learn foundational negotiation concepts: BATNA, win-win, and interest-based bargaining',
  'Tìm hiểu khái niệm đàm phán nền tảng: BATNA, win-win và đàm phán dựa trên lợi ích',
  'beginner', 25, 1
FROM category WHERE name = 'Negotiation & Persuasion';


-- ============================================================================
-- USAGES — principles-of-negotiation
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'principles-of-negotiation'),
 'BATNA: Your Best Alternative', 'BATNA: Lựa Chọn Thay Thế Tốt Nhất',
 'BATNA (Best Alternative to a Negotiated Agreement) is the most important concept in negotiation. It is your plan B — what you will do if the current negotiation fails. A strong BATNA gives you leverage; a weak BATNA puts you at a disadvantage.',
 'BATNA (Phương án thay thế tốt nhất cho thỏa thuận đàm phán) là khái niệm quan trọng nhất trong đàm phán. Đây là kế hoạch B — điều bạn sẽ làm nếu đàm phán hiện tại thất bại. BATNA mạnh cho bạn đòn bẩy; BATNA yếu đặt bạn vào thế bất lợi.',
 'Shield', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'principles-of-negotiation'),
 'Win-Win Negotiation', 'Đàm Phán Đôi Bên Cùng Có Lợi',
 'Win-win (integrative) negotiation seeks outcomes where both parties gain value. Instead of fighting over a fixed pie, skilled negotiators expand the pie by identifying shared interests and creative trade-offs that satisfy both sides.',
 'Đàm phán đôi bên cùng có lợi (tích hợp) tìm kiếm kết quả mà cả hai bên đều nhận được giá trị. Thay vì tranh giành miếng bánh cố định, nhà đàm phán giỏi mở rộng miếng bánh bằng cách xác định lợi ích chung và trao đổi sáng tạo thỏa mãn cả hai bên.',
 'Handshake', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'principles-of-negotiation'),
 'Interest vs Position', 'Lợi Ích vs Lập Trường',
 'Positions are what people say they want ("I need a higher salary"). Interests are the underlying reasons why ("I need financial security for my family"). Effective negotiators look past positions to uncover interests, which opens up more creative solutions.',
 'Lập trường là điều mọi người nói họ muốn ("Tôi cần lương cao hơn"). Lợi ích là lý do sâu xa tại sao ("Tôi cần an toàn tài chính cho gia đình"). Nhà đàm phán hiệu quả nhìn qua lập trường để khám phá lợi ích, mở ra nhiều giải pháp sáng tạo hơn.',
 'Lightbulb', TRUE, 3);


-- ============================================================================
-- SECTIONS — principles-of-negotiation
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

((SELECT id FROM lesson WHERE slug = 'principles-of-negotiation'),
 'markdown', 'Overview', 'Tổng Quan',
'## Principles of Negotiation: Getting to Yes

Negotiation is a dialogue between two or more parties aimed at reaching a mutually beneficial agreement. Whether you are negotiating a salary, a business deal, or a household chore schedule, the same fundamental principles apply.

### BATNA — Your Source of Power

> Fisher & Ury (Getting to Yes, 1981): *"The reason you negotiate is to produce something better than the results you can obtain without negotiating."*

| BATNA Strength | Effect on Negotiation |
|---------------|----------------------|
| **Strong BATNA** | You can walk away confidently → more leverage |
| **Weak BATNA** | You feel pressured to accept bad terms |
| **Unknown BATNA** | You negotiate blindly → worst position |

**Before any negotiation:**
1. Identify your BATNA
2. Try to improve your BATNA
3. Research the other party''s likely BATNA

### Distributive vs Integrative Negotiation

| Aspect | Distributive (Win-Lose) | Integrative (Win-Win) |
|--------|------------------------|----------------------|
| **Mindset** | Fixed pie — one wins, other loses | Expanding pie — both can gain |
| **Focus** | Positions ("I want X") | Interests ("I need X because...") |
| **Relationship** | Short-term, adversarial | Long-term, collaborative |
| **Information** | Hidden, strategic | Shared, transparent |
| **Example** | Haggling over price | Salary + benefits + schedule package |

### The Four Principles of Principled Negotiation (Fisher & Ury)

1. **Separate people from the problem** — Attack the issue, not the person
2. **Focus on interests, not positions** — Ask "why?" behind every demand
3. **Generate options for mutual gain** — Brainstorm before deciding
4. **Use objective criteria** — Base agreements on fair standards, not power',

'## Nguyên Tắc Đàm Phán: Đi Đến Thỏa Thuận

Đàm phán là cuộc đối thoại giữa hai hoặc nhiều bên nhằm đạt thỏa thuận có lợi cho tất cả. Dù bạn đàm phán lương, thương vụ kinh doanh hay lịch chia việc nhà, các nguyên tắc cơ bản đều giống nhau.

### BATNA — Nguồn Sức Mạnh Của Bạn

> Fisher & Ury (Getting to Yes, 1981): *"Lý do bạn đàm phán là để tạo ra thứ tốt hơn kết quả bạn có thể đạt được mà không đàm phán."*

| Sức Mạnh BATNA | Tác Động Lên Đàm Phán |
|----------------|----------------------|
| **BATNA mạnh** | Bạn có thể rời đi tự tin → nhiều đòn bẩy hơn |
| **BATNA yếu** | Bạn cảm thấy áp lực phải chấp nhận điều khoản xấu |
| **BATNA chưa biết** | Bạn đàm phán mù quáng → vị thế tệ nhất |

**Trước mọi cuộc đàm phán:**
1. Xác định BATNA của bạn
2. Cố gắng cải thiện BATNA
3. Nghiên cứu BATNA có thể của đối phương

### Đàm Phán Phân Phối vs Tích Hợp

| Khía Cạnh | Phân phối (Thắng-Thua) | Tích hợp (Win-Win) |
|-----------|------------------------|-------------------|
| **Tư duy** | Bánh cố định — một bên thắng, bên kia thua | Mở rộng bánh — cả hai đều được |
| **Tập trung** | Lập trường ("Tôi muốn X") | Lợi ích ("Tôi cần X vì...") |
| **Quan hệ** | Ngắn hạn, đối đầu | Dài hạn, hợp tác |
| **Thông tin** | Giấu, chiến lược | Chia sẻ, minh bạch |
| **Ví dụ** | Mặc cả giá | Gói lương + phúc lợi + lịch trình |

### Bốn Nguyên Tắc Đàm Phán Có Nguyên Tắc (Fisher & Ury)

1. **Tách con người khỏi vấn đề** — Tấn công vấn đề, không phải con người
2. **Tập trung vào lợi ích, không phải lập trường** — Hỏi "tại sao?" sau mỗi yêu cầu
3. **Tạo lựa chọn cho lợi ích chung** — Brainstorm trước khi quyết định
4. **Sử dụng tiêu chí khách quan** — Dựa thỏa thuận trên tiêu chuẩn công bằng, không phải quyền lực',
 1, '{}'::jsonb),

((SELECT id FROM lesson WHERE slug = 'principles-of-negotiation'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["BATNA là khái niệm quan trọng nhất — luôn xác định phương án thay thế trước khi đàm phán", "Đàm phán tích hợp (win-win) mở rộng miếng bánh thay vì tranh giành miếng bánh cố định", "Tập trung vào lợi ích (tại sao) thay vì lập trường (cái gì) mở ra giải pháp sáng tạo", "Bốn nguyên tắc Fisher & Ury: tách người khỏi vấn đề, lợi ích, lựa chọn, tiêu chí khách quan", "Thông tin là sức mạnh — nghiên cứu BATNA của đối phương trước khi đàm phán"]'::jsonb),

((SELECT id FROM lesson WHERE slug = 'principles-of-negotiation'),
 'info_box', 'Practical Example', 'Ví Dụ Thực Tế',
'**Scenario: Salary Negotiation**

A job candidate wants $90,000 but the company offers $75,000. This looks like a fixed-pie distributive negotiation.

**Positional approach:** "I need $90K." → "We can only offer $75K." → Deadlock.

**Interest-based approach:** The candidate''s real interest is financial security + career growth. The company''s interest is hiring talent within budget.

**Creative solution:** $80K base + $5K signing bonus + remote work 2 days/week + guaranteed review in 6 months. Total value exceeds $90K for the candidate, while the company stays within annual salary budget.

**Key takeaway:** By exploring interests beyond the salary number, both sides found a better deal than either initially proposed.',

'**Kịch bản: Đàm Phán Lương**

Ứng viên muốn $90.000 nhưng công ty đề nghị $75.000. Trông như đàm phán phân phối miếng bánh cố định.

**Cách tiếp cận lập trường:** "Tôi cần $90K." → "Chúng tôi chỉ đề nghị được $75K." → Bế tắc.

**Cách tiếp cận dựa trên lợi ích:** Lợi ích thực của ứng viên là an toàn tài chính + phát triển sự nghiệp. Lợi ích của công ty là tuyển nhân tài trong ngân sách.

**Giải pháp sáng tạo:** $80K lương cơ bản + $5K thưởng ký hợp đồng + làm việc từ xa 2 ngày/tuần + đánh giá đảm bảo sau 6 tháng. Tổng giá trị vượt $90K cho ứng viên, trong khi công ty vẫn trong ngân sách lương hàng năm.

**Bài học:** Bằng cách khám phá lợi ích ngoài con số lương, cả hai bên tìm thấy thỏa thuận tốt hơn cả hai đề xuất ban đầu.',
 3, '{"type": "info"}'::jsonb);


-- ============================================================================
-- EXERCISES — principles-of-negotiation (5 exercises)
-- ============================================================================

-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'principles-of-negotiation'),
 'fill_blank', 'easy',
 'BATNA stands for Best Alternative to a Negotiated ___.',
 'BATNA là viết tắt của Best Alternative to a Negotiated ___.',
 'Agreement',
 'BATNA (Best Alternative to a Negotiated Agreement) was coined by Roger Fisher and William Ury in "Getting to Yes" (1981). It represents your walkaway option — the best outcome you can achieve if the current negotiation fails. Knowing your BATNA prevents you from accepting deals worse than your alternatives.',
 'BATNA (Phương Án Thay Thế Tốt Nhất Cho Thỏa Thuận Đàm Phán) được Roger Fisher và William Ury đặt ra trong "Getting to Yes" (1981). Nó đại diện cho lựa chọn rời đi — kết quả tốt nhất bạn có thể đạt được nếu đàm phán hiện tại thất bại. Biết BATNA giúp bạn không chấp nhận thỏa thuận tệ hơn các lựa chọn thay thế.',
 1);

-- Exercise 2: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'principles-of-negotiation'),
    'multiple_choice', 'easy',
    'In interest-based negotiation, what should you focus on instead of positions?',
    'Trong đàm phán dựa trên lợi ích, bạn nên tập trung vào điều gì thay vì lập trường?',
    'C',
    'Fisher and Ury''s key insight is that positions (what people say they want) often mask underlying interests (why they want it). By asking "why?" behind every demand, negotiators can discover shared interests and creative solutions that satisfy both parties'' real needs.',
    'Insight quan trọng của Fisher và Ury là lập trường (điều mọi người nói họ muốn) thường che giấu lợi ích sâu xa (tại sao họ muốn). Bằng cách hỏi "tại sao?" sau mỗi yêu cầu, nhà đàm phán có thể khám phá lợi ích chung và giải pháp sáng tạo thỏa mãn nhu cầu thực của cả hai bên.',
    2
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, 'Deadlines and urgency', 'Thời hạn và sự cấp bách', FALSE),
((SELECT id FROM ex), 'B'::option_label, 'Power and authority', 'Quyền lực và thẩm quyền', FALSE),
((SELECT id FROM ex), 'C'::option_label, 'Underlying interests and needs', 'Lợi ích và nhu cầu sâu xa', TRUE),
((SELECT id FROM ex), 'D'::option_label, 'Past precedents only', 'Chỉ tiền lệ trong quá khứ', FALSE);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'principles-of-negotiation'),
 'true_false', 'easy',
 'In a distributive negotiation, both parties can increase total value by expanding the pie.',
 'Trong đàm phán phân phối, cả hai bên có thể tăng tổng giá trị bằng cách mở rộng miếng bánh.',
 'false',
 'Distributive (win-lose) negotiation assumes a fixed pie — one party''s gain is the other''s loss. It is the integrative (win-win) approach that expands the pie by finding creative trade-offs. In distributive bargaining, the total value is fixed and parties compete to claim the largest share.',
 'Đàm phán phân phối (thắng-thua) giả định miếng bánh cố định — lợi ích của bên này là thua thiệt của bên kia. Cách tiếp cận tích hợp (win-win) mới mở rộng miếng bánh bằng cách tìm trao đổi sáng tạo. Trong mặc cả phân phối, tổng giá trị cố định và các bên cạnh tranh để giành phần lớn nhất.',
 3);

-- Exercise 4: error_correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'principles-of-negotiation'),
 'error_correction', 'medium',
 'Fix the errors: "The four principles of negotiation is: focus on positions not interests, attack the person not the problem, limit options, and use subjective criteria."',
 'Sửa lỗi: "Bốn nguyên tắc đàm phán là: tập trung vào lập trường không phải lợi ích, tấn công con người không phải vấn đề, hạn chế lựa chọn, và dùng tiêu chí chủ quan."',
 'The four principles of negotiation are: focus on interests not positions, separate the people from the problem, generate options for mutual gain, and use objective criteria.',
 'Every element was reversed: (1) Focus on interests, not positions — positions hide real needs. (2) Separate people from the problem — attack the issue, not the person. (3) Generate options (not limit them) for mutual gain. (4) Use objective (not subjective) criteria. These four principles from "Getting to Yes" form the foundation of principled negotiation.',
 'Mọi yếu tố đều bị đảo ngược: (1) Tập trung vào lợi ích, không phải lập trường — lập trường che giấu nhu cầu thực. (2) Tách con người khỏi vấn đề — tấn công vấn đề, không phải con người. (3) Tạo ra (không hạn chế) lựa chọn cho lợi ích chung. (4) Dùng tiêu chí khách quan (không phải chủ quan). Bốn nguyên tắc này từ "Getting to Yes" tạo nền tảng cho đàm phán có nguyên tắc.',
 4);

-- Exercise 5: arrange_words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'principles-of-negotiation'),
 'arrange_words', 'medium',
 'Arrange the words to form a key negotiation principle.',
 'Sắp xếp các từ để tạo thành nguyên tắc đàm phán then chốt.',
 'A strong BATNA gives you the power to walk away',
 '["to", "A", "gives", "away", "BATNA", "walk", "strong", "the", "power", "you"]',
 'Your BATNA is the single most important source of negotiation power. If you have a strong alternative, you are not desperate to reach a deal, which means you can negotiate from a position of confidence. Always develop and improve your BATNA before entering any negotiation.',
 'BATNA là nguồn sức mạnh đàm phán quan trọng nhất. Nếu bạn có phương án thay thế mạnh, bạn không tuyệt vọng phải đạt thỏa thuận, nghĩa là bạn có thể đàm phán từ vị thế tự tin. Luôn phát triển và cải thiện BATNA trước khi bước vào bất kỳ cuộc đàm phán nào.',
 5);


-- ############################################################################
-- LESSON 4: ADVANCED PERSUASION TECHNIQUES (slug: advanced-persuasion-techniques)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Advanced Persuasion Techniques', 'Kỹ Thuật Thuyết Phục Nâng Cao',
  'advanced-persuasion-techniques',
  'Master Cialdini''s 6 principles of influence and advanced persuasion frameworks',
  'Nắm vững 6 nguyên tắc ảnh hưởng của Cialdini và khung thuyết phục nâng cao',
  'intermediate', 30, 2
FROM category WHERE name = 'Negotiation & Persuasion';


-- ============================================================================
-- USAGES — advanced-persuasion-techniques
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'advanced-persuasion-techniques'),
 'Cialdini''s 6 Principles', '6 Nguyên Tắc Của Cialdini',
 'Robert Cialdini identified six universal principles of influence: Reciprocity, Commitment/Consistency, Social Proof, Authority, Liking, and Scarcity. These psychological triggers are used in sales, marketing, negotiation, and everyday social interactions.',
 'Robert Cialdini xác định sáu nguyên tắc ảnh hưởng phổ quát: Có qua có lại, Cam kết/Nhất quán, Bằng chứng xã hội, Uy quyền, Thiện cảm và Khan hiếm. Những kích hoạt tâm lý này được dùng trong bán hàng, marketing, đàm phán và tương tác xã hội hàng ngày.',
 'Psychology', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'advanced-persuasion-techniques'),
 'Framing and Anchoring', 'Đóng Khung và Neo Đậu',
 'How you present information dramatically changes how people perceive it. Framing effects make the same data feel different depending on positive vs negative framing. Anchoring sets a reference point that biases all subsequent judgments.',
 'Cách bạn trình bày thông tin thay đổi đáng kể cách mọi người nhận thức nó. Hiệu ứng đóng khung khiến cùng một dữ liệu cảm nhận khác nhau tùy vào đóng khung tích cực hay tiêu cực. Neo đậu đặt điểm tham chiếu thiên lệch mọi phán xét tiếp theo.',
 'TrendingUp', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'advanced-persuasion-techniques'),
 'Ethical Persuasion', 'Thuyết Phục Có Đạo Đức',
 'Persuasion techniques are powerful tools that carry ethical responsibility. Ethical persuasion is transparent, honest, and aims for mutual benefit. Manipulation, by contrast, involves deception or exploitation. Understanding the difference is essential for long-term trust and credibility.',
 'Kỹ thuật thuyết phục là công cụ mạnh mẽ đi kèm trách nhiệm đạo đức. Thuyết phục có đạo đức minh bạch, trung thực và hướng đến lợi ích chung. Ngược lại, thao túng liên quan đến lừa dối hoặc lợi dụng. Hiểu sự khác biệt rất quan trọng cho niềm tin và uy tín dài hạn.',
 'Verified', TRUE, 3);


-- ============================================================================
-- SECTIONS — advanced-persuasion-techniques
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

((SELECT id FROM lesson WHERE slug = 'advanced-persuasion-techniques'),
 'markdown', 'Overview', 'Tổng Quan',
'## Advanced Persuasion Techniques: The Science of Influence

Persuasion is the ability to change someone''s beliefs, attitudes, or behaviors through communication. Robert Cialdini''s research identified six universal principles that drive human compliance.

### Cialdini''s 6 Principles of Influence (1984)

| Principle | Mechanism | Example |
|-----------|-----------|---------|
| **Reciprocity** | People repay favors | Free sample → feeling obligated to buy |
| **Commitment** | People stay consistent with past actions | Small "yes" leads to bigger "yes" |
| **Social Proof** | People follow the crowd | "9 out of 10 dentists recommend..." |
| **Authority** | People defer to experts | Doctor''s white coat increases compliance |
| **Liking** | People say yes to those they like | Salespeople build rapport first |
| **Scarcity** | People want what''s limited | "Only 3 left in stock!" |

### Framing Effects

The same information feels different depending on how it is framed:
- **Positive frame:** "This surgery has a 90% survival rate" → People agree
- **Negative frame:** "This surgery has a 10% mortality rate" → People hesitate

Both statements are identical — but framing changes the emotional response and decision.

### Anchoring in Negotiation

The first number mentioned in a negotiation becomes the **anchor** — a reference point that biases all subsequent numbers.
- Seller lists house at $500K → negotiation centers around $450-520K
- Seller lists house at $400K → negotiation centers around $360-420K

**Strategy:** Make the first offer (if well-informed) to set a favorable anchor.

### Ethical vs Manipulative Persuasion

| Ethical Persuasion | Manipulation |
|-------------------|--------------|
| Transparent intent | Hidden agenda |
| Truthful information | Deception or omission |
| Respects autonomy | Exploits vulnerability |
| Mutual benefit | One-sided gain |
| Builds trust | Erodes trust |',

'## Kỹ Thuật Thuyết Phục Nâng Cao: Khoa Học Ảnh Hưởng

Thuyết phục là khả năng thay đổi niềm tin, thái độ hoặc hành vi của ai đó qua giao tiếp. Nghiên cứu của Robert Cialdini xác định sáu nguyên tắc phổ quát thúc đẩy sự tuân thủ.

### 6 Nguyên Tắc Ảnh Hưởng Của Cialdini (1984)

| Nguyên Tắc | Cơ Chế | Ví Dụ |
|------------|--------|-------|
| **Có qua có lại** | Mọi người trả ơn | Mẫu miễn phí → cảm giác phải mua |
| **Cam kết** | Mọi người nhất quán với hành động trước | "Có" nhỏ dẫn đến "có" lớn hơn |
| **Bằng chứng xã hội** | Mọi người theo số đông | "9/10 nha sĩ khuyên dùng..." |
| **Uy quyền** | Mọi người tuân theo chuyên gia | Áo blouse bác sĩ tăng sự tuân thủ |
| **Thiện cảm** | Mọi người đồng ý với người họ thích | Nhân viên bán hàng xây dựng quan hệ trước |
| **Khan hiếm** | Mọi người muốn thứ hạn chế | "Chỉ còn 3 sản phẩm!" |

### Hiệu Ứng Đóng Khung

Cùng một thông tin cảm nhận khác nhau tùy cách đóng khung:
- **Khung tích cực:** "Ca phẫu thuật có tỷ lệ sống 90%" → Mọi người đồng ý
- **Khung tiêu cực:** "Ca phẫu thuật có tỷ lệ tử vong 10%" → Mọi người do dự

Cả hai câu giống hệt nhau — nhưng đóng khung thay đổi phản ứng cảm xúc và quyết định.

### Neo Đậu Trong Đàm Phán

Con số đầu tiên được đề cập trong đàm phán trở thành **neo** — điểm tham chiếu thiên lệch mọi con số tiếp theo.
- Người bán niêm yết nhà $500K → đàm phán xoay quanh $450-520K
- Người bán niêm yết nhà $400K → đàm phán xoay quanh $360-420K

**Chiến lược:** Đưa ra đề nghị đầu tiên (nếu có thông tin tốt) để đặt neo có lợi.

### Thuyết Phục Có Đạo Đức vs Thao Túng

| Thuyết Phục Có Đạo Đức | Thao Túng |
|------------------------|-----------|
| Ý định minh bạch | Mục đích ẩn |
| Thông tin trung thực | Lừa dối hoặc bỏ sót |
| Tôn trọng quyền tự chủ | Lợi dụng điểm yếu |
| Lợi ích chung | Lợi ích một chiều |
| Xây dựng niềm tin | Xói mòn niềm tin |',
 1, '{}'::jsonb),

((SELECT id FROM lesson WHERE slug = 'advanced-persuasion-techniques'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["6 nguyên tắc Cialdini: Có qua có lại, Cam kết, Bằng chứng xã hội, Uy quyền, Thiện cảm, Khan hiếm", "Hiệu ứng đóng khung: cùng thông tin cảm nhận khác nhau tùy cách trình bày tích cực hay tiêu cực", "Neo đậu: con số đầu tiên trong đàm phán ảnh hưởng mạnh mẽ đến kết quả cuối cùng", "Thuyết phục có đạo đức minh bạch và hướng đến lợi ích chung; thao túng lừa dối và lợi dụng", "Hiểu các nguyên tắc này giúp bạn vừa thuyết phục hiệu quả vừa nhận diện khi bị thao túng"]'::jsonb),

((SELECT id FROM lesson WHERE slug = 'advanced-persuasion-techniques'),
 'info_box', 'Real-World Application', 'Ứng Dụng Thực Tế',
'**How Amazon Uses All 6 Principles:**

1. **Reciprocity** — Free shipping on Prime, free returns → customers feel valued
2. **Commitment** — "Add to cart" before "Buy now" → small commitment first
3. **Social Proof** — Star ratings, "X people bought this" → crowd validation
4. **Authority** — "Amazon''s Choice" badge → expert endorsement signal
5. **Liking** — Personalized recommendations ("Based on your interests") → feels personal
6. **Scarcity** — "Only 2 left in stock!" → urgency drives faster decisions

These are not accidents — every element is designed to trigger psychological compliance. As a consumer, recognizing these patterns gives you power. As a marketer, using them ethically builds lasting customer relationships.',

'**Cách Amazon Dùng Cả 6 Nguyên Tắc:**

1. **Có qua có lại** — Miễn phí vận chuyển Prime, đổi trả miễn phí → khách hàng cảm thấy được trân trọng
2. **Cam kết** — "Thêm vào giỏ" trước "Mua ngay" → cam kết nhỏ trước
3. **Bằng chứng xã hội** — Đánh giá sao, "X người đã mua" → xác nhận từ đám đông
4. **Uy quyền** — Huy hiệu "Amazon''s Choice" → tín hiệu xác nhận chuyên gia
5. **Thiện cảm** — Đề xuất cá nhân hóa ("Dựa trên sở thích của bạn") → cảm giác cá nhân
6. **Khan hiếm** — "Chỉ còn 2 sản phẩm!" → sự cấp bách thúc đẩy quyết định nhanh hơn

Đây không phải ngẫu nhiên — mọi yếu tố được thiết kế để kích hoạt tuân thủ tâm lý. Là người tiêu dùng, nhận ra các mẫu này cho bạn sức mạnh. Là nhà tiếp thị, sử dụng chúng có đạo đức xây dựng quan hệ khách hàng lâu dài.',
 3, '{"type": "info"}'::jsonb);


-- ============================================================================
-- EXERCISES — advanced-persuasion-techniques (5 exercises)
-- ============================================================================

-- Exercise 1: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'advanced-persuasion-techniques'),
    'multiple_choice', 'easy',
    'Which Cialdini principle is demonstrated when a store displays "Only 3 left in stock!"?',
    'Nguyên tắc Cialdini nào được thể hiện khi cửa hàng hiển thị "Chỉ còn 3 sản phẩm!"?',
    'D',
    'Scarcity triggers a fear of missing out (FOMO). When something appears limited, people perceive it as more valuable and feel urgency to act quickly. Marketers use countdown timers, limited editions, and low-stock warnings to leverage this principle.',
    'Khan hiếm kích hoạt nỗi sợ bỏ lỡ (FOMO). Khi thứ gì đó có vẻ hạn chế, mọi người coi nó có giá trị hơn và cảm thấy cấp bách phải hành động nhanh. Nhà tiếp thị dùng bộ đếm thời gian, phiên bản giới hạn và cảnh báo còn ít hàng để tận dụng nguyên tắc này.',
    1
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, 'Reciprocity', 'Có qua có lại', FALSE),
((SELECT id FROM ex), 'B'::option_label, 'Social Proof', 'Bằng chứng xã hội', FALSE),
((SELECT id FROM ex), 'C'::option_label, 'Authority', 'Uy quyền', FALSE),
((SELECT id FROM ex), 'D'::option_label, 'Scarcity', 'Khan hiếm', TRUE);

-- Exercise 2: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'advanced-persuasion-techniques'),
 'fill_blank', 'easy',
 'The first number mentioned in a negotiation is called the ___, and it biases all subsequent judgments.',
 'Con số đầu tiên được đề cập trong đàm phán gọi là ___, và nó thiên lệch mọi phán xét tiếp theo.',
 'anchor',
 'Anchoring is one of the most powerful cognitive biases in negotiation. Research by Tversky and Kahneman (1974) showed that even random numbers can serve as anchors. In negotiation, the party that makes the first offer often gains an advantage because their number becomes the reference point.',
 'Neo đậu là một trong những thiên kiến nhận thức mạnh nhất trong đàm phán. Nghiên cứu của Tversky và Kahneman (1974) cho thấy ngay cả con số ngẫu nhiên cũng có thể làm neo. Trong đàm phán, bên đưa ra đề nghị đầu tiên thường có lợi thế vì con số của họ trở thành điểm tham chiếu.',
 2);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'advanced-persuasion-techniques'),
 'true_false', 'medium',
 'Saying "This surgery has a 90% survival rate" and "This surgery has a 10% mortality rate" produce the same emotional response in most people.',
 'Nói "Ca phẫu thuật có tỷ lệ sống 90%" và "Ca phẫu thuật có tỷ lệ tử vong 10%" tạo ra phản ứng cảm xúc giống nhau ở hầu hết mọi người.',
 'false',
 'This is the classic framing effect demonstrated by Tversky and Kahneman. Although both statements convey identical information, the positive frame (90% survival) produces significantly more agreement than the negative frame (10% mortality). Our brains process gains and losses asymmetrically — a phenomenon called loss aversion.',
 'Đây là hiệu ứng đóng khung kinh điển được Tversky và Kahneman chứng minh. Dù cả hai câu truyền đạt thông tin giống hệt, khung tích cực (90% sống) tạo ra sự đồng ý nhiều hơn đáng kể so với khung tiêu cực (10% tử vong). Não chúng ta xử lý lợi ích và mất mát bất đối xứng — hiện tượng gọi là ác cảm mất mát.',
 3);

-- Exercise 4: sentence_transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'advanced-persuasion-techniques'),
 'sentence_transform', 'medium',
 'Reframe this negative statement into a positive frame: "30% of customers are dissatisfied with our service."',
 'Đóng khung lại câu tiêu cực thành tích cực: "30% khách hàng không hài lòng với dịch vụ của chúng tôi."',
 '70% of customers are satisfied with our service',
 'Positive framing presents the same data in terms of gains rather than losses. "70% satisfied" and "30% dissatisfied" are mathematically identical, but the positive frame feels dramatically better. Skilled communicators use framing strategically in presentations, reports, and negotiations.',
 'Đóng khung tích cực trình bày cùng dữ liệu theo lợi ích thay vì mất mát. "70% hài lòng" và "30% không hài lòng" giống nhau về toán học, nhưng khung tích cực cảm nhận tốt hơn đáng kể. Người giao tiếp giỏi sử dụng đóng khung chiến lược trong thuyết trình, báo cáo và đàm phán.',
 4);

-- Exercise 5: arrange_words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'advanced-persuasion-techniques'),
 'arrange_words', 'medium',
 'Arrange the six Cialdini principles in the order presented in his book.',
 'Sắp xếp sáu nguyên tắc Cialdini theo thứ tự trong sách của ông.',
 'Reciprocity, Commitment, Social Proof, Authority, Liking, Scarcity',
 '["Social Proof", "Reciprocity", "Scarcity", "Commitment", "Liking", "Authority"]',
 'In "Influence: The Psychology of Persuasion" (1984), Cialdini presents the principles in this order: Reciprocity, Commitment/Consistency, Social Proof, Authority, Liking, and Scarcity. Each principle exploits a different psychological shortcut that humans use to make decisions quickly.',
 'Trong "Influence: The Psychology of Persuasion" (1984), Cialdini trình bày các nguyên tắc theo thứ tự: Có qua có lại, Cam kết/Nhất quán, Bằng chứng xã hội, Uy quyền, Thiện cảm và Khan hiếm. Mỗi nguyên tắc khai thác một phím tắt tâm lý khác nhau mà con người dùng để ra quyết định nhanh.',
 5);


-- ############################################################################
-- CATEGORY 3: SUPPLY CHAIN & LOGISTICS
-- ############################################################################


-- ############################################################################
-- LESSON 5: SUPPLY CHAIN BASICS (slug: supply-chain-basics)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Supply Chain Basics', 'Cơ Bản Chuỗi Cung Ứng',
  'supply-chain-basics',
  'Understand supply chain components, flows, and the bullwhip effect',
  'Hiểu các thành phần, dòng chảy của chuỗi cung ứng và hiệu ứng roi da',
  'beginner', 25, 1
FROM category WHERE name = 'Supply Chain & Logistics';


-- ============================================================================
-- USAGES — supply-chain-basics
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'supply-chain-basics'),
 'Supply Chain Components', 'Thành Phần Chuỗi Cung Ứng',
 'A supply chain consists of suppliers, manufacturers, distributors, retailers, and customers. Each link adds value and cost. Effective supply chain management coordinates these components to deliver the right product, to the right place, at the right time, at the right cost.',
 'Chuỗi cung ứng gồm nhà cung cấp, nhà sản xuất, nhà phân phối, nhà bán lẻ và khách hàng. Mỗi mắt xích thêm giá trị và chi phí. Quản lý chuỗi cung ứng hiệu quả phối hợp các thành phần để giao đúng sản phẩm, đúng nơi, đúng thời điểm, đúng chi phí.',
 'LocalShipping', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'supply-chain-basics'),
 'Supply Chain Flows', 'Dòng Chảy Chuỗi Cung Ứng',
 'Three critical flows move through every supply chain: (1) Material flow — raw materials to finished goods moving downstream to customers, (2) Information flow — demand signals, forecasts, and orders moving upstream, (3) Financial flow — payments moving upstream from customers to suppliers.',
 'Ba dòng chảy quan trọng di chuyển qua mọi chuỗi cung ứng: (1) Dòng vật liệu — nguyên liệu thô đến thành phẩm di chuyển xuôi dòng đến khách hàng, (2) Dòng thông tin — tín hiệu nhu cầu, dự báo và đơn hàng di chuyển ngược dòng, (3) Dòng tài chính — thanh toán di chuyển ngược dòng từ khách hàng đến nhà cung cấp.',
 'SwapHoriz', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'supply-chain-basics'),
 'The Bullwhip Effect', 'Hiệu Ứng Roi Da',
 'The bullwhip effect describes how small demand fluctuations at the retail level get amplified as they move upstream through the supply chain. A 5% increase in customer demand can cause a 40% spike in supplier orders, leading to overproduction, excess inventory, and wasted resources.',
 'Hiệu ứng roi da mô tả cách biến động nhu cầu nhỏ ở cấp bán lẻ bị khuếch đại khi di chuyển ngược dòng qua chuỗi cung ứng. Tăng 5% nhu cầu khách hàng có thể gây tăng vọt 40% đơn hàng nhà cung cấp, dẫn đến sản xuất thừa, tồn kho dư và lãng phí tài nguyên.',
 'TrendingUp', TRUE, 3);


-- ============================================================================
-- SECTIONS — supply-chain-basics
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

((SELECT id FROM lesson WHERE slug = 'supply-chain-basics'),
 'markdown', 'Overview', 'Tổng Quan',
'## Supply Chain Basics: From Raw Material to Customer

A supply chain is the entire network of organizations, people, activities, and resources involved in creating and delivering a product from raw materials to the end customer.

### The Five Key Components

| Component | Role | Example |
|-----------|------|---------|
| **Suppliers** | Provide raw materials and components | Steel mills, cotton farms |
| **Manufacturers** | Transform materials into finished goods | Automobile factories, textile plants |
| **Distributors** | Store and move products in bulk | Regional warehouses, logistics hubs |
| **Retailers** | Sell to end consumers | Stores, e-commerce platforms |
| **Customers** | Create demand that drives the chain | Individual buyers, businesses |

### Three Critical Flows

Every supply chain has three parallel flows:

1. **Material Flow** (downstream): Raw materials → components → finished goods → customer
2. **Information Flow** (bidirectional): Demand forecasts, order data, tracking information
3. **Financial Flow** (upstream): Customer payment → retailer → distributor → manufacturer → supplier

### The Bullwhip Effect (Lee et al., 1997)

Small changes in consumer demand create increasingly larger swings upstream:

- Customer buys **10% more** → Retailer orders **20% more**
- Distributor orders **30% more** → Manufacturer orders **40% more**
- Supplier ramps up **50% more** production

**Causes:** Demand forecast errors, order batching, price fluctuations, rationing and shortage gaming.

**Solutions:** Information sharing, smaller/more frequent orders, stable pricing, collaborative planning (CPFR).

### Push vs Pull Supply Chains

| Aspect | Push (Make-to-Stock) | Pull (Make-to-Order) |
|--------|---------------------|---------------------|
| **Trigger** | Forecast | Actual customer order |
| **Inventory** | Higher (buffer stock) | Lower (build on demand) |
| **Lead time** | Shorter to customer | Longer to customer |
| **Risk** | Overproduction waste | Stockout if demand spikes |
| **Example** | Coca-Cola, toothpaste | Dell computers, custom furniture |',

'## Cơ Bản Chuỗi Cung Ứng: Từ Nguyên Liệu Thô Đến Khách Hàng

Chuỗi cung ứng là toàn bộ mạng lưới tổ chức, con người, hoạt động và tài nguyên liên quan đến việc tạo ra và giao sản phẩm từ nguyên liệu thô đến khách hàng cuối.

### Năm Thành Phần Chính

| Thành Phần | Vai Trò | Ví Dụ |
|------------|---------|-------|
| **Nhà cung cấp** | Cung cấp nguyên liệu và linh kiện | Nhà máy thép, trang trại bông |
| **Nhà sản xuất** | Biến nguyên liệu thành thành phẩm | Nhà máy ô tô, nhà máy dệt |
| **Nhà phân phối** | Lưu trữ và vận chuyển sản phẩm số lượng lớn | Kho khu vực, trung tâm logistics |
| **Nhà bán lẻ** | Bán cho người tiêu dùng cuối | Cửa hàng, nền tảng thương mại điện tử |
| **Khách hàng** | Tạo nhu cầu thúc đẩy chuỗi | Người mua cá nhân, doanh nghiệp |

### Ba Dòng Chảy Quan Trọng

Mọi chuỗi cung ứng có ba dòng chảy song song:

1. **Dòng Vật Liệu** (xuôi dòng): Nguyên liệu → linh kiện → thành phẩm → khách hàng
2. **Dòng Thông Tin** (hai chiều): Dự báo nhu cầu, dữ liệu đơn hàng, thông tin theo dõi
3. **Dòng Tài Chính** (ngược dòng): Thanh toán khách hàng → bán lẻ → phân phối → sản xuất → nhà cung cấp

### Hiệu Ứng Roi Da (Lee et al., 1997)

Thay đổi nhỏ trong nhu cầu người tiêu dùng tạo ra biến động ngày càng lớn ngược dòng:

- Khách hàng mua **thêm 10%** → Nhà bán lẻ đặt **thêm 20%**
- Nhà phân phối đặt **thêm 30%** → Nhà sản xuất đặt **thêm 40%**
- Nhà cung cấp tăng sản xuất **thêm 50%**

**Nguyên nhân:** Lỗi dự báo nhu cầu, gom đơn hàng, biến động giá, phân bổ và đầu cơ thiếu hụt.

**Giải pháp:** Chia sẻ thông tin, đơn hàng nhỏ/thường xuyên hơn, giá ổn định, lập kế hoạch hợp tác (CPFR).

### Chuỗi Cung Ứng Đẩy vs Kéo

| Khía Cạnh | Đẩy (Sản Xuất Theo Dự Báo) | Kéo (Sản Xuất Theo Đơn) |
|-----------|---------------------------|------------------------|
| **Kích hoạt** | Dự báo | Đơn hàng thực tế |
| **Tồn kho** | Cao (kho đệm) | Thấp (sản xuất theo nhu cầu) |
| **Thời gian giao** | Ngắn cho khách | Dài cho khách |
| **Rủi ro** | Lãng phí sản xuất thừa | Hết hàng khi nhu cầu tăng đột biến |
| **Ví dụ** | Coca-Cola, kem đánh răng | Máy tính Dell, nội thất đặt riêng |',
 1, '{}'::jsonb),

((SELECT id FROM lesson WHERE slug = 'supply-chain-basics'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["Chuỗi cung ứng gồm 5 thành phần: nhà cung cấp, sản xuất, phân phối, bán lẻ, khách hàng", "Ba dòng chảy: vật liệu (xuôi), thông tin (hai chiều), tài chính (ngược)", "Hiệu ứng roi da khuếch đại biến động nhu cầu nhỏ thành biến động lớn ngược dòng", "Giải pháp bullwhip: chia sẻ thông tin, đơn hàng nhỏ thường xuyên, giá ổn định, CPFR", "Push (dự báo) cho thời gian giao ngắn; Pull (theo đơn) cho tồn kho thấp"]'::jsonb),

((SELECT id FROM lesson WHERE slug = 'supply-chain-basics'),
 'info_box', 'Real-World Example', 'Ví Dụ Thực Tế',
'**The Toilet Paper Crisis (2020)**

During COVID-19, a classic bullwhip effect occurred with toilet paper:

1. Consumers panicked and bought 2-3x their normal amount
2. Retailers doubled orders to restock shelves
3. Distributors tripled orders to meet retailer demand
4. Manufacturers ran extra shifts and scrambled for raw materials
5. Pulp suppliers faced unprecedented demand spikes

The actual increase in consumption was only about 40% (people were home more), but orders at the manufacturer level spiked 700%. When panic buying stopped, the entire chain had massive excess inventory.

**Lesson:** Information sharing and transparent demand data could have prevented much of this amplification.',

'**Khủng Hoảng Giấy Vệ Sinh (2020)**

Trong COVID-19, hiệu ứng roi da kinh điển xảy ra với giấy vệ sinh:

1. Người tiêu dùng hoảng loạn và mua gấp 2-3 lần bình thường
2. Nhà bán lẻ tăng gấp đôi đơn hàng để bổ sung kệ hàng
3. Nhà phân phối tăng gấp ba đơn hàng để đáp ứng nhu cầu bán lẻ
4. Nhà sản xuất chạy ca thêm và tìm kiếm nguyên liệu
5. Nhà cung cấp bột giấy đối mặt với nhu cầu tăng đột biến chưa từng có

Mức tiêu thụ thực tế chỉ tăng khoảng 40% (mọi người ở nhà nhiều hơn), nhưng đơn hàng ở cấp nhà sản xuất tăng vọt 700%. Khi mua sắm hoảng loạn dừng lại, toàn chuỗi có tồn kho dư thừa khổng lồ.

**Bài học:** Chia sẻ thông tin và dữ liệu nhu cầu minh bạch có thể ngăn chặn phần lớn sự khuếch đại này.',
 3, '{"type": "info"}'::jsonb);


-- ============================================================================
-- EXERCISES — supply-chain-basics (5 exercises)
-- ============================================================================

-- Exercise 1: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'supply-chain-basics'),
    'multiple_choice', 'easy',
    'Which supply chain flow moves from customers back to suppliers?',
    'Dòng chảy chuỗi cung ứng nào di chuyển từ khách hàng ngược về nhà cung cấp?',
    'B',
    'Financial flow moves upstream — from customers who pay retailers, who pay distributors, who pay manufacturers, who pay suppliers. Material flow moves downstream (supplier to customer), and information flow moves bidirectionally.',
    'Dòng tài chính di chuyển ngược dòng — từ khách hàng trả tiền cho nhà bán lẻ, nhà bán lẻ trả nhà phân phối, nhà phân phối trả nhà sản xuất, nhà sản xuất trả nhà cung cấp. Dòng vật liệu di chuyển xuôi (nhà cung cấp đến khách hàng), và dòng thông tin di chuyển hai chiều.',
    1
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, 'Material flow', 'Dòng vật liệu', FALSE),
((SELECT id FROM ex), 'B'::option_label, 'Financial flow', 'Dòng tài chính', TRUE),
((SELECT id FROM ex), 'C'::option_label, 'Product flow', 'Dòng sản phẩm', FALSE),
((SELECT id FROM ex), 'D'::option_label, 'Logistics flow', 'Dòng logistics', FALSE);

-- Exercise 2: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'supply-chain-basics'),
 'fill_blank', 'easy',
 'The ___ effect describes how small demand changes at the retail level get amplified upstream in the supply chain.',
 'Hiệu ứng ___ mô tả cách biến động nhu cầu nhỏ ở cấp bán lẻ bị khuếch đại ngược dòng trong chuỗi cung ứng.',
 'bullwhip',
 'The bullwhip effect was formally described by Lee, Padmanabhan, and Whang in 1997. Like a bullwhip where a small flick of the wrist creates a large wave at the tip, small changes in end-consumer demand create progressively larger order swings as they move upstream through each supply chain layer.',
 'Hiệu ứng roi da được Lee, Padmanabhan và Whang mô tả chính thức năm 1997. Như roi da khi cổ tay flích nhẹ tạo sóng lớn ở đầu roi, thay đổi nhỏ trong nhu cầu người tiêu dùng cuối tạo ra biến động đơn hàng ngày càng lớn khi di chuyển ngược dòng qua mỗi tầng chuỗi cung ứng.',
 2);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'supply-chain-basics'),
 'true_false', 'easy',
 'In a pull supply chain, production is triggered by actual customer orders rather than demand forecasts.',
 'Trong chuỗi cung ứng kéo, sản xuất được kích hoạt bởi đơn hàng thực tế của khách hàng thay vì dự báo nhu cầu.',
 'true',
 'Pull (make-to-order) supply chains wait for actual customer demand before producing. This reduces excess inventory and waste but may result in longer delivery times. Dell pioneered this model in the PC industry, building computers only after receiving customer orders, which dramatically reduced inventory costs.',
 'Chuỗi cung ứng kéo (sản xuất theo đơn) chờ nhu cầu thực từ khách hàng trước khi sản xuất. Điều này giảm tồn kho dư và lãng phí nhưng có thể dẫn đến thời gian giao hàng dài hơn. Dell tiên phong mô hình này trong ngành PC, chỉ lắp ráp máy tính sau khi nhận đơn hàng, giảm đáng kể chi phí tồn kho.',
 3);

-- Exercise 4: error_correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'supply-chain-basics'),
 'error_correction', 'medium',
 'Fix the errors: "In a supply chain, material flows upstream from customers to suppliers, while financial flow moves downstream from suppliers to customers."',
 'Sửa lỗi: "Trong chuỗi cung ứng, dòng vật liệu chảy ngược dòng từ khách hàng đến nhà cung cấp, trong khi dòng tài chính di chuyển xuôi dòng từ nhà cung cấp đến khách hàng."',
 'In a supply chain, material flows downstream from suppliers to customers, while financial flow moves upstream from customers to suppliers.',
 'The directions are reversed: (1) Material flow moves downstream — raw materials from suppliers are transformed into products that move toward customers. (2) Financial flow moves upstream — money flows from customers back through the chain to suppliers as payment for goods. Information flow is bidirectional.',
 'Các hướng bị đảo ngược: (1) Dòng vật liệu di chuyển xuôi dòng — nguyên liệu từ nhà cung cấp được biến thành sản phẩm di chuyển về phía khách hàng. (2) Dòng tài chính di chuyển ngược dòng — tiền chảy từ khách hàng ngược qua chuỗi đến nhà cung cấp như thanh toán cho hàng hóa. Dòng thông tin là hai chiều.',
 4);

-- Exercise 5: arrange_words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'supply-chain-basics'),
 'arrange_words', 'medium',
 'Arrange the supply chain components in order from upstream to downstream.',
 'Sắp xếp các thành phần chuỗi cung ứng theo thứ tự từ thượng nguồn đến hạ nguồn.',
 'Suppliers, Manufacturers, Distributors, Retailers, Customers',
 '["Retailers", "Manufacturers", "Customers", "Suppliers", "Distributors"]',
 'The supply chain flows from upstream (raw materials) to downstream (end consumer): Suppliers provide materials → Manufacturers produce goods → Distributors store and transport → Retailers sell to consumers → Customers receive products. Each step adds value and moves products closer to the end user.',
 'Chuỗi cung ứng chảy từ thượng nguồn (nguyên liệu thô) đến hạ nguồn (người tiêu dùng cuối): Nhà cung cấp cung cấp vật liệu → Nhà sản xuất sản xuất hàng → Nhà phân phối lưu trữ và vận chuyển → Nhà bán lẻ bán cho người tiêu dùng → Khách hàng nhận sản phẩm. Mỗi bước thêm giá trị và đưa sản phẩm gần hơn đến người dùng cuối.',
 5);


-- ############################################################################
-- LESSON 6: INVENTORY AND WAREHOUSE MANAGEMENT (slug: inventory-warehouse-management)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Inventory and Warehouse Management', 'Quản Lý Kho và Tồn Kho',
  'inventory-warehouse-management',
  'Master EOQ, ABC analysis, JIT, and warehouse optimization techniques',
  'Nắm vững EOQ, phân tích ABC, JIT và kỹ thuật tối ưu hóa kho',
  'intermediate', 30, 2
FROM category WHERE name = 'Supply Chain & Logistics';


-- ============================================================================
-- USAGES — inventory-warehouse-management
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'inventory-warehouse-management'),
 'Economic Order Quantity (EOQ)', 'Lượng Đặt Hàng Kinh Tế (EOQ)',
 'EOQ calculates the optimal order quantity that minimizes total inventory costs — balancing ordering costs (placing orders, shipping) against holding costs (storage, insurance, obsolescence). The formula finds the sweet spot between ordering too often and holding too much.',
 'EOQ tính toán lượng đặt hàng tối ưu giảm thiểu tổng chi phí tồn kho — cân bằng chi phí đặt hàng (đặt đơn, vận chuyển) với chi phí lưu kho (lưu trữ, bảo hiểm, lỗi thời). Công thức tìm điểm cân bằng giữa đặt hàng quá thường xuyên và giữ quá nhiều hàng.',
 'Calculate', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'inventory-warehouse-management'),
 'ABC Analysis', 'Phân Tích ABC',
 'ABC analysis categorizes inventory by value: A items (20% of SKUs, 80% of value), B items (30% of SKUs, 15% of value), C items (50% of SKUs, 5% of value). This Pareto-based approach ensures high-value items get the most management attention.',
 'Phân tích ABC phân loại tồn kho theo giá trị: Hàng A (20% SKU, 80% giá trị), Hàng B (30% SKU, 15% giá trị), Hàng C (50% SKU, 5% giá trị). Cách tiếp cận dựa trên Pareto này đảm bảo hàng giá trị cao nhận được sự chú ý quản lý nhiều nhất.',
 'Sort', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'inventory-warehouse-management'),
 'Just-in-Time (JIT)', 'Đúng Lúc (JIT)',
 'JIT is a production strategy that receives materials only as needed in the production process, reducing inventory holding costs. Pioneered by Toyota, JIT requires reliable suppliers, quality control, and smooth production flow. It minimizes waste but is vulnerable to supply disruptions.',
 'JIT là chiến lược sản xuất nhận vật liệu chỉ khi cần trong quy trình sản xuất, giảm chi phí lưu kho. Toyota tiên phong JIT, đòi hỏi nhà cung cấp đáng tin cậy, kiểm soát chất lượng và dòng sản xuất trơn tru. Nó giảm thiểu lãng phí nhưng dễ bị tổn thương bởi gián đoạn cung ứng.',
 'Timer', TRUE, 3);


-- ============================================================================
-- SECTIONS — inventory-warehouse-management
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

((SELECT id FROM lesson WHERE slug = 'inventory-warehouse-management'),
 'markdown', 'Overview', 'Tổng Quan',
'## Inventory and Warehouse Management: Balancing Cost and Service

Inventory management is the art and science of having the right amount of stock — not too much (waste), not too little (stockouts). It directly impacts profitability, customer satisfaction, and cash flow.

### Types of Inventory

| Type | Purpose | Example |
|------|---------|---------|
| **Raw materials** | Inputs for production | Steel, fabric, components |
| **Work-in-progress (WIP)** | Partially completed goods | Half-assembled products |
| **Finished goods** | Ready for sale | Packaged products on shelves |
| **Safety stock** | Buffer against uncertainty | Extra units for demand spikes |

### EOQ: The Optimal Order Quantity

The Economic Order Quantity minimizes total cost = Ordering cost + Holding cost.

**EOQ = sqrt(2DS / H)** where:
- D = Annual demand (units/year)
- S = Ordering cost per order ($)
- H = Holding cost per unit per year ($)

**Example:** D=10,000 units, S=$50/order, H=$2/unit/year → EOQ = sqrt(2 × 10,000 × 50 / 2) = **707 units**

### ABC Analysis (Pareto Principle)

| Category | % of Items | % of Value | Management Level |
|----------|-----------|-----------|-----------------|
| **A items** | ~20% | ~80% | Tight control, frequent review |
| **B items** | ~30% | ~15% | Moderate control, periodic review |
| **C items** | ~50% | ~5% | Simple controls, infrequent review |

### Just-in-Time (JIT) — Toyota Production System

**Core idea:** Zero inventory is the ideal — receive materials exactly when needed.

**Prerequisites:**
- Reliable, nearby suppliers
- Consistent quality (no defective parts)
- Smooth, level production schedules
- Strong supplier relationships

**Trade-off:** JIT reduces holding costs but increases vulnerability to supply disruptions (as seen during COVID-19 chip shortages).',

'## Quản Lý Kho và Tồn Kho: Cân Bằng Chi Phí và Dịch Vụ

Quản lý tồn kho là nghệ thuật và khoa học để có đúng lượng hàng — không quá nhiều (lãng phí), không quá ít (hết hàng). Nó ảnh hưởng trực tiếp đến lợi nhuận, sự hài lòng khách hàng và dòng tiền.

### Các Loại Tồn Kho

| Loại | Mục Đích | Ví Dụ |
|------|---------|-------|
| **Nguyên liệu thô** | Đầu vào sản xuất | Thép, vải, linh kiện |
| **Hàng đang sản xuất (WIP)** | Hàng hoàn thành một phần | Sản phẩm lắp ráp nửa chừng |
| **Thành phẩm** | Sẵn sàng bán | Sản phẩm đóng gói trên kệ |
| **Tồn kho an toàn** | Đệm chống bất trắc | Đơn vị thêm cho nhu cầu tăng đột biến |

### EOQ: Lượng Đặt Hàng Tối Ưu

Lượng Đặt Hàng Kinh Tế tối thiểu hóa tổng chi phí = Chi phí đặt hàng + Chi phí lưu kho.

**EOQ = sqrt(2DS / H)** trong đó:
- D = Nhu cầu hàng năm (đơn vị/năm)
- S = Chi phí mỗi lần đặt hàng ($)
- H = Chi phí lưu kho mỗi đơn vị mỗi năm ($)

**Ví dụ:** D=10.000 đơn vị, S=$50/đơn, H=$2/đơn vị/năm → EOQ = sqrt(2 × 10.000 × 50 / 2) = **707 đơn vị**

### Phân Tích ABC (Nguyên Tắc Pareto)

| Loại | % Mặt Hàng | % Giá Trị | Mức Quản Lý |
|------|-----------|-----------|------------|
| **Hàng A** | ~20% | ~80% | Kiểm soát chặt, đánh giá thường xuyên |
| **Hàng B** | ~30% | ~15% | Kiểm soát vừa phải, đánh giá định kỳ |
| **Hàng C** | ~50% | ~5% | Kiểm soát đơn giản, đánh giá ít |

### Đúng Lúc (JIT) — Hệ Thống Sản Xuất Toyota

**Ý tưởng cốt lõi:** Tồn kho bằng không là lý tưởng — nhận vật liệu đúng lúc cần.

**Điều kiện tiên quyết:**
- Nhà cung cấp đáng tin cậy, gần
- Chất lượng nhất quán (không có phụ tùng lỗi)
- Lịch sản xuất đều đặn, ổn định
- Quan hệ nhà cung cấp vững chắc

**Đánh đổi:** JIT giảm chi phí lưu kho nhưng tăng tổn thương với gián đoạn cung ứng (như thiếu chip COVID-19).',
 1, '{}'::jsonb),

((SELECT id FROM lesson WHERE slug = 'inventory-warehouse-management'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["EOQ = sqrt(2DS/H) — tìm lượng đặt hàng cân bằng chi phí đặt hàng và lưu kho", "ABC analysis: 20% mặt hàng chiếm 80% giá trị (hàng A) cần kiểm soát chặt nhất", "JIT nhận vật liệu đúng lúc cần, giảm lãng phí nhưng dễ tổn thương với gián đoạn", "Tồn kho an toàn là đệm chống bất trắc nhu cầu và thời gian giao hàng", "Bốn loại tồn kho: nguyên liệu, hàng đang sản xuất, thành phẩm, tồn kho an toàn"]'::jsonb),

((SELECT id FROM lesson WHERE slug = 'inventory-warehouse-management'),
 'info_box', 'Toyota vs Traditional Manufacturing', 'Toyota vs Sản Xuất Truyền Thống',
'**Toyota''s JIT Revolution**

Before Toyota, manufacturers held weeks or months of inventory "just in case." Toyota flipped this to "just in time":

| Metric | Traditional | Toyota JIT |
|--------|-----------|-----------|
| Inventory turns | 4-8 per year | 50-70 per year |
| Defect rate | 1-5% | 0.01% |
| Lead time | Weeks | Hours |
| Warehouse space | Massive | Minimal |

**The key insight:** High inventory hides problems. When you reduce inventory, problems become visible and must be solved — leading to continuous improvement (kaizen).

**Warning:** COVID-19 exposed JIT''s weakness. Many companies are now adopting "Just-in-Case" buffer strategies alongside JIT, creating hybrid approaches.',

'**Cuộc Cách Mạng JIT Của Toyota**

Trước Toyota, nhà sản xuất giữ tồn kho hàng tuần hoặc hàng tháng "đề phòng." Toyota đảo ngược thành "đúng lúc":

| Chỉ Số | Truyền Thống | Toyota JIT |
|--------|-------------|-----------|
| Vòng quay tồn kho | 4-8 lần/năm | 50-70 lần/năm |
| Tỷ lệ lỗi | 1-5% | 0,01% |
| Thời gian sản xuất | Tuần | Giờ |
| Không gian kho | Khổng lồ | Tối thiểu |

**Insight then chốt:** Tồn kho cao che giấu vấn đề. Khi giảm tồn kho, vấn đề trở nên rõ ràng và phải được giải quyết — dẫn đến cải tiến liên tục (kaizen).

**Cảnh báo:** COVID-19 bộc lộ điểm yếu của JIT. Nhiều công ty đang áp dụng chiến lược đệm "Just-in-Case" cùng JIT, tạo cách tiếp cận kết hợp.',
 3, '{"type": "info"}'::jsonb);


-- ============================================================================
-- EXERCISES — inventory-warehouse-management (5 exercises)
-- ============================================================================

-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'inventory-warehouse-management'),
 'fill_blank', 'easy',
 'In ABC analysis, ___ items represent about 20% of SKUs but account for approximately 80% of total inventory value.',
 'Trong phân tích ABC, hàng ___ chiếm khoảng 20% SKU nhưng chiếm khoảng 80% tổng giá trị tồn kho.',
 'A',
 'ABC analysis applies the Pareto principle (80/20 rule) to inventory management. Category A items are the vital few — they require the tightest controls, most frequent reviews, and most accurate demand forecasting because they represent the bulk of inventory investment.',
 'Phân tích ABC áp dụng nguyên tắc Pareto (quy tắc 80/20) vào quản lý tồn kho. Hàng loại A là số ít quan trọng — chúng cần kiểm soát chặt nhất, đánh giá thường xuyên nhất và dự báo nhu cầu chính xác nhất vì chúng đại diện phần lớn đầu tư tồn kho.',
 1);

-- Exercise 2: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'inventory-warehouse-management'),
    'multiple_choice', 'medium',
    'What does EOQ stand for in inventory management?',
    'EOQ viết tắt của gì trong quản lý tồn kho?',
    'A',
    'EOQ (Economic Order Quantity) is the order size that minimizes total annual inventory costs by balancing two opposing costs: ordering costs (which decrease as order size increases) and holding costs (which increase as order size increases). The EOQ formula was developed by Ford W. Harris in 1913.',
    'EOQ (Lượng Đặt Hàng Kinh Tế) là kích thước đơn hàng tối thiểu hóa tổng chi phí tồn kho hàng năm bằng cách cân bằng hai chi phí đối lập: chi phí đặt hàng (giảm khi kích thước đơn tăng) và chi phí lưu kho (tăng khi kích thước đơn tăng). Công thức EOQ được Ford W. Harris phát triển năm 1913.',
    2
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, 'Economic Order Quantity', 'Lượng Đặt Hàng Kinh Tế', TRUE),
((SELECT id FROM ex), 'B'::option_label, 'Efficient Output Quality', 'Chất Lượng Đầu Ra Hiệu Quả', FALSE),
((SELECT id FROM ex), 'C'::option_label, 'Expected Order Queue', 'Hàng Đợi Đơn Hàng Dự Kiến', FALSE),
((SELECT id FROM ex), 'D'::option_label, 'Enterprise Operations Quota', 'Hạn Ngạch Vận Hành Doanh Nghiệp', FALSE);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'inventory-warehouse-management'),
 'true_false', 'medium',
 'Just-in-Time (JIT) inventory requires holding large safety stock buffers to protect against supply disruptions.',
 'Tồn kho Đúng Lúc (JIT) yêu cầu giữ tồn kho an toàn lớn để bảo vệ chống gián đoạn cung ứng.',
 'false',
 'JIT is the opposite of holding large safety stocks. Its core philosophy is near-zero inventory — receiving materials only when needed for production. JIT relies on reliable suppliers and smooth production flow rather than safety stock buffers. This makes JIT efficient but vulnerable to supply chain disruptions.',
 'JIT ngược lại với giữ tồn kho an toàn lớn. Triết lý cốt lõi là tồn kho gần bằng không — nhận vật liệu chỉ khi cần cho sản xuất. JIT dựa vào nhà cung cấp đáng tin cậy và dòng sản xuất trơn tru thay vì đệm tồn kho an toàn. Điều này giúp JIT hiệu quả nhưng dễ tổn thương với gián đoạn chuỗi cung ứng.',
 3);

-- Exercise 4: sentence_transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'inventory-warehouse-management'),
 'sentence_transform', 'medium',
 'Rewrite this statement about Toyota using the concept of kaizen: "Toyota keeps high inventory to hide manufacturing defects."',
 'Viết lại câu này về Toyota sử dụng khái niệm kaizen: "Toyota giữ tồn kho cao để che giấu lỗi sản xuất."',
 'Toyota reduces inventory to expose manufacturing defects and drives continuous improvement through kaizen',
 'Toyota''s JIT philosophy is the opposite: low inventory makes problems visible. When there is no buffer stock, a defective part immediately stops the production line, forcing the team to find and fix the root cause. This is the foundation of kaizen (continuous improvement) — problems are opportunities for improvement, not things to hide.',
 'Triết lý JIT của Toyota ngược lại: tồn kho thấp khiến vấn đề rõ ràng. Khi không có kho đệm, phụ tùng lỗi ngay lập tức dừng dây chuyền sản xuất, buộc nhóm tìm và sửa nguyên nhân gốc. Đây là nền tảng của kaizen (cải tiến liên tục) — vấn đề là cơ hội cải thiện, không phải thứ để che giấu.',
 4);

-- Exercise 5: arrange_words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'inventory-warehouse-management'),
 'arrange_words', 'medium',
 'Arrange the ABC categories from highest value to lowest value.',
 'Sắp xếp các loại ABC từ giá trị cao nhất đến thấp nhất.',
 'A items: 80% value, B items: 15% value, C items: 5% value',
 '["C items: 5% value", "A items: 80% value", "B items: 15% value"]',
 'ABC analysis follows the Pareto principle: A items (top 20% of SKUs) represent ~80% of total value and need the most attention. B items (middle 30%) represent ~15% of value. C items (bottom 50% of SKUs) represent only ~5% of value and can be managed with simpler, less frequent controls.',
 'Phân tích ABC tuân theo nguyên tắc Pareto: Hàng A (top 20% SKU) đại diện ~80% tổng giá trị và cần chú ý nhất. Hàng B (30% giữa) đại diện ~15% giá trị. Hàng C (50% cuối SKU) chỉ đại diện ~5% giá trị và có thể quản lý bằng kiểm soát đơn giản hơn, ít thường xuyên hơn.',
 5);


-- ############################################################################
-- CATEGORY 4: GAME THEORY
-- ############################################################################


-- ############################################################################
-- LESSON 7: INTRODUCTION TO GAME THEORY (slug: intro-to-game-theory)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Introduction to Game Theory', 'Giới Thiệu Lý Thuyết Trò Chơi',
  'intro-to-game-theory',
  'Learn strategic thinking through the Prisoner''s Dilemma, dominant strategies, and payoff matrices',
  'Tìm hiểu tư duy chiến lược qua Song Đề Tù Nhân, chiến lược trội và ma trận lợi ích',
  'beginner', 30, 1
FROM category WHERE name = 'Game Theory';


-- ============================================================================
-- USAGES — intro-to-game-theory
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-to-game-theory'),
 'The Prisoner''s Dilemma', 'Song Đề Tù Nhân',
 'The Prisoner''s Dilemma is the most famous game in game theory. Two suspects are arrested and questioned separately. Each can cooperate (stay silent) or defect (betray the other). Individual rationality leads both to defect, even though mutual cooperation yields a better outcome for both.',
 'Song Đề Tù Nhân là trò chơi nổi tiếng nhất trong lý thuyết trò chơi. Hai nghi phạm bị bắt và thẩm vấn riêng biệt. Mỗi người có thể hợp tác (im lặng) hoặc phản bội (khai người kia). Lý trí cá nhân dẫn cả hai đều phản bội, dù hợp tác chung mang lại kết quả tốt hơn cho cả hai.',
 'Extension', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'intro-to-game-theory'),
 'Dominant Strategy', 'Chiến Lược Trội',
 'A dominant strategy is the best choice regardless of what the other player does. If a player has a dominant strategy, they should always play it. In the Prisoner''s Dilemma, defection is the dominant strategy for both players — even though mutual cooperation is collectively better.',
 'Chiến lược trội là lựa chọn tốt nhất bất kể đối phương làm gì. Nếu người chơi có chiến lược trội, họ nên luôn chơi nó. Trong Song Đề Tù Nhân, phản bội là chiến lược trội cho cả hai người chơi — dù hợp tác chung tốt hơn cho tập thể.',
 'EmojiObjects', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'intro-to-game-theory'),
 'Payoff Matrix', 'Ma Trận Lợi Ích',
 'A payoff matrix is a table that shows all possible outcomes of a strategic interaction. Each cell contains the payoffs for both players given their respective choices. Reading payoff matrices is the fundamental skill of game theory analysis.',
 'Ma trận lợi ích là bảng hiển thị tất cả kết quả có thể của một tương tác chiến lược. Mỗi ô chứa lợi ích cho cả hai người chơi dựa trên lựa chọn tương ứng. Đọc ma trận lợi ích là kỹ năng cơ bản của phân tích lý thuyết trò chơi.',
 'GridOn', TRUE, 3);


-- ============================================================================
-- SECTIONS — intro-to-game-theory
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

((SELECT id FROM lesson WHERE slug = 'intro-to-game-theory'),
 'markdown', 'Overview', 'Tổng Quan',
'## Introduction to Game Theory: Strategic Thinking

Game theory is the mathematical study of strategic decision-making — situations where your outcome depends not only on your choices but also on the choices of others.

### What is a "Game"?

A game in game theory has three elements:
1. **Players** — The decision-makers (at least 2)
2. **Strategies** — The possible actions each player can take
3. **Payoffs** — The outcomes (rewards or penalties) for each combination of strategies

### The Prisoner''s Dilemma

Two suspects (A and B) are arrested. Each can **Cooperate** (stay silent) or **Defect** (betray):

| | B Cooperates | B Defects |
|---|-------------|-----------|
| **A Cooperates** | A: -1, B: -1 | A: -3, B: 0 |
| **A Defects** | A: 0, B: -3 | A: -2, B: -2 |

- If both cooperate: 1 year each (best collective outcome)
- If both defect: 2 years each (Nash equilibrium)
- If one defects while other cooperates: defector goes free, cooperator gets 3 years

**The paradox:** Rational individual behavior (defecting) leads to a worse collective outcome than cooperation.

### Types of Games

| Type | Description | Example |
|------|-------------|---------|
| **Zero-sum** | One player''s gain = other''s loss | Chess, poker |
| **Non-zero-sum** | Both can gain or both can lose | Trade negotiations, arms races |
| **Simultaneous** | Players choose at the same time | Rock-Paper-Scissors |
| **Sequential** | Players take turns | Chess, business entry decisions |
| **One-shot** | Played once | Single auction |
| **Repeated** | Played multiple times | Ongoing business relationships |

### Dominant Strategy

A strategy is **dominant** if it is the best response no matter what the other player does. In the Prisoner''s Dilemma, defecting is dominant: if B cooperates, defecting gives A a better payoff (0 > -1); if B defects, defecting still gives A a better payoff (-2 > -3).',

'## Giới Thiệu Lý Thuyết Trò Chơi: Tư Duy Chiến Lược

Lý thuyết trò chơi là nghiên cứu toán học về ra quyết định chiến lược — tình huống mà kết quả của bạn phụ thuộc không chỉ vào lựa chọn của bạn mà còn vào lựa chọn của người khác.

### "Trò Chơi" Là Gì?

Một trò chơi trong lý thuyết trò chơi có ba yếu tố:
1. **Người chơi** — Những người ra quyết định (ít nhất 2)
2. **Chiến lược** — Các hành động có thể mà mỗi người chơi thực hiện
3. **Lợi ích** — Kết quả (phần thưởng hoặc hình phạt) cho mỗi tổ hợp chiến lược

### Song Đề Tù Nhân

Hai nghi phạm (A và B) bị bắt. Mỗi người có thể **Hợp tác** (im lặng) hoặc **Phản bội** (khai):

| | B Hợp Tác | B Phản Bội |
|---|----------|-----------|
| **A Hợp Tác** | A: -1, B: -1 | A: -3, B: 0 |
| **A Phản Bội** | A: 0, B: -3 | A: -2, B: -2 |

- Nếu cả hai hợp tác: 1 năm mỗi người (kết quả tập thể tốt nhất)
- Nếu cả hai phản bội: 2 năm mỗi người (cân bằng Nash)
- Nếu một người phản bội trong khi người kia hợp tác: kẻ phản bội được tự do, người hợp tác lĩnh 3 năm

**Nghịch lý:** Hành vi cá nhân hợp lý (phản bội) dẫn đến kết quả tập thể tệ hơn so với hợp tác.

### Các Loại Trò Chơi

| Loại | Mô Tả | Ví Dụ |
|------|-------|-------|
| **Tổng bằng không** | Lợi ích người này = thua thiệt người kia | Cờ vua, poker |
| **Tổng khác không** | Cả hai có thể cùng được hoặc cùng mất | Đàm phán thương mại, chạy đua vũ trang |
| **Đồng thời** | Người chơi chọn cùng lúc | Oẳn tù tì |
| **Tuần tự** | Người chơi lần lượt | Cờ vua, quyết định gia nhập thị trường |
| **Một lần** | Chơi một lần | Đấu giá đơn lẻ |
| **Lặp lại** | Chơi nhiều lần | Quan hệ kinh doanh liên tục |

### Chiến Lược Trội

Chiến lược **trội** nếu nó là phản hồi tốt nhất bất kể đối phương làm gì. Trong Song Đề Tù Nhân, phản bội là trội: nếu B hợp tác, phản bội cho A lợi ích tốt hơn (0 > -1); nếu B phản bội, phản bội vẫn cho A lợi ích tốt hơn (-2 > -3).',
 1, '{}'::jsonb),

((SELECT id FROM lesson WHERE slug = 'intro-to-game-theory'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["Trò chơi có 3 yếu tố: người chơi, chiến lược, lợi ích (payoffs)", "Song Đề Tù Nhân: lý trí cá nhân (phản bội) dẫn đến kết quả tập thể tệ hơn hợp tác", "Chiến lược trội là lựa chọn tốt nhất bất kể đối phương làm gì", "Trò chơi tổng bằng không: lợi ích người này = thua thiệt người kia (cờ vua, poker)", "Ma trận lợi ích hiển thị tất cả kết quả có thể cho mọi tổ hợp chiến lược"]'::jsonb),

((SELECT id FROM lesson WHERE slug = 'intro-to-game-theory'),
 'info_box', 'Game Theory in Everyday Life', 'Lý Thuyết Trò Chơi Trong Đời Sống',
'**You play "games" every day without realizing it:**

- **Traffic:** Choosing a route when everyone else is also choosing → each driver''s travel time depends on others'' choices (Braess''s paradox)
- **Salary negotiation:** Your offer depends on what you think the employer will accept, and vice versa
- **Auction bidding:** How much to bid depends on what you think others will bid
- **Social media:** Whether to share information depends on whether others will reciprocate

**The Cold War as Game Theory:** The nuclear arms race between the US and USSR was a real-world Prisoner''s Dilemma. Both nations would have been better off disarming (cooperating), but each feared the other would keep weapons (defect), leading to decades of mutual arms buildup.

> John von Neumann (father of game theory): *"Real life consists of bluffing, of little tactics of deception, of asking yourself what is the other man going to think I mean to do."*',

'**Bạn chơi "trò chơi" mỗi ngày mà không nhận ra:**

- **Giao thông:** Chọn tuyến đường khi mọi người cũng đang chọn → thời gian di chuyển của mỗi tài xế phụ thuộc vào lựa chọn của người khác (nghịch lý Braess)
- **Đàm phán lương:** Đề nghị của bạn phụ thuộc vào bạn nghĩ nhà tuyển dụng sẽ chấp nhận gì, và ngược lại
- **Đấu giá:** Đấu bao nhiêu phụ thuộc vào bạn nghĩ người khác sẽ đấu bao nhiêu
- **Mạng xã hội:** Chia sẻ thông tin hay không phụ thuộc vào việc người khác có đáp lại không

**Chiến Tranh Lạnh Như Lý Thuyết Trò Chơi:** Cuộc chạy đua vũ trang hạt nhân giữa Mỹ và Liên Xô là Song Đề Tù Nhân thực tế. Cả hai nước sẽ tốt hơn nếu giải giáp (hợp tác), nhưng mỗi bên sợ bên kia giữ vũ khí (phản bội), dẫn đến hàng thập kỷ tích lũy vũ khí.

> John von Neumann (cha đẻ lý thuyết trò chơi): *"Cuộc sống thực bao gồm lừa bịp, chiến thuật nhỏ về lừa dối, tự hỏi đối phương sẽ nghĩ mình định làm gì."*',
 3, '{"type": "info"}'::jsonb);


-- ============================================================================
-- EXERCISES — intro-to-game-theory (5 exercises)
-- ============================================================================

-- Exercise 1: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'intro-to-game-theory'),
    'multiple_choice', 'easy',
    'In the Prisoner''s Dilemma, what happens when both prisoners choose to defect (betray)?',
    'Trong Song Đề Tù Nhân, điều gì xảy ra khi cả hai tù nhân chọn phản bội?',
    'C',
    'When both defect, they each receive a moderate punishment (2 years in the classic setup). This is the Nash equilibrium — neither can improve by changing strategy alone. Ironically, both would be better off cooperating (1 year each), but individual rationality drives them to the worse collective outcome.',
    'Khi cả hai phản bội, mỗi người nhận hình phạt vừa phải (2 năm trong thiết lập kinh điển). Đây là cân bằng Nash — không ai có thể cải thiện bằng cách thay đổi chiến lược một mình. Trớ trêu, cả hai sẽ tốt hơn nếu hợp tác (1 năm mỗi người), nhưng lý trí cá nhân đẩy họ đến kết quả tập thể tệ hơn.',
    1
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, 'Both go free', 'Cả hai được tự do', FALSE),
((SELECT id FROM ex), 'B'::option_label, 'One goes free, one gets maximum sentence', 'Một người tự do, một người lĩnh án tối đa', FALSE),
((SELECT id FROM ex), 'C'::option_label, 'Both receive a moderate punishment', 'Cả hai nhận hình phạt vừa phải', TRUE),
((SELECT id FROM ex), 'D'::option_label, 'Both receive the minimum sentence', 'Cả hai nhận án tối thiểu', FALSE);

-- Exercise 2: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-to-game-theory'),
 'fill_blank', 'easy',
 'A ___ strategy is the best choice for a player regardless of what the other player does.',
 'Chiến lược ___ là lựa chọn tốt nhất cho người chơi bất kể đối phương làm gì.',
 'dominant',
 'A dominant strategy yields the highest payoff no matter what strategy the opponent chooses. If a player has a dominant strategy, they should always play it. Not all games have dominant strategies — when no strategy is universally best, players must use more sophisticated analysis like Nash equilibrium.',
 'Chiến lược trội mang lại lợi ích cao nhất bất kể đối phương chọn chiến lược gì. Nếu người chơi có chiến lược trội, họ nên luôn chơi nó. Không phải mọi trò chơi đều có chiến lược trội — khi không có chiến lược nào tốt nhất phổ quát, người chơi phải dùng phân tích tinh vi hơn như cân bằng Nash.',
 2);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-to-game-theory'),
 'true_false', 'easy',
 'In a zero-sum game, it is possible for both players to gain simultaneously.',
 'Trong trò chơi tổng bằng không, cả hai người chơi có thể cùng được lợi đồng thời.',
 'false',
 'By definition, a zero-sum game means the total payoff is constant — one player''s gain exactly equals the other''s loss. Chess is a classic example: one win equals one loss. In contrast, non-zero-sum games (like trade) allow both parties to gain, which is why cooperation can be rational.',
 'Theo định nghĩa, trò chơi tổng bằng không có nghĩa tổng lợi ích là hằng số — lợi ích của người này chính xác bằng thua thiệt của người kia. Cờ vua là ví dụ kinh điển: một thắng bằng một thua. Ngược lại, trò chơi tổng khác không (như thương mại) cho phép cả hai bên cùng được lợi, đó là lý do hợp tác có thể hợp lý.',
 3);

-- Exercise 4: error_correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-to-game-theory'),
 'error_correction', 'medium',
 'Fix the errors: "In the Prisoner''s Dilemma, cooperation is the dominant strategy because both players gets the best outcome when they cooperate."',
 'Sửa lỗi: "Trong Song Đề Tù Nhân, hợp tác là chiến lược trội vì cả hai người chơi nhận được kết quả tốt nhất khi họ hợp tác."',
 'In the Prisoner''s Dilemma, defection is the dominant strategy because each player gets a better individual outcome by defecting regardless of the other''s choice.',
 'Two errors: (1) Cooperation is NOT the dominant strategy — defection is. Each player individually benefits from defecting no matter what the other does. (2) "gets" should be "get" (subject-verb agreement). The paradox is that mutual cooperation IS the best collective outcome, but individual rationality drives both to defect.',
 'Hai lỗi: (1) Hợp tác KHÔNG phải chiến lược trội — phản bội mới là. Mỗi người chơi cá nhân được lợi từ phản bội bất kể người kia làm gì. (2) Nghịch lý là hợp tác chung LÀ kết quả tập thể tốt nhất, nhưng lý trí cá nhân đẩy cả hai đều phản bội.',
 4);

-- Exercise 5: arrange_words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-to-game-theory'),
 'arrange_words', 'medium',
 'Arrange the three elements of a game in the correct order.',
 'Sắp xếp ba yếu tố của trò chơi theo đúng thứ tự.',
 'Players, Strategies, Payoffs',
 '["Payoffs", "Strategies", "Players"]',
 'Every game is defined by three elements in this logical order: (1) Players — who are the decision-makers? (2) Strategies — what actions can each player take? (3) Payoffs — what are the outcomes for each combination of strategies? You must identify players before strategies, and strategies before payoffs.',
 'Mọi trò chơi được xác định bởi ba yếu tố theo thứ tự logic: (1) Người chơi — ai là người ra quyết định? (2) Chiến lược — mỗi người chơi có thể thực hiện hành động gì? (3) Lợi ích — kết quả cho mỗi tổ hợp chiến lược là gì? Bạn phải xác định người chơi trước chiến lược, và chiến lược trước lợi ích.',
 5);


-- ############################################################################
-- LESSON 8: NASH EQUILIBRIUM AND STRATEGY (slug: nash-equilibrium-strategy)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Nash Equilibrium and Strategy', 'Cân Bằng Nash và Chiến Lược',
  'nash-equilibrium-strategy',
  'Understand Nash Equilibrium, mixed strategies, and real-world applications of game theory',
  'Hiểu Cân Bằng Nash, chiến lược hỗn hợp và ứng dụng thực tế của lý thuyết trò chơi',
  'intermediate', 35, 2
FROM category WHERE name = 'Game Theory';


-- ============================================================================
-- USAGES — nash-equilibrium-strategy
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'nash-equilibrium-strategy'),
 'Nash Equilibrium', 'Cân Bằng Nash',
 'A Nash Equilibrium is a state where no player can improve their payoff by unilaterally changing strategy. It is the "stable point" of a game — once reached, no one has incentive to deviate. John Nash proved that every finite game has at least one Nash Equilibrium (pure or mixed).',
 'Cân bằng Nash là trạng thái mà không người chơi nào có thể cải thiện lợi ích bằng cách đơn phương thay đổi chiến lược. Đây là "điểm ổn định" của trò chơi — khi đạt được, không ai có động lực lệch đi. John Nash chứng minh mọi trò chơi hữu hạn đều có ít nhất một Cân bằng Nash (thuần túy hoặc hỗn hợp).',
 'Balance', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'nash-equilibrium-strategy'),
 'Mixed Strategies', 'Chiến Lược Hỗn Hợp',
 'When no pure strategy Nash Equilibrium exists, players can randomize their choices. A mixed strategy assigns probabilities to each possible action. In Rock-Paper-Scissors, the Nash Equilibrium is to play each option with 1/3 probability — any pattern can be exploited.',
 'Khi không có Cân bằng Nash chiến lược thuần túy, người chơi có thể ngẫu nhiên hóa lựa chọn. Chiến lược hỗn hợp gán xác suất cho mỗi hành động có thể. Trong Oẳn Tù Tì, Cân bằng Nash là chơi mỗi lựa chọn với xác suất 1/3 — bất kỳ mẫu nào đều có thể bị khai thác.',
 'Casino', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'nash-equilibrium-strategy'),
 'Repeated Games and Tit-for-Tat', 'Trò Chơi Lặp Lại và Tit-for-Tat',
 'In repeated games, players interact multiple times and can build reputations. Robert Axelrod''s famous tournament (1984) showed that Tit-for-Tat — cooperate first, then mirror the opponent''s last move — outperforms purely selfish strategies over time by fostering mutual cooperation.',
 'Trong trò chơi lặp lại, người chơi tương tác nhiều lần và có thể xây dựng danh tiếng. Giải đấu nổi tiếng của Robert Axelrod (1984) cho thấy Tit-for-Tat — hợp tác trước, rồi sao chép nước đi cuối của đối phương — vượt trội các chiến lược ích kỷ thuần túy theo thời gian bằng cách thúc đẩy hợp tác chung.',
 'Replay', TRUE, 3);


-- ============================================================================
-- SECTIONS — nash-equilibrium-strategy
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

((SELECT id FROM lesson WHERE slug = 'nash-equilibrium-strategy'),
 'markdown', 'Overview', 'Tổng Quan',
'## Nash Equilibrium and Strategy: Finding Stable Outcomes

John Nash (Nobel Prize, 1994) proved that every finite game has at least one equilibrium — a state where no player benefits from unilaterally changing strategy. This concept revolutionized economics, political science, and evolutionary biology.

### How to Find Nash Equilibrium

**Step-by-step for a 2x2 game:**
1. For each of Player B''s strategies, find Player A''s best response
2. For each of Player A''s strategies, find Player B''s best response
3. A Nash Equilibrium occurs where both players are playing their best response simultaneously

### Battle of the Sexes

A classic coordination game: a couple wants to go out together but prefers different events.

| | Opera | Football |
|---|-------|----------|
| **Opera** | 3, 2 | 0, 0 |
| **Football** | 0, 0 | 2, 3 |

**Two pure-strategy Nash Equilibria:** (Opera, Opera) and (Football, Football). Plus one mixed-strategy equilibrium.

### Mixed Strategy Equilibrium

When no pure-strategy equilibrium exists (or to find additional equilibria), players randomize:

**Rock-Paper-Scissors:** No pure-strategy NE exists. The mixed NE is:
- Play Rock with probability 1/3
- Play Paper with probability 1/3
- Play Scissors with probability 1/3

**Key insight:** At the mixed NE, each player is indifferent between all their strategies.

### Repeated Games: Why Cooperation Emerges

In a one-shot Prisoner''s Dilemma, defection dominates. But in **repeated** games:

| Strategy | Description | Performance |
|----------|-------------|-------------|
| **Tit-for-Tat** | Cooperate first, then copy opponent''s last move | Best overall |
| **Always Defect** | Never cooperate | Good short-term, poor long-term |
| **Always Cooperate** | Never defect | Exploited by defectors |
| **Grim Trigger** | Cooperate until betrayed, then always defect | Strong but unforgiving |

Axelrod''s insight: successful strategies are **nice** (cooperate first), **retaliatory** (punish defection), **forgiving** (return to cooperation), and **clear** (predictable).',

'## Cân Bằng Nash và Chiến Lược: Tìm Kết Quả Ổn Định

John Nash (Giải Nobel, 1994) chứng minh mọi trò chơi hữu hạn đều có ít nhất một cân bằng — trạng thái mà không người chơi nào được lợi từ việc đơn phương thay đổi chiến lược. Khái niệm này cách mạng hóa kinh tế, khoa học chính trị và sinh học tiến hóa.

### Cách Tìm Cân Bằng Nash

**Từng bước cho trò chơi 2x2:**
1. Với mỗi chiến lược của Người chơi B, tìm phản hồi tốt nhất của A
2. Với mỗi chiến lược của Người chơi A, tìm phản hồi tốt nhất của B
3. Cân bằng Nash xảy ra khi cả hai đều chơi phản hồi tốt nhất đồng thời

### Trận Chiến Của Đôi Lứa

Trò chơi phối hợp kinh điển: một cặp đôi muốn đi chơi cùng nhau nhưng thích sự kiện khác nhau.

| | Opera | Bóng Đá |
|---|-------|---------|
| **Opera** | 3, 2 | 0, 0 |
| **Bóng Đá** | 0, 0 | 2, 3 |

**Hai cân bằng Nash chiến lược thuần túy:** (Opera, Opera) và (Bóng Đá, Bóng Đá). Cộng thêm một cân bằng chiến lược hỗn hợp.

### Cân Bằng Chiến Lược Hỗn Hợp

Khi không có cân bằng chiến lược thuần túy (hoặc để tìm cân bằng bổ sung), người chơi ngẫu nhiên hóa:

**Oẳn Tù Tì:** Không có NE chiến lược thuần túy. NE hỗn hợp là:
- Chơi Kéo với xác suất 1/3
- Chơi Búa với xác suất 1/3
- Chơi Bao với xác suất 1/3

**Insight then chốt:** Tại NE hỗn hợp, mỗi người chơi bàng quan giữa tất cả chiến lược.

### Trò Chơi Lặp Lại: Tại Sao Hợp Tác Xuất Hiện

Trong Song Đề Tù Nhân một lần, phản bội trội. Nhưng trong trò chơi **lặp lại**:

| Chiến Lược | Mô Tả | Hiệu Suất |
|-----------|-------|-----------|
| **Tit-for-Tat** | Hợp tác trước, rồi sao chép nước cuối của đối phương | Tốt nhất tổng thể |
| **Luôn Phản Bội** | Không bao giờ hợp tác | Tốt ngắn hạn, kém dài hạn |
| **Luôn Hợp Tác** | Không bao giờ phản bội | Bị kẻ phản bội khai thác |
| **Grim Trigger** | Hợp tác cho đến khi bị phản bội, rồi luôn phản bội | Mạnh nhưng không tha thứ |

Insight của Axelrod: chiến lược thành công **tử tế** (hợp tác trước), **trả đũa** (phạt phản bội), **tha thứ** (quay lại hợp tác), và **rõ ràng** (dự đoán được).',
 1, '{}'::jsonb),

((SELECT id FROM lesson WHERE slug = 'nash-equilibrium-strategy'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["Cân bằng Nash: không ai cải thiện được bằng cách đơn phương thay đổi chiến lược", "Mọi trò chơi hữu hạn có ít nhất một cân bằng Nash (thuần túy hoặc hỗn hợp)", "Chiến lược hỗn hợp gán xác suất cho mỗi hành động — Oẳn Tù Tì: mỗi lựa chọn 1/3", "Tit-for-Tat: hợp tác trước, sao chép nước cuối đối phương — chiến lược tốt nhất trong trò chơi lặp", "Chiến lược thành công: tử tế, trả đũa, tha thứ, rõ ràng"]'::jsonb),

((SELECT id FROM lesson WHERE slug = 'nash-equilibrium-strategy'),
 'info_box', 'A Beautiful Mind', 'Một Trí Tuệ Đẹp',
'**John Nash and the Nobel Prize**

John Nash developed his equilibrium concept in his PhD thesis at Princeton — just 27 pages that changed the world. He showed that any finite game has at least one equilibrium point.

**Real-world applications of Nash Equilibrium:**
- **Auctions:** Bidding strategies in spectrum auctions (worth billions)
- **Traffic:** Each driver choosing routes forms a Nash Equilibrium (Wardrop equilibrium)
- **Evolution:** Animal behavior evolves toward evolutionary stable strategies (Nash Equilibria of nature)
- **Business:** Pricing wars, market entry decisions, advertising budgets

Nash''s life was dramatized in the film "A Beautiful Mind" (2001). Despite battling schizophrenia for decades, he shared the Nobel Prize in Economics in 1994 for his foundational contributions to game theory.

> Nash: *"The best result comes when everyone in the group does what''s best for himself AND the group."*',

'**John Nash và Giải Nobel**

John Nash phát triển khái niệm cân bằng trong luận án tiến sĩ tại Princeton — chỉ 27 trang đã thay đổi thế giới. Ông chứng minh mọi trò chơi hữu hạn đều có ít nhất một điểm cân bằng.

**Ứng dụng thực tế của Cân bằng Nash:**
- **Đấu giá:** Chiến lược đấu thầu trong đấu giá phổ tần (trị giá hàng tỷ)
- **Giao thông:** Mỗi tài xế chọn tuyến đường tạo Cân bằng Nash (cân bằng Wardrop)
- **Tiến hóa:** Hành vi động vật tiến hóa hướng đến chiến lược ổn định tiến hóa (Cân bằng Nash của tự nhiên)
- **Kinh doanh:** Chiến tranh giá, quyết định gia nhập thị trường, ngân sách quảng cáo

Cuộc đời Nash được dựng phim trong "A Beautiful Mind" (2001). Dù chiến đấu với tâm thần phân liệt hàng thập kỷ, ông chia sẻ Giải Nobel Kinh tế năm 1994 cho đóng góp nền tảng vào lý thuyết trò chơi.

> Nash: *"Kết quả tốt nhất đến khi mọi người trong nhóm làm điều tốt nhất cho bản thân VÀ cho nhóm."*',
 3, '{"type": "info"}'::jsonb);


-- ============================================================================
-- EXERCISES — nash-equilibrium-strategy (5 exercises)
-- ============================================================================

-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'nash-equilibrium-strategy'),
 'fill_blank', 'easy',
 'A Nash ___ is a state where no player can improve their payoff by unilaterally changing strategy.',
 'Cân bằng ___ là trạng thái mà không người chơi nào có thể cải thiện lợi ích bằng cách đơn phương thay đổi chiến lược.',
 'Equilibrium',
 'Nash Equilibrium is named after John Nash, who proved its existence in 1950. At a Nash Equilibrium, every player is playing their best response to everyone else''s strategy. No one has a reason to deviate, making it a "self-enforcing" outcome. This concept earned Nash the Nobel Prize in Economics in 1994.',
 'Cân bằng Nash được đặt theo tên John Nash, người chứng minh sự tồn tại của nó năm 1950. Tại Cân bằng Nash, mọi người chơi đều chơi phản hồi tốt nhất cho chiến lược của mọi người khác. Không ai có lý do để lệch đi, tạo nên kết quả "tự thực thi." Khái niệm này mang lại cho Nash Giải Nobel Kinh tế năm 1994.',
 1);

-- Exercise 2: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'nash-equilibrium-strategy'),
    'multiple_choice', 'medium',
    'In Rock-Paper-Scissors, what is the Nash Equilibrium mixed strategy?',
    'Trong Oẳn Tù Tì, chiến lược hỗn hợp Cân bằng Nash là gì?',
    'B',
    'Rock-Paper-Scissors has no pure-strategy Nash Equilibrium because for any fixed choice, the opponent can always win. The mixed-strategy NE is to play each option with equal probability (1/3). Any deviation from this creates a pattern that a rational opponent can exploit.',
    'Oẳn Tù Tì không có Cân bằng Nash chiến lược thuần túy vì với bất kỳ lựa chọn cố định nào, đối phương luôn có thể thắng. NE chiến lược hỗn hợp là chơi mỗi lựa chọn với xác suất bằng nhau (1/3). Bất kỳ lệch nào tạo ra mẫu mà đối phương hợp lý có thể khai thác.',
    2
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct) VALUES
((SELECT id FROM ex), 'A'::option_label, 'Always play Rock', 'Luôn chơi Búa', FALSE),
((SELECT id FROM ex), 'B'::option_label, 'Play each option with 1/3 probability', 'Chơi mỗi lựa chọn với xác suất 1/3', TRUE),
((SELECT id FROM ex), 'C'::option_label, 'Alternate between Rock and Paper', 'Xen kẽ giữa Búa và Bao', FALSE),
((SELECT id FROM ex), 'D'::option_label, 'Copy the opponent''s last move', 'Sao chép nước cuối của đối phương', FALSE);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'nash-equilibrium-strategy'),
 'true_false', 'medium',
 'Tit-for-Tat starts by defecting and then copies the opponent''s previous move.',
 'Tit-for-Tat bắt đầu bằng phản bội và sau đó sao chép nước đi trước của đối phương.',
 'false',
 'Tit-for-Tat starts by COOPERATING, then mirrors the opponent''s last move. This "nice" opening is crucial — it signals willingness to cooperate and establishes a basis for mutual cooperation. Starting with defection would trigger a spiral of mutual defection. Axelrod''s tournament showed that "nice" strategies (those that never defect first) consistently outperformed aggressive ones.',
 'Tit-for-Tat bắt đầu bằng HỢP TÁC, rồi sao chép nước đi cuối của đối phương. Sự mở đầu "tử tế" này rất quan trọng — nó tín hiệu sẵn sàng hợp tác và thiết lập cơ sở cho hợp tác chung. Bắt đầu bằng phản bội sẽ kích hoạt vòng xoáy phản bội lẫn nhau. Giải đấu của Axelrod cho thấy chiến lược "tử tế" (không bao giờ phản bội trước) luôn vượt trội các chiến lược hung hăng.',
 3);

-- Exercise 4: sentence_transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'nash-equilibrium-strategy'),
 'sentence_transform', 'medium',
 'Rewrite this definition more accurately: "A Nash Equilibrium is when both players have the best possible outcome."',
 'Viết lại định nghĩa này chính xác hơn: "Cân bằng Nash là khi cả hai người chơi có kết quả tốt nhất có thể."',
 'A Nash Equilibrium is when no player can improve their outcome by unilaterally changing their strategy',
 'A Nash Equilibrium is NOT necessarily the best possible outcome for both players (the Prisoner''s Dilemma proves this — the NE gives both 2 years, while cooperation would give both only 1 year). Instead, it is a stable state where no individual player can do better by changing their own strategy alone.',
 'Cân bằng Nash KHÔNG nhất thiết là kết quả tốt nhất cho cả hai (Song Đề Tù Nhân chứng minh — NE cho cả hai 2 năm, trong khi hợp tác cho cả hai chỉ 1 năm). Thay vào đó, đó là trạng thái ổn định mà không người chơi cá nhân nào có thể làm tốt hơn bằng cách tự thay đổi chiến lược.',
 4);

-- Exercise 5: arrange_words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'nash-equilibrium-strategy'),
 'arrange_words', 'medium',
 'Arrange the four qualities of successful repeated-game strategies identified by Axelrod.',
 'Sắp xếp bốn phẩm chất của chiến lược trò chơi lặp thành công theo Axelrod.',
 'Nice, Retaliatory, Forgiving, Clear',
 '["Clear", "Nice", "Forgiving", "Retaliatory"]',
 'Axelrod''s analysis of his computer tournament revealed four traits of winning strategies: (1) Nice — cooperate first, never defect unprovoked. (2) Retaliatory — punish defection immediately. (3) Forgiving — return to cooperation after punishing. (4) Clear — be predictable so opponents learn to cooperate. Tit-for-Tat embodies all four.',
 'Phân tích của Axelrod về giải đấu máy tính tiết lộ bốn đặc điểm của chiến lược chiến thắng: (1) Tử tế — hợp tác trước, không bao giờ phản bội khi không bị khiêu khích. (2) Trả đũa — phạt phản bội ngay lập tức. (3) Tha thứ — quay lại hợp tác sau khi phạt. (4) Rõ ràng — dự đoán được để đối phương học cách hợp tác. Tit-for-Tat thể hiện cả bốn.',
 5);


-- ############################################################################
-- CATEGORY: Military Strategy
-- ############################################################################

-- ############################################################################
-- LESSON 9: PRINCIPLES OF STRATEGY (slug: principles-of-strategy)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Principles of Strategy', 'Nguyên Lý Chiến Lược',
  'principles-of-strategy',
  'Understand timeless strategic principles from Sun Tzu to Clausewitz',
  'Hiểu các nguyên lý chiến lược vượt thời gian từ Tôn Tử đến Clausewitz',
  'beginner', 35, 1
FROM category WHERE name = 'Military Strategy';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'principles-of-strategy'),
 'Know Your Enemy, Know Yourself', 'Biết Mình Biết Người',
 'Sun Tzu''s most famous principle: if you know the enemy and yourself, you need not fear 100 battles. Self-assessment of strengths and weaknesses, combined with accurate intelligence about opponents, dramatically improves decision quality in competitive situations.',
 'Nguyên lý nổi tiếng nhất của Tôn Tử: nếu biết địch biết mình, không cần sợ 100 trận. Đánh giá điểm mạnh yếu của bản thân kết hợp với thông tin chính xác về đối thủ cải thiện đáng kể chất lượng quyết định.',
 'Shield', TRUE, 1),
((SELECT id FROM lesson WHERE slug = 'principles-of-strategy'),
 'Economy of Force', 'Tiết Kiệm Lực Lượng',
 'Allocate minimum resources to secondary objectives and concentrate maximum effort on decisive points. This principle prevents the fatal mistake of spreading forces too thin. In business, this translates to focused resource allocation and avoiding initiative overload.',
 'Phân bổ tài nguyên tối thiểu cho mục tiêu thứ cấp và tập trung nỗ lực tối đa vào điểm quyết định. Nguyên tắc này ngăn lỗi chết người là phân tán lực lượng quá mỏng.',
 'AccountTree', TRUE, 2),
((SELECT id FROM lesson WHERE slug = 'principles-of-strategy'),
 'Friction and Fog of War', 'Ma Sát và Sương Mù Chiến Tranh',
 'Clausewitz coined "fog of war" — the uncertainty inherent in conflict. No plan survives contact with the enemy intact. Great strategists build flexibility into their plans, maintain reserves, and make decisions with incomplete information. Adaptability outweighs perfect planning.',
 'Clausewitz đặt ra "sương mù chiến tranh" — sự bất định vốn có trong xung đột. Không kế hoạch nào tồn tại nguyên vẹn khi tiếp xúc với kẻ thù. Các chiến lược gia vĩ đại xây dựng sự linh hoạt vào kế hoạch của họ.',
 'Explore', TRUE, 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
((SELECT id FROM lesson WHERE slug = 'principles-of-strategy'),
 'markdown', 'Timeless Principles of Strategy', 'Nguyên Lý Chiến Lược Vượt Thời Gian',
'## Strategy Across History

Military strategy has produced principles that transcend the battlefield.

### Sun Tzu''s Core Principles (5th century BC)

| Principle | Meaning | Modern Application |
|-----------|---------|-------------------|
| **Know yourself, know your enemy** | Intelligence precedes action | Competitive analysis |
| **Attack weakness, avoid strength** | Asymmetric advantage | Market differentiation |
| **Win without fighting** | Non-confrontational victory | Negotiation over litigation |
| **Adapt to circumstances** | Fluid response to change | Agile methodology |

### Clausewitz''s Key Concepts

- **Friction**: Everything in war is simple, but the simplest things are difficult
- **Fog of war**: Incomplete information is the norm, not the exception
- **Center of gravity**: The source of an enemy''s strength — destroy it and resistance collapses

### The OODA Loop (John Boyd)

> **Observe → Orient → Decide → Act**

Whoever cycles through this loop faster gains decisive advantage. Developed from aerial combat, now drives agile business practices.',
'## Chiến Lược Qua Lịch Sử

Chiến lược quân sự đã tạo ra các nguyên lý vượt qua chiến trường.

### Nguyên Lý Cốt Lõi của Tôn Tử (Thế kỷ 5 TCN)

| Nguyên lý | Ý nghĩa | Ứng dụng hiện đại |
|-----------|---------|------------------|
| **Biết mình biết người** | Thông tin trước hành động | Phân tích cạnh tranh |
| **Đánh vào điểm yếu, tránh điểm mạnh** | Lợi thế bất đối xứng | Khác biệt hóa thị trường |
| **Thắng mà không cần chiến** | Chiến thắng không đối đầu | Đàm phán thay kiện tụng |
| **Thích nghi với hoàn cảnh** | Phản ứng linh hoạt | Phương pháp Agile |

### Các Khái Niệm Chính của Clausewitz

- **Ma sát**: Mọi thứ trong chiến tranh đơn giản, nhưng điều đơn giản nhất lại khó
- **Sương mù chiến tranh**: Thông tin không đầy đủ là chuẩn mực
- **Trung tâm trọng lực**: Nguồn sức mạnh của kẻ thù — phá hủy nó và sự kháng cự sụp đổ

### Vòng OODA (John Boyd)

> **Quan sát → Định hướng → Quyết định → Hành động**

Ai chu kỳ qua vòng này nhanh hơn giành lợi thế quyết định.',
 1, '{}'),
((SELECT id FROM lesson WHERE slug = 'principles-of-strategy'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["Tôn Tử nhấn mạnh thắng mà không cần chiến — buộc kẻ thù đầu hàng qua bố trí chiến lược trước khi bắt đầu chiến đấu", "Clausewitz: chiến tranh là sự tiếp nối chính trị bằng phương tiện khác — luôn phục vụ mục tiêu chính trị, không bao giờ là mục đích tự thân", "Vòng OODA của Boyd: ai quan sát, định hướng, quyết định và hành động nhanh hơn sẽ liên tục áp đảo đối thủ", "Ma sát giải thích tại sao kế hoạch tốt nhất thường thất bại khi gặp thực tế — xây dựng dự phòng và linh hoạt là bắt buộc", "Nguyên tắc kinh tế lực lượng: tập trung sức mạnh áp đảo vào điểm quyết định, không phân tán đều khắp nơi"]'::jsonb),
((SELECT id FROM lesson WHERE slug = 'principles-of-strategy'),
 'info_box', 'Strategy vs. Tactics', 'Chiến Lược vs. Chiến Thuật',
 '**Strategy** and **tactics** operate at different levels:

| Dimension | Strategy | Tactics |
|-----------|----------|---------|
| **Scope** | Entire campaign | Single battle |
| **Time horizon** | Long-term | Short-term |
| **Key question** | What should we achieve and why? | How do we win this engagement? |

**The critical mistake:** Winning tactically while losing strategically. In Vietnam, the U.S. won most individual battles but lost the strategic war because tactical victories did not achieve political objectives.',
 '**Chiến lược** và **chiến thuật** hoạt động ở các cấp độ khác nhau:

| Chiều | Chiến lược | Chiến thuật |
|-------|-----------|------------|
| **Phạm vi** | Toàn bộ chiến dịch | Một trận chiến |
| **Thời gian** | Dài hạn | Ngắn hạn |
| **Câu hỏi chính** | Cần đạt gì và tại sao? | Làm thế nào thắng trận này? |

**Sai lầm nghiêm trọng:** Thắng chiến thuật nhưng thua chiến lược. Ở Việt Nam, Mỹ thắng hầu hết các trận nhưng thua chiến tranh chiến lược.',
 3, '{"type": "info"}'::jsonb);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'principles-of-strategy'),
 'fill_blank', 'easy',
 'Sun Tzu wrote: "If you know the enemy and know ___, you need not fear the result of a hundred battles."',
 'Tôn Tử viết: "Biết người biết ___, trăm trận trăm thắng."',
 'yourself',
 'Self-knowledge — understanding your own strengths, weaknesses, resources, and limitations — is as critical as understanding the enemy. Leaders who act without this dual intelligence make decisions based on illusions rather than reality.',
 'Tự biết mình — hiểu điểm mạnh, điểm yếu, tài nguyên và giới hạn — quan trọng như hiểu kẻ thù. Các nhà lãnh đạo hành động mà không có thông tin kép này đưa ra quyết định dựa trên ảo tưởng.',
 1);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'principles-of-strategy'),
 'multiple_choice', 'easy',
 'According to Clausewitz, what is war?',
 'Theo Clausewitz, chiến tranh là gì?',
 'Clausewitz defined war as "the continuation of politics by other means" in his masterwork "On War". War is never an end in itself — it is a tool of statecraft used when political goals cannot be achieved through diplomacy.',
 'Clausewitz định nghĩa chiến tranh là "sự tiếp nối chính trị bằng các phương tiện khác". Chiến tranh không bao giờ là mục đích tự thân — nó là công cụ quản lý nhà nước khi mục tiêu chính trị không thể đạt được qua ngoại giao.',
 2);

WITH mc_mil AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'principles-of-strategy')
  AND type = 'multiple_choice' AND order_index = 2
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'A sport between nations', 'Môn thể thao giữa các quốc gia', FALSE, 1 FROM mc_mil
UNION ALL SELECT id, 'B'::option_label, 'The continuation of politics by other means', 'Sự tiếp nối chính trị bằng phương tiện khác', TRUE, 2 FROM mc_mil
UNION ALL SELECT id, 'C'::option_label, 'A failure of diplomacy', 'Sự thất bại của ngoại giao', FALSE, 3 FROM mc_mil
UNION ALL SELECT id, 'D'::option_label, 'An expression of national culture', 'Biểu hiện văn hóa quốc gia', FALSE, 4 FROM mc_mil;

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'principles-of-strategy'),
 'true_false', 'easy',
 'The OODA loop was originally developed for business management.',
 'Vòng lặp OODA ban đầu được phát triển cho quản lý kinh doanh.',
 'false',
 'False. The OODA loop was developed by U.S. Air Force Colonel John Boyd, who studied superior U.S. pilot performance in the Korean War. American F-86 pilots defeated technically superior MiG-15s because their cockpit design allowed faster situational awareness and quicker OODA cycles. The framework was later adopted widely in business strategy.',
 'Sai. Vòng lặp OODA được phát triển bởi Đại tá Không quân Mỹ John Boyd, người nghiên cứu hiệu suất vượt trội của phi công Mỹ trong Chiến tranh Triều Tiên. Phi công F-86 đánh bại MiG-15 kỹ thuật vượt trội nhờ thiết kế buồng lái cho phép nhận thức nhanh hơn.',
 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'principles-of-strategy'),
 'fill_blank', 'medium',
 'Clausewitz used the term "___ of war" to describe the uncertainty and incomplete information inherent in conflict.',
 'Clausewitz dùng thuật ngữ "___ của chiến tranh" để mô tả sự bất định vốn có trong xung đột.',
 'fog',
 'The "fog of war" describes how commanders must make critical decisions with incomplete or contradictory information. No plan survives first contact with the enemy unchanged. Good commanders build flexible plans and remain psychologically prepared for surprises.',
 '"Sương mù chiến tranh" mô tả cách chỉ huy phải đưa ra quyết định quan trọng với thông tin không đầy đủ hoặc mâu thuẫn. Không kế hoạch nào tồn tại nguyên vẹn khi tiếp xúc đầu tiên với kẻ thù.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'principles-of-strategy'),
 'arrange_words', 'medium',
 'Arrange these words to state the Economy of Force principle.',
 'Sắp xếp các từ để phát biểu nguyên tắc Tiết Kiệm Lực Lượng.',
 'Concentrate maximum force at the decisive point',
 '["force", "the", "at", "maximum", "Concentrate", "decisive", "point"]',
 'Economy of Force means concentrating overwhelming strength at the decisive point while allocating minimum resources to secondary efforts. Uneven allocation creates local superiority that wins engagements. In business: focus your best people and resources on your most important initiative.',
 'Tiết Kiệm Lực Lượng có nghĩa là tập trung sức mạnh áp đảo tại điểm quyết định trong khi phân bổ tài nguyên tối thiểu cho các nỗ lực phụ. Trong kinh doanh: tập trung người giỏi nhất và tài nguyên vào sáng kiến quan trọng nhất.',
 5);


-- ############################################################################
-- LESSON 10: FAMOUS MILITARY CAMPAIGNS (slug: famous-military-campaigns)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Famous Military Campaigns', 'Các Chiến Dịch Quân Sự Nổi Tiếng',
  'famous-military-campaigns',
  'Analyze landmark campaigns from Hannibal to D-Day and extract strategic lessons',
  'Phân tích các chiến dịch quan trọng từ Hannibal đến D-Day và rút ra bài học chiến lược',
  'intermediate', 40, 2
FROM category WHERE name = 'Military Strategy';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'famous-military-campaigns'),
 'Battle of Cannae (216 BC)', 'Trận Cannae (216 TCN)',
 'Hannibal''s encirclement of a Roman army twice his size remains the most studied tactical victory in history. By feigning weakness at the center while enveloping both flanks, he destroyed 70,000 Romans in a single afternoon. The double envelopment became a military academy case study for 2,000 years.',
 'Việc Hannibal bao vây quân đội La Mã gấp đôi quân số của ông vẫn là chiến thắng chiến thuật được nghiên cứu nhiều nhất trong lịch sử. Bằng cách giả yếu ở trung tâm trong khi bao vây cả hai cánh, ông tiêu diệt 70.000 người La Mã trong một buổi chiều.',
 'Shield', TRUE, 1),
((SELECT id FROM lesson WHERE slug = 'famous-military-campaigns'),
 'Operation Overlord — D-Day (1944)', 'Chiến Dịch Overlord — D-Day (1944)',
 'The Normandy landings on June 6, 1944 were the largest amphibious operation in history — 156,000 troops across five beaches. Success required strategic deception (Operation Fortitude), air superiority, naval bombardment, and paratroop drops. It represents the gold standard of joint combined-arms planning.',
 'Cuộc đổ bộ Normandy ngày 6/6/1944 là chiến dịch đổ bộ lớn nhất lịch sử — 156.000 quân trên năm bãi biển. Thành công đòi hỏi lừa dối chiến lược (Fortitude), ưu thế trên không và thả lính dù.',
 'Public', TRUE, 2),
((SELECT id FROM lesson WHERE slug = 'famous-military-campaigns'),
 'Blitzkrieg — Fall of France (1940)', 'Chiến Tranh Chớp Nhoáng — Pháp Thất Thủ (1940)',
 'Germany defeated France in six weeks using Blitzkrieg doctrine. Rather than attacking where expected, armored units punched through the Ardennes forest to cut off Allied forces from behind. Speed, surprise, and exploitation of enemy psychology proved decisive over superior Allied numbers.',
 'Đức đánh bại Pháp trong sáu tuần bằng học thuyết Blitzkrieg. Thay vì tấn công nơi được mong đợi, các đơn vị thiết giáp đột phá qua rừng Ardennes để cắt đứt lực lượng Đồng Minh.',
 'RocketLaunch', TRUE, 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
((SELECT id FROM lesson WHERE slug = 'famous-military-campaigns'),
 'markdown', 'Military Campaigns That Changed History', 'Các Chiến Dịch Quân Sự Thay Đổi Lịch Sử',
'## Learning From History''s Greatest Campaigns

### Battle of Cannae (216 BC) — The Perfect Encirclement

Hannibal faced ~86,000 Romans with ~50,000 troops. His solution:
1. **Weak center**: Gallic infantry retreated under Roman pressure intentionally
2. **Strong flanks**: African veterans on both wings stood firm
3. **Envelopment**: As Romans pushed through, flanks closed in from both sides
4. **Result**: ~70,000 Romans killed — highest single-day ancient casualty count

**Strategic lesson**: Superior numbers mean nothing if encircled.

### Fall of France (1940) — Attacking Where Least Expected

| German Plan | Allied Expectation |
|-------------|-------------------|
| Main thrust through Ardennes | Ardennes impassable for armor |
| Cut off Allies from behind | Expected frontal assault through Belgium |

**Strategic lesson**: The strongest fortress is useless if bypassed.

### D-Day (1944) — Deception as Force Multiplier

Operation Fortitude convinced Germany the real invasion would target Pas-de-Calais. Germany kept 15+ divisions in reserve for weeks after D-Day — waiting for the "real" invasion.

**Strategic lesson**: Intelligence and deception can multiply combat power.',
'## Học Từ Các Chiến Dịch Vĩ Đại Nhất Lịch Sử

### Trận Cannae (216 TCN) — Bao Vây Hoàn Hảo

Hannibal đối mặt ~86.000 La Mã với ~50.000 quân:
1. **Trung tâm yếu**: Bộ binh Gaul cố tình rút lui
2. **Cánh mạnh**: Cựu chiến binh Châu Phi đứng vững ở hai cánh
3. **Bao vây**: Khi La Mã đẩy qua, các cánh khép lại
4. **Kết quả**: ~70.000 La Mã thiệt mạng

**Bài học chiến lược**: Số lượng vượt trội không có nghĩa gì nếu bị bao vây.

### Pháp Thất Thủ (1940) — Tấn Công Nơi Ít Được Mong Đợi

| Kế hoạch Đức | Kỳ vọng Đồng Minh |
|--------------|------------------|
| Mũi chủ công qua Ardennes | Ardennes không thể vượt cho thiết giáp |
| Cắt đứt Đồng Minh từ phía sau | Kỳ vọng tấn công chính diện qua Bỉ |

**Bài học**: Pháo đài mạnh nhất vô dụng nếu bị vòng qua.

### D-Day (1944) — Lừa Dối Như Hệ Số Nhân

Chiến dịch Fortitude giữ 15+ sư đoàn Đức ở sai địa điểm nhiều tuần.

**Bài học**: Lừa dối chiến lược nhân sức chiến đấu.',
 1, '{}'),
((SELECT id FROM lesson WHERE slug = 'famous-military-campaigns'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["Cannae (216 TCN): Hannibal tiêu diệt quân La Mã gấp đôi bằng bao vây kép — trung tâm yếu cố ý, cánh mạnh khép lại, mẫu hình chiến thuật được nghiên cứu 2.000 năm", "Blitzkrieg (1940): Đức đánh bại Pháp trong 6 tuần bằng đột phá qua Ardennes — tấn công nơi ít phòng thủ nhất, không phải nơi mạnh nhất", "D-Day (1944): Lừa dối chiến lược (Fortitude) giữ lực lượng dự bị Đức ở Calais — minh chứng thông tin nhân sức chiến đấu", "Tốc độ tâm lý quyết định hơn số lượng — Blitzkrieg tê liệt quá trình ra quyết định của Pháp trước khi họ kịp phản ứng", "Mỗi chiến dịch vĩ đại khai thác lỗ hổng nhận thức của địch — địch tin sai → phòng thủ sai chỗ → thất bại"]'::jsonb),
((SELECT id FROM lesson WHERE slug = 'famous-military-campaigns'),
 'info_box', 'The Maginot Line Fallacy', 'Sai Lầm Phòng Tuyến Maginot',
 'The Maginot Line was France''s masterpiece of defensive engineering — and its greatest strategic failure.

Built 1930–1936 at enormous cost (3 billion francs), it was never directly attacked. Germany simply drove around it through Belgium and the Ardennes. France surrendered in 6 weeks.

**The strategic lesson:** Defense optimized for the last war loses the next one.

**Modern parallel:** Companies that optimize for their current market position are often disrupted by competitors attacking from entirely new directions (Netflix vs. Blockbuster, Uber vs. taxis).',
 'Phòng tuyến Maginot là kiệt tác kỹ thuật phòng thủ của Pháp — và là thất bại chiến lược lớn nhất.

Xây dựng 1930–1936 với chi phí khổng lồ (3 tỷ franc), nó không bao giờ bị tấn công trực tiếp. Đức đơn giản lái xe vòng qua qua Bỉ và Ardennes. Pháp đầu hàng trong 6 tuần.

**Bài học chiến lược hiện đại:** Các công ty tối ưu hóa cho vị thế hiện tại thường bị phá vỡ bởi đối thủ tấn công từ hướng mới (Netflix vs. Blockbuster, Uber vs. taxi).',
 3, '{"type": "info"}'::jsonb);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'famous-military-campaigns'),
 'multiple_choice', 'easy',
 'What made Hannibal''s victory at Cannae tactically revolutionary?',
 'Điều gì làm chiến thắng của Hannibal tại Cannae mang tính cách mạng?',
 'Cannae introduced deliberate double envelopment — a concave center draws the enemy in while stronger flanks close around them. This creates a killing ground where numerical superiority becomes irrelevant. The concept influenced military planners for 2,000+ years.',
 'Cannae giới thiệu bao vây kép có chủ ý — trung tâm lõm kéo kẻ thù vào trong khi các cánh mạnh khép lại. Điều này tạo vùng tiêu diệt nơi ưu thế số lượng trở nên không liên quan.',
 1);

WITH mc_cam AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'famous-military-campaigns')
  AND type = 'multiple_choice' AND order_index = 1
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'Use of war elephants', 'Sử dụng voi chiến', FALSE, 1 FROM mc_cam
UNION ALL SELECT id, 'B'::option_label, 'Deliberate double envelopment of a larger force', 'Bao vây kép có chủ ý lực lượng đông hơn', TRUE, 2 FROM mc_cam
UNION ALL SELECT id, 'C'::option_label, 'Night attack under darkness', 'Tấn công đêm', FALSE, 3 FROM mc_cam
UNION ALL SELECT id, 'D'::option_label, 'Superior iron weapons', 'Vũ khí sắt vượt trội', FALSE, 4 FROM mc_cam;

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'famous-military-campaigns'),
 'true_false', 'easy',
 'Germany''s Blitzkrieg succeeded mainly because of superior numbers of tanks.',
 'Blitzkrieg của Đức thành công chủ yếu nhờ số lượng xe tăng vượt trội.',
 'false',
 'False. France and Britain had more tanks than Germany, and many French tanks were technically superior. Blitzkrieg succeeded because of doctrine: concentrated armor with motorized infantry, aggressive radio-coordinated command, and psychological speed that paralyzed French decision-making.',
 'Sai. Pháp và Anh có nhiều xe tăng hơn Đức và nhiều xe tăng Pháp kỹ thuật vượt trội. Blitzkrieg thành công vì học thuyết: thiết giáp tập trung với bộ binh cơ giới hóa, chỉ huy phối hợp radio và tốc độ tâm lý làm tê liệt quyết định của Pháp.',
 2);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'famous-military-campaigns'),
 'fill_blank', 'medium',
 'Operation ___ was the Allied deception plan that convinced Germany the D-Day invasion would land at Pas-de-Calais.',
 'Chiến dịch ___ là kế hoạch lừa dối thuyết phục Đức cuộc xâm lược D-Day sẽ đổ bộ ở Pas-de-Calais.',
 'Fortitude',
 'Operation Fortitude used fake radio traffic, inflatable tanks, and General Patton commanding a fictional army group. It worked so well that Hitler refused to release Panzer reserves on D-Day itself, waiting for the "real" invasion at Calais — a decision that may have been strategically decisive.',
 'Chiến dịch Fortitude sử dụng lưu lượng radio giả, xe tăng bơm hơi và Tướng Patton chỉ huy tập đoàn quân hư cấu. Nó hiệu quả đến mức Hitler từ chối giải phóng lực lượng Panzer dự bị vào ngày D-Day.',
 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'famous-military-campaigns'),
 'error_correction', 'medium',
 'Fix the error: "The Maginot Line failed because it was poorly built and collapsed under German attack."',
 'Sửa lỗi: "Phòng tuyến Maginot thất bại vì được xây kém và sụp đổ dưới cuộc tấn công của Đức."',
 'The Maginot Line failed because Germany bypassed it entirely, attacking through Belgium and the Ardennes rather than assaulting it directly.',
 'The Maginot Line was extremely well-built and was never directly attacked — it was never militarily defeated. The failure was France''s assumption that it would channel the German attack. Germany rendered it irrelevant by attacking around it.',
 'Phòng tuyến Maginot được xây dựng rất tốt và không bao giờ bị tấn công trực tiếp. Thất bại là giả định của Pháp rằng nó sẽ định hướng tấn công của Đức. Đức làm nó vô nghĩa bằng cách tấn công vòng quanh.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'famous-military-campaigns'),
 'arrange_words', 'medium',
 'Arrange to state the key lesson from the Fall of France (1940).',
 'Sắp xếp để phát biểu bài học chính từ Pháp thất thủ (1940).',
 'Attack where the enemy is least prepared not strongest',
 '["strongest", "the", "where", "least", "enemy", "not", "Attack", "prepared", "is"]',
 'Germany''s decisive insight was to attack through the Ardennes — precisely where France had not fortified because they deemed it impassable. The principle: avoid the enemy''s strongest defenses, find and exploit the gap. In business: compete where incumbents are weakest, not where they are strongest.',
 'Nhận thức quyết định của Đức là tấn công qua Ardennes — chính xác nơi Pháp không phòng thủ vì cho là không thể vượt qua. Nguyên tắc: tránh phòng thủ mạnh nhất của địch, tìm và khai thác khoảng trống.',
 5);
