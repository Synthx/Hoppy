import 'package:hive/hive.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/data/model/check_in/serving_style.dart';
import 'package:json_annotation/json_annotation.dart';

import 'check_in_location.dart';
import 'position.dart';

export 'check_in_location.dart';
export 'check_in_statistic.dart';
export 'position.dart';
export 'serving_style.dart';

part 'check_in.g.dart';

@HiveType(typeId: 4)
@JsonSerializable(explicitToJson: true)
class CheckIn extends HiveObject {
  @HiveField(0)
  double rating;

  @HiveField(1)
  String? description;

  @HiveField(2)
  ServingStyle servingStyle;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  Position? position;

  @HiveField(5)
  Beer beer;

  @HiveField(6)
  CheckInLocation? location;

  CheckIn({
    required this.rating,
    this.description,
    required this.servingStyle,
    required this.date,
    this.location,
    required this.beer,
  });
}
