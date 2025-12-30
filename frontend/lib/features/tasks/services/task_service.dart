import '../../../core/api/api_client.dart';
import '../model/task.dart';

class TaskService {
  Future<List<Task>> fetchTasks() async {
    final res = await ApiClient.dio.get('/tasks');
    print('RAW RESPONSE: ${res.data.runtimeType} => ${res.data}');
    final raw = res.data;

    if (raw == null) return [];

    if (raw is String) {
      return [];
    }

    if (raw is Map<String, dynamic>) {
      final inner = raw['data'];

      if (inner is List) {
        return inner
            .whereType<Map<String, dynamic>>()
            .map((e) => Task.fromJson(e))
            .toList();
      }
    }

    if (raw is List) {
      return raw
          .whereType<Map<String, dynamic>>()
          .map((e) => Task.fromJson(e))
          .toList();
    }

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

