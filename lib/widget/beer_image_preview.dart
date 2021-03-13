import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';

class BeerImagePreview extends StatelessWidget {
  final String? imagePath;
  final double height;
  final double width;
  final double radius;

  const BeerImagePreview({
    required this.imagePath,
    this.height = double.infinity,
    this.width = double.infinity,
    this.radius = kDefaultRadius,
  });

  Widget _getImage() {
    final fallbackWidget = const Icon(
      Icons.no_photography_outlined,
      size: 36,
      color: Colors.white,
    );

    if (imagePath != null) {
      try {
        return Image.file(
          File(imagePath!),
          fit: BoxFit.cover,
        );
      } on FileSystemException {
        return fallbackWidget;
      }
    }

    return fallbackWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Colors.grey.withOpacity(0.25),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: _getImage(),
      ),
    );
  }
}
