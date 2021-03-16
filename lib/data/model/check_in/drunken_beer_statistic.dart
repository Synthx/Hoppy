import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

part 'drunken_beer_statistic.freezed.dart';

@freezed
class DrunkenBeerStatistic with _$DrunkenBeerStatistic {
  factory DrunkenBeerStatistic({
    @Default(0) int count,
    @Default(double.nan) double averageRating,
    @Default({}) Map<ServingStyle, int> servingStyleRepartition,
    @Default({}) Map<CheckInLocation, int> locationRepartition,
    @Default([]) List<CheckIn> lastCheckIns,
  }) = _DrunkenBeerStatistic;
}
