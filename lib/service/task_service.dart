import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_manager_app/model/task_model.dart';

class TaskService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<TaskModel>> fetchTasks() async {
    final res = await http.get(Uri.parse('$baseUrl/todos?_limit=10'));
    final List jsonData = json.decode(res.body);
    return jsonData.map((json) => TaskModel.fromJson(json)).toList();
  }
}
