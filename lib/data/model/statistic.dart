import 'package:freezed_annotation/freezed_annotation.dart';

import 'model.dart';

part 'statistic.freezed.dart';

@freezed
class Statistic with _$Statistic {
  factory Statistic({
    @Default(0) int beerCount,
    @Default(0) int checkInCount,
    @Default(double.nan) double beerAverageDegree,
    @Default(double.nan) double checkInAverageRating,
    @Default({}) Map<BeerColor, int> beerColorRepartition,
    @Default({}) Map<BeerStyle, int> beerStyleRepartition,
    @Default({}) Map<ServingStyle, int> checkInServingStyleRepartition,
    @Default({}) Map<CheckInLocation, int> checkInLocationRepartition,
  }) = _Statistic;
}
