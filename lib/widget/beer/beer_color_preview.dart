import 'package:flutter/material.dart';
import 'package:hoppy/data/data.dart';

class BeerColorPreview extends StatelessWidget {
  final BeerColor beerColor;
  final bool isSelected;
  final VoidCallback onTap;

  const BeerColorPreview({
    required this.beerColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              color: beerColor.color,
              borderRadius: BorderRadius.circular(36),
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).dividerColor,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.check,
                color: isSelected ? Colors.white : beerColor.color,
              ),
            ),
          ),
          Text(
            '${beerColor.name}',
            style: TextStyle(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.bodyText2!.color,
            ),
          ),
        ],
      ),
    );
  }
}
