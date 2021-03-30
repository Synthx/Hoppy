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

  Future<void> addBeer(BeerDto beerDto) async {
    emit(state.copyWith(loading: true, error: null));

    // save picture into app path
    beerDto = beerDto.copyWith(
      picturePath: await Util.saveFileWithPath(beerDto.picturePath),
    );

    // create beer entity
    final beer = Beer(
      creationDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      name: beerDto.name,
      degree: beerDto.degree,
      color: beerDto.color,
      style: beerDto.style,
      country: beerDto.country,
      title: beerDto.title,
      picturePath: beerDto.picturePath,
    );

    // save beer
    final createdBeer = await beerRepository.insert(beer);

    // update state
    statisticCubit.addBeer(createdBeer);
    searchCubit.addBeer(createdBeer);

    emit(state.copyWith(loading: false, beer: createdBeer));
  }
}
