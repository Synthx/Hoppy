import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/generated/l10n.dart';
import 'package:hoppy/screens/main/explore/explore.dart';
import 'package:hoppy/store/store.dart';

class MostDrunkenBeerCountryCard extends StatelessWidget {
  void _openBeerCountryRepartitionDialog(BuildContext context) {
    Navigator.push(
      context,
      BeerCountryRepartitionDialog.route(),
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

        final countryRepartition =
            state.checkInStatistic.drunkenCountryRepartition.sort();
        final country = countryRepartition.firstKey()!;

        return Container(
          height: kCardHeight,
          margin: const EdgeInsets.symmetric(
            vertical: kCardVerticalMargin,
          ),
          padding: const EdgeInsets.all(kDefaultPadding),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            image: DecorationImage(
              image: const AssetImage('assets/images/beer-country.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4),
                BlendMode.srcOver,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(flex: 2),
              Text(
                Localization.of(context).explore_most_drunken_beer_country,
                textAlign: TextAlign.center,
                style: cardSubtitleStyle(context),
              ),
              const SizedBox(height: 5),
              Text(
                '${country.name}',
                textAlign: TextAlign.center,
                style: cardTitleStyle(context),
              ),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Localization.of(context).explore_drink_count(state
                        .checkInStatistic.drunkenCountryRepartition[country]!),
                    style: cardContentStyle(context),
                  ),
                  MoreCardButton(
                    onTap: () => _openBeerCountryRepartitionDialog(context),
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
