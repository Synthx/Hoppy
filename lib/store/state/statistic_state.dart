import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

part 'statistic_state.freezed.dart';

@freezed
class StatisticState with _$StatisticState {
  factory StatisticState({
    required bool loading,
    required BeerStatistic beerStatistic,
    required CheckInStatistic checkInStatistic,
  }) = _StatisticState;
}
