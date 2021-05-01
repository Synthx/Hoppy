import 'package:get_it/get_it.dart';
import 'package:hoppy/data/data.dart';
import 'package:isar/isar.dart';

final getIt = GetIt.instance;

void setupInjector(Isar isar) {
  // repositories
  getIt.registerLazySingleton(() => SettingsRepository());
  getIt.registerLazySingleton(() => BeerColorRepository(
        isar: isar,
      ));
  getIt.registerLazySingleton(() => BeerStyleRepository(
        isar: isar,
      ));
  getIt.registerLazySingleton(() => BeerRepository());
  getIt.registerLazySingleton(() => CheckInRepository(
        beerRepository: getIt(),
      ));
  // services
  getIt.registerLazySingleton(() => BeerService(
        beerRepository: getIt(),
      ));
  getIt.registerLazySingleton(() => BeerColorService());
  // providers
  getIt.registerLazySingleton(() => BeerColorProvider(
        beerColorRepository: getIt(),
        beerColorService: getIt(),
      ));
}
