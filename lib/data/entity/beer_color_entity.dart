import 'package:hoppy/data/data.dart';
import 'package:isar/isar.dart';

@Collection()
@Name('BeerColor')
class BeerColorEntity extends Auditable {
  @override
  int? id;
  late String key;
  late String color;
  @override
  late int creationDate;
  @override
  late int lastModifiedDate;
}
