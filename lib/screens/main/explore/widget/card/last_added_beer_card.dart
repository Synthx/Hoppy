import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/main/explore/explore.dart';
import 'package:hoppy/screens/screens.dart';
import 'package:hoppy/store/store.dart';
import 'package:hoppy/widget/widget.dart';

class LastAddedBeerCard extends StatelessWidget {
  ImageProvider _getBackgroundImage(String? imagePath) {
    return AssetImage('assets/images/beer.jpg');
  }

  void _openBeerDetailDialog(BuildContext context, Beer beer) {
    Navigator.push(
      context,
      BeerDetailDialog.route(beer),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticCubit, StatisticState>(
      buildWhen: (prev, curr) =>
          prev.beerStatistic.lastAdded != curr.beerStatistic.lastAdded,
      builder: (context, state) {
        if (state.beerStatistic.lastAdded == null) {
          return Container();
        }

        final beer = state.beerStatistic.lastAdded!;
        return Container(
          height: kCardHeight,
          padding: const EdgeInsets.all(kDefaultPadding),
          margin: const EdgeInsets.symmetric(
            vertical: kCardVerticalMargin,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            image: DecorationImage(
              image: _getBackgroundImage(beer.picturePath),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4),
                BlendMode.srcOver,
              ),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BeerFavoriteIconButton(
                    beer: beer,
                    size: 32,
                  ),
                ],
              ),
              const Spacer(flex: 1),
              Text(
                'Dernière bière ajoutée',
                textAlign: TextAlign.center,
                style: cardSubtitleStyle(context),
              ),
              const SizedBox(height: 5),
              Text(
                beer.name,
                textAlign: TextAlign.center,
                style: cardTitleStyle(context),
              ),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!
                        .creation_date(beer.creationDate!),
                    style: cardContentStyle(context),
                  ),
                  MoreCardButton(
                    onTap: () => _openBeerDetailDialog(context, beer),
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
