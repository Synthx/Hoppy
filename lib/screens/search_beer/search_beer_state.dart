import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

part 'search_beer_state.freezed.dart';

@freezed
class SearchBeerState with _$SearchBeerState {
  factory SearchBeerState({
    required BeerFilter filter,
    required bool loading,
    required int maxSize,
    List<Beer>? beers,
    @Default(0) int? page,
    @Default(20) int? size,
  }) = _SearchBeerState;
}
