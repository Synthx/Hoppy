import 'package:get_it/get_it.dart';
import 'package:hoppy/data/data.dart';

final getIt = GetIt.instance;

void setupInjector() {
  // repositories
  getIt.registerLazySingleton(() => SettingsRepository());
  getIt.registerLazySingleton(() => BeerRepository());
  getIt.registerLazySingleton(() => CheckInRepository(
    beerRepository: getIt(),
  ));
  getIt.registerLazySingleton(() => FavoriteBeerRepository());
}
