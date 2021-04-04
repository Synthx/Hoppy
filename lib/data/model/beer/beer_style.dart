import 'package:hive/hive.dart';

part 'beer_style.g.dart';

@HiveType(typeId: 3)
enum BeerStyle {
  @HiveField(0)
  IPA,
  @HiveField(1)
  TRIPEL,
  @HiveField(2)
  QUADRUPEL,
  @HiveField(3)
  PALE_ALE,
  @HiveField(4)
  STRONG_ALE,
  @HiveField(5)
  STOUT,
}

extension BeerStyleExtension on BeerStyle {
  String get key {
    switch (this) {
      case BeerStyle.IPA:
        return 'ipa';
      case BeerStyle.TRIPEL:
        return 'tripel';
      case BeerStyle.QUADRUPEL:
        return 'quadrupel';
      case BeerStyle.PALE_ALE:
        return 'pale_ale';
      case BeerStyle.STRONG_ALE:
        return 'strong_ale';
      case BeerStyle.STOUT:
        return 'stout';
    }
  }
}
