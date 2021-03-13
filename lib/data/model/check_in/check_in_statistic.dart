import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

part 'check_in_statistic.freezed.dart';

@freezed
class CheckInStatistic with _$CheckInStatistic {
  factory CheckInStatistic({
    @Default(0) int count,
    @Default(double.nan) double averageRating,
    @Default({}) Map<ServingStyle, int> servingStyleRepartition,
    @Default({}) Map<CheckInLocation, int> locationRepartition,
    @Default({}) Map<BeerColor, int> drunkenColorRepartition,
    @Default({}) Map<BeerStyle, int> drunkenStyleRepartition,
    @Default({}) Map<BeerCountry, int> drunkenCountryRepartition,
    CheckIn? lastAdded,
  }) = _CheckInStatistic;
}
