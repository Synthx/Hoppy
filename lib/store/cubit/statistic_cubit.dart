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
          beerStatistic: BeerStatistic(),
          checkInStatistic: CheckInStatistic(),
        ));

  Future<void> load() async {
    emit(state.copyWith(loading: true));
    final beerStatistic = await beerRepository.statistic();
    final checkInStatistic = await checkInRepository.statistic();
    emit(state.copyWith(
      loading: false,
      beerStatistic: beerStatistic,
      checkInStatistic: checkInStatistic,
    ));
  }

  void addBeer(Beer beer) {
    final statistic = state.beerStatistic.copyWith();
    statistic.colorRepartition.increment(beer.color);
    statistic.styleRepartition.increment(beer.style);

    emit(state.copyWith.beerStatistic(
      count: statistic.count + 1,
      averageDegree: statistic.averageDegree.average(beer.degree).toPrecision(),
      highestDegree: beer.degree > statistic.highestDegree
          ? beer.degree
          : statistic.highestDegree,
      colorRepartition: statistic.colorRepartition,
      styleRepartition: statistic.styleRepartition,
      lastAdded: beer,
    ));
  }

  void deleteBeer(Beer beer) {
    final statistic = state.beerStatistic.copyWith();
    statistic.colorRepartition.decrement(beer.color);
    statistic.styleRepartition.decrement(beer.style);

    emit(state.copyWith.beerStatistic(
      count: statistic.count - 1,
      colorRepartition: statistic.colorRepartition,
      styleRepartition: statistic.styleRepartition,
    ));
  }

  void addCheckIn(CheckIn checkIn) {
    final statistic = state.checkInStatistic.copyWith();
    statistic.servingStyleRepartition.increment(checkIn.servingStyle);
    if (checkIn.location != null) {
      statistic.locationRepartition.increment(checkIn.location!);
    }

    emit(state.copyWith.checkInStatistic(
      count: statistic.count + 1,
      averageRating:
          statistic.averageRating.average(checkIn.rating).toPrecision(),
      servingStyleRepartition: statistic.servingStyleRepartition,
      locationRepartition: statistic.locationRepartition,
      lastAdded: checkIn,
    ));
  }
}
