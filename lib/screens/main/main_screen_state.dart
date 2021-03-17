import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_screen_state.freezed.dart';

@freezed
class MainScreenState with _$MainScreenState {
  factory MainScreenState({
    int? pageIndex,
  }) = _MainScreenState;
}
