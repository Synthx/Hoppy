import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/generated/l10n.dart';

class BeerCountrySelectorDialog extends StatelessWidget {
  static MaterialPageRoute<BeerCountry?> route() =>
      MaterialPageRoute<BeerCountry?>(
        builder: (_) => BeerCountrySelectorDialog(),
      );

  void _closeDialog(BuildContext context) {
    context.pop();
  }

  void _selectBeerCountry(BuildContext context, BeerCountry beerCountry) {
    context.pop(beerCountry);
  }

  @override
  Widget build(BuildContext context) {
    final beerCountries = BeerCountry.values;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pays'),
        leading: IconButton(
          onPressed: () => _closeDialog(context),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, _) => Divider(height: 0),
        itemCount: beerCountries.length,
        itemBuilder: (context, index) {
          final beerCountry = beerCountries[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 3,
            ),
            onTap: () => _selectBeerCountry(context, beerCountry),
            title: Text(
              Localization.of(context).beer_country(beerCountry.key),
            ),
          );
        },
      ),
    );
  }
}
