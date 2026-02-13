-- ============================================================================
-- SEED DATA: Math Foundations (4 lessons)
-- Category: Math Foundations (ID 6)
-- Lessons: IDs 20-23
-- Compatible with: schema.sql v7
-- ============================================================================


-- ============================================================================
-- CATEGORY 6: Math Foundations
-- ============================================================================

INSERT INTO category (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('Math Foundations', 'Toán Nền Tảng', 'Build core math skills: algebra, statistics, logic, and number theory', 'Xây dựng kỹ năng toán cốt lõi: đại số, thống kê, logic và lý thuyết số', 'Functions', '#10b981', 6);


-- ############################################################################
-- LESSON 20: ALGEBRA BASICS (lesson_id = 20)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(6, 'Algebra Basics', 'Đại Số Cơ Bản', 'math-algebra', 'Variables, expressions, solving equations, and inequalities', 'Biến, biểu thức, giải phương trình và bất phương trình', 'beginner', 25, 1);

-- Usages (IDs 60-62)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(20, 'Understanding variables and expressions', 'Hiểu biến và biểu thức', 'Variables represent unknown values. Expressions combine variables, numbers, and operations like 2x + 3.', 'Biến đại diện cho giá trị chưa biết. Biểu thức kết hợp biến, số và phép tính như 2x + 3.', 'Functions', TRUE, 1),
(20, 'Solving linear equations', 'Giải phương trình bậc nhất', 'Use inverse operations to isolate the variable and find its value.', 'Dùng phép tính ngược để cô lập biến và tìm giá trị của nó.', 'Calculate', TRUE, 2),
(20, 'Working with inequalities', 'Làm việc với bất phương trình', 'Inequalities use <, >, <=, >= to compare expressions and describe ranges of solutions.', 'Bất phương trình dùng <, >, <=, >= để so sánh biểu thức và mô tả phạm vi nghiệm.', 'Analytics', TRUE, 3);

-- Examples for usage 60 (IDs 115-116)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(60, 'In the expression 2x + 3, x is the variable and 2 is the coefficient.', 'Trong biểu thức 2x + 3, x là biến và 2 là hệ số.', 'A coefficient is the number multiplied by a variable. The constant term (3) stands alone without a variable.', 'Hệ số là số nhân với biến. Hằng số (3) đứng một mình không có biến.', '2x + 3', 1),
(60, 'If x = 4, then the expression 3x - 1 equals 3(4) - 1 = 11.', 'Nếu x = 4, thì biểu thức 3x - 1 bằng 3(4) - 1 = 11.', 'To evaluate an expression, substitute (replace) the variable with the given value and compute.', 'Để tính giá trị biểu thức, thay thế biến bằng giá trị cho trước và tính.', '3x - 1', 2);

-- Examples for usage 61 (IDs 117-118)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(61, 'To solve 2x + 3 = 11, subtract 3 from both sides: 2x = 8, then divide by 2: x = 4.', 'Để giải 2x + 3 = 11, trừ 3 hai vế: 2x = 8, rồi chia cho 2: x = 4.', 'Use inverse operations: subtraction undoes addition, division undoes multiplication.', 'Dùng phép tính ngược: phép trừ đảo ngược phép cộng, phép chia đảo ngược phép nhân.', '2x + 3 = 11', 1),
(61, 'To solve x/5 = 3, multiply both sides by 5: x = 15.', 'Để giải x/5 = 3, nhân hai vế cho 5: x = 15.', 'Whatever you do to one side of the equation, you must do to the other side to keep it balanced.', 'Bất cứ phép tính nào thực hiện một vế, phải thực hiện vế còn lại để phương trình cân bằng.', 'x/5 = 3', 2);

-- Examples for usage 62 (IDs 119-120)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(62, 'x + 5 > 12 means x > 7 — any value greater than 7 is a solution.', 'x + 5 > 12 nghĩa là x > 7 — bất kỳ giá trị nào lớn hơn 7 đều là nghiệm.', 'Unlike equations (one answer), inequalities have infinitely many solutions forming a range.', 'Khác phương trình (một đáp số), bất phương trình có vô số nghiệm tạo thành một phạm vi.', 'x > 7', 1),
(62, 'When multiplying or dividing an inequality by a negative number, flip the sign: -2x > 6 becomes x < -3.', 'Khi nhân hoặc chia bất phương trình cho số âm, đổi chiều dấu: -2x > 6 trở thành x < -3.', 'This is the most common mistake in inequalities — always flip the direction when dividing by a negative.', 'Đây là lỗi phổ biến nhất trong bất phương trình — luôn đổi chiều khi chia cho số âm.', 'flip the sign', 2);

-- Tips (IDs 59-61)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(20, 'Balance is the golden rule', 'Cân bằng là nguyên tắc vàng', 'Whatever you do to one side of an equation, you MUST do to the other side. Think of an equation as a balance scale — both sides must always weigh the same.', 'Bất cứ phép tính nào thực hiện một vế phương trình, bạn PHẢI thực hiện vế còn lại. Hãy nghĩ phương trình như một cân — hai bên luôn phải cân bằng.', 'general', 'high', 'Lightbulb', 1),
(20, 'Check your answer by substituting back', 'Kiểm tra đáp số bằng cách thay ngược lại', 'After solving x = 4 from 2x + 3 = 11, substitute back: 2(4) + 3 = 11. If both sides are equal, your answer is correct. This catches arithmetic mistakes.', 'Sau khi giải x = 4 từ 2x + 3 = 11, thay ngược lại: 2(4) + 3 = 11. Nếu hai vế bằng nhau, đáp số đúng. Cách này phát hiện lỗi tính toán.', 'common_mistake', 'high', 'Warning', 2),
(20, 'PEMDAS order of operations', 'Thứ tự phép tính PEMDAS', 'Remember PEMDAS: Parentheses, Exponents, Multiplication/Division (left to right), Addition/Subtraction (left to right). For example: 2 + 3 * 4 = 14, not 20.', 'Nhớ PEMDAS: Ngoặc, Lũy thừa, Nhân/Chia (trái sang phải), Cộng/Trừ (trái sang phải). Ví dụ: 2 + 3 * 4 = 14, không phải 20.', 'shortcut', 'medium', 'Info', 3);

-- Sections (IDs 22-24)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(20, 'markdown', 'Introduction to Algebra', 'Giới thiệu Đại Số',
'## What is Algebra?

Algebra uses **letters (variables)** to represent unknown numbers. This lets us describe patterns and solve problems.

### Variables and Expressions

```
Variable: x, y, n (letters that stand for numbers)
Expression: 2x + 3 (combines variables, numbers, and operations)
Equation: 2x + 3 = 11 (two expressions set equal)
```

### Solving Equations — Step by Step

The goal is to **isolate the variable** on one side:

```
Solve: 2x + 3 = 11

Step 1: Subtract 3 from both sides
        2x + 3 - 3 = 11 - 3
        2x = 8

Step 2: Divide both sides by 2
        2x / 2 = 8 / 2
        x = 4

Check: 2(4) + 3 = 8 + 3 = 11 ✓
```

### Inequalities

```
x + 5 > 12     →  x > 7      (subtract 5)
3x <= 15       →  x <= 5     (divide by 3)
-2x > 6        →  x < -3     (divide by -2, FLIP the sign!)
```

> **Key Rule:** When you multiply or divide by a **negative number**, flip the inequality sign.',
'## Đại Số là gì?

Đại số dùng **chữ cái (biến)** để đại diện cho số chưa biết. Điều này giúp mô tả quy luật và giải bài toán.

### Biến và Biểu thức

```
Biến: x, y, n (chữ cái đại diện cho số)
Biểu thức: 2x + 3 (kết hợp biến, số và phép tính)
Phương trình: 2x + 3 = 11 (hai biểu thức bằng nhau)
```

### Giải Phương trình — Từng bước

Mục tiêu là **cô lập biến** về một vế:

```
Giải: 2x + 3 = 11

Bước 1: Trừ 3 hai vế
        2x + 3 - 3 = 11 - 3
        2x = 8

Bước 2: Chia hai vế cho 2
        2x / 2 = 8 / 2
        x = 4

Kiểm tra: 2(4) + 3 = 8 + 3 = 11 ✓
```

### Bất phương trình

```
x + 5 > 12     →  x > 7      (trừ 5)
3x <= 15       →  x <= 5     (chia cho 3)
-2x > 6        →  x < -3     (chia cho -2, ĐỔI CHIỀU dấu!)
```

> **Quy tắc quan trọng:** Khi nhân hoặc chia cho **số âm**, đổi chiều dấu bất phương trình.', 1, '{}'),

(20, 'key_points', 'Key Points', 'Điểm chính',
'- **Variables** (x, y) represent unknown values in expressions and equations
- **Expressions** combine variables, numbers, and operations: `2x + 3`
- **Equations** set two expressions equal: `2x + 3 = 11`
- Solve by using **inverse operations** to isolate the variable
- Always **do the same thing to both sides** of an equation
- **Inequalities** describe ranges of solutions (`x > 7` means any number greater than 7)',
'- **Biến** (x, y) đại diện cho giá trị chưa biết trong biểu thức và phương trình
- **Biểu thức** kết hợp biến, số và phép tính: `2x + 3`
- **Phương trình** đặt hai biểu thức bằng nhau: `2x + 3 = 11`
- Giải bằng cách dùng **phép tính ngược** để cô lập biến
- Luôn **thực hiện cùng phép tính cho cả hai vế** phương trình
- **Bất phương trình** mô tả phạm vi nghiệm (`x > 7` nghĩa là bất kỳ số nào lớn hơn 7)', 2, '{}'),

(20, 'info_box', 'Common Mistake', 'Lỗi thường gặp',
'**Common mistake:** Forgetting to flip the inequality sign when dividing by a negative number.

```
WRONG:   -2x > 6  →  x > -3
CORRECT: -2x > 6  →  x < -3  (flip > to <)
```

**Why?** Multiplying or dividing by a negative reverses the order. Think: if -2 > -4, then after dividing both by -2: 1 < 2 (flipped!).',
'**Lỗi phổ biến:** Quên đổi chiều dấu bất phương trình khi chia cho số âm.

```
SAI:  -2x > 6  →  x > -3
ĐÚNG: -2x > 6  →  x < -3  (đổi > thành <)
```

**Tại sao?** Nhân hoặc chia cho số âm đảo ngược thứ tự. Nghĩ: nếu -2 > -4, chia cả hai cho -2: 1 < 2 (đã đổi chiều!).', 3, '{"variant": "warning"}');

-- Exercise 134: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(20, 'multiple_choice', 'easy', 'What is the value of x in the equation 2x + 3 = 11?', 'Giá trị của x trong phương trình 2x + 3 = 11 là bao nhiêu?', 'Solve for x: 2x + 3 = 11', 'Giải x: 2x + 3 = 11', 'Subtract 3 from both sides: 2x = 8. Divide both sides by 2: x = 4. Check: 2(4) + 3 = 11.', 'Trừ 3 hai vế: 2x = 8. Chia hai vế cho 2: x = 4. Kiểm tra: 2(4) + 3 = 11.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(134, 'A', '3', FALSE, 'If x = 3: 2(3) + 3 = 9, not 11', 1),
(134, 'B', '4', TRUE, 'Correct! 2(4) + 3 = 8 + 3 = 11', 2),
(134, 'C', '5', FALSE, 'If x = 5: 2(5) + 3 = 13, not 11', 3),
(134, 'D', '7', FALSE, 'If x = 7: 2(7) + 3 = 17, not 11', 4);

-- Exercise 135: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(20, 'fill_blank', 'medium', 'Solve the equation and fill in the value of x.', 'Giải phương trình và điền giá trị của x.', 'If 5x - 10 = 15, then x = ___.', 'Nếu 5x - 10 = 15, thì x = ___.', '5', 'Add 10 to both sides: 5x = 25. Divide both sides by 5: x = 5. Check: 5(5) - 10 = 25 - 10 = 15.', 'Cộng 10 hai vế: 5x = 25. Chia hai vế cho 5: x = 5. Kiểm tra: 5(5) - 10 = 25 - 10 = 15.', 15, 2);

-- Exercise 136: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(20, 'error_correction', 'medium', 'Find and fix the algebraic mistake.', 'Tìm và sửa lỗi đại số.', '3x + 4 = 19, so 3x = 23', '3x + 4 = 19, nên 3x = 23', '3x + 4 = 19, so 3x = 15', 'To isolate 3x, subtract 4 from both sides: 19 - 4 = 15, not 19 + 4 = 23. The student added instead of subtracting.', 'Để cô lập 3x, trừ 4 hai vế: 19 - 4 = 15, không phải 19 + 4 = 23. Học sinh đã cộng thay vì trừ.', 'When moving a number to the other side, use the inverse operation.', 'Khi chuyển số sang vế kia, dùng phép tính ngược.', 15, 3);

-- Exercise 137: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(20, 'sentence_transform', 'medium', 'Rewrite the word problem as an algebraic equation.', 'Viết lại bài toán dạng lời thành phương trình đại số.', 'A number doubled plus seven equals twenty-one.', 'Một số nhân đôi cộng bảy bằng hai mươi mốt.', '2x + 7 = 21', '"A number" becomes the variable x. "Doubled" means multiplied by 2 (2x). "Plus seven" is + 7. "Equals twenty-one" is = 21. So: 2x + 7 = 21.', '"Một số" trở thành biến x. "Nhân đôi" nghĩa là nhân 2 (2x). "Cộng bảy" là + 7. "Bằng hai mươi mốt" là = 21. Vậy: 2x + 7 = 21.', 15, 4);

-- Exercise 138: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(20, 'arrange_words', 'easy', 'Arrange the steps to solve the equation 3x - 6 = 12 in the correct order.', 'Sắp xếp các bước giải phương trình 3x - 6 = 12 theo đúng thứ tự.', '["Divide both sides by 3", "Add 6 to both sides", "Check: 3(6) - 6 = 12", "x = 6"]', 'Add 6 to both sides, Divide both sides by 3, x = 6, Check: 3(6) - 6 = 12', 'First undo the subtraction (add 6): 3x = 18. Then undo the multiplication (divide by 3): x = 6. Finally verify your answer.', 'Đầu tiên đảo phép trừ (cộng 6): 3x = 18. Rồi đảo phép nhân (chia cho 3): x = 6. Cuối cùng kiểm tra đáp số.', 10, 5);

-- Exercise 139: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(20, 'matching', 'easy', 'Match each algebraic term to its definition.', 'Nối mỗi thuật ngữ đại số với định nghĩa tương ứng.', 'Understanding these fundamental terms is essential for reading and writing algebraic expressions and equations.', 'Hiểu các thuật ngữ cơ bản này là cần thiết để đọc và viết biểu thức, phương trình đại số.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(139, 'Variable', 'Biến', 'A letter representing an unknown value', 'Chữ cái đại diện cho giá trị chưa biết', 1),
(139, 'Coefficient', 'Hệ số', 'The number multiplied by a variable', 'Số nhân với biến', 2),
(139, 'Constant', 'Hằng số', 'A fixed number without a variable', 'Số cố định không có biến', 3),
(139, 'Equation', 'Phương trình', 'Two expressions set equal with =', 'Hai biểu thức bằng nhau qua dấu =', 4);

-- Exercise 140: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(20, 'true_false', 'easy', 'Is this statement about algebra correct?', 'Phát biểu này về đại số có đúng không?', 'When solving an inequality and dividing both sides by a negative number, the inequality sign stays the same.', 'Khi giải bất phương trình và chia hai vế cho số âm, dấu bất phương trình giữ nguyên.', 'false', 'False! When you multiply or divide both sides of an inequality by a negative number, you MUST flip the inequality sign. For example: -2x > 6 becomes x < -3 (not x > -3).', 'Sai! Khi nhân hoặc chia hai vế bất phương trình cho số âm, bạn PHẢI đổi chiều dấu. Ví dụ: -2x > 6 trở thành x < -3 (không phải x > -3).', 10, 7);


-- ############################################################################
-- LESSON 21: STATISTICS INTRODUCTION (lesson_id = 21)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(6, 'Statistics Introduction', 'Nhập Môn Thống Kê', 'math-statistics', 'Mean, median, mode, range, and standard deviation concepts', 'Trung bình, trung vị, yếu vị, khoảng biến thiên và khái niệm độ lệch chuẩn', 'beginner', 30, 2);

-- Usages (IDs 63-65)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(21, 'Calculating measures of central tendency', 'Tính các đại lượng xu hướng trung tâm', 'Mean, median, and mode summarize a data set with a single representative value.', 'Trung bình, trung vị và yếu vị tóm tắt tập dữ liệu bằng một giá trị đại diện.', 'Analytics', TRUE, 1),
(21, 'Understanding data spread', 'Hiểu độ phân tán dữ liệu', 'Range and standard deviation measure how spread out the data values are.', 'Khoảng biến thiên và độ lệch chuẩn đo mức độ phân tán của các giá trị dữ liệu.', 'BarChart', TRUE, 2),
(21, 'Interpreting statistics in context', 'Diễn giải thống kê trong ngữ cảnh', 'Choose the right measure depending on the data and what you want to communicate.', 'Chọn đại lượng phù hợp tùy thuộc vào dữ liệu và điều bạn muốn truyền đạt.', 'Psychology', TRUE, 3);

-- Examples for usage 63 (IDs 121-122)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(63, 'For the data set {3, 5, 7, 7, 8}, the mean is (3+5+7+7+8)/5 = 6.', 'Cho tập dữ liệu {3, 5, 7, 7, 8}, trung bình là (3+5+7+7+8)/5 = 6.', 'Mean (average) = sum of all values divided by the number of values.', 'Trung bình (mean) = tổng tất cả giá trị chia cho số lượng giá trị.', 'mean', 1),
(63, 'The median of {3, 5, 7, 7, 8} is 7 — the middle value when sorted.', 'Trung vị của {3, 5, 7, 7, 8} là 7 — giá trị ở giữa khi sắp xếp.', 'For an odd number of values, the median is the middle one. For an even number, average the two middle values.', 'Với số lẻ giá trị, trung vị là giá trị giữa. Với số chẵn, lấy trung bình hai giá trị giữa.', 'median', 2);

-- Examples for usage 64 (IDs 123-124)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(64, 'Range of {3, 5, 7, 7, 8} is 8 - 3 = 5 — the gap between largest and smallest.', 'Khoảng biến thiên của {3, 5, 7, 7, 8} là 8 - 3 = 5 — khoảng cách giữa lớn nhất và nhỏ nhất.', 'Range is the simplest measure of spread but is sensitive to outliers (extreme values).', 'Khoảng biến thiên là đại lượng phân tán đơn giản nhất nhưng nhạy cảm với giá trị ngoại lai.', 'range', 1),
(64, 'Data set A: {48, 50, 52} and B: {10, 50, 90} — same mean (50) but B is much more spread out.', 'Tập A: {48, 50, 52} và B: {10, 50, 90} — cùng trung bình (50) nhưng B phân tán nhiều hơn.', 'Standard deviation captures this difference. Low SD means data is clustered near the mean; high SD means data is spread out.', 'Độ lệch chuẩn cho thấy sự khác biệt này. SD thấp nghĩa là dữ liệu tập trung gần trung bình; SD cao nghĩa là phân tán.', 'spread out', 2);

-- Examples for usage 65 (IDs 125-126)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(65, 'Salaries {30K, 35K, 40K, 45K, 500K}: mean = 130K (misleading!), median = 40K (better).', 'Lương {30K, 35K, 40K, 45K, 500K}: trung bình = 130K (gây hiểu lầm!), trung vị = 40K (tốt hơn).', 'When data has outliers, the median is more representative than the mean because it is not pulled by extreme values.', 'Khi dữ liệu có giá trị ngoại lai, trung vị đại diện hơn trung bình vì không bị kéo bởi giá trị cực đoan.', 'median', 1),
(65, 'Shoe sizes sold: {8, 8, 8, 9, 10, 11} — mode is 8 (most popular size to stock).', 'Cỡ giày bán: {8, 8, 8, 9, 10, 11} — yếu vị là 8 (cỡ phổ biến nhất cần nhập hàng).', 'Mode is the most frequently occurring value. It is useful for categorical data or finding the most common item.', 'Yếu vị là giá trị xuất hiện nhiều nhất. Hữu ích cho dữ liệu phân loại hoặc tìm mục phổ biến nhất.', 'mode', 2);

-- Tips (IDs 62-64)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(21, 'Mean vs Median — when to use which', 'Trung bình vs Trung vị — khi nào dùng cái nào', 'Use the MEAN when data is evenly distributed with no extreme values. Use the MEDIAN when data has outliers or is skewed — for example, income data where a few very high earners distort the average.', 'Dùng TRUNG BÌNH khi dữ liệu phân bố đều không có giá trị cực đoan. Dùng TRUNG VỊ khi dữ liệu có giá trị ngoại lai hoặc lệch — ví dụ, dữ liệu thu nhập khi vài người thu nhập rất cao làm lệch trung bình.', 'general', 'high', 'Lightbulb', 1),
(21, 'Do not confuse mean and median', 'Đừng nhầm lẫn trung bình và trung vị', 'Mean = sum divided by count (affected by outliers). Median = middle value when sorted (resistant to outliers). For {1, 2, 3, 4, 100}: mean = 22, median = 3. The median is often more "typical".', 'Trung bình = tổng chia cho số lượng (bị ảnh hưởng bởi ngoại lai). Trung vị = giá trị giữa khi sắp xếp (kháng ngoại lai). Với {1, 2, 3, 4, 100}: trung bình = 22, trung vị = 3. Trung vị thường "tiêu biểu" hơn.', 'common_mistake', 'high', 'Warning', 2),
(21, 'Quick median calculation', 'Tính trung vị nhanh', 'For a sorted list of n values: if n is odd, median is at position (n+1)/2. If n is even, median is the average of values at positions n/2 and n/2+1. Example: 7 values → position 4; 8 values → average of positions 4 and 5.', 'Cho danh sách n giá trị đã sắp xếp: nếu n lẻ, trung vị ở vị trí (n+1)/2. Nếu n chẵn, trung vị là trung bình của vị trí n/2 và n/2+1. Ví dụ: 7 giá trị → vị trí 4; 8 giá trị → trung bình vị trí 4 và 5.', 'shortcut', 'medium', 'Info', 3);

-- Sections (IDs 25-27)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(21, 'markdown', 'Descriptive Statistics', 'Thống Kê Mô Tả',
'## Measures of Central Tendency

These summarize a data set with a **single representative value**.

### Mean (Average)

```
Data: 4, 8, 6, 5, 7
Mean = (4 + 8 + 6 + 5 + 7) / 5 = 30 / 5 = 6
```

### Median (Middle Value)

```
Sorted data: 4, 5, 6, 7, 8
Median = 6 (the middle value)

Even count: 4, 5, 7, 8
Median = (5 + 7) / 2 = 6
```

### Mode (Most Frequent)

```
Data: 3, 5, 5, 7, 8, 5, 9
Mode = 5 (appears 3 times)
```

## Measures of Spread

### Range

```
Data: 4, 8, 6, 5, 7
Range = max - min = 8 - 4 = 4
```

### Standard Deviation (concept)

```
Low SD:  {48, 49, 50, 51, 52} → data clustered near mean
High SD: {10, 30, 50, 70, 90} → data spread far from mean
```

> **Tip:** Mean is sensitive to outliers; median is resistant. Choose wisely based on your data.',
'## Đại lượng xu hướng trung tâm

Tóm tắt tập dữ liệu bằng **một giá trị đại diện**.

### Trung bình (Mean)

```
Dữ liệu: 4, 8, 6, 5, 7
Trung bình = (4 + 8 + 6 + 5 + 7) / 5 = 30 / 5 = 6
```

### Trung vị (Median)

```
Dữ liệu sắp xếp: 4, 5, 6, 7, 8
Trung vị = 6 (giá trị ở giữa)

Số chẵn: 4, 5, 7, 8
Trung vị = (5 + 7) / 2 = 6
```

### Yếu vị (Mode)

```
Dữ liệu: 3, 5, 5, 7, 8, 5, 9
Yếu vị = 5 (xuất hiện 3 lần)
```

## Đại lượng phân tán

### Khoảng biến thiên (Range)

```
Dữ liệu: 4, 8, 6, 5, 7
Khoảng biến thiên = max - min = 8 - 4 = 4
```

### Độ lệch chuẩn (khái niệm)

```
SD thấp:  {48, 49, 50, 51, 52} → dữ liệu tập trung gần trung bình
SD cao:   {10, 30, 50, 70, 90} → dữ liệu phân tán xa trung bình
```

> **Mẹo:** Trung bình nhạy cảm với ngoại lai; trung vị kháng ngoại lai. Chọn phù hợp theo dữ liệu.', 1, '{}'),

(21, 'key_points', 'Key Points', 'Điểm chính',
'- **Mean** (average) = sum of all values / count of values
- **Median** = middle value when data is sorted (resistant to outliers)
- **Mode** = the most frequently occurring value
- **Range** = maximum value minus minimum value
- **Standard deviation** measures how spread out values are from the mean
- Use **median** instead of mean when data has extreme outliers',
'- **Trung bình** (mean) = tổng tất cả giá trị / số lượng giá trị
- **Trung vị** (median) = giá trị giữa khi dữ liệu sắp xếp (kháng ngoại lai)
- **Yếu vị** (mode) = giá trị xuất hiện nhiều nhất
- **Khoảng biến thiên** (range) = giá trị lớn nhất trừ giá trị nhỏ nhất
- **Độ lệch chuẩn** đo mức phân tán giá trị so với trung bình
- Dùng **trung vị** thay vì trung bình khi dữ liệu có giá trị ngoại lai cực đoan', 2, '{}'),

(21, 'info_box', 'Outliers Change Everything', 'Giá trị ngoại lai thay đổi tất cả',
'**Watch out for outliers** — they can make the mean very misleading:

```
Test scores: 85, 90, 88, 92, 87
Mean = 88.4 (representative)

Now add one outlier: 85, 90, 88, 92, 87, 20
Mean = 77.0 (misleading!)
Median = 87.5 (still representative)
```

**Rule of thumb:** If your data has extreme values, report the **median** instead of the mean.',
'**Coi chừng giá trị ngoại lai** — chúng có thể làm trung bình rất sai lệch:

```
Điểm thi: 85, 90, 88, 92, 87
Trung bình = 88.4 (đại diện)

Thêm ngoại lai: 85, 90, 88, 92, 87, 20
Trung bình = 77.0 (sai lệch!)
Trung vị = 87.5 (vẫn đại diện)
```

**Quy tắc chung:** Nếu dữ liệu có giá trị cực đoan, báo cáo **trung vị** thay vì trung bình.', 3, '{"variant": "tip"}');

-- Exercise 141: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(21, 'multiple_choice', 'easy', 'What is the median of the data set {2, 5, 7, 9, 12}?', 'Trung vị của tập dữ liệu {2, 5, 7, 9, 12} là bao nhiêu?', 'Find the middle value of the sorted data set: 2, 5, 7, 9, 12', 'Tìm giá trị giữa của tập dữ liệu đã sắp xếp: 2, 5, 7, 9, 12', 'The data is already sorted with 5 values. The middle (3rd) value is 7. For odd-count data sets, the median is always the single middle value.', 'Dữ liệu đã sắp xếp có 5 giá trị. Giá trị giữa (thứ 3) là 7. Với tập dữ liệu có số lẻ phần tử, trung vị luôn là giá trị giữa duy nhất.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(141, 'A', '5', FALSE, '5 is the second value, not the middle one', 1),
(141, 'B', '7', TRUE, 'Correct! 7 is the 3rd value out of 5 — the exact middle', 2),
(141, 'C', '9', FALSE, '9 is the fourth value, not the middle', 3),
(141, 'D', '7.0', FALSE, '7.0 and 7 are numerically equal, but 7 is the exact answer since it is directly from the data set', 4);

-- Exercise 142: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(21, 'fill_blank', 'medium', 'Calculate the mean of this data set.', 'Tính trung bình của tập dữ liệu này.', 'The mean of {10, 20, 30, 40, 50} is ___.', 'Trung bình của {10, 20, 30, 40, 50} là ___.', '30', 'Mean = (10 + 20 + 30 + 40 + 50) / 5 = 150 / 5 = 30.', 'Trung bình = (10 + 20 + 30 + 40 + 50) / 5 = 150 / 5 = 30.', 15, 2);

-- Exercise 143: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(21, 'error_correction', 'medium', 'Fix the incorrect calculation of the median.', 'Sửa phép tính trung vị sai.', 'Data: {8, 3, 5, 1, 9}. The median is 5 because it is in the middle of the list.', 'Dữ liệu: {8, 3, 5, 1, 9}. Trung vị là 5 vì nó ở giữa danh sách.', 'Data: {8, 3, 5, 1, 9}. Sorted: {1, 3, 5, 8, 9}. The median is 5.', 'The answer (5) happens to be correct, but the reasoning is wrong. You must SORT the data first: {1, 3, 5, 8, 9}. The median is 5 because it is the middle of the SORTED list, not the original list.', 'Đáp số (5) tình cờ đúng, nhưng lý luận sai. Bạn phải SẮP XẾP dữ liệu trước: {1, 3, 5, 8, 9}. Trung vị là 5 vì nó ở giữa danh sách ĐÃ SẮP XẾP, không phải danh sách gốc.', 'What step must you always do before finding the median?', 'Bước nào bạn luôn phải thực hiện trước khi tìm trung vị?', 15, 3);

-- Exercise 144: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(21, 'sentence_transform', 'medium', 'Rewrite using the correct statistical term.', 'Viết lại dùng thuật ngữ thống kê chính xác.', 'The average of 4, 6, and 8 is (4 + 6 + 8) / 3 = 6.', 'Trung bình của 4, 6 và 8 là (4 + 6 + 8) / 3 = 6.', 'The mean of 4, 6, and 8 is (4 + 6 + 8) / 3 = 6.', 'In statistics, "average" is informally used but the precise term is "mean" (specifically "arithmetic mean"). Using proper terminology avoids confusion with median or mode.', 'Trong thống kê, "trung bình" dùng không chính thức nhưng thuật ngữ chính xác là "mean" (cụ thể là "arithmetic mean"). Dùng thuật ngữ đúng tránh nhầm lẫn với trung vị hoặc yếu vị.', 15, 4);

-- Exercise 145: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(21, 'arrange_words', 'easy', 'Arrange the steps to calculate the median of a data set.', 'Sắp xếp các bước tính trung vị của tập dữ liệu.', '["Find the middle value", "Sort the data from smallest to largest", "Count the number of values", "If even count, average the two middle values"]', 'Sort the data from smallest to largest, Count the number of values, Find the middle value, If even count, average the two middle values', 'First sort, then count to know if odd or even, find the middle position, and handle the even case if needed.', 'Đầu tiên sắp xếp, rồi đếm để biết lẻ hay chẵn, tìm vị trí giữa, và xử lý trường hợp chẵn nếu cần.', 10, 5);

-- Exercise 146: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(21, 'matching', 'easy', 'Match each statistical measure to its description.', 'Nối mỗi đại lượng thống kê với mô tả tương ứng.', 'These are the fundamental measures used to describe and summarize data sets in descriptive statistics.', 'Đây là các đại lượng cơ bản dùng để mô tả và tóm tắt tập dữ liệu trong thống kê mô tả.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(146, 'Mean', 'Trung bình', 'Sum of values divided by count', 'Tổng giá trị chia cho số lượng', 1),
(146, 'Median', 'Trung vị', 'Middle value when data is sorted', 'Giá trị giữa khi dữ liệu sắp xếp', 2),
(146, 'Mode', 'Yếu vị', 'Most frequently occurring value', 'Giá trị xuất hiện nhiều nhất', 3),
(146, 'Range', 'Khoảng biến thiên', 'Difference between max and min', 'Hiệu giữa giá trị lớn nhất và nhỏ nhất', 4);

-- Exercise 147: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(21, 'true_false', 'easy', 'Is this statement about statistics correct?', 'Phát biểu này về thống kê có đúng không?', 'The mean is always the best way to represent the center of a data set.', 'Trung bình luôn là cách tốt nhất để đại diện cho tâm của tập dữ liệu.', 'false', 'False! The mean is heavily affected by outliers. For example, in {1, 2, 3, 4, 100}, the mean is 22 but the median is 3. The median better represents the "typical" value when outliers exist.', 'Sai! Trung bình bị ảnh hưởng nặng bởi giá trị ngoại lai. Ví dụ, trong {1, 2, 3, 4, 100}, trung bình là 22 nhưng trung vị là 3. Trung vị đại diện tốt hơn cho giá trị "tiêu biểu" khi có ngoại lai.', 10, 7);


-- ############################################################################
-- LESSON 22: LOGIC & REASONING (lesson_id = 22)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(6, 'Logic & Reasoning', 'Logic & Lập Luận', 'math-logic', 'Propositions, truth tables, AND/OR/NOT, and logical fallacies', 'Mệnh đề, bảng chân trị, AND/OR/NOT và ngụy biện logic', 'intermediate', 35, 3);

-- Usages (IDs 66-68)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(22, 'Understanding propositions', 'Hiểu mệnh đề', 'A proposition is a statement that is either true or false — never both.', 'Mệnh đề là một phát biểu đúng hoặc sai — không bao giờ cả hai.', 'CheckCircle', TRUE, 1),
(22, 'Using logical operators', 'Sử dụng toán tử logic', 'AND, OR, and NOT combine propositions to form compound statements.', 'AND, OR và NOT kết hợp các mệnh đề để tạo phát biểu phức hợp.', 'AccountTree', TRUE, 2),
(22, 'Recognizing logical fallacies', 'Nhận biết ngụy biện logic', 'Fallacies are errors in reasoning that make an argument invalid despite sounding convincing.', 'Ngụy biện là lỗi lập luận làm cho lý lẽ không hợp lệ dù nghe thuyết phục.', 'Psychology', TRUE, 3);

-- Examples for usage 66 (IDs 127-128)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(66, '"2 + 2 = 4" is a proposition (TRUE). "Is it raining?" is NOT a proposition (it is a question).', '"2 + 2 = 4" là mệnh đề (ĐÚNG). "Trời có mưa không?" KHÔNG phải mệnh đề (đó là câu hỏi).', 'A proposition must be a declarative statement with a definite truth value. Questions, commands, and opinions are not propositions.', 'Mệnh đề phải là phát biểu khẳng định có giá trị chân lý xác định. Câu hỏi, mệnh lệnh và ý kiến không phải mệnh đề.', 'proposition', 1),
(66, '"All cats can fly" is a proposition (FALSE). It has a clear truth value even though it is false.', '"Tất cả mèo biết bay" là mệnh đề (SAI). Nó có giá trị chân lý rõ ràng dù là sai.', 'A false statement is still a valid proposition — what matters is that it CAN be evaluated as true or false.', 'Phát biểu sai vẫn là mệnh đề hợp lệ — điều quan trọng là nó CÓ THỂ được đánh giá đúng hoặc sai.', 'FALSE', 2);

-- Examples for usage 67 (IDs 129-130)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(67, 'P AND Q is TRUE only when both P and Q are TRUE. Example: "It is sunny AND warm" is true only if both conditions hold.', 'P AND Q là TRUE chỉ khi cả P và Q đều TRUE. Ví dụ: "Trời nắng AND ấm" đúng chỉ khi cả hai điều kiện thỏa.', 'AND is the most restrictive operator — all conditions must be true for the result to be true.', 'AND là toán tử hạn chế nhất — tất cả điều kiện phải đúng để kết quả đúng.', 'AND', 1),
(67, 'P OR Q is TRUE when at least one of P or Q is TRUE. NOT P flips TRUE to FALSE and vice versa.', 'P OR Q là TRUE khi ít nhất một trong P hoặc Q là TRUE. NOT P đổi TRUE thành FALSE và ngược lại.', 'OR is inclusive — it is true when one, the other, or both are true. NOT simply inverts the truth value.', 'OR là toán tử bao hàm — đúng khi một, cái kia, hoặc cả hai đúng. NOT đơn giản đảo giá trị chân lý.', 'OR', 2);

-- Examples for usage 68 (IDs 131-132)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(68, 'Ad hominem fallacy: "You are wrong because you are young" — attacks the person, not the argument.', 'Ngụy biện ad hominem: "Bạn sai vì bạn còn trẻ" — tấn công người nói, không phải lý lẽ.', 'An argument should be evaluated on its logic and evidence, not on who is making it.', 'Lý lẽ nên được đánh giá dựa trên logic và bằng chứng, không phải dựa trên người nói.', 'ad hominem', 1),
(68, 'False dilemma: "You are either with us or against us" — ignores other possible positions.', 'Ngụy biện lưỡng phân giả: "Bạn hoặc đứng về phía chúng tôi hoặc chống lại" — bỏ qua các lập trường khác.', 'This fallacy presents only two options when there may be many more. Most real situations have a spectrum of possibilities.', 'Ngụy biện này chỉ đưa ra hai lựa chọn trong khi có thể có nhiều hơn. Hầu hết tình huống thực tế có nhiều khả năng.', 'false dilemma', 2);

-- Tips (IDs 65-67)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(22, 'Truth tables are your best friend', 'Bảng chân trị là bạn tốt nhất', 'When unsure about a logical expression, draw a truth table. List all possible TRUE/FALSE combinations for the inputs and compute the output for each row. This eliminates guessing.', 'Khi không chắc về biểu thức logic, hãy vẽ bảng chân trị. Liệt kê tất cả tổ hợp TRUE/FALSE cho đầu vào và tính đầu ra cho mỗi hàng. Cách này loại bỏ việc đoán.', 'general', 'high', 'Lightbulb', 1),
(22, 'AND vs OR — the classic confusion', 'AND vs OR — sự nhầm lẫn kinh điển', 'AND requires ALL conditions to be true (stricter). OR requires just ONE to be true (more lenient). Common mistake: saying "and" in everyday language often means "or" in logic. "I like cats and dogs" usually means "or" in logical terms.', 'AND yêu cầu TẤT CẢ điều kiện đúng (nghiêm ngặt hơn). OR chỉ cần MỘT đúng (thoải mái hơn). Lỗi phổ biến: "và" trong ngôn ngữ hàng ngày thường có nghĩa "hoặc" trong logic.', 'common_mistake', 'high', 'Warning', 2),
(22, 'De Morgan''s Laws shortcut', 'Quy tắc De Morgan', 'NOT (P AND Q) = (NOT P) OR (NOT Q). NOT (P OR Q) = (NOT P) AND (NOT Q). These laws let you simplify complex negations. Just flip AND/OR and negate each part.', 'NOT (P AND Q) = (NOT P) OR (NOT Q). NOT (P OR Q) = (NOT P) AND (NOT Q). Các quy tắc này giúp đơn giản hóa phủ định phức tạp. Chỉ cần đổi AND/OR và phủ định từng phần.', 'shortcut', 'medium', 'AutoAwesome', 3);

-- Sections (IDs 28-30)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(22, 'markdown', 'Introduction to Logic', 'Giới thiệu Logic',
'## Propositions and Truth Values

A **proposition** is a statement that is either TRUE or FALSE.

```
TRUE propositions:  "2 + 2 = 4", "The Earth orbits the Sun"
FALSE propositions: "5 > 10", "All birds can swim"
NOT propositions:   "Is it raining?" (question), "Close the door" (command)
```

## Logical Operators

### AND (Conjunction)

```
P AND Q — TRUE only when BOTH are TRUE

P     | Q     | P AND Q
------|-------|--------
TRUE  | TRUE  | TRUE
TRUE  | FALSE | FALSE
FALSE | TRUE  | FALSE
FALSE | FALSE | FALSE
```

### OR (Disjunction)

```
P OR Q — TRUE when AT LEAST ONE is TRUE

P     | Q     | P OR Q
------|-------|--------
TRUE  | TRUE  | TRUE
TRUE  | FALSE | TRUE
FALSE | TRUE  | TRUE
FALSE | FALSE | FALSE
```

### NOT (Negation)

```
NOT P — flips the truth value

P     | NOT P
------|------
TRUE  | FALSE
FALSE | TRUE
```

> **Remember:** AND is strict (both must be true). OR is lenient (only one needs to be true).',
'## Mệnh đề và Giá trị Chân lý

**Mệnh đề** là phát biểu đúng hoặc sai.

```
Mệnh đề ĐÚNG: "2 + 2 = 4", "Trái Đất quay quanh Mặt Trời"
Mệnh đề SAI:  "5 > 10", "Tất cả chim biết bơi"
KHÔNG phải mệnh đề: "Trời có mưa không?" (câu hỏi), "Đóng cửa lại" (mệnh lệnh)
```

## Toán tử Logic

### AND (Hội)

```
P AND Q — TRUE chỉ khi CẢ HAI đều TRUE

P     | Q     | P AND Q
------|-------|--------
TRUE  | TRUE  | TRUE
TRUE  | FALSE | FALSE
FALSE | TRUE  | FALSE
FALSE | FALSE | FALSE
```

### OR (Tuyển)

```
P OR Q — TRUE khi ÍT NHẤT MỘT là TRUE

P     | Q     | P OR Q
------|-------|--------
TRUE  | TRUE  | TRUE
TRUE  | FALSE | TRUE
FALSE | TRUE  | TRUE
FALSE | FALSE | FALSE
```

### NOT (Phủ định)

```
NOT P — đảo giá trị chân lý

P     | NOT P
------|------
TRUE  | FALSE
FALSE | TRUE
```

> **Nhớ:** AND nghiêm ngặt (cả hai phải đúng). OR thoải mái (chỉ cần một đúng).', 1, '{}'),

(22, 'key_points', 'Key Points', 'Điểm chính',
'- A **proposition** is a statement that is definitively TRUE or FALSE
- **AND** requires ALL conditions to be true (strict)
- **OR** requires at least ONE condition to be true (lenient)
- **NOT** inverts a truth value: NOT TRUE = FALSE, NOT FALSE = TRUE
- **De Morgan''s Laws**: NOT(P AND Q) = (NOT P) OR (NOT Q); NOT(P OR Q) = (NOT P) AND (NOT Q)
- **Logical fallacies** are errors in reasoning (ad hominem, false dilemma, straw man)',
'- **Mệnh đề** là phát biểu chắc chắn ĐÚNG hoặc SAI
- **AND** yêu cầu TẤT CẢ điều kiện đúng (nghiêm ngặt)
- **OR** yêu cầu ít nhất MỘT điều kiện đúng (thoải mái)
- **NOT** đảo giá trị chân lý: NOT TRUE = FALSE, NOT FALSE = TRUE
- **Quy tắc De Morgan**: NOT(P AND Q) = (NOT P) OR (NOT Q); NOT(P OR Q) = (NOT P) AND (NOT Q)
- **Ngụy biện logic** là lỗi lập luận (ad hominem, lưỡng phân giả, người rơm)', 2, '{}'),

(22, 'info_box', 'Everyday Logic Trap', 'Bẫy Logic Hàng Ngày',
'**In everyday language, "or" is usually exclusive** (one or the other, not both):
- "Do you want coffee or tea?" → you choose one

**In logic and programming, OR is inclusive** (one, the other, or both):
- TRUE OR TRUE = TRUE

```
Everyday: "You can have cake or pie" (pick one)
Logic:    "P OR Q" = TRUE if P, Q, or both are TRUE
```

**Tip:** In math and code, always assume OR is inclusive unless stated otherwise.',
'**Trong ngôn ngữ hàng ngày, "hoặc" thường loại trừ** (cái này hoặc cái kia, không phải cả hai):
- "Bạn muốn cà phê hay trà?" → chọn một

**Trong logic và lập trình, OR là bao hàm** (cái này, cái kia, hoặc cả hai):
- TRUE OR TRUE = TRUE

```
Hàng ngày: "Bạn có thể lấy bánh kem hoặc bánh nướng" (chọn một)
Logic:     "P OR Q" = TRUE nếu P, Q, hoặc cả hai TRUE
```

**Mẹo:** Trong toán và code, luôn giả sử OR là bao hàm trừ khi nói rõ khác.', 3, '{"variant": "info"}');

-- Exercise 148: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(22, 'multiple_choice', 'easy', 'What is the result of TRUE AND FALSE?', 'Kết quả của TRUE AND FALSE là gì?', 'Evaluate the logical expression: TRUE AND FALSE', 'Tính biểu thức logic: TRUE AND FALSE', 'AND requires BOTH operands to be TRUE. Since one is FALSE, the result is FALSE.', 'AND yêu cầu CẢ HAI toán hạng phải TRUE. Vì một cái FALSE, kết quả là FALSE.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(148, 'A', 'TRUE', FALSE, 'AND requires both to be TRUE — one FALSE makes the whole thing FALSE', 1),
(148, 'B', 'FALSE', TRUE, 'Correct! TRUE AND FALSE = FALSE because AND needs both to be TRUE', 2),
(148, 'C', 'NULL', FALSE, 'In standard logic there is no NULL — only TRUE and FALSE', 3),
(148, 'D', 'Error', FALSE, 'This is a valid logical expression with a definite answer', 4);

-- Exercise 149: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(22, 'fill_blank', 'medium', 'Fill in the logical operator.', 'Điền toán tử logic.', 'TRUE ___ FALSE = TRUE. (Which operator makes this statement true?)', 'TRUE ___ FALSE = TRUE. (Toán tử nào làm phát biểu này đúng?)', 'OR', 'TRUE OR FALSE = TRUE because OR only needs at least one operand to be TRUE. AND would give FALSE, and NOT only takes one operand.', 'TRUE OR FALSE = TRUE vì OR chỉ cần ít nhất một toán hạng TRUE. AND sẽ cho FALSE, và NOT chỉ nhận một toán hạng.', 15, 2);

-- Exercise 150: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(22, 'error_correction', 'medium', 'Fix the logical reasoning error.', 'Sửa lỗi lập luận logic.', 'NOT (P AND Q) = (NOT P) AND (NOT Q)', 'NOT (P AND Q) = (NOT P) AND (NOT Q)', 'NOT (P AND Q) = (NOT P) OR (NOT Q)', 'This is De Morgan''s Law. When you negate an AND expression, the AND becomes OR, and each part is negated. The original incorrectly kept AND instead of changing it to OR.', 'Đây là quy tắc De Morgan. Khi phủ định biểu thức AND, AND trở thành OR, và mỗi phần được phủ định. Bản gốc sai khi giữ AND thay vì đổi thành OR.', 'When you distribute NOT over AND, what happens to the operator?', 'Khi phân phối NOT qua AND, điều gì xảy ra với toán tử?', 15, 3);

-- Exercise 151: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(22, 'sentence_transform', 'medium', 'Apply De Morgan''s Law to rewrite this expression.', 'Áp dụng quy tắc De Morgan để viết lại biểu thức này.', 'NOT (A OR B)', 'NOT (A OR B)', '(NOT A) AND (NOT B)', 'De Morgan''s Law: NOT (A OR B) = (NOT A) AND (NOT B). Negate each part and flip OR to AND.', 'Quy tắc De Morgan: NOT (A OR B) = (NOT A) AND (NOT B). Phủ định từng phần và đổi OR thành AND.', 15, 4);

-- Exercise 152: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(22, 'arrange_words', 'easy', 'Arrange the logical operators from most restrictive to least restrictive.', 'Sắp xếp các toán tử logic từ hạn chế nhất đến ít hạn chế nhất.', '["OR (at least one true)", "NOT (inverts value)", "AND (all must be true)"]', 'AND (all must be true), NOT (inverts value), OR (at least one true)', 'AND is most restrictive (both must be true), NOT changes a single value, OR is least restrictive (just one needs to be true).', 'AND hạn chế nhất (cả hai phải đúng), NOT đổi một giá trị đơn, OR ít hạn chế nhất (chỉ cần một đúng).', 10, 5);

-- Exercise 153: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(22, 'matching', 'easy', 'Match each logical concept to its description.', 'Nối mỗi khái niệm logic với mô tả tương ứng.', 'These are the core building blocks of propositional logic, used in mathematics, philosophy, and computer science.', 'Đây là các khối xây dựng cốt lõi của logic mệnh đề, dùng trong toán học, triết học và khoa học máy tính.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(153, 'Proposition', 'Mệnh đề', 'A statement that is TRUE or FALSE', 'Phát biểu đúng hoặc sai', 1),
(153, 'AND', 'AND (Hội)', 'TRUE only when both inputs are TRUE', 'TRUE chỉ khi cả hai đầu vào TRUE', 2),
(153, 'OR', 'OR (Tuyển)', 'TRUE when at least one input is TRUE', 'TRUE khi ít nhất một đầu vào TRUE', 3),
(153, 'NOT', 'NOT (Phủ định)', 'Inverts TRUE to FALSE and vice versa', 'Đảo TRUE thành FALSE và ngược lại', 4);

-- Exercise 154: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(22, 'true_false', 'easy', 'Is this statement about logic correct?', 'Phát biểu này về logic có đúng không?', 'In logic, the OR operator is TRUE when both inputs are TRUE.', 'Trong logic, toán tử OR là TRUE khi cả hai đầu vào đều TRUE.', 'true', 'True! In logic, OR is inclusive — it is TRUE when one, the other, or BOTH inputs are TRUE. The only case where OR is FALSE is when BOTH inputs are FALSE.', 'Đúng! Trong logic, OR là bao hàm — TRUE khi một, cái kia, hoặc CẢ HAI đầu vào TRUE. Trường hợp duy nhất OR là FALSE là khi CẢ HAI đầu vào FALSE.', 10, 7);


-- ############################################################################
-- LESSON 23: NUMBER THEORY BASICS (lesson_id = 23)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(6, 'Number Theory Basics', 'Lý Thuyết Số Cơ Bản', 'math-number-theory', 'Primes, divisibility rules, GCD, LCM, and modular arithmetic', 'Số nguyên tố, quy tắc chia hết, ƯCLN, BCNN và số học đồng dư', 'beginner', 30, 4);

-- Usages (IDs 69-71)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(23, 'Identifying prime numbers', 'Nhận biết số nguyên tố', 'A prime number has exactly two factors: 1 and itself. Primes are the building blocks of all integers.', 'Số nguyên tố có đúng hai ước: 1 và chính nó. Số nguyên tố là khối xây dựng của mọi số nguyên.', 'Star', TRUE, 1),
(23, 'Finding GCD and LCM', 'Tìm ƯCLN và BCNN', 'GCD (Greatest Common Divisor) and LCM (Least Common Multiple) solve problems involving shared factors.', 'ƯCLN (Ước Chung Lớn Nhất) và BCNN (Bội Chung Nhỏ Nhất) giải bài toán liên quan đến ước chung.', 'Calculate', TRUE, 2),
(23, 'Using modular arithmetic', 'Sử dụng số học đồng dư', 'The modulo operation (%) gives the remainder after division — used in clocks, encryption, and programming.', 'Phép chia lấy dư (%) cho số dư sau phép chia — dùng trong đồng hồ, mã hóa và lập trình.', 'Schedule', TRUE, 3);

-- Examples for usage 69 (IDs 133-134)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(69, '7 is prime because its only factors are 1 and 7. 9 is NOT prime because 9 = 3 x 3.', '7 là số nguyên tố vì chỉ có ước là 1 và 7. 9 KHÔNG phải nguyên tố vì 9 = 3 x 3.', 'To check if n is prime, test if any number from 2 to the square root of n divides it evenly.', 'Để kiểm tra n có phải nguyên tố, thử xem số nào từ 2 đến căn bậc hai của n chia hết nó.', 'prime', 1),
(69, 'The first 10 primes: 2, 3, 5, 7, 11, 13, 17, 19, 23, 29. Note: 2 is the only even prime.', '10 số nguyên tố đầu: 2, 3, 5, 7, 11, 13, 17, 19, 23, 29. Lưu ý: 2 là số nguyên tố chẵn duy nhất.', 'Every even number greater than 2 is divisible by 2, so it cannot be prime. That makes 2 special — the only even prime.', 'Mọi số chẵn lớn hơn 2 đều chia hết cho 2, nên không thể là nguyên tố. Điều này làm 2 đặc biệt — số nguyên tố chẵn duy nhất.', '2', 2);

-- Examples for usage 70 (IDs 135-136)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(70, 'GCD(12, 18) = 6 because 6 is the largest number that divides both 12 and 18 evenly.', 'ƯCLN(12, 18) = 6 vì 6 là số lớn nhất chia hết cả 12 và 18.', 'List factors: 12 = {1,2,3,4,6,12}, 18 = {1,2,3,6,9,18}. Common factors: {1,2,3,6}. Greatest: 6.', 'Liệt kê ước: 12 = {1,2,3,4,6,12}, 18 = {1,2,3,6,9,18}. Ước chung: {1,2,3,6}. Lớn nhất: 6.', 'GCD', 1),
(70, 'LCM(4, 6) = 12 because 12 is the smallest number divisible by both 4 and 6.', 'BCNN(4, 6) = 12 vì 12 là số nhỏ nhất chia hết cho cả 4 và 6.', 'Multiples of 4: {4,8,12,16...}, multiples of 6: {6,12,18...}. First common multiple: 12.', 'Bội của 4: {4,8,12,16...}, bội của 6: {6,12,18...}. Bội chung đầu tiên: 12.', 'LCM', 2);

-- Examples for usage 71 (IDs 137-138)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(71, '17 mod 5 = 2 because 17 divided by 5 is 3 remainder 2 (5 x 3 + 2 = 17).', '17 mod 5 = 2 vì 17 chia 5 được 3 dư 2 (5 x 3 + 2 = 17).', 'The modulo operation gives the remainder after integer division. It is written as % in most programming languages.', 'Phép modulo cho số dư sau phép chia nguyên. Nó được viết là % trong hầu hết ngôn ngữ lập trình.', 'mod', 1),
(71, 'Clock arithmetic: 10:00 + 5 hours = 3:00 (15 mod 12 = 3). This is modular arithmetic!', 'Số học đồng hồ: 10:00 + 5 giờ = 3:00 (15 mod 12 = 3). Đây là số học đồng dư!', 'A 12-hour clock wraps around using mod 12. Similarly, days of the week use mod 7.', 'Đồng hồ 12 giờ quay vòng dùng mod 12. Tương tự, ngày trong tuần dùng mod 7.', 'mod 12', 2);

-- Tips (IDs 68-70)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(23, '1 is NOT a prime number', '1 KHÔNG phải số nguyên tố', 'A prime number must have EXACTLY two distinct factors. The number 1 only has one factor (itself), so it is not prime. This convention simplifies many theorems in number theory.', 'Số nguyên tố phải có ĐÚNG hai ước phân biệt. Số 1 chỉ có một ước (chính nó), nên không phải nguyên tố. Quy ước này đơn giản hóa nhiều định lý trong lý thuyết số.', 'common_mistake', 'high', 'Warning', 1),
(23, 'Quick divisibility rules', 'Quy tắc chia hết nhanh', 'Divisible by 2: last digit is even. By 3: sum of digits divisible by 3. By 5: ends in 0 or 5. By 9: sum of digits divisible by 9. By 10: ends in 0. Example: 123 → 1+2+3=6 → divisible by 3.', 'Chia hết cho 2: chữ số cuối chẵn. Cho 3: tổng các chữ số chia hết cho 3. Cho 5: tận cùng 0 hoặc 5. Cho 9: tổng các chữ số chia hết cho 9. Cho 10: tận cùng 0. Ví dụ: 123 → 1+2+3=6 → chia hết cho 3.', 'shortcut', 'high', 'Lightbulb', 2),
(23, 'GCD x LCM = product of the two numbers', 'ƯCLN x BCNN = tích hai số', 'For any two positive integers a and b: GCD(a,b) x LCM(a,b) = a x b. Example: GCD(12,18) x LCM(12,18) = 6 x 36 = 216 = 12 x 18. This shortcut lets you find LCM if you know the GCD.', 'Với hai số nguyên dương a và b bất kỳ: ƯCLN(a,b) x BCNN(a,b) = a x b. Ví dụ: ƯCLN(12,18) x BCNN(12,18) = 6 x 36 = 216 = 12 x 18. Mẹo này giúp tìm BCNN nếu biết ƯCLN.', 'shortcut', 'medium', 'Info', 3);

-- Sections (IDs 31-33)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(23, 'markdown', 'Number Theory Essentials', 'Lý Thuyết Số Cần Biết',
'## Prime Numbers

A **prime number** has exactly two factors: 1 and itself.

```
Prime:     2, 3, 5, 7, 11, 13, 17, 19, 23, 29 ...
NOT prime: 1 (only one factor), 4 (= 2x2), 9 (= 3x3)
```

### Divisibility Rules

```
Divisible by 2:  last digit is even (0, 2, 4, 6, 8)
Divisible by 3:  sum of digits divisible by 3
Divisible by 5:  last digit is 0 or 5
Divisible by 9:  sum of digits divisible by 9
Divisible by 10: last digit is 0
```

## GCD and LCM

```
GCD(12, 18):
  Factors of 12: 1, 2, 3, 4, 6, 12
  Factors of 18: 1, 2, 3, 6, 9, 18
  Common: 1, 2, 3, 6
  GCD = 6

LCM(4, 6):
  Multiples of 4: 4, 8, 12, 16, 20 ...
  Multiples of 6: 6, 12, 18, 24 ...
  LCM = 12

Shortcut: GCD(a,b) x LCM(a,b) = a x b
```

## Modular Arithmetic

```
17 mod 5 = 2    (17 = 5 x 3 + 2)
25 mod 7 = 4    (25 = 7 x 3 + 4)
12 mod 4 = 0    (12 = 4 x 3 + 0, divides evenly)

Clock: 10 + 5 = 15 mod 12 = 3 o''clock
```

> **Key insight:** Modular arithmetic "wraps around" — used in clocks, calendars, and encryption.',
'## Số Nguyên Tố

**Số nguyên tố** có đúng hai ước: 1 và chính nó.

```
Nguyên tố:        2, 3, 5, 7, 11, 13, 17, 19, 23, 29 ...
KHÔNG nguyên tố:  1 (chỉ một ước), 4 (= 2x2), 9 (= 3x3)
```

### Quy tắc Chia hết

```
Chia hết cho 2:  chữ số cuối chẵn (0, 2, 4, 6, 8)
Chia hết cho 3:  tổng các chữ số chia hết cho 3
Chia hết cho 5:  chữ số cuối là 0 hoặc 5
Chia hết cho 9:  tổng các chữ số chia hết cho 9
Chia hết cho 10: chữ số cuối là 0
```

## ƯCLN và BCNN

```
ƯCLN(12, 18):
  Ước của 12: 1, 2, 3, 4, 6, 12
  Ước của 18: 1, 2, 3, 6, 9, 18
  Ước chung: 1, 2, 3, 6
  ƯCLN = 6

BCNN(4, 6):
  Bội của 4: 4, 8, 12, 16, 20 ...
  Bội của 6: 6, 12, 18, 24 ...
  BCNN = 12

Mẹo: ƯCLN(a,b) x BCNN(a,b) = a x b
```

## Số học Đồng dư

```
17 mod 5 = 2    (17 = 5 x 3 + 2)
25 mod 7 = 4    (25 = 7 x 3 + 4)
12 mod 4 = 0    (12 = 4 x 3 + 0, chia hết)

Đồng hồ: 10 + 5 = 15 mod 12 = 3 giờ
```

> **Điểm chính:** Số học đồng dư "quay vòng" — dùng trong đồng hồ, lịch và mã hóa.', 1, '{}'),

(23, 'key_points', 'Key Points', 'Điểm chính',
'- **Prime numbers** have exactly 2 factors (1 is NOT prime, 2 is the only even prime)
- **Divisibility rules** provide quick mental checks (by 2, 3, 5, 9, 10)
- **GCD** = greatest common divisor (largest shared factor of two numbers)
- **LCM** = least common multiple (smallest shared multiple of two numbers)
- **Shortcut**: GCD(a,b) x LCM(a,b) = a x b
- **Modular arithmetic**: a mod b = remainder when a is divided by b',
'- **Số nguyên tố** có đúng 2 ước (1 KHÔNG phải nguyên tố, 2 là nguyên tố chẵn duy nhất)
- **Quy tắc chia hết** giúp kiểm tra nhanh trong đầu (cho 2, 3, 5, 9, 10)
- **ƯCLN** = ước chung lớn nhất (ước chung lớn nhất của hai số)
- **BCNN** = bội chung nhỏ nhất (bội chung nhỏ nhất của hai số)
- **Mẹo**: ƯCLN(a,b) x BCNN(a,b) = a x b
- **Số học đồng dư**: a mod b = số dư khi a chia cho b', 2, '{}'),

(23, 'info_box', 'Why Primes Matter', 'Tại sao Số Nguyên Tố Quan Trọng',
'**Primes are the "atoms" of mathematics.** Every integer greater than 1 can be written as a product of primes (this is called the Fundamental Theorem of Arithmetic):

```
12 = 2 x 2 x 3
30 = 2 x 3 x 5
100 = 2 x 2 x 5 x 5
```

**Real-world use:** Internet encryption (HTTPS) relies on the fact that multiplying two large primes is easy, but factoring the result back into primes is extremely hard.',
'**Số nguyên tố là "nguyên tử" của toán học.** Mọi số nguyên lớn hơn 1 đều viết được thành tích các số nguyên tố (gọi là Định lý Cơ bản của Số học):

```
12 = 2 x 2 x 3
30 = 2 x 3 x 5
100 = 2 x 2 x 5 x 5
```

**Ứng dụng thực tế:** Mã hóa internet (HTTPS) dựa trên việc nhân hai số nguyên tố lớn rất dễ, nhưng phân tích ngược kết quả thành số nguyên tố cực kỳ khó.', 3, '{"variant": "info"}');

-- Exercise 155: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(23, 'multiple_choice', 'easy', 'Which of the following is a prime number?', 'Số nào sau đây là số nguyên tố?', 'Choose the number that has exactly two factors: 1 and itself.', 'Chọn số có đúng hai ước: 1 và chính nó.', '17 has exactly two factors (1 and 17), making it prime. 1 has only one factor, 9 = 3x3, and 15 = 3x5.', '17 có đúng hai ước (1 và 17), nên là số nguyên tố. 1 chỉ có một ước, 9 = 3x3, và 15 = 3x5.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(155, 'A', '1', FALSE, '1 has only one factor (itself) — primes need exactly two factors', 1),
(155, 'B', '9', FALSE, '9 = 3 x 3, so it has factors 1, 3, and 9 — not prime', 2),
(155, 'C', '15', FALSE, '15 = 3 x 5, so it has factors 1, 3, 5, and 15 — not prime', 3),
(155, 'D', '17', TRUE, 'Correct! 17 is only divisible by 1 and 17', 4);

-- Exercise 156: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(23, 'fill_blank', 'medium', 'Calculate the GCD.', 'Tính ƯCLN.', 'GCD(24, 36) = ___.', 'ƯCLN(24, 36) = ___.', '12', 'Factors of 24: {1,2,3,4,6,8,12,24}. Factors of 36: {1,2,3,4,6,9,12,18,36}. Common: {1,2,3,4,6,12}. Greatest: 12.', 'Ước của 24: {1,2,3,4,6,8,12,24}. Ước của 36: {1,2,3,4,6,9,12,18,36}. Chung: {1,2,3,4,6,12}. Lớn nhất: 12.', 15, 2);

-- Exercise 157: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(23, 'error_correction', 'medium', 'Fix the incorrect statement about prime numbers.', 'Sửa phát biểu sai về số nguyên tố.', '1 is the smallest prime number.', '1 là số nguyên tố nhỏ nhất.', '2 is the smallest prime number.', '1 is NOT a prime number because it has only one factor (itself). A prime must have exactly two distinct factors. The smallest prime is 2.', '1 KHÔNG phải là số nguyên tố vì chỉ có một ước (chính nó). Số nguyên tố phải có đúng hai ước phân biệt. Số nguyên tố nhỏ nhất là 2.', 'How many factors does the number 1 have?', 'Số 1 có bao nhiêu ước?', 15, 3);

-- Exercise 158: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(23, 'sentence_transform', 'medium', 'Rewrite using the GCD/LCM relationship shortcut.', 'Viết lại dùng mẹo quan hệ ƯCLN/BCNN.', 'Find LCM(8, 12) by listing multiples.', 'Tìm BCNN(8, 12) bằng cách liệt kê bội số.', 'LCM(8, 12) = (8 x 12) / GCD(8, 12) = 96 / 4 = 24', 'Using the shortcut GCD(a,b) x LCM(a,b) = a x b, we get LCM = (a x b) / GCD. GCD(8,12) = 4, so LCM = 96/4 = 24.', 'Dùng mẹo ƯCLN(a,b) x BCNN(a,b) = a x b, ta được BCNN = (a x b) / ƯCLN. ƯCLN(8,12) = 4, vậy BCNN = 96/4 = 24.', 15, 4);

-- Exercise 159: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(23, 'arrange_words', 'easy', 'Arrange these numbers in order from smallest prime to largest prime.', 'Sắp xếp các số nguyên tố từ nhỏ nhất đến lớn nhất.', '["7", "2", "13", "5"]', '2, 5, 7, 13', 'The primes in ascending order: 2, 5, 7, 13. Note that 2 is the smallest prime and the only even prime number.', 'Số nguyên tố tăng dần: 2, 5, 7, 13. Lưu ý 2 là số nguyên tố nhỏ nhất và là số nguyên tố chẵn duy nhất.', 10, 5);

-- Exercise 160: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(23, 'matching', 'easy', 'Match each number theory concept to its result.', 'Nối mỗi khái niệm lý thuyết số với kết quả tương ứng.', 'These calculations demonstrate the core operations in number theory: finding factors, multiples, remainders, and prime factorization.', 'Các phép tính này minh họa các phép toán cốt lõi trong lý thuyết số: tìm ước, bội, số dư và phân tích thừa số nguyên tố.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(160, 'GCD(12, 18)', 'ƯCLN(12, 18)', '6', '6', 1),
(160, 'LCM(4, 6)', 'BCNN(4, 6)', '12', '12', 2),
(160, '17 mod 5', '17 mod 5', '2', '2', 3),
(160, 'Prime factors of 12', 'Thừa số nguyên tố của 12', '2 x 2 x 3', '2 x 2 x 3', 4);

-- Exercise 161: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(23, 'true_false', 'easy', 'Is this statement about number theory correct?', 'Phát biểu này về lý thuyết số có đúng không?', 'Every even number greater than 2 is NOT a prime number.', 'Mọi số chẵn lớn hơn 2 đều KHÔNG phải số nguyên tố.', 'true', 'True! Every even number greater than 2 is divisible by 2 (and also by 1 and itself), so it has at least 3 factors. Since primes need exactly 2 factors, no even number greater than 2 can be prime.', 'Đúng! Mọi số chẵn lớn hơn 2 đều chia hết cho 2 (và cả 1 và chính nó), nên có ít nhất 3 ước. Vì nguyên tố cần đúng 2 ước, không số chẵn nào lớn hơn 2 là nguyên tố.', 10, 7);


-- ############################################################################
-- COMPARISON: Algebra Basics vs Logic & Reasoning (lesson_id_1 = 20, lesson_id_2 = 22)
-- ############################################################################

INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(20, 22, 'Core approach', 'Cách tiếp cận cốt lõi', 'QUANTITATIVE — works with numbers, variables, and equations to find exact values', 'ĐỊNH LƯỢNG — làm việc với số, biến và phương trình để tìm giá trị chính xác', 'QUALITATIVE — works with truth values (TRUE/FALSE) and logical relationships', 'ĐỊNH TÍNH — làm việc với giá trị chân lý (TRUE/FALSE) và quan hệ logic', '2x + 3 = 11, solve for x = 4', '2x + 3 = 11, giải x = 4', 'TRUE AND FALSE = FALSE (evaluate a logical expression)', 'TRUE AND FALSE = FALSE (tính biểu thức logic)', 'Algebra finds "how much" while logic determines "true or false". Both are fundamental tools in mathematics and computer science.', 'Đại số tìm "bao nhiêu" còn logic xác định "đúng hay sai". Cả hai đều là công cụ nền tảng trong toán học và khoa học máy tính.', 1);


-- ############################################################################
-- VERIFICATION QUERIES
-- ############################################################################

-- Verify lesson completeness
SELECT l.id, l.name, l.slug,
  (SELECT COUNT(*) FROM lesson_usage WHERE lesson_id = l.id) AS usages,
  (SELECT COUNT(*) FROM tip WHERE lesson_id = l.id) AS tips,
  (SELECT COUNT(*) FROM lesson_section WHERE lesson_id = l.id) AS sections,
  (SELECT COUNT(*) FROM exercise WHERE lesson_id = l.id) AS exercises
FROM lesson l WHERE l.group_id = 6 ORDER BY l.order_index;
