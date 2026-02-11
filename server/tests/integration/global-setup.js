import postgres from 'postgres';
import { readFileSync } from 'fs';
import { resolve, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const TEST_DB = process.env.TEST_DB_NAME || 'knowledge_learning_test';

export async function setup() {
  const adminSql = postgres({
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT, 10) || 5432,
    user: process.env.DB_USER || 'relax_user',
    password: process.env.DB_PASSWORD || 'relaxpass',
    database: 'postgres',
  });

  // Terminate any existing connections to the test DB
  await adminSql.unsafe(`
    SELECT pg_terminate_backend(pid)
    FROM pg_stat_activity
    WHERE datname = '${TEST_DB}' AND pid <> pg_backend_pid()
  `);
  await adminSql.unsafe(`DROP DATABASE IF EXISTS ${TEST_DB}`);
  await adminSql.unsafe(`CREATE DATABASE ${TEST_DB}`);
  await adminSql.end();

  // Load schema + seed data into test DB
  const testSql = postgres({
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT, 10) || 5432,
    user: process.env.DB_USER || 'relax_user',
    password: process.env.DB_PASSWORD || 'relaxpass',
    database: TEST_DB,
  });

  const schemaPath = resolve(__dirname, '../../../database/schema.sql');
  const seedPath = resolve(__dirname, '../../../database/seed_data.sql');
  const schema = readFileSync(schemaPath, 'utf-8');
  const seed = readFileSync(seedPath, 'utf-8');

  await testSql.unsafe(schema);
  await testSql.unsafe(seed);
  await testSql.end();
}

export async function teardown() {
  const adminSql = postgres({
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT, 10) || 5432,
    user: process.env.DB_USER || 'relax_user',
    password: process.env.DB_PASSWORD || 'relaxpass',
    database: 'postgres',
  });

  await adminSql.unsafe(`
    SELECT pg_terminate_backend(pid)
    FROM pg_stat_activity
    WHERE datname = '${TEST_DB}' AND pid <> pg_backend_pid()
  `);
  await adminSql.unsafe(`DROP DATABASE IF EXISTS ${TEST_DB}`);
  await adminSql.end();
}
