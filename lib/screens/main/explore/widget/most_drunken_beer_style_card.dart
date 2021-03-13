import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/main/explore/dialog/beer_style_repartition_dialog.dart';
import 'package:hoppy/store/store.dart';

import 'more_card_button.dart';

class MostDrunkenBeerStyleCard extends StatelessWidget {
  void _openBeerStyleRepartitionDialog(BuildContext context) {
    Navigator.push(
      context,
      BeerStyleRepartitionDialog.route(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticCubit, StatisticState>(
      buildWhen: (prev, curr) =>
          prev.checkInStatistic.count != curr.checkInStatistic.count,
      builder: (context, state) {
        if (state.checkInStatistic.count == 0) {
          return Container();
        }

        final styleRepartition =
            state.checkInStatistic.drunkenStyleRepartition.sort();
        final style = styleRepartition.firstKey()!;

        return Container(
          height: kCardHeight,
          margin: const EdgeInsets.symmetric(
            vertical: kCardVerticalMargin,
          ),
          padding: const EdgeInsets.all(kDefaultPadding),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            image: DecorationImage(
              image: const AssetImage('assets/images/beer-style.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.srcOver,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(flex: 2),
              Text(
                'Style de bière le plus apprecié',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                '${style.name}',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.white,
                    ),
              ),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bue ${state.checkInStatistic.drunkenStyleRepartition[style]} fois',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                  ),
                  MoreCardButton(
                    onTap: () => _openBeerStyleRepartitionDialog(context),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
