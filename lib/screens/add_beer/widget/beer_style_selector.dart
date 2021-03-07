import 'package:flutter/material.dart';
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

  void _openBeerStyleDialog() async {
    final beerStyle = await Navigator.push<BeerStyle?>(
      context,
      BeerStyleSelectorDialog.route(),
    );

    if (beerStyle != null) {
      widget.form.control('style').value = beerStyle;
      setState(() {
        _selectedBeerStyle = beerStyle;
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
        onTap: () => _openBeerStyleDialog(),
        title: const Padding(
          padding: const EdgeInsets.only(
            bottom: 6,
          ),
          child: const Text('Style *'),
        ),
        isThreeLine: false,
        subtitle:
            _selectedBeerStyle != null ? Text('${_selectedBeerStyle!.name}') : null,
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
