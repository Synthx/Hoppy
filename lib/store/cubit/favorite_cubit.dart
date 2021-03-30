import 'package:bloc/bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/store/store.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final BeerRepository beerRepository;

  FavoriteCubit({
    required this.beerRepository,
  }) : super(FavoriteState(
          beers: [],
          loading: false,
        ));

  Future<void> load() async {
    emit(state.copyWith(loading: true, error: null));
    final beers = await beerRepository.findAllFavorite();
    emit(state.copyWith(loading: false, beers: beers));
  }

  Future<void> addBeer(Beer beer) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      if (state.beers.length + 1 > kMaxFavorite) {
        throw MaxFavoriteNumberException();
      }

      await beerRepository.update(beer.copyWith(
        favorite: true,
      ));
      emit(state.copyWith(
        beers: state.beers + [beer],
        loading: false,
      ));
    } on MaxFavoriteNumberException catch (e) {
      emit(state.copyWith(loading: false, error: e));
    } catch (e, stackTrace) {
      addError(e, stackTrace);
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> removeBeer(Beer beer) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      await beerRepository.update(beer.copyWith(
        favorite: false,
      ));
      final beers = state.beers.where((b) => b.id != beer.id).toList();
      emit(state.copyWith(beers: beers, loading: false));
    } catch (e, stackTrace) {
      addError(e, stackTrace);
      emit(state.copyWith(loading: false));
    }
  }

  void beerEdited(Beer beer) {
    var currentList = state.beers.toList();
    var index = currentList.indexWhere((e) => e.id == beer.id);
    if (index != -1) {
      currentList[index] = beer;
      emit(state.copyWith(
        beers: currentList,
      ));
    }
  }
}
