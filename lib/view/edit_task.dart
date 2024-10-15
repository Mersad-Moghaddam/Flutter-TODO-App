import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/data/entity/data.dart';
import 'package:flutter_todo/main.dart';
import 'package:flutter_todo/widgets/priority_check_box.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditTasksScreen extends StatefulWidget {
  final TaskEntity task;
  const EditTasksScreen({super.key, required this.task});

  @override
  State<EditTasksScreen> createState() => _EditTasksScreenState();
}

class _EditTasksScreenState extends State<EditTasksScreen> {
  @override

  /// The root widget of the edit screen. It is a [Scaffold] with a
  /// [FloatingActionButton] and a [SafeArea] as its body. The [SafeArea] is
  /// divided into two parts. The first part is a [Container] with a gradient
  /// decoration and a [Column] containing a [Row] with a back arrow and the
  /// screen title, and a [TextField] with a plus icon. The second part is an
  /// [Expanded] widget containing a [ListView] with all the tasks in the box.
  /// The [ListView] is built using a [ValueListenableBuilder] which listens to
  /// the box's [Listenable] and rebuilds the [ListView] whenever the box's
  /// values change. The [ListView] is divided into two parts. The first part is
  /// a [Row] containing a [Text] with the current date and a [Container] with a
  /// colored bar. The second part is a list of all the tasks in the box, with
  /// each task represented by a [TaskItem] widget. The [TaskItem] widget is a
  /// [Padding] with a [TaskEntity] widget as its child.
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            final task = TaskEntity();
            task.name = controller.text;
            task.priority = Priority.low;
            if (task.isInBox) {
              task.save();
            } else {
              final Box<TaskEntity> box = Hive.box(taskBoxName);
              box.add(task);
            }

            Navigator.pop(context);
          },
          label: const Row(
            children: [
              Text("Save Changes"),
              SizedBox(
                width: 4,
              ),
              Icon(
                CupertinoIcons.checkmark,
                size: 18,
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: primaryTextColor,
          elevation: 0,
          title: const Text(
            "Edit Task",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                        flex: 1,
                        child: PriorityCheckBox(
                          label: 'High',
                          color: Colors.red,
                          isChecked: widget.task.priority == Priority.high
                              ? true
                              : false,
                          onTap: () {
                            widget.task.priority = Priority.high;
                          },
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                        flex: 1,
                        child: PriorityCheckBox(
                          label: 'Normal',
                          color: Colors.orangeAccent,
                          isChecked: widget.task.priority == Priority.medium
                              ? true
                              : false,
                          onTap: () {
                            widget.task.priority = Priority.medium;
                          },
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                        flex: 1,
                        child: PriorityCheckBox(
                          label: 'Low',
                          color: Colors.blue,
                          isChecked: widget.task.priority == Priority.low
                              ? true
                              : false,
                          onTap: () {
                            widget.task.priority = Priority.low;
                          },
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 100),
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  height: 84,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            CupertinoIcons.add_circled,
                            color: secondryTextColor,
                          ),
                          label: Text(
                            "Add Task for Today",
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
