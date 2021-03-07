import 'package:bloc/bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/store/store.dart';

class StatisticCubit extends Cubit<StatisticState> {
  final BeerRepository beerRepository;
  final CheckInRepository checkInRepository;

  StatisticCubit({
    required this.beerRepository,
    required this.checkInRepository,
  }) : super(StatisticState(
          loading: false,
          statistic: Statistic(),
        ));

  Future<void> load() async {
    emit(state.copyWith(loading: true));
    final beerStatistic = await beerRepository.statistic();
    final checkInStatistic = await checkInRepository.statistic();
    emit(state.copyWith(
      loading: false,
      statistic: Statistic(
        beerCount: beerStatistic.count,
        checkInCount: checkInStatistic.count,
        beerAverageDegree: beerStatistic.averageDegree,
        checkInAverageRating: checkInStatistic.averageRating,
        beerColorRepartition: beerStatistic.colorRepartition,
        beerStyleRepartition: beerStatistic.styleRepartition,
        checkInLocationRepartition: checkInStatistic.locationRepartition,
        checkInServingStyleRepartition:
            checkInStatistic.servingStyleRepartition,
      ),
    ));
  }

  void addBeer(Beer beer) {
    final statistic = state.statistic.copyWith();
    statistic.beerColorRepartition.increment(beer.color);
    statistic.beerStyleRepartition.increment(beer.style);

    emit(state.copyWith.statistic(
      beerCount: statistic.beerCount + 1,
      beerAverageDegree:
          statistic.beerAverageDegree.average(beer.degree).toPrecision(),
      beerColorRepartition: statistic.beerColorRepartition,
      beerStyleRepartition: statistic.beerStyleRepartition,
    ));
  }

  void deleteBeer(Beer beer) {
    final statistic = state.statistic.copyWith();
    statistic.beerColorRepartition.decrement(beer.color);
    statistic.beerStyleRepartition.decrement(beer.style);

    emit(state.copyWith.statistic(
      beerCount: statistic.beerCount - 1,
      beerColorRepartition: statistic.beerColorRepartition,
      beerStyleRepartition: statistic.beerStyleRepartition,
    ));
  }

  void addCheckIn(CheckIn checkIn) {
    final statistic = state.statistic.copyWith();

    emit(state.copyWith.statistic(
      checkInCount: statistic.checkInCount + 1,
      checkInAverageRating:
          statistic.checkInAverageRating.average(checkIn.rating),
    ));
  }
}
