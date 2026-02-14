-- ============================================================================
-- SEED DATA: UI/UX Design Basics (1 lesson)
-- Category: UI/UX Design Basics (ID 9)
-- Lessons: ID 32
-- Compatible with: schema.sql v7
-- ============================================================================


-- ============================================================================
-- CATEGORY 9: UI/UX Design Basics
-- ============================================================================

INSERT INTO category (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('UI/UX Design Basics', 'Thiết Kế UI/UX Cơ Bản', 'Master the fundamentals of visual design: color theory, typography, layout principles, and user experience', 'Nắm vững nền tảng thiết kế trực quan: lý thuyết màu sắc, kiểu chữ, nguyên tắc bố cục và trải nghiệm người dùng', 'Palette', '#f43f5e', 9);


-- ############################################################################
-- LESSON 32: COLOR THEORY & COLOR PALETTES (lesson_id = 32)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(9, 'Color Theory & Color Palettes', 'Lý Thuyết Màu Sắc & Bảng Màu', 'design-color-theory', 'Understand the color wheel, create harmonious palettes, and apply color psychology to UI design', 'Hiểu bánh xe màu sắc, tạo bảng màu hài hòa và áp dụng tâm lý màu sắc vào thiết kế UI', 'beginner', 25, 1);

-- Usages (IDs 96-98)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(32, 'Understanding the color wheel', 'Hiểu bánh xe màu sắc', 'The color wheel organizes colors by their chromatic relationship. Primary colors (red, blue, yellow) combine to form secondary colors (orange, green, purple), which combine with primaries to form tertiary colors.', 'Bánh xe màu sắc tổ chức các màu theo mối quan hệ sắc độ. Màu cơ bản (đỏ, xanh dương, vàng) kết hợp tạo màu thứ cấp (cam, xanh lá, tím), rồi kết hợp với màu cơ bản tạo màu bậc ba.', 'Palette', TRUE, 1),
(32, 'Creating harmonious palettes', 'Tạo bảng màu hài hòa', 'Color harmony uses mathematical relationships on the color wheel — complementary, analogous, triadic, and split-complementary — to create visually pleasing combinations.', 'Sự hài hòa màu sắc sử dụng các mối quan hệ toán học trên bánh xe màu — bổ sung, tương tự, bộ ba và bổ sung tách — để tạo tổ hợp đẹp mắt.', 'AutoAwesome', TRUE, 2),
(32, 'Color psychology in design', 'Tâm lý màu sắc trong thiết kế', 'Colors trigger emotional and psychological responses. Blue conveys trust, red creates urgency, green suggests growth, and orange encourages action — understanding these associations is essential for effective UI design.', 'Màu sắc kích hoạt phản ứng cảm xúc và tâm lý. Xanh dương truyền tải sự tin cậy, đỏ tạo cảm giác cấp bách, xanh lá gợi ý tăng trưởng và cam khuyến khích hành động — hiểu các liên kết này rất quan trọng cho thiết kế UI hiệu quả.', 'Psychology', TRUE, 3);

-- Examples for usage 96 (IDs 187-188)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(96, 'Mixing red (#FF0000) and blue (#0000FF) on the color wheel produces purple (#800080), a secondary color.', 'Pha trộn đỏ (#FF0000) và xanh dương (#0000FF) trên bánh xe màu tạo ra tím (#800080), một màu thứ cấp.', 'The traditional RYB color wheel (used in painting) differs from the RGB model (used in screens). In RGB, red + blue = magenta, not purple.', 'Bánh xe màu RYB truyền thống (dùng trong hội họa) khác mô hình RGB (dùng trên màn hình). Trong RGB, đỏ + xanh dương = hồng cánh sen, không phải tím.', 'secondary color', 1),
(96, 'Red-orange and yellow-green are tertiary colors — each is formed by mixing one primary and one adjacent secondary color.', 'Đỏ cam và vàng xanh là màu bậc ba — mỗi màu được tạo bằng cách pha một màu cơ bản và một màu thứ cấp liền kề.', 'A complete color wheel has 12 colors: 3 primary, 3 secondary, and 6 tertiary. This 12-color system is the foundation of all color harmony rules.', 'Bánh xe màu đầy đủ có 12 màu: 3 cơ bản, 3 thứ cấp và 6 bậc ba. Hệ thống 12 màu này là nền tảng của mọi quy tắc hài hòa màu sắc.', 'tertiary colors', 2);

-- Examples for usage 97 (IDs 189-190)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(97, 'Blue (#2563EB) and orange (#EA580C) are complementary colors — they sit directly opposite each other on the color wheel and create maximum contrast.', 'Xanh dương (#2563EB) và cam (#EA580C) là màu bổ sung — chúng nằm đối diện nhau trên bánh xe màu và tạo độ tương phản tối đa.', 'Complementary pairs create vibrant contrast. Use them for call-to-action buttons against background colors to draw attention.', 'Cặp bổ sung tạo tương phản sống động. Dùng chúng cho nút kêu gọi hành động trên màu nền để thu hút sự chú ý.', 'complementary', 1),
(97, 'An analogous palette of blue (#3B82F6), blue-green (#06B6D4), and green (#10B981) creates a calm, cohesive look for a wellness app.', 'Bảng màu tương tự gồm xanh dương (#3B82F6), xanh dương-xanh lá (#06B6D4) và xanh lá (#10B981) tạo giao diện bình yên, liền mạch cho ứng dụng sức khỏe.', 'Analogous colors sit next to each other on the wheel (within 30-60 degrees). They feel natural and harmonious because they share undertones.', 'Màu tương tự nằm cạnh nhau trên bánh xe (trong 30-60 độ). Chúng cảm thấy tự nhiên và hài hòa vì có chung sắc nền.', 'analogous', 2);

-- Examples for usage 98 (IDs 191-192)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(98, 'Banks and fintech apps like PayPal and Stripe use blue (#0070BA, #635BFF) because it evokes trust, stability, and professionalism.', 'Ngân hàng và ứng dụng fintech như PayPal và Stripe dùng xanh dương (#0070BA, #635BFF) vì nó gợi sự tin cậy, ổn định và chuyên nghiệp.', 'A 2015 study found that 33% of top brands use blue as their primary color — more than any other color. Blue is associated with calmness and dependability across cultures.', 'Nghiên cứu năm 2015 phát hiện 33% thương hiệu hàng đầu dùng xanh dương làm màu chính — nhiều hơn bất kỳ màu nào. Xanh dương gắn với sự bình tĩnh và đáng tin cậy xuyên văn hóa.', 'trust', 1),
(98, 'Food delivery apps like DoorDash use red (#FF3008) because red stimulates appetite and creates a sense of urgency to order.', 'Ứng dụng giao đồ ăn như DoorDash dùng đỏ (#FF3008) vì đỏ kích thích vị giác và tạo cảm giác cấp bách để đặt hàng.', 'Red increases heart rate and creates excitement. It is the most attention-grabbing color, which is why it is used for warnings, errors, and sale badges.', 'Đỏ tăng nhịp tim và tạo sự phấn khích. Đây là màu thu hút sự chú ý nhất, vì vậy nó được dùng cho cảnh báo, lỗi và nhãn giảm giá.', 'urgency', 2);

-- Tips (IDs 95-97)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(32, 'Use the 60-30-10 rule for color balance', 'Dùng quy tắc 60-30-10 cho cân bằng màu sắc', 'Apply 60% dominant color (background/neutral), 30% secondary color (cards/sections), and 10% accent color (buttons/links). This ratio creates visual hierarchy and prevents any single color from overwhelming the design. For example: 60% white (#FFFFFF), 30% light gray (#F3F4F6), 10% indigo (#6366F1).', 'Áp dụng 60% màu chủ đạo (nền/trung tính), 30% màu phụ (thẻ/phần), và 10% màu nhấn (nút/liên kết). Tỷ lệ này tạo phân cấp thị giác và ngăn bất kỳ màu nào lấn át thiết kế. Ví dụ: 60% trắng (#FFFFFF), 30% xám nhạt (#F3F4F6), 10% chàm (#6366F1).', 'general', 'high', 'Lightbulb', 1),
(32, 'Always test with colorblind simulators', 'Luôn kiểm tra với trình mô phỏng mù màu', 'About 8% of men and 0.5% of women have some form of color vision deficiency. Never rely on color alone to convey meaning — always pair color with icons, labels, or patterns. Use tools like Stark or Sim Daltonism to test your palette. Red-green colorblindness (deuteranopia) is the most common form.', 'Khoảng 8% nam giới và 0.5% nữ giới có một dạng thiếu sắc giác. Không bao giờ chỉ dựa vào màu sắc để truyền đạt ý nghĩa — luôn kết hợp màu với biểu tượng, nhãn hoặc hoa văn. Dùng công cụ như Stark hoặc Sim Daltonism để kiểm tra bảng màu. Mù màu đỏ-xanh (deuteranopia) là dạng phổ biến nhất.', 'common_mistake', 'high', 'Warning', 2),
(32, 'Avoid pure black (#000000) on white backgrounds', 'Tránh dùng đen tuyệt đối (#000000) trên nền trắng', 'Pure black on pure white (#000000 on #FFFFFF) creates harsh contrast that causes eye strain during extended reading. Use near-black instead — #1F2937 or #111827 — for body text. Apple, Google, and most major design systems avoid true black for this reason. The slight warmth feels more natural and is easier on the eyes.', 'Đen tuyệt đối trên trắng tuyệt đối (#000000 trên #FFFFFF) tạo tương phản gắt gây mỏi mắt khi đọc lâu. Dùng gần đen thay thế — #1F2937 hoặc #111827 — cho văn bản nội dung. Apple, Google và hầu hết hệ thống thiết kế lớn đều tránh đen thật vì lý do này. Sắc ấm nhẹ cảm thấy tự nhiên hơn và dễ chịu cho mắt hơn.', 'shortcut', 'medium', 'Info', 3);

-- Sections (IDs 58-60)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(32, 'markdown', 'Color Theory Fundamentals', 'Nền Tảng Lý Thuyết Màu Sắc',
'## The Color Wheel & Color Relationships

The color wheel is the **foundation of all color theory**. Understanding it lets you create palettes that feel intentional and professional.

### Primary, Secondary & Tertiary Colors

| Level | Colors | How They Form |
|-------|--------|---------------|
| **Primary** | Red, Blue, Yellow | Cannot be mixed from other colors |
| **Secondary** | Orange, Green, Purple | Mix of two primaries |
| **Tertiary** | Red-orange, Yellow-green, etc. | Mix of primary + adjacent secondary |

### Color Harmony Schemes

| Scheme | Description | Use Case |
|--------|-------------|----------|
| **Complementary** | Opposite on the wheel (e.g., blue + orange) | High-contrast CTAs and alerts |
| **Analogous** | Adjacent colors (e.g., blue + teal + green) | Calm, cohesive interfaces |
| **Triadic** | Three evenly spaced (e.g., red + blue + yellow) | Vibrant, balanced designs |
| **Split-complementary** | Base + two adjacent to its complement | Contrast with less tension |
| **Monochromatic** | One hue in different shades/tints | Elegant, minimal designs |

### HSL: The Designer''s Color Model

Instead of hex codes, think in **HSL (Hue, Saturation, Lightness)**:

- **Hue** (0-360): Position on the color wheel (0 = red, 120 = green, 240 = blue)
- **Saturation** (0-100%): Color intensity (0% = gray, 100% = vivid)
- **Lightness** (0-100%): Brightness (0% = black, 50% = pure color, 100% = white)

```
/* Building a palette from one hue */
--primary:       hsl(225, 84%, 55%);   /* Base blue */
--primary-light: hsl(225, 84%, 75%);   /* Lighter tint */
--primary-dark:  hsl(225, 84%, 35%);   /* Darker shade */
```

> **Pro tip:** To create a cohesive palette, keep the **saturation consistent** across all your colors. This is what separates amateur palettes from professional ones.',
'## Bánh Xe Màu & Mối Quan Hệ Màu Sắc

Bánh xe màu là **nền tảng của mọi lý thuyết màu sắc**. Hiểu nó giúp bạn tạo bảng màu có chủ đích và chuyên nghiệp.

### Màu Cơ Bản, Thứ Cấp & Bậc Ba

| Cấp độ | Màu sắc | Cách tạo |
|--------|---------|----------|
| **Cơ bản** | Đỏ, Xanh dương, Vàng | Không thể pha từ màu khác |
| **Thứ cấp** | Cam, Xanh lá, Tím | Pha hai màu cơ bản |
| **Bậc ba** | Đỏ cam, Vàng xanh, v.v. | Pha cơ bản + thứ cấp liền kề |

### Các Sơ Đồ Hài Hòa Màu Sắc

| Sơ đồ | Mô tả | Trường hợp sử dụng |
|-------|-------|---------------------|
| **Bổ sung** | Đối diện trên bánh xe (vd: xanh dương + cam) | CTA và cảnh báo tương phản cao |
| **Tương tự** | Màu liền kề (vd: xanh dương + xanh ngọc + xanh lá) | Giao diện bình yên, liền mạch |
| **Bộ ba** | Ba màu cách đều (vd: đỏ + xanh dương + vàng) | Thiết kế sống động, cân bằng |
| **Bổ sung tách** | Gốc + hai màu kề bổ sung | Tương phản ít căng thẳng hơn |
| **Đơn sắc** | Một sắc trong các tông/nhuộm khác nhau | Thiết kế thanh lịch, tối giản |

### HSL: Mô Hình Màu Của Nhà Thiết Kế

Thay vì mã hex, hãy suy nghĩ theo **HSL (Hue, Saturation, Lightness)**:

- **Hue** (0-360): Vị trí trên bánh xe màu (0 = đỏ, 120 = xanh lá, 240 = xanh dương)
- **Saturation** (0-100%): Cường độ màu (0% = xám, 100% = sống động)
- **Lightness** (0-100%): Độ sáng (0% = đen, 50% = màu thuần, 100% = trắng)

```
/* Xây dựng bảng màu từ một sắc */
--primary:       hsl(225, 84%, 55%);   /* Xanh dương gốc */
--primary-light: hsl(225, 84%, 75%);   /* Tông sáng hơn */
--primary-dark:  hsl(225, 84%, 35%);   /* Tông tối hơn */
```

> **Mẹo chuyên nghiệp:** Để tạo bảng màu liền mạch, giữ **độ bão hòa nhất quán** trên tất cả các màu. Đây là điều phân biệt bảng màu nghiệp dư với chuyên nghiệp.', 1, '{}'),

(32, 'key_points', 'Key Points', 'Điểm Chính',
'- The **color wheel** has 12 colors: 3 primary, 3 secondary, 6 tertiary
- **Complementary colors** (opposites on the wheel) create maximum contrast — great for CTAs
- **Analogous colors** (neighbors on the wheel) create harmony — great for cohesive themes
- Use the **60-30-10 rule**: 60% dominant, 30% secondary, 10% accent color
- Think in **HSL** (Hue, Saturation, Lightness) instead of hex for easier palette creation
- **Color psychology matters**: blue = trust, red = urgency, green = growth, orange = action
- Always test for **accessibility** — WCAG requires minimum contrast ratios for text readability',
'- **Bánh xe màu** có 12 màu: 3 cơ bản, 3 thứ cấp, 6 bậc ba
- **Màu bổ sung** (đối diện trên bánh xe) tạo tương phản tối đa — tuyệt vời cho CTA
- **Màu tương tự** (láng giềng trên bánh xe) tạo hài hòa — tuyệt vời cho chủ đề liền mạch
- Dùng **quy tắc 60-30-10**: 60% chủ đạo, 30% phụ, 10% màu nhấn
- Suy nghĩ theo **HSL** (Hue, Saturation, Lightness) thay vì hex để tạo bảng màu dễ hơn
- **Tâm lý màu sắc quan trọng**: xanh dương = tin cậy, đỏ = cấp bách, xanh lá = tăng trưởng, cam = hành động
- Luôn kiểm tra **khả năng tiếp cận** — WCAG yêu cầu tỷ lệ tương phản tối thiểu cho độ đọc văn bản', 2, '{}'),

(32, 'info_box', 'WCAG Contrast Ratio Requirements', 'Yêu Cầu Tỷ Lệ Tương Phản WCAG',
'**Accessibility is not optional.** The Web Content Accessibility Guidelines (WCAG 2.1) define minimum contrast ratios between text and its background:

| Level | Normal Text (< 18px) | Large Text (>= 18px bold / 24px) |
|-------|---------------------|----------------------------------|
| **AA** (minimum) | **4.5:1** | **3:1** |
| **AAA** (enhanced) | **7:1** | **4.5:1** |

**Common failures:**
- Light gray text (#9CA3AF) on white (#FFFFFF) = **2.7:1** — FAILS AA
- Medium gray text (#6B7280) on white (#FFFFFF) = **4.6:1** — PASSES AA
- Dark gray text (#374151) on white (#FFFFFF) = **10.7:1** — PASSES AAA

**Tools to check:** Use Chrome DevTools (inspect element > color picker shows ratio), WebAIM Contrast Checker, or Figma''s Stark plugin. Always verify contrast before shipping!',
'**Khả năng tiếp cận không phải tùy chọn.** Hướng dẫn Khả năng Tiếp cận Nội dung Web (WCAG 2.1) định nghĩa tỷ lệ tương phản tối thiểu giữa văn bản và nền:

| Cấp độ | Văn bản thường (< 18px) | Văn bản lớn (>= 18px đậm / 24px) |
|--------|------------------------|-----------------------------------|
| **AA** (tối thiểu) | **4.5:1** | **3:1** |
| **AAA** (nâng cao) | **7:1** | **4.5:1** |

**Lỗi phổ biến:**
- Văn bản xám nhạt (#9CA3AF) trên trắng (#FFFFFF) = **2.7:1** — KHÔNG ĐẠT AA
- Văn bản xám trung (#6B7280) trên trắng (#FFFFFF) = **4.6:1** — ĐẠT AA
- Văn bản xám đậm (#374151) trên trắng (#FFFFFF) = **10.7:1** — ĐẠT AAA

**Công cụ kiểm tra:** Dùng Chrome DevTools (inspect element > bộ chọn màu hiển thị tỷ lệ), WebAIM Contrast Checker, hoặc plugin Stark của Figma. Luôn xác minh tương phản trước khi xuất bản!', 3, '{"variant": "warning"}');

-- Exercise 218: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(32, 'multiple_choice', 'easy', 'Which pair of colors are complementary on the color wheel?', 'Cặp màu nào là bổ sung trên bánh xe màu sắc?', 'Complementary colors sit directly opposite each other on the color wheel and create maximum visual contrast.', 'Màu bổ sung nằm đối diện nhau trên bánh xe màu và tạo tương phản thị giác tối đa.', 'Blue and orange are complementary — they sit at opposite positions on the 12-color wheel. When placed next to each other, they make both colors appear more vivid. This is why many movie posters use blue-orange color grading.', 'Xanh dương và cam là bổ sung — chúng nằm ở vị trí đối diện trên bánh xe 12 màu. Khi đặt cạnh nhau, chúng làm cả hai màu có vẻ sống động hơn. Đây là lý do nhiều poster phim dùng phối màu xanh dương-cam.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(218, 'A', 'Blue and green', FALSE, 'Blue and green are analogous (neighbors on the wheel), not complementary', 1),
(218, 'B', 'Blue and orange', TRUE, 'Correct! Blue and orange sit directly opposite each other on the color wheel', 2),
(218, 'C', 'Red and yellow', FALSE, 'Red and yellow are both primary colors, not a complementary pair', 3),
(218, 'D', 'Purple and pink', FALSE, 'Purple and pink are closely related hues, not complementary opposites', 4);

-- Exercise 219: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(32, 'fill_blank', 'easy', 'Fill in the name of the color distribution rule used in design.', 'Điền tên quy tắc phân bổ màu sắc dùng trong thiết kế.', 'The ___-30-10 rule states that 60% of your design should use the dominant color, 30% the secondary, and 10% the accent color.', 'Quy tắc ___-30-10 nêu rằng 60% thiết kế nên dùng màu chủ đạo, 30% màu phụ và 10% màu nhấn.', '60', 'The 60-30-10 rule is borrowed from interior design and ensures visual balance. The dominant color (60%) is usually a neutral, the secondary (30%) supports it, and the accent (10%) draws attention to key elements like buttons.', 'Quy tắc 60-30-10 được mượn từ thiết kế nội thất và đảm bảo cân bằng thị giác. Màu chủ đạo (60%) thường là trung tính, màu phụ (30%) hỗ trợ nó, và màu nhấn (10%) thu hút sự chú ý đến yếu tố chính như nút bấm.', 10, 2);

-- Exercise 220: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(32, 'error_correction', 'medium', 'Fix the incorrect statement about color accessibility.', 'Sửa phát biểu sai về khả năng tiếp cận màu sắc.', 'The minimum WCAG AA contrast ratio for normal text is 3:1 between text and background colors.', 'Tỷ lệ tương phản WCAG AA tối thiểu cho văn bản thường là 3:1 giữa văn bản và màu nền.', 'The minimum WCAG AA contrast ratio for normal text is 4.5:1 between text and background colors.', 'WCAG 2.1 Level AA requires a minimum contrast ratio of 4.5:1 for normal-sized text (under 18px). The 3:1 ratio only applies to large text (18px bold or 24px regular). This distinction is critical for accessibility compliance.', 'WCAG 2.1 Cấp AA yêu cầu tỷ lệ tương phản tối thiểu 4.5:1 cho văn bản kích thước thường (dưới 18px). Tỷ lệ 3:1 chỉ áp dụng cho văn bản lớn (18px đậm hoặc 24px thường). Sự phân biệt này rất quan trọng cho tuân thủ khả năng tiếp cận.', 'Check the WCAG AA requirement — is 3:1 the correct ratio for normal-sized text?', 'Kiểm tra yêu cầu WCAG AA — 3:1 có phải tỷ lệ đúng cho văn bản kích thước thường không?', 15, 3);

-- Exercise 221: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(32, 'sentence_transform', 'medium', 'Rewrite this design guideline using the 60-30-10 rule with specific percentages.', 'Viết lại hướng dẫn thiết kế này sử dụng quy tắc 60-30-10 với tỷ lệ phần trăm cụ thể.', 'Use white for the background, gray for the cards, and indigo for the buttons.', 'Dùng trắng cho nền, xám cho thẻ và chàm cho nút bấm.', 'Use 60% white for the background, 30% gray for the cards, and 10% indigo for the buttons.', 'The 60-30-10 rule assigns specific proportions to each color role: the dominant color (background) gets 60%, the secondary color (supporting elements) gets 30%, and the accent (interactive elements) gets 10%. This creates visual hierarchy and prevents color overload.', 'Quy tắc 60-30-10 gán tỷ lệ cụ thể cho mỗi vai trò màu: màu chủ đạo (nền) được 60%, màu phụ (phần tử hỗ trợ) được 30%, và màu nhấn (phần tử tương tác) được 10%. Điều này tạo phân cấp thị giác và ngăn quá tải màu sắc.', 15, 4);

-- Exercise 222: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(32, 'arrange_words', 'easy', 'Arrange the color levels in order from most basic to most complex.', 'Sắp xếp các cấp độ màu từ cơ bản nhất đến phức tạp nhất.', '["Tertiary", "Secondary", "Primary"]', 'Primary, Secondary, Tertiary', 'Primary colors (red, blue, yellow) are the base — they cannot be created by mixing. Secondary colors are made by combining two primaries. Tertiary colors are made by combining a primary with an adjacent secondary — making them the most complex level.', 'Màu cơ bản (đỏ, xanh dương, vàng) là nền tảng — chúng không thể tạo bằng cách pha trộn. Màu thứ cấp được tạo bằng cách kết hợp hai màu cơ bản. Màu bậc ba được tạo bằng cách kết hợp một cơ bản với một thứ cấp liền kề — làm chúng trở thành cấp độ phức tạp nhất.', 10, 5);

-- Exercise 223: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(32, 'matching', 'easy', 'Match each color harmony scheme to its description.', 'Nối mỗi sơ đồ hài hòa màu sắc với mô tả tương ứng.', 'These four color harmony schemes are the most commonly used in UI design. Each creates a different visual effect and suits different design goals.', 'Bốn sơ đồ hài hòa màu sắc này được sử dụng phổ biến nhất trong thiết kế UI. Mỗi sơ đồ tạo hiệu ứng thị giác khác nhau và phù hợp với mục tiêu thiết kế khác nhau.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(223, 'Complementary', 'Bổ sung', 'Two colors opposite on the wheel', 'Hai màu đối diện trên bánh xe', 1),
(223, 'Analogous', 'Tương tự', 'Colors next to each other on the wheel', 'Các màu cạnh nhau trên bánh xe', 2),
(223, 'Triadic', 'Bộ ba', 'Three colors evenly spaced on the wheel', 'Ba màu cách đều trên bánh xe', 3),
(223, 'Monochromatic', 'Đơn sắc', 'One hue in different shades and tints', 'Một sắc trong các tông đậm nhạt khác nhau', 4);

-- Exercise 224: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(32, 'true_false', 'easy', 'Is this statement about color in design correct?', 'Phát biểu này về màu sắc trong thiết kế có đúng không?', 'Using pure black (#000000) for body text on a pure white (#FFFFFF) background is the best practice for readability.', 'Dùng đen tuyệt đối (#000000) cho văn bản nội dung trên nền trắng tuyệt đối (#FFFFFF) là cách tốt nhất cho khả năng đọc.', 'false', 'False! While #000000 on #FFFFFF technically has maximum contrast (21:1), it creates harsh vibration that causes eye strain during extended reading. Professional design systems like Material Design and Apple HIG use near-black (e.g., #1F2937 or #212121) instead. The slightly reduced contrast is still well above WCAG AAA requirements while being much more comfortable to read.', 'Sai! Mặc dù #000000 trên #FFFFFF về mặt kỹ thuật có tương phản tối đa (21:1), nhưng nó tạo rung động gắt gây mỏi mắt khi đọc lâu. Hệ thống thiết kế chuyên nghiệp như Material Design và Apple HIG dùng gần đen (vd: #1F2937 hoặc #212121) thay thế. Tương phản giảm nhẹ vẫn vượt xa yêu cầu WCAG AAA trong khi thoải mái hơn nhiều khi đọc.', 5, 7);


-- ============================================================================
-- COMPARISON: Psychology (lesson 28) vs Design (lesson 32)
-- CHECK constraint: lesson_id_1 < lesson_id_2, so (28, 32) is valid
-- ============================================================================

INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(28, 32, 'Understanding human behavior', 'Hiểu hành vi con người', 'Psychology studies internal mental processes — how memory, perception, and cognition shape decisions and learning', 'Tâm lý học nghiên cứu quá trình tinh thần bên trong — cách trí nhớ, nhận thức và nhận thức định hình quyết định và học tập', 'Design applies behavioral principles to create intuitive interfaces — using color, layout, and visual hierarchy to guide user actions', 'Thiết kế áp dụng nguyên tắc hành vi để tạo giao diện trực quan — sử dụng màu sắc, bố cục và phân cấp thị giác để hướng dẫn hành động người dùng', 'Cognitive load theory explains why too much information overwhelms working memory', 'Lý thuyết tải nhận thức giải thích tại sao quá nhiều thông tin làm quá tải bộ nhớ làm việc', 'A red button on a calm blue page draws attention precisely because of color contrast and urgency psychology', 'Nút đỏ trên trang xanh dương bình yên thu hút sự chú ý chính xác nhờ tương phản màu sắc và tâm lý cấp bách', 'Study psychology to understand WHY users behave certain ways, then apply design principles to shape HOW they interact with your interface', 'Học tâm lý để hiểu TẠI SAO người dùng hành xử theo cách nhất định, sau đó áp dụng nguyên tắc thiết kế để định hình CÁCH họ tương tác với giao diện của bạn', 1);


-- ============================================================================
-- VERIFICATION QUERY
-- ============================================================================

SELECT l.id, l.name, l.slug,
  (SELECT COUNT(*) FROM lesson_usage WHERE lesson_id = l.id) AS usages,
  (SELECT COUNT(*) FROM tip WHERE lesson_id = l.id) AS tips,
  (SELECT COUNT(*) FROM lesson_section WHERE lesson_id = l.id) AS sections,
  (SELECT COUNT(*) FROM exercise WHERE lesson_id = l.id) AS exercises
FROM lesson l WHERE l.group_id = 9 ORDER BY l.order_index;
