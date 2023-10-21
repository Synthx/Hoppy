import 'package:get_it/get_it.dart';
import 'package:hoppy/data/data.dart';

final getIt = GetIt.instance;

void setupInjector() {
  getIt.registerLazySingleton(() => BeerService());
}
