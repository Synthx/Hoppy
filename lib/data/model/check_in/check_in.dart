import 'package:hive/hive.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/data/model/auditable.dart';
import 'package:hoppy/data/model/check_in/serving_style.dart';
import 'package:json_annotation/json_annotation.dart';

import 'check_in_location.dart';
import 'position.dart';

export 'check_in_location.dart';
export 'check_in_statistic.dart';
export 'drunken_beer_statistic.dart';
export 'position.dart';
export 'serving_style.dart';

part 'check_in.g.dart';

@HiveType(typeId: 4)
@JsonSerializable(explicitToJson: true)
class CheckIn extends Auditable {
  @HiveField(2)
  double rating;

  @HiveField(3)
  String? description;

  @HiveField(4)
  ServingStyle servingStyle;

  @HiveField(5)
  DateTime date;

  @HiveField(6)
  Position? position;

  @HiveField(7)
  Beer beer;

  @HiveField(8)
  CheckInLocation? location;

  CheckIn({
    required this.rating,
    this.description,
    required this.servingStyle,
    required this.date,
    this.location,
    required this.beer,
  }) : super(
          creationDate: DateTime.now(),
          lastModifiedDate: DateTime.now(),
        );
}
