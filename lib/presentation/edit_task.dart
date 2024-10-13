import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/data/data.dart';
import 'package:flutter_todo/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditTasksScreen extends StatelessWidget {
  const EditTasksScreen({super.key});

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
  /// [Padding] with a [Task] widget as its child.
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
            final task = Task();
            task.name = controller.text;
            task.priority = Priority.low;
            if (task.isInBox) {
              task.save();
            } else {
              final Box<Task> box = Hive.box(taskBoxName);
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
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 112,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      primaryColor,
                      primaryColor.withOpacity(0.5),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              CupertinoIcons.back,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 94,
                          ),
                          const Text("Add Task",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
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
