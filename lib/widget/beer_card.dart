import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';

class BeerCard extends StatelessWidget {
  final Beer beer;

  const BeerCard({
    required this.beer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: beer.backgroundColor ?? Theme.of(context).cardColor,
            ),
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              'assets/images/beers/${beer.id}.webp',
              fit: BoxFit.contain,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                beer.title.toUpperCase(),
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyMedium?.copyWith(),
              ),
              Text(
                '${context.t.beerStyle(beer.style.name)} - ${beer.abv}%',
                style: context.textTheme.bodySmall?.copyWith(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
