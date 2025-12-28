import '../../../core/api/api_client.dart';
import '../model/task.dart';

class TaskService {
  Future<List<Task>> fetchTasks() async {
    final res = await ApiClient.dio.get('/tasks');
    print('RAW RESPONSE: ${res.data.runtimeType} => ${res.data}');
    final raw = res.data;

    // 🔒 HARD STOP — ignore everything if response is wrong
    if (raw == null) return [];

    // Case 1: Backend accidentally returns String
    if (raw is String) {
      return [];
    }

    // Case 2: Correct backend shape (Map)
    if (raw is Map<String, dynamic>) {
      final inner = raw['data'];

      if (inner is List) {
        return inner
            .whereType<Map<String, dynamic>>()
            .map((e) => Task.fromJson(e))
            .toList();
      }
    }

    // Case 3: Backend returns List directly (Supabase-style)
    if (raw is List) {
      return raw
          .whereType<Map<String, dynamic>>()
          .map((e) => Task.fromJson(e))
          .toList();
    }

    // Fallback — never crash UI
    return [];
  }

  Future<void> createTask(Map<String, dynamic> payload) async {
    await ApiClient.dio.post('/tasks', data: payload);
  }

  Future<void> updateTask(String id, Map<String, dynamic> payload) async {
    await ApiClient.dio.patch('/tasks/$id', data: payload);
  }

  Future<void> deleteTask(String id) async {
    await ApiClient.dio.delete('/tasks/$id');
  }
}
