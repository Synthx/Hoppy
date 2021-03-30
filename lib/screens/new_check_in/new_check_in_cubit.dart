import 'package:bloc/bloc.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/data/model/check_in/check_in_dto.dart';
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

  Future<void> addCheckIn(CheckInDto checkInDto) async {
    emit(state.copyWith(loading: true, error: null));

    // create check-in entity
    final checkIn = CheckIn(
      creationDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      rating: checkInDto.rating,
      servingStyle: checkInDto.servingStyle,
      date: checkInDto.date,
      beer: checkInDto.beer,
    );

    final newCheckIn = await checkInRepository.insert(checkIn);
    statisticCubit.addCheckIn(newCheckIn);
    emit(state.copyWith(loading: false, checkIn: newCheckIn));
  }
}
