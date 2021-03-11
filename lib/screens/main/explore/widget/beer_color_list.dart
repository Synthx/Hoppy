import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';

class BeerColorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var beerColors = BeerColor.values.toList();
    beerColors.shuffle();
    beerColors = beerColors.take(4).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            separatorBuilder: (context, index) {
              return const SizedBox(width: 20);
            },
            itemBuilder: (context, index) {
              var beerColor = beerColors[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      width: 240,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(kDefaultRadius),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Bière ${beerColor.name}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
