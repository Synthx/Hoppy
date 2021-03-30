import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

part 'beer_dto.freezed.dart';

@freezed
class BeerDto with _$BeerDto {
  factory BeerDto({
    required String name,
    required double degree,
    required BeerColor color,
    required BeerStyle style,
    required BeerCountry country,
    String? title,
    String? picturePath,
  }) = _BeerDto;
}
