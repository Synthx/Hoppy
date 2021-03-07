import 'package:bloc/bloc.dart';
import 'package:hoppy/data/data.dart';

import 'new_check_in_state.dart';

class NewCheckInCubit extends Cubit<NewCheckInState> {
  final CheckInRepository checkInRepository;

  NewCheckInCubit({
    required this.checkInRepository,
  }) : super(NewCheckInState(
          loading: false,
          checkIn: null,
        ));

  Future<void> addCheckIn(CheckIn checkIn) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final newCheckIn = await checkInRepository.insert(checkIn);
      emit(state.copyWith(loading: false, checkIn: newCheckIn));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e));
    }
  }
}
