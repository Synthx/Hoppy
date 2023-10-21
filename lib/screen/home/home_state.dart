import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required bool loading,
    required int totalBeers,
    required List<Beer> lastAddedBeers,
    required Beer? featuredBeer,
  }) = _HomeState;
}
