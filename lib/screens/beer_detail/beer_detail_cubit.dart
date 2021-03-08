import 'package:bloc/bloc.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/store/store.dart';

import 'beer_detail_state.dart';

class BeerDetailCubit extends Cubit<BeerDetailState> {
  final BeerRepository beerRepository;
  final StatisticCubit statisticCubit;

  BeerDetailCubit({
    required this.beerRepository,
    required this.statisticCubit,
  }) : super(BeerDetailState(
          loading: false,
        ));

  Future<void> delete(Beer beer) async {
    emit(state.copyWith(loading: true));
    await beerRepository.delete(beer);
    statisticCubit.deleteBeer(beer);
    emit(state.copyWith(loading: false, deleted: true));
  }
}
