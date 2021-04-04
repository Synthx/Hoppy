import 'package:hive/hive.dart';

part 'beer_country.g.dart';

@HiveType(typeId: 2)
enum BeerCountry {
  @HiveField(0)
  FRANCE,
  @HiveField(1)
  BELGIUM,
  @HiveField(2)
  GERMANY,
  @HiveField(3)
  UNITED_STATES,
  @HiveField(4)
  ENGLAND,
  @HiveField(5)
  SPAIN,
  @HiveField(6)
  NETHERLANDS,
  @HiveField(7)
  SWEDEN,
  @HiveField(8)
  IRELAND,
}

extension BeerCountryExtension on BeerCountry {
  String get key {
    switch (this) {
      case BeerCountry.FRANCE:
        return 'france';
      case BeerCountry.BELGIUM:
        return 'belgium';
      case BeerCountry.GERMANY:
        return 'germany';
      case BeerCountry.UNITED_STATES:
        return 'united_states';
      case BeerCountry.ENGLAND:
        return 'england';
      case BeerCountry.SPAIN:
        return 'spain';
      case BeerCountry.NETHERLANDS:
        return 'netherlands';
      case BeerCountry.SWEDEN:
        return 'sweden';
      case BeerCountry.IRELAND:
        return 'ireland';
    }
  }

  String get flag {
    switch (this) {
      case BeerCountry.FRANCE:
        return '🇫🇷';
      case BeerCountry.BELGIUM:
        return '🇧🇪';
      case BeerCountry.GERMANY:
        return '🇩🇪';
      case BeerCountry.UNITED_STATES:
        return '🇺🇸';
      case BeerCountry.ENGLAND:
        return '🏴󠁧󠁢󠁥󠁮󠁧󠁿';
      case BeerCountry.SPAIN:
        return '🇪🇸';
      case BeerCountry.NETHERLANDS:
        return '🇳🇱';
      case BeerCountry.SWEDEN:
        return '🇸🇪';
      case BeerCountry.IRELAND:
        return '🇮🇪';
    }
  }
}
