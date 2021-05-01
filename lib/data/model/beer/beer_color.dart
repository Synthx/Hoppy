import 'package:freezed_annotation/freezed_annotation.dart';

part 'beer_color.freezed.dart';

@freezed
class BeerColor with _$BeerColor {
  factory BeerColor({
    int? id,
    required String key,
    required String color,
    required DateTime creationDate,
    required DateTime lastModifiedDate,
  }) = _BeerColor;
}
