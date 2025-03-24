import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/task_model.dart';

class ApiService {
  static Future<List<Task>> fetchTasks() async {
    try {
      final response = await http.get(Uri.parse('https://amock.io/api/researchUTH/tasks'));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> tasksJson = jsonResponse['data'];
        return tasksJson.map((json) => Task.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load tasks: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }
}
