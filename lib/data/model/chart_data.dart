import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_data.freezed.dart';

@freezed
class ChartData with _$ChartData {
  factory ChartData({
    required String label,
    required int value,
  }) = _ChartData;
}
