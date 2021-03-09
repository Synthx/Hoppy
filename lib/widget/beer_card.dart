import 'package:flutter/material.dart';
import 'package:hoppy/data/data.dart';

import 'beer_image_preview.dart';

class BeerCard extends StatelessWidget {
  final Beer beer;
  final VoidCallback? onTap;

  const BeerCard({
    required this.beer,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BeerImagePreview(
            imagePath: beer.picturePath,
            height: 220,
          ),
          const SizedBox(height: 10),
          Text(
            '${beer.color.name} - ${beer.style.name}',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Text(
            beer.name,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }
}
