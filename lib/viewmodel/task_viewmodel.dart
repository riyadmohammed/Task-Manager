import 'package:flutter/material.dart';
import 'package:task_manager_app/model/task_model.dart';
import 'package:task_manager_app/service/task_service.dart';

class TaskViewModel extends ChangeNotifier {
  final List<TaskModel> _tasks = [];
  final _service = TaskService();

  List<TaskModel> get tasks => _tasks;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fetchTasks() async {
    _isLoading = true;
    notifyListeners();
    _tasks.clear();
    _tasks.addAll(await _service.fetchTasks());
    _isLoading = false;
    notifyListeners();
  }

  void addTask(String title, String description) {
    _tasks.insert(
      0,
      TaskModel(
        id: DateTime.now().millisecondsSinceEpoch,
        title: title,
        description: description,
      ),
    );
    notifyListeners();
  }

  void toggleComplete(int id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].completed = !_tasks[index].completed;
      notifyListeners();
    }
  }

  void deleteTask(int id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}
