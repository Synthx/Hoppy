import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/data/model/auditable.dart';

export 'beer_color.dart';
export 'beer_country.dart';
export 'beer_dto.dart';
export 'beer_filter.dart';
export 'beer_statistic.dart';
export 'beer_style.dart';

part 'beer.freezed.dart';
part 'beer.g.dart';

@freezed
class Beer with _$Beer {
  @Implements(Auditable)
  @HiveType(typeId: 0, adapterName: 'BeerAdapter')
  factory Beer({
    @HiveField(0) String? id,
    @HiveField(1) required DateTime creationDate,
    @HiveField(2) required DateTime lastModifiedDate,
    @HiveField(3) required String name,
    @HiveField(4) required double degree,
    @HiveField(5) required BeerColor color,
    @HiveField(6) required BeerStyle style,
    @HiveField(7) required BeerCountry country,
    @HiveField(8) String? title,
    @HiveField(9) String? picturePath,
    @HiveField(10) @Default(0) int drinkCount,
    @HiveField(11) @Default(double.nan) double averageRating,
    @HiveField(12) @Default(false) bool favorite,
  }) = _Beer;
}
