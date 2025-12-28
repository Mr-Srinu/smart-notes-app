import app from './app';
import { env } from './config/env';

const PORT = Number(process.env.PORT) || 3000;

app.get('/', (_req, res) => {
  res.send('Smart Notes API is running');
});

app.get('/health', (_req, res) => {
  res.json({ status: 'ok' });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});
