import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/add_beer/add_beer.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
      widget.form.control('country').markAsDirty();
      setState(() {
        _selectedBeerCountry = beerCountry;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: 10,
      ),
      onTap: () => _openBeerCountryDialog(),
      title: Padding(
        padding: EdgeInsets.only(
          bottom: _selectedBeerCountry != null ? 6 : 0,
        ),
        child: const Text('Origine *'),
      ),
      isThreeLine: false,
      subtitle: _selectedBeerCountry != null
          ? Text('${_selectedBeerCountry!.name}')
          : null,
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
