import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

part 'new_check_in_state.freezed.dart';

@freezed
class NewCheckInState with _$NewCheckInState {
  const factory NewCheckInState({
    required bool loading,
    CheckIn? checkIn,
    Object? error,
  }) = _NewCheckInState;
}
