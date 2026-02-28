-- =============================================================================
-- Seed: Health & Lifestyle New Categories
-- Categories: Sports Science, Martial Arts & Self-Defense,
--             Sleep Science, Culinary Science
-- =============================================================================

-- =============================================================================
-- CATEGORY: Sports Science
-- =============================================================================

-- Lesson 1: Exercise Physiology Basics
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Exercise Physiology Basics', 'Sinh Lý Học Thể Dục Cơ Bản', 'exercise-physiology-basics',
  'Understand how your body responds to exercise and builds fitness.',
  'Hiểu cách cơ thể phản ứng với tập luyện và xây dựng thể lực.',
  'beginner', 35, 1
FROM category WHERE name = 'Sports Science';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'exercise-physiology-basics'),
 'Designing training programs', 'Thiết kế chương trình tập luyện',
 'Using progressive overload to continuously improve strength over months.',
 'Sử dụng quá tải lũy tiến để liên tục cải thiện sức mạnh theo tháng.', 1),
((SELECT id FROM lesson WHERE slug = 'exercise-physiology-basics'),
 'Understanding recovery', 'Hiểu về phục hồi',
 'Knowing why 48 hours of rest between strength sessions improves gains.',
 'Biết tại sao 48 giờ nghỉ giữa các buổi tập sức mạnh cải thiện kết quả.', 2),
((SELECT id FROM lesson WHERE slug = 'exercise-physiology-basics'),
 'Optimizing cardiovascular training', 'Tối ưu hóa tập luyện tim mạch',
 'Training in Zone 2 (60-70% max HR) to build aerobic base efficiently.',
 'Tập trong Vùng 2 (60-70% nhịp tim tối đa) để xây dựng nền tảng hiếu khí hiệu quả.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'exercise-physiology-basics'),
 'markdown', 'How Exercise Changes Your Body', 'Cách Tập Luyện Thay Đổi Cơ Thể',
 E'## The Science of Physical Fitness\n\nExercise physiology studies how the body responds and adapts to physical activity. Understanding it unlocks smarter, safer training.\n\n### Key Adaptation Principles\n\n**Progressive Overload**: Gradually increase stress (weight, reps, intensity) to force continuous adaptation. Without overload, the body stops adapting.\n\n**SAID Principle** (Specific Adaptation to Imposed Demands):\n- Your body adapts specifically to the TYPE of training\n- Runners don''t automatically get stronger; lifters don''t automatically improve endurance\n\n**Supercompensation Cycle**:\n```\nBaseline → Training Stress → Fatigue → Recovery → SUPERCOMPENSATION (new higher baseline)\n```\nTrain too soon: overtraining. Too late: lose the supercompensation window.\n\n### Energy Systems\n\n| System | Duration | Fuel | Example |\n|--------|----------|------|---------|\n| **ATP-PC** | 0-10 sec | Creatine phosphate | 100m sprint |\n| **Glycolytic** | 10s-2min | Glucose | 400m run |\n| **Oxidative** | 2min+ | Fat + glucose | Marathon |\n\n### Heart Rate Zones\n\n- **Zone 1** (50-60%): Recovery, warm-up\n- **Zone 2** (60-70%): Aerobic base building ← most important for endurance\n- **Zone 3** (70-80%): Tempo, aerobic threshold\n- **Zone 4** (80-90%): Lactate threshold training\n- **Zone 5** (90-100%): VO2max, anaerobic\n\n> Zone 2 is the "secret" of elite endurance athletes — 80% of training volume at low intensity.',
 E'## Khoa Học Về Thể Lực\n\nSinh lý học thể dục nghiên cứu cách cơ thể phản ứng và thích nghi với hoạt động thể chất.\n\n### Các Nguyên Tắc Thích Nghi Chính\n\n**Quá Tải Lũy Tiến**: Tăng dần áp lực (trọng lượng, số lần, cường độ) để buộc cơ thể liên tục thích nghi.\n\n**Nguyên Tắc SAID** (Thích Nghi Cụ Thể Với Nhu Cầu Đặt Ra):\n- Cơ thể thích nghi cụ thể với LOẠI tập luyện\n- Người chạy không tự nhiên mạnh hơn; người tập tạ không tự nhiên bền hơn\n\n**Chu Kỳ Siêu Bù**:\n```\nĐường cơ sở → Căng thẳng tập luyện → Mệt mỏi → Phục hồi → SIÊU BÙ (đường cơ sở mới cao hơn)\n```\n\n### Hệ Thống Năng Lượng\n\n| Hệ thống | Thời gian | Nhiên liệu | Ví dụ |\n|----------|-----------|------------|-------|\n| **ATP-PC** | 0-10 giây | Creatine phosphate | Chạy 100m |\n| **Glycolytic** | 10 giây-2 phút | Glucose | Chạy 400m |\n| **Oxidative** | 2 phút+ | Mỡ + glucose | Marathon |',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'exercise-physiology-basics'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["Progressive overload: must continually increase training stress for adaptation to continue", "SAID principle: body adapts specifically to the TYPE of training imposed", "Supercompensation: train → fatigue → recover → new higher baseline (timing matters)", "Zone 2 (60-70% max HR) is the most important training zone for aerobic base building", "Three energy systems: ATP-PC (0-10s), Glycolytic (10s-2min), Oxidative (2min+)"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'exercise-physiology-basics'),
 'info_box', '80/20 Training Rule', 'Quy Tắc Tập Luyện 80/20',
 'Elite endurance athletes (marathon runners, cyclists) spend ~80% of training in Zone 2 (low intensity) and only ~20% at high intensity. This "polarized training" builds a massive aerobic base. Most amateur athletes do the opposite — training at medium intensity constantly — which leads to slower progress.',
 'Vận động viên bền bỉ ưu tú (vận động viên marathon, xe đạp) dành ~80% thời gian tập trong Vùng 2 (cường độ thấp) và chỉ ~20% ở cường độ cao. "Tập luyện phân cực" này xây dựng nền tảng hiếu khí khổng lồ. Hầu hết vận động viên nghiệp dư làm ngược lại — luôn tập ở cường độ trung bình — dẫn đến tiến bộ chậm hơn.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'exercise-physiology-basics'),
 'multiple_choice', 'easy',
 'What does the SAID principle state about training adaptation?',
 'Nguyên tắc SAID phát biểu điều gì về thích nghi tập luyện?',
 'B',
 'SAID (Specific Adaptation to Imposed Demands): the body adapts specifically to the demands placed on it. Runners develop cardiovascular and muscular adaptations specific to running; weightlifters develop strength specific to lifting. Cross-training has limited transfer between sports.',
 'SAID (Thích Nghi Cụ Thể Với Nhu Cầu Đặt Ra): cơ thể thích nghi cụ thể với các nhu cầu đặt ra trên nó. Người chạy phát triển thích nghi tim mạch và cơ bắp cụ thể cho việc chạy; người tập tạ phát triển sức mạnh cụ thể cho việc nâng. Tập chéo có sự chuyển giao hạn chế giữa các môn thể thao.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'exercise-physiology-basics') AND order_index = 1),
 'A', 'The body adapts to any training equally regardless of type', 'Cơ thể thích nghi bình đẳng với mọi tập luyện bất kể loại'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'exercise-physiology-basics') AND order_index = 1),
 'B', 'The body adapts specifically to the type of training imposed', 'Cơ thể thích nghi cụ thể với loại tập luyện được áp đặt'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'exercise-physiology-basics') AND order_index = 1),
 'C', 'Strength training always improves endurance performance', 'Tập sức mạnh luôn cải thiện hiệu suất bền bỉ'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'exercise-physiology-basics') AND order_index = 1),
 'D', 'Rest is more important than the type of exercise', 'Nghỉ ngơi quan trọng hơn loại bài tập');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'exercise-physiology-basics'),
 'fill_blank', 'easy',
 'The training principle of gradually increasing exercise stress to force continued adaptation is called progressive _____.',
 'Nguyên tắc tập luyện tăng dần áp lực bài tập để buộc tiếp tục thích nghi được gọi là quá tải _____.',
 'overload',
 'Progressive overload is the foundational principle of training: you must continually increase the training stimulus (weight, reps, sets, intensity, volume) to keep the body adapting. Without overload, the body reaches homeostasis and stops improving.',
 'Quá tải lũy tiến là nguyên tắc nền tảng của tập luyện: bạn phải liên tục tăng kích thích tập luyện (trọng lượng, số lần, số set, cường độ, khối lượng) để giữ cơ thể tiếp tục thích nghi. Không có quá tải, cơ thể đạt trạng thái cân bằng nội môi và ngừng cải thiện.',
 2),
((SELECT id FROM lesson WHERE slug = 'exercise-physiology-basics'),
 'multiple_choice', 'medium',
 'Which energy system primarily fuels a 400m sprint race (~50-60 seconds)?',
 'Hệ thống năng lượng nào chủ yếu cung cấp năng lượng cho chạy 400m (~50-60 giây)?',
 'B',
 'The glycolytic (anaerobic glycolysis) system dominates from ~10 seconds to ~2 minutes — exactly the range for a 400m sprint. It rapidly breaks down glucose without oxygen, producing energy quickly but generating lactic acid. The ATP-PC system is exhausted by 10s; the oxidative system is too slow to dominate at this intensity.',
 'Hệ thống glycolytic (đường phân yếm khí) chiếm ưu thế từ ~10 giây đến ~2 phút — chính xác phạm vi cho chạy 400m. Nó phân hủy nhanh glucose mà không cần oxy, tạo năng lượng nhanh nhưng tạo ra axit lactic. Hệ ATP-PC cạn kiệt sau 10 giây; hệ oxy hóa quá chậm để chiếm ưu thế ở cường độ này.',
 3);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'exercise-physiology-basics') AND order_index = 3),
 'A', 'ATP-PC system', 'Hệ thống ATP-PC'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'exercise-physiology-basics') AND order_index = 3),
 'B', 'Glycolytic system', 'Hệ thống glycolytic'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'exercise-physiology-basics') AND order_index = 3),
 'C', 'Oxidative system', 'Hệ thống oxy hóa'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'exercise-physiology-basics') AND order_index = 3),
 'D', 'All three equally', 'Cả ba hệ thống đều nhau');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'exercise-physiology-basics'),
 'true_false', 'medium',
 'Training every day without rest days leads to faster fitness improvements due to continuous stimulation.',
 'Tập luyện mỗi ngày không có ngày nghỉ dẫn đến cải thiện thể lực nhanh hơn do kích thích liên tục.',
 'false',
 'Adaptations happen DURING recovery, not during training. Training creates the stimulus; recovery is when muscles repair and grow stronger (supercompensation). Training without adequate rest leads to overtraining syndrome: decreased performance, increased injury risk, hormonal disruption, and burnout. Most strength programs require 48 hours between sessions for the same muscle group.',
 'Thích nghi xảy ra TRONG QUÁ TRÌNH phục hồi, không phải trong khi tập. Tập luyện tạo ra kích thích; phục hồi là khi cơ bắp phục hồi và trở nên mạnh hơn (siêu bù). Tập luyện không có đủ nghỉ ngơi dẫn đến hội chứng tập quá mức: hiệu suất giảm, tăng nguy cơ chấn thương, rối loạn hormone và kiệt sức.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'exercise-physiology-basics'),
 'arrange_words', 'medium',
 'Arrange to describe the supercompensation cycle.',
 'Sắp xếp để mô tả chu kỳ siêu bù.',
 'Training stress leads to fatigue then recovery and supercompensation',
 '["fatigue", "Training", "recovery", "to", "then", "leads", "supercompensation", "stress", "and"]',
 'Supercompensation is the physiological basis of all training gains. The cycle: training stress → temporary fatigue/performance drop → recovery → supercompensation (performance rises above baseline). The next training session should ideally occur at the supercompensation peak for maximum cumulative gains.',
 'Siêu bù là cơ sở sinh lý của tất cả các tiến bộ tập luyện. Chu kỳ: căng thẳng tập luyện → mệt mỏi tạm thời/hiệu suất giảm → phục hồi → siêu bù (hiệu suất tăng trên đường cơ sở). Buổi tập tiếp theo nên xảy ra ở đỉnh siêu bù để đạt lợi ích tích lũy tối đa.',
 5);

-- Lesson 2: Sports Nutrition & Performance
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Sports Nutrition & Performance', 'Dinh Dưỡng Thể Thao & Hiệu Suất', 'sports-nutrition-performance',
  'Learn how nutrition fuels athletic performance and recovery.',
  'Học cách dinh dưỡng cung cấp năng lượng cho hiệu suất thể thao và phục hồi.',
  'intermediate', 40, 2
FROM category WHERE name = 'Sports Science';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'sports-nutrition-performance'),
 'Pre-workout fueling', 'Nạp năng lượng trước tập',
 'Eating 2-3 hours before exercise with carbs and moderate protein.',
 'Ăn 2-3 giờ trước khi tập với carb và protein vừa phải.', 1),
((SELECT id FROM lesson WHERE slug = 'sports-nutrition-performance'),
 'Post-workout recovery', 'Phục hồi sau tập',
 'Consuming protein within 30-60 minutes post-workout to maximize muscle synthesis.',
 'Tiêu thụ protein trong vòng 30-60 phút sau tập để tối đa hóa tổng hợp cơ bắp.', 2),
((SELECT id FROM lesson WHERE slug = 'sports-nutrition-performance'),
 'Hydration management', 'Quản lý hydrat hóa',
 'Monitoring urine color to maintain optimal hydration during training.',
 'Theo dõi màu nước tiểu để duy trì hydrat hóa tối ưu trong khi tập.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'sports-nutrition-performance'),
 'markdown', 'Fueling Athletic Performance', 'Cung Cấp Năng Lượng Cho Hiệu Suất Thể Thao',
 E'## The Three Macronutrients for Athletes\n\n### Carbohydrates — The Primary Fuel\n\n- Main fuel for high-intensity exercise (glycolytic + oxidative systems)\n- Stored as glycogen in muscles and liver (~500g total)\n- **Glycogen depletion** causes "hitting the wall" in marathons\n- High-carb pre-exercise meal: 1-4g per kg bodyweight, 1-4 hours before\n\n### Protein — Repair and Growth\n\n- Repairs micro-damage caused by training\n- Stimulates muscle protein synthesis (MPS)\n- Recommended: **1.6-2.2g per kg bodyweight per day** for athletes\n- Post-workout window: 20-40g protein within 30-60 minutes\n\n### Fat — Endurance Fuel\n\n- Primary fuel at low-moderate intensities (Zone 1-2)\n- Athletes burn more fat at the same intensity after training — "metabolic flexibility"\n\n### Hydration\n\n| Urine Color | Hydration Status |\n|------------|------------------|\n| Clear/pale yellow | Well hydrated ✓ |\n| Dark yellow | Mildly dehydrated |\n| Orange/amber | Significantly dehydrated |\n\n- Even 2% dehydration reduces performance by 5-10%\n- During exercise: 400-800ml/hour depending on sweat rate\n\n### Nutrient Timing\n\n```\n2-4h before: Full meal (carb + protein + fat)\n30-60min before: Light snack (carb-focused)\nDuring (>60min): 30-60g carbs/hour\nWithin 30-60min after: 20-40g protein + carbs\n```',
 E'## Ba Chất Dinh Dưỡng Đa Lượng Cho Vận Động Viên\n\n### Carbohydrate — Nhiên Liệu Chính\n\n- Nhiên liệu chính cho tập luyện cường độ cao\n- Lưu trữ dưới dạng glycogen trong cơ và gan (~500g tổng)\n- **Cạn kiệt glycogen** gây ra "chạm tường" trong marathon\n- Bữa ăn giàu carb trước tập: 1-4g mỗi kg cân nặng, 1-4 giờ trước\n\n### Protein — Sửa Chữa và Phát Triển\n\n- Sửa chữa tổn thương vi mô do tập luyện\n- Kích thích tổng hợp protein cơ bắp (MPS)\n- Khuyến nghị: **1.6-2.2g mỗi kg cân nặng mỗi ngày** cho vận động viên\n\n### Hydrat Hóa\n\n- Ngay cả 2% mất nước làm giảm hiệu suất 5-10%\n- Trong khi tập: 400-800ml/giờ tùy theo tốc độ đổ mồ hôi',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'sports-nutrition-performance'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["Carbohydrates are the primary fuel for high-intensity exercise; glycogen depletion = hitting the wall", "Athletes need 1.6-2.2g protein per kg bodyweight daily for optimal muscle repair and growth", "Post-workout: 20-40g protein within 30-60 minutes maximizes muscle protein synthesis", "2% dehydration reduces athletic performance by 5-10% — monitor urine color", "Nutrient timing matters: carb-focused pre-workout, protein+carbs post-workout"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'sports-nutrition-performance'),
 'info_box', 'Carbohydrate Loading', 'Nạp Carbohydrate',
 'Marathon runners use "carb loading" — eating very high carbohydrates for 2-3 days before a race to maximize glycogen stores. This can increase glycogen by 20-40%, delaying the wall. However, carb loading only works for events lasting 90+ minutes.',
 'Vận động viên marathon sử dụng "nạp carb" — ăn carbohydrate rất cao trong 2-3 ngày trước cuộc đua để tối đa hóa dự trữ glycogen. Điều này có thể tăng glycogen 20-40%, trì hoãn việc "chạm tường". Tuy nhiên, nạp carb chỉ hoạt động cho các sự kiện kéo dài 90+ phút.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'sports-nutrition-performance'),
 'multiple_choice', 'easy',
 'What is the recommended daily protein intake for athletes to support muscle repair and growth?',
 'Lượng protein hàng ngày được khuyến nghị cho vận động viên để hỗ trợ phục hồi và phát triển cơ bắp là bao nhiêu?',
 'C',
 '1.6-2.2g per kg bodyweight is the evidence-based range for athletes. Sedentary adults need only ~0.8g/kg. Athletes need more due to muscle micro-damage from training. Going above 2.2g/kg provides minimal additional benefit — excess protein is used for energy or converted to fat.',
 '1.6-2.2g mỗi kg cân nặng là phạm vi dựa trên bằng chứng cho vận động viên. Người trưởng thành ít vận động chỉ cần ~0.8g/kg. Vận động viên cần nhiều hơn do tổn thương vi mô cơ bắp từ tập luyện. Vượt quá 2.2g/kg mang lại lợi ích bổ sung tối thiểu — protein dư thừa được sử dụng cho năng lượng hoặc chuyển đổi thành mỡ.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'sports-nutrition-performance') AND order_index = 1),
 'A', '0.5-0.8g per kg bodyweight', '0.5-0.8g mỗi kg cân nặng'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'sports-nutrition-performance') AND order_index = 1),
 'B', '0.8-1.2g per kg bodyweight', '0.8-1.2g mỗi kg cân nặng'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'sports-nutrition-performance') AND order_index = 1),
 'C', '1.6-2.2g per kg bodyweight', '1.6-2.2g mỗi kg cân nặng'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'sports-nutrition-performance') AND order_index = 1),
 'D', '3.0-4.0g per kg bodyweight', '3.0-4.0g mỗi kg cân nặng');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'sports-nutrition-performance'),
 'fill_blank', 'medium',
 'During a marathon, running out of glycogen and experiencing sudden exhaustion is commonly called "hitting the _____".',
 'Trong marathon, cạn kiệt glycogen và trải qua mệt mỏi đột ngột thường được gọi là "chạm _____".',
 'wall',
 '"Hitting the wall" (or "bonking") typically occurs around mile 20 of a marathon when glycogen stores are depleted. The body must shift entirely to fat oxidation, which is much slower, causing dramatic slowdown. Carb loading and consuming carbs during the race (gels, sports drinks) helps delay this.',
 '"Chạm tường" (hoặc "bonking") thường xảy ra khoảng dặm 20 của marathon khi dự trữ glycogen cạn kiệt. Cơ thể phải chuyển hoàn toàn sang oxy hóa mỡ, chậm hơn nhiều, gây ra sự chậm lại đáng kể. Nạp carb và tiêu thụ carb trong cuộc đua (gel, đồ uống thể thao) giúp trì hoãn điều này.',
 2),
((SELECT id FROM lesson WHERE slug = 'sports-nutrition-performance'),
 'true_false', 'easy',
 'Drinking water only when you feel thirsty is sufficient to maintain optimal hydration during exercise.',
 'Uống nước chỉ khi cảm thấy khát là đủ để duy trì hydrat hóa tối ưu khi tập luyện.',
 'false',
 'Thirst lags behind actual hydration status — by the time you feel thirsty, you may already be 1-2% dehydrated. During exercise, drink proactively: 400-800ml per hour. Monitoring urine color (pale yellow = hydrated) is more reliable than thirst alone as a hydration gauge.',
 'Cơn khát đi sau trạng thái hydrat hóa thực tế — vào thời điểm bạn cảm thấy khát, bạn có thể đã mất nước 1-2%. Trong khi tập luyện, uống chủ động: 400-800ml mỗi giờ. Theo dõi màu nước tiểu (vàng nhạt = đủ nước) đáng tin cậy hơn cơn khát đơn thuần như một thước đo hydrat hóa.',
 3),
((SELECT id FROM lesson WHERE slug = 'sports-nutrition-performance'),
 'sentence_transform', 'medium',
 'Rewrite to give correct post-workout nutrition advice: "After exercise, you should wait several hours before eating to let your body naturally recover."',
 'Viết lại để đưa ra lời khuyên dinh dưỡng đúng sau tập: "Sau khi tập, bạn nên chờ vài giờ trước khi ăn để cơ thể tự nhiên phục hồi."',
 'After exercise, consume 20-40g of protein within 30-60 minutes to maximize muscle protein synthesis.',
 'The post-workout window is critical. Muscle protein synthesis (MPS) is elevated after training and providing protein immediately maximizes this response. Waiting hours misses this anabolic window. The body is most receptive to protein uptake and glycogen replenishment in the 30-60 minutes after exercise.',
 'Cửa sổ sau tập rất quan trọng. Tổng hợp protein cơ bắp (MPS) được nâng cao sau khi tập và cung cấp protein ngay lập tức tối đa hóa phản ứng này. Chờ vài giờ bỏ lỡ cửa sổ đồng hóa này. Cơ thể nhạy cảm nhất với việc hấp thu protein và bổ sung glycogen trong 30-60 phút sau khi tập.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'sports-nutrition-performance'),
 'arrange_words', 'easy',
 'Arrange to describe carbohydrates role in exercise.',
 'Sắp xếp để mô tả vai trò của carbohydrate trong tập luyện.',
 'Carbohydrates are the primary fuel for high intensity exercise',
 '["primary", "exercise", "are", "Carbohydrates", "high", "fuel", "intensity", "the", "for"]',
 'Carbohydrates (stored as glycogen) are the preferred and primary fuel for high-intensity exercise because they can be broken down quickly to produce ATP. Fat burns slower and is primary only at low intensities. Protein is generally not used as fuel unless in extreme starvation.',
 'Carbohydrate (được lưu trữ dưới dạng glycogen) là nhiên liệu ưa thích và chính cho tập luyện cường độ cao vì chúng có thể được phân hủy nhanh chóng để tạo ra ATP. Mỡ đốt chậm hơn và chỉ là chính ở cường độ thấp. Protein thường không được sử dụng làm nhiên liệu trừ khi trong tình trạng đói cực độ.',
 5);

-- =============================================================================
-- CATEGORY: Martial Arts & Self-Defense
-- =============================================================================

-- Lesson 3: Martial Arts Fundamentals
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Martial Arts Fundamentals', 'Cơ Bản Võ Thuật', 'martial-arts-fundamentals',
  'Explore the principles, history, and philosophy of major martial arts.',
  'Khám phá các nguyên tắc, lịch sử và triết lý của các môn võ thuật lớn.',
  'beginner', 30, 1
FROM category WHERE name = 'Martial Arts & Self-Defense';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'martial-arts-fundamentals'),
 'Choosing a martial art', 'Chọn môn võ thuật',
 'Comparing striking vs grappling arts based on personal goals.',
 'So sánh võ thuật đánh vs vật tùy theo mục tiêu cá nhân.', 1),
((SELECT id FROM lesson WHERE slug = 'martial-arts-fundamentals'),
 'Understanding training principles', 'Hiểu nguyên tắc tập luyện',
 'Applying randori (free practice) to develop instinctive responses.',
 'Áp dụng randori (luyện tập tự do) để phát triển phản xạ bản năng.', 2),
((SELECT id FROM lesson WHERE slug = 'martial-arts-fundamentals'),
 'Philosophy and discipline', 'Triết lý và kỷ luật',
 'Using martial arts principles like Mushin for focus under pressure.',
 'Sử dụng nguyên tắc võ thuật như Mushin để tập trung dưới áp lực.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'martial-arts-fundamentals'),
 'markdown', 'The World of Martial Arts', 'Thế Giới Võ Thuật',
 E'## Major Martial Arts Categories\n\n### Striking Arts (Stand-up)\n\n| Art | Origin | Core Technique | Key Principle |\n|-----|--------|---------------|---------------|\n| **Boxing** | Greece/Europe | Punches | Head movement + combinations |\n| **Muay Thai** | Thailand | 8 limbs (fists, elbows, knees, kicks) | Clinch + powerful strikes |\n| **Karate** | Okinawa/Japan | Punches, kicks, kata | Kime (focus of power) |\n| **Taekwondo** | Korea | High kicks | Speed + flexibility |\n\n### Grappling Arts (Ground/Clinch)\n\n| Art | Origin | Core Technique | Key Principle |\n|-----|--------|---------------|---------------|\n| **Judo** | Japan | Throws, pins | Use opponent''s force |\n| **Brazilian Jiu-Jitsu** | Brazil | Ground control, submissions | Leverage over strength |\n| **Wrestling** | Global | Takedowns, control | Dominant position |\n\n### Hybrid/MMA\n\n**Mixed Martial Arts** combines striking + grappling. The most complete fighters today train multiple systems.\n\n### Core Philosophical Concepts\n\n- **Mushin** (No-mind): Empty, reactive state — act without conscious thought\n- **Zanshin**: Remaining awareness after a technique — never fully drop your guard\n- **Randori**: Free sparring practice — essential for real-world application\n- **Shu-Ha-Ri**: Learn the rule → break from it → transcend it (mastery stages)\n\n> "The more you sweat in practice, the less you bleed in battle." — Japanese proverb',
 E'## Các Loại Võ Thuật Chính\n\n### Võ Thuật Đánh (Đứng)\n\n| Môn | Xuất xứ | Kỹ thuật cốt lõi | Nguyên tắc chính |\n|-----|---------|-----------------|------------------|\n| **Boxing** | Hy Lạp/Châu Âu | Đấm | Di chuyển đầu + tổ hợp |\n| **Muay Thai** | Thái Lan | 8 chi (nắm, khuỷu, gối, đá) | Clinch + đòn mạnh |\n| **Karate** | Okinawa/Nhật | Đấm, đá, kata | Kime (tập trung sức mạnh) |\n| **Taekwondo** | Hàn Quốc | Đá cao | Tốc độ + linh hoạt |\n\n### Võ Thuật Vật (Dưới Đất/Siết)\n\n| Môn | Xuất xứ | Kỹ thuật cốt lõi | Nguyên tắc chính |\n|-----|---------|-----------------|------------------|\n| **Judo** | Nhật Bản | Ném, ghim | Dùng lực đối thủ |\n| **Brazilian Jiu-Jitsu** | Brazil | Kiểm soát mặt đất, khóa | Đòn bẩy hơn sức mạnh |\n| **Wrestling** | Toàn cầu | Hạ ngã, kiểm soát | Vị trí chiếm ưu thế |',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'martial-arts-fundamentals'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["Martial arts split into striking (Boxing, Muay Thai, Karate) and grappling (Judo, BJJ, Wrestling)", "BJJ principle: leverage and technique overcome raw strength — size advantage neutralized", "Mushin (no-mind): empty, reactive mental state for instinctive, effortless response", "Randori (free sparring) is essential — techniques must work under pressure, not just in drills", "Shu-Ha-Ri: follow the rules → break them → transcend them (the three stages of mastery)"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'martial-arts-fundamentals'),
 'info_box', 'Helio Gracie and BJJ', 'Helio Gracie và BJJ',
 'Helio Gracie was small and physically weak. He modified Japanese Jiu-Jitsu to rely entirely on leverage and technique rather than strength, creating Brazilian Jiu-Jitsu. His family''s challenge matches (Gracie Challenge) against larger opponents validated that technique could defeat strength — a revolution in martial arts.',
 'Helio Gracie nhỏ bé và thể chất yếu. Ông đã sửa đổi Jiu-Jitsu Nhật Bản để dựa hoàn toàn vào đòn bẩy và kỹ thuật thay vì sức mạnh, tạo ra Brazilian Jiu-Jitsu. Các trận đấu thử thách của gia đình ông (Gracie Challenge) chống lại các đối thủ lớn hơn đã xác nhận rằng kỹ thuật có thể đánh bại sức mạnh — một cuộc cách mạng trong võ thuật.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'martial-arts-fundamentals'),
 'multiple_choice', 'easy',
 'Which martial art is known as the "art of 8 limbs" for using fists, elbows, knees, and kicks?',
 'Môn võ thuật nào được gọi là "nghệ thuật 8 chi" vì sử dụng nắm đấm, khuỷu tay, đầu gối và đá?',
 'B',
 'Muay Thai (Thai Boxing) uses 8 "weapons": two fists, two elbows, two knees, two feet — giving it more striking options than boxing (2 weapons) or karate. The clinch (grabbing opponent while landing knees/elbows) is particularly distinctive.',
 'Muay Thai (Đấm Thái) sử dụng 8 "vũ khí": hai nắm đấm, hai khuỷu tay, hai đầu gối, hai bàn chân — cho nhiều tùy chọn đánh hơn boxing (2 vũ khí) hoặc karate. Clinch (ôm đối thủ khi tung đầu gối/khuỷu tay) đặc biệt đặc trưng.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'martial-arts-fundamentals') AND order_index = 1),
 'A', 'Karate', 'Karate'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'martial-arts-fundamentals') AND order_index = 1),
 'B', 'Muay Thai', 'Muay Thai'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'martial-arts-fundamentals') AND order_index = 1),
 'C', 'Taekwondo', 'Taekwondo'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'martial-arts-fundamentals') AND order_index = 1),
 'D', 'Boxing', 'Boxing');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'martial-arts-fundamentals'),
 'fill_blank', 'medium',
 'In Japanese martial arts philosophy, the empty, reactive mental state for instinctive response is called _____.',
 'Trong triết lý võ thuật Nhật Bản, trạng thái tâm trí trống rỗng, phản ứng để có phản xạ bản năng được gọi là _____.',
 'Mushin',
 'Mushin (no-mind or "empty mind") is a state where the practitioner acts without conscious deliberation — pure instinctive response. It is developed through thousands of hours of repetitive practice until techniques become automatic. In combat, conscious thought is too slow; Mushin allows effortless, immediate response.',
 'Mushin (không tâm hay "tâm trống") là trạng thái người tập hành động mà không có suy nghĩ ý thức — phản ứng bản năng thuần túy. Nó được phát triển qua hàng nghìn giờ luyện tập lặp lại cho đến khi kỹ thuật trở nên tự động. Trong chiến đấu, suy nghĩ ý thức quá chậm; Mushin cho phép phản ứng ngay lập tức, không gắng sức.',
 2),
((SELECT id FROM lesson WHERE slug = 'martial-arts-fundamentals'),
 'true_false', 'easy',
 'Brazilian Jiu-Jitsu (BJJ) was designed specifically to overpower opponents using superior strength and size.',
 'Brazilian Jiu-Jitsu (BJJ) được thiết kế đặc biệt để áp đảo đối thủ bằng sức mạnh và kích thước vượt trội.',
 'false',
 'BJJ was specifically designed to work WITHOUT superior strength. Helio Gracie developed it to use leverage, body mechanics, and technique to neutralize larger, stronger opponents. This is BJJ''s fundamental principle: a smaller, weaker person can defeat a larger one through superior technique and position.',
 'BJJ được thiết kế đặc biệt để hoạt động KHÔNG CẦN sức mạnh vượt trội. Helio Gracie phát triển nó để sử dụng đòn bẩy, cơ học cơ thể và kỹ thuật để vô hiệu hóa các đối thủ lớn hơn, mạnh hơn. Đây là nguyên tắc cơ bản của BJJ: một người nhỏ hơn, yếu hơn có thể đánh bại người lớn hơn thông qua kỹ thuật và vị trí vượt trội.',
 3),
((SELECT id FROM lesson WHERE slug = 'martial-arts-fundamentals'),
 'fill_blank', 'medium',
 'Free sparring practice in Japanese martial arts, essential for developing real-world applicable skills, is called _____.',
 'Luyện tập đấu tự do trong võ thuật Nhật Bản, thiết yếu để phát triển kỹ năng áp dụng thực tế, được gọi là _____.',
 'randori',
 'Randori (free practice) is unscripted sparring where practitioners apply techniques against a resisting partner. It is the critical bridge between drilling techniques in isolation and being able to use them in real situations. Without randori, martial arts becomes "dancing" — looking good but non-functional.',
 'Randori (luyện tập tự do) là đấu không theo kịch bản nơi người tập áp dụng kỹ thuật chống lại đối tác kháng cự. Đây là cầu nối quan trọng giữa luyện kỹ thuật đơn lẻ và có thể sử dụng chúng trong tình huống thực tế. Không có randori, võ thuật trở thành "khiêu vũ" — trông đẹp nhưng không hoạt động.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'martial-arts-fundamentals'),
 'arrange_words', 'medium',
 'Arrange to describe the Shu-Ha-Ri stages of mastery.',
 'Sắp xếp để mô tả các giai đoạn thành thạo Shu-Ha-Ri.',
 'Shu Ha Ri means follow the rules break them then transcend',
 '["break", "rules", "means", "them", "follow", "then", "Shu", "Ha", "Ri", "the", "transcend"]',
 'Shu-Ha-Ri describes the three stages of mastery in Japanese martial arts (and now used broadly in learning): Shu (守) = follow the rules strictly; Ha (破) = break from the rules after mastering them; Ri (離) = transcend the rules entirely — the technique becomes natural and personal. It parallels Western concepts of novice → competent → expert.',
 'Shu-Ha-Ri mô tả ba giai đoạn thành thạo trong võ thuật Nhật Bản (và nay được sử dụng rộng rãi trong học tập): Shu (守) = tuân theo quy tắc nghiêm ngặt; Ha (破) = phá vỡ quy tắc sau khi thành thạo chúng; Ri (離) = vượt lên trên quy tắc hoàn toàn — kỹ thuật trở nên tự nhiên và cá nhân.',
 5);

-- Lesson 4: Self-Defense Principles
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Self-Defense Principles', 'Nguyên Tắc Tự Vệ', 'self-defense-principles',
  'Learn the core principles of realistic self-defense and situational awareness.',
  'Học các nguyên tắc cốt lõi của tự vệ thực tế và nhận thức tình huống.',
  'intermediate', 35, 2
FROM category WHERE name = 'Martial Arts & Self-Defense';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'self-defense-principles'),
 'Threat awareness', 'Nhận thức mối đe dọa',
 'Using the Color Code System to maintain appropriate alertness in public.',
 'Sử dụng Hệ thống Mã Màu để duy trì mức cảnh giác phù hợp nơi công cộng.', 1),
((SELECT id FROM lesson WHERE slug = 'self-defense-principles'),
 'Conflict de-escalation', 'Giảm leo thang xung đột',
 'Using verbal techniques to diffuse an aggressive confrontation before it becomes physical.',
 'Sử dụng kỹ thuật lời nói để giảm leo thang đối đầu hung hãn trước khi nó trở nên thể chất.', 2),
((SELECT id FROM lesson WHERE slug = 'self-defense-principles'),
 'Physical response hierarchy', 'Hệ thống phản ứng thể chất',
 'Understanding when verbal, non-physical, then physical responses are appropriate.',
 'Hiểu khi nào phản ứng lời nói, không thể chất, rồi thể chất là phù hợp.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'self-defense-principles'),
 'markdown', 'Real-World Self-Defense', 'Tự Vệ Thực Tế',
 E'## The Foundation of Self-Defense\n\nReal self-defense is 90% avoidance and awareness, 10% physical skills.\n\n### Cooper''s Color Code (Awareness Levels)\n\n| Color | State | Description |\n|-------|-------|-------------|\n| **White** | Unaware | Distracted, oblivious to surroundings |\n| **Yellow** | Relaxed alert | Aware of environment, no specific threat |\n| **Orange** | Specific alert | Potential threat identified, ready |\n| **Red** | Action | Responding to confirmed threat |\n\nMost people live in White. Trained practitioners stay in Yellow in public — aware but not paranoid.\n\n### The Violence Pyramid\n\n```\n         Physical Force\n        /              \\\n      De-escalation     Escape\n     /                        \\\n  Awareness → Avoidance → Communication\n```\n\nAlways attempt lower levels first. Physical force is the last resort.\n\n### Key Self-Defense Principles\n\n1. **Awareness first**: Most attacks are preventable with awareness\n2. **Escape if possible**: Fighting is always risky — retreat when safe to do so\n3. **De-escalate**: Verbal skills prevent 90% of potential physical conflicts\n4. **Target vulnerable points**: Eyes, throat, groin — effective regardless of size\n5. **Legal context**: Self-defense must be proportional to threat\n\n### OODA Loop (in Self-Defense)\n\n- **Observe**: See the threat\n- **Orient**: Understand its nature\n- **Decide**: Choose response\n- **Act**: Execute\n\nTraining compresses the OODA loop — practiced responses are faster.',
 E'## Nền Tảng Của Tự Vệ\n\nTự vệ thực sự là 90% tránh né và nhận thức, 10% kỹ năng thể chất.\n\n### Mã Màu Cooper (Mức Độ Nhận Thức)\n\n| Màu | Trạng thái | Mô tả |\n|-----|-----------|-------|\n| **Trắng** | Không nhận thức | Mất tập trung, không biết môi trường xung quanh |\n| **Vàng** | Cảnh giác thoải mái | Nhận thức môi trường, không có mối đe dọa cụ thể |\n| **Cam** | Cảnh giác cụ thể | Xác định mối đe dọa tiềm năng, sẵn sàng |\n| **Đỏ** | Hành động | Phản ứng với mối đe dọa đã xác nhận |\n\n### Tháp Bạo Lực\n\nLuôn thử các mức độ thấp hơn trước. Vũ lực thể chất là phương án cuối cùng.',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'self-defense-principles'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["Real self-defense is 90% awareness and avoidance, 10% physical technique", "Cooper Color Code: White (unaware) → Yellow (alert) → Orange (specific threat) → Red (action)", "Violence pyramid: awareness → avoidance → communication → de-escalation → physical force (last resort)", "OODA Loop: Observe → Orient → Decide → Act — training speeds up this cycle", "Self-defense must be legally proportional to the actual threat level"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'self-defense-principles'),
 'info_box', 'Verbal De-escalation', 'Giảm Leo Thang Bằng Lời Nói',
 'Studies of violent incidents show that 70-80% of confrontations can be de-escalated verbally before becoming physical. Key techniques: non-threatening body language, acknowledging the other person''s feelings, offering face-saving exits. Many martial arts instructors say the most important self-defense skill is knowing how NOT to fight.',
 'Các nghiên cứu về sự cố bạo lực cho thấy 70-80% các cuộc đối đầu có thể được giảm leo thang bằng lời nói trước khi trở nên thể chất. Kỹ thuật chính: ngôn ngữ cơ thể không đe dọa, thừa nhận cảm xúc của người kia, cung cấp lối thoát giữ thể diện. Nhiều huấn luyện viên võ thuật nói kỹ năng tự vệ quan trọng nhất là biết KHÔNG đánh như thế nào.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'self-defense-principles'),
 'multiple_choice', 'easy',
 'In Cooper''s Color Code, which awareness level should a trained person maintain while walking in public?',
 'Trong Mã Màu Cooper, mức độ nhận thức nào người được đào tạo nên duy trì khi đi bộ nơi công cộng?',
 'B',
 'Yellow (relaxed alert) is the appropriate baseline in public — aware of your surroundings and the people in them, but not tense or paranoid. White (unaware) leaves you vulnerable to surprise attacks. Orange requires a specific identified threat. Red is active response mode. Yellow is sustainable and preventive.',
 'Vàng (cảnh giác thoải mái) là mức cơ sở thích hợp nơi công cộng — nhận thức về môi trường xung quanh và những người trong đó, nhưng không căng thẳng hay hoang tưởng. Trắng (không nhận thức) khiến bạn dễ bị tấn công bất ngờ. Cam đòi hỏi mối đe dọa cụ thể được xác định. Đỏ là chế độ phản ứng tích cực. Vàng bền vững và phòng ngừa.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'self-defense-principles') AND order_index = 1),
 'A', 'White — fully relaxed', 'Trắng — hoàn toàn thư giãn'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'self-defense-principles') AND order_index = 1),
 'B', 'Yellow — relaxed alert', 'Vàng — cảnh giác thoải mái'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'self-defense-principles') AND order_index = 1),
 'C', 'Orange — specific threat identified', 'Cam — xác định mối đe dọa cụ thể'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'self-defense-principles') AND order_index = 1),
 'D', 'Red — ready to act immediately', 'Đỏ — sẵn sàng hành động ngay');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'self-defense-principles'),
 'true_false', 'easy',
 'In real self-defense situations, physical fighting should always be the first response to any threat.',
 'Trong tình huống tự vệ thực tế, chiến đấu thể chất luôn phải là phản ứng đầu tiên với bất kỳ mối đe dọa nào.',
 'false',
 'Physical fighting is the LAST resort. Every confrontation carries risk of injury (even to the "winner"), legal consequences, and psychological impact. The self-defense hierarchy starts with awareness, then avoidance, then verbal de-escalation, then escape — physical force only when all other options are exhausted or impossible.',
 'Chiến đấu thể chất là PHƯƠNG ÁN CUỐI CÙNG. Mỗi cuộc đối đầu mang rủi ro chấn thương (ngay cả người "thắng"), hậu quả pháp lý và tác động tâm lý. Hệ thống tự vệ bắt đầu bằng nhận thức, sau đó là tránh né, rồi giảm leo thang bằng lời nói, sau đó là thoát thân — vũ lực thể chất chỉ khi tất cả các lựa chọn khác đã cạn kiệt hoặc không thể thực hiện.',
 2),
((SELECT id FROM lesson WHERE slug = 'self-defense-principles'),
 'fill_blank', 'medium',
 'The decision-making framework Observe → Orient → Decide → Act used in self-defense training is called the _____ Loop.',
 'Khung ra quyết định Quan sát → Định hướng → Quyết định → Hành động được sử dụng trong đào tạo tự vệ được gọi là Vòng lặp _____.',
 'OODA',
 'The OODA Loop (developed by military strategist John Boyd) describes how individuals process and respond to threats. Training compresses OODA — practiced responses skip the Decide step (which becomes automatic). Attackers also have OODA loops; disrupting their cycle (unpredictability, counterattacks) creates defensive advantage.',
 'Vòng lặp OODA (được phát triển bởi chiến lược gia quân sự John Boyd) mô tả cách cá nhân xử lý và phản ứng với mối đe dọa. Đào tạo nén OODA — các phản ứng được luyện tập bỏ qua bước Quyết định (trở nên tự động). Kẻ tấn công cũng có vòng lặp OODA; làm gián đoạn chu kỳ của họ (không thể đoán trước, phản công) tạo ra lợi thế phòng thủ.',
 3),
((SELECT id FROM lesson WHERE slug = 'self-defense-principles'),
 'error_correction', 'medium',
 'Find and fix the error: "Cooper Color Code Orange means the person is fully relaxed and unaware of their surroundings."',
 'Tìm và sửa lỗi: "Mã Màu Cooper Cam có nghĩa là người đó hoàn toàn thư giãn và không nhận thức về môi trường xung quanh."',
 'Cooper Color Code White means the person is fully relaxed and unaware of their surroundings.',
 'White (not Orange) is the unaware, relaxed state. Orange means a SPECIFIC potential threat has been identified and the person is mentally and physically preparing to respond. The colors: White=unaware, Yellow=relaxed alert, Orange=specific threat detected, Red=active response.',
 'Trắng (không phải Cam) là trạng thái không nhận thức, thư giãn. Cam có nghĩa là một mối đe dọa tiềm năng CỤ THỂ đã được xác định và người đó đang chuẩn bị tinh thần và thể chất để phản ứng. Các màu: Trắng=không nhận thức, Vàng=cảnh giác thoải mái, Cam=phát hiện mối đe dọa cụ thể, Đỏ=phản ứng tích cực.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'self-defense-principles'),
 'arrange_words', 'medium',
 'Arrange the self-defense response hierarchy from first to last resort.',
 'Sắp xếp hệ thống phản ứng tự vệ từ ưu tiên đầu tiên đến cuối cùng.',
 'Awareness avoidance de-escalation escape then physical force',
 '["then", "escape", "physical", "Awareness", "de-escalation", "avoidance", "force"]',
 'The self-defense hierarchy (from first preference to last resort): Awareness → Avoidance → De-escalation → Escape → Physical force. This order minimizes risk at every stage. Physical force is always the most dangerous option — it can fail, result in legal consequences, and cause psychological trauma even when successful.',
 'Hệ thống tự vệ (từ ưu tiên đầu tiên đến cuối cùng): Nhận thức → Tránh né → Giảm leo thang → Thoát thân → Vũ lực thể chất. Thứ tự này giảm thiểu rủi ro ở mỗi giai đoạn. Vũ lực thể chất luôn là lựa chọn nguy hiểm nhất — nó có thể thất bại, dẫn đến hậu quả pháp lý và chấn thương tâm lý ngay cả khi thành công.',
 5);

-- =============================================================================
-- CATEGORY: Sleep Science
-- =============================================================================

-- Lesson 5: The Science of Sleep
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'The Science of Sleep', 'Khoa Học Về Giấc Ngủ', 'science-of-sleep',
  'Understand sleep cycles, circadian rhythms, and why sleep quality matters.',
  'Hiểu chu kỳ giấc ngủ, nhịp sinh học và tại sao chất lượng giấc ngủ quan trọng.',
  'beginner', 30, 1
FROM category WHERE name = 'Sleep Science';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'science-of-sleep'),
 'Optimizing sleep timing', 'Tối ưu hóa thời gian ngủ',
 'Aligning sleep with your chronotype (morning lark vs night owl).',
 'Điều chỉnh giấc ngủ theo kiểu nhịp sinh học của bạn (người dậy sớm vs cú đêm).', 1),
((SELECT id FROM lesson WHERE slug = 'science-of-sleep'),
 'Understanding memory consolidation', 'Hiểu củng cố trí nhớ',
 'Knowing why studying before sleep improves long-term retention.',
 'Biết tại sao học trước khi ngủ cải thiện ghi nhớ dài hạn.', 2),
((SELECT id FROM lesson WHERE slug = 'science-of-sleep'),
 'Managing sleep debt', 'Quản lý nợ giấc ngủ',
 'Understanding why you cannot fully recover a week of poor sleep with one good night.',
 'Hiểu tại sao bạn không thể phục hồi hoàn toàn một tuần ngủ kém với một đêm ngủ tốt.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'science-of-sleep'),
 'markdown', 'Sleep Architecture and Biology', 'Cấu Trúc và Sinh Học Giấc Ngủ',
 E'## Why Sleep Matters More Than You Think\n\nSleep is not passive rest — it is an active biological process essential for memory, immune function, hormone regulation, and cellular repair.\n\n### Sleep Cycle Structure\n\nEach sleep cycle lasts ~90 minutes and contains:\n\n| Stage | Type | Duration | Function |\n|-------|------|----------|---------|\n| **N1** | Light NREM | 5-10 min | Transition to sleep |\n| **N2** | Deeper NREM | 20 min | Memory consolidation (sleep spindles) |\n| **N3** | Deep NREM (SWS) | 20-40 min | Physical repair, growth hormone |\n| **REM** | REM sleep | 10-60 min | Emotional processing, creativity |\n\nA full night has 4-6 cycles. Early cycles have more N3 (deep); later cycles have more REM.\n\n### Circadian Rhythm\n\nYour internal ~24-hour clock is controlled by the **suprachiasmatic nucleus (SCN)**:\n\n- Light exposure → suppresses melatonin → promotes wakefulness\n- Darkness → melatonin rises → promotes sleep\n- **Adenosine**: builds up during waking (sleep pressure), cleared during sleep\n- Caffeine works by BLOCKING adenosine receptors — not creating energy\n\n### Consequences of Sleep Deprivation\n\n- **Cognitive**: 17-19 hours awake = impairment equivalent to 0.05% blood alcohol\n- **Physical**: Reduced testosterone, growth hormone, immune function\n- **Mental**: Increased anxiety, depression risk, emotional dysregulation\n- **Sleep debt**: Cannot be "paid back" — chronic deprivation causes lasting neurological damage',
 E'## Tại Sao Giấc Ngủ Quan Trọng Hơn Bạn Nghĩ\n\nGiấc ngủ không phải là nghỉ ngơi thụ động — đó là quá trình sinh học tích cực thiết yếu cho trí nhớ, chức năng miễn dịch, điều hòa hormone và sửa chữa tế bào.\n\n### Cấu Trúc Chu Kỳ Giấc Ngủ\n\nMỗi chu kỳ giấc ngủ kéo dài ~90 phút và chứa:\n\n| Giai đoạn | Loại | Thời gian | Chức năng |\n|-----------|------|-----------|----------|\n| **N1** | NREM nhẹ | 5-10 phút | Chuyển đổi sang giấc ngủ |\n| **N2** | NREM sâu hơn | 20 phút | Củng cố trí nhớ |\n| **N3** | NREM sâu (SWS) | 20-40 phút | Sửa chữa thể chất, hormone tăng trưởng |\n| **REM** | Giấc ngủ REM | 10-60 phút | Xử lý cảm xúc, sáng tạo |\n\n### Nhịp Sinh Học\n\nĐồng hồ nội tại ~24 giờ được kiểm soát bởi **nhân thị giao (SCN)**:\n- Tiếp xúc ánh sáng → ức chế melatonin → thúc đẩy thức giấc\n- Bóng tối → melatonin tăng → thúc đẩy giấc ngủ\n- **Caffeine** hoạt động bằng cách CHẶN thụ thể adenosine — không tạo ra năng lượng',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'science-of-sleep'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["Sleep cycles are ~90 min: N1 (light) → N2 (memory) → N3 (physical repair) → REM (emotional/creative)", "Circadian rhythm is your ~24h internal clock controlled by light/dark exposure via melatonin", "Caffeine blocks adenosine receptors — it hides fatigue, it does not create energy", "17-19 hours awake = cognitive impairment equivalent to 0.05% blood alcohol level", "Sleep debt cannot be fully paid back — chronic deprivation causes lasting neurological damage"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'science-of-sleep'),
 'info_box', 'REM Sleep and Creativity', 'Giấc Ngủ REM và Sự Sáng Tạo',
 'REM sleep is when the brain makes unexpected connections between distant memories. Many scientific breakthroughs happened during sleep or just after waking: Kekulé''s discovery of benzene''s ring structure, Paul McCartney hearing the melody of "Yesterday" upon waking, and Mendeleev''s periodic table arrangement.',
 'Giấc ngủ REM là khi não tạo ra những kết nối bất ngờ giữa các ký ức xa. Nhiều đột phá khoa học xảy ra trong khi ngủ hoặc ngay sau khi thức dậy: khám phá cấu trúc vòng của benzene của Kekulé, Paul McCartney nghe giai điệu "Yesterday" khi thức dậy, và sắp xếp bảng tuần hoàn của Mendeleev.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'science-of-sleep'),
 'multiple_choice', 'easy',
 'Which sleep stage is primarily associated with physical repair and growth hormone release?',
 'Giai đoạn giấc ngủ nào chủ yếu liên quan đến sửa chữa thể chất và giải phóng hormone tăng trưởng?',
 'C',
 'N3 (deep NREM / slow-wave sleep) is when most physical restoration occurs: growth hormone is released, tissues are repaired, and immune function is strengthened. Athletes who lack N3 sleep show significantly impaired physical recovery. This is why deep sleep is often more important than total sleep duration for physical performance.',
 'N3 (NREM sâu / giấc ngủ sóng chậm) là khi hầu hết quá trình phục hồi thể chất xảy ra: hormone tăng trưởng được giải phóng, các mô được sửa chữa và chức năng miễn dịch được tăng cường. Vận động viên thiếu giấc ngủ N3 cho thấy phục hồi thể chất bị suy giảm đáng kể.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'science-of-sleep') AND order_index = 1),
 'A', 'N1 (light sleep)', 'N1 (ngủ nhẹ)'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'science-of-sleep') AND order_index = 1),
 'B', 'N2 (intermediate sleep)', 'N2 (ngủ trung gian)'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'science-of-sleep') AND order_index = 1),
 'C', 'N3 (deep NREM sleep)', 'N3 (ngủ NREM sâu)'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'science-of-sleep') AND order_index = 1),
 'D', 'REM sleep', 'Giấc ngủ REM');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'science-of-sleep'),
 'fill_blank', 'medium',
 'Caffeine improves alertness by blocking _____ receptors, not by creating actual energy.',
 'Caffeine cải thiện sự tỉnh táo bằng cách chặn thụ thể _____, không phải bằng cách tạo ra năng lượng thực sự.',
 'adenosine',
 'Adenosine is a neurotransmitter that accumulates during wakefulness, creating "sleep pressure." Caffeine molecules are structurally similar to adenosine and bind to the same receptors without activating them — blocking the sleepiness signal. The adenosine is still there; caffeine just hides it. When caffeine wears off, you feel the adenosine crash.',
 'Adenosine là chất dẫn truyền thần kinh tích lũy trong khi thức giấc, tạo ra "áp lực ngủ." Phân tử caffeine có cấu trúc tương tự adenosine và gắn vào cùng thụ thể mà không kích hoạt chúng — chặn tín hiệu buồn ngủ. Adenosine vẫn còn đó; caffeine chỉ che giấu nó. Khi caffeine hết tác dụng, bạn cảm thấy sự sụp đổ của adenosine.',
 2),
((SELECT id FROM lesson WHERE slug = 'science-of-sleep'),
 'true_false', 'medium',
 'Sleeping extra hours on weekends can fully recover the sleep debt accumulated during the week.',
 'Ngủ thêm giờ vào cuối tuần có thể phục hồi hoàn toàn nợ giấc ngủ tích lũy trong tuần.',
 'false',
 'Sleep debt cannot be fully paid back. Research shows that even after a full week of recovery sleep, some cognitive impairments from chronic sleep deprivation persist. Moreover, "social jet lag" from shifting sleep times on weekends disrupts the circadian rhythm, potentially causing more harm than good.',
 'Nợ giấc ngủ không thể được trả lại hoàn toàn. Nghiên cứu cho thấy rằng ngay cả sau một tuần ngủ phục hồi đầy đủ, một số suy giảm nhận thức từ thiếu ngủ mãn tính vẫn còn tồn tại. Hơn nữa, "jet lag xã hội" từ việc thay đổi thời gian ngủ vào cuối tuần làm gián đoạn nhịp sinh học.',
 3),
((SELECT id FROM lesson WHERE slug = 'science-of-sleep'),
 'sentence_transform', 'medium',
 'Rewrite to correctly describe melatonin: "Melatonin is a stimulant hormone that increases alertness when exposed to bright light."',
 'Viết lại để mô tả đúng melatonin: "Melatonin là hormone kích thích làm tăng sự tỉnh táo khi tiếp xúc với ánh sáng mạnh."',
 'Melatonin is a sleep-promoting hormone released in darkness that decreases when exposed to bright light.',
 'Melatonin is a sleep hormone (not stimulant). It is produced by the pineal gland in response to DARKNESS. Light (especially blue light) suppresses melatonin, signaling the brain to stay awake. This is why bright screens before bed delay sleep onset — the light tells your brain it is still daytime.',
 'Melatonin là hormone giấc ngủ (không phải kích thích). Nó được sản xuất bởi tuyến tùng để đáp ứng với BÓNG TỐI. Ánh sáng (đặc biệt là ánh sáng xanh) ức chế melatonin, báo hiệu não ở lại thức. Đây là lý do tại sao màn hình sáng trước khi ngủ trì hoãn khởi phát giấc ngủ.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'science-of-sleep'),
 'arrange_words', 'medium',
 'Arrange to describe sleep deprivation cognitive effects.',
 'Sắp xếp để mô tả tác động nhận thức của thiếu ngủ.',
 'Being awake 17 hours impairs cognition like mild alcohol intoxication',
 '["impairs", "alcohol", "like", "awake", "17", "hours", "Being", "cognition", "intoxication", "mild"]',
 'Research shows 17-19 hours of continuous wakefulness produces cognitive and motor impairments equivalent to a blood alcohol concentration of 0.05% — legally impaired in many countries. This highlights the serious risks of working long shifts, overnight driving, and other sleep-deprived activities.',
 'Nghiên cứu cho thấy 17-19 giờ thức liên tục gây ra suy giảm nhận thức và vận động tương đương với nồng độ cồn trong máu 0.05% — bị suy giảm về mặt pháp lý ở nhiều quốc gia.',
 5);

-- Lesson 6: Sleep Optimization Strategies
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Sleep Optimization Strategies', 'Chiến Lược Tối Ưu Hóa Giấc Ngủ', 'sleep-optimization-strategies',
  'Apply evidence-based strategies to improve sleep quality and consistency.',
  'Áp dụng các chiến lược dựa trên bằng chứng để cải thiện chất lượng và tính nhất quán của giấc ngủ.',
  'intermediate', 35, 2
FROM category WHERE name = 'Sleep Science';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'sleep-optimization-strategies'),
 'Creating a sleep environment', 'Tạo môi trường ngủ',
 'Optimizing bedroom temperature (18-19°C) for deeper sleep.',
 'Tối ưu hóa nhiệt độ phòng ngủ (18-19°C) để ngủ sâu hơn.', 1),
((SELECT id FROM lesson WHERE slug = 'sleep-optimization-strategies'),
 'Managing sleep timing', 'Quản lý thời gian ngủ',
 'Setting consistent wake times to anchor the circadian rhythm.',
 'Đặt thời gian thức nhất quán để neo nhịp sinh học.', 2),
((SELECT id FROM lesson WHERE slug = 'sleep-optimization-strategies'),
 'Reducing sleep latency', 'Giảm thời gian chờ ngủ',
 'Using a wind-down routine to transition from alertness to sleepiness.',
 'Sử dụng thói quen giảm dần để chuyển đổi từ tỉnh táo sang buồn ngủ.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'sleep-optimization-strategies'),
 'markdown', 'Evidence-Based Sleep Optimization', 'Tối Ưu Hóa Giấc Ngủ Dựa Trên Bằng Chứng',
 E'## The Four Pillars of Sleep Quality\n\n### 1. Consistency (Most Important)\n\n- Same **wake time** every day (including weekends) is the most powerful circadian anchor\n- Consistency matters more than total hours\n- Variable wake times = chronic social jet lag\n\n### 2. Environment\n\n| Factor | Optimal | Why |\n|--------|---------|-----|\n| **Temperature** | 18-19°C (65-67°F) | Body needs to drop core temp to initiate sleep |\n| **Darkness** | Complete blackout | Even small light exposure suppresses melatonin |\n| **Noise** | < 30 dB | White/pink noise can mask disruptive sounds |\n| **Blue light** | None 2h before bed | Mimics daylight, delays sleep onset |\n\n### 3. Wind-Down Routine (1 hour before bed)\n\nSignals the brain to shift from alert → sleepy:\n- Dim lights progressively\n- No screens (or blue-light glasses)\n- Low-stimulation activities: reading, light stretching\n- No stressful tasks or difficult conversations\n\n### 4. Behavioral Strategies\n\n- **Stimulus control**: Bed = sleep only (not work, scrolling)\n- **Sleep restriction**: Temporary reduction of time in bed to build sleep pressure (CBT-I technique)\n- **Relaxation**: 4-7-8 breathing (inhale 4s, hold 7s, exhale 8s)\n- **No clock-watching**: Anxiety about sleep makes it worse\n\n> The best sleep aid is a consistent wake time — it anchors everything else.',
 E'## Bốn Trụ Cột Của Chất Lượng Giấc Ngủ\n\n### 1. Tính Nhất Quán (Quan Trọng Nhất)\n\n- Cùng **thời gian thức** mỗi ngày (kể cả cuối tuần) là neo nhịp sinh học mạnh nhất\n- Tính nhất quán quan trọng hơn tổng số giờ\n\n### 2. Môi Trường\n\n| Yếu tố | Tối ưu | Tại sao |\n|--------|--------|--------|\n| **Nhiệt độ** | 18-19°C | Cơ thể cần giảm nhiệt độ lõi để bắt đầu ngủ |\n| **Độ tối** | Tối hoàn toàn | Ánh sáng nhỏ cũng ức chế melatonin |\n| **Tiếng ồn** | < 30 dB | Tiếng ồn trắng/hồng có thể che giấu âm thanh gây rối |\n| **Ánh sáng xanh** | Không có 2 giờ trước ngủ | Bắt chước ánh sáng ban ngày, trì hoãn khởi phát ngủ |\n\n### 3. Thói Quen Giảm Dần (1 giờ trước khi ngủ)\n\nBáo hiệu não chuyển từ tỉnh táo → buồn ngủ:\n- Làm mờ đèn dần dần\n- Không dùng màn hình (hoặc kính lọc ánh sáng xanh)\n- Hoạt động ít kích thích: đọc sách, căng cơ nhẹ',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'sleep-optimization-strategies'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["Consistent wake time (same every day, including weekends) is the single most effective sleep intervention", "Optimal sleep temperature: 18-19°C — body must lower core temperature to initiate sleep", "Stimulus control: bed = sleep only (no work, phone scrolling) to strengthen sleep-bed association", "Blue light from screens delays sleep onset by suppressing melatonin — avoid 2h before bed", "4-7-8 breathing (inhale 4s, hold 7s, exhale 8s) activates parasympathetic system for sleep"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'sleep-optimization-strategies'),
 'info_box', 'CBT-I: Better Than Sleeping Pills', 'CBT-I: Tốt Hơn Thuốc Ngủ',
 'Cognitive Behavioral Therapy for Insomnia (CBT-I) is recommended by medical guidelines as the FIRST-LINE treatment for chronic insomnia — above sleeping medications. It includes sleep restriction, stimulus control, and cognitive restructuring. 70-80% of patients achieve lasting improvement vs temporary relief from pills.',
 'Liệu pháp Nhận thức Hành vi cho Mất ngủ (CBT-I) được khuyến nghị bởi các hướng dẫn y tế là điều trị HÀNG ĐẦU cho mất ngủ mãn tính — trên thuốc ngủ. Nó bao gồm hạn chế giấc ngủ, kiểm soát kích thích và tái cơ cấu nhận thức. 70-80% bệnh nhân đạt được cải thiện lâu dài so với giảm nhẹ tạm thời từ thuốc.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'sleep-optimization-strategies'),
 'multiple_choice', 'easy',
 'What is the optimal bedroom temperature for initiating deep sleep?',
 'Nhiệt độ phòng ngủ tối ưu để bắt đầu giấc ngủ sâu là bao nhiêu?',
 'B',
 'The body needs to drop its core temperature by 1-2°C to initiate and maintain sleep. A cool bedroom (18-19°C / 65-67°F) facilitates this. Rooms that are too warm prevent the core temperature drop, delaying sleep onset and reducing deep NREM sleep.',
 'Cơ thể cần giảm nhiệt độ lõi xuống 1-2°C để bắt đầu và duy trì giấc ngủ. Phòng ngủ mát (18-19°C) tạo điều kiện cho điều này. Phòng quá ấm ngăn cản việc giảm nhiệt độ lõi, trì hoãn khởi phát giấc ngủ và giảm giấc ngủ NREM sâu.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'sleep-optimization-strategies') AND order_index = 1),
 'A', '15-16°C (59-61°F)', '15-16°C (59-61°F)'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'sleep-optimization-strategies') AND order_index = 1),
 'B', '18-19°C (65-67°F)', '18-19°C (65-67°F)'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'sleep-optimization-strategies') AND order_index = 1),
 'C', '22-24°C (72-75°F)', '22-24°C (72-75°F)'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'sleep-optimization-strategies') AND order_index = 1),
 'D', '26-28°C (79-82°F)', '26-28°C (79-82°F)');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'sleep-optimization-strategies'),
 'fill_blank', 'easy',
 'The behavioral sleep principle of only using your bed for sleep (not work or phone use) is called _____ control.',
 'Nguyên tắc giấc ngủ hành vi chỉ sử dụng giường để ngủ (không làm việc hay dùng điện thoại) được gọi là kiểm soát _____.',
 'stimulus',
 'Stimulus control is a CBT-I technique based on classical conditioning. If you frequently use your bed for work, watching TV, or scrolling, your brain associates the bed with wakefulness rather than sleep. Limiting bed use to sleep only re-establishes the bed-sleep association, making it easier to fall asleep when you lie down.',
 'Kiểm soát kích thích là kỹ thuật CBT-I dựa trên điều kiện hóa cổ điển. Nếu bạn thường xuyên sử dụng giường để làm việc, xem TV hoặc cuộn màn hình, não của bạn liên kết giường với trạng thái thức thay vì ngủ. Giới hạn sử dụng giường chỉ để ngủ tái thiết lập sự liên kết giường-ngủ.',
 2),
((SELECT id FROM lesson WHERE slug = 'sleep-optimization-strategies'),
 'true_false', 'easy',
 'Sleeping in on weekends to compensate for weekday sleep loss is an effective long-term sleep strategy.',
 'Ngủ thêm vào cuối tuần để bù đắp cho việc mất ngủ trong tuần là chiến lược giấc ngủ hiệu quả lâu dài.',
 'false',
 'Sleeping in on weekends creates "social jet lag" — shifting your sleep timing like flying across time zones weekly. This disrupts the circadian rhythm more than it helps. Research shows people who maintain consistent wake times 7 days/week have better sleep quality, metabolic health, and cognitive function than those with variable schedules.',
 'Ngủ thêm vào cuối tuần tạo ra "jet lag xã hội" — thay đổi thời gian ngủ của bạn như bay qua các múi giờ hàng tuần. Điều này làm gián đoạn nhịp sinh học nhiều hơn so với lợi ích. Nghiên cứu cho thấy những người duy trì thời gian thức nhất quán 7 ngày/tuần có chất lượng giấc ngủ, sức khỏe chuyển hóa và chức năng nhận thức tốt hơn.',
 3),
((SELECT id FROM lesson WHERE slug = 'sleep-optimization-strategies'),
 'fill_blank', 'medium',
 'The most important single sleep habit for anchoring your circadian rhythm is a consistent _____ time every day.',
 'Thói quen ngủ đơn lẻ quan trọng nhất để neo nhịp sinh học là thời gian _____ nhất quán mỗi ngày.',
 'wake',
 'A consistent WAKE time (alarm time) is the single most powerful tool for regulating sleep. The wake time anchors your circadian rhythm. Going to bed at varying times is much less disruptive than varying wake times. Sleep specialists prioritize wake time consistency above all other interventions.',
 'Thời gian THỨC nhất quán (thời gian báo thức) là công cụ mạnh nhất để điều chỉnh giấc ngủ. Thời gian thức neo nhịp sinh học của bạn. Đi ngủ vào các thời điểm khác nhau ít gây rối hơn nhiều so với thay đổi thời gian thức. Chuyên gia giấc ngủ ưu tiên tính nhất quán thời gian thức hơn tất cả các can thiệp khác.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'sleep-optimization-strategies'),
 'arrange_words', 'medium',
 'Arrange to describe the wind-down routine purpose.',
 'Sắp xếp để mô tả mục đích của thói quen giảm dần.',
 'A wind down routine signals the brain to transition from alert to sleepy',
 '["the", "from", "signals", "brain", "down", "to", "wind", "routine", "A", "transition", "alert", "sleepy", "to"]',
 'The wind-down routine (typically 30-60 minutes before bed) uses behavioral cues to signal the brain that sleep is approaching. Dimming lights, reducing stimulation, avoiding screens — these actions create a consistent pre-sleep context that the brain learns to associate with upcoming sleep.',
 'Thói quen giảm dần (thường 30-60 phút trước khi ngủ) sử dụng các tín hiệu hành vi để báo hiệu não rằng giấc ngủ đang đến. Làm mờ đèn, giảm kích thích, tránh màn hình — những hành động này tạo ra bối cảnh trước khi ngủ nhất quán mà não học cách liên kết với giấc ngủ sắp tới.',
 5);

-- =============================================================================
-- CATEGORY: Culinary Science
-- =============================================================================

-- Lesson 7: The Science of Cooking
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'The Science of Cooking', 'Khoa Học Nấu Ăn', 'science-of-cooking',
  'Understand the chemistry and physics behind cooking techniques.',
  'Hiểu hóa học và vật lý đằng sau các kỹ thuật nấu ăn.',
  'beginner', 30, 1
FROM category WHERE name = 'Culinary Science';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'science-of-cooking'),
 'Perfecting searing technique', 'Hoàn thiện kỹ thuật áp chảo',
 'Understanding the Maillard reaction to achieve a perfect golden-brown crust.',
 'Hiểu phản ứng Maillard để đạt được lớp vỏ vàng nâu hoàn hảo.', 1),
((SELECT id FROM lesson WHERE slug = 'science-of-cooking'),
 'Understanding emulsification', 'Hiểu sự nhũ hóa',
 'Making stable vinaigrette by understanding how mustard acts as an emulsifier.',
 'Làm vinaigrette ổn định bằng cách hiểu cách mù tạt hoạt động như chất nhũ hóa.', 2),
((SELECT id FROM lesson WHERE slug = 'science-of-cooking'),
 'Temperature precision', 'Độ chính xác nhiệt độ',
 'Using a thermometer to cook chicken to 74°C for safety without overcooking.',
 'Dùng nhiệt kế nấu gà đến 74°C để an toàn mà không quá chín.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'science-of-cooking'),
 'markdown', 'Food Science Fundamentals', 'Kiến Thức Khoa Học Thực Phẩm Cơ Bản',
 E'## Why Cooking Is Applied Chemistry\n\nCooking transforms food through chemical and physical reactions. Understanding these reactions makes you a better, more intuitive cook.\n\n### The Maillard Reaction\n\nThe browning reaction between amino acids and sugars at **140-165°C (280-330°F)**:\n- Creates hundreds of new flavor compounds\n- Produces the golden-brown crust on meat, bread, and coffee\n- **Requires dry surface** — wet food steams instead of browns\n- Key technique: **pat meat dry** before searing\n\n### Protein Denaturation\n\nHeat unwinds protein structures:\n- **Eggs**: whites set at 62°C, yolks at 70°C\n- **Chicken**: safe at 74°C (165°F) — the food safety threshold\n- **Beef steak**: rare=52°C, medium=60°C, well-done=71°C\n- Overcooking = too much denaturation = tough, dry texture\n\n### Emulsification\n\nMixing two immiscible liquids (oil + water) using an **emulsifier**:\n- **Lecithin** in egg yolk → mayonnaise\n- **Mustard** → vinaigrette\n- **Butter** → hollandaise sauce\n\nEmulsifiers have hydrophilic (water-loving) and hydrophobic (oil-loving) ends, bridging the two liquids.\n\n### The Role of Salt\n\n- **Osmosis**: Salt draws moisture out (curing, brining)\n- **Brining**: Salt + water penetrates meat, denaturing some proteins, making meat more tender and juicy\n- **Seasoning**: Salt enhances flavor by suppressing bitterness receptors',
 E'## Tại Sao Nấu Ăn Là Hóa Học Ứng Dụng\n\nNấu ăn biến đổi thực phẩm thông qua các phản ứng hóa học và vật lý. Hiểu những phản ứng này giúp bạn nấu ăn tốt hơn và trực giác hơn.\n\n### Phản Ứng Maillard\n\nPhản ứng hóa nâu giữa amino acid và đường ở **140-165°C**:\n- Tạo ra hàng trăm hợp chất hương vị mới\n- Tạo ra lớp vỏ vàng nâu trên thịt, bánh mì và cà phê\n- **Yêu cầu bề mặt khô** — thực phẩm ướt hấp thay vì nâu\n- Kỹ thuật chính: **thấm khô thịt** trước khi áp chảo\n\n### Biến Tính Protein\n\nNhiệt tháo xoắn cấu trúc protein:\n- **Trứng**: lòng trắng đông ở 62°C, lòng đỏ ở 70°C\n- **Gà**: an toàn ở 74°C\n- **Bò**: tái=52°C, vừa=60°C, chín kỹ=71°C\n\n### Nhũ Hóa\n\nTrộn hai chất lỏng không trộn lẫn (dầu + nước) bằng **chất nhũ hóa**:\n- **Lecithin** trong lòng đỏ trứng → mayonnaise\n- **Mù tạt** → vinaigrette\n- Chất nhũ hóa có đầu ưa nước và đầu ưa dầu, kết nối hai chất lỏng.',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'science-of-cooking'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["Maillard reaction: browning of amino acids + sugars at 140-165°C — creates complex flavors (requires dry surface)", "Protein denaturation: chicken safe at 74°C; eggs set at 62-70°C; overcooking = tough texture", "Emulsification: combining oil and water with an emulsifier (lecithin in egg yolk, mustard)", "Brining: salt + water penetrates meat through osmosis, making it juicier and more tender", "Salt suppresses bitterness receptors — it doesn''t just add saltiness, it enhances overall flavor"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'science-of-cooking'),
 'info_box', 'Why Restaurant Steaks Taste Better', 'Tại Sao Bít Tết Nhà Hàng Ngon Hơn',
 'Restaurant steaks achieve a better crust because: 1) They use very high-heat equipment (500°C+ broilers), 2) The meat is completely dry before searing, 3) They use more butter and salt. The key insight: a wet surface means steam is generated, dropping the pan temperature below Maillard range, preventing browning.',
 'Bít tết nhà hàng có lớp vỏ tốt hơn vì: 1) Họ sử dụng thiết bị nhiệt cao (lò nướng 500°C+), 2) Thịt hoàn toàn khô trước khi áp chảo, 3) Họ dùng nhiều bơ và muối hơn. Điểm mấu chốt: bề mặt ướt có nghĩa là hơi nước được tạo ra, làm giảm nhiệt độ chảo dưới phạm vi Maillard, ngăn chặn hóa nâu.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'science-of-cooking'),
 'multiple_choice', 'easy',
 'What is the Maillard reaction responsible for in cooking?',
 'Phản ứng Maillard chịu trách nhiệm điều gì trong nấu ăn?',
 'B',
 'The Maillard reaction (between amino acids and reducing sugars at 140-165°C) creates the hundreds of flavor compounds and the golden-brown color in seared meat, toasted bread, roasted coffee, and grilled foods. It is distinct from caramelization (which only involves sugars, not proteins).',
 'Phản ứng Maillard (giữa amino acid và đường khử ở 140-165°C) tạo ra hàng trăm hợp chất hương vị và màu vàng nâu trong thịt áp chảo, bánh mì nướng, cà phê rang và thực phẩm nướng vỉ. Nó khác với caramel hóa (chỉ liên quan đến đường, không phải protein).',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'science-of-cooking') AND order_index = 1),
 'A', 'Making food safe to eat by killing bacteria', 'Làm thực phẩm an toàn để ăn bằng cách tiêu diệt vi khuẩn'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'science-of-cooking') AND order_index = 1),
 'B', 'Creating flavor compounds and golden-brown color when cooking', 'Tạo ra hợp chất hương vị và màu vàng nâu khi nấu'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'science-of-cooking') AND order_index = 1),
 'C', 'Breaking down fat into digestible molecules', 'Phân hủy chất béo thành phân tử có thể tiêu hóa'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'science-of-cooking') AND order_index = 1),
 'D', 'Emulsifying oil and water together', 'Nhũ hóa dầu và nước với nhau');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'science-of-cooking'),
 'fill_blank', 'easy',
 'For a proper Maillard browning crust, meat must have a _____ surface before going into the pan.',
 'Để có lớp vỏ Maillard hóa nâu đúng cách, thịt phải có bề mặt _____ trước khi vào chảo.',
 'dry',
 'Moisture on the meat surface must first evaporate before the temperature can rise high enough for the Maillard reaction (140°C+). Wet meat stays at 100°C (water boiling point) too long, steaming instead of browning. Patting dry with paper towels before searing is one of the most impactful steps for a good crust.',
 'Độ ẩm trên bề mặt thịt phải bay hơi trước khi nhiệt độ có thể tăng đủ cao cho phản ứng Maillard (140°C+). Thịt ướt ở 100°C (điểm sôi của nước) quá lâu, hấp thay vì hóa nâu. Thấm khô bằng giấy trước khi áp chảo là một trong những bước có tác động lớn nhất để có lớp vỏ tốt.',
 2),
((SELECT id FROM lesson WHERE slug = 'science-of-cooking'),
 'true_false', 'medium',
 'Emulsification is only possible using industrial chemicals — natural foods cannot act as emulsifiers.',
 'Nhũ hóa chỉ có thể thực hiện được bằng hóa chất công nghiệp — thực phẩm tự nhiên không thể hoạt động như chất nhũ hóa.',
 'false',
 'Many natural foods are excellent emulsifiers. Egg yolk contains lecithin (a phospholipid) — the emulsifier in mayonnaise and hollandaise. Mustard contains mucilage compounds that stabilize vinaigrettes. Honey contains beeswax. Natural emulsifiers are used constantly in home and professional cooking.',
 'Nhiều thực phẩm tự nhiên là chất nhũ hóa tuyệt vời. Lòng đỏ trứng chứa lecithin (một phospholipid) — chất nhũ hóa trong mayonnaise và hollandaise. Mù tạt chứa các hợp chất nhầy ổn định vinaigrette. Mật ong chứa sáp ong. Chất nhũ hóa tự nhiên được sử dụng liên tục trong nấu ăn tại nhà và chuyên nghiệp.',
 3),
((SELECT id FROM lesson WHERE slug = 'science-of-cooking'),
 'fill_blank', 'medium',
 'The minimum safe internal temperature for cooked chicken to kill harmful bacteria is _____ °C.',
 'Nhiệt độ bên trong tối thiểu an toàn để nấu chín gà nhằm tiêu diệt vi khuẩn có hại là _____ °C.',
 '74',
 '74°C (165°F) is the USDA safe minimum internal temperature for poultry. At this temperature, salmonella and other pathogens are reliably destroyed. Using a meat thermometer is more accurate than visual cues (color, juices running clear) — the only reliable way to ensure food safety.',
 '74°C (165°F) là nhiệt độ bên trong tối thiểu an toàn của USDA cho gia cầm. Ở nhiệt độ này, salmonella và các mầm bệnh khác bị tiêu diệt đáng tin cậy. Sử dụng nhiệt kế thịt chính xác hơn các tín hiệu thị giác (màu sắc, nước chảy trong) — cách duy nhất đáng tin cậy để đảm bảo an toàn thực phẩm.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'science-of-cooking'),
 'arrange_words', 'medium',
 'Arrange to explain why the Maillard reaction requires high heat.',
 'Sắp xếp để giải thích tại sao phản ứng Maillard đòi hỏi nhiệt độ cao.',
 'Maillard reaction needs temperatures above 140 degrees to create flavor compounds',
 '["degrees", "above", "flavor", "to", "Maillard", "temperatures", "140", "create", "needs", "reaction", "compounds"]',
 'The Maillard reaction requires temperatures above 140°C (280°F). Below this threshold, proteins and sugars do not react in the same way. This is why boiling (100°C) cannot brown food — the water keeps the temperature at exactly 100°C regardless of how long you cook. Only dry-heat methods (roasting, searing, grilling) can reach Maillard temperatures.',
 'Phản ứng Maillard đòi hỏi nhiệt độ trên 140°C (280°F). Dưới ngưỡng này, protein và đường không phản ứng theo cùng cách. Đây là lý do tại sao luộc (100°C) không thể hóa nâu thực phẩm — nước giữ nhiệt độ ở đúng 100°C bất kể bạn nấu bao lâu.',
 5);

-- Lesson 8: Flavor Development & Cuisine Principles
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Flavor Development & Cuisine Principles', 'Phát Triển Hương Vị & Nguyên Tắc Ẩm Thực', 'flavor-development-cuisine',
  'Master the art of balancing flavors and building depth in cooking.',
  'Thành thạo nghệ thuật cân bằng hương vị và xây dựng chiều sâu trong nấu ăn.',
  'intermediate', 40, 2
FROM category WHERE name = 'Culinary Science';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'flavor-development-cuisine'),
 'Balancing a dish', 'Cân bằng một món ăn',
 'Using acid (lemon juice) to brighten a dish that tastes flat or too fatty.',
 'Sử dụng axit (nước chanh) để làm sáng món ăn có vị phẳng hoặc quá béo.', 1),
((SELECT id FROM lesson WHERE slug = 'flavor-development-cuisine'),
 'Building flavor base', 'Xây dựng nền hương vị',
 'Using mirepoix (onion, carrot, celery) as the aromatic foundation of soups.',
 'Sử dụng mirepoix (hành tây, cà rốt, cần tây) làm nền thơm của súp.', 2),
((SELECT id FROM lesson WHERE slug = 'flavor-development-cuisine'),
 'Umami enhancement', 'Tăng cường umami',
 'Adding parmesan rind or anchovies to tomato sauce for depth.',
 'Thêm vỏ parmesan hoặc cá cơm vào nước sốt cà chua để tạo chiều sâu.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'flavor-development-cuisine'),
 'markdown', 'The Architecture of Flavor', 'Kiến Trúc Hương Vị',
 E'## The Five Basic Tastes\n\n| Taste | Examples | Function |\n|-------|---------|----------|\n| **Sweet** | Sugar, fruit, carrots | Energy signals |\n| **Salty** | Table salt, soy sauce | Mineral balance |\n| **Sour** | Lemon, vinegar, yogurt | Freshness, brightness |\n| **Bitter** | Coffee, dark chocolate, greens | Toxin warning |\n| **Umami** | Meat, mushrooms, tomatoes, aged cheese | Protein richness |\n\n### Umami (The Fifth Taste)\n\nDiscovered by Kikunae Ikeda (1908). Caused by glutamate and nucleotides:\n- **Natural umami bombs**: anchovies, parmesan, miso, soy sauce, mushrooms, tomatoes\n- **Synergy**: Combining umami sources (e.g., mushroom + parmesan) multiplies the effect\n- **MSG**: Monosodium glutamate is pure umami — chemically identical to natural glutamate\n\n### Flavor Balancing\n\nWhen a dish is off-balance:\n\n| Problem | Solution |\n|---------|----------|\n| Too salty | Add acid (lemon), starch to dilute |\n| Too bitter | Add fat, sweetness, or salt |\n| Too sweet | Add acid or salt |\n| Too flat/bland | Add salt, acid, or umami |\n| Too rich/fatty | Add acid to cut through |\n\n### Aromatic Foundation (Mirepoix)\n\nFrench: onion (50%) + carrot (25%) + celery (25%)\nSpanish sofrito: onion + garlic + tomato\nItalian soffritto: onion + carrot + celery + garlic\n\nThese aromatics are sweated (low heat, no browning) to build the flavor base.',
 E'## Năm Vị Cơ Bản\n\n| Vị | Ví dụ | Chức năng |\n|----|-------|----------|\n| **Ngọt** | Đường, trái cây, cà rốt | Tín hiệu năng lượng |\n| **Mặn** | Muối, nước tương | Cân bằng khoáng chất |\n| **Chua** | Chanh, giấm, sữa chua | Độ tươi mát, sáng |\n| **Đắng** | Cà phê, sô-cô-la đen, rau xanh | Cảnh báo độc tố |\n| **Umami** | Thịt, nấm, cà chua, phô mai già | Sự phong phú protein |\n\n### Umami (Vị Thứ Năm)\n\nĐược khám phá bởi Kikunae Ikeda (1908). Gây ra bởi glutamate và nucleotide:\n- **Bom umami tự nhiên**: cá cơm, parmesan, miso, tương đậu nành, nấm, cà chua\n- **Hiệu ứng cộng hưởng**: Kết hợp nguồn umami (ví dụ: nấm + parmesan) nhân lên tác dụng\n\n### Cân Bằng Hương Vị\n\n| Vấn đề | Giải pháp |\n|--------|----------|\n| Quá mặn | Thêm axit (chanh), tinh bột để pha loãng |\n| Quá đắng | Thêm chất béo, vị ngọt hoặc muối |\n| Quá ngọt | Thêm axit hoặc muối |\n| Nhạt nhẽo | Thêm muối, axit hoặc umami |\n| Quá béo | Thêm axit để cắt qua |',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'flavor-development-cuisine'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["Five basic tastes: sweet, salty, sour, bitter, umami — all others are aroma (retronasal smell)", "Umami (5th taste) comes from glutamate in anchovies, parmesan, mushrooms, soy sauce, tomatoes", "Acid (lemon, vinegar) brightens and balances — add to flat, rich, or overly sweet dishes", "Mirepoix (onion 50% + carrot 25% + celery 25%) is the French aromatic foundation sweated in fat", "Umami synergy: combining glutamate sources multiplies the umami effect beyond simple addition"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'flavor-development-cuisine'),
 'info_box', 'MSG and the Umami Myth', 'MSG và Huyền Thoại Umami',
 'MSG (monosodium glutamate) is chemically identical to the glutamate in parmesan, tomatoes, and soy sauce. Despite persistent myths, rigorous double-blind studies have found no evidence that MSG causes headaches in normal doses. The same people who report MSG sensitivity show no reaction when given MSG without being told.',
 'MSG (mononatri glutamate) có cấu trúc hóa học giống hệt glutamate trong parmesan, cà chua và nước tương. Bất chấp những huyền thoại dai dẳng, các nghiên cứu mù đôi nghiêm ngặt không tìm thấy bằng chứng nào cho thấy MSG gây đau đầu ở liều thông thường. Những người báo cáo nhạy cảm MSG không có phản ứng khi được cho MSG mà không được thông báo.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'flavor-development-cuisine'),
 'multiple_choice', 'easy',
 'A dish tastes too rich and fatty. What is the best way to balance it?',
 'Một món ăn có vị quá béo và giàu chất béo. Cách tốt nhất để cân bằng nó là gì?',
 'C',
 'Acid (lemon juice, vinegar, wine) cuts through fat by providing a contrasting bright flavor that stimulates salivation and "cuts" the coating sensation of fat on the palate. This is why a squeeze of lemon on pan-fried fish or vinaigrette on a rich salad makes them taste balanced rather than heavy.',
 'Axit (nước chanh, giấm, rượu) cắt qua chất béo bằng cách cung cấp hương vị sáng tương phản kích thích tiết nước bọt và "cắt" cảm giác phủ của chất béo trên vị giác. Đây là lý do tại sao vắt chanh lên cá chiên hoặc vinaigrette trên salad phong phú làm chúng có vị cân bằng hơn là nặng nề.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'flavor-development-cuisine') AND order_index = 1),
 'A', 'Add more salt to balance the fat', 'Thêm muối để cân bằng chất béo'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'flavor-development-cuisine') AND order_index = 1),
 'B', 'Add more fat to homogenize it', 'Thêm chất béo để đồng nhất hóa'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'flavor-development-cuisine') AND order_index = 1),
 'C', 'Add acid such as lemon juice or vinegar', 'Thêm axit như nước chanh hoặc giấm'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'flavor-development-cuisine') AND order_index = 1),
 'D', 'Add sweetness to contrast the fat', 'Thêm vị ngọt để tương phản với chất béo');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'flavor-development-cuisine'),
 'fill_blank', 'medium',
 'The fifth basic taste, first described by Kikunae Ikeda in 1908, caused by glutamate in foods like mushrooms and aged cheese, is called _____.',
 'Vị cơ bản thứ năm, được Kikunae Ikeda mô tả lần đầu năm 1908, gây ra bởi glutamate trong thực phẩm như nấm và phô mai già, được gọi là _____.',
 'umami',
 'Umami (Japanese for "pleasant savory taste") was identified by Kikunae Ikeda at the University of Tokyo. He isolated glutamic acid from kombu seaweed as the source. Umami is triggered by L-glutamate (amino acid) and ribonucleotides (IMP, GMP). It is the taste of protein richness.',
 'Umami (tiếng Nhật nghĩa là "vị ngon thơm dễ chịu") được Kikunae Ikeda xác định tại Đại học Tokyo. Ông đã phân lập axit glutamic từ tảo bẹ kombu như là nguồn. Umami được kích hoạt bởi L-glutamate (amino acid) và ribonucleotide (IMP, GMP). Đó là vị của sự phong phú protein.',
 2),
((SELECT id FROM lesson WHERE slug = 'flavor-development-cuisine'),
 'true_false', 'easy',
 'Mirepoix is a combination of equal parts onion, carrot, and celery used as the flavor base of many French dishes.',
 'Mirepoix là sự kết hợp bằng phần nhau của hành tây, cà rốt và cần tây được dùng làm nền hương vị của nhiều món Pháp.',
 'false',
 'Mirepoix uses a 2:1:1 ratio — 50% onion, 25% carrot, 25% celery (NOT equal parts). The ratio is important: onion provides the dominant sweet aromatic base, while carrot adds sweetness and celery adds savory depth. This ratio is standard in classical French cuisine.',
 'Mirepoix sử dụng tỉ lệ 2:1:1 — 50% hành tây, 25% cà rốt, 25% cần tây (KHÔNG bằng phần nhau). Tỉ lệ quan trọng: hành tây cung cấp nền thơm ngọt chủ đạo, cà rốt thêm vị ngọt và cần tây thêm chiều sâu mặn mà. Tỉ lệ này là tiêu chuẩn trong ẩm thực Pháp cổ điển.',
 3),
((SELECT id FROM lesson WHERE slug = 'flavor-development-cuisine'),
 'sentence_transform', 'medium',
 'Rewrite to give correct advice for a dish that tastes too bitter: "To fix bitterness in a dish, add more bitter ingredients to balance it out."',
 'Viết lại để đưa ra lời khuyên đúng cho món ăn có vị quá đắng: "Để khắc phục vị đắng trong món ăn, thêm nhiều nguyên liệu đắng hơn để cân bằng nó."',
 'To fix bitterness in a dish, add fat, sweetness, or salt to mask and balance it.',
 'Adding more bitter ingredients would intensify the bitterness. Bitterness is counteracted by fat (coats receptors), sweetness (direct contrast), or salt (suppresses bitterness perception). Examples: adding cream to bitter coffee, sugar to bitter greens, or salt to reduce perceived bitterness in chocolate.',
 'Thêm nhiều nguyên liệu đắng sẽ tăng cường vị đắng. Vị đắng được đối lập bởi chất béo (phủ thụ thể), vị ngọt (tương phản trực tiếp) hoặc muối (ức chế cảm nhận đắng). Ví dụ: thêm kem vào cà phê đắng, đường vào rau đắng hoặc muối để giảm vị đắng nhận thức trong sô-cô-la.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'flavor-development-cuisine'),
 'arrange_words', 'easy',
 'Arrange to describe the classic French aromatic base.',
 'Sắp xếp để mô tả nền thơm cổ điển của Pháp.',
 'Mirepoix combines onion carrot and celery as an aromatic base',
 '["celery", "as", "carrot", "combines", "Mirepoix", "aromatic", "onion", "base", "an", "and"]',
 'Mirepoix (named after the Duc de Lévis-Mirepoix, an 18th-century French nobleman) is the foundational aromatic mixture of French cuisine. These vegetables are typically sweated (cooked gently in fat without browning) to release their aromatic compounds and form the flavor foundation of stocks, soups, braises, and sauces.',
 'Mirepoix (đặt theo tên Duc de Lévis-Mirepoix, quý tộc Pháp thế kỷ 18) là hỗn hợp thơm nền tảng của ẩm thực Pháp. Những loại rau này thường được xào nhẹ (nấu nhẹ nhàng trong chất béo không hóa nâu) để giải phóng các hợp chất thơm và tạo nền hương vị của nước dùng, súp và nước sốt.',
 5);
