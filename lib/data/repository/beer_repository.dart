import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';

class BeerRepository extends BaseRepository<Beer> {
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

    return BeerStatistic(
      count: beers.length,
      averageDegree: beers.map((b) => b.degree).average().toPrecision(),
      colorRepartition: beers.map((b) => b.color).group(),
      styleRepartition: beers.map((b) => b.style).group(),
      countryRepartition: beers.map((b) => b.country).group(),
    );
  }
}
