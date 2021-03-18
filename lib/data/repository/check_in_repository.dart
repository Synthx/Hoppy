import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';

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
      await checkIn.delete();
    }
  }

  @override
  Future<CheckIn> insert(CheckIn object) async {
    final beer = object.beer;
    beer.drinkCount += 1;
    beer.averageRating = beer.averageRating.average(object.rating);
    await beerRepository.update(beer);

    return super.insert(object);
  }
}
