import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/viewmodel/task_viewmodel.dart'
    show TaskViewModel;

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    titleController.addListener(_updateButtonState);
    descriptionController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    final hasInput =
        titleController.text.trim().isNotEmpty ||
        descriptionController.text.trim().isNotEmpty;
    if (isButtonEnabled != hasInput) {
      setState(() {
        isButtonEnabled = hasInput;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskVM = Provider.of<TaskViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    isButtonEnabled
                        ? () {
                          taskVM.addTask(
                            titleController.text,
                            descriptionController.text,
                          );
                          Navigator.pop(context);
                        }
                        : null,
                child: Text("Add Task"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
