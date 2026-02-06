# Phân tích Toàn diện Database Design — Project Relax

> **Bối cảnh dự án:** Ứng dụng học ngữ pháp tiếng Anh cho người Việt, chạy local, session-based (không có hệ thống auth), MySQL 8.0+, React frontend, ~12-20 lessons, ~500 exercises max, ước tính < 100K rows/năm cho bảng lớn nhất.

---

## Hệ thống đánh giá

| Mức độ | Ý nghĩa |
|--------|---------|
| 🔴 BẮT BUỘC | Phải sửa/thêm NGAY trước khi phát triển frontend |
| 🟡 NÊN LÀM | Nên làm trong v1.0, nhưng không blocking |
| 🔵 GHI CHÚ | Ghi nhận cho tương lai, không cần làm ngay |
| ⚪ KHÔNG CẦN | Không phù hợp với quy mô/bản chất dự án |

---

## MỤC 1: Lựa chọn Kiểu dữ liệu (Data Types)

**Đánh giá: 🟡 NÊN LÀM — Có một số điểm cần tối ưu**

### 1.1 Primary Keys: `INT UNSIGNED` (4 bytes, max 4.29 tỷ)

| Bảng | Rows dự kiến max | PK hiện tại | Đề xuất | Lý do |
|------|-------------------|-------------|---------|-------|
| tense_group | ~10 | INT UNSIGNED | **Giữ nguyên** | Overhead chỉ 1 byte/row, không đáng thay đổi |
| lesson | ~50 | INT UNSIGNED | **Giữ nguyên** | FK references từ nhiều bảng, đổi type phức tạp |
| formula | ~150 | INT UNSIGNED | **Giữ nguyên** | Tương tự |
| exercise_attempt | ~100K+ | INT UNSIGNED | **Giữ nguyên** | Bảng lớn nhất, INT đúng lựa chọn |

**Kết luận:** INT UNSIGNED cho tất cả PKs là **chấp nhận được**. Tiết kiệm bằng MEDIUMINT (3 bytes) chỉ tiết kiệm 1 byte/row × ~50 rows = 50 bytes — vô nghĩa. Quan trọng hơn là **tất cả FK phải cùng type với PK** — hiện tại đã đúng ✓.

### 1.2 TIMESTAMP vs DATETIME

| Kiểu | Range | Storage | Timezone |
|------|-------|---------|----------|
| TIMESTAMP | 1970 - **2038** | 4 bytes | Auto-convert UTC |
| DATETIME | 1000 - 9999 | 5 bytes | Lưu nguyên |

**Vấn đề:** TIMESTAMP sẽ gặp **Year 2038 Problem** (overflow vào 19/01/2038). MySQL 8.0.28+ đã hỗ trợ 64-bit timestamp, nhưng chỉ ở level API, storage vẫn là 4 bytes.

**Đề xuất: Giữ TIMESTAMP** cho dự án này vì:
1. Ứng dụng local, dữ liệu không tồn tại 12 năm
2. TIMESTAMP tự động convert UTC — tiện cho future i18n
3. `ON UPDATE CURRENT_TIMESTAMP` chỉ hoạt động với TIMESTAMP
4. Tiết kiệm 1 byte/row

### 1.3 TEXT vs VARCHAR cho các trường content

| Column hiện tại | Kiểu | Max data thực tế | Đề xuất |
|----------------|------|-------------------|---------|
| description, description_vi | TEXT | ~500 chars | **Giữ TEXT** — linh hoạt, không biết trước độ dài |
| question, question_vi | TEXT | ~200 chars | **Giữ TEXT** — có thể có câu hỏi dài |
| explanation, explanation_vi | TEXT | ~500 chars | **Giữ TEXT** — giải thích có thể rất dài |
| content, content_vi | TEXT | ~300 chars | **Giữ TEXT** — OK |

**Lưu ý về InnoDB:** TEXT/BLOB được lưu off-page nếu > 768 bytes (COMPACT format) hoặc > 40 bytes (DYNAMIC format, mặc định MySQL 8.0). Điều này có thể tạo overhead khi đọc nhiều cột TEXT cùng lúc. Tuy nhiên, với quy mô dữ liệu nhỏ, impact không đáng kể.

### 1.4 ENUM values

```sql
-- Hiện tại:
difficulty ENUM('beginner', 'intermediate', 'advanced')  -- ✓ Tốt
type ENUM('multiple_choice', 'fill_blank', ...)          -- ✓ Tốt
```

**ENUM trong MySQL:** Lưu trữ nội bộ là 1-2 bytes (index number), tra cứu bằng giá trị string. Phù hợp cho tập giá trị nhỏ, cố định. **Nhược điểm:** Thêm giá trị mới cần `ALTER TABLE` (MySQL 8.0 hỗ trợ instant ADD nhưng không hỗ trợ instant ALTER ENUM).

**Đề xuất: Giữ nguyên ENUM.** Tập giá trị exercise.type có thể mở rộng (thêm loại bài tập mới), nhưng ALTER TABLE trên bảng ~500 rows rất nhanh.

### 1.5 session_id: VARCHAR(64)

Hiện tại dùng `VARCHAR(64)` cho UUID v4 (format: `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` = 36 chars).

**Phương án thay thế:**
| Phương án | Storage | Performance |
|-----------|---------|-------------|
| VARCHAR(64) (hiện tại) | 37-65 bytes | String comparison |
| CHAR(36) | 36 bytes | Faster (fixed-width) |
| BINARY(16) | 16 bytes | Fastest (binary comparison) |

**Đề xuất: Giữ VARCHAR(64).**
- BINARY(16) tiết kiệm nhất nhưng khó debug (hex values)
- CHAR(36) tốt hơn nhưng cần đảm bảo client luôn gửi đúng format
- VARCHAR(64) linh hoạt nhất, performance loss không đáng kể với < 100K rows

### 1.6 JSON column (word_bank)

```sql
word_bank JSON NULL   -- Cho bài arrange_words
```

**Đánh giá:** Đúng use-case. JSON phù hợp vì:
- Dữ liệu có cấu trúc đơn giản (mảng string)
- Không cần query/filter bên trong JSON
- Không cần index trên JSON values
- Thay thế bằng normalized table sẽ over-engineering

### Tổng kết Mục 1

> **Không cần thay đổi gì.** Data types hiện tại đã hợp lý cho quy mô dự án. Các tối ưu vi mô (MEDIUMINT, CHAR, BINARY) không đáng để tăng complexity.

---

## MỤC 2: Chiến lược Đánh Index (Indexing Strategy)

**Đánh giá: 🔴 BẮT BUỘC — Cần XÓA index thừa, giữ index cần thiết**

### 2.1 Phân tích chi tiết

Dựa trên **APPLICATION_QUERIES.sql**, tôi đã map từng query với index cần sử dụng.

#### Indexes NÊN GIỮ (19 indexes thiết yếu)

| Index | Bảng | Dùng bởi Query | Lý do |
|-------|------|-----------------|-------|
| PK (id) | Tất cả 14 bảng | Mọi nơi | Bắt buộc |
| uq_tense_group_name | tense_group | Constraint | Uniqueness |
| idx_tense_group_order | tense_group | A1 | ORDER BY |
| uq_lesson_name | lesson | Constraint | Uniqueness |
| uq_lesson_slug | lesson | B1 | URL routing, O(1) |
| idx_lesson_group | lesson | A3 | Filter by group |
| idx_lesson_published | lesson | A2 | Filter published + order |
| uq_formula_lesson_type | formula | Constraint + B2 | Uniqueness + covers lookup |
| idx_usage_lesson_order | usage | B3a | Covers idx_usage_lesson |
| idx_example_usage | example | B3b | Join với usage |
| uq_signal_word_lesson_word | signal_word | Constraint | Uniqueness |
| idx_signal_word_lesson | signal_word | B4 | Filter by lesson |
| idx_tip_lesson | tip | B5 | Filter by lesson |
| idx_comparison_lesson_1 | lesson_comparison | B6 | Left side comparison |
| idx_comparison_lesson_2 | lesson_comparison | B6 | Right side comparison |
| idx_exercise_lesson_type_diff | exercise | C1, F2 | Composite, covers most queries |
| idx_option_exercise | exercise_option | C2 | Filter options by exercise |
| idx_matching_pair_exercise | matching_pair | C3 | Filter pairs by exercise |
| uq_progress_session_lesson | user_progress | D1, C5c | Direct lookup + upsert |
| idx_progress_session | user_progress | D3, D4 | Session-level aggregation |
| idx_attempt_session_exercise | exercise_attempt | C5a, C6 | Attempt lookup |
| uq_bookmark | bookmark | E1, E4 | Uniqueness + existence check |
| idx_bookmark_session | bookmark | E3 | List bookmarks |

#### Indexes NÊN XÓA (14 indexes thừa)

| Index | Bảng | Lý do xóa |
|-------|------|-----------|
| idx_formula_lesson | formula | **Covered** bởi uq_formula_lesson_type (lesson_id là prefix) |
| idx_formula_type | formula | **Low cardinality** (3 values), không query riêng |
| idx_usage_lesson | usage | **Covered** bởi idx_usage_lesson_order |
| idx_signal_word_category | signal_word | **Low cardinality** (5 values), luôn kèm lesson_id |
| idx_tip_category | tip | **Low cardinality** (6 values), không filter riêng |
| idx_tip_importance | tip | **Low cardinality** (3 values), không filter riêng |
| idx_exercise_lesson | exercise | **Covered** bởi idx_exercise_lesson_type_diff |
| idx_exercise_type | exercise | **Low cardinality** (7 values), luôn kèm lesson_id |
| idx_exercise_difficulty | exercise | **Low cardinality** (3 values), luôn kèm lesson_id |
| idx_exercise_active | exercise | **Boolean** (2 values), luôn kèm lesson_id |
| idx_exercise_lesson_active | exercise | **Covered** bởi idx_exercise_lesson_type_diff |
| idx_progress_status | user_progress | **Low cardinality** (3 values) |
| idx_progress_lesson | user_progress | Luôn query kèm session_id |
| idx_progress_last_access | user_progress | Không có query nào filter riêng |
| idx_attempt_session | exercise_attempt | **Covered** bởi idx_attempt_session_exercise |
| idx_attempt_exercise | exercise_attempt | **Covered** bởi idx_attempt_session_exercise (nếu query kèm session) |
| idx_attempt_created | exercise_attempt | Không có analytics query |
| idx_attempt_date_session | exercise_attempt | Không có analytics query |
| idx_comparison_both | lesson_comparison | **Trùng** với idx_comparison_lesson_1 (lesson_id_1 là prefix) |
| idx_lesson_difficulty | lesson | **Low cardinality** (3 values), không filter riêng |
| idx_bookmark_lesson | bookmark | Luôn query kèm session_id |

### 2.2 Giải thích "Covering Index"

```
idx_exercise_lesson_type_diff ON exercise(lesson_id, type, difficulty)
```
Index composite này tự động "cover" mọi query filter bằng:
- `lesson_id` (leftmost prefix)
- `lesson_id + type`
- `lesson_id + type + difficulty`
- `lesson_id + is_active` (MySQL có thể filter is_active sau khi dùng lesson_id prefix)

→ Không cần các index đơn: idx_exercise_lesson, idx_exercise_type, idx_exercise_difficulty

### 2.3 Tác động của việc xóa index thừa

| Metric | Trước | Sau |
|--------|-------|-----|
| Tổng indexes | 46 | ~28 |
| Write overhead giảm | - | ~39% |
| Storage tiết kiệm | - | Không đáng kể (data nhỏ) |
| Read performance | Không thay đổi | Không thay đổi |

> **Giá trị chính:** Giảm complexity, tránh MySQL optimizer chọn sai index (hiếm nhưng có thể xảy ra khi có quá nhiều index ứng viên).

---

## MỤC 3: Phi chuẩn hóa (Denormalization)

**Đánh giá: ⚪ KHÔNG CẦN — Schema 3NF hiện tại đã phù hợp**

### 3.1 Phân tích

Phi chuẩn hóa có ý nghĩa khi:
- ❌ Có hàng triệu rows → Dự án có tối đa ~1000 rows content
- ❌ JOIN chậm → JOIN trên < 1000 rows luôn < 1ms
- ❌ Aggregation phức tạp → v_lesson_summary có correlated subqueries nhưng trên ~20 lessons = không vấn đề

### 3.2 Nơi duy nhất CÓ THỂ cần denormalize trong tương lai

```
v_lesson_summary: 5 correlated subqueries per lesson
```

Nếu lessons tăng lên > 100 VÀ trang chủ load chậm, có thể thêm:
```sql
ALTER TABLE lesson ADD COLUMN cached_exercise_count SMALLINT DEFAULT 0;
```

Nhưng **KHÔNG LÀM BÂY GIỜ** — premature optimization.

### 3.3 JSON word_bank — đây đã là denormalization

Cột `word_bank JSON` trong bảng `exercise` là một dạng denormalization (thay vì tạo bảng `exercise_word` riêng). Đây là **quyết định đúng** vì:
- Dữ liệu chỉ đọc (admin tạo, student không sửa)
- Không cần query/filter bên trong mảng
- Mảng nhỏ (5-15 từ)

---

## MỤC 4: Bảo mật & Phân quyền

**Đánh giá: 🟡 NÊN LÀM — Cần bảo vệ đáp án ở application layer**

### 4.1 Tình hình hiện tại

- Không có login/logout/account → không có user-level security
- `session_id` là cách duy nhất nhận diện người dùng
- Không có dữ liệu nhạy cảm (không có PII — Personally Identifiable Information)

### 4.2 Các vấn đề bảo mật CẦN XỬ LÝ

#### A. Bảo vệ đáp án (Application Layer — QUAN TRỌNG NHẤT)

**Vấn đề:** Nếu API trả về `correct_answer`, `is_correct` của options, user có thể inspect Network tab → thấy đáp án.

**Giải pháp** (ở backend/API, không phải DB):
```
KHÔNG BAO GIỜ trả về trong response:
- exercise.correct_answer
- exercise_option.is_correct
- exercise_option.explanation (trước khi submit)
- matching_pair order (= đáp án)
```

→ Đã thể hiện trong APPLICATION_QUERIES.sql (C1, C2, C3: không SELECT correct_answer, is_correct)

#### B. SQL Injection Prevention

**Vấn đề:** Nếu backend dùng string concatenation thay vì parameterized queries.

**Giải pháp:** Dùng parameterized queries / prepared statements trong Node.js:
```javascript
// ✓ Đúng
db.query('SELECT * FROM lesson WHERE slug = ?', [slug]);

// ✗ Sai
db.query(`SELECT * FROM lesson WHERE slug = '${slug}'`);
```

→ Đây là trách nhiệm của application layer, không cần thay đổi schema.

#### C. Session ID Security

**Vấn đề:** session_id được generate ở client (browser). Ai biết session_id có thể xem progress của người khác.

**Đánh giá rủi ro:**
- Dữ liệu ảnh hưởng: chỉ learning progress (không nhạy cảm)
- Tấn công vector: brute force UUID v4 (2^122 combinations) → gần như bất khả thi
- Local app: không expose ra internet

**Kết luận:** Chấp nhận được cho local app. Nếu muốn tăng bảo mật:
- Dùng `crypto.randomUUID()` (Web Crypto API) thay vì thư viện uuid
- Lưu session_id vào localStorage (đã là practice phổ biến)

#### D. is_premium column

**Vấn đề:** `lesson.is_premium = TRUE` nhưng không có auth → không thể enforce ở server.

**Đề xuất:** Xóa cột `is_premium` hoặc comment rõ là "reserved for future use". Client-side check `is_premium` không có giá trị bảo mật thực tế.

### 4.3 MySQL User Permissions (không cần cho local app)

Trên production, nên tạo DB user riêng cho app:
```sql
-- KHÔNG CẦN LÀM BÂY GIỜ, ghi chú cho tương lai
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT, INSERT, UPDATE, DELETE ON grammar_learning.* TO 'app_user'@'localhost';
-- KHÔNG grant DROP, ALTER, CREATE → app không thể xóa/sửa schema
```

---

## MỤC 5: Tính Toàn vẹn Dữ liệu (Data Integrity)

**Đánh giá: 🟡 NÊN LÀM — Cần quyết định Soft Delete cho content tables**

### 5.1 Soft Delete vs Hard Delete

| Loại dữ liệu | Đề xuất | Lý do |
|---------------|---------|-------|
| **Content** (lesson, exercise, ...) | **Soft Delete** | Admin có thể vô tình xóa → cần khôi phục |
| **User Progress** (user_progress, exercise_attempt) | **Hard Delete** | Session-based, ephemeral, không cần giữ lại |
| **Bookmarks** | **Hard Delete** | User chủ động xóa = xóa thật |

#### Implementation cho Soft Delete (content tables)

```sql
-- Chỉ cần thêm cho 2 bảng chính: lesson và exercise
-- Các bảng con sẽ theo parent (CASCADE sẽ không trigger khi soft delete)

ALTER TABLE lesson ADD COLUMN deleted_at TIMESTAMP NULL DEFAULT NULL;
ALTER TABLE exercise ADD COLUMN deleted_at TIMESTAMP NULL DEFAULT NULL;
```

**Lưu ý quan trọng:** Khi dùng soft delete:
- Tất cả query WHERE phải thêm `AND deleted_at IS NULL`
- Views phải filter `WHERE deleted_at IS NULL`
- Hoặc tạo DEFAULT scope ở ORM (Prisma, Sequelize đều hỗ trợ)

**Đề xuất:** CHƯA thêm soft delete vào v1.0. Lý do:
1. Chưa có admin panel để quản lý content
2. Content được seed từ SQL file → có thể chạy lại seed
3. Thêm soft delete sau rất dễ (chỉ ALTER TABLE + update queries)

### 5.2 Audit Logs

| Câu hỏi | Trả lời |
|----------|---------|
| Ai thay đổi dữ liệu? | Chỉ có 1 admin (developer) |
| Khi nào cần trace? | Không — content thay đổi qua SQL files (version controlled) |
| User data có sensitive? | Không — chỉ learning progress |

**Kết luận: KHÔNG CẦN audit log cho v1.0.**

Nếu tương lai cần (khi có admin panel):
```sql
CREATE TABLE audit_log (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    table_name  VARCHAR(50) NOT NULL,
    record_id   INT UNSIGNED NOT NULL,
    action      ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    old_values  JSON NULL,
    new_values  JSON NULL,
    changed_by  VARCHAR(100) NULL,
    changed_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_audit_table_record (table_name, record_id)
);
```

### 5.3 Referential Integrity (đã tốt ✓)

- Foreign Keys với ON DELETE CASCADE → child records tự xóa theo parent ✓
- ON DELETE RESTRICT cho tense_group → không xóa được group khi còn lessons ✓
- CHECK constraints cho score ranges, exercise points ✓
- UNIQUE constraints cho slug, session+lesson ✓

---

## MỤC 6: Phân vùng dữ liệu (Partitioning & Sharding)

**Đánh giá: ⚪ KHÔNG CẦN**

### 6.1 Khi nào cần Partitioning?

| Điều kiện | Dự án này |
|-----------|-----------|
| Bảng > 10 triệu rows | Max ~100K rows/năm |
| Query scan nhiều data | Max scan ~500 rows |
| Cần xóa data cũ nhanh | Không yêu cầu |
| Range queries trên date | Không có use-case |

### 6.2 Khi nào cần Sharding?

| Điều kiện | Dự án này |
|-----------|-----------|
| Single server quá tải | Chạy local, 1 user |
| Throughput > 10K writes/s | Max ~10 writes/phút |
| Data > 100GB | Max ~10MB |

**Kết luận:** Hoàn toàn không cần. Nếu tương lai scale lên SaaS với hàng triệu users, có thể partition `exercise_attempt` theo `RANGE(YEAR(created_at))`.

---

## MỤC 7: Backup và Phục hồi (Disaster Recovery)

**Đánh giá: 🟡 NÊN LÀM — Cần một lệnh backup đơn giản**

### 7.1 Phương án phù hợp

Cho ứng dụng local, chỉ cần:

```bash
# Full backup - chạy khi muốn backup
mysqldump -u root grammar_learning > backup_$(date +%Y%m%d_%H%M%S).sql

# Restore
mysql -u root grammar_learning < backup_20260207_120000.sql
```

### 7.2 Backup Strategy cho dự án này

| Loại | Tần suất | Phương pháp |
|------|----------|-------------|
| Schema backup | Mỗi khi thay đổi schema | Git (đã có schema.sql) ✓ |
| Seed data backup | Mỗi khi thêm content | Git (đã có seed_data.sql) ✓ |
| User data backup | Manual / khi cần | mysqldump |

### 7.3 Khôi phục

```
Thời gian khôi phục (RTO - Recovery Time Objective):
- Chạy schema.sql: < 1 giây
- Chạy schema_fixes.sql: < 1 giây
- Chạy seed_data.sql: < 1 giây
- Tổng: < 5 giây

→ User progress sẽ mất (session-based, ephemeral) → CHẤP NHẬN ĐƯỢC
```

**Không cần:** Incremental backup, Point-in-Time Recovery, Automated backup schedule.

---

## MỤC 8: Database Migration & Version Control

**Đánh giá: 🟡 NÊN LÀM — Cần hệ thống migration cơ bản**

### 8.1 Tình hình hiện tại

```
database/
├── schema.sql           ← Schema version 1.0 (chạy lần đầu)
├── schema_fixes.sql     ← Patch (chạy sau schema.sql)
├── seed_data.sql        ← Data mẫu
```

**Vấn đề:**
- `schema_fixes.sql` là file "vá" → không rõ ràng version nào
- Không có cách biết DB đang ở version nào
- Nếu cần thêm cột/bảng mới → tạo file gì? chạy theo thứ tự nào?

### 8.2 Đề xuất: Migration đơn giản (không cần tool phức tạp)

```
database/
├── migrations/
│   ├── 001_initial_schema.sql      ← Gộp từ schema.sql + schema_fixes.sql
│   ├── 002_add_soft_delete.sql     ← Ví dụ: thay đổi tương lai
│   └── 003_add_fulltext_search.sql
├── seed_data.sql
├── schema_version.sql               ← Bảng theo dõi version
```

```sql
-- schema_version.sql
CREATE TABLE IF NOT EXISTS schema_version (
    version     INT UNSIGNED    NOT NULL,
    description VARCHAR(255)    NOT NULL,
    applied_at  TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (version)
);
```

Mỗi migration file bắt đầu bằng:
```sql
-- Migration 002: Add soft delete
-- Idempotent: Có thể chạy lại an toàn

INSERT IGNORE INTO schema_version (version, description) VALUES (2, 'Add soft delete');

-- Chỉ thực hiện nếu chưa có cột
SET @col_exists = (SELECT COUNT(*) FROM information_schema.columns
    WHERE table_schema = 'grammar_learning' AND table_name = 'lesson' AND column_name = 'deleted_at');
SET @sql = IF(@col_exists = 0, 'ALTER TABLE lesson ADD COLUMN deleted_at TIMESTAMP NULL', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
```

### 8.3 Khi nào dùng Migration Tool?

| Tool | Khi nào dùng |
|------|-------------|
| **Manual SQL files** (đề xuất) | Dự án nhỏ, 1 developer |
| **Knex migrations** | Khi có backend Node.js với Knex query builder |
| **Prisma migrate** | Khi dùng Prisma ORM |
| **Flyway / Liquibase** | Enterprise projects, multi-developer |

**Đề xuất cho v1.0:** Manual SQL files với naming convention `NNN_description.sql`. Chuyển sang migration tool khi setup backend.

---

## MỤC 9: Transaction Management (Quản lý Giao dịch)

**Đánh giá: 🔴 BẮT BUỘC — Stored procedure hiện tại thiếu explicit transaction**

### 9.1 Vấn đề hiện tại

```sql
-- sp_update_exercise_progress: 4 operations, KHÔNG có explicit transaction
-- Nếu crash giữa chừng:
-- 1. SELECT max attempt_number ✓
-- 2. INSERT attempt ✓
-- 3. INSERT/UPDATE progress ← CRASH → progress không cập nhật, data inconsistent
-- 4. UPDATE score ← KHÔNG chạy
```

**Mặc dù** InnoDB auto-commit từng statement, nhưng 4 statements liên quan nhau cần atomic.

### 9.2 Giải pháp

**Phương án A (Đề xuất): Transaction ở Application Layer**

```javascript
const connection = await pool.getConnection();
try {
    await connection.beginTransaction();

    // 1. Get attempt number
    // 2. Insert attempt
    // 3. Upsert progress
    // 4. Update score

    await connection.commit();
} catch (error) {
    await connection.rollback();
    throw error;
} finally {
    connection.release();
}
```

**Phương án B: Sửa Stored Procedure (nếu giữ SP)**

```sql
CREATE PROCEDURE sp_update_exercise_progress(...)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    -- ... existing logic ...
    COMMIT;
END
```

**Đề xuất: Phương án A.** Logic nên nằm ở application layer vì:
1. Dễ debug (console.log vs MySQL error log)
2. Dễ test (unit test với mock DB vs integration test)
3. Dễ maintain (code editor vs SQL client)
4. Dễ error handling (try/catch vs SQL exception handlers)

### 9.3 ACID Properties

| Property | Status | Notes |
|----------|--------|-------|
| Atomicity | ⚠️ Cần fix | Thêm explicit transaction |
| Consistency | ✓ | CHECK constraints, FK constraints |
| Isolation | ✓ | MySQL default = REPEATABLE READ (phù hợp) |
| Durability | ✓ | InnoDB flush to disk on commit |

### 9.4 Isolation Level

MySQL default: **REPEATABLE READ** — phù hợp cho dự án này.
- Không cần Serializable (quá chậm, single-user app)
- Không nên dùng Read Uncommitted (dirty reads)
- Read Committed cũng OK nhưng default đã tốt

---

## MỤC 10: Concurrency Control (Kiểm soát truy cập đồng thời)

**Đánh giá: ⚪ KHÔNG CẦN — Single-user local app**

### 10.1 Tại sao không cần?

- Ứng dụng chạy local, 1 browser tab = 1 user
- Không có scenario 2 người cùng sửa 1 record
- `ON DUPLICATE KEY UPDATE` trong sp_update_exercise_progress đã handle upsert race condition

### 10.2 Nếu tương lai scale lên multi-user

Thêm Optimistic Locking cho content tables:
```sql
ALTER TABLE lesson ADD COLUMN version INT UNSIGNED DEFAULT 1;

-- Update with version check:
UPDATE lesson SET name = 'new name', version = version + 1
WHERE id = 1 AND version = 5;
-- Nếu affected_rows = 0 → conflict → reload and retry
```

**Nhưng KHÔNG LÀM BÂY GIỜ.**

---

## MỤC 11: Naming Convention (Quy tắc đặt tên)

**Đánh giá: ✅ ĐÃ TỐT — Chỉ có 2 điểm nhỏ cần lưu ý**

### 11.1 Đánh giá hiện tại

| Rule | Status | Ví dụ |
|------|--------|-------|
| Table names: snake_case, singular | ✓ | `lesson`, `tense_group`, `user_progress` |
| Column names: snake_case | ✓ | `lesson_id`, `order_index`, `created_at` |
| PK naming: `id` | ✓ | Tất cả bảng |
| FK naming: `fk_child_parent` | ✓ | `fk_formula_lesson` |
| Index naming: `idx_table_column` | ✓ | `idx_lesson_group` |
| Unique naming: `uq_table_column` | ✓ | `uq_lesson_slug` |
| Check naming: `chk_table_rule` | ✓ | `chk_exercise_points` |
| View naming: `v_name` | ✓ | `v_lesson_summary` |
| SP naming: `sp_action_noun` | ✓ | `sp_get_lesson_full` |
| Function naming: `fn_action` | ✓ | `fn_lesson_is_complete` |
| Trigger naming: `tr_table_event` | ✓ | `tr_progress_set_total` |

### 11.2 Điểm lưu ý

1. **`usage` là MySQL reserved word** — phải dùng backtick `` `usage` `` mọi nơi. Có thể đổi tên thành `lesson_usage` hoặc `tense_usage` để tránh.

2. **Boolean columns:** Đang dùng `is_published`, `is_active`, `is_correct`, `is_common` — nhất quán ✓. Nhưng `theory_completed` không dùng prefix `is_` → nên là `is_theory_completed` cho nhất quán? Hoặc giữ nguyên vì `theory_completed` đọc tự nhiên hơn.

**Đề xuất:** Chỉ cần đổi `usage` → `lesson_usage` nếu muốn tránh reserved word issues. Tuy nhiên, không bắt buộc vì backtick đã xử lý.

---

## MỤC 12: Lưu trữ dữ liệu lớn (LOBs)

**Đánh giá: ✅ ĐÃ TỐT**

### 12.1 Đánh giá

| Data type | Cách lưu hiện tại | Đánh giá |
|-----------|-------------------|----------|
| Audio files | `audio_url VARCHAR(255)` | ✓ Lưu URL, không lưu binary |
| Icons | `icon VARCHAR(50)` | ✓ Lưu tên MUI icon, không lưu SVG |
| Images | Không có | Nếu cần → lưu URL |

**Không có BLOB/MEDIUMBLOB/LONGBLOB** trong schema — đây là quyết định đúng.

### 12.2 Nếu tương lai cần audio/image

```
Chiến lược:
1. Lưu file trong thư mục public/assets/ (local)
2. Hoặc upload lên CDN/S3 (khi deploy)
3. DB chỉ lưu đường dẫn (URL string)
```

---

## MỤC 13: Data Retention & Archiving

**Đánh giá: 🔵 GHI CHÚ — Cần session cleanup trong tương lai**

### 13.1 Phân tích data lifecycle

| Data | Lifecycle | Retention |
|------|-----------|-----------|
| Content (lessons, exercises) | Permanent | Giữ mãi |
| User Progress | Session-based | Hết session = có thể xóa |
| Exercise Attempts | Session-based | Hết session = có thể xóa |
| Bookmarks | Session-based | Hết session = có thể xóa |

### 13.2 Session Cleanup

`session_id` lưu trong localStorage → tồn tại cho đến khi user clear browser data. Nhưng DB sẽ tích lũy sessions cũ không ai dùng.

**Giải pháp (khi cần):**
```sql
-- Xóa sessions không hoạt động > 90 ngày
DELETE FROM user_progress
WHERE last_access < DATE_SUB(NOW(), INTERVAL 90 DAY);

DELETE FROM exercise_attempt
WHERE session_id NOT IN (SELECT DISTINCT session_id FROM user_progress);

DELETE FROM bookmark
WHERE session_id NOT IN (SELECT DISTINCT session_id FROM user_progress);
```

**Khi nào cần:** Khi exercise_attempt > 100K rows (ước tính > 1 năm sử dụng).

### 13.3 TTL (Time To Live)

Không cần cho dự án này:
- Không có OTP, temporary tokens
- Session không hết hạn (localStorage-based)
- Content không hết hạn

---

## MỤC 14: Views và Stored Procedures/Functions

**Đánh giá: 🔴 BẮT BUỘC — Cần quyết định rõ: logic ở DB hay Application?**

### 14.1 Phân tích hiện tại

| Object | Tên | Mục đích | Đề xuất |
|--------|-----|----------|---------|
| View | v_lesson_summary | Lesson list + counts | 🟡 **GIỮ** — đơn giản hóa query |
| View | v_exercise_summary | Exercise + option count | ⚪ **XÓA** — không có query nào dùng |
| View | v_user_progress_overview | Session stats | ⚪ **XÓA** — dùng query D4 thay thế |
| View | v_lesson_comparisons | Bidirectional comparison | 🟡 **GIỮ** — giải quyết M:N phức tạp |
| View | v_database_stats | Admin stats | 🔵 **GIỮ** — hữu ích cho debug |
| SP | sp_get_lesson_full | Get all lesson data | 🔴 **XÓA** — dùng parallel queries ở app |
| SP | sp_update_exercise_progress | Submit exercise | 🔴 **XÓA** — dùng transaction ở app |
| SP | sp_get_session_progress | Session progress | ⚪ **XÓA** — dùng query D3 |
| SP | sp_get_lesson_exercises | Exercises with options | ⚪ **XÓA** — dùng query C1+C2 |
| SP | sp_reset_lesson_progress | Reset progress | 🟡 **XÓA** — dùng transaction ở app |
| SP | sp_get_lesson_comparisons | Get comparisons | ⚪ **XÓA** — dùng query B6 |
| Function | fn_lesson_is_complete | Check minimum content | 🔵 **GIỮ** — validation hữu ích |
| Function | fn_calc_completion_percent | Calc percentage | ⚪ **XÓA** — tính ở frontend |
| Trigger | tr_progress_set_total | Set exercises_total | 🟡 **GIỮ** — auto-set count |
| Trigger | tr_progress_check_completion | Auto-complete | ⚠️ **CẦN XEM LẠI** — xem 14.2 |

### 14.2 Vấn đề với tr_progress_check_completion

```sql
-- Trigger kiểm tra: exercises_attempted >= exercises_total AND theory_completed
-- → tự động set status = 'completed'
```

**Vấn đề:** `exercises_total` được set khi INSERT (bởi tr_progress_set_total). Nếu admin thêm exercise mới AFTER user đã bắt đầu → `exercises_total` không cập nhật → user có thể "complete" sớm.

**Giải pháp:** Tính `exercises_total` dynamically thay vì cache:
```sql
-- Thay vì dùng cached exercises_total, query trực tiếp:
SELECT COUNT(*) FROM exercise WHERE lesson_id = ? AND is_active = TRUE;
```

→ Bỏ `exercises_total` column, bỏ trigger `tr_progress_set_total`, check completion ở application layer.

### 14.3 Triết lý: Logic ở đâu?

| Ở Database (SP/Trigger/Function) | Ở Application (Node.js) |
|----------------------------------|-------------------------|
| ✓ Đảm bảo consistency dù app nào kết nối | ✓ Dễ debug, test, maintain |
| ✓ Giảm network round-trips | ✓ Version control tốt hơn |
| ✗ Khó debug | ✓ IDE support, linting |
| ✗ Khó test | ✓ Scaling dễ (stateless app) |
| ✗ Vendor lock-in (MySQL syntax) | ✗ Phải tự manage transactions |

**Quyết định cho dự án này: LOGIC Ở APPLICATION LAYER.**

Lý do:
1. Chỉ có 1 app kết nối DB (React → Node.js → MySQL)
2. Developer quen JavaScript hơn SQL
3. Debug stored procedure trên MySQL rất khó
4. Migration giữa DB engines (nếu cần) sẽ dễ hơn

**Giữ lại ở DB:** Views (đơn giản hóa queries), Constraints (data integrity), Triggers (chỉ tr_progress_set_total).

---

## MỤC 15: Phân tách Read/Write (Replication)

**Đánh giá: ⚪ KHÔNG CẦN**

- Single-user local app
- Read/Write ratio ≈ 80/20 (đọc lessons vs ghi progress) nhưng throughput quá thấp
- MySQL single instance xử lý dư sức

---

## MỤC 16: Caching

**Đánh giá: 🔵 GHI CHÚ — In-memory cache ở application layer là đủ**

### 16.1 Phân tích Hot/Cold data

| Data | Tần suất truy cập | Thay đổi | Caching |
|------|-------------------|----------|---------|
| Tense groups | Mỗi page load | Gần như không | **HOT** → cache |
| Lesson list | Mỗi page load | Hiếm | **HOT** → cache |
| Lesson content | Khi xem lesson | Hiếm | **WARM** → cache |
| Exercise list | Khi làm bài | Hiếm | **WARM** → cache |
| User progress | Khi xem dashboard | Mỗi lần submit | **COLD** → không cache |

### 16.2 Chiến lược đề xuất

```javascript
// Simple in-memory cache ở Node.js (không cần Redis)
const cache = new Map();
const CACHE_TTL = 30 * 60 * 1000; // 30 phút

function getCached(key, fetcher) {
    const cached = cache.get(key);
    if (cached && Date.now() - cached.timestamp < CACHE_TTL) {
        return cached.data;
    }
    const data = fetcher();
    cache.set(key, { data, timestamp: Date.now() });
    return data;
}
```

**Invalidation:** Content hầu như không thay đổi → TTL-based invalidation đủ.

**Không cần Redis/Memcached** cho dự án local.

---

## MỤC 17: Polyglot Persistence (Đa dạng hóa Database)

**Đánh giá: ⚪ KHÔNG CẦN**

MySQL alone đủ cho mọi nhu cầu:
- Structured data: MySQL ✓
- Full-text search: MySQL FULLTEXT hoặc LIKE (20 lessons) ✓
- JSON data: MySQL JSON type ✓
- Analytics: SQL aggregation ✓

Không cần Elasticsearch, Redis, MongoDB, Neo4j hay bất kỳ database phụ nào.

---

## MỤC 18: Database cho Microservices

**Đánh giá: ⚪ KHÔNG CẦN**

- Dự án là monolith (1 app, 1 DB)
- Không có multiple services
- Saga pattern, CQRS, Event Sourcing đều overkill

---

## MỤC 19: Observability & Monitoring

**Đánh giá: 🔵 GHI CHÚ — Chỉ cần slow query log**

### 19.1 Cho development

```ini
# my.cnf
[mysqld]
slow_query_log = 1
slow_query_log_file = /var/log/mysql/slow.log
long_query_time = 1    # Log queries > 1 giây
```

### 19.2 Monitoring đơn giản

```sql
-- Kiểm tra số connections
SHOW STATUS LIKE 'Threads_connected';

-- Kiểm tra slow queries
SHOW GLOBAL STATUS LIKE 'Slow_queries';

-- Kiểm tra table sizes
SELECT
    table_name,
    table_rows,
    ROUND(data_length / 1024, 2) AS data_kb,
    ROUND(index_length / 1024, 2) AS index_kb
FROM information_schema.tables
WHERE table_schema = 'grammar_learning'
ORDER BY data_length DESC;
```

**Không cần:** Grafana, Prometheus, DataDog, hay bất kỳ monitoring platform nào.

---

## TỔNG KẾT & ACTION ITEMS

### Bảng tổng kết 19 mục

| # | Mục | Đánh giá | Hành động |
|---|-----|----------|-----------|
| 1 | Data Types | ✅ Đã tốt | Không thay đổi |
| 2 | Indexing | 🔴 BẮT BUỘC | Xóa ~18 indexes thừa |
| 3 | Denormalization | ⚪ Không cần | Giữ 3NF |
| 4 | Security | 🟡 Nên làm | Bảo vệ đáp án ở API layer |
| 5 | Data Integrity | 🟡 Nên làm | Chưa thêm soft delete, sẽ thêm khi có admin panel |
| 6 | Partitioning | ⚪ Không cần | N/A |
| 7 | Backup | 🟡 Nên làm | mysqldump script |
| 8 | Migration | 🟡 Nên làm | Migration files + schema_version table |
| 9 | Transactions | 🔴 BẮT BUỘC | Explicit transaction cho exercise submission |
| 10 | Concurrency | ⚪ Không cần | Single-user |
| 11 | Naming | ✅ Đã tốt | Xem xét đổi `usage` → tránh reserved word |
| 12 | LOBs | ✅ Đã tốt | Đã dùng URL thay binary |
| 13 | Retention | 🔵 Ghi chú | Session cleanup khi cần |
| 14 | Views/SP | 🔴 BẮT BUỘC | Xóa hầu hết SP, giữ Views + logic ở app |
| 15 | Replication | ⚪ Không cần | Single instance |
| 16 | Caching | 🔵 Ghi chú | In-memory cache ở app |
| 17 | Polyglot | ⚪ Không cần | MySQL only |
| 18 | Microservices | ⚪ Không cần | Monolith |
| 19 | Observability | 🔵 Ghi chú | Slow query log |

### Danh sách thay đổi cần thực hiện (ưu tiên)

#### Priority 1 — TRƯỚC KHI code backend

1. **Tối ưu indexes** — Xóa 18 indexes thừa (tạo migration script)
2. **Quyết định về Stored Procedures** — Xóa tất cả SP, giữ logic ở application layer
3. **Review triggers** — Giữ `tr_progress_set_total`, xem xét lại `tr_progress_check_completion`

#### Priority 2 — KHI setup backend

4. **Transaction management** — Implement explicit transactions ở Node.js
5. **API security** — Không trả về đáp án trong response (dùng APPLICATION_QUERIES.sql)
6. **Migration system** — Setup migration files + schema_version table

#### Priority 3 — SAU v1.0

7. Soft delete cho content tables (khi có admin panel)
8. Session cleanup (khi data lớn)
9. In-memory caching (nếu cần performance)
10. Backup script automation
