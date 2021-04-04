import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/generated/l10n.dart';
import 'package:hoppy/screens/main/main.dart';

class BeerColorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var beerColors = BeerColor.values.toList();
    beerColors.shuffle();
    beerColors = beerColors.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
          ),
          child: Text(
            'Vous êtes plutôt ?',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 260,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
            ),
            itemCount: beerColors.length,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, _) => const SizedBox(width: 20),
            itemBuilder: (context, index) {
              var beerColor = beerColors[index];
              return _BeerColorCard(
                color: beerColor,
              );
            },
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _BeerColorCard extends StatelessWidget {
  final BeerColor color;

  const _BeerColorCard({
    required this.color,
  });

  void _goToSearchView(BuildContext context) {
    context.read<MainScreenCubit>().changePage(1);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _goToSearchView(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              width: 240,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(kDefaultRadius),
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/beer-colors/${color.key}.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            Localization.of(context).beer_color(color.key),
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
