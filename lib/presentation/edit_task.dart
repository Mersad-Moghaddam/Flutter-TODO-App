import 'package:flutter/material.dart';
import 'package:flutter_todo/data/data.dart';
import 'package:flutter_todo/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditTasksScreen extends StatelessWidget {
  const EditTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final task = Task();
          task.name = _controller.text;
          task.priority = Priority.low;
          if (task.isInBox) {
            task.save();
          } else {
            final Box<Task> box = Hive.box(taskBoxName);
            box.add(task);
          }

          Navigator.pop(context);
        },
        label: const Text("Save Changes"),
      ),
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration:
                const InputDecoration(label: Text("Add Task for Today")),
          )
        ],
      ),
    );
  }
}
