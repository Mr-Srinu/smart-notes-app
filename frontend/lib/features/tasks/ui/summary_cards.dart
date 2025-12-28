import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _SummaryRow extends StatelessWidget {
  final List tasks;
  const _SummaryRow({required this.tasks});

  int _count(String status) =>
      tasks.where((t) => t.status == status).length;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SummaryCard(
          title: 'Pending',
          count: _count('pending'),
          color: Colors.orange,
        ),
        const SizedBox(width: 12),
        _SummaryCard(
          title: 'In Progress',
          count: _count('in_progress'),
          color: Colors.blue,
        ),
        const SizedBox(width: 12),
        _SummaryCard(
          title: 'Completed',
          count: _count('completed'),
          color: Colors.green,
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$count',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: color),
            ),
            Text(title, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}
