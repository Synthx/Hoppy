import 'package:hive/hive.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/data/model/auditable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

export 'beer_color.dart';
export 'beer_country.dart';
export 'beer_filter.dart';
export 'beer_statistic.dart';
export 'beer_style.dart';

part 'beer.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(explicitToJson: true)
class Beer extends Auditable {
  @HiveField(3)
  String name;

  @HiveField(4)
  double degree;

  @HiveField(5)
  BeerColor color;

  @HiveField(6)
  BeerStyle style;

  @HiveField(7)
  BeerCountry country;

  @HiveField(8)
  String? title;

  @HiveField(9)
  String? picturePath;

  @HiveField(10)
  int drinkCount;

  @HiveField(11)
  double averageRating;

  @HiveField(12)
  bool favorite;

  Beer({
    String? id,
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
          id: id,
          creationDate: DateTime.now(),
          lastModifiedDate: DateTime.now(),
        );

  factory Beer.fromJson(Map<String, dynamic> json) => _$BeerFromJson(json);

  Map<String, dynamic> toJson() => _$BeerToJson(this);
}
