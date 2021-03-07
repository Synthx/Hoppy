import 'package:bloc/bloc.dart';
import 'package:hoppy/data/data.dart';

import 'search_beer_state.dart';

class SearchBeerCubit extends Cubit<SearchBeerState> {
  final BeerRepository beerRepository;

  SearchBeerCubit({
    required this.beerRepository,
  }) : super(SearchBeerState(
          loading: false,
          filter: BeerFilter(),
        ));

  void nextPage() async {
    var currentList = state.beers ?? [];
    emit(state.copyWith(loading: true, page: state.page + 1));
    final beers = await beerRepository.search(
      filter: state.filter,
      page: state.page,
      size: state.size,
    );
    currentList.addAll(beers);
    emit(state.copyWith(loading: false, beers: currentList));
  }

  void keywordChanged(String? keyword) async {
    final filter = state.filter.copyWith(keyword: keyword);
    emit(state.copyWith(loading: true, beers: [], filter: filter, page: 0));
    final beers = await beerRepository.search(
      filter: state.filter,
      page: state.page,
      size: state.size,
    );
    emit(state.copyWith(loading: false, beers: beers));
  }
}
