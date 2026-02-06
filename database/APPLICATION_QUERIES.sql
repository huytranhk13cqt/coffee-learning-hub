-- ============================================================================
-- APPLICATION QUERIES
-- Tất cả các câu truy vấn quan trọng mà ứng dụng sẽ sử dụng
-- Phân loại theo màn hình / tính năng
-- ============================================================================

USE grammar_learning;

-- ############################################################################
-- A. HOMEPAGE / NAVIGATION
-- ############################################################################

-- ---------------------------------------------------------------------------
-- A1. Lấy danh sách Tense Groups kèm số lesson đã published
-- Dùng khi: Render sidebar/menu chính, homepage cards
-- Tần suất: Cao (mỗi lần load trang)
-- Index sử dụng: PRIMARY KEY (tense_group), idx_lesson_group, idx_lesson_published
-- ---------------------------------------------------------------------------
SELECT
    g.id,
    g.name,
    g.name_vi,
    g.description,
    g.description_vi,
    g.icon,
    g.color,
    g.order_index,
    COUNT(l.id) AS lesson_count
FROM tense_group g
LEFT JOIN lesson l ON l.group_id = g.id AND l.is_published = TRUE
GROUP BY g.id
ORDER BY g.order_index;

-- ---------------------------------------------------------------------------
-- A2. Lấy tất cả lessons đã published, nhóm theo group
-- Dùng khi: Trang danh sách bài học (có thể dùng thay A1 nếu muốn 1 query)
-- Index sử dụng: idx_lesson_published, idx_lesson_group
-- ---------------------------------------------------------------------------
SELECT
    l.id,
    l.name,
    l.name_vi,
    l.slug,
    l.short_desc,
    l.short_desc_vi,
    l.difficulty,
    l.estimated_time,
    l.order_index   AS lesson_order,
    g.id            AS group_id,
    g.name          AS group_name,
    g.name_vi       AS group_name_vi,
    g.color         AS group_color,
    g.icon          AS group_icon,
    g.order_index   AS group_order
FROM lesson l
JOIN tense_group g ON l.group_id = g.id
WHERE l.is_published = TRUE
ORDER BY g.order_index, l.order_index;

-- ---------------------------------------------------------------------------
-- A3. Lấy lessons theo một group cụ thể (khi click vào "Thì Hiện Tại")
-- Dùng khi: Xem danh sách bài trong 1 nhóm
-- Index sử dụng: idx_lesson_group
-- ---------------------------------------------------------------------------
SELECT
    l.id,
    l.name,
    l.name_vi,
    l.slug,
    l.short_desc,
    l.short_desc_vi,
    l.difficulty,
    l.estimated_time,
    l.order_index
FROM lesson l
WHERE l.group_id = ?                    -- :group_id
  AND l.is_published = TRUE
ORDER BY l.order_index;


-- ############################################################################
-- B. LESSON PAGE (Trang lý thuyết)
-- ############################################################################

-- ---------------------------------------------------------------------------
-- B1. Lấy thông tin lesson theo slug (URL routing)
-- Dùng khi: Người dùng truy cập /lesson/simple-present
-- Index sử dụng: uq_lesson_slug (UNIQUE index = O(1) lookup)
-- ---------------------------------------------------------------------------
SELECT
    l.*,
    g.name          AS group_name,
    g.name_vi       AS group_name_vi,
    g.color         AS group_color,
    g.icon          AS group_icon
FROM lesson l
JOIN tense_group g ON l.group_id = g.id
WHERE l.slug = ?                        -- :slug
  AND l.is_published = TRUE;

-- ---------------------------------------------------------------------------
-- B2. Lấy formulas cho 1 lesson
-- Dùng khi: Hiển thị phần công thức (S + V + O, S + do/does + not + V, ...)
-- Index sử dụng: uq_formula_lesson_type (lesson_id là leftmost prefix)
-- ---------------------------------------------------------------------------
SELECT
    id,
    type,
    subject_note,
    structure,
    structure_vi,
    example,
    example_vi,
    example_negative,
    note
FROM formula
WHERE lesson_id = ?                     -- :lesson_id
ORDER BY order_index;

-- ---------------------------------------------------------------------------
-- B3. Lấy usages kèm examples (2 cách)
-- ---------------------------------------------------------------------------

-- Cách 1: 2 query riêng (đơn giản, dễ xử lý ở application)
-- Query B3a: Lấy usages
SELECT
    id,
    title,
    title_vi,
    description,
    description_vi,
    icon,
    is_common
FROM lesson_usage
WHERE lesson_id = ?                     -- :lesson_id
ORDER BY order_index;

-- Query B3b: Lấy examples cho tất cả usages của lesson (1 query thay vì N query)
SELECT
    e.id,
    e.usage_id,
    e.sentence,
    e.sentence_vi,
    e.explanation,
    e.explanation_vi,
    e.highlight_word,
    e.audio_url
FROM example e
JOIN lesson_usage u ON e.usage_id = u.id
WHERE u.lesson_id = ?                   -- :lesson_id
ORDER BY u.order_index, e.order_index;

-- Cách 2: JOIN + GROUP_CONCAT (1 query, nhưng xử lý phức tạp hơn ở app)
-- Không khuyến khích vì GROUP_CONCAT có giới hạn mặc định 1024 bytes
-- và JSON_ARRAYAGG có thể gây khó debug

-- ---------------------------------------------------------------------------
-- B4. Lấy signal words cho 1 lesson
-- Dùng khi: Hiển thị phần "Dấu hiệu nhận biết"
-- Index sử dụng: uq_signal_word_lesson_word (lesson_id là leftmost prefix)
-- ---------------------------------------------------------------------------
SELECT
    id,
    word,
    word_vi,
    category,
    example_sentence,
    example_vi,
    position,
    note
FROM signal_word
WHERE lesson_id = ?                     -- :lesson_id
ORDER BY order_index;

-- ---------------------------------------------------------------------------
-- B5. Lấy tips cho 1 lesson
-- Dùng khi: Hiển thị phần "Mẹo ghi nhớ"
-- Index sử dụng: idx_tip_lesson
-- ---------------------------------------------------------------------------
SELECT
    id,
    title,
    title_vi,
    content,
    content_vi,
    category,
    importance,
    icon
FROM tip
WHERE lesson_id = ?                     -- :lesson_id
ORDER BY order_index;

-- ---------------------------------------------------------------------------
-- B6. Lấy comparisons cho 1 lesson (dùng View đã có)
-- Dùng khi: Hiển thị phần "So sánh với thì khác"
-- Index sử dụng: idx_comparison_lesson_1, idx_comparison_lesson_2
-- ---------------------------------------------------------------------------
SELECT
    vc.compared_with_id,
    vc.compared_with_name,
    vc.compared_with_name_vi,
    vc.aspect,
    vc.aspect_vi,
    vc.this_lesson_point,
    vc.this_lesson_point_vi,
    vc.other_lesson_point,
    vc.other_lesson_point_vi,
    vc.this_example,
    vc.this_example_vi,
    vc.other_example,
    vc.other_example_vi,
    vc.tip,
    vc.tip_vi
FROM v_lesson_comparisons vc
WHERE vc.lesson_id = ?                  -- :lesson_id
ORDER BY vc.order_index;

-- ---------------------------------------------------------------------------
-- B7. Lấy TOÀN BỘ nội dung lesson trong 1 lần (Batch Query)
-- Dùng khi: Muốn load tất cả nội dung 1 lần (giảm round-trip)
-- Lưu ý: Nên dùng ở application layer thay vì stored procedure
--         để dễ debug, test, và maintain
-- ---------------------------------------------------------------------------
-- Thay vì gọi sp_get_lesson_full, application layer sẽ gọi:
-- 1. B1 (lesson info)
-- 2. B2 (formulas)
-- 3. B3a + B3b (usages + examples)
-- 4. B4 (signal words)
-- 5. B5 (tips)
-- 6. B6 (comparisons)
-- Có thể gọi song song (Promise.all) ở Node.js → nhanh hơn stored procedure


-- ############################################################################
-- C. EXERCISE PAGE (Trang bài tập)
-- ############################################################################

-- ---------------------------------------------------------------------------
-- C1. Lấy exercises cho 1 lesson (KHÔNG kèm đáp án)
-- Dùng khi: Hiển thị danh sách bài tập cho người dùng làm
-- Index sử dụng: idx_exercise_lesson_active
-- Bảo mật: KHÔNG trả về correct_answer, is_correct của options
-- ---------------------------------------------------------------------------
SELECT
    e.id,
    e.type,
    e.difficulty,
    e.question,
    e.question_vi,
    e.content,
    e.content_vi,
    e.word_bank,
    e.hint,
    e.hint_vi,
    e.points,
    e.time_limit
FROM exercise e
WHERE e.lesson_id = ?                   -- :lesson_id
  AND e.is_active = TRUE
ORDER BY e.order_index;

-- ---------------------------------------------------------------------------
-- C2. Lấy options cho multiple_choice exercises (KHÔNG kèm đáp án)
-- Dùng khi: Hiển thị các lựa chọn A/B/C/D
-- Index sử dụng: uq_option_exercise_label (exercise_id là leftmost prefix)
-- Bảo mật: KHÔNG trả về is_correct, explanation
-- ---------------------------------------------------------------------------
SELECT
    eo.id,
    eo.exercise_id,
    eo.label,
    eo.content,
    eo.content_vi
FROM exercise_option eo
WHERE eo.exercise_id IN (               -- :exercise_ids (từ C1)
    SELECT e.id FROM exercise e
    WHERE e.lesson_id = ? AND e.is_active = TRUE
)
ORDER BY eo.exercise_id, eo.order_index;

-- ---------------------------------------------------------------------------
-- C3. Lấy matching pairs (KHÔNG reveal thứ tự đúng)
-- Dùng khi: Hiển thị bài tập nối
-- Index sử dụng: idx_matching_pair_exercise
-- Lưu ý: Application layer nên shuffle right_content trước khi gửi client
-- ---------------------------------------------------------------------------
SELECT
    mp.id,
    mp.exercise_id,
    mp.left_content,
    mp.left_content_vi,
    mp.right_content,
    mp.right_content_vi
FROM matching_pair mp
WHERE mp.exercise_id IN (               -- :exercise_ids (từ C1)
    SELECT e.id FROM exercise e
    WHERE e.lesson_id = ? AND e.is_active = TRUE AND e.type = 'matching'
)
ORDER BY mp.exercise_id, mp.order_index;

-- ---------------------------------------------------------------------------
-- C4. Kiểm tra đáp án (server-side validation)
-- Dùng khi: Người dùng submit câu trả lời
-- Application logic cần:
--   1. Lấy correct_answer / is_correct từ DB
--   2. So sánh với user_answer
--   3. Trả về kết quả + explanation
-- ---------------------------------------------------------------------------

-- C4a. Kiểm tra đáp án cho multiple_choice
SELECT
    eo.id,
    eo.label,
    eo.is_correct,
    eo.explanation,
    eo.explanation_vi
FROM exercise_option eo
WHERE eo.exercise_id = ?                -- :exercise_id
  AND eo.label = ?;                     -- :user_answer (A/B/C/D)

-- C4b. Kiểm tra đáp án cho fill_blank, error_correction, sentence_transform, true_false
SELECT
    e.correct_answer,
    e.explanation,
    e.explanation_vi
FROM exercise e
WHERE e.id = ?;                         -- :exercise_id

-- C4c. Kiểm tra đáp án cho matching (application logic)
SELECT
    mp.id,
    mp.left_content,
    mp.right_content
FROM matching_pair mp
WHERE mp.exercise_id = ?                -- :exercise_id
ORDER BY mp.order_index;
-- So sánh user_pairs với DB pairs ở application layer

-- C4d. Kiểm tra đáp án cho arrange_words (application logic)
SELECT
    e.correct_answer,
    e.word_bank,
    e.explanation,
    e.explanation_vi
FROM exercise e
WHERE e.id = ?;                         -- :exercise_id
-- So sánh user-arranged sentence với correct_answer ở application layer

-- ---------------------------------------------------------------------------
-- C5. Ghi nhận kết quả bài tập (INSERT attempt + UPDATE progress)
-- Dùng khi: Sau khi kiểm tra đáp án, ghi lại kết quả
-- Transaction: CẦN đảm bảo atomicity
-- ---------------------------------------------------------------------------

-- Nên wrap trong transaction ở application layer:
START TRANSACTION;

-- C5a. Tính attempt_number
SELECT COALESCE(MAX(attempt_number), 0) + 1 AS next_attempt
FROM exercise_attempt
WHERE session_id = ?                    -- :session_id
  AND exercise_id = ?;                  -- :exercise_id

-- C5b. Insert attempt record
INSERT INTO exercise_attempt
    (session_id, exercise_id, user_answer, is_correct, time_taken, attempt_number)
VALUES
    (?, ?, ?, ?, ?, ?);                 -- :session_id, :exercise_id, :user_answer, :is_correct, :time_taken, :attempt_number

-- C5c. Upsert progress (INSERT hoặc UPDATE nếu đã tồn tại)
INSERT INTO user_progress
    (session_id, lesson_id, status, exercises_attempted, exercises_correct, total_attempts, total_time_spent)
VALUES
    (?, ?, 'in_progress', 1, IF(? = TRUE, 1, 0), 1, COALESCE(?, 0))
ON DUPLICATE KEY UPDATE
    status = IF(status = 'completed', 'completed', 'in_progress'),
    exercises_attempted = exercises_attempted + 1,
    exercises_correct = exercises_correct + IF(? = TRUE, 1, 0),
    total_attempts = total_attempts + 1,
    total_time_spent = total_time_spent + COALESCE(?, 0);

-- C5d. Cập nhật điểm
UPDATE user_progress
SET current_score = ROUND((exercises_correct / NULLIF(exercises_attempted, 0)) * 100, 2),
    best_score = GREATEST(best_score, ROUND((exercises_correct / NULLIF(exercises_attempted, 0)) * 100, 2))
WHERE session_id = ?                    -- :session_id
  AND lesson_id = ?;                    -- :lesson_id

COMMIT;

-- ---------------------------------------------------------------------------
-- C6. Lấy kết quả chi tiết sau khi hoàn thành tất cả bài tập
-- Dùng khi: Hiển thị trang kết quả / review
-- ---------------------------------------------------------------------------
SELECT
    e.id           AS exercise_id,
    e.type,
    e.question,
    e.question_vi,
    e.content,
    e.correct_answer,
    e.explanation,
    e.explanation_vi,
    ea.user_answer,
    ea.is_correct,
    ea.time_taken,
    ea.attempt_number
FROM exercise e
LEFT JOIN exercise_attempt ea ON ea.exercise_id = e.id
    AND ea.session_id = ?               -- :session_id
    AND ea.attempt_number = (
        SELECT MAX(ea2.attempt_number)
        FROM exercise_attempt ea2
        WHERE ea2.session_id = ea.session_id
          AND ea2.exercise_id = ea.exercise_id
    )
WHERE e.lesson_id = ?                   -- :lesson_id
  AND e.is_active = TRUE
ORDER BY e.order_index;


-- ############################################################################
-- D. USER PROGRESS (Theo dõi tiến trình)
-- ############################################################################

-- ---------------------------------------------------------------------------
-- D1. Lấy progress cho 1 lesson (khi vào lại lesson)
-- Dùng khi: Hiển thị tiến trình đã lưu, nút "Tiếp tục"
-- Index sử dụng: uq_progress_session_lesson (UNIQUE = O(1))
-- ---------------------------------------------------------------------------
SELECT
    up.status,
    up.theory_completed,
    up.theory_time_spent,
    up.exercises_attempted,
    up.exercises_correct,
    up.exercises_total,
    up.current_score,
    up.best_score,
    up.total_time_spent,
    up.last_position,
    up.completed_at
FROM user_progress up
WHERE up.session_id = ?                 -- :session_id
  AND up.lesson_id = ?;                 -- :lesson_id

-- ---------------------------------------------------------------------------
-- D2. Cập nhật trạng thái xem lý thuyết
-- Dùng khi: Người dùng đã scroll/đọc hết phần lý thuyết
-- ---------------------------------------------------------------------------
INSERT INTO user_progress (session_id, lesson_id, theory_completed, last_position)
VALUES (?, ?, TRUE, 'theory')
ON DUPLICATE KEY UPDATE
    theory_completed = TRUE,
    last_position = 'theory',
    theory_time_spent = theory_time_spent + ?;  -- :additional_seconds

-- ---------------------------------------------------------------------------
-- D3. Lấy tổng quan tiến trình cho 1 session (Dashboard)
-- Dùng khi: Trang overview, hiển thị progress bars
-- Index sử dụng: idx_progress_session, idx_lesson_group
-- ---------------------------------------------------------------------------
SELECT
    g.id            AS group_id,
    g.name          AS group_name,
    g.name_vi       AS group_name_vi,
    g.color         AS group_color,
    g.icon          AS group_icon,
    l.id            AS lesson_id,
    l.name          AS lesson_name,
    l.name_vi       AS lesson_name_vi,
    l.slug,
    l.difficulty,
    COALESCE(up.status, 'not_started')  AS status,
    COALESCE(up.theory_completed, FALSE) AS theory_completed,
    COALESCE(up.best_score, 0)          AS best_score,
    COALESCE(up.exercises_attempted, 0) AS exercises_attempted,
    COALESCE(up.exercises_total, 0)     AS exercises_total,
    COALESCE(up.completed_at, NULL)     AS completed_at
FROM lesson l
JOIN tense_group g ON l.group_id = g.id
LEFT JOIN user_progress up ON up.lesson_id = l.id AND up.session_id = ?  -- :session_id
WHERE l.is_published = TRUE
ORDER BY g.order_index, l.order_index;

-- ---------------------------------------------------------------------------
-- D4. Thống kê tổng hợp cho 1 session
-- Dùng khi: Hiển thị header dashboard (tổng điểm, số bài hoàn thành...)
-- ---------------------------------------------------------------------------
SELECT
    COUNT(DISTINCT up.lesson_id)                            AS lessons_started,
    SUM(CASE WHEN up.status = 'completed' THEN 1 ELSE 0 END) AS lessons_completed,
    (SELECT COUNT(*) FROM lesson WHERE is_published = TRUE) AS total_lessons,
    ROUND(AVG(up.best_score), 1)                            AS avg_score,
    SUM(up.total_time_spent)                                AS total_time_seconds
FROM user_progress up
WHERE up.session_id = ?;                -- :session_id

-- ---------------------------------------------------------------------------
-- D5. Reset progress cho 1 lesson
-- Dùng khi: Người dùng muốn làm lại bài
-- Transaction: CẦN đảm bảo atomicity
-- ---------------------------------------------------------------------------
START TRANSACTION;

-- Xóa các attempt
DELETE ea FROM exercise_attempt ea
JOIN exercise e ON ea.exercise_id = e.id
WHERE ea.session_id = ?                 -- :session_id
  AND e.lesson_id = ?;                  -- :lesson_id

-- Reset progress record (giữ lại record, chỉ reset giá trị)
UPDATE user_progress
SET status = 'not_started',
    theory_completed = FALSE,
    theory_time_spent = 0,
    exercises_attempted = 0,
    exercises_correct = 0,
    current_score = 0,
    -- GIỮ LẠI best_score và total_attempts để tham khảo
    last_position = NULL,
    completed_at = NULL
WHERE session_id = ?                    -- :session_id
  AND lesson_id = ?;                    -- :lesson_id

COMMIT;


-- ############################################################################
-- E. BOOKMARKS
-- ############################################################################

-- ---------------------------------------------------------------------------
-- E1. Thêm bookmark
-- ---------------------------------------------------------------------------
INSERT INTO bookmark (session_id, lesson_id, section_type, section_id, note)
VALUES (?, ?, ?, ?, ?)                  -- :session_id, :lesson_id, :section_type, :section_id, :note
ON DUPLICATE KEY UPDATE
    note = VALUES(note);                -- Cập nhật note nếu bookmark đã tồn tại

-- ---------------------------------------------------------------------------
-- E2. Xóa bookmark
-- ---------------------------------------------------------------------------
DELETE FROM bookmark
WHERE session_id = ?                    -- :session_id
  AND lesson_id = ?                     -- :lesson_id
  AND (section_type = ? OR (section_type IS NULL AND ? IS NULL))
  AND (section_id = ? OR (section_id IS NULL AND ? IS NULL));

-- ---------------------------------------------------------------------------
-- E3. Lấy bookmarks cho 1 session
-- Dùng khi: Trang "Đã lưu" / "Favorites"
-- ---------------------------------------------------------------------------
SELECT
    b.id,
    b.lesson_id,
    l.name          AS lesson_name,
    l.name_vi       AS lesson_name_vi,
    l.slug,
    b.section_type,
    b.section_id,
    b.note,
    b.created_at
FROM bookmark b
JOIN lesson l ON b.lesson_id = l.id
WHERE b.session_id = ?                  -- :session_id
ORDER BY b.created_at DESC;

-- ---------------------------------------------------------------------------
-- E4. Kiểm tra 1 mục có được bookmark không (toggle UI)
-- ---------------------------------------------------------------------------
SELECT EXISTS(
    SELECT 1 FROM bookmark
    WHERE session_id = ?                -- :session_id
      AND lesson_id = ?                 -- :lesson_id
      AND section_type <=> ?            -- :section_type (NULL-safe comparison)
      AND section_id <=> ?              -- :section_id
) AS is_bookmarked;


-- ############################################################################
-- F. SEARCH & FILTERING
-- ############################################################################

-- ---------------------------------------------------------------------------
-- F1. Tìm lesson theo keyword (search box)
-- Dùng khi: Người dùng gõ tìm kiếm
-- Lưu ý: LIKE '%keyword%' không dùng được index → fulltext search nếu cần
--         Nhưng với ~20 lessons, scan toàn bộ vẫn nhanh (< 1ms)
-- ---------------------------------------------------------------------------
SELECT
    l.id,
    l.name,
    l.name_vi,
    l.slug,
    l.short_desc,
    l.short_desc_vi,
    l.difficulty,
    g.name          AS group_name,
    g.color         AS group_color
FROM lesson l
JOIN tense_group g ON l.group_id = g.id
WHERE l.is_published = TRUE
  AND (
    l.name LIKE CONCAT('%', ?, '%')         -- :keyword
    OR l.name_vi LIKE CONCAT('%', ?, '%')   -- :keyword
    OR l.short_desc LIKE CONCAT('%', ?, '%')
    OR l.short_desc_vi LIKE CONCAT('%', ?, '%')
  )
ORDER BY g.order_index, l.order_index;

-- ---------------------------------------------------------------------------
-- F2. Lọc exercises theo type và difficulty
-- Dùng khi: Người dùng muốn luyện tập theo loại cụ thể
-- Index sử dụng: idx_exercise_lesson_type_diff
-- ---------------------------------------------------------------------------
SELECT
    e.id,
    e.lesson_id,
    l.name          AS lesson_name,
    l.name_vi       AS lesson_name_vi,
    e.type,
    e.difficulty,
    e.question,
    e.question_vi,
    e.points
FROM exercise e
JOIN lesson l ON e.lesson_id = l.id
WHERE e.is_active = TRUE
  AND (? IS NULL OR e.type = ?)             -- :type (optional filter)
  AND (? IS NULL OR e.difficulty = ?)       -- :difficulty (optional filter)
  AND (? IS NULL OR e.lesson_id = ?)        -- :lesson_id (optional filter)
ORDER BY l.order_index, e.order_index;


-- ############################################################################
-- G. NAVIGATION HELPERS
-- ############################################################################

-- ---------------------------------------------------------------------------
-- G1. Lấy lesson trước và sau (Previous/Next navigation)
-- Dùng khi: Nút "Bài trước" / "Bài tiếp theo"
-- ---------------------------------------------------------------------------

-- Bài tiếp theo (cùng group)
SELECT id, name, name_vi, slug
FROM lesson
WHERE group_id = (SELECT group_id FROM lesson WHERE id = ?)  -- :current_lesson_id
  AND order_index > (SELECT order_index FROM lesson WHERE id = ?)
  AND is_published = TRUE
ORDER BY order_index
LIMIT 1;

-- Bài trước đó (cùng group)
SELECT id, name, name_vi, slug
FROM lesson
WHERE group_id = (SELECT group_id FROM lesson WHERE id = ?)  -- :current_lesson_id
  AND order_index < (SELECT order_index FROM lesson WHERE id = ?)
  AND is_published = TRUE
ORDER BY order_index DESC
LIMIT 1;

-- ---------------------------------------------------------------------------
-- G2. Đếm số exercise cho mỗi lesson (dùng cho lesson cards)
-- Index sử dụng: idx_exercise_lesson_active
-- ---------------------------------------------------------------------------
SELECT
    lesson_id,
    COUNT(*) AS exercise_count
FROM exercise
WHERE is_active = TRUE
GROUP BY lesson_id;


-- ############################################################################
-- KẾT LUẬN VỀ QUERY PATTERNS
-- ############################################################################

-- Các patterns chính:
-- 1. LOOKUP BY ID/SLUG: B1 (slug lookup) → cần UNIQUE index ✓
-- 2. FILTER BY PARENT: B2-B6 (lesson_id) → cần FK index ✓
-- 3. UPSERT: C5c, D2, E1 → ON DUPLICATE KEY UPDATE
-- 4. AGGREGATION: A1, D3, D4 → COUNT, SUM, AVG
-- 5. SUBQUERY IN: C2, C3 → exercise_ids từ lesson
-- 6. FULL TEXT SEARCH: F1 → LIKE (đủ cho ~20 lessons)
-- 7. NAVIGATION: G1 → ORDER BY + LIMIT

-- Indexes trong schema v2.0 (27 total = 15 PK + 6 UNIQUE + 6 regular):
--
-- UNIQUE (đóng vai trò cả constraint lẫn index):
--   uq_tense_group_name          → Constraint
--   uq_lesson_name, uq_lesson_slug → B1: slug lookup (O(1))
--   uq_formula_lesson_type       → B2: covers WHERE lesson_id = ? (leftmost prefix)
--   uq_signal_word_lesson_word   → B4: covers WHERE lesson_id = ? (leftmost prefix)
--   uq_option_exercise_label     → C2: covers WHERE exercise_id IN (...)
--   uq_progress_session_lesson   → D1: direct lookup
--   uq_bookmark                  → E1, E4: existence check + covers WHERE session_id = ?
--   uq_comparison_pair_aspect    → Constraint
--
-- REGULAR indexes (mỗi index phục vụ ít nhất 1 query cụ thể):
--   idx_tense_group_order            → A1: ORDER BY
--   idx_lesson_group                 → A3: filter by group
--   idx_lesson_published             → A2: filter published + ORDER BY order_index
--   idx_lesson_usage_lesson_order    → B3a: filter + sort usages
--   idx_example_usage                → B3b: JOIN examples
--   idx_tip_lesson                   → B5: filter tips
--   idx_comparison_lesson_1/2        → B6: comparison lookup
--   idx_exercise_lesson_type_diff    → C1, F2: THE composite (replaces 5 old indexes)
--   idx_matching_pair_exercise       → C3: filter pairs
--   idx_progress_session             → D3, D4: session aggregation
--   idx_attempt_session_exercise     → C5a, C6: attempt lookup (replaces 4 old indexes)
