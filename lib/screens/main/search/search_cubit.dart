import 'package:bloc/bloc.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/main/search/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final BeerRepository beerRepository;

  SearchCubit({
    required this.beerRepository,
  }) : super(SearchState(
          filter: BeerFilter(),
          beers: [],
          loading: false,
          page: 0,
          size: 20,
        ));

  Future<void> search() async {
    emit(state.copyWith(loading: true));
    final datasource = await _searchBeers();
    emit(state.copyWith(loading: false, beers: datasource.content));
  }

  Future<void> nextPage() async {
    var currentList = state.beers;
    emit(state.copyWith(loading: true, page: state.page + 1));
    final datasource = await _searchBeers();
    currentList.addAll(datasource.content);
    emit(state.copyWith(
      loading: false,
      beers: currentList,
      totalElements: datasource.totalElements,
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
