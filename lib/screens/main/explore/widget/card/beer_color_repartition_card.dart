import 'package:flutter/material.dart' hide AnimatedIcon;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/generated/l10n.dart';
import 'package:hoppy/screens/main/explore/explore.dart';
import 'package:hoppy/screens/screens.dart';
import 'package:hoppy/store/store.dart';
import 'package:hoppy/widget/widget.dart';

class BeerColorRepartitionCard extends StatelessWidget {
  void _openAddBeerDialog(BuildContext context) {
    Navigator.push(
      context,
      SearchBeerDialog.route(),
    );
  }

  void _openBeerColorRepartitionDialog(BuildContext context) {
    Navigator.push(
      context,
      BeerColorRepartitionDialog.route(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kCardHeight,
      margin: const EdgeInsets.symmetric(
        vertical: kCardVerticalMargin,
      ),
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: BlocBuilder<StatisticCubit, StatisticState>(
              buildWhen: (prev, curr) =>
                  prev.checkInStatistic.count != curr.checkInStatistic.count,
              builder: (context, state) {
                if (state.checkInStatistic.count == 0) {
                  return _EmptyBeerColorRepartition();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Localization.of(context).explore_beer_color_repartition,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: BeerColorChart(
                        repartition: state
                            .checkInStatistic.drunkenColorRepartition
                            .sort(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: BlocBuilder<StatisticCubit, StatisticState>(
              buildWhen: (prev, curr) =>
                  prev.checkInStatistic.count != curr.checkInStatistic.count,
              builder: (context, state) {
                if (state.checkInStatistic.count > 0) {
                  return MoreCardButton(
                    onTap: () => _openBeerColorRepartitionDialog(context),
                  );
                }

                return MoreCardButton(
                  onTap: () => _openAddBeerDialog(context),
                  iconData: Icons.add,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyBeerColorRepartition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedIcon(
          icon: Text(
            '📈',
            style: TextStyle(fontSize: 50, color: Colors.black),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Ajouter des bières et renseigner ce que vous avez bus pour obtenez des statistiques détaillés sur vos goûts',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
