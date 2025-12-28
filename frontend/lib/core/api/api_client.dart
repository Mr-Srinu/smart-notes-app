// lib/core/api/api_client.dart
import 'package:dio/dio.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:3000/api',
      headers: {
        'x-api-key': 'task-app-secret',
        'Content-Type': 'application/json',
      },
    ),
  );
}
