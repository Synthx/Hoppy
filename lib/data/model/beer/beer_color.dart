import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'beer_color.g.dart';

@HiveType(typeId: 1)
enum BeerColor {
  @HiveField(0)
  BLOND,
  @HiveField(1)
  AMBER,
  @HiveField(2)
  BROWN,
  @HiveField(3)
  DARK,
  @HiveField(4)
  RED,
  @HiveField(5)
  WHITE,
}

extension BeerColorExtension on BeerColor {
  Color get color {
    switch (this) {
      case BeerColor.AMBER:
        return Color(0xFFF26A38);
      case BeerColor.BLOND:
        return Color(0xFFF6D02E);
      case BeerColor.BROWN:
        return Color(0xFFA94126);
      case BeerColor.DARK:
        return Color(0xFF1E0F0C);
      case BeerColor.RED:
        return Color(0xFFD52027);
      case BeerColor.WHITE:
        return Color(0xFFFBDEA6);
    }
  }

  String get key {
    switch (this) {
      case BeerColor.AMBER:
        return 'amber';
      case BeerColor.BLOND:
        return 'blond';
      case BeerColor.BROWN:
        return 'brown';
      case BeerColor.DARK:
        return 'dark';
      case BeerColor.RED:
        return 'red';
      case BeerColor.WHITE:
        return 'white';
    }
  }
}
