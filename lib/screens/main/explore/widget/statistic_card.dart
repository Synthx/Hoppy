import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/store/store.dart';

class StatisticCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: _BeerCount()),
              const SizedBox(width: 10),
              Flexible(child: _BeerAverageDegree()),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: _CheckInCount()),
              const SizedBox(width: 10),
              Flexible(child: _CheckInAverageRating()),
            ],
          ),
        ],
      ),
    );
  }
}

class _BeerCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nombre de bières ajoutées',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(height: 5),
        BlocBuilder<StatisticCubit, StatisticState>(
          buildWhen: (prev, curr) =>
              prev.beerStatistic.count != curr.beerStatistic.count,
          builder: (context, state) {
            return Text(
              '${state.beerStatistic.count}',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 18,
                  ),
            );
          },
        ),
      ],
    );
  }
}

class _BeerAverageDegree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Degré moyen',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(height: 5),
        BlocBuilder<StatisticCubit, StatisticState>(
          buildWhen: (prev, curr) =>
              prev.beerStatistic.averageDegree !=
              curr.beerStatistic.averageDegree,
          builder: (context, state) {
            return Text(
              '${state.beerStatistic.averageDegree}°',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 18,
                  ),
            );
          },
        ),
      ],
    );
  }
}

class _CheckInCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nombre de bières bues',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(height: 5),
        BlocBuilder<StatisticCubit, StatisticState>(
          buildWhen: (prev, curr) =>
              prev.checkInStatistic.count != curr.checkInStatistic.count,
          builder: (context, state) {
            return Text(
              '${state.checkInStatistic.count}',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 18,
                  ),
            );
          },
        ),
      ],
    );
  }
}

class _CheckInAverageRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notation moyenne',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(height: 5),
        BlocBuilder<StatisticCubit, StatisticState>(
          buildWhen: (prev, curr) =>
              prev.checkInStatistic.averageRating !=
              curr.checkInStatistic.averageRating,
          builder: (context, state) {
            return Text(
              '${state.checkInStatistic.averageRating}',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 18,
                  ),
            );
          },
        ),
      ],
    );
  }
}
