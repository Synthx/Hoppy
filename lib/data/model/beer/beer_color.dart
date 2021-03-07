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
}

extension BeerColorExtension on BeerColor {
  Color get color {
    switch(this) {
      case BeerColor.AMBER:
        return Colors.orange;
      case BeerColor.BLOND:
        return Colors.yellow;
      case BeerColor.BROWN:
        return Colors.brown;
      case BeerColor.DARK:
        return Colors.black;
      case BeerColor.RED:
        return Colors.red;
    }
  }

  String get name {
    switch(this) {
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
    }
  }
}
