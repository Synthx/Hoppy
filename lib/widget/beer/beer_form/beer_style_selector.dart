import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/generated/l10n.dart';
import 'package:hoppy/screens/add_beer/add_beer.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
  void initState() {
    super.initState();
    _selectedBeerStyle = widget.form.control('style').value;
  }

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      textColor: Theme.of(context).textTheme.bodyText1!.color,
      iconColor: Theme.of(context).textTheme.bodyText1!.color,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: 10,
      ),
      child: ListTile(
        onTap: () => _openBeerStyleDialog(),
        title: Padding(
          padding: EdgeInsets.only(
            bottom: _selectedBeerStyle != null ? 6 : 0,
          ),
          child: const Text('Style *'),
        ),
        isThreeLine: false,
        subtitle: _selectedBeerStyle != null
            ? Text(
                Localization.of(context).beer_style(_selectedBeerStyle!.key),
              )
            : null,
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
