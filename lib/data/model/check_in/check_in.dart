import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/data/model/auditable.dart';
import 'package:hoppy/data/model/check_in/serving_style.dart';

import 'check_in_location.dart';
import 'position.dart';

export 'check_in_dto.dart';
export 'check_in_location.dart';
export 'check_in_statistic.dart';
export 'drunken_beer_statistic.dart';
export 'position.dart';
export 'serving_style.dart';

part 'check_in.freezed.dart';
part 'check_in.g.dart';

@freezed
class CheckIn with _$CheckIn {
  @Implements(Auditable)
  @HiveType(typeId: 4, adapterName: 'CheckInAdapter')
  factory CheckIn({
    @HiveField(0) String? id,
    @HiveField(1) required DateTime creationDate,
    @HiveField(2) required DateTime lastModifiedDate,
    @HiveField(3) required double rating,
    @HiveField(4) String? comment,
    @HiveField(5) required ServingStyle servingStyle,
    @HiveField(6) required DateTime date,
    @HiveField(7) Position? position,
    @HiveField(8) required Beer beer,
    @HiveField(9) CheckInLocation? location,
  }) = _CheckIn;
}
