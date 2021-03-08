import 'package:hive/hive.dart';

part 'serving_style.g.dart';

@HiveType(typeId: 5)
enum ServingStyle {
  @HiveField(0)
  DRAFT,
  @HiveField(1)
  BOTTLE,
  @HiveField(2)
  CAN,
  @HiveField(3)
  OTHER,
}

extension ServingStyleExtension on ServingStyle {
  String get name {
    switch (this) {
      case ServingStyle.DRAFT:
        return 'Pression';
      case ServingStyle.BOTTLE:
        return 'Bouteille';
      case ServingStyle.CAN:
        return 'Canette';
      case ServingStyle.OTHER:
        return 'Autre';
    }
  }
}
