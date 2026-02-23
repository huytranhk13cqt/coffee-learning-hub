-- ============================================================================
-- SEED DATA: Personal Finance (Category 18)
-- Category: Personal Finance (ID 18, order_index 18)
-- Lessons: budgeting-fundamentals, investing-basics, debt-management
-- Compatible with: schema.sql v7+
-- Applied AFTER: seed_medicine (category 17) or standalone
-- ============================================================================


-- ============================================================================
-- CATEGORY 18: Personal Finance
-- ============================================================================

INSERT INTO category (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('Personal Finance', 'Tài Chính Cá Nhân',
 'Master budgeting, investing, and financial planning for long-term wealth',
 'Làm chủ lập ngân sách, đầu tư và lập kế hoạch tài chính dài hạn',
 'AccountBalance', '#10b981', 18);


-- ############################################################################
-- LESSON 1: BUDGETING FUNDAMENTALS (slug: budgeting-fundamentals)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Budgeting Fundamentals', 'Cơ Bản Lập Ngân Sách',
  'budgeting-fundamentals',
  'Learn the 50/30/20 rule and how to track income vs expenses',
  'Học quy tắc 50/30/20 và cách theo dõi thu nhập vs chi tiêu',
  'beginner', 25, 1
FROM category WHERE name = 'Personal Finance';


-- ============================================================================
-- LESSON USAGES: budgeting-fundamentals
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'budgeting-fundamentals'),
 '50/30/20 Rule', 'Quy Tắc 50/30/20',
 'The 50/30/20 rule is a simple budgeting framework: allocate 50% of after-tax income to needs (rent, food, utilities), 30% to wants (dining out, entertainment, hobbies), and 20% to savings and debt repayment. It provides a flexible starting point for anyone new to budgeting.',
 'Quy tắc 50/30/20 là khung lập ngân sách đơn giản: phân bổ 50% thu nhập sau thuế cho nhu cầu (thuê nhà, thức ăn, tiện ích), 30% cho mong muốn (ăn ngoài, giải trí, sở thích) và 20% cho tiết kiệm và trả nợ. Nó cung cấp điểm khởi đầu linh hoạt cho bất kỳ ai mới làm quen với lập ngân sách.',
 'AccountBalance', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'budgeting-fundamentals'),
 'Emergency Fund', 'Quỹ Khẩn Cấp',
 'An emergency fund is a dedicated savings reserve covering 3–6 months of essential living expenses. It protects you from going into debt when unexpected events occur — job loss, medical emergencies, car repairs. Without one, a single crisis can derail years of financial progress.',
 'Quỹ khẩn cấp là khoản tiết kiệm dự trữ riêng biệt bao gồm 3–6 tháng chi phí sinh hoạt thiết yếu. Nó bảo vệ bạn khỏi mắc nợ khi xảy ra sự kiện bất ngờ — mất việc làm, cấp cứu y tế, sửa xe. Không có quỹ này, một cuộc khủng hoảng duy nhất có thể phá hủy nhiều năm tiến bộ tài chính.',
 'Savings', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'budgeting-fundamentals'),
 'Expense Tracking', 'Theo Dõi Chi Tiêu',
 'Expense tracking means recording every purchase to understand where your money actually goes versus where you think it goes. Most people significantly underestimate discretionary spending. Regular tracking reveals patterns, uncovers waste, and makes the abstract concept of a budget concrete and actionable.',
 'Theo dõi chi tiêu nghĩa là ghi lại mọi giao dịch mua để hiểu tiền của bạn thực sự đi đâu so với nơi bạn nghĩ. Hầu hết mọi người đánh giá thấp đáng kể chi tiêu tùy ý. Theo dõi thường xuyên tiết lộ các mẫu, phát hiện lãng phí và làm cho khái niệm trừu tượng của ngân sách trở nên cụ thể và có thể thực hiện.',
 'Receipt', TRUE, 3);


-- ============================================================================
-- LESSON SECTIONS: budgeting-fundamentals
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

-- Section 1: markdown overview
((SELECT id FROM lesson WHERE slug = 'budgeting-fundamentals'),
 'markdown', 'Building Your First Budget', 'Xây Dựng Ngân Sách Đầu Tiên',
'## What Is a Budget?

A budget is a **plan for how you will allocate your income** across spending, saving, and debt repayment. It is not about restriction — it is about intentionality.

### The 50/30/20 Rule

The most popular budgeting framework, popularized by Senator Elizabeth Warren in "All Your Worth" (2005):

| Category | Percentage | Examples |
|----------|-----------|---------|
| **Needs** | 50% | Rent/mortgage, groceries, utilities, minimum debt payments, insurance |
| **Wants** | 30% | Dining out, streaming services, gym, hobbies, travel |
| **Savings/Debt** | 20% | Emergency fund, retirement, extra debt payments, investments |

> **Important:** Apply percentages to **after-tax** (take-home) income, not gross income.

### Fixed vs Variable Expenses

- **Fixed expenses** — the same every month (rent, loan payment, insurance premium)
- **Variable expenses** — change each month (groceries, electricity, entertainment)

Variable expenses are where most budget leaks occur.

### Cash Flow: The Core Concept

$$\text{Cash Flow} = \text{Income} - \text{Expenses}$$

- **Positive cash flow** — you spend less than you earn → money available to save or invest
- **Negative cash flow** — you spend more than you earn → debt accumulates

The first step to financial health is achieving positive cash flow consistently.',

'## Ngân Sách Là Gì?

Ngân sách là **kế hoạch phân bổ thu nhập** cho chi tiêu, tiết kiệm và trả nợ. Nó không phải về hạn chế — mà là về sự có chủ đích.

### Quy Tắc 50/30/20

Khung lập ngân sách phổ biến nhất, được phổ biến bởi Thượng nghị sĩ Elizabeth Warren trong "All Your Worth" (2005):

| Danh mục | Tỷ lệ | Ví dụ |
|----------|-------|-------|
| **Nhu cầu** | 50% | Thuê/trả tiền nhà, thực phẩm, tiện ích, thanh toán nợ tối thiểu, bảo hiểm |
| **Mong muốn** | 30% | Ăn ngoài, dịch vụ streaming, phòng gym, sở thích, du lịch |
| **Tiết kiệm/Nợ** | 20% | Quỹ khẩn cấp, hưu trí, trả nợ thêm, đầu tư |

> **Quan trọng:** Áp dụng tỷ lệ cho thu nhập **sau thuế** (thu nhập thực nhận), không phải thu nhập gộp.

### Chi Phí Cố Định và Biến Đổi

- **Chi phí cố định** — như nhau mỗi tháng (tiền thuê, khoản vay, phí bảo hiểm)
- **Chi phí biến đổi** — thay đổi mỗi tháng (thực phẩm, điện, giải trí)

Chi phí biến đổi là nơi hầu hết rò rỉ ngân sách xảy ra.

### Dòng Tiền: Khái Niệm Cốt Lõi

$$\text{Dòng tiền} = \text{Thu nhập} - \text{Chi tiêu}$$

- **Dòng tiền dương** — bạn chi ít hơn thu nhập → có tiền để tiết kiệm hoặc đầu tư
- **Dòng tiền âm** — bạn chi nhiều hơn thu nhập → nợ tích lũy

Bước đầu tiên để có sức khỏe tài chính là đạt được dòng tiền dương nhất quán.',
 1, '{}'),

-- Section 2: key_points
((SELECT id FROM lesson WHERE slug = 'budgeting-fundamentals'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["Quy tắc 50/30/20: 50% nhu cầu, 30% mong muốn, 20% tiết kiệm — áp dụng cho thu nhập sau thuế", "Quỹ khẩn cấp (3–6 tháng chi phí) là nền tảng tài chính — không có nó, bất kỳ cuộc khủng hoảng nào cũng có thể dẫn đến nợ nần", "Dòng tiền = Thu nhập − Chi tiêu; dòng tiền dương là điều kiện tiên quyết để xây dựng tài sản", "Chi phí cố định (thuê nhà, bảo hiểm) khó thay đổi ngắn hạn; chi phí biến đổi (ăn uống, giải trí) là nơi cắt giảm dễ nhất", "Theo dõi chi tiêu trong 30 ngày trước khi lập ngân sách — hầu hết mọi người ngạc nhiên khi thấy tiền của họ thực sự đi đâu"]'::jsonb),

-- Section 3: info_box (emergency fund importance)
((SELECT id FROM lesson WHERE slug = 'budgeting-fundamentals'),
 'info_box', 'Why an Emergency Fund Comes First', 'Tại Sao Quỹ Khẩn Cấp Phải Đến Trước',
 '**The emergency fund is the single most important financial safety net you can build.**

Without one, any unexpected expense forces you into high-interest debt — which can take months or years to escape.

**Target amounts by situation:**
- Stable job, no dependents: **3 months** of essential expenses
- Self-employed or variable income: **6 months** of essential expenses
- Single income household with dependents: **6+ months**

**Where to keep it:**
- High-yield savings account (not checking account — too easy to spend)
- Separate from your regular savings (out of sight, out of mind)
- Liquid (accessible within 1-2 business days) — NOT invested in stocks

**The rule:** Touch it ONLY for true emergencies. A sale on shoes is not an emergency.',

 '**Quỹ khẩn cấp là mạng lưới an toàn tài chính quan trọng nhất bạn có thể xây dựng.**

Không có nó, bất kỳ chi phí bất ngờ nào cũng buộc bạn phải vay nợ lãi suất cao — có thể mất nhiều tháng hoặc nhiều năm để thoát ra.

**Số tiền mục tiêu theo tình huống:**
- Công việc ổn định, không có người phụ thuộc: **3 tháng** chi phí thiết yếu
- Tự kinh doanh hoặc thu nhập biến đổi: **6 tháng** chi phí thiết yếu
- Hộ gia đình thu nhập một người có người phụ thuộc: **6+ tháng**

**Nơi để giữ:**
- Tài khoản tiết kiệm lãi suất cao (không phải tài khoản thanh toán — quá dễ chi tiêu)
- Tách khỏi tiết kiệm thông thường (khuất mắt, khuất tâm)
- Thanh khoản (có thể truy cập trong 1–2 ngày làm việc) — KHÔNG đầu tư vào cổ phiếu

**Quy tắc:** Chỉ dùng cho khẩn cấp thực sự. Đợt giảm giá giày không phải khẩn cấp.',
 3, '{"type": "info"}'::jsonb);


-- ============================================================================
-- EXERCISES: budgeting-fundamentals (7 exercises)
-- ============================================================================

-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'budgeting-fundamentals'),
 'fill_blank', 'easy',
 'The 50/30/20 rule allocates 50% to needs, 30% to wants, and ___% to savings.',
 'Quy tắc 50/30/20 phân bổ 50% cho nhu cầu, 30% cho mong muốn và ___% cho tiết kiệm.',
 '20',
 'The 50/30/20 rule allocates after-tax income into three buckets: 50% for essential needs, 30% for discretionary wants, and 20% for savings and debt repayment. The 20% savings category includes emergency fund contributions, retirement accounts, and extra debt payments.',
 'Quy tắc 50/30/20 phân bổ thu nhập sau thuế thành ba nhóm: 50% cho nhu cầu thiết yếu, 30% cho mong muốn tùy ý và 20% cho tiết kiệm và trả nợ. Danh mục tiết kiệm 20% bao gồm đóng góp quỹ khẩn cấp, tài khoản hưu trí và thanh toán nợ thêm.',
 1);

-- Exercise 2: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'budgeting-fundamentals'),
 'multiple_choice', 'easy',
 'What is an emergency fund?',
 'Quỹ khẩn cấp là gì?',
 'An emergency fund is specifically 3–6 months of essential living expenses saved in a liquid, easily accessible account. It is distinct from an investment portfolio (which is for growth), a retirement account (which is for long-term), and business capital (which is for operations).',
 'Quỹ khẩn cấp cụ thể là 3–6 tháng chi phí sinh hoạt thiết yếu được tiết kiệm trong tài khoản thanh khoản, dễ tiếp cận. Nó khác với danh mục đầu tư (để tăng trưởng), tài khoản hưu trí (dài hạn) và vốn kinh doanh (để vận hành).',
 2);

WITH mc_ex AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'budgeting-fundamentals')
  AND type = 'multiple_choice'
  AND order_index = 2
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'Investment portfolio', 'Danh mục đầu tư', FALSE, 1 FROM mc_ex
UNION ALL SELECT id, 'B'::option_label, '3-6 months of living expenses saved', '3–6 tháng chi phí sinh hoạt được tiết kiệm', TRUE, 2 FROM mc_ex
UNION ALL SELECT id, 'C'::option_label, 'Retirement account', 'Tài khoản hưu trí', FALSE, 3 FROM mc_ex
UNION ALL SELECT id, 'D'::option_label, 'Business capital', 'Vốn kinh doanh', FALSE, 4 FROM mc_ex;


-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'budgeting-fundamentals'),
 'true_false', 'easy',
 'A budget is a plan for how you will spend and save your money.',
 'Ngân sách là kế hoạch cho cách bạn sẽ chi tiêu và tiết kiệm tiền.',
 'true',
 'True. A budget is a forward-looking financial plan that allocates expected income across spending categories, saving goals, and debt repayment. It is not a record of past spending (that is expense tracking) — it is a pre-commitment to how future money will be used.',
 'Đúng. Ngân sách là kế hoạch tài chính hướng tới tương lai phân bổ thu nhập dự kiến cho các danh mục chi tiêu, mục tiêu tiết kiệm và trả nợ. Nó không phải là hồ sơ chi tiêu trong quá khứ (đó là theo dõi chi tiêu) — nó là cam kết trước về cách sử dụng tiền trong tương lai.',
 3);

-- Exercise 4: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'budgeting-fundamentals'),
 'multiple_choice', 'easy',
 'What is the first step in creating a budget?',
 'Bước đầu tiên trong việc tạo ngân sách là gì?',
 'Calculating net income (take-home pay after taxes and deductions) is the essential first step because a budget is a percentage-based allocation of actual spendable income. Without knowing the total available, all subsequent planning is guesswork.',
 'Tính thu nhập ròng (lương thực nhận sau thuế và khấu trừ) là bước đầu tiên thiết yếu vì ngân sách là phân bổ theo tỷ lệ của thu nhập thực sự có thể chi tiêu. Không biết tổng số tiền có sẵn, tất cả lập kế hoạch tiếp theo chỉ là đoán mò.',
 4);

WITH mc_ex2 AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'budgeting-fundamentals')
  AND type = 'multiple_choice'
  AND order_index = 4
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'Cut all expenses', 'Cắt giảm toàn bộ chi phí', FALSE, 1 FROM mc_ex2
UNION ALL SELECT id, 'B'::option_label, 'Calculate your net income', 'Tính thu nhập ròng của bạn', TRUE, 2 FROM mc_ex2
UNION ALL SELECT id, 'C'::option_label, 'Open an investment account', 'Mở tài khoản đầu tư', FALSE, 3 FROM mc_ex2
UNION ALL SELECT id, 'D'::option_label, 'Pay off all debt', 'Trả hết toàn bộ nợ', FALSE, 4 FROM mc_ex2;


-- Exercise 5: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'budgeting-fundamentals'),
 'fill_blank', 'easy',
 'The difference between your income and expenses is called your ___ flow.',
 'Sự chênh lệch giữa thu nhập và chi tiêu của bạn được gọi là dòng ___ của bạn.',
 'cash',
 'Cash flow = Income − Expenses. Positive cash flow means you earn more than you spend, creating surplus money that can be saved or invested. Negative cash flow means you spend more than you earn, which leads to drawing down savings or accumulating debt.',
 'Dòng tiền = Thu nhập − Chi tiêu. Dòng tiền dương nghĩa là bạn kiếm nhiều hơn chi tiêu, tạo ra tiền thặng dư có thể tiết kiệm hoặc đầu tư. Dòng tiền âm nghĩa là bạn chi nhiều hơn kiếm, dẫn đến rút tiết kiệm hoặc tích lũy nợ.',
 5);

-- Exercise 6: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'budgeting-fundamentals'),
 'true_false', 'easy',
 'Fixed expenses change every month.',
 'Chi phí cố định thay đổi mỗi tháng.',
 'false',
 'False. Fixed expenses stay the same (or nearly the same) each month — examples include rent, mortgage payments, car loans, and insurance premiums. Variable expenses are the ones that change monthly, such as groceries, utilities, dining out, and entertainment. Understanding this distinction is key to effective budget management.',
 'Sai. Chi phí cố định không thay đổi (hoặc gần như không thay đổi) mỗi tháng — ví dụ bao gồm tiền thuê, trả tiền thế chấp, vay mua xe và phí bảo hiểm. Chi phí biến đổi là những chi phí thay đổi hàng tháng, chẳng hạn như thực phẩm, tiện ích, ăn ngoài và giải trí. Hiểu sự phân biệt này là chìa khóa để quản lý ngân sách hiệu quả.',
 6);

-- Exercise 7: error_correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'budgeting-fundamentals'),
 'error_correction', 'medium',
 'Fix the errors in this sentence: "A budget help you track where your money going and ensures you dont overspend."',
 'Sửa các lỗi trong câu này: "A budget help you track where your money going and ensures you dont overspend."',
 'A budget helps you track where your money is going and ensures you don''t overspend.',
 'Three errors: (1) "help" → "helps" — third-person singular subject "A budget" requires the -s ending. (2) "money going" → "money is going" — the present continuous tense requires the auxiliary verb "is". (3) "dont" → "don''t" — the contraction requires an apostrophe.',
 'Ba lỗi: (1) "help" → "helps" — chủ ngữ ngôi thứ ba số ít "A budget" yêu cầu kết thúc bằng -s. (2) "money going" → "money is going" — thì hiện tại tiếp diễn yêu cầu trợ động từ "is". (3) "dont" → "don''t" — dạng rút gọn cần dấu nháy đơn.',
 7);


-- ############################################################################
-- LESSON 2: INVESTING BASICS (slug: investing-basics)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Investing Basics', 'Cơ Bản Đầu Tư',
  'investing-basics',
  'Understand stocks, bonds, compound interest, and diversification',
  'Hiểu cổ phiếu, trái phiếu, lãi kép và đa dạng hóa danh mục',
  'intermediate', 40, 2
FROM category WHERE name = 'Personal Finance';


-- ============================================================================
-- LESSON USAGES: investing-basics
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'investing-basics'),
 'Stocks and Bonds', 'Cổ Phiếu và Trái Phiếu',
 'Stocks represent ownership shares in a company — stockholders profit when the company grows. Bonds are loans to governments or companies that pay regular interest. Stocks offer higher potential returns but more volatility; bonds offer lower returns with more stability.',
 'Cổ phiếu đại diện cho cổ phần sở hữu trong một công ty — cổ đông thu lợi khi công ty tăng trưởng. Trái phiếu là khoản vay cho chính phủ hoặc công ty trả lãi định kỳ. Cổ phiếu có tiềm năng lợi nhuận cao hơn nhưng biến động nhiều hơn; trái phiếu có lợi nhuận thấp hơn với ổn định hơn.',
 'TrendingUp', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'investing-basics'),
 'Compound Interest', 'Lãi Kép',
 'Compound interest is earning interest on your interest — your returns generate additional returns over time. Albert Einstein reportedly called it the "eighth wonder of the world." Starting early dramatically amplifies wealth because compounding needs time to accelerate.',
 'Lãi kép là kiếm lãi trên lãi — lợi nhuận của bạn tạo ra thêm lợi nhuận theo thời gian. Albert Einstein được cho là đã gọi nó là "kỳ quan thứ tám của thế giới." Bắt đầu sớm khuếch đại tài sản đáng kể vì lãi kép cần thời gian để tăng tốc.',
 'AutoGraph', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'investing-basics'),
 'Diversification', 'Đa Dạng Hóa',
 'Diversification means spreading investments across different assets, sectors, and geographies to reduce risk. When one investment falls, others may rise, smoothing out portfolio volatility. Index funds and ETFs provide instant diversification across hundreds or thousands of stocks.',
 'Đa dạng hóa nghĩa là phân bổ đầu tư qua các tài sản, lĩnh vực và địa lý khác nhau để giảm rủi ro. Khi một khoản đầu tư giảm, những khoản khác có thể tăng, làm mịn biến động danh mục. Quỹ chỉ số và ETF cung cấp đa dạng hóa tức thì trên hàng trăm hoặc hàng ngàn cổ phiếu.',
 'PieChart', TRUE, 3);


-- ============================================================================
-- LESSON SECTIONS: investing-basics
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

-- Section 1: markdown overview
((SELECT id FROM lesson WHERE slug = 'investing-basics'),
 'markdown', 'Why Invest? Making Money Work for You', 'Tại Sao Đầu Tư? Làm Cho Tiền Làm Việc',
'## The Case for Investing

Saving money in a bank account is safe, but inflation slowly erodes purchasing power. **Investing** puts your money to work, growing it faster than inflation.

### Asset Classes

| Asset | Risk | Return Potential | Typical Use |
|-------|------|-----------------|-------------|
| **Cash/Savings** | Very low | Very low (0.5–2%) | Emergency fund |
| **Bonds** | Low-Medium | Low (2–5%) | Stability, income |
| **Index Funds/ETFs** | Medium | Medium-High (7–10% avg) | Long-term growth |
| **Individual Stocks** | High | Variable | Growth potential |
| **Real Estate** | Medium | Medium (5–8%) | Passive income + appreciation |

### The Power of Compound Interest

$$FV = PV \times (1 + r)^n$$

Where:
- **FV** = Future Value
- **PV** = Present Value (initial investment)
- **r** = annual interest rate
- **n** = number of years

**Example:** $1,000 at 5% annual return:
- After 10 years: **$1,629**
- After 20 years: **$2,653**
- After 30 years: **$4,322**

> The earlier you start, the more time compounding has to work. **Waiting 10 years to start costs you roughly half your final wealth.**

### Key Investing Principles

1. **Start early** — time is your most powerful asset
2. **Invest consistently** — dollar-cost averaging reduces timing risk
3. **Diversify** — do not put all eggs in one basket
4. **Keep costs low** — fund expense ratios compound too (against you)
5. **Stay the course** — emotional selling during downturns destroys returns',

'## Lý Do Đầu Tư: Làm Cho Tiền Làm Việc Vì Bạn

Tiết kiệm tiền trong tài khoản ngân hàng là an toàn, nhưng lạm phát từ từ侵蚀 sức mua. **Đầu tư** làm cho tiền của bạn hoạt động, tăng trưởng nhanh hơn lạm phát.

### Các Loại Tài Sản

| Tài sản | Rủi ro | Tiềm năng lợi nhuận | Mục đích điển hình |
|---------|--------|--------------------|--------------------|
| **Tiền mặt/Tiết kiệm** | Rất thấp | Rất thấp (0,5–2%) | Quỹ khẩn cấp |
| **Trái phiếu** | Thấp-Trung | Thấp (2–5%) | Ổn định, thu nhập |
| **Quỹ chỉ số/ETF** | Trung | Trung-Cao (TB 7–10%) | Tăng trưởng dài hạn |
| **Cổ phiếu riêng lẻ** | Cao | Thay đổi | Tiềm năng tăng trưởng |
| **Bất động sản** | Trung | Trung (5–8%) | Thu nhập thụ động + tăng giá |

### Sức Mạnh Của Lãi Kép

$$FV = PV \times (1 + r)^n$$

Trong đó:
- **FV** = Giá trị tương lai
- **PV** = Giá trị hiện tại (đầu tư ban đầu)
- **r** = lãi suất hàng năm
- **n** = số năm

**Ví dụ:** $1.000 với lợi nhuận hàng năm 5%:
- Sau 10 năm: **$1.629**
- Sau 20 năm: **$2.653**
- Sau 30 năm: **$4.322**

> Bạn bắt đầu càng sớm, lãi kép càng có nhiều thời gian để hoạt động. **Chờ 10 năm để bắt đầu khiến bạn mất khoảng một nửa tài sản cuối cùng.**

### Nguyên Tắc Đầu Tư Quan Trọng

1. **Bắt đầu sớm** — thời gian là tài sản mạnh nhất của bạn
2. **Đầu tư nhất quán** — trung bình chi phí bằng đô la giảm rủi ro định thời
3. **Đa dạng hóa** — đừng bỏ tất cả trứng vào một giỏ
4. **Giữ chi phí thấp** — tỷ lệ chi phí quỹ cũng lãi kép (chống lại bạn)
5. **Kiên trì** — bán cảm tính trong thời gian suy giảm phá hủy lợi nhuận',
 1, '{}'),

-- Section 2: key_points
((SELECT id FROM lesson WHERE slug = 'investing-basics'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["Lãi kép nghĩa là lãi tạo ra thêm lãi — đây là lý do tại sao bắt đầu đầu tư sớm có tác động khổng lồ đến tài sản dài hạn", "Cổ phiếu = sở hữu công ty (lợi nhuận cao, rủi ro cao); trái phiếu = cho vay (thu nhập ổn định, rủi ro thấp hơn)", "Đa dạng hóa trên nhiều tài sản, lĩnh vực và địa lý giảm rủi ro mà không giảm nhiều lợi nhuận", "Quỹ chỉ số và ETF cung cấp đa dạng hóa rộng với chi phí thấp — phù hợp nhất cho hầu hết nhà đầu tư", "Thu nhập thụ động (cổ tức, lãi, tiền thuê) tạo ra dòng tiền mà không cần làm việc tích cực"]'::jsonb),

-- Section 3: chart (compound interest growth)
((SELECT id FROM lesson WHERE slug = 'investing-basics'),
 'chart', 'Compound Interest Growth Over Time', 'Tăng Trưởng Lãi Kép Theo Thời Gian',
 'This chart shows how $1,000 grows with compound interest at 5% annually versus staying flat as an initial deposit. The gap widens dramatically over time — illustrating why starting early is the most powerful investing decision.',
 'Biểu đồ này cho thấy $1.000 tăng trưởng như thế nào với lãi kép 5% hàng năm so với việc giữ nguyên là khoản tiền gửi ban đầu. Khoảng cách mở rộng đáng kể theo thời gian — minh họa lý do tại sao bắt đầu sớm là quyết định đầu tư mạnh mẽ nhất.',
 3,
 '{"chartType": "bar", "title": "Compound Interest Growth", "titleVi": "Tăng trưởng lãi kép", "xAxisLabel": "Years", "yAxisLabel": "Value ($)", "xKey": "name", "series": [{"dataKey": "Initial", "name": "Initial", "nameVi": "Vốn ban đầu", "color": "#6366f1"}, {"dataKey": "Compound", "name": "Compound", "nameVi": "Lãi kép", "color": "#10b981"}], "data": [{"name": "Year 0", "Initial": 1000, "Compound": 1000}, {"name": "Year 5", "Initial": 1000, "Compound": 1276}, {"name": "Year 10", "Initial": 1000, "Compound": 1629}, {"name": "Year 20", "Initial": 1000, "Compound": 2653}, {"name": "Year 30", "Initial": 1000, "Compound": 4322}]}'::jsonb);


-- ============================================================================
-- EXERCISES: investing-basics (7 exercises)
-- ============================================================================

-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'investing-basics'),
 'fill_blank', 'medium',
 'The effect where interest earns more interest over time is called ___ interest.',
 'Hiệu ứng mà lãi tạo ra thêm lãi theo thời gian được gọi là lãi ___.',
 'compound',
 'Compound interest means you earn returns not only on your original principal but also on all previously accumulated returns. This creates exponential growth over time. Simple interest, in contrast, only earns returns on the original principal — which grows linearly.',
 'Lãi kép nghĩa là bạn kiếm lợi nhuận không chỉ trên vốn gốc ban đầu mà còn trên tất cả lợi nhuận tích lũy trước đó. Điều này tạo ra tăng trưởng theo hàm mũ theo thời gian. Ngược lại, lãi đơn chỉ kiếm lợi nhuận trên vốn gốc — tăng trưởng tuyến tính.',
 1);

-- Exercise 2: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'investing-basics'),
 'multiple_choice', 'medium',
 'What do stocks represent?',
 'Cổ phiếu đại diện cho điều gì?',
 'When you buy a stock, you become a part-owner (shareholder) of that company. You benefit when the company''s value grows (capital gains) and may receive a share of profits (dividends). Unlike bonds, stocks do not promise fixed repayments — returns depend entirely on company performance.',
 'Khi bạn mua cổ phiếu, bạn trở thành đồng sở hữu (cổ đông) của công ty đó. Bạn được hưởng lợi khi giá trị công ty tăng (lãi vốn) và có thể nhận một phần lợi nhuận (cổ tức). Không giống trái phiếu, cổ phiếu không hứa hẹn hoàn trả cố định — lợi nhuận hoàn toàn phụ thuộc vào hiệu quả hoạt động của công ty.',
 2);

WITH mc_ex AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'investing-basics')
  AND type = 'multiple_choice'
  AND order_index = 2
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'Loans to companies', 'Khoản vay cho công ty', FALSE, 1 FROM mc_ex
UNION ALL SELECT id, 'B'::option_label, 'Ownership shares in companies', 'Cổ phần sở hữu trong công ty', TRUE, 2 FROM mc_ex
UNION ALL SELECT id, 'C'::option_label, 'Government debt', 'Nợ chính phủ', FALSE, 3 FROM mc_ex
UNION ALL SELECT id, 'D'::option_label, 'Bank deposits', 'Tiền gửi ngân hàng', FALSE, 4 FROM mc_ex;


-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'investing-basics'),
 'true_false', 'medium',
 'Diversification means spreading investments across different asset classes to reduce risk.',
 'Đa dạng hóa nghĩa là phân bổ đầu tư qua các loại tài sản khác nhau để giảm rủi ro.',
 'true',
 'True. Diversification is the practice of allocating investments across different asset classes (stocks, bonds, real estate), sectors (tech, healthcare, energy), and geographies (domestic, international). When assets are not perfectly correlated, losses in one area can be offset by gains in another, reducing overall portfolio volatility.',
 'Đúng. Đa dạng hóa là thực hành phân bổ đầu tư qua các loại tài sản khác nhau (cổ phiếu, trái phiếu, bất động sản), lĩnh vực (công nghệ, y tế, năng lượng) và địa lý (trong nước, quốc tế). Khi các tài sản không tương quan hoàn hảo, tổn thất ở một lĩnh vực có thể được bù đắp bởi lợi nhuận ở lĩnh vực khác, giảm biến động danh mục tổng thể.',
 3);

-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'investing-basics'),
 'fill_blank', 'medium',
 'The return on investment that comes from interest, dividends, or rent is called ___ income.',
 'Lợi nhuận đầu tư đến từ lãi, cổ tức hoặc tiền thuê được gọi là thu nhập ___.',
 'passive',
 'Passive income is money earned with minimal active effort — it flows in regularly without requiring you to trade your time for it. Common sources include bond interest, stock dividends, rental income from real estate, and royalties. Building passive income streams is a core goal of long-term investing.',
 'Thu nhập thụ động là tiền kiếm được với nỗ lực chủ động tối thiểu — nó chảy vào đều đặn mà không yêu cầu bạn đổi thời gian để lấy nó. Các nguồn phổ biến bao gồm lãi trái phiếu, cổ tức cổ phiếu, thu nhập cho thuê bất động sản và tiền bản quyền. Xây dựng các nguồn thu nhập thụ động là mục tiêu cốt lõi của đầu tư dài hạn.',
 4);

-- Exercise 5: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'investing-basics'),
 'multiple_choice', 'medium',
 'Which investment is generally considered lower risk?',
 'Khoản đầu tư nào thường được xem là rủi ro thấp hơn?',
 'Index funds track a broad market index (e.g., S&P 500) by holding hundreds or thousands of securities. This built-in diversification, combined with low expense ratios, makes them the recommended choice for most long-term investors. Individual stocks and crypto are high-risk; startup equity is extremely high-risk.',
 'Quỹ chỉ số theo dõi chỉ số thị trường rộng (ví dụ: S&P 500) bằng cách nắm giữ hàng trăm hoặc hàng nghìn chứng khoán. Sự đa dạng hóa tích hợp này, kết hợp với tỷ lệ chi phí thấp, làm cho chúng trở thành lựa chọn được khuyến nghị cho hầu hết nhà đầu tư dài hạn. Cổ phiếu riêng lẻ và tiền điện tử rủi ro cao; cổ phần khởi nghiệp rủi ro cực cao.',
 5);

WITH mc_ex2 AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'investing-basics')
  AND type = 'multiple_choice'
  AND order_index = 5
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'Individual stocks', 'Cổ phiếu riêng lẻ', FALSE, 1 FROM mc_ex2
UNION ALL SELECT id, 'B'::option_label, 'Cryptocurrency', 'Tiền điện tử', FALSE, 2 FROM mc_ex2
UNION ALL SELECT id, 'C'::option_label, 'Index funds', 'Quỹ chỉ số', TRUE, 3 FROM mc_ex2
UNION ALL SELECT id, 'D'::option_label, 'Startup equity', 'Cổ phần khởi nghiệp', FALSE, 4 FROM mc_ex2;


-- Exercise 6: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'investing-basics'),
 'true_false', 'medium',
 'Bonds typically offer higher returns than stocks over the long term.',
 'Trái phiếu thường mang lại lợi nhuận cao hơn cổ phiếu về dài hạn.',
 'false',
 'False. Historically, stocks (equities) have significantly outperformed bonds over long periods. The S&P 500 has averaged roughly 10% annually over the past century. Bonds typically return 2–5%. The trade-off is volatility — stocks fluctuate more year-to-year, which is why they reward long-term investors who do not panic-sell during downturns.',
 'Sai. Về lịch sử, cổ phiếu (vốn chủ sở hữu) vượt trội đáng kể so với trái phiếu trong dài hạn. S&P 500 đã trung bình khoảng 10% hàng năm trong thế kỷ qua. Trái phiếu thường trả 2–5%. Đánh đổi là biến động — cổ phiếu dao động nhiều hơn theo năm, đó là lý do tại sao chúng thưởng cho nhà đầu tư dài hạn không hoảng loạn bán trong thời gian suy giảm.',
 6);

-- Exercise 7: sentence_transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'investing-basics'),
 'sentence_transform', 'medium',
 'Transform "Start investing early" to explain why with compound interest.',
 'Chuyển đổi "Start investing early" để giải thích lý do với lãi kép.',
 'Start investing early because compound interest multiplies your wealth exponentially over time.',
 'The original sentence is advice without justification. A complete explanation links the action (start early) to the mechanism (compound interest) and the outcome (exponential wealth growth). The earlier you invest, the more compounding cycles your money goes through.',
 'Câu gốc là lời khuyên không có lý do. Một giải thích đầy đủ liên kết hành động (bắt đầu sớm) với cơ chế (lãi kép) và kết quả (tăng trưởng tài sản theo hàm mũ). Bạn đầu tư càng sớm, tiền của bạn trải qua càng nhiều chu kỳ lãi kép.',
 7);


-- ############################################################################
-- LESSON 3: DEBT MANAGEMENT (slug: debt-management)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Debt Management', 'Quản Lý Nợ',
  'debt-management',
  'Distinguish good debt from bad debt and learn payoff strategies',
  'Phân biệt nợ tốt và nợ xấu và học chiến lược trả nợ',
  'intermediate', 30, 3
FROM category WHERE name = 'Personal Finance';


-- ============================================================================
-- LESSON USAGES: debt-management
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'debt-management'),
 'Good Debt vs Bad Debt', 'Nợ Tốt vs Nợ Xấu',
 'Not all debt is equal. "Good debt" finances assets that appreciate in value or increase earning power — like a mortgage or student loan for a high-return degree. "Bad debt" finances consumption or depreciating assets at high interest rates — like credit card balances or payday loans.',
 'Không phải tất cả nợ đều bằng nhau. "Nợ tốt" tài trợ cho tài sản tăng giá hoặc tăng khả năng kiếm tiền — như thế chấp hoặc vay học sinh cho bằng cấp lợi nhuận cao. "Nợ xấu" tài trợ cho tiêu dùng hoặc tài sản giảm giá với lãi suất cao — như số dư thẻ tín dụng hoặc vay ngắn hạn.',
 'CreditCard', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'debt-management'),
 'Debt Avalanche', 'Phương Pháp Tuyết Lở',
 'The debt avalanche method pays minimum payments on all debts, then directs all extra money to the highest-interest-rate debt first. Once that is paid off, the freed-up payment attacks the next highest-rate debt. This approach minimizes total interest paid — making it the most mathematically efficient strategy.',
 'Phương pháp tuyết lở trả tối thiểu trên tất cả các khoản nợ, sau đó hướng tất cả tiền thêm vào khoản nợ có lãi suất cao nhất trước. Sau khi trả xong, khoản thanh toán được giải phóng tấn công khoản nợ lãi suất cao tiếp theo. Cách tiếp cận này giảm thiểu tổng lãi phải trả — làm cho nó trở thành chiến lược hiệu quả nhất về mặt toán học.',
 'Savings', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'debt-management'),
 'Debt Snowball', 'Phương Pháp Quả Cầu Tuyết',
 'The debt snowball method pays minimum payments on all debts, then throws extra money at the smallest balance first — regardless of interest rate. Once a debt is eliminated, its monthly payment is added to the next smallest debt. The psychological momentum of quick wins helps people stay motivated.',
 'Phương pháp quả cầu tuyết trả tối thiểu trên tất cả các khoản nợ, sau đó ném tiền thêm vào khoản nợ có số dư nhỏ nhất trước — bất kể lãi suất. Sau khi xóa hết một khoản nợ, khoản thanh toán hàng tháng của nó được cộng vào khoản nợ nhỏ tiếp theo. Động lực tâm lý từ những chiến thắng nhanh giúp mọi người duy trì động lực.',
 'Snowflake', TRUE, 3);


-- ============================================================================
-- LESSON SECTIONS: debt-management
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

-- Section 1: markdown overview
((SELECT id FROM lesson WHERE slug = 'debt-management'),
 'markdown', 'Taking Control of Debt', 'Kiểm Soát Nợ',
'## Understanding and Eliminating Debt

Debt is a tool — used wisely, it accelerates wealth; used poorly, it destroys it.

### Good Debt vs Bad Debt

| Type | Examples | Why It Matters |
|------|---------|---------------|
| **Good debt** | Mortgage, student loan (high ROI), business loan | Finances assets that grow or increase income |
| **Neutral debt** | Car loan (reliable transportation needed for work) | Depreciates but serves a functional need |
| **Bad debt** | Credit cards, payday loans, consumer finance | High interest on depreciating or consumable items |

> **Rule of thumb:** If the interest rate exceeds likely investment returns (~7%), pay it off first.

### Two Proven Payoff Strategies

**Debt Avalanche (Mathematically Optimal)**
1. List debts by interest rate — highest to lowest
2. Pay minimums on all debts
3. Direct all extra money to the highest-rate debt
4. When paid off, roll that payment to the next debt

**Debt Snowball (Psychologically Effective)**
1. List debts by balance — smallest to largest
2. Pay minimums on all debts
3. Direct all extra money to the smallest balance
4. When paid off, roll that payment to the next debt

### Annual Percentage Rate (APR)

APR is the annual cost of borrowing, expressed as a percentage:

$$\text{APR} = \text{Interest Rate} + \text{Fees (annualized)}$$

| Debt Type | Typical APR |
|-----------|------------|
| Mortgage | 3–7% |
| Student loans | 4–8% |
| Car loans | 4–10% |
| Credit cards | 15–29% |
| Payday loans | 300–400% |

> High-interest debt (especially credit cards) should nearly always be paid off before investing.

### The Debt-Investment Crossover

If your debt APR > expected investment return → **pay debt first**
If your debt APR < expected investment return → **invest while making minimum payments**',

'## Hiểu và Loại Bỏ Nợ

Nợ là công cụ — sử dụng khôn ngoan, nó tăng tốc tài sản; sử dụng kém, nó phá hủy nó.

### Nợ Tốt vs Nợ Xấu

| Loại | Ví dụ | Tại sao quan trọng |
|------|-------|-------------------|
| **Nợ tốt** | Thế chấp, vay học sinh (ROI cao), vay kinh doanh | Tài trợ tài sản tăng trưởng hoặc tăng thu nhập |
| **Nợ trung tính** | Vay mua xe (cần phương tiện đáng tin cậy cho công việc) | Mất giá nhưng phục vụ nhu cầu chức năng |
| **Nợ xấu** | Thẻ tín dụng, vay ngắn hạn, tài chính tiêu dùng | Lãi suất cao trên tài sản mất giá hoặc tiêu thụ |

> **Nguyên tắc chung:** Nếu lãi suất vượt quá lợi nhuận đầu tư có thể (~7%), hãy trả trước.

### Hai Chiến Lược Trả Nợ Đã Được Chứng Minh

**Phương pháp Tuyết Lở (Tối ưu về Toán học)**
1. Liệt kê nợ theo lãi suất — cao nhất đến thấp nhất
2. Trả tối thiểu trên tất cả các khoản nợ
3. Hướng tất cả tiền thêm vào khoản nợ lãi suất cao nhất
4. Khi trả xong, chuyển khoản thanh toán đó sang khoản nợ tiếp theo

**Phương pháp Quả Cầu Tuyết (Hiệu quả về Tâm lý)**
1. Liệt kê nợ theo số dư — nhỏ nhất đến lớn nhất
2. Trả tối thiểu trên tất cả các khoản nợ
3. Hướng tất cả tiền thêm vào số dư nhỏ nhất
4. Khi trả xong, chuyển khoản thanh toán đó sang khoản nợ tiếp theo

### Lãi Suất Phần Trăm Hàng Năm (APR)

APR là chi phí vay hàng năm, được biểu thị dưới dạng phần trăm:

$$\text{APR} = \text{Lãi suất} + \text{Phí (tính theo năm)}$$

| Loại nợ | APR điển hình |
|---------|--------------|
| Thế chấp | 3–7% |
| Vay học sinh | 4–8% |
| Vay mua xe | 4–10% |
| Thẻ tín dụng | 15–29% |
| Vay ngắn hạn | 300–400% |

> Nợ lãi suất cao (đặc biệt thẻ tín dụng) hầu như luôn nên được trả trước khi đầu tư.

### Giao Điểm Nợ-Đầu Tư

Nếu APR nợ > lợi nhuận đầu tư dự kiến → **trả nợ trước**
Nếu APR nợ < lợi nhuận đầu tư dự kiến → **đầu tư trong khi trả tối thiểu**',
 1, '{}'),

-- Section 2: key_points
((SELECT id FROM lesson WHERE slug = 'debt-management'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["Nợ tốt tài trợ tài sản tăng giá hoặc tăng thu nhập (thế chấp, vay học sinh ROI cao); nợ xấu tài trợ tiêu dùng với lãi suất cao", "Phương pháp Tuyết Lở — trả khoản nợ lãi suất cao nhất trước — tiết kiệm nhiều tiền lãi nhất về mặt toán học", "Phương pháp Quả Cầu Tuyết — trả số dư nhỏ nhất trước — tạo ra động lực tâm lý từ những chiến thắng nhanh", "APR (Lãi suất Phần trăm Hàng năm) là thước đo thực sự của chi phí nợ; thẻ tín dụng thường 15–29%, vay ngắn hạn 300–400%", "Quy tắc chung: nếu APR nợ > lợi nhuận đầu tư dự kiến (~7%), trả nợ trước khi đầu tư"]'::jsonb),

-- Section 3: info_box (APR explanation)
((SELECT id FROM lesson WHERE slug = 'debt-management'),
 'info_box', 'What Is APR and Why It Matters', 'APR Là Gì và Tại Sao Quan Trọng',
 '**APR (Annual Percentage Rate)** is the true annual cost of borrowing — it includes both the interest rate AND any fees, expressed as a yearly percentage.

**Why APR matters more than the interest rate:**
- A loan advertised at "2% per month" sounds small, but that is ~26.8% APR
- Payday loans advertised as "$15 per $100 for 2 weeks" = **391% APR**
- A credit card with 20% APR costs you $200/year on a $1,000 balance

**APR vs APY:**
- **APR** = Annual Percentage Rate (borrowing cost — used for loans and credit cards)
- **APY** = Annual Percentage Yield (earning rate — used for savings accounts; includes compounding)

**Practical rule:** When comparing debts, always compare APRs. When comparing savings or investment accounts, compare APYs.',

 '**APR (Lãi Suất Phần Trăm Hàng Năm)** là chi phí vay thực sự hàng năm — nó bao gồm cả lãi suất VÀ mọi phí, được biểu thị dưới dạng phần trăm hàng năm.

**Tại sao APR quan trọng hơn lãi suất:**
- Khoản vay quảng cáo "2% mỗi tháng" có vẻ nhỏ, nhưng đó là ~26,8% APR
- Vay ngắn hạn quảng cáo "$15 cho $100 trong 2 tuần" = **391% APR**
- Thẻ tín dụng với APR 20% khiến bạn mất $200/năm trên số dư $1.000

**APR vs APY:**
- **APR** = Lãi Suất Phần Trăm Hàng Năm (chi phí vay — dùng cho khoản vay và thẻ tín dụng)
- **APY** = Lợi Suất Phần Trăm Hàng Năm (tỷ lệ kiếm — dùng cho tài khoản tiết kiệm; bao gồm lãi kép)

**Quy tắc thực tế:** Khi so sánh các khoản nợ, luôn so sánh APR. Khi so sánh tài khoản tiết kiệm hoặc đầu tư, so sánh APY.',
 3, '{"type": "info"}'::jsonb);


-- ============================================================================
-- EXERCISES: debt-management (7 exercises)
-- ============================================================================

-- Exercise 1: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'debt-management'),
 'multiple_choice', 'medium',
 'Which is an example of "good debt"?',
 'Đâu là ví dụ về "nợ tốt"?',
 'A student loan for a high-ROI degree is considered good debt because it finances an investment in human capital that is expected to generate significantly higher lifetime income than the cost of the loan. Credit card debt, payday loans, and gambling debt are all examples of bad debt — high-cost financing of consumption with no lasting financial benefit.',
 'Vay học sinh cho bằng cấp ROI cao được xem là nợ tốt vì nó tài trợ cho đầu tư vào vốn con người dự kiến tạo ra thu nhập suốt đời cao hơn đáng kể so với chi phí khoản vay. Nợ thẻ tín dụng, vay ngắn hạn và nợ cờ bạc đều là ví dụ về nợ xấu — tài chính chi phí cao cho tiêu dùng không có lợi ích tài chính lâu dài.',
 1);

WITH mc_ex AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'debt-management')
  AND type = 'multiple_choice'
  AND order_index = 1
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'Credit card debt', 'Nợ thẻ tín dụng', FALSE, 1 FROM mc_ex
UNION ALL SELECT id, 'B'::option_label, 'Payday loans', 'Vay ngắn hạn', FALSE, 2 FROM mc_ex
UNION ALL SELECT id, 'C'::option_label, 'Student loan for high ROI degree', 'Vay học sinh cho bằng cấp ROI cao', TRUE, 3 FROM mc_ex
UNION ALL SELECT id, 'D'::option_label, 'Casino gambling debt', 'Nợ cờ bạc casino', FALSE, 4 FROM mc_ex;


-- Exercise 2: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'debt-management'),
 'fill_blank', 'medium',
 'The ___ method pays off the highest interest rate debt first.',
 'Phương pháp ___ trả hết khoản nợ có lãi suất cao nhất trước.',
 'avalanche',
 'The debt avalanche method is mathematically optimal — by eliminating the highest-interest debt first, you reduce the total interest paid over time. The name comes from the idea of knocking down the steepest slope first, which reduces the overall debt burden most efficiently.',
 'Phương pháp tuyết lở là tối ưu về mặt toán học — bằng cách loại bỏ khoản nợ lãi suất cao nhất trước, bạn giảm tổng lãi phải trả theo thời gian. Tên gọi đến từ ý tưởng đánh đổ dốc dựng nhất trước, giúp giảm gánh nặng nợ tổng thể hiệu quả nhất.',
 2);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'debt-management'),
 'true_false', 'easy',
 'The debt snowball method pays off the smallest balance first for psychological wins.',
 'Phương pháp quả cầu tuyết trả hết số dư nhỏ nhất trước để có chiến thắng tâm lý.',
 'true',
 'True. The debt snowball method, popularized by financial educator Dave Ramsey, prioritizes eliminating the smallest debt balance first — regardless of interest rate. The quick wins of fully paying off individual debts build confidence and momentum, helping people stay committed to debt repayment. Research shows behavioral motivation matters significantly for actual debt payoff success.',
 'Đúng. Phương pháp quả cầu tuyết, được phổ biến bởi nhà giáo dục tài chính Dave Ramsey, ưu tiên loại bỏ số dư nợ nhỏ nhất trước — bất kể lãi suất. Những chiến thắng nhanh khi trả hết hoàn toàn từng khoản nợ riêng lẻ xây dựng sự tự tin và động lực, giúp mọi người duy trì cam kết trả nợ. Nghiên cứu cho thấy động lực hành vi quan trọng đáng kể cho thành công trả nợ thực tế.',
 3);

-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'debt-management'),
 'fill_blank', 'easy',
 'APR stands for Annual Percentage ___.',
 'APR là viết tắt của Lãi Suất Phần Trăm ___ Năm.',
 'Rate',
 'APR (Annual Percentage Rate) is the standardized way to express the yearly cost of borrowing, including both interest and fees. It allows consumers to make apples-to-apples comparisons between different loan products. Lenders are legally required to disclose APR in many countries.',
 'APR (Lãi Suất Phần Trăm Hàng Năm) là cách tiêu chuẩn hóa để biểu thị chi phí vay hàng năm, bao gồm cả lãi và phí. Nó cho phép người tiêu dùng so sánh công bằng giữa các sản phẩm vay khác nhau. Người cho vay thường bắt buộc phải tiết lộ APR theo luật ở nhiều quốc gia.',
 4);

-- Exercise 5: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'debt-management'),
 'multiple_choice', 'medium',
 'What is the most financially efficient debt payoff strategy?',
 'Chiến lược trả nợ hiệu quả nhất về mặt tài chính là gì?',
 'The debt avalanche is the most mathematically efficient strategy because it minimizes total interest paid. By targeting the highest-rate debt first, you eliminate the most costly debt as fast as possible. The snowball method costs more in interest but can be better for people who need psychological motivation.',
 'Phương pháp tuyết lở là chiến lược hiệu quả nhất về mặt toán học vì nó giảm thiểu tổng lãi phải trả. Bằng cách nhắm vào khoản nợ lãi suất cao nhất trước, bạn loại bỏ khoản nợ tốn kém nhất càng nhanh càng tốt. Phương pháp quả cầu tuyết tốn nhiều lãi hơn nhưng có thể tốt hơn cho những người cần động lực tâm lý.',
 5);

WITH mc_ex2 AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'debt-management')
  AND type = 'multiple_choice'
  AND order_index = 5
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'Debt snowball', 'Phương pháp quả cầu tuyết', FALSE, 1 FROM mc_ex2
UNION ALL SELECT id, 'B'::option_label, 'Debt avalanche', 'Phương pháp tuyết lở', TRUE, 2 FROM mc_ex2
UNION ALL SELECT id, 'C'::option_label, 'Minimum payments', 'Thanh toán tối thiểu', FALSE, 3 FROM mc_ex2
UNION ALL SELECT id, 'D'::option_label, 'Debt consolidation', 'Hợp nhất nợ', FALSE, 4 FROM mc_ex2;


-- Exercise 6: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'debt-management'),
 'true_false', 'medium',
 'High-interest debt like credit cards should generally be paid off before investing.',
 'Nợ lãi suất cao như thẻ tín dụng thường nên được trả hết trước khi đầu tư.',
 'true',
 'True. Credit card APRs typically range from 15–29%, far exceeding expected long-term investment returns (~7–10%). Paying off a 20% APR credit card is a guaranteed 20% return — better than most investments. The math is clear: eliminate high-interest debt first, then redirect those payments toward investing.',
 'Đúng. APR thẻ tín dụng thường trong khoảng 15–29%, vượt xa lợi nhuận đầu tư dài hạn dự kiến (~7–10%). Trả hết thẻ tín dụng APR 20% là lợi nhuận đảm bảo 20% — tốt hơn hầu hết các khoản đầu tư. Toán học rõ ràng: loại bỏ nợ lãi suất cao trước, sau đó chuyển hướng các khoản thanh toán đó sang đầu tư.',
 6);

-- Exercise 7: arrange_words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'debt-management'),
 'arrange_words', 'medium',
 'Arrange these words to form a correct statement about the debt avalanche method.',
 'Sắp xếp các từ này để tạo thành phát biểu đúng về phương pháp tuyết lở.',
 'The debt avalanche method saves the most money in interest payments',
 '["The", "debt", "avalanche", "method", "saves", "the", "most", "money", "in", "interest", "payments"]',
 'The debt avalanche method is mathematically optimal because it minimizes total interest paid over the life of all debts. By attacking the highest-interest debt first, you reduce the balance that generates the most expensive interest charges as quickly as possible.',
 'Phương pháp tuyết lở tối ưu về mặt toán học vì nó giảm thiểu tổng lãi phải trả trong suốt thời gian tồn tại của tất cả các khoản nợ. Bằng cách tấn công khoản nợ lãi suất cao nhất trước, bạn giảm số dư tạo ra các khoản phí lãi đắt nhất càng nhanh càng tốt.',
 7);
