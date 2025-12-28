import 'package:flutter/material.dart';
import '../model/task.dart';
import '../services/task_service.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final statusClr = _statusColor(context);
    final priorityClr = _priorityColor(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                _OptionsMenu(task),
              ],
            ),

            const SizedBox(height: 8),

            // STATUS + PRIORITY
            Row(
              children: [
                _StatusPill(task.status, statusClr),
                const SizedBox(width: 16),
                _PriorityDot(task.priority, priorityClr),
              ],
            ),

            // SUGGESTED ACTIONS
            if (task.suggestedActions.isNotEmpty) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                children: task.suggestedActions.map((a) {
                  return ElevatedButton.icon(
                    icon: Icon(_iconFor(a), size: 18),
                    label: Text(a),
                    onPressed: () {},
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _statusColor(BuildContext context) {
    final light = Theme.of(context).brightness == Brightness.light;
    if (task.status == 'completed') {
      return light ? Colors.green.shade800 : Colors.green;
    }
    if (task.status == 'in_progress') {
      return light ? Colors.blue.shade800 : Colors.blue;
    }
    return light ? Colors.orange.shade900 : Colors.orange;
  }

  Color _priorityColor(BuildContext context) {
    final light = Theme.of(context).brightness == Brightness.light;
    if (task.priority == 'high') {
      return light ? Colors.red.shade800 : Colors.red;
    }
    if (task.priority == 'medium') {
      return light ? Colors.orange.shade800 : Colors.orange;
    }
    return light ? Colors.green.shade800 : Colors.green;
  }

  IconData _iconFor(String a) {
    if (a.contains('calendar')) return Icons.calendar_today;
    if (a.contains('invite')) return Icons.mail_outline;
    if (a.contains('agenda')) return Icons.list_alt;
    if (a.contains('invoice')) return Icons.receipt_long;
    return Icons.play_arrow;
  }
}

class _OptionsMenu extends StatelessWidget {
  final Task task;
  const _OptionsMenu(this.task);

  @override
  Widget build(BuildContext context) {
    final service = TaskService();

    return PopupMenuButton<String>(
      tooltip: 'Task actions',
      onSelected: (value) async {
        switch (value) {
          case 'pending':
          case 'in_progress':
          case 'completed':
            await service.updateTask(
              task.id,
              {'status': value},
            );
            break;

          case 'delete':
            await service.deleteTask(task.id);
            break;
        }
      },
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: 'pending',
          child: Text('Mark as Pending'),
        ),
        PopupMenuItem(
          value: 'in_progress',
          child: Text('Mark as In Progress'),
        ),
        PopupMenuItem(
          value: 'completed',
          child: Text('Mark as Completed'),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 'delete',
          child: Text(
            'Delete Task',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}


class _StatusPill extends StatelessWidget {
  final String text;
  final Color color;
  const _StatusPill(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _PriorityDot extends StatelessWidget {
  final String text;
  final Color color;
  const _PriorityDot(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
