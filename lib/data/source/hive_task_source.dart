import 'package:flutter_todo/data/entity/data.dart';
import 'package:flutter_todo/data/source/source.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveTaskSource implements DataSource<TaskEntity> {
  final Box<TaskEntity> box;

  HiveTaskSource({required this.box});
  @override
  Future<TaskEntity> createOrUpdate(TaskEntity data) async {
    if (data.isInBox) {
      data.save();
    } else {
      data.id = await box.add(data);
    }
    return data;
  }

  @override
  Future<void> delete(TaskEntity data) async {
    return data.delete();
  }

  @override
  Future<Future<int>> deleteAll() async {
    return box.clear();
  }

  @override
  Future<void> deleteById(int id) async {
    return box.delete(id);
  }

  @override
  Future<TaskEntity> findById(int id) async {
    //return box.get(id)!;
    return box.values.firstWhere((element) => element.id == id);
  }

  @override
  Future<List<TaskEntity>> getAll() async {
    return box.values.toList();
  }
}
