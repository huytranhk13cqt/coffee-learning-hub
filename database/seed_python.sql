-- ============================================================================
-- SEED DATA: Python Basics (4 lessons)
-- Category: Python Basics (ID 5)
-- Lessons: IDs 16-19
-- Compatible with: schema.sql v6
-- ============================================================================


-- ============================================================================
-- CATEGORY 5: Python Basics
-- ============================================================================

INSERT INTO category (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('Python Basics', 'Python Cơ Bản', 'Learn Python programming fundamentals: variables, control flow, functions, and data structures', 'Học các nền tảng lập trình Python: biến, luồng điều khiển, hàm và cấu trúc dữ liệu', 'Code', '#3b82f6', 5);


-- ############################################################################
-- LESSON 16: VARIABLES & DATA TYPES (lesson_id = 16)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(5, 'Variables & Data Types', 'Biến & Kiểu Dữ Liệu', 'python-variables', 'Store and work with different kinds of data in Python', 'Lưu trữ và làm việc với các loại dữ liệu trong Python', 'beginner', 25, 1);

-- Usages (IDs 48-50)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(16, 'Storing values in variables', 'Lưu giá trị vào biến', 'Use the = operator to assign values to named variables for later use.', 'Sử dụng toán tử = để gán giá trị cho biến có tên để dùng sau.', 'Save', TRUE, 1),
(16, 'Working with numbers', 'Làm việc với số', 'Python supports integers (int) and decimal numbers (float) for calculations.', 'Python hỗ trợ số nguyên (int) và số thập phân (float) để tính toán.', 'Calculate', TRUE, 2),
(16, 'Working with text strings', 'Làm việc với chuỗi văn bản', 'Use quotes to create strings and combine them with + or f-strings.', 'Dùng dấu ngoặc kép để tạo chuỗi và nối chúng bằng + hoặc f-string.', 'TextFields', TRUE, 3);

-- Examples for usage 48 (IDs 91-92)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(48, 'name = "Alice" stores the text Alice in a variable called name.', 'name = "Alice" lưu văn bản Alice vào biến tên là name.', 'The = sign is the assignment operator, not a math equals sign.', 'Dấu = là toán tử gán, không phải dấu bằng toán học.', 'name =', 1),
(48, 'age = 25 creates a variable age holding the integer 25.', 'age = 25 tạo biến age chứa số nguyên 25.', 'Python automatically detects the type (int) — no need to declare it.', 'Python tự động nhận diện kiểu (int) — không cần khai báo.', 'age = 25', 2);

-- Examples for usage 49 (IDs 93-94)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(49, 'price = 19.99 creates a float variable for decimal numbers.', 'price = 19.99 tạo biến float cho số thập phân.', 'Float is short for "floating point" — how computers store decimal numbers.', 'Float viết tắt của "floating point" — cách máy tính lưu số thập phân.', 'float', 1),
(49, 'total = price * 3 multiplies price by 3 and stores the result.', 'total = price * 3 nhân price với 3 và lưu kết quả.', 'Python supports + - * / operators and follows standard math order of operations.', 'Python hỗ trợ toán tử + - * / và tuân theo thứ tự phép tính toán học.', '* 3', 2);

-- Examples for usage 50 (IDs 95-96)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(50, 'greeting = "Hello" + " " + "World" concatenates three strings into one.', 'greeting = "Hello" + " " + "World" nối ba chuỗi thành một.', 'The + operator joins strings together (concatenation).', 'Toán tử + nối các chuỗi lại với nhau (phép nối chuỗi).', '+ operator', 1),
(50, 'f"Hello, {name}!" inserts the variable name directly into the string.', 'f"Hello, {name}!" chèn biến name trực tiếp vào chuỗi.', 'F-strings (formatted string literals) are the modern, readable way to build strings in Python 3.6+.', 'F-string (chuỗi định dạng) là cách hiện đại, dễ đọc để tạo chuỗi trong Python 3.6+.', 'f-string', 2);

-- Tips (IDs 47-49)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(16, 'Python is dynamically typed', 'Python là ngôn ngữ kiểu động', 'You do not need to declare variable types — Python figures it out automatically. x = 5 makes x an int, x = "hello" makes x a str. You can even reassign x to a different type later.', 'Bạn không cần khai báo kiểu biến — Python tự xác định. x = 5 làm x thành int, x = "hello" làm x thành str. Bạn còn có thể gán x sang kiểu khác sau đó.', 'general', 'high', 'Lightbulb', 1),
(16, 'Use descriptive variable names', 'Dùng tên biến mô tả rõ ràng', 'Good: student_name = "Alice", total_price = 99.5. Bad: x = "Alice", t = 99.5. Descriptive names make code readable and self-documenting.', 'Tốt: student_name = "Alice", total_price = 99.5. Xấu: x = "Alice", t = 99.5. Tên mô tả làm code dễ đọc và tự giải thích.', 'common_mistake', 'high', 'Warning', 2),
(16, 'type() reveals the data type', 'type() cho biết kiểu dữ liệu', 'Use type(variable) to check what type a value is: type(42) returns <class ''int''>, type("hi") returns <class ''str''>, type(3.14) returns <class ''float''>.', 'Dùng type(biến) để kiểm tra kiểu: type(42) trả về <class ''int''>, type("hi") trả về <class ''str''>, type(3.14) trả về <class ''float''>.', 'shortcut', 'medium', 'Info', 3);

-- Sections (IDs 10-12)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(16, 'markdown', 'Introduction to Variables', 'Giới thiệu về Biến',
'## Variables in Python

Variables are like **labeled boxes** — you give the box a name and put a value inside.

```python
# Creating variables
name = "Alice"
age = 25
height = 1.65
is_student = True
```

Python has 4 basic data types:

| Type | Example | Description |
|------|---------|-------------|
| `str` | `"Hello"` | Text string |
| `int` | `42` | Whole number |
| `float` | `3.14` | Decimal number |
| `bool` | `True` / `False` | True or False |

```python
# F-string — modern string formatting
name = "Alice"
age = 25
print(f"I am {name}, {age} years old")
# Output: I am Alice, 25 years old
```',
'## Biến trong Python

Biến giống như **hộp có nhãn** — bạn đặt tên cho hộp và bỏ giá trị vào trong.

```python
# Tạo biến
name = "Alice"
age = 25
height = 1.65
is_student = True
```

Python có 4 kiểu dữ liệu cơ bản:

| Kiểu | Ví dụ | Mô tả |
|------|-------|-------|
| `str` | `"Hello"` | Chuỗi văn bản |
| `int` | `42` | Số nguyên |
| `float` | `3.14` | Số thập phân |
| `bool` | `True` / `False` | Đúng hoặc Sai |

```python
# F-string — cách nối chuỗi hiện đại
name = "Alice"
age = 25
print(f"Tôi là {name}, {age} tuổi")
# Output: Tôi là Alice, 25 tuổi
```', 1, '{}'),

(16, 'key_points', 'Key Points', 'Điểm chính',
'- **Variables** store data for reuse: `name = "Alice"`
- Python **auto-detects type** — no need to declare `int` or `str`
- **4 basic types**: `str` (string), `int` (integer), `float` (decimal), `bool` (True/False)
- Use **f-strings** to insert variables into strings: `f"Hello, {name}"`
- Use `type(x)` to check a variable''s data type',
'- **Biến** lưu trữ dữ liệu để dùng lại: `name = "Alice"`
- Python **tự nhận diện kiểu** — không cần khai báo `int` hay `str`
- **4 kiểu cơ bản**: `str` (chuỗi), `int` (số nguyên), `float` (số thập phân), `bool` (True/False)
- Dùng **f-string** để chèn biến vào chuỗi: `f"Hello, {name}"`
- Dùng `type(x)` để kiểm tra kiểu dữ liệu của biến', 2, '{}'),

(16, 'info_box', 'Common Mistake', 'Lỗi thường gặp',
'**Common mistake:** Confusing `=` (assignment) with `==` (comparison)

```python
x = 5      # Assignment: put value 5 into x
x == 5     # Comparison: ask "is x equal to 5?" → True
```

Remember: **1 equals sign =** to assign, **2 equals signs ==** to compare!',
'**Lỗi phổ biến:** Nhầm `=` (gán) với `==` (so sánh)

```python
x = 5      # Gán: đặt giá trị 5 vào x
x == 5     # So sánh: hỏi "x có bằng 5 không?" → True
```

Nhớ: **1 dấu =** để gán, **2 dấu ==** để so sánh!', 3, '{"variant": "warning"}');

-- Exercise 106: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(16, 'multiple_choice', 'easy', 'What is the data type of the value 3.14?', 'Kiểu dữ liệu của giá trị 3.14 là gì?', 'In Python, every value has a type. What type does 3.14 belong to?', 'Trong Python, mỗi giá trị có một kiểu. 3.14 thuộc kiểu nào?', '3.14 is a decimal number, so Python stores it as a float (floating-point number).', '3.14 là số thập phân, nên Python lưu nó dưới dạng float (số dấu phẩy động).', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(106, 'A', 'int', FALSE, 'int is for whole numbers like 42 — 3.14 has a decimal point', 1),
(106, 'B', 'float', TRUE, 'Correct! 3.14 is a decimal (floating-point) number', 2),
(106, 'C', 'str', FALSE, 'str is for text in quotes like "hello" — 3.14 has no quotes', 3),
(106, 'D', 'bool', FALSE, 'bool is only for True or False values', 4);

-- Exercise 107: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(16, 'fill_blank', 'easy', 'Fill in the correct Python keyword.', 'Điền từ khóa Python chính xác.', 'To check the data type of a variable x, use the built-in function ___(x).', 'Để kiểm tra kiểu dữ liệu của biến x, dùng hàm có sẵn ___(x).', 'type', 'The type() function returns the data type of any value or variable in Python.', 'Hàm type() trả về kiểu dữ liệu của bất kỳ giá trị hoặc biến nào trong Python.', 10, 2);

-- Exercise 108: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(16, 'error_correction', 'medium', 'Fix the Python code error.', 'Sửa lỗi code Python.', 'name = Alice', 'name = Alice', 'name = "Alice"', 'String values must be wrapped in quotes. Without quotes, Python thinks Alice is a variable name (which is undefined).', 'Giá trị chuỗi phải được đặt trong dấu ngoặc kép. Không có ngoặc, Python nghĩ Alice là tên biến (chưa được định nghĩa).', 'Text values in Python need to be wrapped in something.', 'Giá trị văn bản trong Python cần được bọc trong thứ gì đó.', 15, 3);

-- Exercise 109: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(16, 'sentence_transform', 'medium', 'Rewrite this string concatenation using an f-string.', 'Viết lại phép nối chuỗi này bằng f-string.', '"Hello, " + name + "! You are " + str(age) + " years old."', '"Hello, " + name + "! You are " + str(age) + " years old."', 'f"Hello, {name}! You are {age} years old."', 'F-strings (f"...{variable}...") are cleaner than concatenation with +. They also automatically convert numbers to strings, so no str() needed.', 'F-string (f"...{biến}...") gọn hơn nối chuỗi bằng +. Chúng cũng tự chuyển số thành chuỗi, không cần str().', 15, 4);

-- Exercise 110: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(16, 'arrange_words', 'easy', 'Arrange these Python data types from simplest to most complex.', 'Sắp xếp các kiểu dữ liệu Python từ đơn giản đến phức tạp nhất.', '["str", "bool", "float", "int"]', 'bool, int, float, str', 'bool is simplest (True/False), int is whole numbers, float adds decimals, str can hold any text of any length — the most complex basic type.', 'bool đơn giản nhất (True/False), int là số nguyên, float thêm số thập phân, str chứa văn bản bất kỳ — kiểu cơ bản phức tạp nhất.', 10, 5);

-- Exercise 111: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(16, 'matching', 'easy', 'Match each value to its Python data type.', 'Nối mỗi giá trị với kiểu dữ liệu Python tương ứng.', 'Python automatically determines the type based on the value: quotes make str, decimals make float, whole numbers make int, True/False make bool.', 'Python tự xác định kiểu dựa trên giá trị: có ngoặc kép là str, có dấu thập phân là float, số nguyên là int, True/False là bool.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(111, '"Hello World"', '"Hello World"', 'str', 'str (chuỗi)', 1),
(111, '42', '42', 'int', 'int (số nguyên)', 2),
(111, '3.14', '3.14', 'float', 'float (số thập phân)', 3),
(111, 'True', 'True', 'bool', 'bool (logic)', 4);

-- Exercise 112: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(16, 'true_false', 'easy', 'Is this statement about Python correct?', 'Phát biểu này về Python có đúng không?', 'In Python, you must declare the type of a variable before using it (e.g., int x = 5).', 'Trong Python, bạn phải khai báo kiểu biến trước khi dùng (ví dụ: int x = 5).', 'false', 'False! Python is dynamically typed — you just write x = 5 and Python figures out the type automatically. Languages like Java and C require type declarations, but Python does not.', 'Sai! Python là ngôn ngữ kiểu động — bạn chỉ cần viết x = 5 và Python tự nhận kiểu. Các ngôn ngữ như Java và C yêu cầu khai báo kiểu, nhưng Python thì không.', 5, 7);


-- ############################################################################
-- LESSON 17: CONTROL FLOW (lesson_id = 17)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(5, 'Control Flow', 'Luồng Điều Khiển', 'python-control-flow', 'Make decisions in your code with if, elif, and else', 'Ra quyết định trong code với if, elif và else', 'beginner', 30, 2);

-- Usages (IDs 51-53)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(17, 'Making decisions with if', 'Ra quyết định với if', 'Use if statements to run code only when a condition is True.', 'Dùng câu lệnh if để chạy code chỉ khi điều kiện là True.', 'CallSplit', TRUE, 1),
(17, 'Handling alternatives with else', 'Xử lý trường hợp khác với else', 'Use else to define what happens when the if condition is False.', 'Dùng else để định nghĩa điều xảy ra khi điều kiện if là False.', 'AltRoute', TRUE, 2),
(17, 'Multiple conditions with elif', 'Nhiều điều kiện với elif', 'Use elif (else if) to check multiple conditions in sequence.', 'Dùng elif (else if) để kiểm tra nhiều điều kiện theo thứ tự.', 'AccountTree', TRUE, 3);

-- Examples for usage 51 (IDs 97-98)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(51, 'if age >= 18: print("You can vote") runs the print only if age is 18 or more.', 'if age >= 18: print("Bạn có thể bỏ phiếu") chỉ chạy print khi age từ 18 trở lên.', 'The code inside the if block only executes when the condition evaluates to True.', 'Code bên trong khối if chỉ chạy khi điều kiện đánh giá là True.', 'if age >= 18', 1),
(51, 'if temperature > 30: print("It is hot!") checks if the temperature exceeds 30.', 'if temperature > 30: print("Trời nóng!") kiểm tra nhiệt độ có vượt 30 không.', 'Comparison operators (>, <, >=, <=, ==, !=) return True or False.', 'Toán tử so sánh (>, <, >=, <=, ==, !=) trả về True hoặc False.', 'temperature > 30', 2);

-- Examples for usage 52 (IDs 99-100)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(52, 'if score >= 50: print("Pass") else: print("Fail") handles both outcomes.', 'if score >= 50: print("Đậu") else: print("Rớt") xử lý cả hai trường hợp.', 'else catches everything that the if condition did not match.', 'else bắt mọi thứ mà điều kiện if không khớp.', 'else', 1),
(52, 'if is_raining: take_umbrella() else: wear_sunglasses() — only one branch runs.', 'if is_raining: take_umbrella() else: wear_sunglasses() — chỉ một nhánh chạy.', 'Python guarantees exactly one branch executes — either if or else, never both.', 'Python đảm bảo chính xác một nhánh chạy — hoặc if hoặc else, không bao giờ cả hai.', 'one branch', 2);

-- Examples for usage 53 (IDs 101-102)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(53, 'if score >= 90: grade = "A" elif score >= 80: grade = "B" elif score >= 70: grade = "C" else: grade = "F"', 'if score >= 90: grade = "A" elif score >= 80: grade = "B" elif score >= 70: grade = "C" else: grade = "F"', 'elif lets you chain multiple conditions — Python checks them top to bottom, using the first True match.', 'elif cho phép nối nhiều điều kiện — Python kiểm tra từ trên xuống, dùng kết quả True đầu tiên.', 'elif', 1),
(53, 'You can have as many elif blocks as needed, but only one if and one optional else.', 'Bạn có thể có bao nhiêu elif tùy ý, nhưng chỉ một if và một else tùy chọn.', 'The structure is always: if (required) → elif (0 or more) → else (optional).', 'Cấu trúc luôn là: if (bắt buộc) → elif (0 hoặc nhiều) → else (tùy chọn).', 'structure', 2);

-- Tips (IDs 50-52)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(17, 'Indentation matters in Python', 'Thụt lề quan trọng trong Python', 'Unlike most languages that use braces { }, Python uses INDENTATION (4 spaces) to define code blocks. If your indentation is wrong, Python will raise an IndentationError.', 'Khác với hầu hết ngôn ngữ dùng dấu { }, Python dùng THỤT LỀ (4 dấu cách) để xác định khối code. Nếu thụt lề sai, Python sẽ báo IndentationError.', 'common_mistake', 'high', 'Warning', 1),
(17, 'Use comparison operators correctly', 'Dùng toán tử so sánh đúng cách', 'Remember: == (equals), != (not equals), > (greater), < (less), >= (greater or equal), <= (less or equal). Common mistake: using = (assignment) instead of == (comparison) in if statements.', 'Nhớ: == (bằng), != (khác), > (lớn hơn), < (nhỏ hơn), >= (lớn hơn hoặc bằng), <= (nhỏ hơn hoặc bằng). Lỗi phổ biến: dùng = (gán) thay vì == (so sánh) trong if.', 'common_mistake', 'high', 'Lightbulb', 2),
(17, 'Combine conditions with and/or', 'Kết hợp điều kiện với and/or', 'Use "and" when BOTH conditions must be True: if age >= 18 and has_id: ... Use "or" when EITHER condition can be True: if is_weekend or is_holiday: ...', 'Dùng "and" khi CẢ HAI điều kiện phải True: if age >= 18 and has_id: ... Dùng "or" khi MỘT TRONG HAI có thể True: if is_weekend or is_holiday: ...', 'shortcut', 'medium', 'AutoAwesome', 3);

-- Sections (IDs 13-15)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(17, 'markdown', 'Control Flow with if/elif/else', 'Luồng điều khiển với if/elif/else',
'## Conditional Statements

The `if` statement lets code **make decisions** based on conditions.

```python
age = 20

if age >= 18:
    print("You are an adult")
else:
    print("You are a child")
```

### Multiple conditions with elif

```python
score = 85

if score >= 90:
    grade = "A"
elif score >= 80:
    grade = "B"
elif score >= 70:
    grade = "C"
else:
    grade = "F"

print(f"Your grade: {grade}")
# Output: Your grade: B
```

### Combining conditions

```python
age = 25
has_license = True

if age >= 18 and has_license:
    print("You may drive")
```

> **Note:** Python uses **4-space indentation** instead of `{ }` braces to define code blocks.',
'## Câu lệnh điều kiện

Câu lệnh `if` cho phép code **ra quyết định** dựa trên điều kiện.

```python
age = 20

if age >= 18:
    print("Bạn là người lớn")
else:
    print("Bạn là trẻ em")
```

### Nhiều điều kiện với elif

```python
score = 85

if score >= 90:
    grade = "A"
elif score >= 80:
    grade = "B"
elif score >= 70:
    grade = "C"
else:
    grade = "F"

print(f"Điểm của bạn: {grade}")
# Output: Điểm của bạn: B
```

### Kết hợp điều kiện

```python
age = 25
has_license = True

if age >= 18 and has_license:
    print("Bạn được phép lái xe")
```

> **Lưu ý:** Python dùng **thụt lề 4 dấu cách** thay vì dấu `{ }` để đánh dấu khối code.', 1, '{}'),

(17, 'key_points', 'Key Points', 'Điểm chính',
'- `if` checks a condition — runs the code inside if the condition is `True`
- `else` runs when the `if` condition is `False` — always the last resort
- `elif` (else if) allows checking **multiple conditions** in order
- Python checks top to bottom, runs the **first True branch** then skips the rest
- Use `and` / `or` to combine multiple conditions in one statement
- **4-space indentation** is REQUIRED — this is how Python identifies code blocks',
'- `if` kiểm tra điều kiện — chạy code bên trong nếu điều kiện là `True`
- `else` chạy khi điều kiện `if` là `False` — luôn là phương án cuối cùng
- `elif` (else if) cho phép kiểm tra **nhiều điều kiện** theo thứ tự
- Python kiểm tra từ trên xuống, chạy **nhánh True đầu tiên** rồi bỏ qua phần còn lại
- Dùng `and` / `or` để kết hợp nhiều điều kiện trong một câu lệnh
- **Thụt lề 4 dấu cách** là BẮT BUỘC — đây là cách Python nhận biết khối code', 2, '{}'),

(17, 'info_box', 'Debugging Tip', 'Mẹo gỡ lỗi',
'**IndentationError** is the most common error when learning Python:

```python
# WRONG — missing indentation
if age >= 18:
print("Hello")   # IndentationError!

# CORRECT — indented 4 spaces
if age >= 18:
    print("Hello")
```

Always use **4 spaces** (not Tab) and check indentation when you get errors.',
'**IndentationError** là lỗi phổ biến nhất khi mới học Python:

```python
# SAI — thiếu thụt lề
if age >= 18:
print("Hello")   # IndentationError!

# ĐÚNG — thụt 4 dấu cách
if age >= 18:
    print("Hello")
```

Luôn dùng **4 dấu cách** (không dùng Tab) và kiểm tra thụt lề khi gặp lỗi.', 3, '{"variant": "tip"}');

-- Exercise 113: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(17, 'multiple_choice', 'easy', 'What will this code print?', 'Code này sẽ in ra gì?', 'x = 10\nif x > 5:\n    print("big")\nelse:\n    print("small")', 'x = 10\nif x > 5:\n    print("big")\nelse:\n    print("small")', 'Since x is 10 and 10 > 5 is True, the if block executes and prints "big". The else block is skipped.', 'Vì x là 10 và 10 > 5 là True, khối if chạy và in "big". Khối else bị bỏ qua.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(113, 'A', 'big', TRUE, 'Correct! 10 > 5 is True, so the if branch runs', 1),
(113, 'B', 'small', FALSE, 'The else branch only runs when the if condition is False', 2),
(113, 'C', 'big small', FALSE, 'Only one branch runs — either if or else, never both', 3),
(113, 'D', 'Error', FALSE, 'This is valid Python code with correct syntax and indentation', 4);

-- Exercise 114: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(17, 'fill_blank', 'easy', 'Fill in the Python keyword.', 'Điền từ khóa Python.', 'In Python, ___ is used to check an additional condition after an if statement fails.', 'Trong Python, ___ dùng để kiểm tra thêm một điều kiện sau khi câu lệnh if không đúng.', 'elif', 'elif (short for "else if") lets you check multiple conditions in sequence. It must come after an if and before an optional else.', 'elif (viết tắt của "else if") cho phép kiểm tra nhiều điều kiện theo thứ tự. Nó phải đặt sau if và trước else (tùy chọn).', 10, 2);

-- Exercise 115: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(17, 'error_correction', 'medium', 'Fix the Python code error.', 'Sửa lỗi code Python.', 'if score = 100:', 'if score = 100:', 'if score == 100:', 'In Python, = is the assignment operator and == is the comparison operator. Inside an if statement, you need == to compare values.', 'Trong Python, = là toán tử gán và == là toán tử so sánh. Bên trong câu lệnh if, bạn cần == để so sánh giá trị.', 'Think about the difference between assigning and comparing.', 'Hãy nghĩ về sự khác biệt giữa gán và so sánh.', 15, 3);

-- Exercise 116: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(17, 'sentence_transform', 'medium', 'Rewrite using elif instead of nested if statements.', 'Viết lại dùng elif thay vì if lồng nhau.', 'if x > 0: print("positive") else: if x < 0: print("negative") else: print("zero")', 'if x > 0: print("positive") else: if x < 0: print("negative") else: print("zero")', 'if x > 0: print("positive") elif x < 0: print("negative") else: print("zero")', 'elif replaces the else: if pattern, making the code flatter and more readable. Both versions produce the same result, but elif is the Pythonic way.', 'elif thay thế mẫu else: if, làm code phẳng và dễ đọc hơn. Cả hai cho cùng kết quả, nhưng elif là cách Python.', 15, 4);

-- Exercise 117: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(17, 'arrange_words', 'easy', 'Arrange the parts of an if/elif/else statement in the correct order.', 'Sắp xếp các phần của câu lệnh if/elif/else theo đúng thứ tự.', '["else:", "elif condition2:", "if condition1:", "elif condition3:"]', 'if condition1:, elif condition2:, elif condition3:, else:', 'The correct order is always: if first (required), then any number of elif blocks, then else last (optional). Python checks conditions from top to bottom.', 'Thứ tự luôn là: if đầu tiên (bắt buộc), rồi bao nhiêu elif tùy ý, rồi else cuối (tùy chọn). Python kiểm tra điều kiện từ trên xuống.', 10, 5);

-- Exercise 118: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(17, 'matching', 'easy', 'Match each Python comparison operator to its meaning.', 'Nối mỗi toán tử so sánh Python với ý nghĩa của nó.', 'These comparison operators return True or False and are used inside if/elif conditions to make decisions.', 'Các toán tử so sánh trả về True hoặc False và được dùng trong điều kiện if/elif để ra quyết định.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(118, '==', '==', 'Equal to', 'Bằng', 1),
(118, '!=', '!=', 'Not equal to', 'Khác', 2),
(118, '>=', '>=', 'Greater than or equal', 'Lớn hơn hoặc bằng', 3),
(118, 'and', 'and', 'Both conditions must be True', 'Cả hai điều kiện phải True', 4);

-- Exercise 119: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(17, 'true_false', 'easy', 'Is this statement about Python correct?', 'Phát biểu này về Python có đúng không?', 'In Python, indentation (spaces at the beginning of a line) is just for readability and does not affect how the code runs.', 'Trong Python, thụt lề (dấu cách ở đầu dòng) chỉ để dễ đọc và không ảnh hưởng đến cách code chạy.', 'false', 'False! In Python, indentation is REQUIRED and determines code structure. Wrong indentation causes IndentationError. This is unlike languages like Java or JavaScript where indentation is optional.', 'Sai! Trong Python, thụt lề là BẮT BUỘC và quyết định cấu trúc code. Thụt lề sai gây IndentationError. Điều này khác với Java hay JavaScript nơi thụt lề là tùy chọn.', 5, 7);


-- ############################################################################
-- LESSON 18: FUNCTIONS (lesson_id = 18)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(5, 'Functions', 'Hàm', 'python-functions', 'Create reusable blocks of code with def, parameters, and return', 'Tạo khối code tái sử dụng với def, tham số và return', 'intermediate', 35, 3);

-- Usages (IDs 54-56)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(18, 'Defining and calling functions', 'Định nghĩa và gọi hàm', 'Use def to create a function, then call it by name with parentheses.', 'Dùng def để tạo hàm, rồi gọi nó bằng tên với dấu ngoặc tròn.', 'Functions', TRUE, 1),
(18, 'Using parameters and arguments', 'Dùng tham số và đối số', 'Functions can accept input values (parameters) to work with different data each time.', 'Hàm có thể nhận giá trị đầu vào (tham số) để làm việc với dữ liệu khác nhau mỗi lần.', 'Input', TRUE, 2),
(18, 'Returning values', 'Trả về giá trị', 'Use return to send a result back from the function to the caller.', 'Dùng return để gửi kết quả từ hàm về nơi gọi.', 'Output', TRUE, 3);

-- Examples for usage 54 (IDs 103-104)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(54, 'def greet(): print("Hello!") defines a function; greet() calls it.', 'def greet(): print("Hello!") định nghĩa hàm; greet() gọi nó.', 'def creates the function, but code inside only runs when you call the function with ().', 'def tạo hàm, nhưng code bên trong chỉ chạy khi bạn gọi hàm với ().', 'def', 1),
(54, 'Functions let you write code once and reuse it anywhere in your program.', 'Hàm cho phép viết code một lần và dùng lại ở bất kỳ đâu trong chương trình.', 'The DRY principle: Don''t Repeat Yourself. Functions are the primary tool for avoiding code duplication.', 'Nguyên tắc DRY: Đừng Lặp Lại. Hàm là công cụ chính để tránh trùng lặp code.', 'reuse', 2);

-- Examples for usage 55 (IDs 105-106)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(55, 'def greet(name): print(f"Hello, {name}!") — name is a parameter that receives a value.', 'def greet(name): print(f"Hello, {name}!") — name là tham số nhận giá trị.', 'Parameters are defined in the function definition; arguments are the actual values passed when calling.', 'Tham số được định nghĩa khi tạo hàm; đối số là giá trị thực được truyền khi gọi.', 'parameter', 1),
(55, 'def add(a, b): return a + b — a and b are two parameters; add(3, 5) returns 8.', 'def add(a, b): return a + b — a và b là hai tham số; add(3, 5) trả về 8.', 'Functions can accept multiple parameters separated by commas.', 'Hàm có thể nhận nhiều tham số phân cách bằng dấu phẩy.', 'a, b', 2);

-- Examples for usage 56 (IDs 107-108)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(56, 'def square(n): return n * n — return sends n*n back to where the function was called.', 'def square(n): return n * n — return gửi n*n về nơi hàm được gọi.', 'Without return, a function returns None by default.', 'Không có return, hàm trả về None theo mặc định.', 'return', 1),
(56, 'result = square(4) stores the return value 16 in the variable result.', 'result = square(4) lưu giá trị trả về 16 vào biến result.', 'You can store the return value in a variable or use it directly in expressions.', 'Bạn có thể lưu giá trị trả về vào biến hoặc dùng trực tiếp trong biểu thức.', 'result =', 2);

-- Tips (IDs 53-55)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(18, 'Define before you call', 'Định nghĩa trước khi gọi', 'A function must be defined (with def) BEFORE it is called. If you call a function before defining it, Python raises a NameError. This is because Python reads code from top to bottom.', 'Hàm phải được định nghĩa (với def) TRƯỚC khi gọi. Nếu gọi hàm trước khi định nghĩa, Python báo NameError. Vì Python đọc code từ trên xuống dưới.', 'common_mistake', 'high', 'Warning', 1),
(18, 'return vs print', 'return vs print', 'print() shows text on screen but the value is GONE after that. return sends the value back so you can use it later: result = my_function(). If you need to use the output of a function, always use return.', 'print() hiển thị văn bản lên màn hình nhưng giá trị BIẾN MẤT sau đó. return gửi giá trị về để dùng sau: result = my_function(). Nếu cần dùng đầu ra của hàm, luôn dùng return.', 'common_mistake', 'high', 'Lightbulb', 2),
(18, 'Default parameter values', 'Giá trị tham số mặc định', 'You can set default values: def greet(name="World"): print(f"Hello, {name}!"). Calling greet() uses the default "World", while greet("Alice") overrides it with "Alice".', 'Bạn có thể đặt giá trị mặc định: def greet(name="World"): print(f"Hello, {name}!"). Gọi greet() dùng mặc định "World", còn greet("Alice") ghi đè bằng "Alice".', 'shortcut', 'medium', 'AutoAwesome', 3);

-- Sections (IDs 16-18)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(18, 'markdown', 'Functions in Python', 'Hàm trong Python',
'## Creating and Using Functions

Functions are **named blocks of code** that you can call multiple times.

```python
# Define a function
def greet(name):
    return f"Hello, {name}!"

# Call the function
message = greet("Alice")
print(message)  # Hello, Alice!
```

### Functions with multiple parameters

```python
def calculate_area(width, height):
    area = width * height
    return area

result = calculate_area(5, 3)
print(f"Area: {result}")  # Area: 15
```

### Default values

```python
def greet(name, greeting="Hello"):
    return f"{greeting}, {name}!"

print(greet("Alice"))           # Hello, Alice!
print(greet("Bob", "Hi"))       # Hi, Bob!
```

> **Remember:** `def` creates the function, `return` sends back the result. Without `return`, a function returns `None`.',
'## Tạo và sử dụng hàm

Hàm là **khối code có tên** mà bạn có thể gọi lại nhiều lần.

```python
# Định nghĩa hàm
def greet(name):
    return f"Xin chào, {name}!"

# Gọi hàm
message = greet("Alice")
print(message)  # Xin chào, Alice!
```

### Hàm với nhiều tham số

```python
def calculate_area(width, height):
    area = width * height
    return area

result = calculate_area(5, 3)
print(f"Diện tích: {result}")  # Diện tích: 15
```

### Giá trị mặc định

```python
def greet(name, greeting="Xin chào"):
    return f"{greeting}, {name}!"

print(greet("Alice"))           # Xin chào, Alice!
print(greet("Bob", "Chào"))     # Chào, Bob!
```

> **Nhớ:** `def` tạo hàm, `return` trả về kết quả. Không có `return`, hàm trả về `None`.', 1, '{}'),

(18, 'key_points', 'Key Points', 'Điểm chính',
'- **`def`** defines a function: `def function_name(parameter):`
- **Call a function** by name + parentheses: `function_name(argument)`
- **Parameters** receive input values, **`return`** sends the result out
- Without `return` → function returns `None`
- Use **default values** for optional parameters: `def f(x=10)`
- Functions enable **code reuse** (DRY principle: Don''t Repeat Yourself)',
'- **`def`** định nghĩa hàm: `def tên_hàm(tham_số):`
- **Gọi hàm** bằng tên + ngoặc tròn: `tên_hàm(đối_số)`
- **Tham số** nhận giá trị đầu vào, **`return`** gửi kết quả ra
- Không có `return` → hàm trả về `None`
- Dùng **giá trị mặc định** cho tham số tùy chọn: `def f(x=10)`
- Hàm giúp **tái sử dụng code** (nguyên tắc DRY: Don''t Repeat Yourself)', 2, '{}'),

(18, 'info_box', 'Return vs Print', 'Return vs Print',
'**The most important distinction for beginners:**

```python
# print() — displays then GONE
def add_print(a, b):
    print(a + b)

result = add_print(3, 5)  # Prints: 8
print(result)              # Prints: None (!)

# return — sends value BACK for reuse
def add_return(a, b):
    return a + b

result = add_return(3, 5)  # Prints nothing
print(result)               # Prints: 8
```

**Rule:** If you need to **use the result** later → use `return`. If you just need to **display** it → use `print`.',
'**Sự khác biệt quan trọng nhất cho người mới:**

```python
# print() — hiển thị rồi BIẾN MẤT
def add_print(a, b):
    print(a + b)

result = add_print(3, 5)  # In: 8
print(result)              # In: None (!)

# return — gửi giá trị VỀ để dùng tiếp
def add_return(a, b):
    return a + b

result = add_return(3, 5)  # Không in gì
print(result)               # In: 8
```

**Quy tắc:** Nếu cần **dùng kết quả** sau đó → dùng `return`. Nếu chỉ cần **hiển thị** → dùng `print`.', 3, '{"variant": "warning"}');

-- Exercise 120: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(18, 'multiple_choice', 'easy', 'What does this function return?', 'Hàm này trả về gì?', 'def double(n):\n    return n * 2\n\nresult = double(5)', 'def double(n):\n    return n * 2\n\nresult = double(5)', 'double(5) passes 5 as the parameter n. Inside the function, n * 2 = 10, which is returned and stored in result.', 'double(5) truyền 5 làm tham số n. Bên trong hàm, n * 2 = 10, được trả về và lưu vào result.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(120, 'A', '5', FALSE, '5 is the input — the function multiplies it by 2', 1),
(120, 'B', '10', TRUE, 'Correct! 5 * 2 = 10 is returned', 2),
(120, 'C', 'None', FALSE, 'The function has a return statement, so it does not return None', 3),
(120, 'D', 'Error', FALSE, 'This is valid Python code with correct syntax', 4);

-- Exercise 121: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(18, 'fill_blank', 'easy', 'Fill in the Python keyword.', 'Điền từ khóa Python.', 'To create a new function in Python, use the ___ keyword followed by the function name and parentheses.', 'Để tạo hàm mới trong Python, dùng từ khóa ___ theo sau là tên hàm và dấu ngoặc tròn.', 'def', 'The def keyword (short for "define") is used to create functions in Python. Example: def my_function():...', 'Từ khóa def (viết tắt của "define") dùng để tạo hàm trong Python. Ví dụ: def my_function():...', 10, 2);

-- Exercise 122: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(18, 'error_correction', 'medium', 'Fix the Python code error.', 'Sửa lỗi code Python.', 'def greet(name)\n    return f"Hello, {name}!"', 'def greet(name)\n    return f"Hello, {name}!"', 'def greet(name):\n    return f"Hello, {name}!"', 'The function definition is missing a colon (:) at the end. In Python, every def line, if, elif, else, for, and while must end with a colon.', 'Định nghĩa hàm thiếu dấu hai chấm (:) ở cuối. Trong Python, mỗi dòng def, if, elif, else, for và while phải kết thúc bằng dấu hai chấm.', 'What punctuation mark is missing at the end of the first line?', 'Dấu câu nào bị thiếu ở cuối dòng đầu tiên?', 15, 3);

-- Exercise 123: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(18, 'sentence_transform', 'medium', 'Convert this repeated code into a function call.', 'Chuyển code lặp lại thành lời gọi hàm.', 'area1 = 5 * 3\narea2 = 7 * 4\narea3 = 10 * 6', 'area1 = 5 * 3\narea2 = 7 * 4\narea3 = 10 * 6', 'def area(w, h): return w * h', 'Creating a function area(w, h) eliminates the repeated pattern of width * height. You can then call area(5, 3), area(7, 4), area(10, 6).', 'Tạo hàm area(w, h) loại bỏ mẫu lặp chiều_rộng * chiều_cao. Sau đó gọi area(5, 3), area(7, 4), area(10, 6).', 15, 4);

-- Exercise 124: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(18, 'arrange_words', 'easy', 'Arrange the parts of a Python function in the correct order.', 'Sắp xếp các phần của hàm Python theo đúng thứ tự.', '["return result", "result = a + b", "def add(a, b):", "print(add(3, 5))"]', 'def add(a, b):, result = a + b, return result, print(add(3, 5))', 'A function must be: defined (def), execute its body (compute), return the result, then be called. The function call comes AFTER the definition.', 'Hàm phải: định nghĩa (def), thực thi thân (tính toán), trả về kết quả, rồi được gọi. Lời gọi hàm đặt SAU định nghĩa.', 10, 5);

-- Exercise 125: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(18, 'matching', 'medium', 'Match each function concept to its description.', 'Nối mỗi khái niệm hàm với mô tả tương ứng.', 'Understanding the distinction between parameters (definition), arguments (call), return values (output), and function body (logic) is key to writing clean functions.', 'Hiểu sự khác biệt giữa tham số (định nghĩa), đối số (gọi), giá trị trả về (đầu ra) và thân hàm (logic) là chìa khóa để viết hàm sạch.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(125, 'def', 'def', 'Defines a new function', 'Định nghĩa hàm mới', 1),
(125, 'return', 'return', 'Sends a value back to the caller', 'Gửi giá trị về nơi gọi', 2),
(125, 'Parameter', 'Tham số', 'Variable in function definition', 'Biến trong định nghĩa hàm', 3),
(125, 'Argument', 'Đối số', 'Value passed when calling function', 'Giá trị truyền khi gọi hàm', 4);

-- Exercise 126: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(18, 'true_false', 'easy', 'Is this statement about Python functions correct?', 'Phát biểu này về hàm Python có đúng không?', 'A Python function without a return statement returns None.', 'Hàm Python không có câu lệnh return sẽ trả về None.', 'true', 'True! If a function does not explicitly return a value, Python returns None by default. This is why print() inside a function shows output but the function itself returns None.', 'Đúng! Nếu hàm không trả về giá trị rõ ràng, Python trả về None mặc định. Đây là lý do print() trong hàm hiển thị kết quả nhưng hàm trả về None.', 5, 7);


-- ############################################################################
-- LESSON 19: LISTS & LOOPS (lesson_id = 19)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(5, 'Lists & Loops', 'Danh Sách & Vòng Lặp', 'python-lists-loops', 'Store collections of data and process them with for and while loops', 'Lưu trữ tập hợp dữ liệu và xử lý chúng bằng vòng lặp for và while', 'beginner', 30, 4);

-- Usages (IDs 57-59)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(19, 'Creating and accessing lists', 'Tạo và truy cập danh sách', 'Use square brackets to create lists and index numbers to access individual items.', 'Dùng dấu ngoặc vuông để tạo danh sách và số chỉ mục để truy cập từng phần tử.', 'List', TRUE, 1),
(19, 'Iterating with for loops', 'Lặp với vòng for', 'Use for to process each item in a list one at a time.', 'Dùng for để xử lý từng phần tử trong danh sách, mỗi lần một phần tử.', 'Loop', TRUE, 2),
(19, 'Modifying lists', 'Chỉnh sửa danh sách', 'Add, remove, and change items in a list using built-in methods.', 'Thêm, xóa và thay đổi phần tử trong danh sách bằng các phương thức có sẵn.', 'Edit', TRUE, 3);

-- Examples for usage 57 (IDs 109-110)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(57, 'fruits = ["apple", "banana", "cherry"] creates a list of three strings.', 'fruits = ["apple", "banana", "cherry"] tạo danh sách ba chuỗi.', 'Lists use square brackets [] and items are separated by commas.', 'Danh sách dùng dấu ngoặc vuông [] và các phần tử phân cách bằng dấu phẩy.', '["apple", "banana", "cherry"]', 1),
(57, 'fruits[0] returns "apple" — list indexing starts at 0, not 1.', 'fruits[0] trả về "apple" — chỉ mục danh sách bắt đầu từ 0, không phải 1.', 'Index 0 = first item, index 1 = second item, index -1 = last item.', 'Chỉ mục 0 = phần tử đầu, chỉ mục 1 = phần tử thứ 2, chỉ mục -1 = phần tử cuối.', '[0]', 2);

-- Examples for usage 58 (IDs 111-112)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(58, 'for fruit in fruits: print(fruit) prints each fruit on a new line.', 'for fruit in fruits: print(fruit) in mỗi trái cây trên một dòng mới.', 'The for loop automatically iterates through each item — no index needed.', 'Vòng lặp for tự động lặp qua từng phần tử — không cần chỉ mục.', 'for ... in', 1),
(58, 'for i in range(5): print(i) prints numbers 0, 1, 2, 3, 4.', 'for i in range(5): print(i) in các số 0, 1, 2, 3, 4.', 'range(n) generates numbers from 0 to n-1. It is commonly used with for loops for counting.', 'range(n) tạo các số từ 0 đến n-1. Nó thường dùng với for để đếm.', 'range(5)', 2);

-- Examples for usage 59 (IDs 113-114)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(59, 'fruits.append("mango") adds "mango" to the end of the list.', 'fruits.append("mango") thêm "mango" vào cuối danh sách.', 'append() always adds to the END of the list. It modifies the list in place.', 'append() luôn thêm vào CUỐI danh sách. Nó thay đổi trực tiếp danh sách.', 'append()', 1),
(59, 'fruits.remove("banana") removes the first occurrence of "banana".', 'fruits.remove("banana") xóa lần xuất hiện đầu tiên của "banana".', 'remove() deletes by VALUE (not index). If the value is not found, it raises a ValueError.', 'remove() xóa theo GIÁ TRỊ (không phải chỉ mục). Nếu không tìm thấy, nó báo ValueError.', 'remove()', 2);

-- Tips (IDs 56-58)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(19, 'Lists start at index 0', 'Danh sách bắt đầu từ chỉ mục 0', 'The first item is fruits[0], the second is fruits[1], etc. This is called "zero-based indexing" and is used by most programming languages. Use fruits[-1] to get the LAST item.', 'Phần tử đầu là fruits[0], thứ hai là fruits[1], v.v. Đây gọi là "đánh chỉ mục từ 0" và hầu hết ngôn ngữ lập trình đều dùng. Dùng fruits[-1] để lấy phần tử CUỐI.', 'common_mistake', 'high', 'Warning', 1),
(19, 'for vs while loops', 'Vòng lặp for vs while', 'Use FOR when you know how many times to loop (or iterating a list). Use WHILE when you want to loop until a condition becomes False. Most Python code uses for loops — they are safer because they always terminate.', 'Dùng FOR khi biết số lần lặp (hoặc lặp qua danh sách). Dùng WHILE khi muốn lặp cho đến khi điều kiện False. Hầu hết code Python dùng for — chúng an toàn hơn vì luôn kết thúc.', 'comparison', 'high', 'Lightbulb', 2),
(19, 'len() tells you the list size', 'len() cho biết kích thước danh sách', 'len(fruits) returns the number of items in the list. This is useful for loops, conditions, and checking if a list is empty: if len(my_list) == 0: print("List is empty").', 'len(fruits) trả về số phần tử trong danh sách. Hữu ích cho vòng lặp, điều kiện, và kiểm tra rỗng: if len(my_list) == 0: print("Danh sách rỗng").', 'shortcut', 'medium', 'Info', 3);

-- Sections (IDs 19-21)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(19, 'markdown', 'Lists and Loops', 'Danh sách và Vòng lặp',
'## Lists

Lists store **multiple values** in a single variable:

```python
# Creating lists
fruits = ["apple", "banana", "cherry"]
numbers = [1, 2, 3, 4, 5]
mixed = ["hello", 42, True, 3.14]

# Accessing elements (starts at 0)
print(fruits[0])   # apple
print(fruits[-1])  # cherry (last element)
```

## For Loops

```python
# Iterate through a list
for fruit in fruits:
    print(f"I like {fruit}")

# Iterate with range()
for i in range(3):
    print(f"Round {i}")
# Output: Round 0, Round 1, Round 2
```

## List Operations

```python
fruits = ["apple", "banana"]

fruits.append("cherry")    # Add to end
fruits.remove("banana")    # Remove by value
print(len(fruits))         # 2 (size)
print(fruits)              # ["apple", "cherry"]
```',
'## Danh sách (List)

Danh sách lưu trữ **nhiều giá trị** trong một biến:

```python
# Tạo danh sách
fruits = ["apple", "banana", "cherry"]
numbers = [1, 2, 3, 4, 5]
mixed = ["hello", 42, True, 3.14]

# Truy cập phần tử (bắt đầu từ 0)
print(fruits[0])   # apple
print(fruits[-1])  # cherry (phần tử cuối)
```

## Vòng lặp for

```python
# Lặp qua danh sách
for fruit in fruits:
    print(f"Tôi thích {fruit}")

# Lặp với range()
for i in range(3):
    print(f"Lần thứ {i}")
# Output: Lần thứ 0, Lần thứ 1, Lần thứ 2
```

## Thao tác với danh sách

```python
fruits = ["apple", "banana"]

fruits.append("cherry")    # Thêm vào cuối
fruits.remove("banana")    # Xóa theo giá trị
print(len(fruits))         # 2 (kích thước)
print(fruits)              # ["apple", "cherry"]
```', 1, '{}'),

(19, 'key_points', 'Key Points', 'Điểm chính',
'- **Lists** use `[]` and store multiple values: `items = [1, 2, 3]`
- Indexing starts at **0**: `items[0]` = first element, `items[-1]` = last element
- **`for x in list:`** iterates through each item automatically
- **`range(n)`** generates numbers 0 to n-1 for counting loops
- **`.append(x)`** adds to end, **`.remove(x)`** deletes by value
- **`len(list)`** returns the number of items in the list',
'- **Danh sách** dùng `[]` và lưu nhiều giá trị: `items = [1, 2, 3]`
- Chỉ mục bắt đầu từ **0**: `items[0]` = phần tử đầu, `items[-1]` = phần tử cuối
- **`for x in list:`** lặp qua từng phần tử tự động
- **`range(n)`** tạo dãy số 0 đến n-1 cho vòng lặp đếm
- **`.append(x)`** thêm vào cuối, **`.remove(x)`** xóa theo giá trị
- **`len(list)`** trả về số phần tử trong danh sách', 2, '{}'),

(19, 'info_box', 'While Loop Caution', 'Cảnh báo vòng While',
'**Be careful with `while` loops** — they can run forever if the condition never becomes False:

```python
# DANGEROUS — infinite loop!
count = 0
while count < 5:
    print(count)
    # Forgot count += 1 → loops forever!

# SAFE — always update the condition variable
count = 0
while count < 5:
    print(count)
    count += 1  # Important!
```

**Tip:** Prefer `for` loops — they always terminate. Only use `while` when you do not know the number of iterations in advance.',
'**Cẩn thận với vòng `while`** — nó có thể chạy mãi nếu điều kiện không bao giờ False:

```python
# NGUY HIỂM — vòng lặp vô hạn!
count = 0
while count < 5:
    print(count)
    # Quên count += 1 → lặp mãi mãi!

# AN TOÀN — luôn cập nhật biến điều kiện
count = 0
while count < 5:
    print(count)
    count += 1  # Quan trọng!
```

**Mẹo:** Ưu tiên dùng `for` — nó luôn kết thúc. Chỉ dùng `while` khi không biết trước số lần lặp.', 3, '{"variant": "warning"}');

-- Exercise 127: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(19, 'multiple_choice', 'easy', 'What does fruits[1] return?', 'fruits[1] trả về gì?', 'fruits = ["apple", "banana", "cherry"]', 'fruits = ["apple", "banana", "cherry"]', 'List indexing starts at 0, so fruits[0] = "apple", fruits[1] = "banana", fruits[2] = "cherry".', 'Chỉ mục danh sách bắt đầu từ 0, nên fruits[0] = "apple", fruits[1] = "banana", fruits[2] = "cherry".', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(127, 'A', 'apple', FALSE, 'fruits[0] returns "apple" — remember indexing starts at 0', 1),
(127, 'B', 'banana', TRUE, 'Correct! Index 1 is the second element, "banana"', 2),
(127, 'C', 'cherry', FALSE, 'fruits[2] returns "cherry" — that is index 2', 3),
(127, 'D', 'Error', FALSE, 'Index 1 is valid for a list with 3 elements (indices 0, 1, 2)', 4);

-- Exercise 128: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(19, 'fill_blank', 'easy', 'Fill in the Python method.', 'Điền phương thức Python.', 'To add an item to the end of a list, use the list.___(item) method.', 'Để thêm phần tử vào cuối danh sách, dùng phương thức list.___(phần_tử).', 'append', 'The append() method adds a single item to the end of a list. Example: fruits.append("mango") adds "mango" as the last element.', 'Phương thức append() thêm một phần tử vào cuối danh sách. Ví dụ: fruits.append("mango") thêm "mango" làm phần tử cuối.', 10, 2);

-- Exercise 129: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(19, 'error_correction', 'medium', 'Fix the Python code error.', 'Sửa lỗi code Python.', 'fruits = ["apple", "banana", "cherry"]\nprint(fruits[3])', 'fruits = ["apple", "banana", "cherry"]\nprint(fruits[3])', 'fruits = ["apple", "banana", "cherry"]\nprint(fruits[2])', 'The list has 3 items with indices 0, 1, 2. Index 3 is out of range and causes an IndexError. The last item is at index 2 (or use -1).', 'Danh sách có 3 phần tử với chỉ mục 0, 1, 2. Chỉ mục 3 vượt phạm vi và gây IndexError. Phần tử cuối ở chỉ mục 2 (hoặc dùng -1).', 'How many items are in the list and what is the maximum valid index?', 'Danh sách có bao nhiêu phần tử và chỉ mục hợp lệ lớn nhất là bao nhiêu?', 15, 3);

-- Exercise 130: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(19, 'sentence_transform', 'medium', 'Rewrite this code using a for loop instead of repeating print statements.', 'Viết lại code này dùng vòng for thay vì lặp lại print.', 'print(fruits[0])\nprint(fruits[1])\nprint(fruits[2])', 'print(fruits[0])\nprint(fruits[1])\nprint(fruits[2])', 'for fruit in fruits: print(fruit)', 'A for loop iterates through each item automatically, replacing repetitive code with a single clean statement. This scales to any list size.', 'Vòng lặp for tự động lặp qua từng phần tử, thay code lặp lại bằng một câu lệnh gọn. Cách này hoạt động với danh sách bất kỳ kích thước.', 15, 4);

-- Exercise 131: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(19, 'arrange_words', 'easy', 'Arrange these list operations in a logical order.', 'Sắp xếp các thao tác danh sách theo thứ tự logic.', '["Process items with a for loop", "Create an empty list", "Add items with append()", "Check length with len()"]', 'Create an empty list, Add items with append(), Check length with len(), Process items with a for loop', 'First create the list, then populate it, verify its contents, and finally process the items. This is a common pattern in data processing.', 'Đầu tiên tạo danh sách, rồi thêm dữ liệu, kiểm tra nội dung, và cuối cùng xử lý các phần tử. Đây là mẫu phổ biến trong xử lý dữ liệu.', 10, 5);

-- Exercise 132: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(19, 'matching', 'easy', 'Match each list method to what it does.', 'Nối mỗi phương thức danh sách với chức năng của nó.', 'Python lists have many built-in methods. These four are the most commonly used for adding, removing, counting, and sorting items.', 'Danh sách Python có nhiều phương thức có sẵn. Bốn phương thức này thường dùng nhất để thêm, xóa, đếm và sắp xếp.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(132, 'append()', 'append()', 'Add item to end', 'Thêm phần tử vào cuối', 1),
(132, 'remove()', 'remove()', 'Delete by value', 'Xóa theo giá trị', 2),
(132, 'len()', 'len()', 'Count total items', 'Đếm tổng số phần tử', 3),
(132, 'sort()', 'sort()', 'Order items ascending', 'Sắp xếp phần tử tăng dần', 4);

-- Exercise 133: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(19, 'true_false', 'easy', 'Is this statement about Python lists correct?', 'Phát biểu này về danh sách Python có đúng không?', 'The first element in a Python list is at index 1.', 'Phần tử đầu tiên trong danh sách Python ở chỉ mục 1.', 'false', 'False! Python uses zero-based indexing, so the first element is at index 0, the second at index 1, etc. This is the same as most programming languages (C, Java, JavaScript).', 'Sai! Python dùng đánh chỉ mục từ 0, nên phần tử đầu ở chỉ mục 0, phần tử thứ 2 ở chỉ mục 1, v.v. Giống hầu hết ngôn ngữ (C, Java, JavaScript).', 5, 7);


-- ############################################################################
-- COMPARISON: Variables & Data Types vs Control Flow (ID 16)
-- ############################################################################

INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(16, 17, 'Core concept', 'Khái niệm cốt lõi', 'STORING data — variables hold values of different types for later use', 'LƯU TRỮ dữ liệu — biến giữ giá trị các kiểu khác nhau để dùng sau', 'DECIDING what to do — if/elif/else chooses which code path to follow', 'QUYẾT ĐỊNH làm gì — if/elif/else chọn đường code nào để đi', 'name = "Alice" (stores a string)', 'name = "Alice" (lưu chuỗi)', 'if age >= 18: print("adult") (makes a decision)', 'if age >= 18: print("người lớn") (ra quyết định)', 'Variables store the data, control flow decides what to do with it. You need both to write useful programs.', 'Biến lưu dữ liệu, luồng điều khiển quyết định làm gì với nó. Cần cả hai để viết chương trình hữu ích.', 1);


-- ############################################################################
-- VERIFICATION QUERIES
-- ############################################################################

-- Verify lesson completeness
SELECT l.id, l.name, l.slug,
  (SELECT COUNT(*) FROM lesson_usage WHERE lesson_id = l.id) AS usages,
  (SELECT COUNT(*) FROM tip WHERE lesson_id = l.id) AS tips,
  (SELECT COUNT(*) FROM lesson_section WHERE lesson_id = l.id) AS sections,
  (SELECT COUNT(*) FROM exercise WHERE lesson_id = l.id) AS exercises
FROM lesson l WHERE l.group_id = 5 ORDER BY l.order_index;
