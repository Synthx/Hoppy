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
  String get name {
    switch (this) {
      case BeerCountry.FRANCE:
        return 'France';
      case BeerCountry.BELGIUM:
        return 'Belgique';
      case BeerCountry.GERMANY:
        return 'Allemagne';
      case BeerCountry.UNITED_STATES:
        return 'Etats-unis';
      case BeerCountry.ENGLAND:
        return 'Angleterre';
      case BeerCountry.SPAIN:
        return 'Espagne';
      case BeerCountry.NETHERLANDS:
        return 'Pays-bas';
      case BeerCountry.SWEDEN:
        return 'Suède';
      case BeerCountry.IRELAND:
        return 'Irelande';
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
