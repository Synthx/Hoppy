import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/beer_detail/beer_detail.dart';

class BeerStatistic extends StatelessWidget {
  final Beer beer;

  const BeerStatistic({
    required this.beer,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BeerDetailCubit, BeerDetailState>(
      buildWhen: (prev, curr) =>
          prev.haveNewCheckin != curr.haveNewCheckin &&
          curr.haveNewCheckin == true,
      builder: (context, state) {
        return FutureBuilder<DrunkenBeerStatistic>(
          future: getIt<CheckInRepository>().beerStatistic(beer),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final statistic = snapshot.data!;
            if (statistic.count == 0) {
              return Container(
                height: 220,
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(kDefaultPadding),
                margin: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BeerSomeStatistic(
                  beerStatistic: statistic,
                ),
                const SizedBox(height: 20),
                BeerLastCheckIns(
                  checkIns: statistic.lastCheckIns,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
