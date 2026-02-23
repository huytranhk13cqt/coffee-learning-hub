-- ============================================================================
-- SEED DATA: Interactive Charts (Explorable Explanations)
-- Run AFTER: migration 018 + relevant lesson seed files
--
-- Interactive charts let students manipulate parameters via sliders
-- and observe real-time chart changes. Uses safe predefined generators
-- (no eval/Function) defined in src/components/lesson/sections/chartGenerators.js
-- ============================================================================


-- 1. MATH — Quadratic Function Explorer (y = ax² + bx + c)
-- Lesson: math-algebra (Algebra Basics)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index)
SELECT l.id, 'interactive_chart'::lesson_section_type,
  'Quadratic Function Explorer',
  'Khám phá hàm bậc hai',
  'Drag the sliders to see how coefficients **a**, **b**, and **c** change the parabola. Notice: **a** controls width and direction, **b** shifts the vertex horizontally, and **c** moves it vertically.',
  'Kéo thanh trượt để xem các hệ số **a**, **b**, **c** thay đổi đồ thị parabol. Lưu ý: **a** quyết định độ rộng và hướng, **b** dịch đỉnh theo chiều ngang, **c** dịch theo chiều dọc.',
  '{
    "chartType": "line",
    "generator": "quadratic",
    "xRange": [-10, 10, 0.5],
    "xKey": "x",
    "series": [
      { "dataKey": "y", "name": "y = ax² + bx + c" }
    ],
    "parameters": [
      { "key": "a", "label": "Coefficient a", "label_vi": "Hệ số a", "min": -3, "max": 3, "step": 0.1, "default": 1 },
      { "key": "b", "label": "Coefficient b", "label_vi": "Hệ số b", "min": -5, "max": 5, "step": 0.5, "default": 0 },
      { "key": "c", "label": "Coefficient c", "label_vi": "Hệ số c", "min": -10, "max": 10, "step": 1, "default": 0 }
    ],
    "colors": ["#6366f1"]
  }'::jsonb,
  50
FROM lesson l WHERE l.slug = 'math-algebra';


-- 2. PHYSICS — Sine Wave / Oscillation (y = A·sin(ωx))
-- Lesson: physics-newtons-laws (Newton's Laws of Motion)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index)
SELECT l.id, 'interactive_chart'::lesson_section_type,
  'Simple Harmonic Motion',
  'Dao động điều hòa đơn giản',
  'Explore how **amplitude** and **frequency** affect a sine wave. In physics, this models oscillations like pendulums and springs. Higher frequency = more oscillations per cycle.',
  'Khám phá cách **biên độ** và **tần số** ảnh hưởng đến sóng hình sin. Trong vật lý, mô hình này mô tả dao động như con lắc và lò xo. Tần số cao hơn = nhiều dao động hơn trong mỗi chu kỳ.',
  '{
    "chartType": "line",
    "generator": "sine",
    "xRange": [0, 720, 3],
    "xKey": "x",
    "series": [
      { "dataKey": "y", "name": "y = A·sin(ωx)" }
    ],
    "parameters": [
      { "key": "A", "label": "Amplitude (A)", "label_vi": "Biên độ (A)", "min": 0.5, "max": 3, "step": 0.1, "default": 1 },
      { "key": "f", "label": "Frequency (ω)", "label_vi": "Tần số (ω)", "min": 1, "max": 5, "step": 0.5, "default": 1 }
    ],
    "colors": ["#0ea5e9"]
  }'::jsonb,
  50
FROM lesson l WHERE l.slug = 'physics-newtons-laws';


-- 3. ECONOMICS — Supply & Demand Curves
-- Lesson: economics-supply-demand
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index)
SELECT l.id, 'interactive_chart'::lesson_section_type,
  'Supply & Demand Interactive',
  'Cung và Cầu tương tác',
  'Adjust the slopes to see how **supply** and **demand** curves shift. Where they intersect is the **equilibrium point** — the market price where quantity supplied equals quantity demanded.',
  'Điều chỉnh độ dốc để xem đường **cung** và **cầu** thay đổi. Nơi chúng giao nhau là **điểm cân bằng** — mức giá thị trường khi lượng cung bằng lượng cầu.',
  '{
    "chartType": "line",
    "xRange": [0, 100, 2],
    "xKey": "x",
    "series": [
      { "dataKey": "supply", "name": "Cung (Supply)", "generator": "supply" },
      { "dataKey": "demand", "name": "Cầu (Demand)", "generator": "demand" }
    ],
    "parameters": [
      { "key": "slope", "label": "Supply/Demand slope", "label_vi": "Độ dốc cung/cầu", "min": 0.1, "max": 2, "step": 0.1, "default": 0.5 },
      { "key": "base", "label": "Supply base price", "label_vi": "Giá cung cơ bản", "min": 0, "max": 30, "step": 1, "default": 10 },
      { "key": "intercept", "label": "Demand intercept", "label_vi": "Giá cầu tối đa", "min": 50, "max": 150, "step": 5, "default": 100 }
    ],
    "colors": ["#10b981", "#ef4444"]
  }'::jsonb,
  50
FROM lesson l WHERE l.slug = 'economics-supply-demand';


-- 4. DATA SCIENCE — Normal Distribution (Bell Curve)
-- Lesson: data-science-intro
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index)
SELECT l.id, 'interactive_chart'::lesson_section_type,
  'Normal Distribution Explorer',
  'Khám phá phân phối chuẩn',
  'The **bell curve** is the foundation of statistics. **μ (mu)** shifts the center, **σ (sigma)** controls spread — smaller sigma = taller and narrower peak. ~68% of data falls within 1σ of the mean.',
  'Đường cong **hình chuông** là nền tảng của thống kê. **μ (mu)** dịch tâm, **σ (sigma)** điều khiển độ rộng — sigma nhỏ = đỉnh cao và hẹp hơn. ~68% dữ liệu nằm trong 1σ so với trung bình.',
  '{
    "chartType": "area",
    "generator": "normal",
    "xRange": [-10, 10, 0.2],
    "xKey": "x",
    "series": [
      { "dataKey": "y", "name": "f(x)" }
    ],
    "parameters": [
      { "key": "mu", "label": "Mean (μ)", "label_vi": "Trung bình (μ)", "min": -5, "max": 5, "step": 0.5, "default": 0 },
      { "key": "sigma", "label": "Std Dev (σ)", "label_vi": "Độ lệch chuẩn (σ)", "min": 0.5, "max": 4, "step": 0.1, "default": 1 },
      { "key": "scale", "label": "Scale", "label_vi": "Tỉ lệ", "min": 50, "max": 200, "step": 10, "default": 100 }
    ],
    "colors": ["#8b5cf6"]
  }'::jsonb,
  50
FROM lesson l WHERE l.slug = 'data-science-intro';


-- 5. MATH — Exponential Growth vs Linear
-- Lesson: math-algebra
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index)
SELECT l.id, 'interactive_chart'::lesson_section_type,
  'Exponential vs Linear Growth',
  'Tăng trưởng mũ so với tuyến tính',
  'Compare **linear growth** (constant rate) with **exponential growth** (accelerating rate). Notice how exponential always overtakes linear — this is why compound interest is so powerful!',
  'So sánh **tăng trưởng tuyến tính** (tốc độ không đổi) với **tăng trưởng mũ** (tốc độ tăng dần). Lưu ý tăng trưởng mũ luôn vượt qua tuyến tính — đây là lý do lãi kép rất mạnh mẽ!',
  '{
    "chartType": "line",
    "xRange": [0, 20, 0.5],
    "xKey": "x",
    "series": [
      { "dataKey": "linear", "name": "Tuyến tính (mx + b)", "generator": "linear" },
      { "dataKey": "exp", "name": "Mũ (a·e^(rx))", "generator": "exponential" }
    ],
    "parameters": [
      { "key": "m", "label": "Linear slope (m)", "label_vi": "Độ dốc tuyến tính (m)", "min": 1, "max": 20, "step": 1, "default": 5 },
      { "key": "b", "label": "Linear intercept (b)", "label_vi": "Hệ số chặn tuyến tính (b)", "min": 0, "max": 50, "step": 5, "default": 10 },
      { "key": "a", "label": "Exp coefficient (a)", "label_vi": "Hệ số mũ (a)", "min": 1, "max": 10, "step": 1, "default": 1 },
      { "key": "r", "label": "Growth rate (r)", "label_vi": "Tốc độ tăng trưởng (r)", "min": 0.05, "max": 0.5, "step": 0.05, "default": 0.2 }
    ],
    "colors": ["#3b82f6", "#ef4444"]
  }'::jsonb,
  55
FROM lesson l WHERE l.slug = 'math-algebra';
