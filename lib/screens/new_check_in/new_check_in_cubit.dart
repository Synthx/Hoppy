import 'package:bloc/bloc.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/store/store.dart';

import 'new_check_in_state.dart';

class NewCheckInCubit extends Cubit<NewCheckInState> {
  final CheckInRepository checkInRepository;
  final StatisticCubit statisticCubit;

  NewCheckInCubit({
    required this.checkInRepository,
    required this.statisticCubit,
  }) : super(NewCheckInState(
          loading: false,
        ));

  Future<void> addCheckIn(CheckIn checkIn) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final newCheckIn = await checkInRepository.insert(checkIn);
      statisticCubit.addCheckIn(newCheckIn);
      emit(state.copyWith(loading: false, checkIn: newCheckIn));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e));
    }
  }
}
