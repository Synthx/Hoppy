import 'package:bloc/bloc.dart';

class StoreObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('${bloc.runtimeType}: ${transition.nextState}');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType}: $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
