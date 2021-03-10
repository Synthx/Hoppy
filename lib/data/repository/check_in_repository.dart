import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';

class CheckInRepository extends AuditableRepository<CheckIn> {
  final BeerRepository beerRepository;

  const CheckInRepository({
    required this.beerRepository,
  }) : super('check-ins');

  Future<CheckInStatistic> statistic() async {
    final checkIns = await this.findAll();

    return CheckInStatistic(
      count: checkIns.length,
      averageRating: checkIns.map((c) => c.rating).average(),
      servingStyleRepartition: checkIns.map((c) => c.servingStyle).group(),
      locationRepartition: checkIns
          .where((e) => e.location != null)
          .map((e) => e.location!)
          .group(),
      lastAdded: checkIns.isNotEmpty ? checkIns.last : null,
    );
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
