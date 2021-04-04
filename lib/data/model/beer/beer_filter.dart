import 'package:freezed_annotation/freezed_annotation.dart';

part 'beer_filter.freezed.dart';

@freezed
class BeerFilter with _$BeerFilter {
  factory BeerFilter({
    String? keyword,
  }) = _BeerFilter;
}
