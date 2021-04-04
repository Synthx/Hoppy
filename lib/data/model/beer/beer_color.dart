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

  String get name {
    switch (this) {
      case BeerColor.AMBER:
        return 'Ambrée';
      case BeerColor.BLOND:
        return 'Blonde';
      case BeerColor.BROWN:
        return 'Brune';
      case BeerColor.DARK:
        return 'Noire';
      case BeerColor.RED:
        return 'Rouge';
      case BeerColor.WHITE:
        return 'Blanche';
    }
  }

  String get fileName {
    switch (this) {
      case BeerColor.AMBER:
        return 'amber.jpg';
      case BeerColor.BLOND:
        return 'blond.jpg';
      case BeerColor.BROWN:
        return 'brown.jpg';
      case BeerColor.DARK:
        return 'dark.jpg';
      case BeerColor.RED:
        return 'red.jpg';
      case BeerColor.WHITE:
        return 'white.jpg';
    }
  }
}
