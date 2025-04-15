class TaskModel {
  final int id;
  final String title;
  final String description;
  bool completed;

  TaskModel({
    required this.id,
    required this.title,
    this.description = '',
    this.completed = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json['id'],
    title: json['title'],
    completed: json['completed'] ?? false,
  );
}
