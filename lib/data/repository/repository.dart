import 'package:flutter/cupertino.dart';
import 'package:flutter_todo/data/source/source.dart';

class Repository<T> extends ChangeNotifier implements DataSource {
  final DataSource localDataSource;

  Repository({required this.localDataSource});
  @override

  /// Creates or updates a given [data] in the repository.
  ///
  /// This function simply delegates to the underlying [DataSource] and then
  /// notifies all listeners that the data has changed.
  Future createOrUpdate(data) async {
    final mainData = localDataSource.createOrUpdate(data);
    notifyListeners();
    return mainData;
  }

  @override

  /// Deletes a given [data] from the repository.
  ///
  /// This function simply delegates to the underlying [DataSource] and then
  /// notifies all listeners that the data has changed.
  Future<void> delete(data) async {
    localDataSource.delete(data);
    notifyListeners();
  }

  @override

  /// Deletes all items from the repository.
  ///
  /// This function simply delegates to the underlying [DataSource] and then
  /// notifies all listeners that the data has changed.
  Future<void> deleteAll() async {
    localDataSource.deleteAll();
    notifyListeners();
  }

  @override

  /// Deletes an item with the given [id] from the repository.
  ///
  /// This function simply delegates to the underlying [DataSource] and then
  /// notifies all listeners that the data has changed.
  Future<void> deleteById(int id) async {
    localDataSource.deleteById(id);
    notifyListeners();
  }

  @override

  /// Finds an item with the given [id] in the repository.
  ///
  /// This function simply delegates to the underlying [DataSource].
  Future findById(int id) {
    return localDataSource.findById(id);
  }

  @override

  /// Retrieves all items from the repository.
  ///
  /// This function simply delegates to the underlying [DataSource].
  Future<List> getAll() {
    return localDataSource.getAll();
  }

  @override

  /// Retrieves the total number of items from the repository.
  ///
  /// This function simply delegates to the underlying [DataSource].
  int getCount() {
    return localDataSource.getCount();
  }
}
