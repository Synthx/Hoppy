import 'package:hive/hive.dart';

class BaseRepository<T extends HiveObject> {
  final String _boxName;

  const BaseRepository(this._boxName);

  Future<Box<T>> openBox() async {
    return Hive.openBox<T>(_boxName);
  }

  Future<List<T>> findAll() async {
    final box = await this.openBox();
    return box.values.toList();
  }

  Future<T> insert(T object) async {
    final box = await this.openBox();
    final id = await box.add(object);
    return box.get(id)!;
  }

  Future<T> update(T object) async {
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
