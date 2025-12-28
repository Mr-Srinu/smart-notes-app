import { Request, Response } from 'express';
import { supabase } from '../config/superbase';
import { classifyTask } from '../services/classification_service';
import { logTaskHistory } from '../services/audit_service';

export async function createTask(req: Request, res: Response) {
  const { title, description } = req.body;

  if (!title) {
    return res.status(400).json({ message: 'Title is required' });
  }

  const meta = classifyTask(title, description);

  const { data, error } = await supabase
    .from('tasks')
    .insert({
      title,
      description,
      status: 'pending',
      ...meta
    })
    .select()
    .single();

  if (error) return res.status(500).json({ message: error.message });

  await logTaskHistory(data.id, 'created', null, data);

  res.status(201).json(data);
}

export async function getTasks(req: Request, res: Response) {
  const { status, category, priority } = req.query as Record<string, string>;

  let query = supabase.from('tasks').select('*');

  if (status) query = query.eq('status', status);
  if (category) query = query.eq('category', category);
  if (priority) query = query.eq('priority', priority);

  const { data, error } = await query;

  if (error) return res.status(500).json({ message: error.message });

  res.json(data);
}

export async function getTaskById(req: Request, res: Response) {
  const { id } = req.params;

  const { data, error } = await supabase
    .from('tasks')
    .select('*')
    .eq('id', id)
    .single();

  if (error) return res.status(404).json({ message: 'Task not found' });

  res.json(data);
}

export async function updateTask(req: Request, res: Response) {
  const { id } = req.params;

  const { data: oldTask } = await supabase
    .from('tasks')
    .select('*')
    .eq('id', id)
    .single();

  const { data, error } = await supabase
    .from('tasks')
    .update({ ...req.body, updated_at: new Date().toISOString() })
    .eq('id', id)
    .select()
    .single();

  if (error) return res.status(500).json({ message: error.message });

  await logTaskHistory(id, 'updated', oldTask, data);

  res.json(data);
}

export async function deleteTask(req: Request, res: Response) {
  const { id } = req.params;

  const { data: oldTask } = await supabase
    .from('tasks')
    .select('*')
    .eq('id', id)
    .single();

  await supabase.from('tasks').delete().eq('id', id);

  await logTaskHistory(id, 'deleted', oldTask, null);

  res.json({ message: 'Task deleted' });
}
