class Task {
  final String id;
  final String title;
  final String category;
  final String priority;
  final String status;
  final String? assignedTo;
  final DateTime? dueDate;
  final List<String> suggestedActions;

  Task({
    required this.id,
    required this.title,
    required this.category,
    required this.priority,
    required this.status,
    this.assignedTo,
    this.dueDate,
    required this.suggestedActions,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      category: json['category']?.toString() ?? 'general',
      priority: json['priority']?.toString() ?? 'low',
      status: json['status']?.toString() ?? 'pending',
      assignedTo: json['assigned_to']?.toString(),
      dueDate: json['due_date'] != null
          ? DateTime.tryParse(json['due_date'].toString())
          : null,
      suggestedActions:
      (json['suggested_actions'] as List?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
    );
  }
}
