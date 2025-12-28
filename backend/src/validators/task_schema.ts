import { z } from 'zod';

export const taskSchema = z.object({
  title: z.string().min(1),
  description: z.string().optional(),
  assigned_to: z.string().optional(),
  due_date: z.string().optional(),
  category: z.string().optional(),
  priority: z.string().optional(),
});
