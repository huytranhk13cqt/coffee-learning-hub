import mysql from 'mysql2/promise';

let pool = null;

export function getPool() {
  if (!pool) {
    pool = mysql.createPool({
      host: process.env.DB_HOST || 'localhost',
      port: parseInt(process.env.DB_PORT, 10) || 3306,
      user: process.env.DB_USER || 'grammar_user',
      password: process.env.DB_PASSWORD || '',
      database: process.env.DB_NAME || 'grammar_learning',
      waitForConnections: true,
      connectionLimit: 10,
      queueLimit: 0,
      connectTimeout: 10000,
      charset: 'utf8mb4',
      timezone: '+00:00',
      decimalNumbers: true,
    });
  }
  return pool;
}

export async function closePool() {
  if (pool) {
    await pool.end();
    pool = null;
  }
}
