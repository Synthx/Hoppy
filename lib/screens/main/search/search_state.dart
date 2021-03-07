import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  factory SearchState({
    required BeerFilter filter,
    required List<Beer> beers,
    required bool loading,
    @Default(0) int page,
    @Default(25) int size,
  }) = _SearchState;
}
