import 'package:flutter/material.dart';
import 'package:task_manager_app/model/task_model.dart';
import 'package:task_manager_app/view/add_task_page.dart';
import 'package:task_manager_app/viewmodel/task_viewmodel.dart';
import 'package:provider/provider.dart';

class TaskManagerPage extends StatelessWidget {
  const TaskManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final taskVM = context.watch<TaskViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text("Task Manager")),
      body: RefreshIndicator(
        onRefresh: taskVM.fetchTasks,
        child: taskVM.isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: taskVM.tasks.length,
          itemBuilder: (context, index) {
            final task = taskVM.tasks[index];
            return buildTaskItem(context, task, taskVM);
          },
        ),
      ),
    );
  }


  Widget buildTaskItem(BuildContext context,TaskModel task, TaskViewModel taskVM) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          GestureDetector(
            onTap: () => taskVM.toggleComplete(task.id),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: task.completed ? Colors.green : Colors.transparent,
                border: Border.all(
                  color: task.completed ? Colors.green : Colors.grey,
                  width: 2,
                ),
              ),
              child: task.completed
                  ? Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ),
          const SizedBox(width: 12),


          Expanded(
            child: Text(
              task.title,
              style: TextStyle(
                decoration: task.completed
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: task.completed ? Colors.grey : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'toggle') {
                taskVM.toggleComplete(task.id);
              } else if (value == 'delete') {
                taskVM.deleteTask(task.id);
              } else if (value == 'add') {
                // Capture context here safely
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddTaskPage()),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'toggle',
                child: Text(task.completed ? 'Unmark as Completed' : 'Mark as Completed'),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Text('Delete'),
              ),
              PopupMenuItem<String>(
                value: 'add',
                child: Text('Add Task'),
              ),
            ],
          )

        ],
      ),
    );
  }
}
