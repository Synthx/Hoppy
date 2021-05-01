import 'package:freezed_annotation/freezed_annotation.dart';

part 'beer_style.freezed.dart';

@freezed
class BeerStyle with _$BeerStyle {
  factory BeerStyle({
    int? id,
    required String key,
    required DateTime creationDate,
    required DateTime lastModifiedDate,
  }) = _BeerStyle;
}
