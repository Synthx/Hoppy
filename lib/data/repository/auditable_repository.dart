import 'dart:typed_data';

import 'package:hoppy/data/data.dart';
import 'package:hoppy/data/model/synchronization_information.dart';
import 'package:isar/isar.dart';

abstract class AuditableRepository<T extends Auditable> {
  final Isar isar;
  final IsarCollection<T> collection;

  const AuditableRepository(this.isar, this.collection);

  Future<T?> find(int id) async {
    return collection.get(id);
  }

  Future<List<T>> findAll() async {
    return collection.where().findAll();
  }

  Future<T> insert(T object) async {
    var id = await count() + 1;
    var now = DateTime.now().millisecondsSinceEpoch;
    object
      ..id = id
      ..creationDate = now
      ..lastModifiedDate = now;

    await isar.writeTxn((isar) async {
      await collection.put(object);
    });

    return find(id) as T;
  }

  Future<T> update(T object) async {
    var now = DateTime.now().millisecondsSinceEpoch;
    object.lastModifiedDate = now;

    await isar.writeTxn((isar) async {
      await collection.put(object);
    });

    return find(object.id!) as T;
  }

  Future<void> delete(int id) async {
    await isar.writeTxn((_) async {
      await collection.delete(id);
    });
  }

  Future<void> deleteAll() async {
    await isar.writeTxn((_) async {
      await collection.where().deleteAll();
    });
  }

  Future<int> count() async {
    return collection.where().count();
  }

  Future<SynchronizationInformation<T>> import(Uint8List bytes) async {
    await isar.writeTxn((_) async {
      await collection.importJsonRaw(bytes);
    });

    return SynchronizationInformation(
      data: await findAll(),
      lastModificationDate: null,
    );
  }
}
