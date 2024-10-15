import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/data/data.dart';
import 'package:flutter_todo/main.dart';
import 'package:flutter_todo/view/edit_task.dart';
import 'package:flutter_todo/widgets/task_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HommeScreen extends StatelessWidget {
  const HommeScreen({super.key});

  @override

  /// The root widget of the home screen. It is a [Scaffold] with a
  /// [FloatingActionButton] and a [SafeArea] as its body. The [SafeArea] is
  /// divided into two parts. The first part is a [Container] with a gradient
  /// decoration and a [Column] containing a [Row] with a title and a share
  /// icon, and a [TextField] with a search icon. The second part is an
  /// [Expanded] widget containing a [ListView] with all the tasks in the box.
  /// The [ListView] is built using a [ValueListenableBuilder] which listens to
  /// the box's [Listenable] and rebuilds the [ListView] whenever the box's
  /// values change. The [ListView] is divided into two parts. The first part is
  /// a [Row] containing a [Text] with the current date and a [Container] with a
  /// colored bar. The second part is a list of all the tasks in the box, with
  /// each task represented by a [TaskItem] widget. The [TaskItem] widget is a
  /// [Padding] with a [Task] widget as its child.
  Widget build(BuildContext context) {
    Box<Task> box = Hive.box(taskBoxName);
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditTasksScreen(
                            task: Task(),
                          )));
            },
            label: const Row(
              children: [
                Text("Add Task"),
                SizedBox(
                  width: 4,
                ),
                Icon(CupertinoIcons.add_circled)
              ],
            )),
        body: SafeArea(
          top: true,
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("To Do List",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          InkWell(
                              onTap: () {
                                final snackBar = SnackBar(
                                  content: const Text('Share Succesfully!'),
                                  action: SnackBarAction(
                                    backgroundColor: primaryColor,
                                    label: 'Undo',
                                    textColor: Colors.white,
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              child: const Icon(CupertinoIcons.share_up,
                                  color: Colors.white)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 38,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.1),
                                blurRadius: 0,
                              )
                            ]),
                        child: const TextField(
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            iconColor: secondryTextColor,
                            labelStyle: TextStyle(color: secondryTextColor),
                            hintText: "Search Tasks",
                            prefixIcon: Icon(CupertinoIcons.search),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ValueListenableBuilder<Box<Task>>(
                  builder: (context, box, child) {
                    return ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 10, 16, 100),
                        itemCount: box.values.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Today',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        height: 3,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      )
                                    ],
                                  ),
                                  MaterialButton(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    textColor: secondryTextColor,
                                    color: const Color(0xffEAEFF5),
                                    onPressed: () {
                                      box.clear();
                                    },
                                    child: const Row(
                                      children: [
                                        Text("Delete All"),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Icon(
                                          CupertinoIcons.delete,
                                          color: secondryTextColor,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          } else {
                            final Task task = box.values.toList()[index - 1];
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TaskItem(task: task),
                            );
                          }
                        });
                  },
                  valueListenable: box.listenable(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
