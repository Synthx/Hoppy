import 'package:bloc/bloc.dart';
import 'package:hoppy/data/data.dart';

import 'search_beer_state.dart';

class SearchBeerCubit extends Cubit<SearchBeerState> {
  final BeerRepository beerRepository;

  SearchBeerCubit({
    required this.beerRepository,
  }) : super(SearchBeerState(
          beers: [],
          loading: false,
          filter: BeerFilter(),
          page: 0,
          size: 20,
        ));

  void load() async {
    emit(state.copyWith(loading: true));
    final datasource = await _searchBeers();
    emit(state.copyWith(
      loading: false,
      beers: datasource.content,
      totalElements: datasource.totalElements,
    ));
  }

  void nextPage() async {
    var currentList = state.beers ?? [];
    emit(state.copyWith(loading: true, page: state.page + 1));
    final datasource = await _searchBeers();
    currentList.addAll(datasource.content);
    emit(state.copyWith(
      loading: false,
      beers: currentList,
      totalElements: datasource.totalElements,
    ));
  }

  void keywordChanged(String? keyword) async {
    final filter = state.filter.copyWith(keyword: keyword);
    emit(state.copyWith(loading: true, beers: [], filter: filter, page: 0));
    final datasource = await _searchBeers();
    emit(state.copyWith(
      loading: false,
      beers: datasource.content,
      totalElements: datasource.totalElements,
    ));
  }

  void addBeer(Beer beer) {
    final beers = state.beers ?? [];
    beers.add(beer);
    emit(state.copyWith(
      beers: beers,
    ));
  }

  Future<Page<Beer>> _searchBeers() async {
    return beerRepository.search(
      filter: state.filter,
      page: state.page,
      size: state.size,
    );
  }
}
