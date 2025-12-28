import 'package:flutter/material.dart';
import '../services/task_service.dart';

class TaskFormSheet extends StatefulWidget {
  const TaskFormSheet({super.key});

  @override
  State<TaskFormSheet> createState() => _TaskFormSheetState();
}

class _TaskFormSheetState extends State<TaskFormSheet> {
  final _title = TextEditingController();
  final _desc = TextEditingController();
  final _service = TaskService();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Create Task',
              style: Theme.of(context).textTheme.headlineSmall),

          const SizedBox(height: 16),

          TextField(
            controller: _title,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: _desc,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: loading
                  ? null
                  : () async {
                setState(() => loading = true);
                await _service.createTask({
                  'title': _title.text,
                  'description': _desc.text,
                });
                Navigator.pop(context);
              },
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text('Create Task'),
            ),
          ),
        ],
      ),
    );
  }
}
