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
    emit(state.copyWith(loading: true));
    final beers = await beerRepository.findAllFavorite();
    emit(state.copyWith(loading: false, beers: beers));
  }

  Future<void> addBeer(Beer beer) async {
    emit(state.copyWith(loading: true));
    try {
      if (state.beers.length + 1 > kMaxFavorite) {
        throw MaxFavoriteNumberException();
      }

      beer.favorite = true;
      await beerRepository.update(beer);
      emit(state.copyWith(
        beers: state.beers + [beer],
        loading: false,
      ));
    } catch (e) {
      print(e.runtimeType);
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> removeBeer(Beer beer) async {
    emit(state.copyWith(loading: true));
    try {
      beer.favorite = false;
      await beerRepository.update(beer);
      final beers = state.beers.where((b) => b.key != beer.key).toList();
      emit(state.copyWith(beers: beers, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }
}
