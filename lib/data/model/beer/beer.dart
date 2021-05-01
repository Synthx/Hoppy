import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

export 'beer_color.dart';
export 'beer_country.dart';
export 'beer_dto.dart';
export 'beer_filter.dart';
export 'beer_statistic.dart';
export 'beer_style.dart';

part 'beer.freezed.dart';

@freezed
class Beer with _$Beer {
  factory Beer({
    int? id,
    required DateTime creationDate,
    required DateTime lastModifiedDate,
    required String name,
    required double degree,
    required BeerColor color,
    required BeerStyle style,
    required BeerCountry country,
    String? title,
    String? picturePath,
    @Default(0) int drinkCount,
    @Default(double.nan) double averageRating,
    @Default(false) bool favorite,
  }) = _Beer;
}
