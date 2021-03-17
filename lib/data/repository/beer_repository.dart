import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';

class BeerRepository extends AuditableRepository<Beer> {
  const BeerRepository() : super('beers');

  Future<Page<Beer>> search({
    required BeerFilter filter,
    required int page,
    required int size,
  }) async {
    final box = await this.openBox();
    final beers = box.values.where((beer) =>
        beer.name.toLowerCase().contains(filter.keyword?.toLowerCase() ?? ''));
    final count = beers.length;

    return Page(
      content: beers.skip(page * size).take(size).toList(),
      number: page,
      size: size,
      totalElements: count,
      totalPages: (count / size).round(),
    );
  }

  Future<List<Beer>> findAllFavorite() async {
    final box = await this.openBox();
    return box.values.where((beer) => beer.favorite).toList();
  }

  Future<BeerStatistic> statistic() async {
    final beers = await this.findAll();

    var highestDegree = double.nan;
    if (beers.isNotEmpty) {
      var degrees = beers.map((e) => e.degree).toList();
      degrees.sort();
      highestDegree = degrees.last;
    }

    Beer? mostDrunk = null;
    if (beers.isNotEmpty) {
      var beerList = beers.where((e) => e.drinkCount > 0).toList();
      if (beerList.isNotEmpty) {
        beerList.sort((a, b) => a.drinkCount.compareTo(b.drinkCount));
        mostDrunk = beerList.last;
      }
    }

    return BeerStatistic(
      count: beers.length,
      averageDegree: beers.map((b) => b.degree).average().toPrecision(),
      highestDegree: highestDegree,
      lastAdded: beers.isNotEmpty ? beers.first : null,
      mostDrunk: mostDrunk,
    );
  }
}
