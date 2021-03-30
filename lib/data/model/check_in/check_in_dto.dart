import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/data/model/check_in/check_in_location.dart';
import 'package:hoppy/data/model/check_in/serving_style.dart';

part 'check_in_dto.freezed.dart';

@freezed
class CheckInDto with _$CheckInDto {
  factory CheckInDto({
    required double rating,
    String? comment,
    required ServingStyle servingStyle,
    required DateTime date,
    CheckInLocation? location,
    required Beer beer,
  }) = _CheckInDto;
}
