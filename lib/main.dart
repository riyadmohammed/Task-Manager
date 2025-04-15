import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/view/task_manager_page.dart';
import 'package:task_manager_app/viewmodel/task_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TaskViewModel()..fetchTasks(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TaskManagerPage(),
    );
  }
}
