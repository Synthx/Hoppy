import 'package:bloc/bloc.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/store/store.dart';

class SearchCubit extends Cubit<SearchState> {
  final BeerRepository beerRepository;

  SearchCubit({
    required this.beerRepository,
  }) : super(SearchState(
          beers: [],
          filter: BeerFilter(),
          loading: false,
          page: 0,
          size: 20,
        ));

  Future<void> search() async {
    emit(state.copyWith(loading: true));
    final datasource = await beerRepository.search(
      filter: state.filter,
      page: state.page,
      size: state.size,
    );
    emit(state.copyWith(
      loading: false,
      beers: datasource.content,
      totalElements: datasource.totalElements,
    ));
  }

  Future<void> nextPage() async {
    var currentList = state.beers;
    emit(state.copyWith(loading: true, page: state.page + 1));
    final datasource = await beerRepository.search(
      filter: state.filter,
      page: state.page,
      size: state.size,
    );
    currentList.addAll(datasource.content);
    emit(state.copyWith(
      loading: false,
      beers: currentList,
    ));
  }

  void addBeer(Beer beer) {
    var currentList = state.beers;
    currentList.add(beer);
    emit(state.copyWith(
      beers: currentList,
      totalElements: (state.totalElements ?? 0) + 1,
    ));
  }

  void editBeer(Beer beer) {
    var index = state.beers.indexWhere((e) => e.id == beer.id);
    var currentList = state.beers;
    if (index != -1) {
      currentList[index] = beer;
      emit(state.copyWith(
        beers: currentList,
      ));
    }
  }

  void deleteBeer(Beer beer) {
    emit(state.copyWith(
      beers: state.beers.where((e) => e.id != beer.id).toList(),
      totalElements: state.totalElements! - 1,
    ));
  }
}
