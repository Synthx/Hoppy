import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';

class BeerInformation extends StatelessWidget {
  final Beer beer;

  const BeerInformation({
    required this.beer,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1!;
    return Container(
      padding: const EdgeInsets.only(
        top: 40,
        left: kDefaultPadding,
        right: kDefaultPadding,
        bottom: 20,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            beer.style.name,
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
            '${beer.color.name} - ${beer.degree}°',
            style: textStyle.copyWith(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            beer.country.name,
            style: textStyle.copyWith(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
