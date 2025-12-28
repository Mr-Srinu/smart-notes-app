// lib/features/tasks/provider/task_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/task.dart';
import '../services/task_service.dart';

final taskProvider =
StateNotifierProvider<TaskNotifier, AsyncValue<List<Task>>>(
      (ref) => TaskNotifier(),
);

class TaskNotifier extends StateNotifier<AsyncValue<List<Task>>> {
  TaskNotifier() : super(const AsyncLoading()) {
    loadTasks();
  }

  final _service = TaskService();

  List<Task> _allTasks = [];

  String _searchQuery = '';
  String? _statusFilter;
  String? _priorityFilter;
  String? _categoryFilter;

  Future<void> loadTasks() async {
    try {
      final tasks = await _service.fetchTasks();
      _allTasks = tasks;
      _applyFilters();
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // 🔎 Filters API (UI calls these)
  void setSearch(String v) {
    _searchQuery = v;
    _applyFilters();
  }

  void setStatus(String? v) {
    _statusFilter = v;
    _applyFilters();
  }

  void setPriority(String? v) {
    _priorityFilter = v;
    _applyFilters();
  }

  void setCategory(String? v) {
    _categoryFilter = v;
    _applyFilters();
  }

  void clearFilters() {
    _searchQuery = '';
    _statusFilter = null;
    _priorityFilter = null;
    _categoryFilter = null;
    _applyFilters();
  }

  void _applyFilters() {
    final filtered = _allTasks.where((t) {
      final searchOk = t.title
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());

      final statusOk =
          _statusFilter == null || t.status == _statusFilter;
      final priorityOk =
          _priorityFilter == null || t.priority == _priorityFilter;
      final categoryOk =
          _categoryFilter == null || t.category == _categoryFilter;

      return searchOk && statusOk && priorityOk && categoryOk;
    }).toList();

    state = AsyncData(filtered);
  }
}
