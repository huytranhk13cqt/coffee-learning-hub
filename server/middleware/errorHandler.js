import { AppError } from '../errors/AppError.js';

export function errorHandler(err, req, res, next) {
  if (err instanceof AppError) {
    return res.status(err.statusCode).json({ error: err.message });
  }

  console.error('Unexpected error:', err);
  res.status(500).json({ error: 'Internal server error' });
}
