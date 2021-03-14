import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

part 'favorite_state.freezed.dart';

@freezed
class FavoriteState with _$FavoriteState {
  factory FavoriteState({
    required List<Beer> beers,
    required bool loading,
  }) = _FavoriteState;
}
