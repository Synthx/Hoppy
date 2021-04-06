import 'package:bloc/bloc.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/store/store.dart';

import 'add_beer_state.dart';

class AddBeerCubit extends Cubit<AddBeerState> {
  final BeerService beerService;
  final StatisticCubit statisticCubit;
  final SearchCubit searchCubit;

  AddBeerCubit({
    required this.beerService,
    required this.statisticCubit,
    required this.searchCubit,
  }) : super(AddBeerState(
          loading: false,
        ));

  Future<void> addBeer(BeerDto beerDto) async {
    emit(state.copyWith(loading: true, error: null));

    // save beer
    final createdBeer = await beerService.create(beerDto);

    // update state
    statisticCubit.addBeer(createdBeer);
    searchCubit.addBeer(createdBeer);

    emit(state.copyWith(loading: false, beer: createdBeer));
  }
}
