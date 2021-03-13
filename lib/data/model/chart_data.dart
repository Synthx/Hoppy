import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_data.freezed.dart';

@freezed
class ChartData<T> with _$ChartData<T> {
  factory ChartData({
    required T key,
    required int value,
  }) = _ChartData<T>;
}
