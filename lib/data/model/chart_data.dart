import 'package:flutter/material.dart';

class ChartData {
  final String label;
  int size;
  Color? color;

  ChartData({
    required this.label,
    required this.size,
    this.color,
  });
}
