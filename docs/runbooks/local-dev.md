# Runbook: Local Development Setup

> Use this when: setting up fresh, after cloning, or after a long break when you've forgotten the setup.

---

## Prerequisites

- Node.js ≥ 20 (`node --version`)
- Docker Desktop running (`docker ps`)
- Git

---

## 1. Clone & Configure

```bash
git clone <repo-url> project-relax
cd project-relax
cp .env.example .env
```

`.env` defaults work as-is for local Docker. Only change if you use a non-default DB password.

---

## 2. Start PostgreSQL

```bash
docker compose up -d
```

**First run**: Docker will auto-load `database/schema.sql` + all seed files. This takes ~10–30 seconds.

**Check it's ready**:

```bash
docker exec -it knowledge-postgres psql -U relax_user -d knowledge_learning -c "\dt"
# Should show 20+ tables
```

**If the container already exists but DB is empty** (volume was deleted):

```bash
docker compose down -v     # Remove volume
docker compose up -d       # Recreate with fresh schema
```

---

## 3. Install Dependencies

```bash
# Client (root)
npm ci

# Server
cd server && npm ci && cd ..
```

Or using Makefile:

```bash
make install
```

---

## 4. Apply Pending Migrations

Check current schema version:

```bash
docker exec -it knowledge-postgres psql -U relax_user -d knowledge_learning \
  -c "SELECT version, description FROM schema_version ORDER BY version DESC LIMIT 5;"
```

Apply migrations in order (e.g., if on v19, apply 020, 021, 022...):

```bash
docker exec -i knowledge-postgres psql -U relax_user -d knowledge_learning \
  < database/migrations/020_your_migration.sql
```

See [`migration.md`](./migration.md) for full migration guide.

---

## 5. Start Dev Servers

Two terminals:

```bash
# Terminal 1 — Client (http://localhost:5173)
npm run dev

# Terminal 2 — Server (http://localhost:3001)
cd server && npm run dev
```

Or with Makefile (runs both via concurrently):

```bash
make dev
```

---

## 6. Verify Everything Works

```bash
# API health
curl http://localhost:3001/api/home | head -c 200

# Client
open http://localhost:5173
```

---

## Common Issues

### Port already in use

```bash
# Find what's using port 3001
lsof -i :3001

# Kill it
kill -9 <PID>
```

### DB connection refused

```bash
docker compose ps          # Check container is running
docker compose logs db     # Check for errors
```

### Schema mismatch errors (`column X does not exist`)

You're likely on an old schema version. Apply missing migrations (see step 4).

### `node_modules` issues

```bash
rm -rf node_modules server/node_modules
npm ci && cd server && npm ci
```

---

## Running Tests

```bash
# Client unit tests
npx vitest run

# Server unit tests
cd server && npx vitest run

# Server integration tests (requires DB running)
cd server && npx vitest run -c vitest.integration.js

# All tests
cd server && npm run test:all

# E2E (requires both servers running)
npx playwright test
```

Or: `make check` — runs lint + format + all tests + build.

---

## Stopping Everything

```bash
# Stop dev servers: Ctrl+C in each terminal

# Stop PostgreSQL
docker compose stop

# Stop + remove containers (keeps data volume)
docker compose down

# Stop + remove everything including data
docker compose down -v
```
