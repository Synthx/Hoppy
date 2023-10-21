import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/data/data.dart';

import 'home_state.dart';

export 'home_state.dart';

class HomeStore extends Cubit<HomeState> {
  final BeerService beerService;

  HomeStore({
    required this.beerService,
  }) : super(const HomeState(
          loading: false,
          totalBeers: 0,
          lastAddedBeers: [],
          featuredBeer: null,
        ));

  Future init() async {
    emit(state.copyWith(loading: true));

    final totalBeers = await beerService.count();
    final lastAddedBeers = await beerService.findLastAdded();
    final featuredBeer = await beerService.findFeatured();

    emit(state.copyWith(
      loading: false,
      totalBeers: totalBeers,
      lastAddedBeers: lastAddedBeers,
      featuredBeer: featuredBeer,
    ));
  }
}
