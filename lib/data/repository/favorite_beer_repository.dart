import 'package:hoppy/data/data.dart';

class FavoriteBeerRepository extends AuditableRepository<Beer> {
  const FavoriteBeerRepository() : super('favorite-beers');
}
