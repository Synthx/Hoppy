import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/generated/l10n.dart';

class BeerInformation extends StatelessWidget {
  final Beer beer;

  const BeerInformation({
    required this.beer,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1!;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Localization.of(context).beer_style(beer.style.key),
            style: textStyle.copyWith(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            beer.name,
            style: textStyle.copyWith(
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${Localization.of(context).beer_color(beer.color.key)} - ${beer.degree}°',
            style: textStyle.copyWith(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            Localization.of(context).beer_country(beer.country.key),
            style: textStyle.copyWith(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
