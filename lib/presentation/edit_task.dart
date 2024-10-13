import 'package:flutter/material.dart';
import 'package:flutter_todo/data/data.dart';
import 'package:flutter_todo/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditTasksScreen extends StatelessWidget {
  const EditTasksScreen({super.key});

  @override

  /// The build method for the [EditTasksScreen].
  ///
  /// This method returns a [Scaffold] with a [FloatingActionButton] and a
  /// [Column] body. The [Column] contains a [TextField] for the user to enter
  /// the task name and a [Text] for the label. The [FloatingActionButton] is
  /// used to save the task and navigate back to the previous screen.
  ///
  /// The [TextEditingController] is used to get the text from the [TextField] and
  /// assign it to the [Task] object. The [Task] object is then saved to the box
  /// using [Box.add].
  ///
  /// If the [Task] is already in the box, [Task.save] is called to update the
  /// task in the box.
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
