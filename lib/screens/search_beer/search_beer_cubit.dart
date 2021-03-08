import 'package:bloc/bloc.dart';
import 'package:hoppy/data/data.dart';

import 'search_beer_state.dart';

class SearchBeerCubit extends Cubit<SearchBeerState> {
  final BeerRepository beerRepository;

  SearchBeerCubit({
    required this.beerRepository,
  }) : super(SearchBeerState(
          loading: false,
          maxSize: 0,
          filter: BeerFilter(),
        ));

  void nextPage() async {
    var currentList = state.beers ?? [];
    emit(state.copyWith(loading: true, page: state.page + 1));
    await Future.delayed(Duration(seconds: 2));
    final beers = await _searchBeers();
    currentList.addAll(beers);
    emit(state.copyWith(loading: false, beers: currentList));
  }

  void keywordChanged(String? keyword) async {
    final filter = state.filter.copyWith(keyword: keyword);
    emit(state.copyWith(loading: true, beers: [], filter: filter, page: 0));
    await Future.delayed(Duration(seconds: 2));
    final beers = await _searchBeers();
    emit(state.copyWith(loading: false, beers: beers));
  }

  Future<List<Beer>> _searchBeers() async {
    final maxSize = await beerRepository.count();
    emit(state.copyWith(maxSize: maxSize));

    return beerRepository.search(
      filter: state.filter,
      page: state.page,
      size: state.size,
    );
  }
}
