import 'package:hive/hive.dart';

abstract class Auditable extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  DateTime? creationDate;
  @HiveField(2)
  DateTime? lastModifiedDate;

  Auditable({
    this.id,
    this.creationDate,
    this.lastModifiedDate,
  });
}
