import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'position.g.dart';

@HiveType(typeId: 6)
@JsonSerializable(explicitToJson: true)
class Position {
  @HiveField(0)
  double latitude;

  @HiveField(1)
  double longitude;

  Position({
    required this.latitude,
    required this.longitude,
  });

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);

  Map<String, dynamic> toJson() => _$PositionToJson(this);
}
