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

    emit(state.copyWith.beerStatistic(
      count: statistic.count + 1,
      averageDegree: statistic.averageDegree.average(beer.degree).toPrecision(),
      highestDegree: beer.degree > statistic.highestDegree
          ? beer.degree
          : statistic.highestDegree,
      lastAdded: beer,
    ));
  }

  void addCheckIn(CheckIn checkIn) {
    final drunkenBeer = checkIn.beer;
    final statistic = state.checkInStatistic.copyWith();

    // checkin repartition statistic
    statistic.servingStyleRepartition.increment(checkIn.servingStyle);
    if (checkIn.location != null) {
      statistic.locationRepartition.increment(checkIn.location!);
    }
    // drunken beer repartition statistic
    statistic.drunkenCountryRepartition.increment(drunkenBeer.country);
    statistic.drunkenStyleRepartition.increment(drunkenBeer.style);
    statistic.drunkenColorRepartition.increment(drunkenBeer.color);

    emit(state.copyWith.checkInStatistic(
      count: statistic.count + 1,
      averageRating:
          statistic.averageRating.average(checkIn.rating).toPrecision(),
      servingStyleRepartition: statistic.servingStyleRepartition,
      drunkenCountryRepartition: statistic.drunkenCountryRepartition,
      drunkenStyleRepartition: statistic.drunkenStyleRepartition,
      drunkenColorRepartition: statistic.drunkenColorRepartition,
      locationRepartition: statistic.locationRepartition,
      lastAdded: checkIn,
    ));
  }
}
