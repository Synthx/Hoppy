import 'package:hive/hive.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/data/model/auditable.dart';
import 'package:json_annotation/json_annotation.dart';

export 'beer_color.dart';
export 'beer_country.dart';
export 'beer_filter.dart';
export 'beer_statistic.dart';
export 'beer_style.dart';

part 'beer.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(explicitToJson: true)
class Beer extends Auditable {
  @HiveField(2)
  String name;

  @HiveField(3)
  double degree;

  @HiveField(4)
  BeerColor color;

  @HiveField(5)
  BeerStyle style;

  @HiveField(6)
  BeerCountry country;

  @HiveField(7)
  String? title;

  @HiveField(8)
  String? picturePath;

  @HiveField(9)
  int drinkCount;

  @HiveField(10)
  double averageRating;

  @HiveField(11)
  bool favorite;

  Beer({
    required this.name,
    required this.degree,
    required this.color,
    required this.style,
    required this.country,
    this.title,
    this.picturePath,
    this.drinkCount = 0,
    this.averageRating = double.nan,
    this.favorite = false,
  }) : super(
          creationDate: DateTime.now(),
          lastModifiedDate: DateTime.now(),
        );

  factory Beer.fromJson(Map<String, dynamic> json) => _$BeerFromJson(json);

  Map<String, dynamic> toJson() => _$BeerToJson(this);
}
