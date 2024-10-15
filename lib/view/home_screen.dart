import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/data/entity/data.dart';
import 'package:flutter_todo/data/repository/repository.dart';
import 'package:flutter_todo/main.dart';
import 'package:flutter_todo/view/edit_task.dart';
import 'package:flutter_todo/widgets/task_item.dart';
import 'package:flutter_todo/widgets/task_list.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class HommeScreen extends StatelessWidget {
  const HommeScreen({super.key});

  @override

  /// The root widget of the home screen. It is a [Scaffold] with a
  /// [FloatingActionButton] and a [SafeArea] as its body. The [SafeArea] is
  /// divided into two parts. The first part is a [Container] with a gradient
  /// decoration and a [Column] containing a [Row] with a back arrow and the
  /// screen title, and a [TextField] with a search icon. The second part is an
  /// [Expanded] widget containing a [ListView] with all the tasks in the box.
  /// The [ListView] is built using a [ValueListenableBuilder] which listens to
  /// the box's [Listenable] and rebuilds the [ListView] whenever the box's
  /// values change. The [ListView] is divided into two parts. The first part is
  /// a [Row] containing a [Text] with the current date and a [Container] with a
  /// colored bar. The second part is a list of all the tasks in the box, with
  /// each task represented by a [TaskItem] widget. The [TaskItem] widget is a
  /// [Padding] with a [TaskEntity] widget as its child.
  Widget build(BuildContext context) {
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
                            task: TaskEntity(),
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
                child: ValueListenableBuilder<Box<TaskEntity>>(
                  valueListenable:
                      Hive.box<TaskEntity>(taskBoxName).listenable(),
                  builder: (context, box, child) {
                    final repository =
                        Provider.of<Repository<TaskEntity>>(context);
                    return FutureBuilder(
                        future: repository.getAll(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return const TaskList();
                          } else {
                            return const CircularProgressIndicator();
                          }
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
