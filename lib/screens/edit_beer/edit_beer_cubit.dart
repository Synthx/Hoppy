import 'package:bloc/bloc.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/edit_beer/edit_beer.dart';
import 'package:hoppy/store/store.dart';

class EditBeerCubit extends Cubit<EditBeerState> {
  final BeerRepository beerRepository;
  final StatisticCubit statisticCubit;

  EditBeerCubit({
    required this.beerRepository,
    required this.statisticCubit,
  }) : super(EditBeerState(
          loading: false,
        ));

  void edit(Beer beer) async {
    emit(state.copyWith(loading: true, error: null));
    final editedBeer = await beerRepository.update(beer);
    await statisticCubit.load();
    emit(state.copyWith(loading: false, beer: editedBeer));
  }
}
