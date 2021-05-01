import 'package:hoppy/data/data.dart';
import 'package:hoppy/isar.g.dart';
import 'package:isar/isar.dart';

class BeerStyleRepository extends AuditableRepository<BeerStyleEntity> {
  @override
  final Isar isar;

  BeerStyleRepository({
    required this.isar,
  }) : super(isar, isar.beerStyleEntitys);
}
