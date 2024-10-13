import 'package:flutter/material.dart';
import 'package:flutter_todo/data/data.dart';
import 'package:flutter_todo/widgets/check_box.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override

  /// A widget for a single task in the list of tasks.
  ///
  /// It has a checkbox on the left, and the task name on the right.
  ///
  /// The checkbox is interactive, and tapping on it will change the task's
  /// [isCompleted] property.
  ///
  /// The widget also displays a strikethrough over the task's name if the task
  /// is completed.
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          widget.task.isCompleted = !widget.task.isCompleted;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        height: 84,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              children: [
                MyChecBox(
                  isChecked: widget.task.isCompleted,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    widget.task.name,
                    style: TextStyle(
                      fontSize: 20,
                      decoration: widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
