import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/store/store.dart';

const statisticCardHeight = 100.0;
const numberSize = 26.0;

class StatisticCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          _BeerCount(),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _BeerAverageDegree(),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _CheckInCount(),
              ),
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
    return Container(
      height: statisticCardHeight,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Nombre de bières différentes',
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
                      fontSize: numberSize,
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BeerAverageDegree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: statisticCardHeight,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      fontSize: numberSize,
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CheckInCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: statisticCardHeight,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      fontSize: numberSize,
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}
