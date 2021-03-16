import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

part 'edit_beer_state.freezed.dart';

@freezed
class EditBeerState with _$EditBeerState {
  factory EditBeerState({
    required bool loading,
    Beer? beer,
    Object? error,
  }) = _EditBeerState;
}
