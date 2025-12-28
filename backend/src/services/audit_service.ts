import { supabase } from '../config/superbase';

export async function logTaskHistory(
  taskId: string,
  action: string,
  oldValue: any,
  newValue: any
) {
  await supabase.from('task_history').insert({
    task_id: taskId,
    action,
    old_value: oldValue,
    new_value: newValue,
    changed_by: 'system'
  });
}
