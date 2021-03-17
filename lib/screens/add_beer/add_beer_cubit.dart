import 'package:bloc/bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/store/store.dart';

import 'add_beer_state.dart';

class AddBeerCubit extends Cubit<AddBeerState> {
  final BeerRepository beerRepository;
  final StatisticCubit statisticCubit;
  final SearchCubit searchCubit;

  AddBeerCubit({
    required this.beerRepository,
    required this.statisticCubit,
    required this.searchCubit,
  }) : super(AddBeerState(
          loading: false,
        ));

  Future<void> addBeer(Beer beer) async {
    emit(state.copyWith(loading: true, error: null));

    try {
      // save picture into app path
      beer.picturePath = await Util.saveFileWithPath(beer.picturePath);

      // save beer
      final createdBeer = await beerRepository.insert(beer);

      // change statistic
      statisticCubit.addBeer(createdBeer);
      searchCubit.addBeer(createdBeer);

      emit(state.copyWith(loading: false, beer: createdBeer));
    } catch (e) {
      // TODO: write into log file (or send it to firebase?)
      print(e);

      emit(state.copyWith(loading: false, error: e));
    }
  }
}
