import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

part 'add_beer_state.freezed.dart';

@freezed
class AddBeerState with _$AddBeerState {
  factory AddBeerState({
    required bool loading,
    Beer? beer,
    Object? error,
  }) = _AddBeerState;
}
