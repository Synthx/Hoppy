import 'package:bloc/bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:logging/logging.dart';

class StoreObserver extends BlocObserver {
  final _logger = Logger('Store');

  @override
  void onChange(BlocBase bloc, Change change) {
    _logger.info('${bloc.runtimeType} : ${change.nextState}');
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    ErrorHandler.catchError(error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
