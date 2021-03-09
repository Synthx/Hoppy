import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

part 'search_beer_state.freezed.dart';

@freezed
class SearchBeerState with _$SearchBeerState {
  factory SearchBeerState({
    required BeerFilter filter,
    required bool loading,
    required int page,
    required int size,
    List<Beer>? beers,
    int? totalElements,
  }) = _SearchBeerState;
}
