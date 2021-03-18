import 'package:hive/hive.dart';
import 'package:hoppy/data/model/auditable.dart';
import 'package:uuid/uuid.dart';

class AuditableRepository<T extends Auditable> {
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

  Future<T> insert(T object) async {
    object.id = Uuid().v1();
    object.creationDate = DateTime.now();
    object.lastModifiedDate = DateTime.now();
    final box = await openBox();
    await box.put(object.id, object);
    return box.get(object.id)!;
  }

  Future<T> update(T object) async {
    object.lastModifiedDate = DateTime.now();
    final box = await openBox();
    await box.put(object.id, object);
    return box.get(object.id)!;
  }

  Future<void> delete(String id) async {
    final box = await openBox();
    await box.delete(id);
  }

  Future<int> count() async {
    final box = await openBox();
    return box.length;
  }
}
