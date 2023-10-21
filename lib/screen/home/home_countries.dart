import 'package:flutter/material.dart';
import 'package:hoppy/data/data.dart';

class HomeCountriesList extends StatelessWidget {
  const HomeCountriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final countries = Country.values.take(4).toList();
    const cardHeight = 200.0;
    const cardWidth = 280.0;

    return Placeholder();
  }
}
