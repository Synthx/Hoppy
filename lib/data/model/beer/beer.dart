import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';

export 'beer_color.dart';
export 'beer_style.dart';

part 'beer.freezed.dart';

part 'beer.g.dart';

@freezed
class Beer with _$Beer {
  const factory Beer({
    @JsonKey(name: '_id') required String id,
    required String title,
    required String content,
    required double abv,
    required BeerColor color,
    required BeerStyle style,
    required Country country,
    required String website,
    required String description,
    @ColorConverter() Color? backgroundColor,
    @ColorConverter() Color? textColor,
    String? picture,
  }) = _Beer;

  factory Beer.fromJson(Map<String, dynamic> json) => _$BeerFromJson(json);
}
