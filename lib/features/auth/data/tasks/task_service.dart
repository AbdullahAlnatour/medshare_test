import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../core/storage/token_storage.dart';
import 'task_response_model.dart';

class TaskService {
  final String baseUrl = 'http://10.0.2.2:5149/api/tasks';

  /// GET ALL TASKS
  Future<List<TaskResponseModel>> getAllTasks() async {
    final token = await TokenStorage.getAccessToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/alltasks'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      print(json);
      return jsonList
          .map((e) => TaskResponseModel.fromJson(e))
          .toList();
    } else {
      throw Exception(
        'Failed to load tasks (${response.statusCode}): ${response.body}',
      );
    }
  }

  /// CREATE TASK
  Future<void> createTask({
    required DateTime dueDate,
    required String notes,
  }) async {
    final token = await TokenStorage.getAccessToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    final jsonBody = jsonEncode({
      "dueDate": dueDate.toIso8601String(),
      "notes": notes,
    });

    final response = await http.post(
      Uri.parse('$baseUrl/assign'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        '❌ Failed to create task\n'
            'URL: ${response.request?.url}\n'
            'Status: ${response.statusCode} ${response.reasonPhrase}\n'
            'Response body: ${response.body}\n'
            'Request body: $jsonBody\n'
            'Headers: ${response.request?.headers}\n',
      );
    }
  }

  /// CANCEL TASK
  Future<void> cancelTask(int taskId) async {
    final token = await TokenStorage.getAccessToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.put(
      Uri.parse('$baseUrl/cancel'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'taskId': taskId}),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to cancel task (${response.statusCode}): ${response.body}',
      );
    }
  }
  Future<void> updateTaskNotes({
    required int taskId,
    required String notes,
  }) async {
    final token = await TokenStorage.getAccessToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.put(
      Uri.parse('$baseUrl/update'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'taskId': taskId,
        'notes': notes,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to update task (${response.statusCode}): ${response.body}',
      );
    }
  }

}
