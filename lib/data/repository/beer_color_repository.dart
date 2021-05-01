import 'package:hoppy/data/data.dart';
import 'package:hoppy/isar.g.dart';
import 'package:isar/isar.dart';

class BeerColorRepository extends AuditableRepository<BeerColorEntity> {
  @override
  final Isar isar;

  BeerColorRepository({
    required this.isar,
  }) : super(isar, isar.beerColorEntitys);
}
