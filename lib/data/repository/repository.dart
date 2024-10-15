import 'package:flutter_todo/data/source/source.dart';

class Repository<T> implements DataSource {
  final DataSource localDataSource;

  Repository({required this.localDataSource});
  @override
  Future createOrUpdate(data) {
    return localDataSource.createOrUpdate(data);
  }

  @override
  Future<void> delete(data) {
    return localDataSource.delete(data);
  }

  @override
  Future<void> deleteAll() {
    return localDataSource.deleteAll();
  }

  @override
  Future<void> deleteById(int id) {
    return localDataSource.deleteById(id);
  }

  @override
  Future findById(int id) {
    return localDataSource.findById(id);
  }

  @override
  Future<List> getAll() {
    return localDataSource.getAll();
  }
}
