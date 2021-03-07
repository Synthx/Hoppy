import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';

class CheckInRepository extends BaseRepository<CheckIn> {
  const CheckInRepository() : super('check-ins');

  Future<CheckInStatistic> statistic() async {
    final checkIns = await this.findAll();

    return CheckInStatistic(
      count: checkIns.length,
      averageRating: checkIns.map((c) => c.rating).average(),
      servingStyleRepartition: checkIns.map((c) => c.servingStyle).group(),
      locationRepartition: {},
    );
  }
}
