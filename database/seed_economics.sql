-- ============================================================================
-- SEED DATA: Economics 101 (1 lesson)
-- Category: Economics 101 (ID 14)
-- Lesson: Supply and Demand
-- Compatible with: schema.sql v7+
-- Applied AFTER: seed_physics (category 13)
-- Demonstrates: chart section (line — supply/demand curves with equilibrium)
-- ============================================================================

-- ============================================================================
-- CATEGORY 14: Economics 101
-- ============================================================================

INSERT INTO category (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('Economics 101', 'Kinh Tế Học 101',
 'Understand how markets work: supply and demand, pricing, incentives, and economic decision-making',
 'Hiểu cách thị trường hoạt động: cung và cầu, định giá, động cơ kinh tế và ra quyết định',
 'TrendingUp', '#f97316', 14);


-- ############################################################################
-- LESSON: SUPPLY AND DEMAND (slug: economics-supply-demand)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Supply and Demand', 'Cung và Cầu',
  'economics-supply-demand',
  'Learn how prices emerge from the interaction of supply and demand in free markets',
  'Học cách giá cả hình thành từ sự tương tác giữa cung và cầu trong thị trường tự do',
  'beginner', 25, 1
FROM category WHERE name = 'Economics 101';


-- ============================================================================
-- LESSON USAGES
-- ============================================================================

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'economics-supply-demand'),
 'The Law of Demand', 'Quy Luật Cầu',
 'As the price of a good rises, the quantity demanded falls (and vice versa) — all else being equal. This inverse relationship forms a downward-sloping demand curve. Consumers seek substitutes or simply buy less when prices are high.',
 'Khi giá của một hàng hóa tăng, lượng cầu giảm (và ngược lại) — khi các yếu tố khác không đổi. Mối quan hệ nghịch này tạo thành đường cầu dốc xuống. Người tiêu dùng tìm hàng thay thế hoặc đơn giản là mua ít hơn khi giá cao.',
 'ShoppingCart', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'economics-supply-demand'),
 'The Law of Supply', 'Quy Luật Cung',
 'As the price of a good rises, producers are willing to supply more of it — higher prices make production more profitable. This direct relationship forms an upward-sloping supply curve.',
 'Khi giá của một hàng hóa tăng, nhà sản xuất sẵn sàng cung cấp nhiều hơn — giá cao hơn khiến sản xuất có lời hơn. Mối quan hệ thuận này tạo thành đường cung dốc lên.',
 'Inventory', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'economics-supply-demand'),
 'Market Equilibrium', 'Cân Bằng Thị Trường',
 'Equilibrium occurs where the supply and demand curves intersect — the quantity suppliers produce exactly matches what consumers want to buy at that price. If price rises above equilibrium, surplus occurs; if it falls below, shortage occurs.',
 'Cân bằng xảy ra khi đường cung và cầu giao nhau — lượng nhà sản xuất cung cấp khớp chính xác với lượng người tiêu dùng muốn mua ở mức giá đó. Nếu giá vượt cân bằng, xuất hiện dư thừa; nếu giảm dưới cân bằng, xuất hiện thiếu hụt.',
 'Balance', TRUE, 3);


-- ============================================================================
-- EXAMPLES (2 per usage)
-- ============================================================================

INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES

-- Usage 1: Law of Demand
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'economics-supply-demand') AND order_index = 1),
 'When gasoline prices doubled in 2022, many consumers reduced driving, carpooled, or switched to public transit — demonstrating the Law of Demand.',
 'Khi giá xăng tăng gấp đôi năm 2022, nhiều người tiêu dùng giảm lái xe, đi chung xe hoặc chuyển sang giao thông công cộng — minh chứng Quy luật Cầu.',
 'The Law of Demand applies to virtually all normal goods. Consumers respond to price increases by: (1) buying less of the item, (2) switching to substitutes, or (3) delaying purchase. The steepness of the demand curve shows how sensitive consumers are to price changes (price elasticity).',
 'Quy luật Cầu áp dụng cho hầu hết hàng hóa thông thường. Người tiêu dùng phản ứng với giá tăng bằng cách: (1) mua ít hơn, (2) chuyển sang hàng thay thế, hoặc (3) trì hoãn mua. Độ dốc đường cầu cho thấy người tiêu dùng nhạy cảm như thế nào với thay đổi giá (độ co giãn giá).',
 'Law of Demand', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'economics-supply-demand') AND order_index = 1),
 'iPhone demand dropped when Apple raised prices by 20%. Some customers bought older models, switched to Android, or kept their existing phones longer.',
 'Nhu cầu iPhone giảm khi Apple tăng giá 20%. Một số khách hàng mua dòng cũ hơn, chuyển sang Android, hoặc giữ điện thoại hiện tại lâu hơn.',
 'Luxury goods and necessities have different demand elasticities. Insulin (a life necessity) has highly inelastic demand — people buy it regardless of price. iPhones have more elastic demand — consumers have alternatives.',
 'Hàng xa xỉ và hàng thiết yếu có độ co giãn cầu khác nhau. Insulin (thiết yếu sống còn) có cầu rất kém co giãn — người mua bất kể giá. iPhone có cầu co giãn hơn — người tiêu dùng có lựa chọn thay thế.',
 'demand elasticity', 2),

-- Usage 2: Law of Supply
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'economics-supply-demand') AND order_index = 2),
 'When coffee prices rose to record highs in 2011, Brazilian farmers converted cattle pastures into coffee plantations to capture higher profits.',
 'Khi giá cà phê tăng lên mức kỷ lục năm 2011, nông dân Brazil chuyển đổi đồng cỏ chăn nuôi sang vườn cà phê để thu lợi nhuận cao hơn.',
 'The Law of Supply explains why higher prices attract more producers. In the short term, existing producers work harder or invest more. In the long term, new producers enter the market, eventually pushing prices back down — the "invisible hand" at work.',
 'Quy luật Cung giải thích tại sao giá cao hơn thu hút nhiều nhà sản xuất hơn. Ngắn hạn, nhà sản xuất hiện tại làm việc nhiều hơn hoặc đầu tư thêm. Dài hạn, nhà sản xuất mới gia nhập thị trường, cuối cùng đẩy giá xuống — "bàn tay vô hình" hoạt động.',
 'Law of Supply', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'economics-supply-demand') AND order_index = 2),
 'Software companies can supply unlimited digital copies at near-zero marginal cost, which is why software prices are often low despite high initial development costs.',
 'Các công ty phần mềm có thể cung cấp bản sao kỹ thuật số không giới hạn với chi phí cận biên gần bằng không, đó là lý do giá phần mềm thường thấp dù chi phí phát triển ban đầu cao.',
 'Digital goods have unusual supply curves — after the first copy is created, each additional copy costs virtually nothing to produce. This is why software, music, and movies follow different economic rules than physical goods.',
 'Hàng hóa kỹ thuật số có đường cung bất thường — sau khi tạo ra bản sao đầu tiên, mỗi bản sao thêm hầu như không tốn chi phí sản xuất. Đây là lý do phần mềm, âm nhạc và phim theo quy tắc kinh tế khác hàng hóa vật chất.',
 'marginal cost', 2),

-- Usage 3: Market Equilibrium
((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'economics-supply-demand') AND order_index = 3),
 'During COVID-19, hand sanitizer demand surged while supply couldn''t keep up — creating a shortage that drove prices from $3 to $50 per bottle.',
 'Trong COVID-19, nhu cầu nước rửa tay tăng vọt trong khi cung không theo kịp — tạo ra tình trạng thiếu hụt đẩy giá từ $3 lên $50 mỗi chai.',
 'A shortage occurs when quantity demanded exceeds quantity supplied at the current price. The market resolves this by raising prices until demand falls or supply increases to meet it. This is the market''s natural self-correcting mechanism.',
 'Thiếu hụt xảy ra khi lượng cầu vượt lượng cung ở mức giá hiện tại. Thị trường giải quyết bằng cách tăng giá cho đến khi cầu giảm hoặc cung tăng để đáp ứng. Đây là cơ chế tự điều chỉnh tự nhiên của thị trường.',
 'shortage', 1),

((SELECT id FROM lesson_usage WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'economics-supply-demand') AND order_index = 3),
 'A housing glut in suburban areas (excess supply) drives down rents and home prices until developers stop building and buyers enter the market — restoring equilibrium.',
 'Tình trạng dư thừa nhà ở ở các khu vực ngoại ô (cung thừa) đẩy giá thuê và giá nhà xuống cho đến khi nhà phát triển ngừng xây và người mua vào thị trường — khôi phục cân bằng.',
 'A surplus (excess supply) occurs when quantity supplied exceeds quantity demanded. Unlike shortages, surpluses physically accumulate as unsold inventory, creating strong pressure on sellers to lower prices.',
 'Dư thừa (thừa cung) xảy ra khi lượng cung vượt lượng cầu. Khác với thiếu hụt, dư thừa tích lũy vật chất thành hàng tồn kho chưa bán, tạo áp lực mạnh buộc người bán hạ giá.',
 'surplus', 2);


-- ============================================================================
-- TIPS
-- ============================================================================

INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES

((SELECT id FROM lesson WHERE slug = 'economics-supply-demand'),
 '"Demand" means willingness AND ability to pay', '"Cầu" nghĩa là sẵn sàng VÀ có khả năng trả',
 'Economic "demand" is not just desire — it requires both the willingness to buy AND the ability to pay. A billionaire wanting a rare painting AND a student who can afford it are both "demand." Someone who wants a Ferrari but cannot afford one is not market demand — it''s just a wish.',
 '"Cầu" trong kinh tế không chỉ là mong muốn — cần cả sự sẵn sàng mua VÀ khả năng trả tiền. Tỷ phú muốn bức tranh quý VÀ sinh viên có đủ tiền mua đều là "cầu." Người muốn Ferrari nhưng không đủ tiền không phải cầu thị trường — đó chỉ là mơ ước.',
 'common_mistake', 'high', 'Warning', 1),

((SELECT id FROM lesson WHERE slug = 'economics-supply-demand'),
 'Price is the signal, not the cause', 'Giá là tín hiệu, không phải nguyên nhân',
 'Prices emerge from supply and demand — they don''t cause supply and demand. When prices rise, they signal scarcity; when they fall, they signal surplus. Price controls (rent control, price ceilings) interfere with these signals, often causing worse shortages or surpluses over time.',
 'Giá cả xuất hiện từ cung và cầu — chúng không gây ra cung và cầu. Khi giá tăng, chúng báo hiệu sự khan hiếm; khi giảm, báo hiệu dư thừa. Kiểm soát giá (kiểm soát tiền thuê, trần giá) cản trở các tín hiệu này, thường gây thiếu hụt hoặc dư thừa tệ hơn theo thời gian.',
 'general', 'high', 'Lightbulb', 2),

((SELECT id FROM lesson WHERE slug = 'economics-supply-demand'),
 'Ceteris paribus: all else being equal', 'Ceteris paribus: tất cả yếu tố khác không đổi',
 'Economic laws like "demand falls when price rises" apply only when all other factors remain constant (income, preferences, prices of related goods, etc.). In reality, multiple factors change simultaneously — a good economist identifies which variable changed and isolates its effect.',
 'Các quy luật kinh tế như "cầu giảm khi giá tăng" chỉ áp dụng khi tất cả yếu tố khác không đổi (thu nhập, sở thích, giá hàng liên quan, v.v.). Thực tế, nhiều yếu tố thay đổi đồng thời — nhà kinh tế học giỏi xác định biến nào thay đổi và tách riêng tác động của nó.',
 'shortcut', 'medium', 'Info', 3);


-- ============================================================================
-- LESSON SECTIONS (3 sections: markdown + chart + key_points)
-- Demonstrates: chart section (line — supply and demand curves crossing)
-- ============================================================================

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

-- Section 1: markdown
((SELECT id FROM lesson WHERE slug = 'economics-supply-demand'),
 'markdown', 'How Markets Set Prices', 'Thị Trường Thiết Lập Giá Như Thế Nào',
'## Supply and Demand: The Foundation of Market Economics

Every price you see — from a cup of coffee to a home — emerges from the interaction of **supply** and **demand**.

### The Law of Demand

> As price increases, quantity demanded decreases (all else equal)

| Price | Quantity Demanded |
|-------|-------------------|
| $1 | 100 units |
| $2 | 80 units |
| $3 | 60 units |
| $4 | 50 units |
| $5 | 35 units |

### The Law of Supply

> As price increases, quantity supplied increases (all else equal)

Producers want to sell more when prices are high because it''s more profitable.

### Market Equilibrium

**Equilibrium** is the price where supply equals demand. At this price:
- No buyer wants to buy more than is available
- No seller has unsold inventory

**Disequilibrium states:**
| Situation | Cause | Effect |
|-----------|-------|--------|
| **Shortage** | Price below equilibrium | Buyers compete → price rises |
| **Surplus** | Price above equilibrium | Sellers compete → price falls |

> Markets are self-correcting: shortages push prices up; surpluses push prices down.',

'## Cung và Cầu: Nền Tảng Kinh Tế Học Thị Trường

Mọi giá cả bạn thấy — từ ly cà phê đến ngôi nhà — đều xuất hiện từ sự tương tác giữa **cung** và **cầu**.

### Quy Luật Cầu

> Khi giá tăng, lượng cầu giảm (các yếu tố khác không đổi)

| Giá | Lượng Cầu |
|-----|----------|
| $1 | 100 đơn vị |
| $2 | 80 đơn vị |
| $3 | 60 đơn vị |
| $4 | 50 đơn vị |
| $5 | 35 đơn vị |

### Quy Luật Cung

> Khi giá tăng, lượng cung tăng (các yếu tố khác không đổi)

Nhà sản xuất muốn bán nhiều hơn khi giá cao vì có lợi nhuận hơn.

### Cân Bằng Thị Trường

**Cân bằng** là mức giá mà cung bằng cầu. Ở mức giá này:
- Không người mua nào muốn mua nhiều hơn lượng có sẵn
- Không người bán nào có hàng tồn kho

**Trạng thái mất cân bằng:**
| Tình huống | Nguyên nhân | Tác động |
|-----------|-------------|---------|
| **Thiếu hụt** | Giá dưới cân bằng | Người mua cạnh tranh → giá tăng |
| **Dư thừa** | Giá trên cân bằng | Người bán cạnh tranh → giá giảm |

> Thị trường tự điều chỉnh: thiếu hụt đẩy giá lên; dư thừa đẩy giá xuống.',
 1, '{}'),

-- Section 2: chart (line chart — supply/demand curves showing equilibrium at $4)
((SELECT id FROM lesson WHERE slug = 'economics-supply-demand'),
 'chart', 'Supply & Demand Curves — Finding Equilibrium', 'Đường Cung & Cầu — Tìm Cân Bằng',
 'The two curves cross at $4 with 50 units — this is the market equilibrium price. Below $4 there is shortage (demand > supply); above $4 there is surplus (supply > demand).',
 'Hai đường giao nhau tại $4 với 50 đơn vị — đây là giá cân bằng thị trường. Dưới $4 có thiếu hụt (cầu > cung); trên $4 có dư thừa (cung > cầu).',
 2,
 '{"chartType":"line","xKey":"price","series":[{"dataKey":"demand","name":"Cầu (Demand)"},{"dataKey":"supply","name":"Cung (Supply)"}],"data":[{"price":"$1","demand":100,"supply":10},{"price":"$2","demand":80,"supply":25},{"price":"$3","demand":60,"supply":40},{"price":"$4","demand":50,"supply":50},{"price":"$5","demand":35,"supply":65},{"price":"$6","demand":20,"supply":80},{"price":"$7","demand":10,"supply":100}],"colors":["#ef4444","#10b981"]}'),

-- Section 3: key_points
((SELECT id FROM lesson WHERE slug = 'economics-supply-demand'),
 'key_points', 'Key Economics Principles', 'Nguyên Tắc Kinh Tế Học Quan Trọng',
 '- **Law of Demand** — as price rises, quantity demanded falls (inverse relationship); consumers seek substitutes or buy less
- **Law of Supply** — as price rises, quantity supplied increases (direct relationship); higher prices attract more producers
- **Equilibrium** — the price where quantity supplied = quantity demanded; the market naturally moves toward this point
- **Shortage** — when price is below equilibrium: demand > supply → price rises to restore balance
- **Surplus** — when price is above equilibrium: supply > demand → price falls to restore balance
- **Ceteris paribus** — laws hold only when all other factors (income, preferences, technology) are held constant',
 '- **Quy luật Cầu** — khi giá tăng, lượng cầu giảm (quan hệ nghịch); người tiêu dùng tìm hàng thay thế hoặc mua ít hơn
- **Quy luật Cung** — khi giá tăng, lượng cung tăng (quan hệ thuận); giá cao hơn thu hút nhiều nhà sản xuất hơn
- **Cân bằng** — mức giá lượng cung = lượng cầu; thị trường tự nhiên di chuyển về điểm này
- **Thiếu hụt** — khi giá dưới cân bằng: cầu > cung → giá tăng để khôi phục cân bằng
- **Dư thừa** — khi giá trên cân bằng: cung > cầu → giá giảm để khôi phục cân bằng
- **Ceteris paribus** — quy luật đúng chỉ khi tất cả yếu tố khác (thu nhập, sở thích, công nghệ) không đổi',
 3, '{}');


-- ============================================================================
-- EXERCISES (7 exercises — all types)
-- ============================================================================

-- Exercise 1: multiple_choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'economics-supply-demand'),
 'multiple_choice', 'easy',
 'When demand for a product increases while supply remains constant, what happens to the equilibrium price?',
 'Khi cầu về một sản phẩm tăng trong khi cung không đổi, điều gì xảy ra với giá cân bằng?',
 'With higher demand and unchanged supply, more buyers compete for the same goods. This competition pushes the equilibrium price upward until the market clears again.',
 'Với cầu cao hơn và cung không đổi, nhiều người mua hơn cạnh tranh cho cùng lượng hàng. Sự cạnh tranh này đẩy giá cân bằng lên cho đến khi thị trường cân bằng lại.',
 1);

WITH mc_ex AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'economics-supply-demand')
  AND type = 'multiple_choice'
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index)
SELECT id, 'A'::option_label, 'Price rises', 'Giá tăng', TRUE, 1 FROM mc_ex
UNION ALL SELECT id, 'B'::option_label, 'Price falls', 'Giá giảm', FALSE, 2 FROM mc_ex
UNION ALL SELECT id, 'C'::option_label, 'Price stays the same', 'Giá không đổi', FALSE, 3 FROM mc_ex
UNION ALL SELECT id, 'D'::option_label, 'Supply also increases', 'Cung cũng tăng', FALSE, 4 FROM mc_ex;


-- Exercise 2: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'economics-supply-demand'),
 'fill_blank', 'easy',
 'The price at which the quantity supplied exactly equals the quantity demanded is called the _____ price.',
 'Mức giá mà lượng cung bằng chính xác lượng cầu được gọi là giá _____.',
 'equilibrium',
 'The equilibrium price is where the supply and demand curves intersect. At this price, every willing buyer finds a seller and every willing seller finds a buyer — the market "clears."',
 'Giá cân bằng là nơi đường cung và cầu giao nhau. Ở mức giá này, mỗi người mua sẵn sàng đều tìm được người bán và ngược lại — thị trường được "giải phóng."',
 'It''s the point where supply and demand meet', 'Đây là điểm giao nhau của cung và cầu',
 2);


-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'economics-supply-demand'),
 'true_false', 'easy',
 'According to the Law of Supply, if the price of wheat rises, farmers will want to produce and sell less wheat.',
 'Theo Quy luật Cung, nếu giá lúa mì tăng, nông dân sẽ muốn sản xuất và bán ít lúa mì hơn.',
 'false',
 'This is the opposite of the Law of Supply. When price rises, producers have greater incentive to supply MORE because each unit sold generates higher profit. Farmers would plant more wheat, not less, when prices are high.',
 'Đây là ngược lại Quy luật Cung. Khi giá tăng, nhà sản xuất có động lực lớn hơn để cung ứng NHIỀU hơn vì mỗi đơn vị bán ra có lợi nhuận cao hơn. Nông dân sẽ trồng nhiều lúa mì hơn, không phải ít hơn, khi giá cao.',
 3);


-- Exercise 4: matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'economics-supply-demand'),
 'matching', 'medium',
 'Match each economic situation to what happens to price.',
 'Ghép mỗi tình huống kinh tế với điều xảy ra với giá cả.',
 'Shortage (demand > supply) → price rises. Surplus (supply > demand) → price falls. Equilibrium (supply = demand) → price is stable. Inelastic demand → price change has little effect on quantity.',
 'Thiếu hụt (cầu > cung) → giá tăng. Dư thừa (cung > cầu) → giá giảm. Cân bằng (cung = cầu) → giá ổn định. Cầu kém co giãn → thay đổi giá ít ảnh hưởng đến lượng.',
 4);

WITH match_ex AS (
  SELECT id FROM exercise
  WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'economics-supply-demand')
  AND type = 'matching'
)
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index)
SELECT id, 'Shortage', 'Thiếu hụt', 'Price rises until balance is restored', 'Giá tăng cho đến khi cân bằng được khôi phục', 1 FROM match_ex
UNION ALL SELECT id, 'Surplus', 'Dư thừa', 'Price falls until balance is restored', 'Giá giảm cho đến khi cân bằng được khôi phục', 2 FROM match_ex
UNION ALL SELECT id, 'Equilibrium', 'Cân bằng', 'Price is stable; supply = demand', 'Giá ổn định; cung = cầu', 3 FROM match_ex
UNION ALL SELECT id, 'Demand increases', 'Cầu tăng', 'Equilibrium price rises', 'Giá cân bằng tăng', 4 FROM match_ex;


-- Exercise 5: arrange_words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'economics-supply-demand'),
 'arrange_words', 'medium',
 'Arrange these market events in correct order when a sudden shortage occurs.',
 'Sắp xếp các sự kiện thị trường theo đúng thứ tự khi xảy ra thiếu hụt đột ngột.',
 'Demand exceeds supply, Buyers compete for limited goods, Prices rise, Supply increases and demand falls, New equilibrium is reached',
 '["Buyers compete for limited goods", "Prices rise", "Demand exceeds supply", "New equilibrium is reached", "Supply increases and demand falls"]',
 'This sequence shows the market''s self-correcting mechanism: shortage → competition → higher prices → supply response → new equilibrium. Markets naturally eliminate shortages through price adjustment.',
 'Chuỗi này cho thấy cơ chế tự điều chỉnh của thị trường: thiếu hụt → cạnh tranh → giá cao hơn → phản ứng cung → cân bằng mới. Thị trường tự nhiên loại bỏ thiếu hụt thông qua điều chỉnh giá.',
 5);


-- Exercise 6: error_correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'economics-supply-demand'),
 'error_correction', 'medium',
 'Fix the economic error: "Higher prices always increase demand for all goods because consumers associate high prices with better quality."',
 'Sửa lỗi kinh tế: "Giá cao hơn luôn tăng cầu cho tất cả hàng hóa vì người tiêu dùng liên kết giá cao với chất lượng tốt hơn."',
 'Higher prices generally decrease demand for most goods (Law of Demand). While some luxury or Veblen goods may see increased demand at higher prices, this is a rare exception — not the general rule.',
 'According to the Law of Demand, higher price → lower quantity demanded (inverse relationship). The statement reverses causation. Veblen goods (luxury items) are an exception but not the rule for all goods.',
 'Giá cao hơn thường giảm cầu cho hầu hết hàng hóa (Quy luật Cầu). Mặc dù một số hàng xa xỉ hay hàng Veblen có thể thấy cầu tăng ở giá cao hơn, đây là ngoại lệ hiếm gặp — không phải quy tắc chung.',
 6);


-- Exercise 7: sentence_transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'economics-supply-demand'),
 'sentence_transform', 'hard',
 'Transform this demand scenario into a prediction: "An unusually cold winter increases the demand for heating fuel while supply remains unchanged."',
 'Chuyển đổi tình huống cầu này thành dự đoán: "Mùa đông lạnh bất thường làm tăng cầu nhiên liệu sưởi trong khi cung không đổi."',
 'With higher demand and unchanged supply, a shortage will develop, causing the equilibrium price of heating fuel to rise until the market clears.',
 'Increased demand shifts the demand curve right, creating a shortage at the old price. Competing buyers bid up the price until a new higher equilibrium is reached where quantity demanded and supplied balance again.',
 'Cầu tăng dịch đường cầu sang phải, tạo ra thiếu hụt ở mức giá cũ. Người mua cạnh tranh đẩy giá lên cho đến khi lượng cầu giảm và/hoặc lượng cung tăng đủ để đáp ứng, thiết lập cân bằng mới ở mức giá cao hơn.',
 7);
