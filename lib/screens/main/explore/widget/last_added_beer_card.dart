import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/store/store.dart';

class LastAddedBeerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticCubit, StatisticState>(
      buildWhen: (prev, curr) => prev.beerStatistic.count != curr.beerStatistic.count,
      builder: (context, state) {
        if (state.beerStatistic.count == 0) {
          return Container();
        }

        return Container(
          height: kCardHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

            ],
          ),
        );
      },
    );
  }
}
