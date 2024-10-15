import 'package:flutter_todo/data/entity/data.dart';
import 'package:flutter_todo/data/source/source.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveTaskSource implements DataSource<TaskEntity> {
  final Box<TaskEntity> box;

  HiveTaskSource({required this.box});
  @override

  /// Create a new task or update an existing one.
  ///
  /// If the task is new, it will be added to the box and its [TaskEntity.id]
  /// property will be set to the ID of the new record.
  ///
  /// If the task is existing, it will be updated in the box.
  ///
  Future<TaskEntity> createOrUpdate(TaskEntity data) async {
    if (data.isInBox) {
      data.save();
    } else {
      data.id = await box.add(data);
    }
    return data;
  }

  @override

  /// Deletes a task from the box.
  ///
  /// This is a convenience method which simply calls [TaskEntity.delete] on
  /// the given [TaskEntity].
  ///
  Future<void> delete(TaskEntity data) async {
    return data.delete();
  }

  @override

  /// Deletes all tasks from the box.
  ///
  /// This is a convenience method which simply calls [Box.clear] on the box.
  ///
  /// The return value is a [Future] that resolves to the number of records
  /// deleted.
  ///
  Future<Future<int>> deleteAll() async {
    return box.clear();
  }

  @override

  /// Deletes a task from the box with the given [id].
  ///
  /// This is a convenience method which simply calls [Box.delete] on the box
  /// with the given [id].
  ///
  /// The return value is a [Future] that resolves to [void] when the record has
  /// been deleted.
  ///
  Future<void> deleteById(int id) async {
    return box.delete(id);
  }

  @override

  /// Finds a task in the box by its id.
  ///
  /// This method is a convenience wrapper around [Box.values] which returns a
  /// [Future] that resolves to the task with the given [id]. If no task with
  /// that id exists, it throws a [StateError].
  ///
  /// The underlying implementation uses [Box.values.firstWhere] to search the
  /// box. This means that if multiple tasks have the same id, only the first
  /// one is returned and the other ones are ignored.
  Future<TaskEntity> findById(int id) async {
    //return box.get(id)!;
    return box.values.firstWhere((element) => element.id == id);
  }

  @override

  /// Finds all tasks in the box.
  ///
  /// This method returns a [Future] that resolves to a [List] of all the tasks
  /// in the box.
  Future<List<TaskEntity>> getAll() async {
    return box.values.toList();
  }

  // Future<List<TaskEntity>> getAll(String searchKeyWord = '') async {
  //   return box.values.where((task) => task.name.contains(searchKeyWord)).toList();
  // }
  @override

  /// Returns the number of tasks in the box.
  int getCount() {
    return box.values.length;
  }
}
