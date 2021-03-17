import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  factory SearchState({
    required List<Beer> beers,
    required BeerFilter filter,
    required bool loading,
    required int page,
    required int size,
    int? totalElements,
  }) = _SearchState;
}
