import 'package:flutter/material.dart';

extension StringExtension on String {
  Color get color {
    var hex = toUpperCase().replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }

    return Color(int.parse(hex, radix: 16));
  }
}
