import express from 'express';
import cors from 'cors';
import taskRoutes from './routes/task_routes';
import { apiKeyMiddleware } from './middleware/apiKey';
import { errorHandler } from './middleware/error';

const app = express();

app.use(
  cors({
    origin: true,
    methods: ['GET', 'POST', 'PATCH', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'x-api-key'],
  })
);

app.options('*', cors());

app.use(express.json());
app.use('/api/tasks', apiKeyMiddleware, taskRoutes);
app.use(errorHandler);

export default app;
