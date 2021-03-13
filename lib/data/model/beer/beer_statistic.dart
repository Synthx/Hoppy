import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

part 'beer_statistic.freezed.dart';

@freezed
class BeerStatistic with _$BeerStatistic {
  factory BeerStatistic({
    @Default(0) int count,
    @Default(double.nan) double averageDegree,
    @Default(double.nan) double highestDegree,
    Beer? lastAdded,
    Beer? mostDrunk,
  }) = _BeerStatistic;
}
