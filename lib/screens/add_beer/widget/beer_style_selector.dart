import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../dialog/beer_style_selector_dialog.dart';

class BeerStyleSelector extends StatefulWidget {
  final FormGroup form;

  const BeerStyleSelector({
    required this.form,
  });

  @override
  State createState() => _BeerStyleSelectorState();
}

class _BeerStyleSelectorState extends State<BeerStyleSelector> {
  BeerStyle? _selectedBeerStyle;

  Future<void> _openBeerStyleDialog() async {
    final beerStyle = await Navigator.push<BeerStyle?>(
      context,
      BeerStyleSelectorDialog.route(),
    );

    if (beerStyle != null) {
      widget.form.control('style').value = beerStyle;
      widget.form.control('style').markAsDirty();
      setState(() {
        _selectedBeerStyle = beerStyle;
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
      onTap: () => _openBeerStyleDialog(),
      title: Padding(
        padding: EdgeInsets.only(
          bottom: _selectedBeerStyle != null ? 6 : 0,
        ),
        child: const Text('Style *'),
      ),
      isThreeLine: false,
      subtitle: _selectedBeerStyle != null
          ? Text('${_selectedBeerStyle!.name}')
          : null,
      trailing: Icon(Icons.chevron_right),
    );
  }
}
