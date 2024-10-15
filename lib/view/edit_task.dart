import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/data/entity/data.dart';
import 'package:flutter_todo/data/repository/repository.dart';
import 'package:flutter_todo/main.dart';
import 'package:flutter_todo/widgets/priority_check_box.dart';
import 'package:provider/provider.dart';

class EditTasksScreen extends StatefulWidget {
  final TaskEntity task;
  const EditTasksScreen({super.key, required this.task});

  @override
  State<EditTasksScreen> createState() => _EditTasksScreenState();
}

class _EditTasksScreenState extends State<EditTasksScreen> {
  @override

  /// The main widget of the edit task screen. It is a [SafeArea] with a
  /// [Scaffold] as its child. The [Scaffold] has a [FloatingActionButton] and an
  /// [AppBar] as its app bar. The [AppBar] has a title and a leading icon. The
  /// leading icon is a back arrow. The [FloatingActionButton] is used to save
  /// changes to the task. The [FloatingActionButton] is an [InkWell] with a
  /// [Text] and an [Icon] as its child. The [Text] is "Save Changes" and the
  /// [Icon] is a checkmark. The [Scaffold]'s body is a [Column] with two
  /// children. The first child is a [Padding] with a [Flex] as its child. The
  /// [Flex] has three children, which are [PriorityCheckBox] widgets. The
  /// second child is a [Padding] with a [Container] as its child. The [Container]
  /// is a [TextField] with a prefix icon and a label. The prefix icon is a plus
  /// icon and the label is "Add Task for Today". The [TextField] is used to
  /// enter a new task.
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

            final repository =
                Provider.of<Repository<TaskEntity>>(context, listen: false);
            repository.createOrUpdate(task);

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
