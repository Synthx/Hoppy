import 'package:hive/hive.dart';
import 'package:hoppy/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

export 'beer_color.dart';
export 'beer_country.dart';
export 'beer_filter.dart';
export 'beer_statistic.dart';
export 'beer_style.dart';

part 'beer.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(explicitToJson: true)
class Beer extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double degree;

  @HiveField(2)
  BeerColor color;

  @HiveField(3)
  BeerStyle style;

  @HiveField(4)
  BeerCountry country;

  @HiveField(5)
  String? title;

  @HiveField(6)
  String? picturePath;

  @HiveField(7)
  int? drinkCount;

  @HiveField(8)
  double? averageRating;

  @HiveField(9)
  bool favorite;

  @HiveField(10)
  DateTime creationDate;

  @HiveField(11)
  DateTime lastModifiedDate;

  Beer({
    required this.name,
    required this.degree,
    required this.color,
    required this.style,
    required this.country,
    required this.creationDate,
    required this.lastModifiedDate,
    this.title,
    this.picturePath,
    this.drinkCount,
    this.averageRating,
    this.favorite = false,
  });

  factory Beer.fromJson(Map<String, dynamic> json) => _$BeerFromJson(json);

  Map<String, dynamic> toJson() => _$BeerToJson(this);
}
