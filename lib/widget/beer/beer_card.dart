import 'package:flutter/material.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/widget/widget.dart';

class BeerCard extends StatelessWidget {
  final Beer beer;
  final VoidCallback? onTap;
  final bool? showFavoriteButton;

  const BeerCard({
    required this.beer,
    this.onTap,
    this.showFavoriteButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 220,
            child: Stack(
              children: [
                BeerImagePreview(
                  imagePath: beer.picturePath,
                ),
                if (showFavoriteButton == true)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: BeerFavoriteIconButton(
                      beer: beer,
                    ),
                  ),
              ],
            ),
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
