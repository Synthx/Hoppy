import 'package:bloc/bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/edit_beer/edit_beer.dart';
import 'package:hoppy/store/store.dart';

class EditBeerCubit extends Cubit<EditBeerState> {
  final BeerRepository beerRepository;
  final StatisticCubit statisticCubit;
  final FavoriteCubit favoriteCubit;
  final SearchCubit searchCubit;

  EditBeerCubit({
    required this.beerRepository,
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

    // edit beer entity
    var beer = (await beerRepository.find(id))!;
    beer = beer.copyWith(
      name: beerDto.name,
      degree: beerDto.degree,
      color: beerDto.color,
      style: beerDto.style,
      country: beerDto.country,
      title: beerDto.title,
      picturePath: await Util.saveFileWithPath(beerDto.picturePath),
    );

    // save beer
    final editedBeer = await beerRepository.update(beer);

    // update state
    await statisticCubit.load();
    favoriteCubit.beerEdited(editedBeer);
    searchCubit.editBeer(editedBeer);

    emit(state.copyWith(loading: false, beer: editedBeer));
  }
}
