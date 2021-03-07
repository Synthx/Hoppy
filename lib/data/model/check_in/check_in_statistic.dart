import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

part 'check_in_statistic.freezed.dart';

@freezed
class CheckInStatistic with _$CheckInStatistic {
  factory CheckInStatistic({
    required int count,
    required double averageRating,
    required Map<ServingStyle, int> servingStyleRepartition,
    required Map<CheckInLocation, int> locationRepartition,
  }) = _CheckInStatistic;
}
