import 'package:freezed_annotation/freezed_annotation.dart';

part 'beer_detail_state.freezed.dart';

@freezed
abstract class BeerDetailState with _$BeerDetailState {
  factory BeerDetailState({
    required bool loading,
  }) = _BeerDetailState;
}
