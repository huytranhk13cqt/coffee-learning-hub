import postgres from 'postgres';

let sql = null;

export function getSql() {
  if (!sql) {
    sql = postgres({
      host: process.env.DB_HOST || 'localhost',
      port: parseInt(process.env.DB_PORT, 10) || 5432,
      user: process.env.DB_USER || 'relax_user',
      password: process.env.DB_PASSWORD || '',
      database: process.env.DB_NAME || 'knowledge_learning',
      max: 10,
      idle_timeout: 20,
      connect_timeout: 10,
    });
  }
  return sql;
}

export async function closeSql() {
  if (sql) {
    await sql.end();
    sql = null;
  }
}
