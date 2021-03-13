import 'package:hive/hive.dart';
import 'package:hoppy/data/model/auditable.dart';

class AuditableRepository<T extends Auditable> {
  final String _boxName;

  const AuditableRepository(this._boxName);

  Future<Box<T>> openBox() async {
    return Hive.openBox<T>(_boxName);
  }

  Future<Iterable<T>> findAll() async {
    final box = await this.openBox();
    return box.values;
  }

  Future<T> insert(T object) async {
    object.creationDate = DateTime.now();
    object.lastModifiedDate = DateTime.now();
    final box = await this.openBox();
    final id = await box.add(object);
    return box.get(id)!;
  }

  Future<T> update(T object) async {
    object.lastModifiedDate = DateTime.now();
    final box = await this.openBox();
    await box.put(object.key, object);
    return box.get(object.key)!;
  }

  Future<void> delete(T object) async {
    final box = await this.openBox();
    await box.delete(object.key);
  }

  Future<int> count() async {
    final box = await this.openBox();
    return box.length;
  }
}
