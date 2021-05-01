import 'package:hoppy/data/data.dart';
import 'package:isar/isar.dart';

@Collection()
@Name('BeerStyle')
class BeerStyleEntity extends Auditable {
  @override
  int? id;
  late String key;
  @override
  late int creationDate;
  @override
  late int lastModifiedDate;
}
