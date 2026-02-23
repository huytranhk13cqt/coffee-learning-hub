-- ============================================================================
-- SEED DATA: Chemistry Basics — Extra Lessons
-- Adds 2 lessons to existing category 'Chemistry Basics'
-- Applied AFTER: seed_chemistry.sql
-- Do NOT re-insert the category.
-- ============================================================================


-- ############################################################################
-- LESSON 2: CHEMICAL REACTIONS AND EQUATIONS (slug: chemical-reactions)
-- order_index: 2  (Atomic Structure is order_index 1)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Chemical Reactions and Equations', 'Phản Ứng Hóa Học và Phương Trình',
  'chemical-reactions',
  'Balance chemical equations and understand reaction types: synthesis, decomposition, and more',
  'Cân bằng phương trình hóa học và hiểu các loại phản ứng: tổng hợp, phân giải và nhiều hơn',
  'intermediate', 35, 2
FROM category WHERE name = 'Chemistry Basics';


-- ============================================================================
-- LESSON USAGES
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'chemical-reactions'),
 'Types of Chemical Reactions', 'Các Loại Phản Ứng Hóa Học',
 'Chemical reactions are classified into five main types. Synthesis (combination): two or more substances combine to form one product (A + B → AB). Decomposition: one compound breaks apart into simpler substances (AB → A + B). Single replacement: one element displaces another in a compound (A + BC → AC + B). Double replacement: two compounds exchange ions (AB + CD → AD + CB). Combustion: a substance reacts with oxygen, typically releasing heat and light.',
 'Phản ứng hóa học được phân loại thành năm loại chính. Tổng hợp (kết hợp): hai hay nhiều chất kết hợp thành một sản phẩm (A + B → AB). Phân giải: một hợp chất phân tách thành các chất đơn giản hơn (AB → A + B). Thế đơn: một nguyên tố thay thế nguyên tố khác trong hợp chất (A + BC → AC + B). Thế đôi: hai hợp chất trao đổi ion (AB + CD → AD + CB). Đốt cháy: một chất phản ứng với oxy, thường giải phóng nhiệt và ánh sáng.',
 'AutoFixHigh', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'chemical-reactions'),
 'Balancing Chemical Equations', 'Cân Bằng Phương Trình Hóa Học',
 'The law of conservation of mass states that matter is neither created nor destroyed in a chemical reaction — the same atoms must appear on both sides of the equation, just rearranged. Balancing an equation means adjusting the coefficients (whole-number multipliers) in front of each formula until the count of each element is equal on both sides. Subscripts within formulas are never changed when balancing.',
 'Định luật bảo toàn khối lượng phát biểu rằng vật chất không được tạo ra hay phá hủy trong phản ứng hóa học — các nguyên tử giống nhau phải xuất hiện ở cả hai vế của phương trình, chỉ được sắp xếp lại. Cân bằng phương trình có nghĩa là điều chỉnh hệ số (số nhân nguyên) trước mỗi công thức cho đến khi số lượng mỗi nguyên tố bằng nhau ở cả hai vế. Các chỉ số dưới trong công thức không bao giờ được thay đổi khi cân bằng.',
 'Scale', TRUE, 2);


-- ============================================================================
-- EXAMPLES (2 per usage)
-- ============================================================================

INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES

-- Usage 1: Types of Chemical Reactions
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'chemical-reactions') AND order_index = 1),
 'Photosynthesis is a synthesis reaction: 6CO₂ + 6H₂O → C₆H₁₂O₆ + 6O₂. Plants combine carbon dioxide and water using sunlight energy to form glucose (a single complex product) and oxygen.',
 'Quang hợp là phản ứng tổng hợp: 6CO₂ + 6H₂O → C₆H₁₂O₆ + 6O₂. Thực vật kết hợp carbon dioxide và nước sử dụng năng lượng ánh sáng để tạo thành glucose (một sản phẩm phức tạp duy nhất) và oxy.',
 'Synthesis reactions are anabolic — they build complex molecules from simpler ones. Living cells use synthesis reactions constantly to build proteins, DNA, and carbohydrates. These reactions require energy input (endothermic in biological systems powered by ATP).',
 'Phản ứng tổng hợp là đồng hóa — chúng xây dựng phân tử phức tạp từ các phân tử đơn giản hơn. Tế bào sống liên tục sử dụng phản ứng tổng hợp để xây dựng protein, DNA và carbohydrate. Các phản ứng này đòi hỏi đầu vào năng lượng (thu nhiệt trong hệ sinh học được cung cấp năng lượng bởi ATP).',
 'synthesis reaction', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'chemical-reactions') AND order_index = 1),
 'When iron (Fe) is placed in copper sulfate solution (CuSO₄), iron displaces copper: Fe + CuSO₄ → FeSO₄ + Cu. The iron dissolves and copper metal deposits on the iron — a single-replacement reaction.',
 'Khi sắt (Fe) được đặt vào dung dịch đồng sulfate (CuSO₄), sắt thay thế đồng: Fe + CuSO₄ → FeSO₄ + Cu. Sắt hòa tan và kim loại đồng lắng xuống trên sắt — phản ứng thế đơn.',
 'Single replacement reactions follow an activity series. More reactive metals displace less reactive metals from their compounds. Iron is more reactive than copper, so iron displaces copper. Gold is less reactive than copper, so gold cannot displace copper from copper sulfate — no reaction occurs.',
 'Phản ứng thế đơn theo dãy hoạt động. Kim loại phản ứng mạnh hơn thay thế kim loại kém phản ứng hơn khỏi hợp chất của chúng. Sắt phản ứng mạnh hơn đồng, nên sắt thay thế đồng. Vàng kém phản ứng hơn đồng, nên vàng không thể thay thế đồng khỏi đồng sulfate — không có phản ứng xảy ra.',
 'single replacement', 2),

-- Usage 2: Balancing Equations
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'chemical-reactions') AND order_index = 2),
 'Unbalanced: H₂ + O₂ → H₂O. Balanced: 2H₂ + O₂ → 2H₂O. The unbalanced version has 2 oxygen atoms on the left but only 1 on the right. Adding coefficient 2 in front of H₂O fixes oxygen but requires coefficient 2 in front of H₂ to balance hydrogen.',
 'Chưa cân bằng: H₂ + O₂ → H₂O. Đã cân bằng: 2H₂ + O₂ → 2H₂O. Phiên bản chưa cân bằng có 2 nguyên tử oxy ở bên trái nhưng chỉ 1 ở bên phải. Thêm hệ số 2 trước H₂O sửa oxy nhưng cần hệ số 2 trước H₂ để cân bằng hydro.',
 'When balancing: (1) count atoms of each element on both sides; (2) adjust coefficients to make counts equal; (3) never change subscripts — only add or change whole-number coefficients in front of formulas. A coefficient of 1 is not written (it is implied). Fractions as coefficients are acceptable but must be cleared by multiplying all coefficients by the denominator.',
 'Khi cân bằng: (1) đếm nguyên tử mỗi nguyên tố ở cả hai vế; (2) điều chỉnh hệ số để số lượng bằng nhau; (3) không bao giờ thay đổi chỉ số dưới — chỉ thêm hoặc thay đổi hệ số nguyên trước công thức. Hệ số 1 không được viết (ngầm hiểu). Phân số làm hệ số được chấp nhận nhưng phải loại bỏ bằng cách nhân tất cả hệ số với mẫu số.',
 'balancing', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'chemical-reactions') AND order_index = 2),
 'The combustion of methane (natural gas): CH₄ + 2O₂ → CO₂ + 2H₂O. Left: 1C, 4H, 4O. Right: 1C, 4H, 4O. The equation is balanced — each atom type has equal counts on both sides.',
 'Sự đốt cháy methane (khí tự nhiên): CH₄ + 2O₂ → CO₂ + 2H₂O. Trái: 1C, 4H, 4O. Phải: 1C, 4H, 4O. Phương trình được cân bằng — mỗi loại nguyên tử có số lượng bằng nhau ở cả hai vế.',
 'Always verify your balanced equation by counting all atoms on both sides. Combustion of hydrocarbons (compounds containing only C and H) always produces CO₂ and H₂O as products when oxygen is abundant (complete combustion). Incomplete combustion (limited O₂) produces CO and soot (C) instead.',
 'Luôn kiểm tra phương trình đã cân bằng bằng cách đếm tất cả nguyên tử ở cả hai vế. Đốt cháy hydrocarbon (hợp chất chỉ chứa C và H) luôn tạo ra CO₂ và H₂O là sản phẩm khi oxy đủ (đốt cháy hoàn toàn). Đốt cháy không hoàn toàn (O₂ hạn chế) tạo ra CO và bồ hóng (C) thay thế.',
 'combustion', 2);


-- ============================================================================
-- TIPS
-- ============================================================================

INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES

((SELECT id FROM lesson WHERE slug = 'chemical-reactions'),
 'Never change subscripts when balancing', 'Không bao giờ thay đổi chỉ số dưới khi cân bằng',
 'The most common balancing mistake is changing subscripts (the small numbers inside formulas, like the 2 in H₂O) instead of coefficients (the large numbers in front of formulas). Changing H₂O to H₂O₂ creates a completely different compound (hydrogen peroxide, not water). Only coefficients may be changed. Always work with the formulas as given and only adjust the numbers in front.',
 'Lỗi cân bằng phổ biến nhất là thay đổi chỉ số dưới (con số nhỏ trong công thức, như số 2 trong H₂O) thay vì hệ số (con số lớn trước công thức). Thay đổi H₂O thành H₂O₂ tạo ra hợp chất hoàn toàn khác (hydro peroxide, không phải nước). Chỉ hệ số mới được thay đổi. Luôn làm việc với công thức như đã cho và chỉ điều chỉnh con số phía trước.',
 'common_mistake', 'high', 'Warning', 1),

((SELECT id FROM lesson WHERE slug = 'chemical-reactions'),
 'Balance polyatomic ions as a unit', 'Cân bằng ion đa nguyên tử như một đơn vị',
 'When a polyatomic ion (like SO₄²⁻, NO₃⁻, or OH⁻) appears unchanged on both sides of the equation, treat it as a single unit rather than balancing each atom individually. For example, in Ca(OH)₂ + H₂SO₄ → CaSO₄ + 2H₂O, check the OH group as a unit on the left. This shortcut dramatically speeds up balancing complex equations.',
 'Khi ion đa nguyên tử (như SO₄²⁻, NO₃⁻, hoặc OH⁻) xuất hiện không thay đổi ở cả hai vế của phương trình, hãy coi nó như một đơn vị thay vì cân bằng từng nguyên tử riêng biệt. Ví dụ, trong Ca(OH)₂ + H₂SO₄ → CaSO₄ + 2H₂O, kiểm tra nhóm OH như một đơn vị ở bên trái. Phím tắt này tăng tốc đáng kể việc cân bằng các phương trình phức tạp.',
 'shortcut', 'high', 'Lightbulb', 2),

((SELECT id FROM lesson WHERE slug = 'chemical-reactions'),
 'Energy is always involved', 'Năng lượng luôn liên quan',
 'Every chemical reaction either releases energy (exothermic: combustion, rusting, many acid-base reactions) or absorbs energy (endothermic: photosynthesis, cooking). Exothermic reactions release energy as heat, light, or electrical energy — the products have lower chemical potential energy than the reactants. Endothermic reactions require energy input — the products have higher energy than the reactants.',
 'Mọi phản ứng hóa học đều giải phóng năng lượng (tỏa nhiệt: đốt cháy, gỉ sét, nhiều phản ứng acid-base) hoặc hấp thụ năng lượng (thu nhiệt: quang hợp, nấu ăn). Phản ứng tỏa nhiệt giải phóng năng lượng dưới dạng nhiệt, ánh sáng hoặc điện năng — sản phẩm có năng lượng tiềm năng hóa học thấp hơn chất phản ứng. Phản ứng thu nhiệt đòi hỏi đầu vào năng lượng — sản phẩm có năng lượng cao hơn chất phản ứng.',
 'general', 'medium', 'Info', 3);


-- ============================================================================
-- LESSON SECTIONS (3 sections: markdown + key_points + diagram)
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

-- Section 1: markdown
((SELECT id FROM lesson WHERE slug = 'chemical-reactions'),
 'markdown', 'Chemical Reactions: Rearranging Atoms', 'Phản Ứng Hóa Học: Sắp Xếp Lại Nguyên Tử',
'## Chemical Reactions and Equations

A chemical reaction transforms **reactants** into **products** by breaking existing bonds and forming new ones. Atoms are rearranged — never created or destroyed (law of conservation of mass).

### General Equation Form

$$\text{Reactants} \rightarrow \text{Products}$$

Written with states: $2H_2(g) + O_2(g) \rightarrow 2H_2O(l)$

### Five Reaction Types

| Type | General Form | Example |
|------|-------------|---------|
| **Synthesis** | A + B → AB | 2Na + Cl₂ → 2NaCl |
| **Decomposition** | AB → A + B | 2H₂O₂ → 2H₂O + O₂ |
| **Single Replacement** | A + BC → AC + B | Zn + 2HCl → ZnCl₂ + H₂ |
| **Double Replacement** | AB + CD → AD + CB | AgNO₃ + NaCl → AgCl + NaNO₃ |
| **Combustion** | Fuel + O₂ → CO₂ + H₂O | CH₄ + 2O₂ → CO₂ + 2H₂O |

### How to Balance an Equation

1. **Write the unbalanced equation** with correct chemical formulas
2. **Count atoms** of each element on each side
3. **Add coefficients** (whole numbers in front of formulas) to make counts equal
4. **Never change subscripts** within formulas
5. **Verify** by counting all atoms on both sides

**Example: Balancing iron oxide formation**

| Step | Equation | Left | Right |
|------|---------|------|-------|
| Unbalanced | Fe + O₂ → Fe₂O₃ | Fe=1, O=2 | Fe=2, O=3 |
| Add 4Fe | 4Fe + O₂ → Fe₂O₃ | Fe=4, O=2 | Fe=2, O=3 |
| Add 3O₂ | 4Fe + 3O₂ → Fe₂O₃ | Fe=4, O=6 | Fe=2, O=3 |
| Add 2Fe₂O₃ | 4Fe + 3O₂ → 2Fe₂O₃ | Fe=4, O=6 | Fe=4, O=6 ✓ |',

'## Phản Ứng Hóa Học và Phương Trình

Phản ứng hóa học biến đổi **chất phản ứng** thành **sản phẩm** bằng cách phá vỡ các liên kết hiện có và tạo liên kết mới. Các nguyên tử được sắp xếp lại — không bao giờ được tạo ra hay phá hủy (định luật bảo toàn khối lượng).

### Dạng Phương Trình Tổng Quát

$$\text{Chất phản ứng} \rightarrow \text{Sản phẩm}$$

Viết kèm trạng thái: $2H_2(g) + O_2(g) \rightarrow 2H_2O(l)$

### Năm Loại Phản Ứng

| Loại | Dạng tổng quát | Ví dụ |
|------|--------------|------|
| **Tổng hợp** | A + B → AB | 2Na + Cl₂ → 2NaCl |
| **Phân giải** | AB → A + B | 2H₂O₂ → 2H₂O + O₂ |
| **Thế đơn** | A + BC → AC + B | Zn + 2HCl → ZnCl₂ + H₂ |
| **Thế đôi** | AB + CD → AD + CB | AgNO₃ + NaCl → AgCl + NaNO₃ |
| **Đốt cháy** | Nhiên liệu + O₂ → CO₂ + H₂O | CH₄ + 2O₂ → CO₂ + 2H₂O |

### Cách Cân Bằng Phương Trình

1. **Viết phương trình chưa cân bằng** với công thức hóa học đúng
2. **Đếm nguyên tử** mỗi nguyên tố ở mỗi vế
3. **Thêm hệ số** (số nguyên trước công thức) để số lượng bằng nhau
4. **Không bao giờ thay đổi chỉ số dưới** trong công thức
5. **Xác minh** bằng cách đếm tất cả nguyên tử ở cả hai vế

**Ví dụ: Cân bằng phản ứng tạo oxide sắt**

| Bước | Phương trình | Trái | Phải |
|------|------------|------|-----|
| Chưa cân bằng | Fe + O₂ → Fe₂O₃ | Fe=1, O=2 | Fe=2, O=3 |
| Thêm 4Fe | 4Fe + O₂ → Fe₂O₃ | Fe=4, O=2 | Fe=2, O=3 |
| Thêm 3O₂ | 4Fe + 3O₂ → Fe₂O₃ | Fe=4, O=6 | Fe=2, O=3 |
| Thêm 2Fe₂O₃ | 4Fe + 3O₂ → 2Fe₂O₃ | Fe=4, O=6 | Fe=4, O=6 ✓ |',
 1, '{}'),

-- Section 2: key_points
((SELECT id FROM lesson WHERE slug = 'chemical-reactions'),
 'key_points', 'Core Chemical Reaction Principles', 'Nguyên Tắc Phản Ứng Hóa Học Cốt Lõi',
 NULL, NULL,
 2,
 '["Synthesis: two or more reactants combine into a single product (A + B → AB)", "Decomposition: one compound breaks into two or more simpler substances (AB → A + B)", "Single replacement: one element displaces another from a compound (A + BC → AC + B)", "Combustion: fuel reacts with oxygen — hydrocarbons produce CO₂ + H₂O (complete combustion)", "Law of conservation of mass: atoms are never created or destroyed — only rearranged"]'::jsonb),

-- Section 3: diagram
((SELECT id FROM lesson WHERE slug = 'chemical-reactions'),
 'diagram', 'Five Types of Chemical Reactions', 'Năm Loại Phản Ứng Hóa Học',
 'A visual map of the five main chemical reaction types and their general patterns.',
 'Sơ đồ trực quan năm loại phản ứng hóa học chính và mô hình tổng quát của chúng.',
 3,
 '{"diagram": "graph TD\n  A[Chemical Reactions] --> B[Synthesis: A + B → AB]\n  A --> C[Decomposition: AB → A + B]\n  A --> D[Single Replacement: A + BC → AC + B]\n  A --> E[Double Replacement: AB + CD → AD + CB]\n  A --> F[Combustion: Fuel + O₂ → CO₂ + H₂O]"}'::jsonb);


-- ============================================================================
-- EXERCISES (5 exercises)
-- ============================================================================

-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'chemical-reactions'),
 'fill_blank', 'easy',
 'In a synthesis reaction, two or more substances combine to form a ___ product.',
 'Trong phản ứng tổng hợp, hai hay nhiều chất kết hợp để tạo thành một sản phẩm ___.',
 'single',
 'A synthesis (or combination) reaction always has the general form A + B → AB: multiple reactants combine to form a single product. Examples include: 2Na + Cl₂ → 2NaCl (table salt), 2H₂ + O₂ → 2H₂O (water), and C + O₂ → CO₂ (carbon dioxide). The product is always a single, more complex compound.',
 'Phản ứng tổng hợp (hoặc kết hợp) luôn có dạng tổng quát A + B → AB: nhiều chất phản ứng kết hợp thành một sản phẩm duy nhất. Ví dụ: 2Na + Cl₂ → 2NaCl (muối ăn), 2H₂ + O₂ → 2H₂O (nước) và C + O₂ → CO₂ (carbon dioxide). Sản phẩm luôn là một hợp chất duy nhất, phức tạp hơn.',
 'How many products does a synthesis reaction produce?', 'Phản ứng tổng hợp tạo ra bao nhiêu sản phẩm?',
 1);


-- Exercise 2: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'chemical-reactions'),
 'multiple_choice', 'easy',
 'What type of reaction is represented by: H₂ + Cl₂ → 2HCl?',
 'Phản ứng nào được đại diện bởi: H₂ + Cl₂ → 2HCl?',
 'This is a synthesis (combination) reaction: two reactants (H₂ and Cl₂) combine to form a single product (HCl). The pattern is A + B → AB. The equation is also correctly balanced: left side has 2H and 2Cl; right side has 2H and 2Cl (2 × HCl).',
 'Đây là phản ứng tổng hợp (kết hợp): hai chất phản ứng (H₂ và Cl₂) kết hợp thành một sản phẩm duy nhất (HCl). Mô hình là A + B → AB. Phương trình cũng được cân bằng đúng: vế trái có 2H và 2Cl; vế phải có 2H và 2Cl (2 × HCl).',
 2);

WITH mc_ex AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'chemical-reactions')
  AND type = 'multiple_choice'
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'Decomposition', 'Phân giải', FALSE, 1 FROM mc_ex
UNION ALL SELECT id, 'B'::option_label, 'Synthesis', 'Tổng hợp', TRUE, 2 FROM mc_ex
UNION ALL SELECT id, 'C'::option_label, 'Combustion', 'Đốt cháy', FALSE, 3 FROM mc_ex
UNION ALL SELECT id, 'D'::option_label, 'Single Replacement', 'Thế đơn', FALSE, 4 FROM mc_ex;


-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'chemical-reactions'),
 'true_false', 'easy',
 'The law of conservation of mass states that atoms are neither created nor destroyed in chemical reactions.',
 'Định luật bảo toàn khối lượng phát biểu rằng các nguyên tử không được tạo ra hay phá hủy trong phản ứng hóa học.',
 'true',
 'The law of conservation of mass (Antoine Lavoisier, 1789) states that the total mass of reactants equals the total mass of products in a chemical reaction. This is because atoms are neither created nor destroyed — only rearranged into new combinations. This is why chemical equations must be balanced: equal numbers of each atom on both sides.',
 'Định luật bảo toàn khối lượng (Antoine Lavoisier, 1789) phát biểu rằng tổng khối lượng chất phản ứng bằng tổng khối lượng sản phẩm trong phản ứng hóa học. Điều này vì các nguyên tử không được tạo ra hay phá hủy — chỉ được sắp xếp lại thành các tổ hợp mới. Đây là lý do tại sao phương trình hóa học phải được cân bằng: số lượng bằng nhau của mỗi nguyên tử ở cả hai vế.',
 3);


-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'chemical-reactions'),
 'fill_blank', 'medium',
 'A balanced chemical equation has equal numbers of each type of ___ on both sides of the arrow.',
 'Phương trình hóa học cân bằng có số lượng bằng nhau của mỗi loại ___ ở cả hai vế của mũi tên.',
 'atom',
 'When balancing equations, you count individual atoms of each element on both the reactant side (left) and product side (right). The equation is balanced when each element has exactly the same total count on both sides. For example, in 2H₂ + O₂ → 2H₂O: left has 4H and 2O; right has 4H and 2O — balanced.',
 'Khi cân bằng phương trình, bạn đếm các nguyên tử riêng lẻ của mỗi nguyên tố ở cả vế chất phản ứng (trái) và vế sản phẩm (phải). Phương trình cân bằng khi mỗi nguyên tố có cùng tổng số ở cả hai vế. Ví dụ, trong 2H₂ + O₂ → 2H₂O: bên trái có 4H và 2O; bên phải có 4H và 2O — cân bằng.',
 'Think about what you count on each side of the equation', 'Nghĩ về những gì bạn đếm ở mỗi vế phương trình',
 4);


-- Exercise 5: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'chemical-reactions'),
 'true_false', 'medium',
 'Combustion reactions always produce carbon dioxide and water as products.',
 'Phản ứng đốt cháy luôn tạo ra carbon dioxide và nước làm sản phẩm.',
 'false',
 'Combustion of hydrocarbons (compounds containing only carbon and hydrogen) produces CO₂ and H₂O when oxygen is abundant (complete combustion). However, combustion of substances without carbon does not produce CO₂. For example, hydrogen combustion produces only water: 2H₂ + O₂ → 2H₂O. Magnesium combustion produces magnesium oxide: 2Mg + O₂ → 2MgO. The products of combustion depend entirely on the composition of the fuel.',
 'Đốt cháy hydrocarbon (hợp chất chỉ chứa carbon và hydro) tạo ra CO₂ và H₂O khi oxy đủ (đốt cháy hoàn toàn). Tuy nhiên, đốt cháy các chất không có carbon không tạo ra CO₂. Ví dụ, đốt cháy hydro chỉ tạo ra nước: 2H₂ + O₂ → 2H₂O. Đốt cháy magiê tạo ra magnesium oxide: 2Mg + O₂ → 2MgO. Sản phẩm đốt cháy hoàn toàn phụ thuộc vào thành phần của nhiên liệu.',
 5);


-- ############################################################################
-- LESSON 3: ORGANIC CHEMISTRY BASICS (slug: organic-chemistry-basics)
-- order_index: 3
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Organic Chemistry Basics', 'Cơ Bản Hóa Học Hữu Cơ',
  'organic-chemistry-basics',
  'Understand carbon compounds, functional groups, and why carbon is the basis of life',
  'Hiểu hợp chất carbon, nhóm chức năng và tại sao carbon là cơ sở của sự sống',
  'intermediate', 40, 3
FROM category WHERE name = 'Chemistry Basics';


-- ============================================================================
-- LESSON USAGES
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'organic-chemistry-basics'),
 'Carbon Chemistry: Why Carbon Is Unique', 'Hóa Học Carbon: Tại Sao Carbon Độc Đáo',
 'Carbon (C) can form four covalent bonds, allowing it to link to other carbon atoms in long chains, rings, and branched structures — creating an almost unlimited variety of molecules. Carbon can bond with hydrogen, oxygen, nitrogen, sulfur, phosphorus, and halogens. This versatility makes carbon the backbone of all living organisms and an extraordinary range of synthetic materials including plastics, pharmaceuticals, and fuels.',
 'Carbon (C) có thể tạo bốn liên kết cộng hóa trị, cho phép nó liên kết với các nguyên tử carbon khác trong các chuỗi dài, vòng và cấu trúc phân nhánh — tạo ra sự đa dạng gần như vô hạn các phân tử. Carbon có thể liên kết với hydro, oxy, nitơ, lưu huỳnh, photpho và halogen. Tính linh hoạt này làm cho carbon là xương sống của tất cả sinh vật và một loạt các vật liệu tổng hợp đáng chú ý bao gồm nhựa, dược phẩm và nhiên liệu.',
 'Hub', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'organic-chemistry-basics'),
 'Functional Groups', 'Nhóm Chức Năng',
 'A functional group is a specific atom or group of atoms within an organic molecule that is responsible for the molecule''s characteristic chemical reactions. Functional groups determine how a molecule behaves chemically, regardless of the size of its carbon chain. Common functional groups include: hydroxyl (-OH, alcohols), carboxyl (-COOH, carboxylic acids), amino (-NH₂, amines), carbonyl (C=O, aldehydes/ketones), and ester (-COO-, esters).',
 'Nhóm chức năng là một nguyên tử cụ thể hoặc nhóm nguyên tử trong phân tử hữu cơ chịu trách nhiệm cho các phản ứng hóa học đặc trưng của phân tử. Nhóm chức năng xác định cách một phân tử cư xử về mặt hóa học, bất kể kích thước chuỗi carbon của nó. Các nhóm chức năng phổ biến bao gồm: hydroxyl (-OH, rượu), carboxyl (-COOH, acid carboxylic), amino (-NH₂, amine), carbonyl (C=O, aldehyde/ketone) và ester (-COO-, ester).',
 'Category', TRUE, 2);


-- ============================================================================
-- EXAMPLES (2 per usage)
-- ============================================================================

INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES

-- Usage 1: Carbon Chemistry
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'organic-chemistry-basics') AND order_index = 1),
 'Methane (CH₄), ethane (C₂H₆), propane (C₃H₈), and octane (C₈H₁₈) are all hydrocarbons — molecules built from only carbon and hydrogen. Their properties change dramatically with chain length: methane is a gas, octane is a liquid fuel.',
 'Methane (CH₄), ethane (C₂H₆), propane (C₃H₈) và octane (C₈H₁₈) đều là hydrocarbon — phân tử được xây dựng từ chỉ carbon và hydro. Tính chất của chúng thay đổi đáng kể theo chiều dài chuỗi: methane là khí, octane là nhiên liệu lỏng.',
 'Alkanes (hydrocarbons with single C-C bonds) follow the pattern CₙH₂ₙ₊₂. As chain length grows, boiling point increases (stronger intermolecular van der Waals forces). This is why natural gas (methane, C1) is a gas at room temperature while motor oil (C15–C40) is a viscous liquid.',
 'Alkane (hydrocarbon có liên kết C-C đơn) theo mô hình CₙH₂ₙ₊₂. Khi chiều dài chuỗi tăng, điểm sôi tăng (lực van der Waals giữa các phân tử mạnh hơn). Đây là lý do khí tự nhiên (methane, C1) là khí ở nhiệt độ phòng trong khi dầu động cơ (C15–C40) là chất lỏng nhớt.',
 'hydrocarbons', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'organic-chemistry-basics') AND order_index = 1),
 'Diamond and graphite are both pure carbon — yet diamond is the hardest natural substance while graphite is soft enough to write with. The difference is entirely in how carbon atoms are bonded to each other.',
 'Kim cương và graphit đều là carbon nguyên chất — tuy nhiên kim cương là chất tự nhiên cứng nhất trong khi graphit đủ mềm để viết. Sự khác biệt hoàn toàn nằm ở cách các nguyên tử carbon liên kết với nhau.',
 'In diamond, each carbon forms four tetrahedral single bonds to adjacent carbons — creating an incredibly rigid 3D lattice. In graphite, carbons form flat hexagonal layers with three bonds each; layers are held by weak van der Waals forces and can slide. Graphene (a single graphite layer) is the strongest known 2D material.',
 'Trong kim cương, mỗi carbon tạo bốn liên kết đơn tứ diện với các carbon lân cận — tạo ra mạng lưới 3D cực kỳ cứng. Trong graphit, các carbon tạo thành các lớp lục giác phẳng với ba liên kết mỗi cái; các lớp được giữ bởi lực van der Waals yếu và có thể trượt. Graphene (một lớp graphit đơn) là vật liệu 2D mạnh nhất được biết đến.',
 'allotropes of carbon', 2),

-- Usage 2: Functional Groups
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'organic-chemistry-basics') AND order_index = 2),
 'Ethanol (C₂H₅OH) is an alcohol — its -OH (hydroxyl) functional group makes it water-soluble, gives it a higher boiling point than ethane (C₂H₆), and allows it to undergo fermentation. Remove the -OH and you get ethane, a flammable gas with very different properties.',
 'Ethanol (C₂H₅OH) là rượu — nhóm chức -OH (hydroxyl) của nó làm cho nó tan trong nước, cho nó điểm sôi cao hơn ethane (C₂H₆) và cho phép nó trải qua quá trình lên men. Loại bỏ -OH và bạn có ethane, một khí dễ cháy với tính chất rất khác.',
 'Functional groups transform the chemistry of a molecule dramatically. The -OH group in alcohols enables hydrogen bonding (explaining high boiling points), water solubility, and specific reactions like oxidation to aldehydes or ketones. Pharmaceutical design often involves adding or modifying functional groups to control a drug''s activity, solubility, and stability.',
 'Các nhóm chức năng biến đổi đáng kể hóa học của phân tử. Nhóm -OH trong rượu cho phép liên kết hydro (giải thích điểm sôi cao), khả năng hòa tan trong nước và các phản ứng cụ thể như oxy hóa thành aldehyde hoặc ketone. Thiết kế dược phẩm thường liên quan đến việc thêm hoặc sửa đổi các nhóm chức năng để kiểm soát hoạt tính, khả năng hòa tan và độ ổn định của thuốc.',
 'hydroxyl functional group', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'organic-chemistry-basics') AND order_index = 2),
 'Acetic acid (CH₃COOH) and ethanol (C₂H₅OH) both have two carbons, but the carboxyl group (-COOH) in acetic acid makes it acidic and gives vinegar its sour taste, while the hydroxyl group (-OH) in ethanol gives it alcohol properties.',
 'Acetic acid (CH₃COOH) và ethanol (C₂H₅OH) đều có hai carbon, nhưng nhóm carboxyl (-COOH) trong acetic acid làm nó có tính acid và cho giấm vị chua của nó, trong khi nhóm hydroxyl (-OH) trong ethanol cho nó tính chất rượu.',
 'This example perfectly illustrates the principle of functional groups: same number of carbons, completely different chemistry because of different functional groups. Carboxylic acids (-COOH) donate H⁺ ions in water (making solutions acidic) while alcohols (-OH) typically do not ionize under normal conditions.',
 'Ví dụ này minh họa hoàn hảo nguyên tắc của nhóm chức năng: cùng số carbon, hóa học hoàn toàn khác vì các nhóm chức năng khác nhau. Acid carboxylic (-COOH) cho ion H⁺ vào nước (làm dung dịch có tính acid) trong khi rượu (-OH) thường không ion hóa trong điều kiện bình thường.',
 'functional groups', 2);


-- ============================================================================
-- TIPS
-- ============================================================================

INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES

((SELECT id FROM lesson WHERE slug = 'organic-chemistry-basics'),
 'Organic ≠ "natural" or "healthy"', 'Hữu cơ không có nghĩa là "tự nhiên" hay "lành mạnh"',
 'In chemistry, "organic" means a compound contains carbon (with some exceptions like CO₂, CO, and carbonates). It does not mean natural, plant-based, or healthy. Cyanide (HCN) is an organic compound. Plastics are organic compounds. "Organic food" uses a different agricultural definition. Many deadly poisons and toxic synthetic chemicals are organic molecules — the word means only "carbon-based."',
 'Trong hóa học, "hữu cơ" có nghĩa là hợp chất chứa carbon (với một số ngoại lệ như CO₂, CO và carbonate). Nó không có nghĩa là tự nhiên, có nguồn gốc thực vật hay lành mạnh. Cyanide (HCN) là hợp chất hữu cơ. Nhựa là hợp chất hữu cơ. "Thực phẩm hữu cơ" sử dụng định nghĩa nông nghiệp khác. Nhiều chất độc chết người và hóa chất tổng hợp độc hại là phân tử hữu cơ — từ này chỉ có nghĩa là "dựa trên carbon."',
 'common_mistake', 'high', 'Warning', 1),

((SELECT id FROM lesson WHERE slug = 'organic-chemistry-basics'),
 'IUPAC naming: the carbon chain is the backbone', 'Đặt tên IUPAC: chuỗi carbon là xương sống',
 'Organic compounds are named by the longest continuous carbon chain (the parent chain). Prefixes indicate chain length: meth- (1C), eth- (2C), prop- (3C), but- (4C), pent- (5C), hex- (6C), hept- (7C), oct- (8C). Suffixes indicate the main functional group: -ane (alkane), -ene (alkene, C=C double bond), -ol (alcohol, -OH), -oic acid (carboxylic acid, -COOH). Memorizing these prefixes unlocks thousands of compound names.',
 'Hợp chất hữu cơ được đặt tên theo chuỗi carbon liên tục dài nhất (chuỗi mẹ). Tiền tố cho biết độ dài chuỗi: meth- (1C), eth- (2C), prop- (3C), but- (4C), pent- (5C), hex- (6C), hept- (7C), oct- (8C). Hậu tố cho biết nhóm chức chính: -ane (alkane), -ene (alkene, liên kết đôi C=C), -ol (rượu, -OH), -oic acid (acid carboxylic, -COOH). Ghi nhớ các tiền tố này mở khóa hàng nghìn tên hợp chất.',
 'shortcut', 'high', 'Lightbulb', 2),

((SELECT id FROM lesson WHERE slug = 'organic-chemistry-basics'),
 'Carbon is the element of life — and technology', 'Carbon là nguyên tố của sự sống — và công nghệ',
 'All known life is carbon-based. The four major biomolecules — carbohydrates, lipids, proteins, and nucleic acids (DNA/RNA) — are all organic molecules. Carbon''s ability to form stable chains, rings, and functional groups creates the molecular complexity that life requires. Beyond biology, carbon-based materials include graphene (strongest 2D material), carbon fiber (stronger than steel, lighter than aluminum), and fullerenes/nanotubes used in nanotechnology.',
 'Tất cả sự sống đã biết đều dựa trên carbon. Bốn đại phân tử sinh học — carbohydrate, lipid, protein và acid nucleic (DNA/RNA) — đều là phân tử hữu cơ. Khả năng tạo chuỗi, vòng và nhóm chức năng ổn định của carbon tạo ra sự phức tạp phân tử mà sự sống đòi hỏi. Ngoài sinh học, vật liệu dựa trên carbon bao gồm graphene (vật liệu 2D mạnh nhất), sợi carbon (mạnh hơn thép, nhẹ hơn nhôm) và fullerene/ống nano dùng trong công nghệ nano.',
 'general', 'medium', 'Info', 3);


-- ============================================================================
-- LESSON SECTIONS (3 sections: markdown + key_points + info_box)
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

-- Section 1: markdown
((SELECT id FROM lesson WHERE slug = 'organic-chemistry-basics'),
 'markdown', 'Organic Chemistry: Carbon-Based Molecules', 'Hóa Học Hữu Cơ: Phân Tử Dựa Trên Carbon',
'## Organic Chemistry

Organic chemistry is the study of carbon-containing compounds — there are more carbon compounds than compounds of all other elements combined.

### Why Carbon Is Special

Carbon has 4 valence electrons, allowing it to form **4 covalent bonds**:

- Bond to other carbon atoms (chains, rings, branches)
- Bond to H, O, N, S, P, halogens (F, Cl, Br, I)
- Form single bonds (C–C), double bonds (C=C), or triple bonds (C≡C)

This gives carbon unmatched structural versatility.

### Hydrocarbons: The Simplest Organic Molecules

| Name | Formula | Bonds | State at 25°C |
|------|---------|-------|--------------|
| Methane | CH₄ | All single | Gas |
| Ethylene | C₂H₄ | One C=C double | Gas |
| Acetylene | C₂H₂ | One C≡C triple | Gas |
| Benzene | C₆H₆ | Aromatic ring | Liquid |
| Octane | C₈H₁₈ | All single | Liquid |

### Common Functional Groups

| Group | Formula | Class | Example |
|-------|---------|-------|---------|
| Hydroxyl | −OH | Alcohol | Ethanol (C₂H₅OH) |
| Carboxyl | −COOH | Carboxylic acid | Acetic acid (CH₃COOH) |
| Amino | −NH₂ | Amine | Glycine (amino acid) |
| Carbonyl | C=O | Aldehyde / Ketone | Formaldehyde / Acetone |
| Ester | −COO− | Ester | Ethyl acetate |

### The Four Biomolecules

All life is built from four classes of organic molecules:

| Biomolecule | Building blocks | Role |
|-------------|----------------|------|
| **Carbohydrates** | Monosaccharides (glucose) | Energy, structure |
| **Lipids** | Fatty acids + glycerol | Energy storage, membranes |
| **Proteins** | Amino acids (20 types) | Enzymes, structure, transport |
| **Nucleic acids** | Nucleotides | DNA (heredity), RNA (protein synthesis) |',

'## Hóa Học Hữu Cơ

Hóa học hữu cơ là nghiên cứu các hợp chất chứa carbon — có nhiều hợp chất carbon hơn tổng số hợp chất của tất cả các nguyên tố khác cộng lại.

### Tại Sao Carbon Đặc Biệt

Carbon có 4 electron hóa trị, cho phép tạo **4 liên kết cộng hóa trị**:

- Liên kết với các nguyên tử carbon khác (chuỗi, vòng, phân nhánh)
- Liên kết với H, O, N, S, P, halogen (F, Cl, Br, I)
- Tạo liên kết đơn (C–C), liên kết đôi (C=C) hoặc liên kết ba (C≡C)

Điều này cho carbon tính linh hoạt cấu trúc vô song.

### Hydrocarbon: Phân Tử Hữu Cơ Đơn Giản Nhất

| Tên | Công thức | Liên kết | Trạng thái ở 25°C |
|-----|----------|---------|-----------------|
| Methane | CH₄ | Tất cả đơn | Khí |
| Ethylene | C₂H₄ | Một liên kết C=C đôi | Khí |
| Acetylene | C₂H₂ | Một liên kết C≡C ba | Khí |
| Benzene | C₆H₆ | Vòng thơm | Lỏng |
| Octane | C₈H₁₈ | Tất cả đơn | Lỏng |

### Các Nhóm Chức Năng Phổ Biến

| Nhóm | Công thức | Lớp | Ví dụ |
|------|----------|-----|------|
| Hydroxyl | −OH | Rượu | Ethanol (C₂H₅OH) |
| Carboxyl | −COOH | Acid carboxylic | Acetic acid (CH₃COOH) |
| Amino | −NH₂ | Amine | Glycine (amino acid) |
| Carbonyl | C=O | Aldehyde / Ketone | Formaldehyde / Acetone |
| Ester | −COO− | Ester | Ethyl acetate |

### Bốn Đại Phân Tử Sinh Học

Tất cả sự sống được xây dựng từ bốn lớp phân tử hữu cơ:

| Đại phân tử | Đơn vị cấu tạo | Vai trò |
|-------------|--------------|--------|
| **Carbohydrate** | Monosaccharide (glucose) | Năng lượng, cấu trúc |
| **Lipid** | Acid béo + glycerol | Dự trữ năng lượng, màng |
| **Protein** | Amino acid (20 loại) | Enzyme, cấu trúc, vận chuyển |
| **Acid nucleic** | Nucleotide | DNA (di truyền), RNA (tổng hợp protein) |',
 1, '{}'),

-- Section 2: key_points
((SELECT id FROM lesson WHERE slug = 'organic-chemistry-basics'),
 'key_points', 'Core Organic Chemistry Concepts', 'Khái Niệm Cốt Lõi Hóa Học Hữu Cơ',
 NULL, NULL,
 2,
 '["Organic chemistry studies carbon-containing compounds — the chemistry of life and most synthetic materials", "Carbon forms 4 covalent bonds: it can chain with other carbons and bond H, O, N, S creating enormous molecular diversity", "Hydrocarbons contain only C and H; they are the basis of fuels, plastics, and many industrial chemicals", "Functional groups (−OH, −COOH, −NH₂, C=O) determine a molecule''s chemical behavior regardless of carbon chain length", "All four classes of biomolecules (carbohydrates, lipids, proteins, nucleic acids) are carbon-based organic molecules"]'::jsonb),

-- Section 3: info_box (why carbon is special)
((SELECT id FROM lesson WHERE slug = 'organic-chemistry-basics'),
 'info_box', 'Why Carbon Is the Basis of Life', 'Tại Sao Carbon Là Cơ Sở Của Sự Sống',
 'Carbon''s unique suitability for life comes from four properties working together. First, carbon forms four stable covalent bonds — more than hydrogen (1), oxygen (2), or nitrogen (3). Second, carbon-carbon bonds are strong enough to be stable in liquid water at biological temperatures, yet weak enough to be broken and reformed by enzymes. Third, carbon can form chains of hundreds or thousands of atoms, creating the molecular complexity needed for information storage (DNA) and catalysis (enzymes). Fourth, carbon chemistry is compatible with water — most organic molecules can interact with water through hydrogen bonding while maintaining structural integrity. Silicon, which sits below carbon in the periodic table and also forms four bonds, was once considered a candidate for alternative life. However, silicon-oxygen bonds form rigid solids (silicate rocks) rather than flexible chains, and silicon does not form the same diverse functional groups as carbon. All known life uses carbon.',
 'Sự phù hợp độc đáo của carbon cho sự sống đến từ bốn tính chất kết hợp với nhau. Thứ nhất, carbon tạo bốn liên kết cộng hóa trị ổn định — nhiều hơn hydro (1), oxy (2) hoặc nitơ (3). Thứ hai, liên kết carbon-carbon đủ mạnh để ổn định trong nước lỏng ở nhiệt độ sinh học, nhưng đủ yếu để bị phá vỡ và tái tạo bởi enzyme. Thứ ba, carbon có thể tạo chuỗi hàng trăm hoặc hàng nghìn nguyên tử, tạo ra sự phức tạp phân tử cần thiết cho lưu trữ thông tin (DNA) và xúc tác (enzyme). Thứ tư, hóa học carbon tương thích với nước — hầu hết phân tử hữu cơ có thể tương tác với nước thông qua liên kết hydro trong khi duy trì tính toàn vẹn cấu trúc. Silicon, nằm dưới carbon trong bảng tuần hoàn và cũng tạo bốn liên kết, từng được coi là ứng cử viên cho sự sống thay thế. Tuy nhiên, liên kết silicon-oxy tạo thành chất rắn cứng (đá silicate) thay vì chuỗi linh hoạt, và silicon không tạo ra các nhóm chức năng đa dạng như carbon. Tất cả sự sống đã biết đều sử dụng carbon.',
 3, '{"variant": "info"}'::jsonb);


-- ============================================================================
-- EXERCISES (5 exercises)
-- ============================================================================

-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'organic-chemistry-basics'),
 'fill_blank', 'easy',
 'Organic chemistry is primarily the study of compounds containing the element ___.',
 'Hóa học hữu cơ chủ yếu là nghiên cứu các hợp chất chứa nguyên tố ___.',
 'carbon',
 'Organic chemistry is defined as the chemistry of carbon-containing compounds, with a few exceptions (CO₂, CO, carbonates, and cyanides are sometimes classified as inorganic). Carbon''s ability to form four covalent bonds and chain with other carbon atoms produces millions of distinct compounds — far more than any other element.',
 'Hóa học hữu cơ được định nghĩa là hóa học của các hợp chất chứa carbon, với một số ngoại lệ (CO₂, CO, carbonate và cyanide đôi khi được phân loại là vô cơ). Khả năng tạo bốn liên kết cộng hóa trị và liên kết với các nguyên tử carbon khác tạo ra hàng triệu hợp chất khác biệt — nhiều hơn bất kỳ nguyên tố nào khác.',
 'This element forms the backbone of all living molecules', 'Nguyên tố này tạo thành xương sống của tất cả phân tử sống',
 1);


-- Exercise 2: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'organic-chemistry-basics'),
 'multiple_choice', 'easy',
 'What is a functional group in organic chemistry?',
 'Nhóm chức năng trong hóa học hữu cơ là gì?',
 'A functional group is a specific atom or group of atoms within an organic molecule that is primarily responsible for the molecule''s chemical reactions and properties. The same functional group (such as -OH) gives similar chemical behavior to all molecules containing it, regardless of the rest of the carbon structure. This is why understanding functional groups is the key to understanding organic reactions.',
 'Nhóm chức năng là một nguyên tử cụ thể hoặc nhóm nguyên tử trong phân tử hữu cơ chịu trách nhiệm chính cho các phản ứng hóa học và tính chất của phân tử. Cùng một nhóm chức năng (như -OH) cho hành vi hóa học tương tự cho tất cả phân tử chứa nó, bất kể phần còn lại của cấu trúc carbon. Đây là lý do tại sao hiểu nhóm chức năng là chìa khóa để hiểu phản ứng hữu cơ.',
 2);

WITH mc_ex AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'organic-chemistry-basics')
  AND type = 'multiple_choice'
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'A group of elements on the periodic table with similar properties', 'Một nhóm nguyên tố trên bảng tuần hoàn có tính chất tương tự', FALSE, 1 FROM mc_ex
UNION ALL SELECT id, 'B'::option_label, 'An atom or group of atoms that determines a molecule''s characteristic chemical behavior', 'Một nguyên tử hoặc nhóm nguyên tử xác định hành vi hóa học đặc trưng của phân tử', TRUE, 2 FROM mc_ex
UNION ALL SELECT id, 'C'::option_label, 'A type of chemical reaction specific to organic compounds', 'Một loại phản ứng hóa học đặc thù cho hợp chất hữu cơ', FALSE, 3 FROM mc_ex
UNION ALL SELECT id, 'D'::option_label, 'A unit of measurement for organic molecules', 'Một đơn vị đo lường cho phân tử hữu cơ', FALSE, 4 FROM mc_ex;


-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'organic-chemistry-basics'),
 'true_false', 'easy',
 'Hydrocarbons contain only hydrogen and carbon atoms.',
 'Hydrocarbon chỉ chứa nguyên tử hydro và carbon.',
 'true',
 'By definition, hydrocarbons are organic compounds composed exclusively of hydrogen (H) and carbon (C). They include alkanes (all single bonds: CₙH₂ₙ₊₂), alkenes (one or more C=C double bonds: CₙH₂ₙ), alkynes (one or more C≡C triple bonds: CₙH₂ₙ₋₂), and aromatic hydrocarbons (benzene ring structures). Natural gas, petroleum, and coal are primarily hydrocarbon mixtures.',
 'Theo định nghĩa, hydrocarbon là hợp chất hữu cơ chỉ gồm hydro (H) và carbon (C). Chúng bao gồm alkane (tất cả liên kết đơn: CₙH₂ₙ₊₂), alkene (một hoặc nhiều liên kết đôi C=C: CₙH₂ₙ), alkyne (một hoặc nhiều liên kết ba C≡C: CₙH₂ₙ₋₂) và hydrocarbon thơm (cấu trúc vòng benzene). Khí tự nhiên, dầu mỏ và than đá chủ yếu là hỗn hợp hydrocarbon.',
 3);


-- Exercise 4: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'organic-chemistry-basics'),
 'fill_blank', 'easy',
 'The simplest hydrocarbon is ___, which has the formula CH₄ and contains one carbon atom.',
 'Hydrocarbon đơn giản nhất là ___, có công thức CH₄ và chứa một nguyên tử carbon.',
 'methane',
 'Methane (CH₄) is the simplest alkane — one carbon atom bonded to four hydrogen atoms. It is the main component of natural gas and is also produced by anaerobic bacteria (marsh gas, landfill gas, bovine digestion). Methane is a potent greenhouse gas, approximately 25 times more effective than CO₂ at trapping heat over a 100-year period.',
 'Methane (CH₄) là alkane đơn giản nhất — một nguyên tử carbon liên kết với bốn nguyên tử hydro. Nó là thành phần chính của khí tự nhiên và cũng được tạo ra bởi vi khuẩn kỵ khí (khí đầm lầy, khí bãi rác, tiêu hóa bò). Methane là khí nhà kính mạnh, hiệu quả hơn khoảng 25 lần so với CO₂ trong việc giữ nhiệt trong giai đoạn 100 năm.',
 'The IUPAC prefix for one carbon is "meth-"', 'Tiền tố IUPAC cho một carbon là "meth-"',
 4);


-- Exercise 5: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'organic-chemistry-basics'),
 'true_false', 'easy',
 'Proteins and DNA are both organic molecules.',
 'Protein và DNA đều là phân tử hữu cơ.',
 'true',
 'Proteins are polymers of amino acids — all organic molecules containing carbon chains with amino (-NH₂) and carboxyl (-COOH) functional groups. DNA (deoxyribonucleic acid) is a polymer of nucleotides, each containing a deoxyribose sugar (C₅H₁₀O₄), a phosphate group, and one of four nitrogenous bases — all carbon-containing organic molecules. Both are essential biomolecules that define life as we know it.',
 'Protein là polymer của các amino acid — tất cả đều là phân tử hữu cơ chứa chuỗi carbon với các nhóm chức amino (-NH₂) và carboxyl (-COOH). DNA (deoxyribonucleic acid) là polymer của các nucleotide, mỗi cái chứa đường deoxyribose (C₅H₁₀O₄), nhóm phosphate và một trong bốn base nitơ — tất cả đều là phân tử hữu cơ chứa carbon. Cả hai đều là đại phân tử sinh học thiết yếu xác định sự sống như chúng ta biết.',
 5);
