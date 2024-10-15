abstract class DataSource<T> {
  Future<List<T>> getAll();
  Future<T> findById(int id);
  Future<void> deleteAll();
  Future<void> deleteById(int id);
  Future<void> delete(T data);
  Future<T> createOrUpdate(T data);
}
