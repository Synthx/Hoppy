import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

part 'beer_filter.freezed.dart';

@freezed
class BeerFilter with _$BeerFilter {
  factory BeerFilter({
    String? keyword,
    @Default([]) List<BeerColor> colors,
    @Default([]) List<BeerStyle> styles,
    @Default([]) List<BeerCountry> countries,
    @Default(RangeValues(0, 100)) RangeValues degreeRange,
    bool? havePicture,
  }) = _BeerFilter;
}
