import 'package:hive/hive.dart';

abstract class Auditable extends HiveObject {
  @HiveField(0)
  DateTime creationDate;
  @HiveField(1)
  DateTime lastModifiedDate;

  Auditable({
    required this.creationDate,
    required this.lastModifiedDate,
  });
}
