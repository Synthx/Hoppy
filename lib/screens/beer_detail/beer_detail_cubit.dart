import 'package:bloc/bloc.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/store/store.dart';

import 'beer_detail_state.dart';

class BeerDetailCubit extends Cubit<BeerDetailState> {
  final BeerRepository beerRepository;
  final StatisticCubit statisticCubit;

  BeerDetailCubit({
    required this.beerRepository,
    required this.statisticCubit,
  }) : super(BeerDetailState(
          loading: false,
          haveNewCheckin: false,
        ));

  Future<void> load(String id) async {
    emit(state.copyWith(loading: true));
    final beer = await beerRepository.find(id);
    emit(state.copyWith(loading: false, beer: beer));
  }

  void setBeer(Beer beer) {
    emit(state.copyWith(beer: beer));
  }

  void setHaveNewCheckIn(bool haveNewCheckIn) {
    emit(state.copyWith(haveNewCheckin: haveNewCheckIn));
  }

  Future<void> delete(Beer beer) async {
    emit(state.copyWith(loading: true));
    await beerRepository.delete(beer.id!);
    statisticCubit.deleteBeer(beer);
    emit(state.copyWith(loading: false, beer: null));
  }
}
