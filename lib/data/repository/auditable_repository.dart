import 'package:hive/hive.dart';

abstract class AuditableRepository<T> {
  final String _boxName;

  const AuditableRepository(this._boxName);

  Future<Box<T>> openBox() async {
    return Hive.openBox<T>(_boxName);
  }

  Future<T?> find(String id) async {
    final box = await openBox();
    return box.get(id);
  }

  Future<Iterable<T>> findAll() async {
    final box = await openBox();
    return box.values;
  }

  Future<T> insert(T object);

  Future<T> update(T object);

  Future<void> delete(String id) async {
    final box = await openBox();
    await box.delete(id);
  }

  Future<int> count() async {
    final box = await openBox();
    return box.length;
  }
}
