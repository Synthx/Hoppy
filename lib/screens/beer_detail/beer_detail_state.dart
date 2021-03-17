import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hoppy/data/data.dart';

part 'beer_detail_state.freezed.dart';

@freezed
class BeerDetailState with _$BeerDetailState {
  factory BeerDetailState({
    required bool loading,
    required bool haveNewCheckin,
    Beer? beer,
  }) = _BeerDetailState;
}
