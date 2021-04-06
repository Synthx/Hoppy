import 'package:bloc/bloc.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/edit_beer/edit_beer.dart';
import 'package:hoppy/store/store.dart';

class EditBeerCubit extends Cubit<EditBeerState> {
  final BeerService beerService;
  final StatisticCubit statisticCubit;
  final FavoriteCubit favoriteCubit;
  final SearchCubit searchCubit;

  EditBeerCubit({
    required this.beerService,
    required this.statisticCubit,
    required this.favoriteCubit,
    required this.searchCubit,
  }) : super(EditBeerState(
          loading: false,
        ));

  Future<void> edit({
    required String id,
    required BeerDto beerDto,
  }) async {
    emit(state.copyWith(loading: true, error: null));

    // save beer
    final editedBeer = await beerService.update(id, beerDto);

    // update state
    await statisticCubit.load();
    favoriteCubit.beerEdited(editedBeer);
    searchCubit.editBeer(editedBeer);

    emit(state.copyWith(loading: false, beer: editedBeer));
  }
}
