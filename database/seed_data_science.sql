-- ============================================================================
-- SEED DATA: Data Science (Phase 19C)
-- Category: Data Science (ID 16, order_index 16)
-- Lessons:
--   1. Introduction to Data Science   (slug: data-science-intro)
--   2. Statistics for Data Science    (slug: statistics-for-data-science)
--   3. Machine Learning Basics        (slug: machine-learning-basics)
-- Compatible with: schema.sql v7+
-- Applied AFTER: seed_chemistry (category 15)
-- ============================================================================


-- ============================================================================
-- CATEGORY 16: Data Science
-- ============================================================================

INSERT INTO category (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('Data Science', 'Khoa Học Dữ Liệu',
 'Master the art of extracting insights from data: statistics, machine learning, visualization, and Python tools',
 'Làm chủ nghệ thuật trích xuất thông tin từ dữ liệu: thống kê, học máy, trực quan hóa và công cụ Python',
 'Analytics', '#06b6d4', 16);


-- ############################################################################
-- LESSON 1: INTRODUCTION TO DATA SCIENCE (slug: data-science-intro)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Introduction to Data Science', 'Giới Thiệu Khoa Học Dữ Liệu',
  'data-science-intro',
  'Discover what data science is, the data pipeline, and key tools',
  'Khám phá khoa học dữ liệu, quy trình dữ liệu và các công cụ chính',
  'beginner', 30, 1
FROM category WHERE name = 'Data Science';


-- ============================================================================
-- LESSON USAGES — data-science-intro
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'data-science-intro'),
 'What is Data Science?', 'Khoa Học Dữ Liệu Là Gì?',
 'Data science is an interdisciplinary field that combines statistics, computer science, and domain expertise to extract meaningful insights from structured and unstructured data. Data scientists ask questions, collect data, analyze patterns, and communicate findings to drive decisions.',
 'Khoa học dữ liệu là lĩnh vực liên ngành kết hợp thống kê, khoa học máy tính và chuyên môn lĩnh vực để trích xuất thông tin có giá trị từ dữ liệu có cấu trúc và phi cấu trúc. Nhà khoa học dữ liệu đặt câu hỏi, thu thập dữ liệu, phân tích mô hình và truyền đạt kết quả để hỗ trợ quyết định.',
 'Science', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'data-science-intro'),
 'The Data Pipeline', 'Quy Trình Dữ Liệu',
 'Every data science project follows a pipeline: collect raw data → clean and prepare it (data wrangling) → explore and visualize (EDA) → model and analyze → communicate results. Each stage builds on the previous one. Data cleaning alone typically takes 60-80% of a data scientist''s time.',
 'Mọi dự án khoa học dữ liệu đều theo một quy trình: thu thập dữ liệu thô → làm sạch và chuẩn bị (data wrangling) → khám phá và trực quan hóa (EDA) → xây dựng mô hình và phân tích → truyền đạt kết quả. Mỗi giai đoạn xây dựng trên giai đoạn trước. Làm sạch dữ liệu thường chiếm 60-80% thời gian của nhà khoa học dữ liệu.',
 'Pipeline', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'data-science-intro'),
 'Data Scientist Roles', 'Vai Trò Nhà Khoa Học Dữ Liệu',
 'Data science roles vary: Data Analysts focus on reporting and dashboards; Data Engineers build data pipelines and infrastructure; Data Scientists build predictive models; ML Engineers deploy and scale models in production. Many teams need all four roles working together.',
 'Vai trò khoa học dữ liệu rất đa dạng: Nhà Phân Tích Dữ Liệu tập trung vào báo cáo và dashboard; Kỹ Sư Dữ Liệu xây dựng pipeline và cơ sở hạ tầng dữ liệu; Nhà Khoa Học Dữ Liệu xây dựng mô hình dự đoán; Kỹ Sư ML triển khai và mở rộng mô hình trong môi trường sản xuất. Nhiều nhóm cần cả bốn vai trò cùng hoạt động.',
 'Groups', TRUE, 3);


-- ============================================================================
-- LESSON SECTIONS — data-science-intro
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

-- Section 1: markdown overview
((SELECT id FROM lesson WHERE slug = 'data-science-intro'),
 'markdown', 'What is Data Science?', 'Khoa Học Dữ Liệu Là Gì?',
'## Introduction to Data Science

Data science sits at the intersection of **three disciplines**:

| Discipline | Contribution |
|------------|-------------|
| **Statistics** | Modeling uncertainty, hypothesis testing, distributions |
| **Programming** | Automating analysis, handling large datasets, building models |
| **Domain Knowledge** | Asking the right questions, interpreting results in context |

### The Data Science Pipeline

```
Raw Data → Collect → Clean → Explore → Model → Communicate
```

1. **Data Collection** — gather from databases, APIs, files, web scraping
2. **Data Wrangling** — handle missing values, fix formats, remove duplicates
3. **Exploratory Data Analysis (EDA)** — visualize distributions, find correlations
4. **Modeling** — apply statistical or machine learning algorithms
5. **Communication** — dashboards, reports, presentations

### Key Python Libraries

| Library | Purpose |
|---------|---------|
| `pandas` | Data manipulation and analysis |
| `numpy` | Numerical computing |
| `matplotlib` / `seaborn` | Data visualization |
| `scikit-learn` | Machine learning |
| `jupyter` | Interactive notebooks |

```python
import pandas as pd

# Load a dataset
df = pd.read_csv("data.csv")
print(df.head())       # First 5 rows
print(df.describe())   # Summary statistics
```',

'## Giới Thiệu Khoa Học Dữ Liệu

Khoa học dữ liệu nằm ở giao điểm của **ba lĩnh vực**:

| Lĩnh vực | Đóng góp |
|----------|----------|
| **Thống kê** | Mô hình hóa sự không chắc chắn, kiểm định giả thuyết, phân phối |
| **Lập trình** | Tự động hóa phân tích, xử lý dữ liệu lớn, xây dựng mô hình |
| **Kiến thức lĩnh vực** | Đặt câu hỏi đúng, diễn giải kết quả trong bối cảnh |

### Quy Trình Khoa Học Dữ Liệu

```
Dữ Liệu Thô → Thu Thập → Làm Sạch → Khám Phá → Mô Hình → Truyền Đạt
```

1. **Thu Thập Dữ Liệu** — lấy từ cơ sở dữ liệu, API, file, web scraping
2. **Data Wrangling** — xử lý giá trị thiếu, sửa định dạng, loại bỏ trùng lặp
3. **Khám Phá Dữ Liệu (EDA)** — trực quan hóa phân phối, tìm tương quan
4. **Xây Dựng Mô Hình** — áp dụng thuật toán thống kê hoặc học máy
5. **Truyền Đạt** — dashboard, báo cáo, thuyết trình

### Thư Viện Python Chính

| Thư viện | Mục đích |
|---------|---------|
| `pandas` | Thao tác và phân tích dữ liệu |
| `numpy` | Tính toán số học |
| `matplotlib` / `seaborn` | Trực quan hóa dữ liệu |
| `scikit-learn` | Học máy |
| `jupyter` | Notebook tương tác |

```python
import pandas as pd

# Nạp tập dữ liệu
df = pd.read_csv("data.csv")
print(df.head())       # 5 hàng đầu
print(df.describe())   # Thống kê tóm tắt
```',
 1, '{}'),

-- Section 2: key_points
((SELECT id FROM lesson WHERE slug = 'data-science-intro'),
 'key_points', 'Key Data Science Concepts', 'Khái Niệm Khoa Học Dữ Liệu Quan Trọng',
 '- **Data Science** combines statistics, programming, and domain expertise to extract insights from data
- **Data Wrangling** is the process of cleaning and preparing raw data — it consumes up to 80% of project time
- **EDA (Exploratory Data Analysis)** comes before modeling: visualize first, then model
- **Python** is the dominant language for data science (pandas, numpy, scikit-learn, matplotlib)
- **Machine Learning** is a subset of AI that enables computers to learn patterns from data without explicit programming
- **The data pipeline**: Collect → Clean → Explore → Model → Communicate',
 '- **Khoa học dữ liệu** kết hợp thống kê, lập trình và chuyên môn lĩnh vực để trích xuất thông tin từ dữ liệu
- **Data Wrangling** là quá trình làm sạch và chuẩn bị dữ liệu thô — chiếm đến 80% thời gian dự án
- **EDA (Phân Tích Dữ Liệu Khám Phá)** đến trước khi xây dựng mô hình: trực quan hóa trước, sau đó mô hình hóa
- **Python** là ngôn ngữ chủ đạo cho khoa học dữ liệu (pandas, numpy, scikit-learn, matplotlib)
- **Học máy** là tập con của AI cho phép máy tính học các mô hình từ dữ liệu mà không cần lập trình tường minh
- **Quy trình dữ liệu**: Thu Thập → Làm Sạch → Khám Phá → Mô Hình → Truyền Đạt',
 2, '{}'),

-- Section 3: info_box about Python/R tools
((SELECT id FROM lesson WHERE slug = 'data-science-intro'),
 'info_box', 'Python vs R: Which Should You Learn?', 'Python vs R: Nên Học Ngôn Ngữ Nào?',
 'Python is the industry standard for data science and machine learning — it has a larger ecosystem, stronger deployment story, and overlaps with software engineering. R is preferred in academic research and statistics-heavy domains (bioinformatics, econometrics). For most beginners and industry roles, start with Python.',
 'Python là tiêu chuẩn công nghiệp cho khoa học dữ liệu và học máy — có hệ sinh thái lớn hơn, triển khai mạnh hơn và giao thoa với kỹ thuật phần mềm. R được ưa chuộng trong nghiên cứu học thuật và các lĩnh vực thiên về thống kê (tin sinh học, kinh tế lượng). Với hầu hết người mới bắt đầu và vai trò công nghiệp, hãy bắt đầu với Python.',
 3,
 '{"type": "tip"}'::jsonb);


-- ============================================================================
-- EXERCISES — data-science-intro (7 exercises)
-- ============================================================================

-- Exercise 1: multiple_choice — What does data science primarily combine?
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'data-science-intro'),
 'multiple_choice', 'easy',
 'What does data science primarily combine?',
 'Khoa học dữ liệu chủ yếu kết hợp những gì?',
 'Data science sits at the intersection of statistics, programming/computer science, and domain knowledge. All three components are necessary: statistics for modeling, programming for scale, and domain knowledge to ask the right questions.',
 'Khoa học dữ liệu nằm ở giao điểm của thống kê, lập trình/khoa học máy tính và kiến thức lĩnh vực. Cả ba thành phần đều cần thiết: thống kê để mô hình hóa, lập trình để xử lý quy mô lớn và kiến thức lĩnh vực để đặt câu hỏi đúng.',
 1);

WITH mc_ex AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'data-science-intro')
  AND type = 'multiple_choice'
  AND order_index = 1
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'Art and Music', 'Nghệ thuật và Âm nhạc', FALSE, 1 FROM mc_ex
UNION ALL SELECT id, 'B'::option_label, 'Statistics, Programming, and Domain Knowledge', 'Thống kê, Lập trình và Kiến thức lĩnh vực', TRUE, 2 FROM mc_ex
UNION ALL SELECT id, 'C'::option_label, 'Biology and Chemistry', 'Sinh học và Hóa học', FALSE, 3 FROM mc_ex
UNION ALL SELECT id, 'D'::option_label, 'Law and Finance', 'Luật và Tài chính', FALSE, 4 FROM mc_ex;


-- Exercise 2: true_false — Is machine learning a subset of AI?
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'data-science-intro'),
 'true_false', 'easy',
 'Machine learning is a subset of artificial intelligence.',
 'Học máy là một tập con của trí tuệ nhân tạo.',
 'true',
 'Machine learning is indeed a subset of AI. AI is the broad field of making machines simulate human intelligence. Machine learning is a specific approach within AI where systems learn from data to improve without explicit programming. Deep learning is, in turn, a subset of machine learning.',
 'Học máy đúng là tập con của AI. AI là lĩnh vực rộng về việc làm cho máy mô phỏng trí tuệ con người. Học máy là một phương pháp cụ thể trong AI nơi hệ thống học từ dữ liệu để cải thiện mà không cần lập trình tường minh. Học sâu, đến lượt nó, là tập con của học máy.',
 2);


-- Exercise 3: fill_blank — data wrangling
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'data-science-intro'),
 'fill_blank', 'easy',
 'The process of cleaning and preparing raw data for analysis is called data ___.',
 'Quá trình làm sạch và chuẩn bị dữ liệu thô để phân tích được gọi là data ___.',
 'wrangling',
 'Data wrangling (also called data munging) involves handling missing values, fixing inconsistent formats, removing duplicates, and transforming data into a usable structure. It typically consumes 60-80% of a data scientist''s project time.',
 'Data wrangling (còn gọi là data munging) bao gồm xử lý giá trị thiếu, sửa định dạng không nhất quán, loại bỏ trùng lặp và biến đổi dữ liệu thành cấu trúc có thể sử dụng. Thường chiếm 60-80% thời gian dự án của nhà khoa học dữ liệu.',
 3);


-- Exercise 4: multiple_choice — popular Python library for data analysis
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'data-science-intro'),
 'multiple_choice', 'easy',
 'Which of the following is a popular Python library used for data analysis and manipulation?',
 'Thư viện Python nào sau đây phổ biến được dùng để phân tích và thao tác dữ liệu?',
 'Pandas is the primary Python library for data analysis. It provides DataFrame and Series structures for handling tabular data, with powerful tools for filtering, grouping, joining, and reshaping. Django, Flask, and FastAPI are web frameworks, not data tools.',
 'Pandas là thư viện Python chính cho phân tích dữ liệu. Nó cung cấp cấu trúc DataFrame và Series để xử lý dữ liệu dạng bảng, với công cụ mạnh mẽ để lọc, nhóm, kết hợp và định hình lại dữ liệu. Django, Flask và FastAPI là web framework, không phải công cụ dữ liệu.',
 4);

WITH mc_ex2 AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'data-science-intro')
  AND type = 'multiple_choice'
  AND order_index = 4
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'Django', 'Django', FALSE, 1 FROM mc_ex2
UNION ALL SELECT id, 'B'::option_label, 'Flask', 'Flask', FALSE, 2 FROM mc_ex2
UNION ALL SELECT id, 'C'::option_label, 'Pandas', 'Pandas', TRUE, 3 FROM mc_ex2
UNION ALL SELECT id, 'D'::option_label, 'FastAPI', 'FastAPI', FALSE, 4 FROM mc_ex2;


-- Exercise 5: true_false — EDA before model building
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'data-science-intro'),
 'true_false', 'easy',
 'Exploratory Data Analysis (EDA) should be performed before building predictive models.',
 'Phân Tích Dữ Liệu Khám Phá (EDA) nên được thực hiện trước khi xây dựng mô hình dự đoán.',
 'true',
 'EDA always comes before modeling. During EDA you visualize distributions, detect outliers, understand correlations, and check for missing data. This informs which model to choose and how to preprocess features. Jumping to modeling without EDA leads to poor model choices and wasted compute.',
 'EDA luôn đến trước khi xây dựng mô hình. Trong EDA bạn trực quan hóa phân phối, phát hiện ngoại lệ, hiểu tương quan và kiểm tra dữ liệu thiếu. Điều này cho biết nên chọn mô hình nào và cách tiền xử lý đặc trưng. Nhảy thẳng vào xây dựng mô hình mà không có EDA dẫn đến lựa chọn mô hình kém và lãng phí tài nguyên tính toán.',
 5);


-- Exercise 6: fill_blank — histogram
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'data-science-intro'),
 'fill_blank', 'easy',
 'A ___ is a visual representation of the distribution of a numerical dataset, showing how data is spread across different value ranges.',
 'Một ___ là biểu diễn trực quan về phân phối của tập dữ liệu số, cho thấy dữ liệu trải rộng như thế nào qua các khoảng giá trị khác nhau.',
 'histogram',
 'A histogram divides data into bins (intervals) and counts how many values fall into each bin. It reveals the shape of the distribution: symmetric, skewed left/right, bimodal, etc. It is one of the first plots to create during EDA.',
 'Histogram chia dữ liệu thành các bin (khoảng) và đếm bao nhiêu giá trị rơi vào mỗi bin. Nó cho thấy hình dạng phân phối: đối xứng, lệch trái/phải, hai đỉnh, v.v. Đây là một trong những biểu đồ đầu tiên nên tạo trong EDA.',
 6);


-- Exercise 7: error_correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'data-science-intro'),
 'error_correction', 'medium',
 'Fix the errors in this sentence: "Data scientist use statistic to finding pattern in datas."',
 'Sửa các lỗi trong câu này: "Data scientist use statistic to finding pattern in datas."',
 'Data scientists use statistics to find patterns in data.',
 'Four errors: (1) "Data scientist" → "Data scientists" (plural subject). (2) "statistic" → "statistics" (uncountable noun used as field name). (3) "to finding" → "to find" (infinitive after "to"). (4) "datas" → "data" ("data" is already plural; "datas" is not a word).',
 'Bốn lỗi: (1) "Data scientist" → "Data scientists" (chủ ngữ số nhiều). (2) "statistic" → "statistics" (danh từ không đếm được dùng như tên lĩnh vực). (3) "to finding" → "to find" (động từ nguyên mẫu sau "to"). (4) "datas" → "data" ("data" đã là số nhiều; "datas" không phải từ).',
 7);


-- ############################################################################
-- LESSON 2: STATISTICS FOR DATA SCIENCE (slug: statistics-for-data-science)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Statistics for Data Science', 'Thống Kê Cho Khoa Học Dữ Liệu',
  'statistics-for-data-science',
  'Master mean, median, standard deviation, and probability distributions',
  'Nắm vững trung bình, trung vị, độ lệch chuẩn và phân phối xác suất',
  'intermediate', 40, 2
FROM category WHERE name = 'Data Science';


-- ============================================================================
-- LESSON USAGES — statistics-for-data-science
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'statistics-for-data-science'),
 'Mean, Median, and Mode', 'Trung Bình, Trung Vị và Mode',
 'The three measures of central tendency describe where the "center" of a dataset lies. Mean is the arithmetic average. Median is the middle value when sorted. Mode is the most frequent value. Each tells a different story: median is robust to outliers while mean is sensitive to them.',
 'Ba thước đo xu hướng trung tâm mô tả vị trí "tâm" của tập dữ liệu. Trung bình là trung bình cộng. Trung vị là giá trị ở giữa khi sắp xếp. Mode là giá trị xuất hiện thường xuyên nhất. Mỗi thước đo kể một câu chuyện khác: trung vị không bị ảnh hưởng bởi ngoại lệ trong khi trung bình rất nhạy cảm với chúng.',
 'Calculate', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'statistics-for-data-science'),
 'Standard Deviation', 'Độ Lệch Chuẩn',
 'Standard deviation measures how spread out values are from the mean. A small standard deviation means data points are clustered near the mean; a large one means they are scattered widely. It is the square root of variance. Formula: σ = √(Σ(xᵢ − μ)² / N).',
 'Độ lệch chuẩn đo mức độ phân tán của các giá trị so với trung bình. Độ lệch chuẩn nhỏ nghĩa là các điểm dữ liệu tập trung gần trung bình; độ lệch chuẩn lớn nghĩa là chúng phân tán rộng. Nó là căn bậc hai của phương sai. Công thức: σ = √(Σ(xᵢ − μ)² / N).',
 'BarChart', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'statistics-for-data-science'),
 'Normal Distribution', 'Phân Phối Chuẩn',
 'The normal (Gaussian) distribution is the most important probability distribution in statistics. It is bell-shaped and symmetric around the mean. The 68-95-99.7 rule states that 68% of data falls within 1 standard deviation of the mean, 95% within 2, and 99.7% within 3. Many natural phenomena follow this pattern.',
 'Phân phối chuẩn (Gaussian) là phân phối xác suất quan trọng nhất trong thống kê. Nó có hình chuông và đối xứng quanh trung bình. Quy tắc 68-95-99,7 nói rằng 68% dữ liệu nằm trong 1 độ lệch chuẩn so với trung bình, 95% trong 2 và 99,7% trong 3. Nhiều hiện tượng tự nhiên tuân theo mô hình này.',
 'Timeline', TRUE, 3);


-- ============================================================================
-- LESSON SECTIONS — statistics-for-data-science
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

-- Section 1: markdown with formulas
((SELECT id FROM lesson WHERE slug = 'statistics-for-data-science'),
 'markdown', 'Core Statistical Concepts', 'Các Khái Niệm Thống Kê Cốt Lõi',
'## Statistics for Data Science

Statistics provides the mathematical foundation for understanding data and drawing valid conclusions.

### Measures of Central Tendency

Given dataset: **{2, 4, 4, 4, 5, 5, 7, 9}** (n = 8)

| Measure | Formula | Value |
|---------|---------|-------|
| **Mean (μ)** | $\mu = \frac{\sum x_i}{n}$ | (2+4+4+4+5+5+7+9)/8 = **5** |
| **Median** | Middle value when sorted | (4+5)/2 = **4.5** |
| **Mode** | Most frequent value | **4** (appears 3 times) |

### Measures of Spread

**Variance (σ²):** Average squared deviation from the mean
$$\sigma^2 = \frac{\sum (x_i - \mu)^2}{N}$$

**Standard Deviation (σ):** Square root of variance — in the same units as the data
$$\sigma = \sqrt{\frac{\sum (x_i - \mu)^2}{N}}$$

### The Normal Distribution

The bell curve is defined by two parameters: mean (μ) and standard deviation (σ).

**68-95-99.7 Rule:**
- 68% of data falls within **±1σ** of the mean
- 95% of data falls within **±2σ** of the mean
- 99.7% of data falls within **±3σ** of the mean

### Correlation

Correlation coefficient **r** measures the linear relationship between two variables:
- r = +1: perfect positive correlation
- r = 0: no linear correlation
- r = −1: perfect negative correlation

> **Remember:** Correlation ≠ Causation',

'## Thống Kê Cho Khoa Học Dữ Liệu

Thống kê cung cấp nền tảng toán học để hiểu dữ liệu và rút ra kết luận hợp lệ.

### Thước Đo Xu Hướng Trung Tâm

Tập dữ liệu cho trước: **{2, 4, 4, 4, 5, 5, 7, 9}** (n = 8)

| Thước đo | Công thức | Giá trị |
|----------|-----------|---------|
| **Trung bình (μ)** | $\mu = \frac{\sum x_i}{n}$ | (2+4+4+4+5+5+7+9)/8 = **5** |
| **Trung vị** | Giá trị giữa khi sắp xếp | (4+5)/2 = **4,5** |
| **Mode** | Giá trị xuất hiện nhiều nhất | **4** (xuất hiện 3 lần) |

### Thước Đo Độ Phân Tán

**Phương sai (σ²):** Trung bình bình phương độ lệch so với trung bình
$$\sigma^2 = \frac{\sum (x_i - \mu)^2}{N}$$

**Độ lệch chuẩn (σ):** Căn bậc hai của phương sai — cùng đơn vị với dữ liệu
$$\sigma = \sqrt{\frac{\sum (x_i - \mu)^2}{N}}$$

### Phân Phối Chuẩn

Đường cong chuông được xác định bởi hai tham số: trung bình (μ) và độ lệch chuẩn (σ).

**Quy tắc 68-95-99,7:**
- 68% dữ liệu nằm trong **±1σ** của trung bình
- 95% dữ liệu nằm trong **±2σ** của trung bình
- 99,7% dữ liệu nằm trong **±3σ** của trung bình

### Tương Quan

Hệ số tương quan **r** đo mối quan hệ tuyến tính giữa hai biến:
- r = +1: tương quan dương hoàn hảo
- r = 0: không có tương quan tuyến tính
- r = −1: tương quan âm hoàn hảo

> **Nhớ:** Tương quan ≠ Nhân quả',
 1, '{}'),

-- Section 2: key_points
((SELECT id FROM lesson WHERE slug = 'statistics-for-data-science'),
 'key_points', 'Key Statistical Principles', 'Nguyên Tắc Thống Kê Quan Trọng',
 '- **Mean** is sensitive to outliers; a single extreme value can pull it far from the center
- **Median** is resistant to outliers — always use median for skewed distributions (income, house prices)
- **Standard deviation** = 0 means all values are identical; larger σ = more spread
- **Normal distribution** (bell curve): 68% within ±1σ, 95% within ±2σ, 99.7% within ±3σ
- **Correlation coefficient r** ranges from −1 to +1; close to 0 means weak or no linear relationship
- **Correlation ≠ Causation**: two variables can be correlated without one causing the other',
 '- **Trung bình** nhạy cảm với ngoại lệ; một giá trị cực đoan có thể kéo nó xa khỏi tâm
- **Trung vị** không bị ảnh hưởng bởi ngoại lệ — luôn dùng trung vị cho phân phối lệch (thu nhập, giá nhà)
- **Độ lệch chuẩn** = 0 nghĩa là tất cả giá trị đều giống nhau; σ lớn hơn = phân tán nhiều hơn
- **Phân phối chuẩn** (đường cong chuông): 68% trong ±1σ, 95% trong ±2σ, 99,7% trong ±3σ
- **Hệ số tương quan r** dao động từ −1 đến +1; gần 0 nghĩa là quan hệ tuyến tính yếu hoặc không có
- **Tương quan ≠ Nhân quả**: hai biến có thể tương quan mà không phải biến này gây ra biến kia',
 2, '{}'),

-- Section 3: chart (bar chart — normal distribution approximation)
((SELECT id FROM lesson WHERE slug = 'statistics-for-data-science'),
 'chart', 'Normal Distribution: 68-95-99.7 Rule', 'Phân Phối Chuẩn: Quy Tắc 68-95-99.7',
 'This bar chart shows approximately how data is distributed in a normal distribution around the mean (μ). The tallest bars are near the mean; data thins out as you move further away.',
 'Biểu đồ cột này cho thấy gần đúng cách phân phối dữ liệu trong phân phối chuẩn quanh trung bình (μ). Các cột cao nhất ở gần trung bình; dữ liệu mỏng dần khi di chuyển xa hơn.',
 3,
 '{"chartType":"bar","xKey":"range","series":[{"dataKey":"percent","name":"Tỷ lệ dữ liệu (%)","nameVi":"Tỷ lệ dữ liệu (%)"}],"data":[{"range":"μ−3σ","percent":0.1},{"range":"μ−2σ","percent":2.1},{"range":"μ−1σ","percent":13.6},{"range":"μ","percent":34.1},{"range":"μ+1σ","percent":34.1},{"range":"μ+2σ","percent":13.6},{"range":"μ+3σ","percent":2.1}],"colors":["#06b6d4"]}'::jsonb);


-- ============================================================================
-- EXERCISES — statistics-for-data-science (7 exercises)
-- ============================================================================

-- Exercise 1: fill_blank — mean
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'statistics-for-data-science'),
 'fill_blank', 'easy',
 'The arithmetic average of a dataset — calculated by summing all values and dividing by the count — is called the ___.',
 'Trung bình cộng của tập dữ liệu — tính bằng cách cộng tất cả giá trị rồi chia cho số lượng — được gọi là ___.',
 'mean',
 'The mean (μ) = Σxᵢ / n. It is the most common measure of central tendency but is sensitive to outliers. For the dataset {1, 2, 3, 4, 100}, the mean is 22 — which does not represent the typical value well.',
 'Trung bình (μ) = Σxᵢ / n. Đây là thước đo xu hướng trung tâm phổ biến nhất nhưng nhạy cảm với ngoại lệ. Với tập dữ liệu {1, 2, 3, 4, 100}, trung bình là 22 — không đại diện tốt cho giá trị điển hình.',
 1);


-- Exercise 2: multiple_choice — what standard deviation measures
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'statistics-for-data-science'),
 'multiple_choice', 'easy',
 'What does standard deviation measure in a dataset?',
 'Độ lệch chuẩn đo lường điều gì trong tập dữ liệu?',
 'Standard deviation measures how spread out (dispersed) the data values are around the mean. A low σ means values are clustered tightly around the mean; a high σ means they are spread widely. It is NOT the average value, count of points, or the median.',
 'Độ lệch chuẩn đo mức độ phân tán của các giá trị dữ liệu quanh trung bình. σ thấp nghĩa là giá trị tập trung chặt quanh trung bình; σ cao nghĩa là chúng phân tán rộng. Nó KHÔNG PHẢI giá trị trung bình, số điểm dữ liệu hay trung vị.',
 2);

WITH mc_ex3 AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'statistics-for-data-science')
  AND type = 'multiple_choice'
  AND order_index = 2
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'The average value of the dataset', 'Giá trị trung bình của tập dữ liệu', FALSE, 1 FROM mc_ex3
UNION ALL SELECT id, 'B'::option_label, 'The spread/variability of data around the mean', 'Độ phân tán/biến thiên của dữ liệu quanh trung bình', TRUE, 2 FROM mc_ex3
UNION ALL SELECT id, 'C'::option_label, 'The total number of data points', 'Tổng số điểm dữ liệu', FALSE, 3 FROM mc_ex3
UNION ALL SELECT id, 'D'::option_label, 'The median of the dataset', 'Trung vị của tập dữ liệu', FALSE, 4 FROM mc_ex3;


-- Exercise 3: true_false — median resistant to outliers
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'statistics-for-data-science'),
 'true_false', 'easy',
 'The median is resistant to outliers, making it a better measure of central tendency for skewed distributions.',
 'Trung vị không bị ảnh hưởng bởi ngoại lệ, khiến nó là thước đo xu hướng trung tâm tốt hơn cho các phân phối lệch.',
 'true',
 'The median is the middle value after sorting, so extreme outliers do not affect it. For example, in {1, 2, 3, 4, 100}, the median is 3 (representative), while the mean is 22 (misleading). This is why economists report median household income rather than mean income.',
 'Trung vị là giá trị giữa sau khi sắp xếp, nên các ngoại lệ cực đoan không ảnh hưởng đến nó. Ví dụ, trong {1, 2, 3, 4, 100}, trung vị là 3 (đại diện), trong khi trung bình là 22 (gây hiểu lầm). Đây là lý do các nhà kinh tế báo cáo thu nhập hộ gia đình trung vị thay vì trung bình.',
 3);


-- Exercise 4: fill_blank — 68-95-99.7 rule
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'statistics-for-data-science'),
 'fill_blank', 'medium',
 'In a normal distribution, approximately ___% of data falls within 1 standard deviation of the mean.',
 'Trong phân phối chuẩn, khoảng ___% dữ liệu nằm trong 1 độ lệch chuẩn so với trung bình.',
 '68',
 'The 68-95-99.7 empirical rule: 68% of data falls within ±1σ, 95% within ±2σ, and 99.7% within ±3σ of the mean. This rule only applies to normally distributed data. It is widely used in quality control, finance, and natural sciences.',
 'Quy tắc kinh nghiệm 68-95-99,7: 68% dữ liệu nằm trong ±1σ, 95% trong ±2σ và 99,7% trong ±3σ của trung bình. Quy tắc này chỉ áp dụng cho dữ liệu phân phối chuẩn. Nó được sử dụng rộng rãi trong kiểm soát chất lượng, tài chính và khoa học tự nhiên.',
 4);


-- Exercise 5: multiple_choice — measure most affected by outliers
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'statistics-for-data-science'),
 'multiple_choice', 'medium',
 'Which measure of central tendency is most affected by extreme outliers?',
 'Thước đo xu hướng trung tâm nào bị ảnh hưởng nhiều nhất bởi các ngoại lệ cực đoan?',
 'The mean is most affected by outliers because it uses the actual numeric value of every data point in its calculation. A single very large or very small value shifts the mean significantly. Median and mode are resistant to outliers; range is a measure of spread, not central tendency.',
 'Trung bình bị ảnh hưởng nhiều nhất bởi ngoại lệ vì nó sử dụng giá trị số thực tế của mọi điểm dữ liệu trong tính toán. Một giá trị rất lớn hoặc rất nhỏ sẽ dịch chuyển trung bình đáng kể. Trung vị và mode không bị ảnh hưởng bởi ngoại lệ; khoảng biến thiên là thước đo độ phân tán, không phải xu hướng trung tâm.',
 5);

WITH mc_ex4 AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'statistics-for-data-science')
  AND type = 'multiple_choice'
  AND order_index = 5
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'Median', 'Trung vị', FALSE, 1 FROM mc_ex4
UNION ALL SELECT id, 'B'::option_label, 'Mode', 'Mode', FALSE, 2 FROM mc_ex4
UNION ALL SELECT id, 'C'::option_label, 'Mean', 'Trung bình', TRUE, 3 FROM mc_ex4
UNION ALL SELECT id, 'D'::option_label, 'Range', 'Khoảng biến thiên', FALSE, 4 FROM mc_ex4;


-- Exercise 6: sentence_transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'statistics-for-data-science'),
 'sentence_transform', 'medium',
 'Transform this sentence to include the approximate standard deviation value: "The standard deviation of 2, 4, 6, 8 tells us about variability."',
 'Biến đổi câu này để bao gồm giá trị độ lệch chuẩn xấp xỉ: "The standard deviation of 2, 4, 6, 8 tells us about variability."',
 'The standard deviation of 2, 4, 6, 8 is approximately 2.58, indicating moderate variability.',
 'For {2, 4, 6, 8}: mean = 5. Deviations: (2-5)²=9, (4-5)²=1, (6-5)²=1, (8-5)²=9. Variance = (9+1+1+9)/4 = 5. Standard deviation = √5 ≈ 2.24 (population) or ≈ 2.58 (sample, dividing by n-1). The sample standard deviation 2.58 is commonly used in data science.',
 'Với {2, 4, 6, 8}: trung bình = 5. Độ lệch: (2-5)²=9, (4-5)²=1, (6-5)²=1, (8-5)²=9. Phương sai = (9+1+1+9)/4 = 5. Độ lệch chuẩn = √5 ≈ 2,24 (tổng thể) hoặc ≈ 2,58 (mẫu, chia cho n-1). Độ lệch chuẩn mẫu 2,58 thường được dùng trong khoa học dữ liệu.',
 6);


-- Exercise 7: true_false — perfect negative correlation
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'statistics-for-data-science'),
 'true_false', 'medium',
 'A correlation coefficient of -1 indicates a perfect negative correlation between two variables.',
 'Hệ số tương quan bằng -1 cho thấy tương quan âm hoàn hảo giữa hai biến.',
 'true',
 'The Pearson correlation coefficient r ranges from -1 to +1. r = -1 means a perfect negative linear relationship: as one variable increases, the other decreases proportionally every time. r = +1 is perfect positive. r = 0 means no linear relationship. Values between these indicate varying strengths of correlation.',
 'Hệ số tương quan Pearson r dao động từ -1 đến +1. r = -1 nghĩa là quan hệ tuyến tính âm hoàn hảo: khi một biến tăng, biến kia giảm tỉ lệ mỗi lần. r = +1 là tương quan dương hoàn hảo. r = 0 nghĩa là không có quan hệ tuyến tính. Các giá trị ở giữa biểu thị độ mạnh tương quan khác nhau.',
 7);


-- ############################################################################
-- LESSON 3: MACHINE LEARNING BASICS (slug: machine-learning-basics)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Machine Learning Basics', 'Cơ Bản Học Máy',
  'machine-learning-basics',
  'Understand supervised vs unsupervised learning, features, and model training',
  'Hiểu học có giám sát vs không giám sát, đặc trưng và huấn luyện mô hình',
  'intermediate', 45, 3
FROM category WHERE name = 'Data Science';


-- ============================================================================
-- LESSON USAGES — machine-learning-basics
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'machine-learning-basics'),
 'Supervised Learning', 'Học Có Giám Sát',
 'In supervised learning, the model trains on labeled data — each input example is paired with its correct output (label). The model learns to map inputs to outputs and then predicts labels for new, unseen data. Examples: email spam detection (spam/not spam), house price prediction.',
 'Trong học có giám sát, mô hình huấn luyện trên dữ liệu có nhãn — mỗi ví dụ đầu vào được ghép với đầu ra đúng (nhãn). Mô hình học cách ánh xạ đầu vào sang đầu ra rồi dự đoán nhãn cho dữ liệu mới chưa thấy. Ví dụ: phát hiện email spam (spam/không spam), dự đoán giá nhà.',
 'School', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'machine-learning-basics'),
 'Unsupervised Learning', 'Học Không Giám Sát',
 'Unsupervised learning finds hidden patterns in data without any labels. The algorithm discovers structure on its own. Clustering (k-means) groups similar data points together. Dimensionality reduction (PCA) compresses data while preserving patterns. Useful for customer segmentation, anomaly detection.',
 'Học không giám sát tìm các mô hình ẩn trong dữ liệu mà không có nhãn nào. Thuật toán tự khám phá cấu trúc. Phân cụm (k-means) nhóm các điểm dữ liệu tương tự lại với nhau. Giảm chiều (PCA) nén dữ liệu trong khi bảo toàn mô hình. Hữu ích cho phân khúc khách hàng, phát hiện bất thường.',
 'BubbleChart', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'machine-learning-basics'),
 'Model Evaluation', 'Đánh Giá Mô Hình',
 'A model must be evaluated on data it has NOT seen during training (test set). Common metrics: accuracy (classification), mean squared error / MSE (regression), precision and recall (imbalanced classes). Overfitting occurs when a model memorizes training data but fails on new data — prevented by cross-validation and regularization.',
 'Mô hình phải được đánh giá trên dữ liệu mà nó CHƯA thấy trong quá trình huấn luyện (tập kiểm tra). Các chỉ số phổ biến: độ chính xác (phân loại), sai số bình phương trung bình / MSE (hồi quy), precision và recall (lớp mất cân bằng). Overfitting xảy ra khi mô hình ghi nhớ dữ liệu huấn luyện nhưng thất bại với dữ liệu mới — được ngăn ngừa bằng cross-validation và regularization.',
 'Assessment', TRUE, 3);


-- ============================================================================
-- LESSON SECTIONS — machine-learning-basics
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

-- Section 1: markdown overview
((SELECT id FROM lesson WHERE slug = 'machine-learning-basics'),
 'markdown', 'Machine Learning Fundamentals', 'Nền Tảng Học Máy',
'## Machine Learning Basics

Machine learning (ML) is a subset of AI that enables systems to **learn from data** and improve their performance without being explicitly programmed for every task.

### Types of Machine Learning

| Type | Training Data | Goal | Examples |
|------|--------------|------|---------|
| **Supervised** | Labeled (input + correct output) | Predict labels for new inputs | Spam detection, house prices |
| **Unsupervised** | Unlabeled | Find hidden patterns/groups | Customer clustering, anomaly detection |
| **Reinforcement** | Rewards/penalties | Maximize cumulative reward | Game AI, robotics |

### The ML Workflow

```
Data → Features → Train → Evaluate → Deploy
```

1. **Features** — the input variables used to make predictions (e.g., house size, location)
2. **Training** — the model adjusts its parameters to minimize prediction error on training data
3. **Evaluation** — test the model on unseen data to measure real-world performance
4. **Overfitting** — when a model learns training data too well and fails to generalize

### Key Algorithms

| Task | Algorithm |
|------|-----------|
| Classification | Logistic Regression, Decision Tree, Random Forest, SVM |
| Regression | Linear Regression, Ridge, Lasso |
| Clustering | K-Means, DBSCAN |
| Dimensionality Reduction | PCA, t-SNE |

```python
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
model = LinearRegression()
model.fit(X_train, y_train)
score = model.score(X_test, y_test)
```',

'## Nền Tảng Học Máy

Học máy (ML) là tập con của AI cho phép hệ thống **học từ dữ liệu** và cải thiện hiệu suất mà không cần lập trình tường minh cho mọi tác vụ.

### Các Loại Học Máy

| Loại | Dữ liệu huấn luyện | Mục tiêu | Ví dụ |
|------|-------------------|---------|-------|
| **Có giám sát** | Có nhãn (đầu vào + đầu ra đúng) | Dự đoán nhãn cho đầu vào mới | Phát hiện spam, giá nhà |
| **Không giám sát** | Không có nhãn | Tìm mô hình/nhóm ẩn | Phân cụm khách hàng, phát hiện bất thường |
| **Học tăng cường** | Phần thưởng/hình phạt | Tối đa hóa phần thưởng tích lũy | AI trò chơi, robot |

### Quy Trình ML

```
Dữ liệu → Đặc trưng → Huấn luyện → Đánh giá → Triển khai
```

1. **Đặc trưng (Features)** — các biến đầu vào dùng để dự đoán (vd: diện tích nhà, vị trí)
2. **Huấn luyện** — mô hình điều chỉnh tham số để giảm thiểu sai số dự đoán trên dữ liệu huấn luyện
3. **Đánh giá** — kiểm tra mô hình trên dữ liệu chưa thấy để đo hiệu suất thực tế
4. **Overfitting** — khi mô hình học quá tốt dữ liệu huấn luyện và thất bại khi tổng quát hóa

### Thuật Toán Chính

| Tác vụ | Thuật toán |
|--------|-----------|
| Phân loại | Logistic Regression, Decision Tree, Random Forest, SVM |
| Hồi quy | Linear Regression, Ridge, Lasso |
| Phân cụm | K-Means, DBSCAN |
| Giảm chiều | PCA, t-SNE |

```python
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
model = LinearRegression()
model.fit(X_train, y_train)
score = model.score(X_test, y_test)
```',
 1, '{}'),

-- Section 2: info_box about overfitting
((SELECT id FROM lesson WHERE slug = 'machine-learning-basics'),
 'info_box', 'Overfitting: The #1 Pitfall in Machine Learning', 'Overfitting: Bẫy Số 1 Trong Học Máy',
 'Overfitting occurs when a model learns the training data so thoroughly — including its noise and random quirks — that it performs poorly on new, unseen data. Signs: training accuracy is very high, but test accuracy is much lower. Solutions: use more training data, apply regularization (L1/L2), use cross-validation, or simplify the model.',
 'Overfitting xảy ra khi mô hình học dữ liệu huấn luyện quá kỹ — kể cả nhiễu và các đặc điểm ngẫu nhiên — đến mức hoạt động kém trên dữ liệu mới chưa thấy. Dấu hiệu: độ chính xác huấn luyện rất cao nhưng độ chính xác kiểm tra thấp hơn nhiều. Giải pháp: dùng nhiều dữ liệu huấn luyện hơn, áp dụng regularization (L1/L2), dùng cross-validation hoặc đơn giản hóa mô hình.',
 2,
 '{"type": "warning"}'::jsonb),

-- Section 3: key_points
((SELECT id FROM lesson WHERE slug = 'machine-learning-basics'),
 'key_points', 'Key Machine Learning Concepts', 'Khái Niệm Học Máy Quan Trọng',
 '- **Supervised Learning** uses labeled data (input → output pairs) to learn a mapping for prediction
- **Unsupervised Learning** finds hidden structure (clusters, patterns) in unlabeled data
- **Features** are the input variables; **labels** are the target outputs in supervised learning
- **Training set** vs **Test set**: always evaluate on data the model has NOT seen during training
- **Overfitting**: model memorizes training data but fails to generalize — test accuracy drops significantly vs training accuracy
- **MSE (Mean Squared Error)**: the average of squared prediction errors; lower is better for regression tasks',
 '- **Học có giám sát** dùng dữ liệu có nhãn (cặp đầu vào → đầu ra) để học ánh xạ cho dự đoán
- **Học không giám sát** tìm cấu trúc ẩn (cụm, mô hình) trong dữ liệu không có nhãn
- **Đặc trưng (Features)** là các biến đầu vào; **nhãn (labels)** là đầu ra mục tiêu trong học có giám sát
- **Tập huấn luyện** vs **Tập kiểm tra**: luôn đánh giá trên dữ liệu mô hình CHƯA thấy trong quá trình huấn luyện
- **Overfitting**: mô hình ghi nhớ dữ liệu huấn luyện nhưng không tổng quát hóa được — độ chính xác kiểm tra giảm đáng kể so với độ chính xác huấn luyện
- **MSE (Sai Số Bình Phương Trung Bình)**: trung bình của bình phương sai số dự đoán; giá trị càng thấp càng tốt cho tác vụ hồi quy',
 3, '{}');


-- ============================================================================
-- EXERCISES — machine-learning-basics (7 exercises)
-- ============================================================================

-- Exercise 1: multiple_choice — supervised learning
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'machine-learning-basics'),
 'multiple_choice', 'easy',
 'Which type of machine learning uses labeled training data to learn a mapping from inputs to outputs?',
 'Loại học máy nào sử dụng dữ liệu huấn luyện có nhãn để học ánh xạ từ đầu vào sang đầu ra?',
 'Supervised learning requires labeled data — each training example has both an input and a correct output label. The model learns to predict outputs from inputs. Unsupervised learning has no labels. Reinforcement learning learns through rewards/penalties. Transfer learning reuses a pre-trained model.',
 'Học có giám sát yêu cầu dữ liệu có nhãn — mỗi ví dụ huấn luyện có cả đầu vào và nhãn đầu ra đúng. Mô hình học dự đoán đầu ra từ đầu vào. Học không giám sát không có nhãn. Học tăng cường học qua phần thưởng/hình phạt. Transfer learning tái sử dụng mô hình đã huấn luyện trước.',
 1);

WITH mc_ex5 AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'machine-learning-basics')
  AND type = 'multiple_choice'
  AND order_index = 1
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'Unsupervised Learning', 'Học Không Giám Sát', FALSE, 1 FROM mc_ex5
UNION ALL SELECT id, 'B'::option_label, 'Supervised Learning', 'Học Có Giám Sát', TRUE, 2 FROM mc_ex5
UNION ALL SELECT id, 'C'::option_label, 'Reinforcement Learning', 'Học Tăng Cường', FALSE, 3 FROM mc_ex5
UNION ALL SELECT id, 'D'::option_label, 'Transfer Learning', 'Transfer Learning', FALSE, 4 FROM mc_ex5;


-- Exercise 2: fill_blank — features
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'machine-learning-basics'),
 'fill_blank', 'easy',
 'In machine learning, the input variables used to make predictions are called ___.',
 'Trong học máy, các biến đầu vào được dùng để đưa ra dự đoán được gọi là ___.',
 'features',
 'Features (also called attributes or independent variables) are the measurable properties of the data used as inputs to the model. For example, in a house price model: square footage, number of bedrooms, location, and age are all features. The output being predicted is called the label or target.',
 'Đặc trưng (còn gọi là thuộc tính hay biến độc lập) là các thuộc tính có thể đo lường của dữ liệu được dùng làm đầu vào cho mô hình. Ví dụ, trong mô hình giá nhà: diện tích, số phòng ngủ, vị trí và tuổi nhà đều là đặc trưng. Đầu ra được dự đoán được gọi là nhãn hoặc mục tiêu.',
 2);


-- Exercise 3: true_false — overfitting
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'machine-learning-basics'),
 'true_false', 'easy',
 'Overfitting occurs when a model performs well on training data but poorly on new, unseen data.',
 'Overfitting xảy ra khi mô hình hoạt động tốt trên dữ liệu huấn luyện nhưng kém trên dữ liệu mới chưa thấy.',
 'true',
 'Overfitting is when the model has memorized the training data — including its noise — rather than learning generalizable patterns. High training accuracy + low test accuracy is the signature of overfitting. Solutions include cross-validation, regularization, dropout (neural nets), and using more training data.',
 'Overfitting là khi mô hình đã ghi nhớ dữ liệu huấn luyện — kể cả nhiễu — thay vì học các mô hình có thể tổng quát hóa. Độ chính xác huấn luyện cao + độ chính xác kiểm tra thấp là dấu hiệu đặc trưng của overfitting. Giải pháp bao gồm cross-validation, regularization, dropout (mạng nơ-ron) và sử dụng nhiều dữ liệu huấn luyện hơn.',
 3);


-- Exercise 4: multiple_choice — clustering example
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'machine-learning-basics'),
 'multiple_choice', 'medium',
 'Grouping customers into segments based on their purchasing behavior, without pre-defined categories, is an example of which type of machine learning?',
 'Nhóm khách hàng thành các phân khúc dựa trên hành vi mua hàng của họ, mà không có danh mục xác định trước, là ví dụ về loại học máy nào?',
 'Customer segmentation by purchasing behavior is clustering — an unsupervised learning technique. There are no pre-defined labels. The algorithm (e.g., k-means) discovers natural groupings in the data on its own. Supervised learning requires labeled examples for each category.',
 'Phân khúc khách hàng theo hành vi mua hàng là phân cụm — một kỹ thuật học không giám sát. Không có nhãn xác định trước. Thuật toán (vd: k-means) tự khám phá các nhóm tự nhiên trong dữ liệu. Học có giám sát yêu cầu các ví dụ có nhãn cho mỗi danh mục.',
 4);

WITH mc_ex6 AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'machine-learning-basics')
  AND type = 'multiple_choice'
  AND order_index = 4
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'Supervised Learning', 'Học Có Giám Sát', FALSE, 1 FROM mc_ex6
UNION ALL SELECT id, 'B'::option_label, 'Unsupervised Learning', 'Học Không Giám Sát', TRUE, 2 FROM mc_ex6
UNION ALL SELECT id, 'C'::option_label, 'Reinforcement Learning', 'Học Tăng Cường', FALSE, 3 FROM mc_ex6
UNION ALL SELECT id, 'D'::option_label, 'Deep Learning', 'Học Sâu', FALSE, 4 FROM mc_ex6;


-- Exercise 5: fill_blank — MSE
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'machine-learning-basics'),
 'fill_blank', 'medium',
 'The evaluation metric that measures the average squared difference between predicted and actual values in a regression model is called ___ (write the full name).',
 'Chỉ số đánh giá đo trung bình bình phương sai số giữa giá trị dự đoán và giá trị thực trong mô hình hồi quy được gọi là ___ (viết tên đầy đủ).',
 'mean squared error',
 'Mean Squared Error (MSE) = (1/n) × Σ(yᵢ − ŷᵢ)². It squares each error before averaging, penalizing large errors more heavily. The square root of MSE is RMSE (Root Mean Squared Error), which is in the same units as the target variable and often easier to interpret.',
 'Sai Số Bình Phương Trung Bình (MSE) = (1/n) × Σ(yᵢ − ŷᵢ)². Nó bình phương mỗi sai số trước khi lấy trung bình, phạt nặng hơn các sai số lớn. Căn bậc hai của MSE là RMSE (Căn Bậc Hai Sai Số Bình Phương Trung Bình), có cùng đơn vị với biến mục tiêu và thường dễ giải thích hơn.',
 5);


-- Exercise 6: sentence_transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'machine-learning-basics'),
 'sentence_transform', 'medium',
 'Expand this sentence to clarify the risk of overfitting: "A decision tree can be overfitted."',
 'Mở rộng câu này để làm rõ rủi ro của overfitting: "A decision tree can be overfitted."',
 'A decision tree can be overfitted to the training data, causing it to memorize noise rather than learn generalizable patterns.',
 'The expanded sentence adds "to the training data" to specify what is being overfitted to, and the consequence clause "causing it to memorize noise rather than learn generalizable patterns" explains WHY overfitting is harmful. Both clarifications are important for a complete technical statement.',
 'Câu mở rộng thêm "to the training data" để chỉ rõ đang overfitting vào cái gì, và mệnh đề hệ quả "causing it to memorize noise rather than learn generalizable patterns" giải thích TẠI SAO overfitting có hại. Cả hai làm rõ đều quan trọng cho một phát biểu kỹ thuật đầy đủ.',
 6);


-- Exercise 7: arrange_words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'machine-learning-basics'),
 'arrange_words', 'medium',
 'Arrange the words to form a correct definition sentence about machine learning features.',
 'Sắp xếp các từ để tạo thành câu định nghĩa đúng về đặc trưng trong học máy.',
 'Features are the input variables used to train a machine learning model.',
 '["Features", "are", "the", "input", "variables", "used", "to", "train", "a", "machine", "learning", "model"]',
 'Features are the inputs (independent variables) that a machine learning model uses to learn patterns and make predictions. For example, in a model predicting student grades: study hours, attendance, and previous scores are all features. The output (grade) is the label.',
 'Đặc trưng là các đầu vào (biến độc lập) mà mô hình học máy sử dụng để học các mô hình và đưa ra dự đoán. Ví dụ, trong mô hình dự đoán điểm học sinh: giờ học, chuyên cần và điểm trước đều là đặc trưng. Đầu ra (điểm số) là nhãn.',
 7);
