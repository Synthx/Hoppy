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
        ));

  Future<void> search() async {
    emit(state.copyWith(loading: true, page: 0));
    final beers = await beerRepository.search(
      filter: state.filter,
      page: state.page,
      size: state.size,
    );
    emit(state.copyWith(loading: false, beers: beers));
  }

  Future<void> nextPage() async {
    emit(state.copyWith(loading: true, page: state.page + 1));
    final beers = await beerRepository.search(
      filter: state.filter,
      page: state.page,
      size: state.size,
    );
    emit(state.copyWith(loading: false, beers: beers));
  }
}
