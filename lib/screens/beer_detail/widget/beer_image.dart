import 'package:flutter/material.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/widget/widget.dart';

class BeerImage extends StatelessWidget {
  final Beer beer;

  const BeerImage({
    required this.beer,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerHeight = MediaQuery.of(context).size.height / 2;
    return Container(
      height: containerHeight,
      width: screenWidth,
      child: Stack(
        children: [
          BeerImagePreview(
            height: containerHeight,
            imagePath: beer.picturePath,
            radius: 0,
          ),
        ],
      ),
    );
  }
}
