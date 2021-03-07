import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

part 'beer_statistic.freezed.dart';

@freezed
abstract class BeerStatistic with _$BeerStatistic {
  factory BeerStatistic({
    required int count,
    required double averageDegree,
    required Map<BeerColor, int> colorRepartition,
    required Map<BeerStyle, int> styleRepartition,
    required Map<BeerCountry, int> countryRepartition,
  }) = _BeerStatistic;
}
