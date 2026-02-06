# Backend Architecture Blueprint — Project Relax

> Tài liệu thiết kế kiến trúc backend TRƯỚC KHI code.
> Mọi quyết định đều dựa trên bối cảnh: local app, session-based, MySQL 8.0, Express.js.

---

## 1. Kiến trúc tổng quan: Layered Architecture

```
Client (React)
    ↓ HTTP request
┌──────────────────────────────────────────────┐
│  Express.js Server                           │
│                                              │
│  ┌─────────┐                                 │
│  │ Routes   │ → Định nghĩa endpoints,       │
│  │          │   validation, gọi controller   │
│  └────┬─────┘                                │
│       ↓                                      │
│  ┌─────────────┐                             │
│  │ Controllers  │ → Nhận req/res,            │
│  │              │   gọi service, trả JSON    │
│  └──────┬───────┘                            │
│         ↓                                    │
│  ┌─────────────┐                             │
│  │ Services     │ → Business logic,          │
│  │              │   orchestrate repos,       │
│  │              │   transaction management   │
│  └──────┬───────┘                            │
│         ↓                                    │
│  ┌──────────────┐                            │
│  │ Repositories  │ → SQL queries (thuần),    │
│  │               │   parameterized queries,  │
│  │               │   data mapping            │
│  └──────┬────────┘                           │
│         ↓                                    │
│  ┌──────────────┐                            │
│  │ DB Pool       │ → mysql2/promise pool,    │
│  │ (Singleton)   │   connection management   │
│  └───────────────┘                           │
└──────────────────────────────────────────────┘
    ↓ SQL query
MySQL 8.0 (grammar_learning)
```

### Nguyên tắc mỗi tầng

| Tầng | ĐƯỢC LÀM | KHÔNG ĐƯỢC LÀM |
|------|-----------|-----------------|
| **Route** | Validate input, gọi controller | Chứa business logic, SQL |
| **Controller** | Parse req, format res, HTTP status | Business logic, SQL, truy cập pool trực tiếp |
| **Service** | Business logic, gọi nhiều repos, quản lý transaction | Biết về req/res, format HTTP response |
| **Repository** | Execute SQL, map data | Business logic, biết về HTTP, format response |
| **DB Pool** | Quản lý connections | Business logic |

### Tại sao tách Controller và Service?

```
❌ KHÔNG tách (Controller chứa cả logic):
controller.submitExercise() {
    // Validate input → check exercise exists → check answer →
    // insert attempt → update progress → calculate score → format response
    // → 50+ lines, untestable
}

✓ CÓ tách:
controller.submitExercise() {
    const result = await exerciseService.submitAnswer(sessionId, exerciseId, answer);
    res.json(result);  // 3 lines, clear responsibility
}

service.submitAnswer() {
    // Business logic: validate, check, calculate — TESTABLE without HTTP
}
```

---

## 2. Database Connection: Pool Pattern + Singleton

### Tại sao Connection Pool?

```
Không có Pool:
Request 1 → createConnection() → query → close  (~20ms overhead)
Request 2 → createConnection() → query → close  (~20ms overhead)
Request 3 → createConnection() → query → close  (~20ms overhead)
= Tổng: 60ms wasted trên connection setup

Có Pool:
App start → createPool(10 connections)
Request 1 → getConnection() → query → release  (~0ms, connection sẵn sàng)
Request 2 → getConnection() → query → release  (~0ms)
Request 3 → getConnection() → query → release  (~0ms)
= Connections được tái sử dụng, 0 overhead
```

### Cấu hình Pool cho dự án này

```javascript
// config/database.js
const poolConfig = {
    host: process.env.DB_HOST || 'localhost',
    port: process.env.DB_PORT || 3306,
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'grammar_learning',

    // Pool settings
    connectionLimit: 10,    // Max connections (10 là đủ cho local app)
    waitForConnections: true, // Queue requests khi hết connection
    queueLimit: 0,          // Unlimited queue (0 = no limit)

    // Timeouts
    connectTimeout: 10000,  // 10s để kết nối

    // MySQL specific
    charset: 'utf8mb4',
    timezone: '+00:00',     // UTC

    // Performance
    namedPlaceholders: false, // Dùng ? placeholders (đơn giản hơn)
    decimalNumbers: true,     // DECIMAL trả về Number thay vì String
};
```

### Singleton Pattern cho Pool

```javascript
// config/database.js
let pool = null;

function getPool() {
    if (!pool) {
        pool = mysql.createPool(poolConfig);
    }
    return pool;
}
```

**Tại sao Singleton?** Chỉ cần 1 pool duy nhất cho toàn app.
Nếu tạo nhiều pool → lãng phí connections, có thể vượt quá max_connections của MySQL.

---

## 3. Transaction Pattern: Transaction Helper

### Vấn đề

Exercise submission (C5) và reset progress (D5) cần transaction.
Nếu viết transaction thủ công mỗi lần:

```javascript
// Lặp lại pattern này ở MỌI NƠI cần transaction
const conn = await pool.getConnection();
try {
    await conn.beginTransaction();
    // ... business logic ...
    await conn.commit();
} catch (err) {
    await conn.rollback();
    throw err;
} finally {
    conn.release();  // PHẢI release, nếu quên → pool cạn kiệt
}
```

### Giải pháp: Transaction Helper (Higher-Order Function)

```javascript
// utils/transaction.js
async function withTransaction(pool, callback) {
    const conn = await pool.getConnection();
    try {
        await conn.beginTransaction();
        const result = await callback(conn);  // conn được truyền vào
        await conn.commit();
        return result;
    } catch (err) {
        await conn.rollback();
        throw err;
    } finally {
        conn.release();
    }
}

// Sử dụng — clean, không lo quên release/rollback:
const result = await withTransaction(pool, async (conn) => {
    await conn.query('INSERT INTO exercise_attempt ...', [...]);
    await conn.query('INSERT INTO user_progress ... ON DUPLICATE KEY UPDATE ...', [...]);
    return { success: true };
});
```

---

## 4. Repository Pattern: Chi tiết

### Repository ≠ ORM

Repository trong dự án này KHÔNG phải ORM phức tạp. Nó chỉ là:
- **1 class** cho mỗi domain (lesson, exercise, progress)
- Chứa **raw SQL** từ APPLICATION_QUERIES.sql
- Nhận **pool** (hoặc connection) qua constructor (Dependency Injection)
- Trả về **plain objects** (không phải model instances)

### Danh sách Repositories cần tạo

| Repository | Domain | Queries chính |
|-----------|--------|---------------|
| `TenseGroupRepository` | tense_group | A1 |
| `LessonRepository` | lesson, formula, lesson_usage, example, signal_word, tip, comparison | A2, A3, B1-B6, G1 |
| `ExerciseRepository` | exercise, exercise_option, matching_pair | C1, C2, C3, C4, F2 |
| `ProgressRepository` | user_progress, exercise_attempt | D1-D5, C5, C6 |
| `BookmarkRepository` | bookmark | E1-E4 |

### Tại sao LessonRepository chứa nhiều bảng?

Theo nguyên tắc **Aggregate Root** (DDD): `lesson` là root, các bảng con (formula, usage, tip...) luôn được truy cập thông qua lesson.
Không bao giờ query `formula` mà không biết `lesson_id`.

### Repository nhận connection cho transaction

```javascript
class ProgressRepository {
    constructor(pool) { this.pool = pool; }

    // Query bình thường → dùng pool
    async findBySessionAndLesson(sessionId, lessonId) {
        const [rows] = await this.pool.query(
            'SELECT ... FROM user_progress WHERE session_id = ? AND lesson_id = ?',
            [sessionId, lessonId]
        );
        return rows[0] || null;
    }

    // Trong transaction → nhận connection thay vì pool
    async insertAttempt(conn, data) {
        // conn = connection từ withTransaction
        const [result] = await conn.query(
            'INSERT INTO exercise_attempt (...) VALUES (...)',
            [data.sessionId, data.exerciseId, ...]
        );
        return result.insertId;
    }
}
```

---

## 5. Error Handling Pattern

### Custom Error Classes

```javascript
// errors/AppError.js
class AppError extends Error {
    constructor(message, statusCode) {
        super(message);
        this.statusCode = statusCode;
    }
}

class NotFoundError extends AppError {
    constructor(resource) {
        super(`${resource} not found`, 404);
    }
}

class ValidationError extends AppError {
    constructor(message) {
        super(message, 400);
    }
}
```

### Error Handling Middleware

```javascript
// middleware/errorHandler.js
function errorHandler(err, req, res, next) {
    if (err instanceof AppError) {
        return res.status(err.statusCode).json({ error: err.message });
    }
    // Unexpected error → log và trả 500
    console.error(err);
    res.status(500).json({ error: 'Internal server error' });
}
```

---

## 6. Environment Configuration

### .env file

```env
# Database
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=
DB_NAME=grammar_learning

# Server
PORT=3001
NODE_ENV=development

# CORS (React dev server)
CORS_ORIGIN=http://localhost:5173
```

### Tại sao dùng .env?

1. **Bảo mật:** Password không nằm trong code (không commit lên git)
2. **Linh hoạt:** Đổi DB config không cần sửa code
3. **Convention:** Mọi Node.js project đều dùng pattern này

---

## 7. Cấu trúc thư mục Backend

```
server/
├── index.js                 ← Entry point: tạo app, listen port
├── app.js                   ← Express app setup: middleware, routes, error handler
├── .env                     ← Environment variables (git ignored)
├── .env.example             ← Template cho .env (committed)
│
├── config/
│   └── database.js          ← Pool singleton + config
│
├── routes/
│   ├── index.js             ← Route aggregator
│   ├── tenseGroupRoutes.js
│   ├── lessonRoutes.js
│   ├── exerciseRoutes.js
│   ├── progressRoutes.js
│   └── bookmarkRoutes.js
│
├── controllers/
│   ├── tenseGroupController.js
│   ├── lessonController.js
│   ├── exerciseController.js
│   ├── progressController.js
│   └── bookmarkController.js
│
├── services/
│   ├── lessonService.js
│   ├── exerciseService.js
│   ├── progressService.js
│   └── bookmarkService.js
│
├── repositories/
│   ├── tenseGroupRepository.js
│   ├── lessonRepository.js
│   ├── exerciseRepository.js
│   ├── progressRepository.js
│   └── bookmarkRepository.js
│
├── middleware/
│   ├── errorHandler.js
│   └── validateRequest.js
│
├── utils/
│   └── transaction.js       ← withTransaction helper
│
└── errors/
    └── AppError.js          ← Custom error classes
```

---

## 8. API Routes Design

### URL Convention: RESTful

```
GET    /api/groups                          → Danh sách tense groups
GET    /api/lessons                         → Danh sách lessons (có filter)
GET    /api/lessons/:slug                   → Chi tiết lesson + content
GET    /api/lessons/:slug/exercises         → Bài tập (KHÔNG có đáp án)
POST   /api/exercises/:id/submit            → Submit đáp án
GET    /api/exercises/:id/result            → Xem kết quả sau submit

GET    /api/progress                        → Dashboard overview
GET    /api/progress/:lessonId              → Progress cho 1 lesson
PUT    /api/progress/:lessonId/theory       → Cập nhật theory completion
DELETE /api/progress/:lessonId              → Reset progress

GET    /api/bookmarks                       → Danh sách bookmarks
POST   /api/bookmarks                       → Thêm bookmark
DELETE /api/bookmarks/:id                   → Xóa bookmark

GET    /api/search?q=keyword                → Tìm kiếm lessons
```

### Session ID: Truyền qua HTTP Header

```
X-Session-Id: 550e8400-e29b-41d4-a716-446655440000
```

**Tại sao header thay vì cookie?**
- Không cần cookie parsing middleware
- Explicit — frontend kiểm soát hoàn toàn
- Dễ debug (thấy rõ trong Network tab)
- Không bị CSRF issues

---

## 9. Dependency Injection (DI) — Đơn giản hóa

### Tại sao DI?

Mỗi layer phụ thuộc vào layer dưới. Nếu hardcode dependencies:
```javascript
// ❌ Hardcoded — khó test, khó thay thế
const pool = require('../config/database');
class LessonRepository {
    async findAll() { await pool.query(...); }
}
```

Với DI:
```javascript
// ✓ Injected — dễ test với mock pool
class LessonRepository {
    constructor(pool) { this.pool = pool; }
    async findAll() { await this.pool.query(...); }
}
```

### Wiring (Khởi tạo chuỗi dependencies)

```javascript
// index.js — "Composition Root"
const pool = createPool();

// Repositories
const lessonRepo = new LessonRepository(pool);
const exerciseRepo = new ExerciseRepository(pool);
const progressRepo = new ProgressRepository(pool);

// Services
const lessonService = new LessonService(lessonRepo);
const exerciseService = new ExerciseService(exerciseRepo, progressRepo, pool);

// Controllers
const lessonController = new LessonController(lessonService);

// Routes
app.use('/api/lessons', createLessonRoutes(lessonController));
```

**Không cần DI container** (như InversifyJS). Manual wiring đủ cho dự án này.

---

## 10. Quyết định KHÔNG áp dụng

| Pattern/Tool | Lý do bỏ qua |
|-------------|---------------|
| **ORM (Prisma/Sequelize)** | Đã có APPLICATION_QUERIES.sql sẵn. ORM thêm abstraction không cần thiết, ẩn SQL → khó debug |
| **Query Builder (Knex)** | Dự án có ~30 queries cố định, không cần build query động |
| **DI Container** | Manual wiring đủ cho ~5 repos, ~5 services |
| **Middleware auth** | Không có auth, session_id từ header |
| **Rate limiting** | Local app, 1 user |
| **Request logging (Morgan)** | Có thể thêm sau nếu cần debug |
| **API versioning (v1/)** | Local app, 1 client |
| **DTO/Mapper classes** | Plain objects đủ, dữ liệu đơn giản |
| **Unit of Work pattern** | withTransaction helper đủ đơn giản |
| **CQRS** | Overkill cho single-user app |

---

## 11. Dependencies cần cài

```json
{
  "dependencies": {
    "express": "^4.21",
    "mysql2": "^3.11",
    "dotenv": "^16.4",
    "cors": "^2.8"
  },
  "devDependencies": {
    "nodemon": "^3.1"
  }
}
```

**4 dependencies duy nhất** (+ nodemon cho dev). Không bloat.

| Package | Tại sao |
|---------|---------|
| `express` | Web framework — industry standard |
| `mysql2` | MySQL driver — hỗ trợ Promise, prepared statements, pool |
| `dotenv` | Load .env variables |
| `cors` | Allow React dev server (localhost:5173) gọi API (localhost:3001) |
| `nodemon` | Auto-restart server khi code thay đổi |

---

## 12. Checklist trước khi code

- [ ] Cài dependencies (express, mysql2, dotenv, cors, nodemon)
- [ ] Tạo cấu trúc thư mục server/
- [ ] Tạo .env + .env.example
- [ ] Tạo config/database.js (pool singleton)
- [ ] Tạo utils/transaction.js (transaction helper)
- [ ] Tạo errors/AppError.js (custom errors)
- [ ] Tạo middleware/errorHandler.js
- [ ] Tạo 1 walking skeleton: GET /api/groups (route → controller → service → repo → DB)
- [ ] Verify skeleton hoạt động end-to-end
- [ ] Mở rộng ra các routes còn lại
