-- ============================================================================
-- SEED DATA: UI/UX Design — Extra Lessons
-- Adds 2 lessons to existing category 'UI/UX Design Basics' (ID 9)
-- Prerequisite: seed_design.sql must have been applied (lesson 32 exists)
-- lesson order_index continues from 1 (existing) → 4, 5
-- ============================================================================


-- ############################################################################
-- LESSON: UI ANIMATION PRINCIPLES (slug = animation-principles-ui)
-- order_index = 4 (lesson 32 is order_index 1; 2-3 reserved for typography/layout)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'UI Animation Principles',
  'Nguyên Tắc Hoạt Hình UI',
  'animation-principles-ui',
  'Apply the 12 principles of animation to create intuitive UI motion',
  'Áp dụng 12 nguyên tắc hoạt hình để tạo chuyển động UI trực quan',
  'intermediate',
  35,
  4
FROM category WHERE name = 'UI/UX Design Basics';

-- Usages
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'animation-principles-ui'),
  'Easing and Timing',
  'Easing và Thời Gian',
  'Easing controls how animation speed changes over time. An ease-in-out curve starts slow, accelerates through the middle, and decelerates at the end — mirroring natural physical motion and making transitions feel less mechanical.',
  'Easing kiểm soát cách tốc độ hoạt hình thay đổi theo thời gian. Đường cong ease-in-out bắt đầu chậm, tăng tốc ở giữa và giảm tốc ở cuối — phản ánh chuyển động vật lý tự nhiên và làm cho các chuyển tiếp ít máy móc hơn.',
  'Animation',
  TRUE,
  1
),
(
  (SELECT id FROM lesson WHERE slug = 'animation-principles-ui'),
  'Animation Feedback',
  'Phản Hồi Hoạt Hình',
  'Animation communicates state changes to users — a button ripple confirms a tap, a shake indicates an error, a bounce signals new content. Good feedback animation reduces uncertainty and makes interfaces feel alive and responsive.',
  'Hoạt hình truyền đạt thay đổi trạng thái cho người dùng — hiệu ứng gợn trên nút xác nhận nhấn, rung lắc chỉ ra lỗi, nảy báo hiệu nội dung mới. Hoạt hình phản hồi tốt giảm sự không chắc chắn và làm giao diện cảm thấy sống động và phản hồi.',
  'TouchApp',
  TRUE,
  2
);

-- Sections
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'animation-principles-ui'),
  'markdown',
  'UI Animation Principles',
  'Nguyên Tắc Hoạt Hình UI',
  '## UI Animation Principles

Good UI animation **guides attention, communicates state, and provides feedback**. Bad animation distracts, confuses, and slows users down.

### The Core Principles

| Principle | Description | UI Application |
|-----------|-------------|----------------|
| **Easing** | Movements start/end gradually, not linearly | Use `ease-in-out` for most transitions |
| **Anticipation** | Small preparation before main action | Button press depresses before triggering |
| **Squash & Stretch** | Objects deform to show elasticity | Bouncing notification badge |
| **Follow-through** | Parts continue moving after main action stops | Drawer handle swings after close |
| **Staging** | Guide attention to what matters | Fade in content after navigation |

### Duration Guidelines

```css
/* Fast: micro-interactions (50-100ms) */
.button:hover { transition: background 100ms ease; }

/* Medium: transitions (200-400ms) */
.modal { transition: opacity 300ms ease-in-out; }

/* Slow: complex choreography (500ms+) */
.page-enter { animation: slideIn 500ms ease-out; }
```

### Easing Functions

| Type | CSS Value | Feel |
|------|-----------|------|
| **Linear** | `linear` | Mechanical, robotic |
| **Ease-in** | `ease-in` | Accelerating departure |
| **Ease-out** | `ease-out` | Decelerating arrival (most natural) |
| **Ease-in-out** | `ease-in-out` | Natural, physical motion |
| **Spring** | `cubic-bezier(0.34, 1.56, 0.64, 1)` | Playful overshoot |

> **Rule of thumb:** Most UI transitions should use `ease-out` (200-300ms) — it feels natural because objects in the real world decelerate as they stop.',
  '## Nguyên Tắc Hoạt Hình UI

Hoạt hình UI tốt **hướng dẫn sự chú ý, truyền đạt trạng thái và cung cấp phản hồi**. Hoạt hình xấu gây xao nhãng, nhầm lẫn và làm chậm người dùng.

### Các Nguyên Tắc Cốt Lõi

| Nguyên tắc | Mô tả | Ứng dụng UI |
|------------|-------|-------------|
| **Easing** | Chuyển động bắt đầu/kết thúc từ từ, không tuyến tính | Dùng `ease-in-out` cho hầu hết chuyển tiếp |
| **Anticipation** | Chuẩn bị nhỏ trước hành động chính | Nút nhấn xuống trước khi kích hoạt |
| **Squash & Stretch** | Vật biến dạng thể hiện tính đàn hồi | Badge thông báo nảy |
| **Follow-through** | Các phần tiếp tục di chuyển sau khi hành động chính dừng | Tay cầm ngăn kéo đu sau khi đóng |
| **Staging** | Hướng chú ý đến điều quan trọng | Nội dung mờ dần sau điều hướng |

### Hướng Dẫn Thời Lượng

```css
/* Nhanh: micro-interaction (50-100ms) */
.button:hover { transition: background 100ms ease; }

/* Trung bình: chuyển tiếp (200-400ms) */
.modal { transition: opacity 300ms ease-in-out; }

/* Chậm: dàn dựng phức tạp (500ms+) */
.page-enter { animation: slideIn 500ms ease-out; }
```

### Các Hàm Easing

| Loại | Giá trị CSS | Cảm giác |
|------|-------------|----------|
| **Linear** | `linear` | Cơ học, robot |
| **Ease-in** | `ease-in` | Khởi đầu tăng tốc |
| **Ease-out** | `ease-out` | Đến nơi giảm tốc (tự nhiên nhất) |
| **Ease-in-out** | `ease-in-out` | Chuyển động tự nhiên, vật lý |
| **Spring** | `cubic-bezier(0.34, 1.56, 0.64, 1)` | Vượt qua vui tươi |

> **Quy tắc ngón tay cái:** Hầu hết chuyển tiếp UI nên dùng `ease-out` (200-300ms) — cảm thấy tự nhiên vì vật trong thực tế giảm tốc khi dừng lại.',
  1,
  '{}'
),
(
  (SELECT id FROM lesson WHERE slug = 'animation-principles-ui'),
  'key_points',
  'Key Points',
  'Điểm Chính',
  '- **Easing** is non-linear motion — `ease-in-out` mimics natural physics and feels most comfortable
- The **optimal duration** for most UI transitions is **200-400ms** — short enough to feel snappy, long enough to perceive
- **Micro-interactions** (hover, press, tap feedback) should be 50-150ms to feel instant
- **Animation purpose**: guide attention, signal state changes, provide feedback — NOT decoration
- Use **ease-out** for elements entering the screen; **ease-in** for elements leaving
- **Parallax scrolling** creates depth by moving foreground elements faster than background elements
- **Reduced motion**: always respect `prefers-reduced-motion` for accessibility — some users experience motion sickness
- **Too much animation** is worse than none — limit simultaneous animations to avoid cognitive overload',
  '- **Easing** là chuyển động phi tuyến — `ease-in-out` mô phỏng vật lý tự nhiên và cảm thấy thoải mái nhất
- **Thời lượng tối ưu** cho hầu hết chuyển tiếp UI là **200-400ms** — đủ ngắn để cảm thấy nhanh, đủ dài để nhận ra
- **Micro-interaction** (hover, nhấn, phản hồi chạm) nên là 50-150ms để cảm thấy tức thì
- **Mục đích hoạt hình**: hướng dẫn sự chú ý, báo hiệu thay đổi trạng thái, cung cấp phản hồi — KHÔNG phải trang trí
- Dùng **ease-out** cho phần tử vào màn hình; **ease-in** cho phần tử rời màn hình
- **Parallax scrolling** tạo chiều sâu bằng cách di chuyển phần tử nền trước nhanh hơn phần tử nền sau
- **Giảm chuyển động**: luôn tôn trọng `prefers-reduced-motion` để đảm bảo khả năng tiếp cận — một số người dùng bị say chuyển động
- **Quá nhiều hoạt hình** còn tệ hơn không có — giới hạn hoạt hình đồng thời để tránh quá tải nhận thức',
  2,
  '{}'
),
(
  (SELECT id FROM lesson WHERE slug = 'animation-principles-ui'),
  'info_box',
  'When NOT to Animate',
  'Khi Nào KHÔNG Nên Tạo Hoạt Hình',
  '**Animation can harm UX when misused.** Avoid animation in these situations:

- **Error messages**: users want to read the error immediately — a bouncy animation delays resolution
- **Critical confirmations** (delete, submit): animation adds cognitive friction when users need to act fast
- **Repetitive actions**: if a user clicks a button 50 times, animating every click becomes annoying
- **Long loading states**: a looping spinner is fine for short waits; for waits over 3 seconds, use a progress indicator with estimated time
- **Accessibility contexts**: always implement `@media (prefers-reduced-motion: reduce)` to disable non-essential animations for users with vestibular disorders or motion sensitivity

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
```

**The test:** Ask yourself — does this animation help the user understand what happened, or does it just look cool?',
  '**Hoạt hình có thể gây hại UX khi sử dụng sai.** Tránh hoạt hình trong các trường hợp sau:

- **Thông báo lỗi**: người dùng muốn đọc lỗi ngay — hoạt hình nảy làm chậm giải quyết
- **Xác nhận quan trọng** (xóa, gửi): hoạt hình thêm ma sát nhận thức khi người dùng cần hành động nhanh
- **Hành động lặp đi lặp lại**: nếu người dùng nhấn nút 50 lần, tạo hoạt hình mỗi lần sẽ gây khó chịu
- **Trạng thái tải lâu**: spinner lặp tốt cho chờ ngắn; chờ hơn 3 giây, dùng chỉ số tiến trình với thời gian ước tính
- **Ngữ cảnh tiếp cận**: luôn triển khai `@media (prefers-reduced-motion: reduce)` để tắt hoạt hình không thiết yếu cho người dùng bị rối loạn tiền đình hoặc nhạy cảm với chuyển động

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
```

**Bài kiểm tra:** Hỏi bản thân — hoạt hình này có giúp người dùng hiểu chuyện gì đã xảy ra không, hay nó chỉ trông đẹp?',
  3,
  '{"variant": "warning"}'
);

-- Exercises
-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'animation-principles-ui'),
  'fill_blank',
  'easy',
  'Fill in the CSS easing function that makes animations feel most natural.',
  'Điền hàm easing CSS làm cho hoạt hình cảm thấy tự nhiên nhất.',
  'The ___ easing function starts slow, speeds up through the middle, and slows down at the end — mimicking natural physical motion.',
  'Hàm easing ___ bắt đầu chậm, tăng tốc ở giữa và giảm tốc ở cuối — mô phỏng chuyển động vật lý tự nhiên.',
  'easing',
  'Easing (specifically ease-in-out) is the principle that gives UI animation its natural, physical feel. Linear animation looks robotic because objects in the real world never start or stop instantaneously — they accelerate and decelerate. CSS offers `ease`, `ease-in`, `ease-out`, `ease-in-out`, and custom `cubic-bezier()` values.',
  'Easing (đặc biệt là ease-in-out) là nguyên tắc mang lại cảm giác tự nhiên, vật lý cho hoạt hình UI. Hoạt hình tuyến tính trông robot vì vật trong thực tế không bao giờ bắt đầu hoặc dừng lại tức thì — chúng tăng tốc và giảm tốc. CSS cung cấp `ease`, `ease-in`, `ease-out`, `ease-in-out` và giá trị `cubic-bezier()` tùy chỉnh.',
  10,
  1
);

-- Exercise 2: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'animation-principles-ui'),
  'multiple_choice',
  'easy',
  'What is the primary purpose of UI animation?',
  'Mục đích chính của hoạt hình UI là gì?',
  'Select the option that best describes why animation is added to user interfaces.',
  'Chọn tùy chọn mô tả tốt nhất lý do hoạt hình được thêm vào giao diện người dùng.',
  'The primary purpose of UI animation is to guide attention and provide feedback — it helps users understand what just happened, what they can do, and where they are in a workflow. Animation should always serve the user''s goals, not the designer''s desire to show off technical skill or entertain.',
  'Mục đích chính của hoạt hình UI là hướng dẫn sự chú ý và cung cấp phản hồi — nó giúp người dùng hiểu chuyện gì vừa xảy ra, họ có thể làm gì và họ đang ở đâu trong luồng công việc. Hoạt hình phải luôn phục vụ mục tiêu của người dùng, không phải mong muốn thể hiện kỹ năng kỹ thuật hoặc giải trí của nhà thiết kế.',
  10,
  2
);
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, explanation, order_index) VALUES
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'animation-principles-ui') AND order_index = 2),
  'A', 'To show off technical skill', 'Để thể hiện kỹ năng kỹ thuật', FALSE,
  'Showing off technical skill leads to animations that serve the designer, not the user — a classic UX anti-pattern',
  1
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'animation-principles-ui') AND order_index = 2),
  'B', 'To entertain users', 'Để giải trí người dùng', FALSE,
  'Entertainment value is secondary; if animation distracts from the task, it has failed its purpose',
  2
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'animation-principles-ui') AND order_index = 2),
  'C', 'To guide attention and provide feedback', 'Để hướng dẫn sự chú ý và cung cấp phản hồi', TRUE,
  'Correct! UI animation communicates state changes, confirms interactions, and directs focus to what matters',
  3
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'animation-principles-ui') AND order_index = 2),
  'D', 'To fill empty screen space', 'Để lấp đầy không gian trống trên màn hình', FALSE,
  'Empty space (white space) is a deliberate design tool — filling it with animation creates visual noise',
  4
);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'animation-principles-ui'),
  'true_false',
  'easy',
  'Is this statement about UI animation duration correct?',
  'Phát biểu này về thời lượng hoạt hình UI có đúng không?',
  'All UI animations should be as fast as possible, under 100ms.',
  'Tất cả hoạt hình UI nên nhanh nhất có thể, dưới 100ms.',
  'false',
  'False! While micro-interactions like hover effects should be 50-150ms, most UI transitions (modals, drawers, page changes) benefit from 200-400ms. Below 100ms, complex animations become imperceptible — users cannot process what happened. The optimal range varies by animation type: micro (50-150ms), navigation (200-400ms), complex choreography (400-600ms).',
  'Sai! Trong khi micro-interaction như hiệu ứng hover nên là 50-150ms, hầu hết chuyển tiếp UI (modal, ngăn kéo, thay đổi trang) được hưởng lợi từ 200-400ms. Dưới 100ms, hoạt hình phức tạp trở nên không thể nhận thấy — người dùng không thể xử lý những gì đã xảy ra. Phạm vi tối ưu thay đổi theo loại hoạt hình: micro (50-150ms), điều hướng (200-400ms), dàn dựng phức tạp (400-600ms).',
  5,
  3
);

-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'animation-principles-ui'),
  'fill_blank',
  'medium',
  'Fill in the duration range considered optimal for most UI transitions.',
  'Điền phạm vi thời lượng được coi là tối ưu cho hầu hết chuyển tiếp UI.',
  'The ___ duration for most UI transitions is 200-400ms for best user perception.',
  'Thời lượng ___ cho hầu hết chuyển tiếp UI là 200-400ms để người dùng nhận thức tốt nhất.',
  'optimal',
  'Research by Google Material Design and Apple HIG both converge on 200-400ms as the sweet spot for most UI transitions. Under 200ms feels too abrupt for complex changes; over 400ms starts to feel sluggish. The "optimal" label means this range balances perceived responsiveness with the ability to perceive and understand the transition.',
  'Nghiên cứu của Google Material Design và Apple HIG đều hội tụ về 200-400ms là điểm ngọt cho hầu hết chuyển tiếp UI. Dưới 200ms cảm thấy quá đột ngột cho các thay đổi phức tạp; trên 400ms bắt đầu cảm thấy chậm chạp. Nhãn "tối ưu" có nghĩa là phạm vi này cân bằng giữa sự phản hồi cảm nhận và khả năng nhận thức và hiểu chuyển tiếp.',
  10,
  4
);

-- Exercise 5: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'animation-principles-ui'),
  'true_false',
  'easy',
  'Is this statement about parallax scrolling correct?',
  'Phát biểu này về parallax scrolling có đúng không?',
  'Parallax scrolling can create a sense of depth and visual interest.',
  'Parallax scrolling có thể tạo cảm giác chiều sâu và sự thú vị về thị giác.',
  'true',
  'True! Parallax scrolling moves different layers at different speeds — foreground elements move faster than background elements. This differential speed mimics the natural parallax effect that our eyes use to perceive depth. When implemented tastefully with moderate speed differences (not extreme), it adds dimensionality without disorienting users. However, excessive parallax is a known cause of motion sickness on the web.',
  'Đúng! Parallax scrolling di chuyển các lớp khác nhau ở tốc độ khác nhau — phần tử nền trước di chuyển nhanh hơn phần tử nền sau. Sự khác biệt tốc độ này mô phỏng hiệu ứng parallax tự nhiên mà mắt chúng ta sử dụng để nhận thức chiều sâu. Khi được triển khai tinh tế với sự khác biệt tốc độ vừa phải (không cực đoan), nó thêm chiều sâu mà không gây mất phương hướng cho người dùng. Tuy nhiên, parallax quá mức là nguyên nhân gây say chuyển động đã được biết đến trên web.',
  5,
  5
);


-- ############################################################################
-- LESSON: RESPONSIVE DESIGN PATTERNS (slug = responsive-design-patterns)
-- order_index = 5
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Responsive Design Patterns',
  'Mẫu Thiết Kế Đáp Ứng',
  'responsive-design-patterns',
  'Design interfaces that work seamlessly across all screen sizes',
  'Thiết kế giao diện hoạt động liền mạch trên mọi kích thước màn hình',
  'intermediate',
  40,
  5
FROM category WHERE name = 'UI/UX Design Basics';

-- Usages
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'responsive-design-patterns'),
  'Mobile-First Approach',
  'Phương Pháp Mobile-First',
  'Mobile-first design starts with the smallest screen and progressively enhances the layout for larger screens. Because mobile has the most constraints (small screen, touch input, slower networks), designing for it first forces you to prioritize essential content and functionality.',
  'Thiết kế mobile-first bắt đầu với màn hình nhỏ nhất và dần dần cải thiện bố cục cho màn hình lớn hơn. Vì mobile có nhiều ràng buộc nhất (màn hình nhỏ, đầu vào cảm ứng, mạng chậm hơn), thiết kế cho nó trước buộc bạn ưu tiên nội dung và chức năng thiết yếu.',
  'PhoneAndroid',
  TRUE,
  1
),
(
  (SELECT id FROM lesson WHERE slug = 'responsive-design-patterns'),
  'Breakpoints and Grid',
  'Điểm Ngắt và Lưới',
  'Breakpoints are CSS threshold values where the layout changes to accommodate the new screen width. A fluid grid uses percentage-based widths rather than fixed pixel values, allowing content to scale proportionally between breakpoints.',
  'Điểm ngắt là giá trị ngưỡng CSS nơi bố cục thay đổi để phù hợp với chiều rộng màn hình mới. Lưới linh hoạt sử dụng chiều rộng dựa trên phần trăm thay vì giá trị pixel cố định, cho phép nội dung co giãn tỷ lệ giữa các điểm ngắt.',
  'GridView',
  TRUE,
  2
);

-- Sections
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'responsive-design-patterns'),
  'markdown',
  'Responsive Design Fundamentals',
  'Nền Tảng Thiết Kế Đáp Ứng',
  '## Responsive Design Fundamentals

Responsive design ensures your interface looks and works great on every device — from a 320px mobile screen to a 4K monitor.

### The Three Pillars of Responsive Design

| Pillar | Technique | Purpose |
|--------|-----------|---------|
| **Fluid grids** | Percentage widths | Content scales between breakpoints |
| **Flexible images** | `max-width: 100%` | Images never overflow their container |
| **Media queries** | `@media (min-width: ...)` | Apply layout rules at breakpoints |

### Standard Breakpoints (Mobile-First)

```css
/* Mobile base: 320px - 767px (no media query needed) */
.container { width: 100%; padding: 0 16px; }

/* Tablet: 768px+ */
@media (min-width: 768px) {
  .container { max-width: 768px; margin: 0 auto; }
  .grid { grid-template-columns: repeat(2, 1fr); }
}

/* Desktop: 1024px+ */
@media (min-width: 1024px) {
  .container { max-width: 1024px; }
  .grid { grid-template-columns: repeat(3, 1fr); }
}

/* Wide: 1440px+ */
@media (min-width: 1440px) {
  .container { max-width: 1280px; }
  .grid { grid-template-columns: repeat(4, 1fr); }
}
```

### Common Responsive Patterns

| Pattern | Description | Best For |
|---------|-------------|----------|
| **Mostly Fluid** | Multi-column → single column | General content |
| **Column Drop** | Columns stack one by one | Dashboard layouts |
| **Layout Shifter** | Dramatic reordering of content | Complex pages |
| **Off Canvas** | Navigation hidden off-screen on mobile | Navigation-heavy apps |

> **Touch targets**: always make interactive elements at least **44x44 pixels** (Apple HIG) or **48x48dp** (Material Design) on touch devices.',
  '## Nền Tảng Thiết Kế Đáp Ứng

Thiết kế đáp ứng đảm bảo giao diện của bạn trông đẹp và hoạt động tốt trên mọi thiết bị — từ màn hình mobile 320px đến màn hình 4K.

### Ba Trụ Cột Của Thiết Kế Đáp Ứng

| Trụ cột | Kỹ thuật | Mục đích |
|---------|----------|----------|
| **Lưới linh hoạt** | Chiều rộng phần trăm | Nội dung co giãn giữa các điểm ngắt |
| **Hình ảnh linh hoạt** | `max-width: 100%` | Hình ảnh không bao giờ tràn container |
| **Media query** | `@media (min-width: ...)` | Áp dụng quy tắc bố cục tại điểm ngắt |

### Điểm Ngắt Chuẩn (Mobile-First)

```css
/* Nền mobile: 320px - 767px (không cần media query) */
.container { width: 100%; padding: 0 16px; }

/* Máy tính bảng: 768px+ */
@media (min-width: 768px) {
  .container { max-width: 768px; margin: 0 auto; }
  .grid { grid-template-columns: repeat(2, 1fr); }
}

/* Desktop: 1024px+ */
@media (min-width: 1024px) {
  .container { max-width: 1024px; }
  .grid { grid-template-columns: repeat(3, 1fr); }
}

/* Màn hình rộng: 1440px+ */
@media (min-width: 1440px) {
  .container { max-width: 1280px; }
  .grid { grid-template-columns: repeat(4, 1fr); }
}
```

### Các Mẫu Đáp Ứng Phổ Biến

| Mẫu | Mô tả | Tốt nhất cho |
|-----|-------|--------------|
| **Mostly Fluid** | Nhiều cột → một cột | Nội dung chung |
| **Column Drop** | Các cột xếp chồng từng cái | Bố cục dashboard |
| **Layout Shifter** | Sắp xếp lại nội dung đáng kể | Trang phức tạp |
| **Off Canvas** | Điều hướng ẩn ngoài màn hình trên mobile | Ứng dụng nhiều điều hướng |

> **Touch target**: luôn làm phần tử tương tác ít nhất **44x44 pixel** (Apple HIG) hoặc **48x48dp** (Material Design) trên thiết bị cảm ứng.',
  1,
  '{}'
),
(
  (SELECT id FROM lesson WHERE slug = 'responsive-design-patterns'),
  'key_points',
  'Key Points',
  'Điểm Chính',
  '- **Mobile-first** design starts with the **smallest** screen size and progressively enhances — not the reverse
- **Fluid grids** use percentage-based widths (`width: 50%`) so layouts scale between breakpoints
- **Media queries** define CSS breakpoints — common values: 768px (tablet), 1024px (desktop), 1440px (wide)
- **Touch targets** must be at least **44x44 pixels** (Apple) or 48x48dp (Google) for comfortable tapping
- `max-width: 100%` on images prevents overflow and is the foundation of responsive images
- **Breakpoints should be based on content**, not specific devices — let the design tell you when it breaks
- The **viewport meta tag** (`<meta name="viewport" content="width=device-width, initial-scale=1">`) is required for mobile browsers to render responsively
- **CSS Grid** and **Flexbox** are the modern tools for responsive layouts — avoid fixed-pixel layouts',
  '- Thiết kế **Mobile-first** bắt đầu với kích thước màn hình **nhỏ nhất** và dần dần cải thiện — không phải ngược lại
- **Lưới linh hoạt** sử dụng chiều rộng dựa trên phần trăm (`width: 50%`) để bố cục co giãn giữa các điểm ngắt
- **Media query** xác định điểm ngắt CSS — giá trị phổ biến: 768px (máy tính bảng), 1024px (desktop), 1440px (màn hình rộng)
- **Touch target** phải ít nhất **44x44 pixel** (Apple) hoặc 48x48dp (Google) để nhấn thoải mái
- `max-width: 100%` trên hình ảnh ngăn tràn và là nền tảng của hình ảnh đáp ứng
- **Điểm ngắt nên dựa trên nội dung**, không phải thiết bị cụ thể — để thiết kế cho bạn biết khi nào nó bị vỡ
- **Viewport meta tag** (`<meta name="viewport" content="width=device-width, initial-scale=1">`) là bắt buộc để trình duyệt mobile render đáp ứng
- **CSS Grid** và **Flexbox** là công cụ hiện đại cho bố cục đáp ứng — tránh bố cục pixel cố định',
  2,
  '{}'
),
(
  (SELECT id FROM lesson WHERE slug = 'responsive-design-patterns'),
  'diagram',
  'Mobile-First Breakpoint Progression',
  'Tiến Trình Điểm Ngắt Mobile-First',
  'This diagram shows how a mobile-first design progressively enhances from the smallest screen size upward, with each breakpoint adding layout complexity.',
  'Sơ đồ này cho thấy cách thiết kế mobile-first dần dần cải thiện từ kích thước màn hình nhỏ nhất trở lên, với mỗi điểm ngắt thêm độ phức tạp bố cục.',
  3,
  '{"code": "graph TD\n    A[Mobile First]\n    A --> B[320px Base Design]\n    B --> C[768px Tablet]\n    C --> D[1024px Desktop]\n    D --> E[1440px Wide]\n    B --> F[Progressive Enhancement]"}'
);

-- Exercises
-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'responsive-design-patterns'),
  'fill_blank',
  'easy',
  'Fill in the missing word about mobile-first design approach.',
  'Điền từ còn thiếu về phương pháp thiết kế mobile-first.',
  'Mobile-first design starts with the ___ screen size and expands up.',
  'Thiết kế mobile-first bắt đầu với kích thước màn hình ___ và mở rộng lên.',
  'smallest',
  'Mobile-first means writing your base CSS for the smallest viewport first, then adding media queries for larger screens using `min-width`. This forces you to prioritize essential content and ensures performance on constrained devices. The opposite approach — desktop-first — starts large and uses `max-width` queries to remove features, often leaving mobile as an afterthought.',
  'Mobile-first có nghĩa là viết CSS cơ sở cho viewport nhỏ nhất trước, sau đó thêm media query cho màn hình lớn hơn bằng `min-width`. Điều này buộc bạn ưu tiên nội dung thiết yếu và đảm bảo hiệu suất trên thiết bị hạn chế. Cách tiếp cận ngược lại — desktop-first — bắt đầu lớn và sử dụng truy vấn `max-width` để loại bỏ tính năng, thường để mobile như là suy nghĩ sau.',
  10,
  1
);

-- Exercise 2: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'responsive-design-patterns'),
  'multiple_choice',
  'easy',
  'What is a CSS breakpoint?',
  'Điểm ngắt CSS là gì?',
  'Select the best definition of a CSS breakpoint in responsive design.',
  'Chọn định nghĩa tốt nhất về điểm ngắt CSS trong thiết kế đáp ứng.',
  'A breakpoint is a threshold in a CSS media query where layout rules change based on the viewport width. Common breakpoints align with general device categories (mobile, tablet, desktop) but should really be chosen based on where your specific design starts to break down — not arbitrary device sizes.',
  'Điểm ngắt là ngưỡng trong media query CSS nơi quy tắc bố cục thay đổi dựa trên chiều rộng viewport. Điểm ngắt phổ biến phù hợp với danh mục thiết bị chung (mobile, máy tính bảng, desktop) nhưng thực sự nên được chọn dựa trên nơi thiết kế cụ thể của bạn bắt đầu bị vỡ — không phải kích thước thiết bị tùy tiện.',
  10,
  2
);
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, explanation, order_index) VALUES
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'responsive-design-patterns') AND order_index = 2),
  'A', 'A bug in the code', 'Một lỗi trong mã', FALSE,
  'A breakpoint is intentional CSS, not a bug',
  1
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'responsive-design-patterns') AND order_index = 2),
  'B', 'A point where layout changes based on screen width', 'Điểm nơi bố cục thay đổi dựa trên chiều rộng màn hình', TRUE,
  'Correct! Breakpoints use CSS media queries to apply different layout rules at different viewport widths',
  2
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'responsive-design-patterns') AND order_index = 2),
  'C', 'A navigation element', 'Một phần tử điều hướng', FALSE,
  'Navigation elements are UI components — breakpoints are CSS rules',
  3
),
(
  (SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'responsive-design-patterns') AND order_index = 2),
  'D', 'A color palette', 'Một bảng màu sắc', FALSE,
  'Color palettes are visual design choices — breakpoints control layout behavior',
  4
);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'responsive-design-patterns'),
  'true_false',
  'easy',
  'Is this statement about fluid grids correct?',
  'Phát biểu này về lưới linh hoạt có đúng không?',
  'A fluid grid uses percentage-based widths instead of fixed pixels.',
  'Lưới linh hoạt sử dụng chiều rộng dựa trên phần trăm thay vì pixel cố định.',
  'true',
  'True! Fluid grids use percentage values (e.g., `width: 33.33%`) instead of fixed pixel values (e.g., `width: 400px`). This means columns and containers scale proportionally with the viewport, filling the available space at any screen size. Fluid grids work in combination with breakpoints — the percentage values stay constant between breakpoints, while breakpoints change the column count.',
  'Đúng! Lưới linh hoạt sử dụng giá trị phần trăm (ví dụ `width: 33.33%`) thay vì giá trị pixel cố định (ví dụ `width: 400px`). Điều này có nghĩa là các cột và container co giãn tỷ lệ với viewport, lấp đầy không gian có sẵn ở bất kỳ kích thước màn hình nào. Lưới linh hoạt hoạt động kết hợp với điểm ngắt — giá trị phần trăm không đổi giữa các điểm ngắt, trong khi điểm ngắt thay đổi số lượng cột.',
  5,
  3
);

-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'responsive-design-patterns'),
  'fill_blank',
  'medium',
  'Fill in the CSS feature used to apply different layout rules at different screen widths.',
  'Điền tính năng CSS được sử dụng để áp dụng các quy tắc bố cục khác nhau ở các chiều rộng màn hình khác nhau.',
  'The CSS property that controls how elements wrap at breakpoints is called ___.',
  'Tính năng CSS kiểm soát cách các phần tử thay đổi bố cục tại điểm ngắt được gọi là ___.',
  'media query',
  'CSS media queries (`@media`) are the mechanism for applying style rules conditionally based on characteristics like viewport width, height, orientation, or resolution. The syntax `@media (min-width: 768px) { ... }` applies the enclosed CSS rules only when the screen is 768px wide or wider, enabling the layout shift that defines responsive design.',
  'Media query CSS (`@media`) là cơ chế áp dụng quy tắc style có điều kiện dựa trên các đặc điểm như chiều rộng viewport, chiều cao, hướng hoặc độ phân giải. Cú pháp `@media (min-width: 768px) { ... }` áp dụng các quy tắc CSS kèm theo chỉ khi màn hình rộng 768px hoặc hơn, cho phép thay đổi bố cục xác định thiết kế đáp ứng.',
  10,
  4
);

-- Exercise 5: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(
  (SELECT id FROM lesson WHERE slug = 'responsive-design-patterns'),
  'true_false',
  'easy',
  'Is this statement about mobile touch targets correct?',
  'Phát biểu này về touch target trên mobile có đúng không?',
  'Touch targets on mobile should be at least 44x44 pixels per Apple guidelines.',
  'Touch target trên mobile nên ít nhất 44x44 pixel theo hướng dẫn của Apple.',
  'true',
  'True! Apple''s Human Interface Guidelines specify a minimum tappable area of 44x44 points (approximately 44x44 pixels on standard displays). Google Material Design recommends 48x48dp. These minimums exist because human finger tips are typically 10-12mm wide, and smaller targets cause mis-taps. This is why navigation bars, checkboxes, and links should have adequate padding even if their visual size appears smaller.',
  'Đúng! Hướng dẫn Giao diện Con người của Apple chỉ định diện tích nhấn tối thiểu là 44x44 điểm (xấp xỉ 44x44 pixel trên màn hình tiêu chuẩn). Google Material Design khuyến nghị 48x48dp. Những tối thiểu này tồn tại vì đầu ngón tay người thường rộng 10-12mm, và mục tiêu nhỏ hơn gây nhấn nhầm. Đây là lý do tại sao thanh điều hướng, hộp kiểm và liên kết nên có padding đầy đủ ngay cả khi kích thước thị giác của chúng nhỏ hơn.',
  5,
  5
);


-- ============================================================================
-- VERIFICATION QUERY
-- ============================================================================

SELECT l.id, l.name, l.slug,
  (SELECT COUNT(*) FROM lesson_usage WHERE lesson_id = l.id) AS usages,
  (SELECT COUNT(*) FROM lesson_section WHERE lesson_id = l.id) AS sections,
  (SELECT COUNT(*) FROM exercise WHERE lesson_id = l.id) AS exercises
FROM lesson l
WHERE l.group_id = (SELECT id FROM category WHERE name = 'UI/UX Design Basics')
ORDER BY l.order_index;
