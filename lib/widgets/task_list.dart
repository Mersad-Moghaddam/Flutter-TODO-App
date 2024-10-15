import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/data/entity/data.dart';
import 'package:flutter_todo/data/repository/repository.dart';
import 'package:flutter_todo/main.dart';
import 'package:flutter_todo/widgets/task_item.dart';
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
  });

  @override

  /// A widget that displays a list of tasks.
  ///
  /// The first item in the list is a header with the current date and a
  /// "Delete All" button. The "Delete All" button deletes all the tasks in the
  /// list.
  ///
  /// The rest of the items in the list are tasks, each represented by a
  /// [TaskItem] widget.
  ///
  /// The list is built using a [FutureBuilder] which waits for the list of
  /// tasks to be loaded from the repository. While the list is loading, a
  /// [CircularProgressIndicator] is displayed.
  ///
  /// Once the list is loaded, the widget is rebuilt with the list of tasks.
  ///
  Widget build(BuildContext context) {
    return Consumer<Repository<TaskEntity>>(
      builder: (BuildContext context, Repository<TaskEntity> repository,
          Widget? child) {
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 100),
          itemCount: repository.getCount() + 1,
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
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 3,
                          width: 50,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10)),
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
                        repository.deleteAll();
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                    future: repository.getAll(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return TaskItem(task: snapshot.data![index - 1]);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              );
            }
          },
        );
      },
    );
  }
}
