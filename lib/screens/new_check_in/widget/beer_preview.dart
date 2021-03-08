import 'package:flutter/material.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/widget/widget.dart';

class BeerPreview extends StatelessWidget {
  final Beer beer;

  const BeerPreview({
    required this.beer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      child: Row(
        children: [
          BeerImagePreview(
            imagePath: beer.picturePath,
            height: 82,
            width: 82,
          ),
          const SizedBox(width: 15),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  beer.name,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 18,
                      ),
                ),
                const SizedBox(height: 4),
                Text(beer.style.name),
                Text(beer.color.name),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
