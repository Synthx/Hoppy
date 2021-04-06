import 'package:bloc/bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/store/store.dart';

import 'beer_detail_state.dart';

class BeerDetailCubit extends Cubit<BeerDetailState> {
  final BeerRepository beerRepository;
  final CheckInRepository checkInRepository;
  final StatisticCubit statisticCubit;
  final FavoriteCubit favoriteCubit;
  final SearchCubit searchCubit;

  BeerDetailCubit({
    required this.beerRepository,
    required this.checkInRepository,
    required this.statisticCubit,
    required this.searchCubit,
    required this.favoriteCubit,
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
    await favoriteCubit.removeBeer(beer);
    await beerRepository.delete(beer.id!);
    if (beer.picturePath != null) {
      await LocalStorage.delete(beer.picturePath!);
    }
    await checkInRepository.deleteAssociated(beer);
    await statisticCubit.load();
    searchCubit.deleteBeer(beer);
    emit(state.copyWith(loading: false, beer: null));
  }
}
