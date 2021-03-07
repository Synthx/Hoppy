import 'package:flutter/material.dart';
import 'package:hoppy/data/data.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../dialog/beer_country_selector_dialog.dart';

class BeerCountrySelector extends StatefulWidget {
  final FormGroup form;

  const BeerCountrySelector({
    required this.form,
  });

  @override
  State createState() => _BeerCountrySelectorState();
}

class _BeerCountrySelectorState extends State<BeerCountrySelector> {
  BeerCountry? _selectedBeerCountry;

  void _openBeerCountryDialog() async {
    final beerCountry = await Navigator.push<BeerCountry?>(
      context,
      BeerCountrySelectorDialog.route(),
    );

    if (beerCountry != null) {
      widget.form.control('country').value = beerCountry;
      setState(() {
        _selectedBeerCountry = beerCountry;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        onTap: () => _openBeerCountryDialog(),
        title: const Padding(
          padding: const EdgeInsets.only(
            bottom: 6,
          ),
          child: const Text('Origine *'),
        ),
        isThreeLine: false,
        subtitle:
            _selectedBeerCountry != null ? Text('${_selectedBeerCountry!.name}') : null,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
