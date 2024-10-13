import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/data/data.dart';
import 'package:flutter_todo/main.dart';
import 'package:flutter_todo/presentation/edit_task.dart';
import 'package:flutter_todo/widgets/task_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HommeScreen extends StatelessWidget {
  const HommeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Box<Task> box = Hive.box(taskBoxName);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditTasksScreen()));
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
        child: Column(
          children: [
            Container(
              height: 102,
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("To Do List",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Icon(CupertinoIcons.share_up, color: Colors.white),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
    );
  }
}
