import { Request, Response, NextFunction } from 'express';
import { env } from '../config/env';

export function apiKeyMiddleware(
  req: Request,
  res: Response,
  next: NextFunction
) {
  if (
    req.method === 'OPTIONS' ||
    req.path === '/' ||
    req.path === '/health'
  ) {
    return next();
  }

  const apiKey = req.headers['x-api-key'];

  if (!apiKey || apiKey !== env.apiKey) {
    return res.status(401).json({ message: 'Invalid API Key' });
  }

  next();
}
