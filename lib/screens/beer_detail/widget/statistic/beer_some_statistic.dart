import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:intl/intl.dart';

class BeerSomeStatistic extends StatelessWidget {
  final DrunkenBeerStatistic beerStatistic;

  const BeerSomeStatistic({
    required this.beerStatistic,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
            ),
            children: [
              _BeerStatisticCard(
                title: 'Bue',
                value: '${beerStatistic.count} fois',
              ),
              const VerticalDivider(width: 0),
              _BeerStatisticCard(
                title: 'Dernière fois',
                value: DateFormat.yMd()
                    .format(beerStatistic.lastCheckIns.first.date),
              ),
              const VerticalDivider(width: 0),
              _BeerStatisticCard(
                title: 'Note moyenne',
                value: '${beerStatistic.averageRating}',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BeerStatisticCard extends StatelessWidget {
  final String title;
  final String value;

  const _BeerStatisticCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 12,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }
}
