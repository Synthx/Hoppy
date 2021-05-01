import 'package:hive/hive.dart';
import 'package:hoppy/data/data.dart';

void setupAdapter() {
  Hive.registerAdapter(BeerCountryAdapter());
  Hive.registerAdapter(CheckInAdapter());
  Hive.registerAdapter(ServingStyleAdapter());
  Hive.registerAdapter(CheckInLocationAdapter());
}
