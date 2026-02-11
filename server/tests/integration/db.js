import postgres from 'postgres';

const TEST_DB = process.env.TEST_DB_NAME || 'knowledge_learning_test';

let testSql = null;

export function getTestSql() {
  if (!testSql) {
    testSql = postgres({
      host: process.env.DB_HOST || 'localhost',
      port: parseInt(process.env.DB_PORT, 10) || 5432,
      user: process.env.DB_USER || 'relax_user',
      password: process.env.DB_PASSWORD || 'relaxpass',
      database: TEST_DB,
      max: 5,
      idle_timeout: 10,
      connect_timeout: 10,
    });
  }
  return testSql;
}

export async function closeTestSql() {
  if (testSql) {
    await testSql.end();
    testSql = null;
  }
}
