import 'package:bloc/bloc.dart';
import 'package:hoppy/screens/main/main.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenState());

  void changePage(int pageIndex) {
    emit(state.copyWith(pageIndex: pageIndex));
  }

  void resetPageIndex() {
    emit(state.copyWith(pageIndex: null));
  }
}
