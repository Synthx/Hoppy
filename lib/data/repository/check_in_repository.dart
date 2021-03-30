import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:uuid/uuid.dart';

class CheckInRepository extends AuditableRepository<CheckIn> {
  final BeerRepository beerRepository;

  const CheckInRepository({
    required this.beerRepository,
  }) : super('check-ins');

  Future<CheckInStatistic> statistic() async {
    final checkIns = await findAll();
    final drunkenBeers = checkIns.map((c) => c.beer);

    return CheckInStatistic(
      count: checkIns.length,
      averageRating: checkIns.map((c) => c.rating).average(),
      servingStyleRepartition: checkIns.map((c) => c.servingStyle).group(),
      locationRepartition: checkIns
          .where((e) => e.location != null)
          .map((e) => e.location!)
          .group(),
      drunkenColorRepartition: drunkenBeers.map((b) => b.color).group(),
      drunkenStyleRepartition: drunkenBeers.map((b) => b.style).group(),
      drunkenCountryRepartition: drunkenBeers.map((b) => b.country).group(),
      lastAdded: checkIns.isNotEmpty ? checkIns.last : null,
    );
  }

  Future<DrunkenBeerStatistic> beerStatistic(Beer beer) async {
    final checkIns =
        (await findAll()).where((e) => e.beer.id == beer.id).toList();

    return DrunkenBeerStatistic(
      count: checkIns.length,
      averageRating: checkIns.map((e) => e.rating).average(),
      servingStyleRepartition: checkIns.map((e) => e.servingStyle).group(),
      locationRepartition: checkIns
          .where((e) => e.location != null)
          .map((e) => e.location!)
          .group(),
      lastCheckIns: checkIns.take(4).toList(),
    );
  }

  Future<void> deleteAssociated(Beer beer) async {
    final box = await openBox();
    final checkIns = box.values.where((e) => e.beer.id == beer.id);
    for (var checkIn in checkIns) {
      await delete(checkIn.id!);
    }
  }

  @override
  Future<CheckIn> insert(CheckIn object) async {
    final id = Uuid().v1();
    final beer = object.beer;
    await beerRepository.update(beer.copyWith(
      drinkCount: beer.drinkCount + 1,
      averageRating: beer.averageRating.average(object.rating),
    ));

    final box = await openBox();
    await box.put(
        id,
        object.copyWith(
          id: id,
          creationDate: DateTime.now(),
          lastModifiedDate: DateTime.now(),
        ));
    return box.get(id)!;
  }

  @override
  Future<CheckIn> update(CheckIn object) async {
    final box = await openBox();
    await box.put(
        object.id,
        object.copyWith(
          lastModifiedDate: DateTime.now(),
        ));
    return box.get(object.id)!;
  }
}
