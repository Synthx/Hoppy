import 'package:flutter/material.dart';
import 'package:hoppy/data/data.dart';

class BeerCountrySelectorDialog extends StatelessWidget {
  static route() => MaterialPageRoute<BeerCountry?>(
        builder: (_) => BeerCountrySelectorDialog(),
      );

  _closeDialog(BuildContext context) {
    Navigator.pop(context);
  }

  _selectBeerCountry(BuildContext context, BeerCountry beerCountry) {
    Navigator.pop(context, beerCountry);
  }

  @override
  Widget build(BuildContext context) {
    final beerCountries = BeerCountry.values;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pays'),
        leading: IconButton(
          onPressed: () => _closeDialog(context),
          icon: const Icon(Icons.clear),
        ),
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) {
          return const Divider(height: 1);
        },
        itemCount: beerCountries.length,
        itemBuilder: (context, index) {
          final beerCountry = beerCountries[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 3,
            ),
            onTap: () => _selectBeerCountry(context, beerCountry),
            title: Text('${beerCountry.name}'),
          );
        },
      ),
    );
  }
}
